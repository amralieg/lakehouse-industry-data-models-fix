-- Schema for Domain: equipment | Business: Semiconductors | Version: v1_mvm
-- Generated on: 2026-05-06 20:34:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `semiconductors_ecm`.`equipment` COMMENT 'Semiconductor manufacturing equipment assets including lithography scanners, deposition systems, etchers, CMP tools, ATE platforms, and metrology/inspection systems. Manages equipment qualification, utilization, preventive/corrective maintenance schedules, calibration, and tool performance metrics supporting OEE.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `semiconductors_ecm`.`equipment`.`fab_tool` (
    `fab_tool_id` BIGINT COMMENT 'Primary key for fab_tool',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Equipment certification management (ISO, safety) mandates a FK from fab tool to the certification record for auditability.',
    `chips_act_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.chips_act_obligation. Business justification: CHIPS Act reporting ties each capital equipment purchase to a specific obligation record for domestic production compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for OEE and maintenance cost reporting per cost center; finance tracks tool expenses by cost center, obvious for budgeting.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Export classification (ECCN) of a fab tool is required for export‑license determination and regulatory filing.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export Control process requires each fab tool to be linked to its export license for legal shipment and usage tracking.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: REQUIRED: Tool‑node compatibility matrix used in capacity planning and regulatory compliance reporting; linking each fab_tool to its supported technology_node is standard in semiconductor fabs.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Fixed‑asset register must reference each fab tool for depreciation schedules and asset audits.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Depreciation and expense posting need a GL account per tool; finance GL accounts are used in asset accounting reports.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: PROCUREMENT: OEM supplier needed for purchase contracts and warranty compliance; experts track OEM supplier per tool.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis attributes tool usage to profit centers; required for product line margin calculations.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to fabrication.work_center. Business justification: Fab tools are physically assigned to work centers in semiconductor manufacturing. Capacity planning, OEE roll-up by work center, MES dispatching, and shift scheduling all require knowing which work ce',
    `asset_status` STRING COMMENT 'Operational status of the asset within the enterprise.. Valid values are `active|inactive|scrapped`',
    `asset_tag` STRING COMMENT 'Internal asset tag used for inventory and tracking within the enterprise.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration activity.',
    `calibration_due_date` DATE COMMENT 'Planned date for the next calibration.',
    `capacity_wafer_per_hour` DECIMAL(18,2) COMMENT 'Maximum number of wafers the tool can process per hour.',
    `capital_expenditure_amount` DECIMAL(18,2) COMMENT 'Initial capital cost recorded for the asset.',
    `cleanroom_class` STRING COMMENT 'Cleanroom classification where the tool operates.. Valid values are `class1|class10|class100`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the data lake.',
    `depreciation_end_date` DATE COMMENT 'Date depreciation of the asset ends (end of useful life).',
    `depreciation_start_date` DATE COMMENT 'Date depreciation of the asset begins.',
    `energy_consumption_kwh_per_year` DECIMAL(18,2) COMMENT 'Estimated electricity usage per year.',
    `fab_site_code` STRING COMMENT 'Code identifying the fab location where the tool is installed.',
    `fab_tool_description` STRING COMMENT 'Free‑form description of the equipment, including special features.',
    `fab_tool_name` STRING COMMENT 'Human‑readable name of the equipment (e.g., "EUV Scanner 1").',
    `firmware_version` STRING COMMENT 'Current firmware version installed on the tool.',
    `installation_date` DATE COMMENT 'Date the equipment was first installed in the fab.',
    `last_maintenance_date` DATE COMMENT 'Most recent date on which preventive maintenance was performed.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle phase of the equipment.. Valid values are `in_service|retired|maintenance|decommissioned|spare`',
    `maintenance_interval_days` STRING COMMENT 'Planned interval between preventive maintenance activities.',
    `model_number` STRING COMMENT 'Model designation assigned by the OEM.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating time between failures.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair the tool after a failure.',
    `oee_percent` DECIMAL(18,2) COMMENT 'Calculated OEE expressed as a percentage.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Maximum electrical power consumption of the tool.',
    `process_node_compatibility` STRING COMMENT 'Semiconductor process nodes the tool can support.. Valid values are `5nm|7nm|10nm|14nm|28nm|40nm`',
    `purchase_date` DATE COMMENT 'Date the equipment was purchased or capitalized.',
    `regulatory_status` STRING COMMENT 'Current compliance status with applicable regulations.. Valid values are `compliant|non_compliant|pending`',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number uniquely identifying the physical unit.',
    `software_version` STRING COMMENT 'Current version of the tools control software.',
    `tool_subtype` STRING COMMENT 'Technology subtype describing the process method. [ENUM-REF-CANDIDATE: euv|duv|cvd|pvd|ald|plasma|chemical — 7 candidates stripped; promote to reference product]',
    `tool_type` STRING COMMENT 'High‑level functional category of the equipment. [ENUM-REF-CANDIDATE: lithography|deposition|etch|cmp|metrology|ate|ion_implanter — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturer warranty ends.',
    CONSTRAINT pk_fab_tool PRIMARY KEY(`fab_tool_id`)
) COMMENT 'Master record for all semiconductor manufacturing equipment assets including lithography scanners (EUV/DUV), CVD/PVD/ALD deposition systems, etch chambers, CMP tools, ion implanters, ATE platforms, and metrology/inspection systems. Authoritative SSOT for tool identity, classification, OEM specifications, process node compatibility, FAB location, install date, and asset lifecycle status. Sourced from Applied Materials SmartFactory MES and SAP S/4HANA Fixed Assets.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` (
    `tool_chamber_id` BIGINT COMMENT 'Unique identifier for the tool chamber.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Individual chambers require independent certifications (ISO cleanroom class, SEMI S2 safety, process qualification certs) beyond tool-level certifications. Chamber-specific compliance is tracked separ',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the multi‑chamber tool that houses this chamber.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: PROCUREMENT: Chamber vendor is a supplier; linking enables vendor performance reporting and spare‑part sourcing.',
    `audit_last_date` DATE COMMENT 'Date of the most recent compliance audit for the chamber.',
    `calibration_date` DATE COMMENT 'Date when the chamber was last calibrated.',
    `calibration_status` STRING COMMENT 'Current calibration condition of the chamber.. Valid values are `calibrated|out_of_calibration|pending`',
    `chamber_code` STRING COMMENT 'Unique alphanumeric code assigned to the chamber by the manufacturer or fab.',
    `chamber_lifetime_hours` DECIMAL(18,2) COMMENT 'Cumulative operating hours the chamber has logged.',
    `chamber_name` STRING COMMENT 'Human‑readable name of the process chamber.',
    `chamber_status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., fault code, maintenance activity).',
    `chamber_type` STRING COMMENT 'Category of the chamber based on its primary process function.. Valid values are `deposition|etch|cvd|pvd|metrology|inspection`',
    `compliance_status` STRING COMMENT 'Regulatory and internal compliance state of the chamber.. Valid values are `compliant|non_compliant|pending_audit`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the chamber record was first created in the system.',
    `firmware_version` STRING COMMENT 'Version of the embedded firmware controlling the chamber.',
    `gas_flow_rate_sccm` DECIMAL(18,2) COMMENT 'Standard cubic centimeters per minute flow rate for process gases.',
    `installation_date` DATE COMMENT 'Date the chamber was first installed in the fab.',
    `last_calibration_result` STRING COMMENT 'Outcome of the most recent calibration (e.g., pass, fail, deviation values).',
    `last_inspection_date` DATE COMMENT 'Date when the chamber was last inspected for wear or damage.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance event.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the chamber record.',
    `location` STRING COMMENT 'Specific location within the fab (e.g., line, bay, floor).',
    `maintenance_cycle_days` STRING COMMENT 'Standard interval in days between scheduled maintenance events.',
    `model_number` STRING COMMENT 'Model designation of the chamber.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating hours between failures for the chamber.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair the chamber after a failure.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next maintenance activity based on the maintenance cycle.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Calculated OEE metric for the chamber (percentage).',
    `pressure_setpoint_pa` DECIMAL(18,2) COMMENT 'Target pressure setting for the chamber during operation.',
    `qualification_date` DATE COMMENT 'Date when the chamber was last qualified.',
    `qualification_result` STRING COMMENT 'Detailed outcome of the qualification test (e.g., pass, fail, notes).',
    `qualification_status` STRING COMMENT 'Result of the most recent qualification run for the chamber.. Valid values are `qualified|unqualified|pending|failed`',
    `safety_lock_status` STRING COMMENT 'Current state of the chambers safety interlock.. Valid values are `engaged|disengaged`',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number for the chamber.',
    `software_version` STRING COMMENT 'Version of the control software used by the chamber.',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature setting for the chamber during operation.',
    `throughput_pph` DECIMAL(18,2) COMMENT 'Maximum parts‑per‑hour the chamber can process under nominal conditions.',
    `tool_chamber_description` STRING COMMENT 'Free‑text description of the chambers purpose, capabilities, or special notes.',
    `tool_chamber_status` STRING COMMENT 'Current operational state of the chamber.. Valid values are `in_service|maintenance|retired|decommissioned|qualified|unqualified`',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty for the chamber ends.',
    CONSTRAINT pk_tool_chamber PRIMARY KEY(`tool_chamber_id`)
) COMMENT 'Individual process chamber or module within a multi-chamber fab tool (e.g., a CVD cluster tool with 4 deposition chambers, or an etch system with multiple etch modules). Tracks chamber-level qualification status, process recipe assignments, chamber-specific utilization, and maintenance history independently from the parent tool. Essential for chamber-level SPC and yield correlation in multi-chamber tools.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` (
    `tool_qualification_id` BIGINT COMMENT 'Unique identifier for each tool qualification record.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific chamber or module within the tool that was qualified.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: Tool qualifications are process-step-specific (etch qual, litho qual, implant qual). Production release, capacity planning, and WIP routing require step-level tool qualification status in semiconducto',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe used during qualification.',
    `approval_date` DATE COMMENT 'Date the qualification was formally approved.',
    `approved_by` STRING COMMENT 'Name of the process engineer or manager who approved the qualification.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Target baseline value that the tool must meet or exceed.',
    `calibration_date` DATE COMMENT 'Date when the measurement tool was last calibrated.',
    `calibration_status` STRING COMMENT 'Current calibration status of the measurement tool.. Valid values are `calibrated|due|overdue`',
    `change_control_number` STRING COMMENT 'Reference number of the change control request linked to this qualification.',
    `compliance_approval_status` STRING COMMENT 'Regulatory compliance sign‑off status for the qualification.. Valid values are `approved|pending|rejected`',
    `compliance_document_reference` STRING COMMENT 'Reference to the compliance document associated with the qualification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was created in the system.',
    `documentation_url` STRING COMMENT 'Link to detailed qualification documentation or report.',
    `equipment_serial_number` STRING COMMENT 'Manufacturer-assigned serial number of the equipment.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the tool is on the critical production path.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance on the equipment.',
    `maintenance_status` STRING COMMENT 'Indicates whether the equipment maintenance is current.. Valid values are `up_to_date|overdue`',
    `measurement_method` STRING COMMENT 'Method used to capture the qualification metric.. Valid values are `metrology|visual|electrical`',
    `notes` STRING COMMENT 'Free‑form comments or observations captured during qualification.',
    `oee_impact` DECIMAL(18,2) COMMENT 'Estimated impact of the qualification on Overall Equipment Effectiveness, expressed as a percentage.',
    `process_node` STRING COMMENT 'Technology node (e.g., 7nm, 5nm) for which the tool is qualified.',
    `qualification_end_date` DATE COMMENT 'Date when the qualification activity completed.',
    `qualification_location` STRING COMMENT 'Plant or fab location where the qualification was performed.',
    `qualification_protocol` STRING COMMENT 'Name or code of the protocol used to qualify the tool.',
    `qualification_reason` STRING COMMENT 'Business driver for performing the qualification.. Valid values are `new_product|process_change|equipment_upgrade|maintenance`',
    `qualification_start_date` DATE COMMENT 'Date when the qualification activity began.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification process.. Valid values are `pending|in_progress|passed|failed|cancelled`',
    `qualification_type` STRING COMMENT 'Category of qualification performed on the tool.. Valid values are `initial|requalification|process_change|maintenance`',
    `qualification_validity_period_days` STRING COMMENT 'Number of days the qualification remains valid from the start date.',
    `qualification_version` STRING COMMENT 'Version identifier for the qualification record, incremented on re‑qualifications.',
    `result` STRING COMMENT 'Overall outcome of the qualification.. Valid values are `pass|fail`',
    `result_metric_unit` STRING COMMENT 'Unit of measure for the result metric.. Valid values are `nm|um|mm|percent`',
    `result_metric_value` DECIMAL(18,2) COMMENT 'Measured value of the primary qualification metric (e.g., overlay error).',
    `risk_assessment` STRING COMMENT 'Risk level associated with the qualification outcome.. Valid values are `low|medium|high`',
    `tolerance` DECIMAL(18,2) COMMENT 'Acceptable deviation from the baseline value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the qualification record.',
    `validity_end_date` DATE COMMENT 'Date after which the qualification expires and must be renewed.',
    `validity_start_date` DATE COMMENT 'Date from which the qualification is considered valid for production.',
    CONSTRAINT pk_tool_qualification PRIMARY KEY(`tool_qualification_id`)
) COMMENT 'Qualification and certification records for fab tools and chambers against specific process nodes, recipes, and product families. Captures qualification type (initial qual, re-qual, process change qual), qualification protocol, pass/fail criteria, baseline metrology results, approving process engineer, and qualification validity period. A tool must be qualified before it can run production wafer lots. Sourced from Oracle Agile PLM and SmartFactory MES.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: PM schedules must align with equipment certifications (OEM warranty requirements, safety certifications, ISO 9001 quality system mandates). Ensures preventive maintenance intervals satisfy certificati',
    `maintenance_plan_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_plan. Business justification: maintenance_plan is the master reference defining maintenance strategy (frequency, cost, skill requirements, compliance standards), while pm_schedule is the operational instantiation of that plan for ',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — PM schedules must reference the tool they apply to. This drives work order generation and maintenance planning.',
    `primary_pm_fab_tool_id` BIGINT COMMENT 'Identifier of the fab tool or chamber to which the schedule applies.',
    `spare_part_id` BIGINT COMMENT 'Identifier of the spare part that must be available for the maintenance.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: pm_schedule description explicitly states it defines planned PM activities for each fab tool or chamber. It currently has fab_tool_id and pm_fab_tool_id → fab_tool but no FK to tool_chamber. Chamber',
    `compliance_requirement` STRING COMMENT 'Regulatory or industry standard that the maintenance activity must satisfy.. Valid values are `SEMI|ISO9001|ISO14001|ITAR|RoHS|REACH`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the system.',
    `estimated_downtime_minutes` STRING COMMENT 'Planned equipment downtime in minutes for the maintenance activity.',
    `interval_unit` STRING COMMENT 'Unit of measure for the interval value (day, week, month, wafer, or run).. Valid values are `day|week|month|wafer|run`',
    `interval_value` STRING COMMENT 'Numeric value defining the interval between maintenance events (e.g., 500 wafers, 1000 runs, 30 days).',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the equipment is classified as critical for production (true) or not (false).',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the schedule record.',
    `last_performed_date` DATE COMMENT 'Date on which the maintenance activity was last executed.',
    `maintenance_window_end` TIMESTAMP COMMENT 'Planned end time of the maintenance window.',
    `maintenance_window_start` TIMESTAMP COMMENT 'Planned start time of the maintenance window.',
    `next_scheduled_date` DATE COMMENT 'Planned calendar date for the next execution of the maintenance.',
    `oee_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated impact of the maintenance on Overall Equipment Effectiveness expressed as a percentage.',
    `pm_procedure_reference` STRING COMMENT 'Reference code or document ID for the detailed preventive maintenance procedure.',
    `pm_schedule_description` STRING COMMENT 'Free‑text description of the maintenance activity and its purpose.',
    `pm_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.. Valid values are `active|inactive|retired|planned`',
    `pm_type` STRING COMMENT 'Category of preventive maintenance activity (e.g., daily, weekly, monthly, wafer‑count‑based, run‑count‑based).. Valid values are `daily|weekly|monthly|wafer_count|run_count`',
    `priority` STRING COMMENT 'Business priority assigned to the maintenance activity.. Valid values are `high|medium|low`',
    `required_technician_skill_level` STRING COMMENT 'Skill level required of the technician performing the maintenance.. Valid values are `junior|mid|senior|expert`',
    `schedule_code` STRING COMMENT 'Business code used to uniquely reference the schedule across systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name describing the maintenance schedule.',
    `scheduling_constraint` STRING COMMENT 'Business rule or production window constraint that influences when the PM can be run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the schedule record.',
    `work_order_template_code` BIGINT COMMENT 'Identifier of the work‑order template used to generate PM work orders.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Preventive maintenance (PM) schedule master defining planned PM activities for each fab tool or chamber. Specifies PM type (daily, weekly, monthly, wafer-count-based, run-count-based), PM procedure reference, estimated downtime window, required spare parts, required technician skill level, and scheduling constraints relative to production WIP. Drives the PM work order generation cadence in SAP PM module.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` (
    `maintenance_event_id` BIGINT COMMENT 'System-generated unique identifier for the maintenance event record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Maintenance events incur direct labor and parts costs that must be charged to specific cost centers for activity-based costing, variance analysis, and monthly maintenance cost rollups by organizationa',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Major maintenance projects (equipment upgrades, overhauls, relocations) are tracked as internal orders for CAPEX vs OPEX classification, project accounting, and eventual settlement to fixed assets per',
    `maintenance_plan_id` BIGINT COMMENT 'Identifier of the scheduled maintenance plan governing this event.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Maintenance consumes materials (lubricants, cleaning chemicals, consumable parts) tracked in material master. Essential for maintenance cost accounting, inventory planning, and MRO material management',
    `pm_schedule_id` BIGINT COMMENT 'FK to equipment.pm_schedule.pm_schedule_id — Scheduled PM events must link back to the PM schedule that triggered them, enabling PM compliance tracking.',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Every maintenance event must reference the tool serviced. Core operational FK for maintenance history and MTTR calculation.',
    `spare_part_id` BIGINT COMMENT 'FK to equipment.spare_part.spare_part_id — Maintenance events consume spare parts. This link enables parts consumption tracking and inventory depletion.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Maintenance events often procure parts/services via specific POs. Critical for tracking maintenance costs, supplier performance, and linking procurement to equipment uptime/downtime in fab operations.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Equipment upgrades, process modifications, or safety-related maintenance events trigger regulatory filings (EPA notifications, OSHA reports, process change submissions). Links maintenance actions to c',
    `storage_location_id` BIGINT COMMENT 'Identifier of the fab floor or site where the equipment resides.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: maintenance_event has multiple FKs to fab_tool but no FK to tool_chamber. In semiconductor fabs, maintenance events are frequently chamber-specific (e.g., replacing a chamber liner, cleaning a CVD cha',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Major equipment installation, relocation, or upgrade projects are tracked under WBS elements for project cost control, earned value management, and capital project tracking during fab expansions or te',
    `baseline_change_flag` BOOLEAN COMMENT 'True if the maintenance altered the equipment baseline for qualification.',
    `comments` STRING COMMENT 'Additional free‑form notes captured by technicians or supervisors.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework applicable to the maintenance activity.. Valid values are `ISO9001|ITAR|EAR|RoHS|REACH|SOX`',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `downtime_duration_minutes` STRING COMMENT 'Total equipment downtime measured in minutes.',
    `eco_reference` STRING COMMENT 'Identifier of the ECO that drove the modification, if applicable.',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the maintenance work was completed.',
    `event_number` STRING COMMENT 'Human‑readable identifier or ticket number assigned to the maintenance event.',
    `event_type` STRING COMMENT 'Classification of the maintenance activity.. Valid values are `preventive|corrective|emergency|upgrade|modification`',
    `labor_cost_total` DECIMAL(18,2) COMMENT 'Monetary cost of labor based on labor hours and rate.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total technician labor time recorded for the event.',
    `maintenance_category` STRING COMMENT 'Strategic classification of the maintenance approach.. Valid values are `preventive|predictive|reactive`',
    `maintenance_event_status` STRING COMMENT 'Current processing state of the maintenance event.. Valid values are `open|in_progress|completed|cancelled`',
    `oee_impact_percentage` DECIMAL(18,2) COMMENT 'Estimated impact on Overall Equipment Effectiveness expressed as a percent.',
    `parts_cost_total` DECIMAL(18,2) COMMENT 'Aggregate cost of all spare parts and consumables used.',
    `performance_improvement_target` STRING COMMENT 'Planned performance gain (e.g., throughput increase) resulting from the event.',
    `post_config_version` STRING COMMENT 'Snapshot or version identifier of equipment configuration after maintenance.',
    `pre_config_version` STRING COMMENT 'Snapshot or version identifier of equipment configuration before maintenance.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the maintenance event record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the maintenance event record.',
    `repair_action_description` STRING COMMENT 'Narrative of the corrective actions performed during the event.',
    `requalification_required` BOOLEAN COMMENT 'Indicates whether a formal re‑qualification is needed after the event.',
    `requalification_status` STRING COMMENT 'Current status of any required re‑qualification process.. Valid values are `pending|completed|not_required`',
    `root_cause_category` STRING COMMENT 'High‑level classification of the underlying cause of failure.. Valid values are `mechanical|electrical|software|process|human_error|unknown`',
    `root_cause_detail` STRING COMMENT 'Free‑text description of the specific root cause identified.',
    `safety_incident_description` STRING COMMENT 'Details of any safety incident associated with the maintenance.',
    `safety_incident_flag` BOOLEAN COMMENT 'True if the maintenance event involved a safety incident.',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the maintenance work actually began.',
    `technician_name` STRING COMMENT 'Full name of the technician responsible for the maintenance.',
    `total_cost` DECIMAL(18,2) COMMENT 'Combined cost of parts, labor, and any additional charges.',
    `trigger_source` STRING COMMENT 'Origin that caused the maintenance event to be created.. Valid values are `scheduled_pm|alarm|operator_report|fdc_event|eco`',
    `updated_by` STRING COMMENT 'System user identifier that last modified the record.',
    `upgrade_type` STRING COMMENT 'Indicates whether the event involved a hardware, software, or firmware upgrade.. Valid values are `none|hardware|software|firmware`',
    `created_by` STRING COMMENT 'System user identifier that created the record.',
    CONSTRAINT pk_maintenance_event PRIMARY KEY(`maintenance_event_id`)
) COMMENT 'Transactional record of every maintenance activity executed on a fab tool or chamber, including preventive maintenance (PM), corrective maintenance (CM), emergency breakdown repair, engineering-driven modifications, tool upgrades/retrofits, and hardware/software modifications. Captures event type, trigger (scheduled PM, alarm, operator-reported, FDC event, ECO), start/end timestamps, actual downtime duration, root cause classification (5-why, fishbone), repair actions taken, spare parts and consumables consumed (part ID, quantity, unit cost, planned vs unplanned), technician IDs, upgrade/retrofit details (upgrade type, ECO reference, pre/post configuration, performance improvement targets, baseline change flag), and return-to-service sign-off including re-qualification requirements. SSOT for tool downtime attribution, MTTR/MTBF calculation, parts consumption tracking, upgrade history, and total cost of ownership. Sourced from SAP S/4HANA PM and SmartFactory MES.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` (
    `tool_downtime_id` BIGINT COMMENT 'System-generated unique identifier for each downtime event record.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: Tool downtime directly impacts specific WIP lots in the fab. Cycle time impact analysis, hot-lot recovery planning, customer notification for affected orders, and OEE-to-yield correlation all require ',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier of the fab tool or chamber that experienced the downtime.',
    `maintenance_event_id` BIGINT COMMENT 'Reference to the maintenance work order associated with the downtime, if any.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: tool_downtime tracks downtime per SEMI E10 for both fab tools and individual chambers. It already has primary_fab_tool_id → fab_tool but lacks a chamber-level FK. Multi-chamber cluster tools (CVD, PVD',
    `tool_maintenance_event_id` BIGINT COMMENT 'FK to equipment.maintenance_event.maintenance_event_id — Downtime events caused by maintenance must link to the maintenance event for root cause tracing and planned vs unplanned analysis.',
    `comments` STRING COMMENT 'Free‑form notes or observations related to the downtime event.',
    `corrective_action_taken` STRING COMMENT 'Brief description of the corrective action performed to resolve the issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the downtime record was first created in the system.',
    `downtime_duration_minutes` STRING COMMENT 'Total duration of the downtime event expressed in whole minutes.',
    `downtime_end_timestamp` TIMESTAMP COMMENT 'Exact date and time when the tool exited the downtime state.',
    `downtime_reason_code` STRING COMMENT 'Standardized code representing the root cause of the downtime.',
    `downtime_reason_description` STRING COMMENT 'Human‑readable description of why the tool was down.',
    `downtime_start_timestamp` TIMESTAMP COMMENT 'Exact date and time when the tool entered the downtime state.',
    `downtime_type` STRING COMMENT 'Classification of the downtime according to the SEMI E10 state model.. Valid values are `productive|standby|engineering|scheduled|unscheduled|non_scheduled`',
    `impact_wip_lot_count` STRING COMMENT 'Number of work‑in‑process lots affected by the downtime.',
    `oee_impact_percentage` DECIMAL(18,2) COMMENT 'Estimated reduction in Overall Equipment Effectiveness caused by the downtime, expressed as a percentage.',
    `responsible_party` STRING COMMENT 'Team or role accountable for handling the downtime event.. Valid values are `maintenance|engineering|facilities|scheduling|operator`',
    `root_cause_category` STRING COMMENT 'High‑level category describing the underlying cause of the downtime.. Valid values are `equipment|process|material|human|environment`',
    `scheduled_flag` BOOLEAN COMMENT 'Indicates whether the downtime was planned (true) or unplanned (false).',
    `severity_level` STRING COMMENT 'Severity rating of the downtime event based on impact and urgency.. Valid values are `low|medium|high|critical`',
    `shift` STRING COMMENT 'Production shift during which the downtime occurred.. Valid values are `day|night|swing`',
    `source_system` STRING COMMENT 'Originating system that supplied the downtime data.. Valid values are `MES|Camstar|KLA|Custom`',
    `state_after` STRING COMMENT 'Equipment state after the downtime event concluded.',
    `state_before` STRING COMMENT 'Equipment state immediately prior to the downtime event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the downtime record.',
    CONSTRAINT pk_tool_downtime PRIMARY KEY(`tool_downtime_id`)
) COMMENT 'Granular downtime records for each fab tool and chamber classified per SEMI E10 equipment state model (Productive, Standby, Engineering, Scheduled Downtime, Unscheduled Downtime, Non-Scheduled). Captures state transition timestamps, downtime reason code, responsible party (maintenance, engineering, facilities, scheduling), and impact on WIP lots. Feeds OEE (Overall Equipment Effectiveness) calculation and capacity planning models.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`equipment`.`calibration_record` (
    `calibration_record_id` BIGINT COMMENT 'System-generated unique identifier for each calibration record.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Calibration activities must reference applicable certifications (ISO/IEC 17025 lab accreditation, NIST traceability, SEMI standards) to validate measurement authority. Required for customer audits and',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier of the fab equipment that was calibrated.',
    `tertiary_fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Calibration records must reference the tool/instrument calibrated. Required for ISO 9001 traceability.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: calibration_record already has four FKs to fab_tool but no FK to tool_chamber. The tool_chamber table explicitly tracks calibration_date, calibration_status, and last_calibration_result, confirming th',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: In semiconductor fabs, calibration is frequently triggered by maintenance events — after replacing a component, the tool must be recalibrated before returning to production. maintenance_event has requ',
    `wafer_id` BIGINT COMMENT 'Unique identifier of the wafer on which the calibration measurement was taken.',
    `calibration_interval_days` STRING COMMENT 'Planned interval in days between successive calibrations for this equipment.',
    `calibration_method` STRING COMMENT 'Technique used to perform the calibration.. Valid values are `sensor|reference|laser|electrical`',
    `calibration_record_status` STRING COMMENT 'Current processing status of the calibration record.. Valid values are `pending|completed|rejected|archived`',
    `calibration_report_url` STRING COMMENT 'Link to the detailed calibration report stored in the document repository.',
    `calibration_result_code` STRING COMMENT 'Standardized code representing the calibration outcome for downstream analytics.',
    `calibration_source_system` STRING COMMENT 'Name of the source system that generated the record (e.g., KLA ICOS, SmartFactory MES).',
    `calibration_standard` STRING COMMENT 'Reference standard used for calibration (e.g., NIST traceable, SEMI E30).',
    `calibration_timestamp` TIMESTAMP COMMENT 'Date and time when the calibration activity was performed.',
    `calibration_type` STRING COMMENT 'Method of calibration applied to the equipment.. Valid values are `in-situ|offline|periodic|initial|post-maintenance`',
    `comments` STRING COMMENT 'Additional remarks or observations captured by the technician.',
    `compliance_reference` STRING COMMENT 'Reference to the compliance clause (e.g., ISO 9001, IATF 16949) satisfied by this calibration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration record was first created in the system.',
    `location` STRING COMMENT 'Plant or fab line where the equipment resides (e.g., FAB1, LineA).',
    `lot_number` STRING COMMENT 'Identifier of the wafer lot associated with the calibration (if applicable).',
    `measured_value` DECIMAL(18,2) COMMENT 'Value recorded by the instrument during calibration.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Estimated uncertainty of the measured value.',
    `measurement_unit` STRING COMMENT 'Unit of the measured and nominal values (e.g., nanometers, volts).. Valid values are `nm|um|mm|V|A|%`',
    `next_due_date` DATE COMMENT 'Date by which the next calibration must be performed.',
    `nominal_value` DECIMAL(18,2) COMMENT 'Target or nominal value that the equipment should meet.',
    `pass_fail_result` STRING COMMENT 'Pass/Fail outcome of the calibration activity.. Valid values are `pass|fail`',
    `technician_name` STRING COMMENT 'Full name of the calibration technician.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the calibration record.',
    CONSTRAINT pk_calibration_record PRIMARY KEY(`calibration_record_id`)
) COMMENT 'Calibration and metrology verification records for fab tools and measurement instruments. Tracks calibration type (in-situ, offline, periodic), calibration standard used, measured vs. nominal values, calibration pass/fail result, calibration interval, next due date, calibrating technician, and traceability to NIST or SEMI standards. Mandatory for ISO 9001 and IATF 16949 compliance. Sourced from KLA ICOS and SmartFactory MES calibration modules.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` (
    `equipment_process_recipe_id` BIGINT COMMENT 'Unique identifier for the equipment process recipe record.',
    `change_notification_id` BIGINT COMMENT 'Identifier of the change request that introduced or modified this recipe version.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Process recipes are classified under ECCN codes; linking enables recipe‑level export control compliance checks.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Process recipes consume specific materials (gases, chemicals, photoresists) tracked in material master. Essential for BOM management, material planning, and process cost calculation in semiconductor f',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Each process recipe is defined for a specific PDK version; needed for the Recipe Management report linking recipes to PDKs.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: A recipe is owned by a specific fab tool; adding fab_tool_id enables direct navigation and removes redundant attributes that can be derived from the fab_tool record.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: Equipment recipes are step-specific implementations of process intent. Recipe execution control, process integration, and traceability require step-level attribution in semiconductor manufacturing exe',
    `technology_control_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.technology_control_plan. Business justification: Recipes containing controlled technology parameters (advanced lithography exposure settings, critical etch chemistries, sub-7nm process steps) require linkage to technology control plans for EAR/ITAR ',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific equipment chamber where the recipe is executed.',
    `approval_status` STRING COMMENT 'Current approval state of the recipe within the change control process.. Valid values are `draft|pending|approved|rejected|revoked`',
    `audit_status` STRING COMMENT 'Result of the latest audit (passed, failed, pending).. Valid values are `passed|failed|pending`',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the recipe (e.g., SEMI, ISO).. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recipe record was first created in the system.',
    `documentation_url` STRING COMMENT 'Link to the detailed recipe documentation or PDF.',
    `effective_end_date` DATE COMMENT 'Date after which the recipe version is no longer valid (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the recipe version is valid for production.',
    `exposure_dose_mj_cm2` DECIMAL(18,2) COMMENT 'Energy dose applied during lithography exposure.',
    `focus_offset_nm` DECIMAL(18,2) COMMENT 'Focus adjustment offset for the lithography tool, in nanometers.',
    `gas_flow_rate_sccm` DECIMAL(18,2) COMMENT 'Standard cubic centimeters per minute flow rate for process gases.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the recipe version is currently active for scheduling.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the recipe has been superseded and should no longer be used.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance audit of the recipe.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of this recipe version.',
    `oee_actual_percent` DECIMAL(18,2) COMMENT 'Measured OEE percentage achieved during the most recent execution.',
    `oee_target_percent` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness percentage for the recipe.',
    `parameter_count` STRING COMMENT 'Number of distinct process parameters defined in the recipe.',
    `parameter_set_description` STRING COMMENT 'Narrative description of the key process parameters defined in the recipe.',
    `pressure_setpoint_pa` DECIMAL(18,2) COMMENT 'Target chamber pressure for the process, in pascals.',
    `process_node_target` STRING COMMENT 'Technology node the recipe is intended for (e.g., 7nm, 5nm).',
    `process_step_count` STRING COMMENT 'Number of discrete process steps defined in the recipe.',
    `recipe_category` STRING COMMENT 'High‑level process domain the recipe belongs to.. Valid values are `Front-End|Back-End|Middle-Of-Line|Packaging`',
    `recipe_code` STRING COMMENT 'Business identifier code for the recipe used in change management and scheduling.',
    `recipe_hash` STRING COMMENT 'Checksum or hash value used to verify recipe integrity.',
    `recipe_name` STRING COMMENT 'Human‑readable name of the process recipe.',
    `recipe_owner` STRING COMMENT 'Name or identifier of the person or group responsible for the recipe.',
    `rf_power_watts` DECIMAL(18,2) COMMENT 'Radio‑frequency power setting for plasma processes, in watts.',
    `safety_status` STRING COMMENT 'Safety classification of the recipe based on hazardous materials or process risk.. Valid values are `safe|warning|critical`',
    `source_system` STRING COMMENT 'Name of the source system that originated the recipe record (e.g., SmartFactory MES).',
    `spin_speed_rpm` STRING COMMENT 'Rotational speed for spin‑coat steps, in revolutions per minute.',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature setting for the process step, in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the recipe record.',
    `version` STRING COMMENT 'Version string of the recipe (e.g., v1.2, rev3).',
    `version_history_note` STRING COMMENT 'Free‑text note describing changes made in this version.',
    `yield_actual_percent` DECIMAL(18,2) COMMENT 'Actual yield percentage observed in the latest run.',
    `yield_target_percent` DECIMAL(18,2) COMMENT 'Target good‑die yield percentage for the recipe.',
    CONSTRAINT pk_equipment_process_recipe PRIMARY KEY(`equipment_process_recipe_id`)
) COMMENT 'Master and execution records for process recipes on fab tools. Defines complete recipe parameters (temperature, pressure, gas flows, RF power, spin speed, exposure dose, focus offset, etc.) for each process step and tool type, including recipe name, version, process node target, tool compatibility, recipe owner, approval status, and effective date range. Also captures each recipe execution instance linking a specific wafer lot run to the recipe version used, actual as-run vs as-set parameter values, execution start/end timestamps, operator ID, chamber used, and pass/fail outcome. SSOT for recipe configuration, version management, recipe execution history, and recipe-to-yield correlation analysis. Sourced from SmartFactory MES and Camstar recipe management.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` (
    `recipe_execution_id` BIGINT COMMENT 'Unique system-generated identifier for each recipe execution event.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each recipe execution consumes materials, utilities, and equipment time that must be allocated to cost centers for standard costing, actual vs. standard variance analysis, and production cost accounti',
    `equipment_process_recipe_id` BIGINT COMMENT 'FK to equipment.equipment_process_recipe.equipment_process_recipe_id — Each recipe execution must reference the recipe version used. Core traceability for yield correlation and process control.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot that was processed in this execution.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Recipe execution on a wafer lot must be tied to the design project it produces, used in the Production Tracking dashboard.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Recipe executions consume materials (process gases, chemicals) in real-time production. Critical for actual material consumption tracking, yield analysis, cost-per-wafer calculation, and supply chain ',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the fab tool (e.g., lithography scanner, deposition system) where the recipe was executed.',
    `recipe_fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Recipe executions must reference the tool where processing occurred for tool-specific performance analysis.',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe definition used for this execution.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: Recipe executions occur at specific process steps in the flow. Lot traceability, SPC data collection, and process control decisions require step-level attribution in semiconductor MES systems.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific chamber or module inside the tool used for the execution.',
    `wafer_id` BIGINT COMMENT 'Unique identifier of the individual wafer within the lot (e.g., Wafer 001).',
    `batch_number` STRING COMMENT 'Manufacturing batch number associated with the lot run.',
    `compliance_status` STRING COMMENT 'Indicates whether the execution met all applicable process compliance rules.. Valid values are `compliant|non_compliant|pending`',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total elapsed time of the execution in seconds (derived from start and end timestamps).',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the recipe execution completed or was terminated.',
    `equipment_type` STRING COMMENT 'Category of equipment (e.g., Lithography, CVD, Etcher).',
    `execution_status` STRING COMMENT 'Outcome of the recipe execution: pass, fail, or abort.. Valid values are `pass|fail|abort`',
    `gas_flow_actual_sccm` DECIMAL(18,2) COMMENT 'Measured gas flow rate during the run.',
    `gas_flow_setpoint_sccm` DECIMAL(18,2) COMMENT 'Target gas flow rate in standard cubic centimeters per minute.',
    `is_calibrated` BOOLEAN COMMENT 'True if the tool was calibrated immediately before execution; otherwise false.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the execution is for a critical process step (true) or not (false).',
    `notes` STRING COMMENT 'Free‑form text field for operator comments or observations.',
    `oee_availability_percent` DECIMAL(18,2) COMMENT 'Availability component of Overall Equipment Effectiveness for this execution.',
    `oee_performance_percent` DECIMAL(18,2) COMMENT 'Performance component of Overall Equipment Effectiveness for this execution.',
    `oee_quality_percent` DECIMAL(18,2) COMMENT 'Quality component of Overall Equipment Effectiveness for this execution.',
    `power_actual_w` DECIMAL(18,2) COMMENT 'Measured power delivered during execution.',
    `power_setpoint_w` DECIMAL(18,2) COMMENT 'Target power level for plasma or laser processes, in watts.',
    `pressure_actual_pa` DECIMAL(18,2) COMMENT 'Measured chamber pressure during execution.',
    `pressure_setpoint_pa` DECIMAL(18,2) COMMENT 'Target chamber pressure for the recipe, in pascals.',
    `process_step` STRING COMMENT 'Logical name of the process step within the overall flow (e.g., Etch, Deposition).',
    `recipe_version` STRING COMMENT 'Version string of the recipe (e.g., v3.2.1) applied during the run.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this execution record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this execution record.',
    `result_code` STRING COMMENT 'Machine‑generated code providing detailed reason for pass/fail/abort.',
    `run_number` STRING COMMENT 'Sequential number of the execution within the batch.',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the recipe execution started.',
    `temperature_actual_c` DECIMAL(18,2) COMMENT 'Measured temperature achieved during execution.',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature for the process step, in degrees Celsius.',
    `time_actual_sec` DECIMAL(18,2) COMMENT 'Measured duration the step actually ran.',
    `time_setpoint_sec` DECIMAL(18,2) COMMENT 'Target duration for the process step, in seconds.',
    CONSTRAINT pk_recipe_execution PRIMARY KEY(`recipe_execution_id`)
) COMMENT 'Transactional record of each process recipe execution on a fab tool or chamber, linking a specific wafer lot run to the recipe version used, actual process parameter values recorded (as-run vs. as-set), execution start/end timestamps, operator ID, and pass/fail outcome. Enables recipe-to-yield correlation analysis and supports SPC control chart population. Sourced from SmartFactory MES and Camstar lot history.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`equipment`.`spare_part` (
    `spare_part_id` BIGINT COMMENT 'Unique surrogate key for each spare part record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory cost allocation requires linking each spare part to the cost center that budgets its purchase.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Spare parts with embedded technology (microcontrollers, sensors with firmware, RF components, laser modules) require ECCN classification for export control. Critical for international shipments, servi',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Spare parts must reference compatible tool types/models for PM planning and emergency repair part identification. This is a many-to-many but critical for operations.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Spare parts inventory must be posted to specific GL accounts (raw materials, MRO supplies, capital spares) for balance sheet classification, inventory valuation, and month-end financial close per acco',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Spare parts are materials in the supply chain system. Fundamental integration for unified inventory management, procurement planning, valuation, and material movement tracking across equipment and sup',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Spare parts inventory management requires physical storage location tracking for stock replenishment, picking operations, and cycle counting. Essential for MRO inventory control and warehouse manageme',
    `substance_inventory_id` BIGINT COMMENT 'Foreign key linking to compliance.substance_inventory. Business justification: Spare parts containing chemicals, gases, or solvents must track REACH SVHC, RoHS, and hazardous material compliance via substance inventory. Critical for procurement approval, storage safety, and regu',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: INVENTORY/RISK: Each spare part has a primary supplier for lead‑time, quality, and risk assessment reports.',
    `calibration_interval_days` STRING COMMENT 'Number of days between required calibrations for the part.',
    `calibration_required_flag` BOOLEAN COMMENT 'True if the part must be calibrated periodically (e.g., sensors, metrology tools).',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of regulatory or industry certifications applicable to the part (e.g., RoHS, REACH).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the spare part record was first created in the system.',
    `criticality_rating` STRING COMMENT 'Business impact rating if the part is unavailable (high = production‑stop risk).. Valid values are `high|medium|low|none|unknown|reserved`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the unit cost.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `current_stock_qty` STRING COMMENT 'Number of units of the part currently available in the fab stockroom.',
    `disposal_method` STRING COMMENT 'Preferred method for disposing of excess or expired parts.. Valid values are `recycle|sell|destroy|return|donate|store`',
    `equipment_compatible` STRING COMMENT 'List of equipment models or tool families that can use this spare part.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the part is classified as hazardous under safety regulations.',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection activity.. Valid values are `passed|failed|pending|deferred|not_required|exempt`',
    `last_inspection_date` DATE COMMENT 'Date the part was most recently inspected for quality or safety compliance.',
    `last_received_date` DATE COMMENT 'Date the most recent shipment of this part was received into inventory.',
    `last_used_date` DATE COMMENT 'Date the part was last issued for equipment maintenance or repair.',
    `lead_time_days` STRING COMMENT 'Average number of calendar days from order placement to receipt of the part.',
    `lifecycle_end_date` DATE COMMENT 'Date the part was officially retired or marked obsolete.',
    `lifecycle_start_date` DATE COMMENT 'Date the part was first introduced into the inventory catalog.',
    `min_stock_level` STRING COMMENT 'Minimum quantity that must be on hand to avoid stock‑out situations.',
    `part_category` STRING COMMENT 'High‑level equipment domain the part supports. [ENUM-REF-CANDIDATE: lithography|deposition|etch|cmp|metrology|ate|assembly|test|other — 9 candidates stripped; promote to reference product]',
    `part_image_url` STRING COMMENT 'Link to a digital image or drawing of the spare part.',
    `part_name` STRING COMMENT 'Human‑readable name of the spare part used in inventory and work orders.',
    `part_number` STRING COMMENT 'Manufacturer‑assigned part number that uniquely identifies the component across suppliers.',
    `part_type` STRING COMMENT 'Classification of the part based on its usage and criticality to fab operations.. Valid values are `consumable|spare|critical|standard|optional|custom`',
    `part_volume_cm3` DECIMAL(18,2) COMMENT 'Physical volume of a single unit of the part in cubic centimeters.',
    `part_weight_kg` DECIMAL(18,2) COMMENT 'Physical weight of a single unit of the part in kilograms.',
    `reorder_point` STRING COMMENT 'Inventory quantity threshold that triggers a replenishment order.',
    `safety_stock_qty` STRING COMMENT 'Buffer quantity kept to protect against demand variability and supply delays.',
    `spare_part_description` STRING COMMENT 'Detailed textual description of the part, including function and key specifications.',
    `spare_part_status` STRING COMMENT 'Current lifecycle status of the part within the inventory system.. Valid values are `active|inactive|obsolete|pending|discontinued|reserved`',
    `storage_condition` STRING COMMENT 'Environmental condition required for safe storage of the part.. Valid values are `cleanroom|ambient|refrigerated|sealed|dry|controlled`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard purchase cost per individual unit of the part.',
    `updated_by` STRING COMMENT 'Identifier of the system user who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the spare part record.',
    `warranty_expiration_date` DATE COMMENT 'Date on which the manufacturers warranty for the part expires.',
    `created_by` STRING COMMENT 'Identifier of the system user who created the record.',
    CONSTRAINT pk_spare_part PRIMARY KEY(`spare_part_id`)
) COMMENT 'Master record for spare parts and consumables inventory specific to fab tool maintenance, including critical spare parts (e.g., focus rings, edge rings, quartz liners, lamp assemblies, pump kits), their OEM part numbers, compatible tool types, minimum stock levels, lead times, and storage location in the FAB stockroom. Supports PM planning and emergency repair readiness. Sourced from SAP S/4HANA MM module.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`equipment`.`metrology_run` (
    `metrology_run_id` BIGINT COMMENT 'Unique surrogate key for each metrology run record.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Metrology equipment certifications (ISO 17025, SEMI E133, NIST traceability) govern measurement validity and data acceptance. Customer qualification and audit processes require linking measurement dat',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Lot identifier of the wafer(s) measured in this run.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Metrology measurements are associated with a design project for CD verification, required by the Design Quality Assurance report.',
    `fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Metrology runs must reference the metrology tool used for tool-specific measurement bias tracking and calibration correlation.',
    `primary_fab_tool_id` BIGINT COMMENT 'FK to equipment.fab_tool.fab_tool_id — Metrology runs must reference the metrology tool that performed the measurement. Required for tool-to-tool matching and measurement system analysis.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_step. Business justification: Metrology runs are triggered at specific process steps (post-CMP, post-litho, post-etch). Linking to fabrication_process_step enables SPC charting by step, yield correlation analysis, and process cont',
    `recipe_execution_id` BIGINT COMMENT 'Foreign key linking to equipment.recipe_execution. Business justification: Metrology runs are performed to measure the results of process recipe executions — e.g., measuring film thickness after a CVD recipe execution, or CD measurement after a lithography recipe execution. ',
    `recipe_id` BIGINT COMMENT 'Identifier of the measurement recipe used for this run.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: metrology_run has three FKs to fab_tool but no FK to tool_chamber. Metrology and inspection runs are executed on specific chambers of multi-chamber tools (e.g., a specific etch chamber on a cluster to',
    `wafer_id` BIGINT COMMENT 'Unique identifier of the individual wafer within the lot.',
    `calibration_status` STRING COMMENT 'Current calibration state of the metrology tool at run time.. Valid values are `calibrated|uncalibrated|pending`',
    `comments` STRING COMMENT 'Free‑form notes entered by the operator or engineer.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the run record was first created in the data lake.',
    `data_source` STRING COMMENT 'System that supplied the metrology data.. Valid values are `KLA_ICOS|SmartFactory_MES`',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity inside the tool during the run (%).',
    `lot_type` STRING COMMENT 'Classification of the wafer lot for the run.. Valid values are `prototype|volume|engineering`',
    `mean_value` DECIMAL(18,2) COMMENT 'Statistical mean of the measured values across all sites.',
    `measured_value` DECIMAL(18,2) COMMENT 'Raw measurement value recorded for the primary parameter.',
    `measurement_mode` STRING COMMENT 'Indicates whether the measurement was performed inline with production or offline.. Valid values are `inline|offline`',
    `measurement_type` STRING COMMENT 'Category of the physical parameter measured during the run.. Valid values are `cd|film_thickness|overlay|defect_density|refractive_index|resist_thickness`',
    `measurement_unit` STRING COMMENT 'Unit of measure associated with the measurement type.. Valid values are `nm|um|percent|mm|ps|GHz`',
    `metrology_run_status` STRING COMMENT 'Current lifecycle state of the run.. Valid values are `planned|running|completed|failed|cancelled`',
    `oee_percent` DECIMAL(18,2) COMMENT 'Calculated OEE for the tool during the run, expressed as a percentage.',
    `pass_fail` STRING COMMENT 'Overall pass/fail result of the run against spec limits.. Valid values are `pass|fail`',
    `run_duration_seconds` STRING COMMENT 'Total elapsed time of the metrology run in seconds.',
    `run_number` STRING COMMENT 'Human‑readable identifier assigned to the metrology run, e.g., MR000123.. Valid values are `^MR[0-9]{6}$`',
    `run_timestamp` TIMESTAMP COMMENT 'Date‑time when the metrology run was executed on the tool.',
    `shift` STRING COMMENT 'Work shift during which the run was performed.. Valid values are `day|swing|night`',
    `sigma_value` DECIMAL(18,2) COMMENT 'Sigma (3‑sigma) statistic derived from mean and standard deviation.',
    `spec_limit_high` DECIMAL(18,2) COMMENT 'Upper bound of the acceptable specification window for the measurement.',
    `spec_limit_low` DECIMAL(18,2) COMMENT 'Lower bound of the acceptable specification window for the measurement.',
    `std_dev` DECIMAL(18,2) COMMENT 'Standard deviation of the measured values across all sites.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature of the tool chamber during the run (°C).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the run record.',
    CONSTRAINT pk_metrology_run PRIMARY KEY(`metrology_run_id`)
) COMMENT 'Metrology and inspection run records capturing in-line and off-line measurement results from metrology tools (CD-SEM, OCD, ellipsometer, profilometer) and inspection systems (KLA ICOS, brightfield/darkfield inspection). Records measurement recipe, wafer lot and site map, measured parameter (CD, film thickness, overlay, defect density), measured values per site, mean/3-sigma statistics, and pass/fail disposition against spec limits. SSOT for process control metrology data. Sourced from KLA ICOS and SmartFactory MES.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`equipment`.`maintenance_plan` (
    `maintenance_plan_id` BIGINT COMMENT 'Primary key for maintenance_plan',
    `fab_tool_id` BIGINT COMMENT 'Unique identifier of the equipment asset linked to this maintenance plan.',
    `obligation_register_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation_register. Business justification: Maintenance plans must comply with regulatory obligations (OSHA safety inspections, EPA environmental monitoring, pressure vessel certifications, electrical safety audits). Links preventive maintenanc',
    `superseded_maintenance_plan_id` BIGINT COMMENT 'Self-referencing FK on maintenance_plan (superseded_maintenance_plan_id)',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: maintenance_plan has fab_tool_id → fab_tool but no FK to tool_chamber. Maintenance plans in semiconductor fabs are often defined at the chamber level (e.g., a specific maintenance plan for a CVD chamb',
    `calibration_interval_days` STRING COMMENT 'Number of days between required calibration activities.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard governing the maintenance activities.',
    `cost_currency` STRING COMMENT 'Currency of the cost estimate; default is USD.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Projected monetary cost to execute the maintenance plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the maintenance plan record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the maintenance plan expires or is superseded; null for open‑ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the maintenance plan becomes effective.',
    `equipment_category` STRING COMMENT 'High‑level classification of equipment the plan applies to.',
    `frequency_unit` STRING COMMENT 'Time unit for the frequency value.',
    `frequency_value` STRING COMMENT 'Numeric interval defining how often the maintenance activity recurs.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the plan is considered critical for production continuity.',
    `last_performed_date` DATE COMMENT 'Date when the maintenance plan was last executed.',
    `maintenance_plan_status` STRING COMMENT 'Current lifecycle state of the maintenance plan.',
    `maintenance_task_description` STRING COMMENT 'Narrative description of the primary maintenance activities covered by the plan.',
    `maintenance_window_hours` DECIMAL(18,2) COMMENT 'Typical duration of a maintenance event expressed in hours.',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Average operating time between equipment failures, used for reliability analysis.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time required to complete a maintenance event.',
    `next_due_date` DATE COMMENT 'Scheduled date for the next execution of the maintenance plan.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions related to the plan.',
    `plan_code` STRING COMMENT 'Business code used to reference the maintenance plan in operational systems.',
    `plan_name` STRING COMMENT 'Human‑readable name of the maintenance plan.',
    `plan_type` STRING COMMENT 'Category of maintenance activity the plan addresses.',
    `priority_level` STRING COMMENT 'Business priority assigned to the maintenance plan.',
    `required_skill_level` STRING COMMENT 'Skill tier required for personnel executing the plan.',
    `requires_calibration` BOOLEAN COMMENT 'True if the equipment requires periodic calibration as part of this plan.',
    `safety_risk_level` STRING COMMENT 'Assessed safety risk associated with the maintenance plan.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Planned end timestamp for the first maintenance window.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned start timestamp for the first maintenance window under this plan.',
    `task_count` STRING COMMENT 'Total count of distinct tasks defined in the maintenance plan.',
    `tool_serial_number` STRING COMMENT 'Manufacturer‑assigned serial number of the equipment tool.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the maintenance plan record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the maintenance plan record.',
    `vendor_contact` STRING COMMENT 'Contact details (phone or email) for the vendor responsible for the maintenance service.',
    `vendor_name` STRING COMMENT 'Name of the equipment vendor or service provider associated with the maintenance plan.',
    `warranty_expiration_date` DATE COMMENT 'Date when the equipment warranty expires, influencing maintenance decisions.',
    `created_by` STRING COMMENT 'User identifier of the person who created the maintenance plan record.',
    CONSTRAINT pk_maintenance_plan PRIMARY KEY(`maintenance_plan_id`)
) COMMENT 'Master reference table for maintenance_plan. Referenced by maintenance_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ADD CONSTRAINT `fk_equipment_tool_chamber_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ADD CONSTRAINT `fk_equipment_tool_qualification_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `semiconductors_ecm`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_primary_pm_fab_tool_id` FOREIGN KEY (`primary_pm_fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `semiconductors_ecm`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ADD CONSTRAINT `fk_equipment_pm_schedule_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `semiconductors_ecm`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `semiconductors_ecm`.`equipment`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `semiconductors_ecm`.`equipment`.`spare_part`(`spare_part_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ADD CONSTRAINT `fk_equipment_maintenance_event_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `semiconductors_ecm`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ADD CONSTRAINT `fk_equipment_tool_downtime_tool_maintenance_event_id` FOREIGN KEY (`tool_maintenance_event_id`) REFERENCES `semiconductors_ecm`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_tertiary_fab_tool_id` FOREIGN KEY (`tertiary_fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ADD CONSTRAINT `fk_equipment_calibration_record_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `semiconductors_ecm`.`equipment`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ADD CONSTRAINT `fk_equipment_equipment_process_recipe_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_equipment_process_recipe_id` FOREIGN KEY (`equipment_process_recipe_id`) REFERENCES `semiconductors_ecm`.`equipment`.`equipment_process_recipe`(`equipment_process_recipe_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_recipe_fab_tool_id` FOREIGN KEY (`recipe_fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ADD CONSTRAINT `fk_equipment_recipe_execution_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ADD CONSTRAINT `fk_equipment_spare_part_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_primary_fab_tool_id` FOREIGN KEY (`primary_fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_recipe_execution_id` FOREIGN KEY (`recipe_execution_id`) REFERENCES `semiconductors_ecm`.`equipment`.`recipe_execution`(`recipe_execution_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ADD CONSTRAINT `fk_equipment_metrology_run_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_fab_tool_id` FOREIGN KEY (`fab_tool_id`) REFERENCES `semiconductors_ecm`.`equipment`.`fab_tool`(`fab_tool_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_superseded_maintenance_plan_id` FOREIGN KEY (`superseded_maintenance_plan_id`) REFERENCES `semiconductors_ecm`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_tool_chamber_id` FOREIGN KEY (`tool_chamber_id`) REFERENCES `semiconductors_ecm`.`equipment`.`tool_chamber`(`tool_chamber_id`);

-- ========= TAGS =========
ALTER SCHEMA `semiconductors_ecm`.`equipment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `semiconductors_ecm`.`equipment` SET TAGS ('dbx_domain' = 'equipment');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Oem Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|inactive|scrapped');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `capacity_wafer_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity (Wafer/Hour)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `capital_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Amount');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `cleanroom_class` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Class');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `cleanroom_class` SET TAGS ('dbx_value_regex' = 'class1|class10|class100');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `energy_consumption_kwh_per_year` SET TAGS ('dbx_business_glossary_term' = 'Annual Energy Consumption (kWh)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Site Code');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `fab_tool_description` SET TAGS ('dbx_business_glossary_term' = 'Tool Description');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `fab_tool_name` SET TAGS ('dbx_business_glossary_term' = 'Tool Name');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|maintenance|decommissioned|spare');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `maintenance_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval (Days)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `oee_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percent');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating (kW)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `process_node_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Process Node Compatibility');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `process_node_compatibility` SET TAGS ('dbx_value_regex' = '5nm|7nm|10nm|14nm|28nm|40nm');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `tool_subtype` SET TAGS ('dbx_business_glossary_term' = 'Tool Subtype');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `tool_type` SET TAGS ('dbx_business_glossary_term' = 'Tool Type');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`fab_tool` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Tool ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `audit_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Audit Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|out_of_calibration|pending');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_code` SET TAGS ('dbx_business_glossary_term' = 'Chamber Code');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_lifetime_hours` SET TAGS ('dbx_business_glossary_term' = 'Chamber Lifetime (Hours)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_name` SET TAGS ('dbx_business_glossary_term' = 'Chamber Name');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Current Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_type` SET TAGS ('dbx_business_glossary_term' = 'Chamber Type (e.g., Deposition, Etch, CVD, PVD, Metrology, Inspection)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `chamber_type` SET TAGS ('dbx_value_regex' = 'deposition|etch|cvd|pvd|metrology|inspection');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_audit');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `gas_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Rate (sccm)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `last_calibration_result` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Result');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Physical Location of Chamber');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `maintenance_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (Days)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness Percentage');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `pressure_setpoint_pa` SET TAGS ('dbx_business_glossary_term' = 'Pressure Setpoint (Pa)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `qualification_result` SET TAGS ('dbx_business_glossary_term' = 'Qualification Result');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|unqualified|pending|failed');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `safety_lock_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Lock Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `safety_lock_status` SET TAGS ('dbx_value_regex' = 'engaged|disengaged');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `temperature_setpoint_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint (°C)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `throughput_pph` SET TAGS ('dbx_business_glossary_term' = 'Throughput (Parts Per Hour)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `tool_chamber_description` SET TAGS ('dbx_business_glossary_term' = 'Description of Chamber');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `tool_chamber_status` SET TAGS ('dbx_business_glossary_term' = 'Chamber Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `tool_chamber_status` SET TAGS ('dbx_value_regex' = 'in_service|maintenance|retired|decommissioned|qualified|unqualified');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_chamber` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber Identifier (CHAMBER_ID)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe Identifier (RECIPE_ID)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DT)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVER)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Metric Value (BASELINE_VAL)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date (CALIB_DATE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status (CALIB_STATUS)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|due|overdue');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number (CC_NUM)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Status (COMP_APPROVAL)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `compliance_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Identifier (COMP_DOC_ID)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (DOC_URL)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number (SERIAL_NO)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag (IS_CRITICAL)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (MAINT_LAST_DT)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status (MAINT_STATUS)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'up_to_date|overdue');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method (MEAS_METHOD)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'metrology|visual|electrical');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes (QUAL_NOTES)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `oee_impact` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Percentage (OEE_IMPACT_PCT)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `process_node` SET TAGS ('dbx_business_glossary_term' = 'Process Node (TECH_NODE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_end_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification End Date (QUAL_END_DT)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_location` SET TAGS ('dbx_business_glossary_term' = 'Qualification Location (QUAL_LOC)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_protocol` SET TAGS ('dbx_business_glossary_term' = 'Qualification Protocol (QUAL_PROTOCOL)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Qualification Reason (QUAL_REASON)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_reason` SET TAGS ('dbx_value_regex' = 'new_product|process_change|equipment_upgrade|maintenance');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Start Date (QUAL_START_DT)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QUAL_STATUS)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|passed|failed|cancelled');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type (QUAL_TYPE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'initial|requalification|process_change|maintenance');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Qualification Validity Period (VALIDITY_DAYS)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `qualification_version` SET TAGS ('dbx_business_glossary_term' = 'Qualification Version (QUAL_VER)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Qualification Result (QUAL_RESULT)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `result_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Metric Unit (QUAL_METRIC_UOM)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `result_metric_unit` SET TAGS ('dbx_value_regex' = 'nm|um|mm|percent');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `result_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Result Metric Value (QUAL_METRIC_VAL)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment (RISK_ASSESS)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `tolerance` SET TAGS ('dbx_business_glossary_term' = 'Tolerance (QUAL_TOLERANCE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date (VALID_UNTIL)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_qualification` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date (VALID_FROM)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Schedule ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `primary_pm_fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Required Spare Part ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_value_regex' = 'SEMI|ISO9001|ISO14001|ITAR|RoHS|REACH');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `estimated_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime (Minutes)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Interval Unit');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `interval_unit` SET TAGS ('dbx_value_regex' = 'day|week|month|wafer|run');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `interval_value` SET TAGS ('dbx_business_glossary_term' = 'Interval Value');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Equipment Flag');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `last_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performed Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `maintenance_window_end` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `maintenance_window_start` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `oee_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Estimate (%)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `pm_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'PM Procedure Reference');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `pm_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `pm_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `pm_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|planned');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `pm_type` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Type (PM Type)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `pm_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|wafer_count|run_count');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `required_technician_skill_level` SET TAGS ('dbx_business_glossary_term' = 'Technician Skill Level Requirement');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `required_technician_skill_level` SET TAGS ('dbx_value_regex' = 'junior|mid|senior|expert');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `scheduling_constraint` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Constraint');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`pm_schedule` ALTER COLUMN `work_order_template_code` SET TAGS ('dbx_business_glossary_term' = 'Work Order Template ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `baseline_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Change Flag');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Comments');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'ISO9001|ITAR|EAR|RoHS|REACH|SOX');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency (ISO 4217)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `eco_reference` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Reference');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Maintenance End Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Number (EVT_NUM)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Type (MTN_TYPE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|emergency|upgrade|modification');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `labor_cost_total` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Cost (USD)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Category');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_value_regex' = 'preventive|predictive|reactive');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_event_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `maintenance_event_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|cancelled');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `oee_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Percentage');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `parts_cost_total` SET TAGS ('dbx_business_glossary_term' = 'Total Parts Cost (USD)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `performance_improvement_target` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Target');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `post_config_version` SET TAGS ('dbx_business_glossary_term' = 'Post‑Configuration Version');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `pre_config_version` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Configuration Version');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `repair_action_description` SET TAGS ('dbx_business_glossary_term' = 'Repair Action Description');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `requalification_required` SET TAGS ('dbx_business_glossary_term' = 'Re‑qualification Required');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `requalification_status` SET TAGS ('dbx_business_glossary_term' = 'Re‑qualification Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `requalification_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_required');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category (RC_CAT)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|software|process|human_error|unknown');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `root_cause_detail` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Detail');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `safety_incident_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Description');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Maintenance Cost (USD)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Trigger Source (TRG_SRC)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `trigger_source` SET TAGS ('dbx_value_regex' = 'scheduled_pm|alarm|operator_report|fdc_event|eco');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `upgrade_type` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Type (UPG_TYPE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `upgrade_type` SET TAGS ('dbx_value_regex' = 'none|hardware|software|firmware');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `tool_downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Downtime Record ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason Code');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason Description');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_type` SET TAGS ('dbx_business_glossary_term' = 'Downtime Type');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `downtime_type` SET TAGS ('dbx_value_regex' = 'productive|standby|engineering|scheduled|unscheduled|non_scheduled');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `impact_wip_lot_count` SET TAGS ('dbx_business_glossary_term' = 'WIP Lot Impact Count');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `oee_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'OEE Impact Percentage');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'maintenance|engineering|facilities|scheduling|operator');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment|process|material|human|environment');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Downtime Flag');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'MES|Camstar|KLA|Custom');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `state_after` SET TAGS ('dbx_business_glossary_term' = 'State After Downtime');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `state_before` SET TAGS ('dbx_business_glossary_term' = 'State Before Downtime');
ALTER TABLE `semiconductors_ecm`.`equipment`.`tool_downtime` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval (Days)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_method` SET TAGS ('dbx_business_glossary_term' = 'Calibration Method');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_method` SET TAGS ('dbx_value_regex' = 'sensor|reference|laser|electrical');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_record_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_record_status` SET TAGS ('dbx_value_regex' = 'pending|completed|rejected|archived');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_report_url` SET TAGS ('dbx_business_glossary_term' = 'Calibration Report URL');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_result_code` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result Code');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_source_system` SET TAGS ('dbx_business_glossary_term' = 'Calibration Source System');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_standard` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calibration Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_type` SET TAGS ('dbx_business_glossary_term' = 'Calibration Type');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `calibration_type` SET TAGS ('dbx_value_regex' = 'in-situ|offline|periodic|initial|post-maintenance');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reference');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Equipment Location');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Calibration Value');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'nm|um|mm|V|A|%');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `nominal_value` SET TAGS ('dbx_business_glossary_term' = 'Nominal Calibration Value');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `semiconductors_ecm`.`equipment`.`calibration_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `equipment_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Process Recipe ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `change_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `technology_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Control Plan Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|revoked');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `exposure_dose_mj_cm2` SET TAGS ('dbx_business_glossary_term' = 'Exposure Dose (mJ/cm²)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `focus_offset_nm` SET TAGS ('dbx_business_glossary_term' = 'Focus Offset (nm)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `gas_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Rate (sccm)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated Flag');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `oee_actual_percent` SET TAGS ('dbx_business_glossary_term' = 'OEE Actual Percentage');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `oee_target_percent` SET TAGS ('dbx_business_glossary_term' = 'OEE Target Percentage');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `parameter_count` SET TAGS ('dbx_business_glossary_term' = 'Parameter Count');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `parameter_set_description` SET TAGS ('dbx_business_glossary_term' = 'Parameter Set Description');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `pressure_setpoint_pa` SET TAGS ('dbx_business_glossary_term' = 'Pressure Setpoint (Pa)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `process_node_target` SET TAGS ('dbx_business_glossary_term' = 'Target Process Node');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `process_step_count` SET TAGS ('dbx_business_glossary_term' = 'Process Step Count');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_category` SET TAGS ('dbx_business_glossary_term' = 'Recipe Category');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_category` SET TAGS ('dbx_value_regex' = 'Front-End|Back-End|Middle-Of-Line|Packaging');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_code` SET TAGS ('dbx_business_glossary_term' = 'Recipe Code');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_hash` SET TAGS ('dbx_business_glossary_term' = 'Recipe Hash');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Name');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `recipe_owner` SET TAGS ('dbx_business_glossary_term' = 'Recipe Owner');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `rf_power_watts` SET TAGS ('dbx_business_glossary_term' = 'RF Power (W)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `safety_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `safety_status` SET TAGS ('dbx_value_regex' = 'safe|warning|critical');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `spin_speed_rpm` SET TAGS ('dbx_business_glossary_term' = 'Spin Speed (RPM)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `temperature_setpoint_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint (°C)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `version_history_note` SET TAGS ('dbx_business_glossary_term' = 'Version History Note');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `yield_actual_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Actual Percentage');
ALTER TABLE `semiconductors_ecm`.`equipment`.`equipment_process_recipe` ALTER COLUMN `yield_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Target Percentage');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `recipe_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Execution Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Execution Duration (Seconds)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution End Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'pass|fail|abort');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `gas_flow_actual_sccm` SET TAGS ('dbx_business_glossary_term' = 'Actual Gas Flow (sccm)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `gas_flow_setpoint_sccm` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Setpoint (sccm)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `is_calibrated` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status Flag');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Execution Flag');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Execution Notes');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `oee_availability_percent` SET TAGS ('dbx_business_glossary_term' = 'OEE Availability (%)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `oee_performance_percent` SET TAGS ('dbx_business_glossary_term' = 'OEE Performance (%)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `oee_quality_percent` SET TAGS ('dbx_business_glossary_term' = 'OEE Quality (%)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `power_actual_w` SET TAGS ('dbx_business_glossary_term' = 'Actual Power (W)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `power_setpoint_w` SET TAGS ('dbx_business_glossary_term' = 'Power Setpoint (W)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `pressure_actual_pa` SET TAGS ('dbx_business_glossary_term' = 'Actual Pressure (Pa)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `pressure_setpoint_pa` SET TAGS ('dbx_business_glossary_term' = 'Pressure Setpoint (Pa)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step Name');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe Version');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `result_code` SET TAGS ('dbx_business_glossary_term' = 'Result Code');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Sequence Number');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `temperature_actual_c` SET TAGS ('dbx_business_glossary_term' = 'Actual Temperature (°C)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `temperature_setpoint_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint (°C)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `time_actual_sec` SET TAGS ('dbx_business_glossary_term' = 'Actual Process Time (Sec)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`recipe_execution` ALTER COLUMN `time_setpoint_sec` SET TAGS ('dbx_business_glossary_term' = 'Process Time Setpoint (Sec)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval (Days)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `calibration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required Flag');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|none|unknown|reserved');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `current_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Current Stock Quantity');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'recycle|sell|destroy|return|donate|store');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `equipment_compatible` SET TAGS ('dbx_business_glossary_term' = 'Compatible Equipment Types');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|deferred|not_required|exempt');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `lifecycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle End Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `lifecycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Start Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `part_category` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Category');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `part_image_url` SET TAGS ('dbx_business_glossary_term' = 'Part Image URL');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `part_name` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Name');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Number (OEM)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `part_type` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Type');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `part_type` SET TAGS ('dbx_value_regex' = 'consumable|spare|critical|standard|optional|custom');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `part_volume_cm3` SET TAGS ('dbx_business_glossary_term' = 'Part Volume (cm³)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `part_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Part Weight (kg)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `spare_part_description` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Description');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `spare_part_status` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Status');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `spare_part_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending|discontinued|reserved');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Required Storage Condition');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'cleanroom|ambient|refrigerated|sealed|dry|controlled');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost (USD)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `semiconductors_ecm`.`equipment`.`spare_part` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `metrology_run_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Run Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Identifier (WAFER_LOT_ID)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `recipe_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Execution Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Recipe Identifier (RECIPE_ID)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (WAFER_ID)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status (CALIBRATION_STATUS)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|uncalibrated|pending');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Run Comments (COMMENTS)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source (DATA_SOURCE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'KLA_ICOS|SmartFactory_MES');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Tool Humidity (HUMIDITY_PERCENT)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type (LOT_TYPE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'prototype|volume|engineering');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `mean_value` SET TAGS ('dbx_business_glossary_term' = 'Mean Value (MEAN_VALUE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value (MEASURED_VALUE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_business_glossary_term' = 'Measurement Mode (MEASUREMENT_MODE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_value_regex' = 'inline|offline');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type (MEASUREMENT_TYPE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'cd|film_thickness|overlay|defect_density|refractive_index|resist_thickness');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit (MEASUREMENT_UNIT)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'nm|um|percent|mm|ps|GHz');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `metrology_run_status` SET TAGS ('dbx_business_glossary_term' = 'Metrology Run Status (STATUS)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `metrology_run_status` SET TAGS ('dbx_value_regex' = 'planned|running|completed|failed|cancelled');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `oee_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE_PERCENT)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Disposition (PASS_FAIL)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Run Duration (RUN_DURATION_SECONDS)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Metrology Run Number (RUN_NUMBER)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `run_number` SET TAGS ('dbx_value_regex' = '^MR[0-9]{6}$');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Metrology Run Timestamp (RUN_TIMESTAMP)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift (SHIFT)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|swing|night');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `sigma_value` SET TAGS ('dbx_business_glossary_term' = 'Sigma Value (SIGMA_VALUE)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `spec_limit_high` SET TAGS ('dbx_business_glossary_term' = 'Specification Upper Limit (SPEC_LIMIT_HIGH)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `spec_limit_low` SET TAGS ('dbx_business_glossary_term' = 'Specification Lower Limit (SPEC_LIMIT_LOW)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `std_dev` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation (STD_DEV)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Tool Temperature (TEMPERATURE_C)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`metrology_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_plan` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Identifier');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `obligation_register_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Register Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `superseded_maintenance_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `semiconductors_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
