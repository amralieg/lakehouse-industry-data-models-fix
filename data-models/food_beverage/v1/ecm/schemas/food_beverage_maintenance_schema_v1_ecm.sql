-- Schema for Domain: maintenance | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`maintenance` COMMENT 'Manages preventive and corrective maintenance of manufacturing equipment, CMMS work orders, spare parts inventory, calibration schedules, and asset reliability programs across all F&B production facilities';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`asset` (
    `asset_id` BIGINT COMMENT 'Unique surrogate key for each maintainable asset.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Asset Ownership Register requires linking each asset to the owning customer account for warranty and service SLA tracking.',
    `asset_group_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset_group. Business justification: Assets are organized into groups; adding asset_group_id links each asset to its group.',
    `asset_hierarchy_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset_hierarchy. Business justification: Each asset belongs to a hierarchy node; adding asset_hierarchy_id creates the required parent relationship.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Asset Maintenance Responsibility Report requires linking each asset to the employee accountable for its upkeep, enabling compliance tracking and cost allocation.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: REQUIRED: Asset‑to‑Brand Production Traceability report needs brand_id on asset to link equipment producing a specific brand for recall and compliance.',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_center. Business justification: Regulatory equipment location reporting requires each asset to be tied to its distribution center for maintenance scheduling and compliance.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Asset accounting needs company code for ledger posting and statutory financial statements.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for capital asset depreciation accounting; assets are charged to a cost center for financial reporting.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Audit: Asset compliance tracking requires linking each asset to its facilitys registration for regulatory audit and reporting.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Required for Maintenance Scheduling report: links each asset to its network node location to calculate OTIF and logistics impact.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Links installed equipment to the originating sales order, supporting traceability for warranty claims and post‑sale service.',
    `parent_asset_id` BIGINT COMMENT 'Reference to a higher‑level asset for hierarchical equipment (e.g., a line containing multiple machines).',
    `plant_id` BIGINT COMMENT 'Identifier of the plant/facility where the asset resides.',
    `production_line_id` BIGINT COMMENT 'Identifier of the production line to which the asset is assigned.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Required for R&D equipment cost allocation and compliance reporting linking each asset to its R&D project.',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Needed for equipment lease tracking; each asset is provisioned under a sales contract, enabling contract compliance and revenue recognition reports.',
    `ship_to_location_id` BIGINT COMMENT 'Foreign key linking to customer.ship_to_location. Business justification: Service Scheduling uses the customers ship‑to location to plan on‑site maintenance visits for assets.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Asset location tracking links equipment to its storage location, supporting the Asset Utilization and Allocation report.',
    `asset_category` STRING COMMENT 'Specific functional category of the equipment. [ENUM-REF-CANDIDATE: mixer|boiler|conveyor|refrigeration|cip_system|compressor|pump|valve — 8 candidates stripped; promote to reference product]',
    `asset_name` STRING COMMENT 'Human‑readable name of the asset used in reports and work orders.',
    `asset_status` STRING COMMENT 'Current operational status of the asset.. Valid values are `active|inactive|decommissioned|scrapped`',
    `asset_type` STRING COMMENT 'Broad classification of the asset within the plant.. Valid values are `production_equipment|utility|facility|instrumentation`',
    `barcode` STRING COMMENT 'Machine‑readable barcode associated with the asset tag.',
    `book_value` DECIMAL(18,2) COMMENT 'Net book value of the asset after depreciation.',
    `calibration_due_date` DATE COMMENT 'Date by which the asset must be recalibrated to maintain measurement accuracy.',
    `calibration_interval_days` STRING COMMENT 'Standard period between required calibrations.',
    `capacity_units` STRING COMMENT 'Production capacity expressed in appropriate units (e.g., liters_per_hour).',
    `class_iso14224` STRING COMMENT 'Classification code defined by ISO 14224 for equipment type.',
    `commissioning_date` DATE COMMENT 'Date the asset became operational after testing.',
    `compliance_certifications` STRING COMMENT 'List of certifications (e.g., GMP, HACCP, ISO 22000) held by the asset.',
    `criticality_rating` STRING COMMENT 'Business impact rating used for risk‑based maintenance planning.. Valid values are `critical|major|minor`',
    `decommission_date` DATE COMMENT 'Date the asset was retired or removed from service.',
    `dimensions` STRING COMMENT 'Length x Width x Height of the asset (e.g., 2.5m x 1.2m x 1.8m).',
    `health_score` STRING COMMENT 'Composite score indicating overall equipment health.',
    `installation_date` DATE COMMENT 'Date the asset was physically installed at the plant.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or internal inspection.',
    `last_maintenance_date` DATE COMMENT 'Date the most recent maintenance work order was completed.',
    `maintenance_interval_days` STRING COMMENT 'Standard interval between preventive maintenance events.',
    `maintenance_strategy` STRING COMMENT 'Chosen maintenance approach for the asset.. Valid values are `preventive|predictive|run_to_failure`',
    `manufacturer` STRING COMMENT 'Company that built the asset.',
    `model_number` STRING COMMENT 'Model identifier assigned by the manufacturer.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating time between two consecutive failures.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to restore the asset to service after a failure.',
    `next_inspection_date` DATE COMMENT 'Planned date for the next required inspection.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next preventive maintenance activity.',
    `operating_status` STRING COMMENT 'Current operational condition of the asset.. Valid values are `operational|standby|out_of_service`',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Maximum electrical power consumption of the asset.',
    `regulatory_status` STRING COMMENT 'Current status of the asset with respect to regulatory compliance.. Valid values are `compliant|non_compliant|pending`',
    `replacement_value` DECIMAL(18,2) COMMENT 'Estimated cost to replace the asset with a new equivalent unit.',
    `risk_score` STRING COMMENT 'Risk rating used for reliability and safety planning.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the asset.',
    `tag` STRING COMMENT 'Barcode or RFID tag printed on the asset for physical identification.',
    `useful_life_years` STRING COMMENT 'Planned economic life of the asset expressed in years.',
    `warranty_expiry_date` DATE COMMENT 'Date the OEM warranty coverage ends.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Mass of the asset in kilograms.',
    CONSTRAINT pk_asset PRIMARY KEY(`asset_id`)
) COMMENT 'Master record for all maintainable physical assets across F&B production facilities — filling lines, mixers, pasteurizers, CIP systems, boilers, compressors, conveyors, refrigeration units, and utilities. Captures asset ID, asset name, asset type (production equipment, utility, facility, instrumentation), asset category, manufacturer, model number, serial number, installation date, commissioning date, decommission date, asset status (active, inactive, decommissioned, scrapped), criticality rating (critical, major, minor), plant/facility assignment, production line assignment, cost center, replacement value, current book value, expected useful life (years), maintenance strategy (preventive, predictive, run-to-failure), OEM warranty expiry date, asset tag/barcode, parent asset reference for hierarchy, and asset class per ISO 14224. SSOT for all maintainable equipment identity in the maintenance domain — distinct from manufacturing.equipment_master which focuses on production execution context.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` (
    `asset_hierarchy_id` BIGINT COMMENT 'System-generated unique identifier for each node in the asset hierarchy.',
    `parent_node_asset_hierarchy_id` BIGINT COMMENT 'Identifier of the immediate parent node in the hierarchy.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant to which the node belongs.',
    `parent_asset_hierarchy_id` BIGINT COMMENT 'Self-referencing FK on asset_hierarchy (parent_asset_hierarchy_id)',
    `asset_category` STRING COMMENT 'Broad classification of the asset type.. Valid values are `mechanical|electrical|process|utility`',
    `asset_hierarchy_description` STRING COMMENT 'Detailed textual description of the asset or location.',
    `asset_hierarchy_status` STRING COMMENT 'Current operational status of the node.. Valid values are `active|inactive|planned|decommissioned`',
    `asset_subcategory` STRING COMMENT 'More specific classification within the asset category.. Valid values are `pump|motor|valve|conveyor|boiler`',
    `asset_tag` STRING COMMENT 'Internal tag or barcode used for tracking the asset.',
    `availability_percent` DECIMAL(18,2) COMMENT 'Percentage of time the asset is available for production.',
    `calibration_interval_days` STRING COMMENT 'Number of days between required calibrations.',
    `calibration_required` BOOLEAN COMMENT 'Indicates whether the asset requires periodic calibration.',
    `compliance_status` STRING COMMENT 'Current compliance state with food safety regulations.. Valid values are `compliant|non_compliant|pending`',
    `cost_center_code` STRING COMMENT 'Financial cost center responsible for the asset.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hierarchy record was created.',
    `criticality_level` STRING COMMENT 'Business criticality of the asset for production.. Valid values are `high|medium|low`',
    `decommission_date` DATE COMMENT 'Date the asset was retired or removed from service.',
    `effective_end_date` DATE COMMENT 'Date when the node ceases to be effective (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the node becomes effective in the hierarchy.',
    `hierarchy_level` STRING COMMENT 'Depth of the node in the hierarchy (root = 0).',
    `installation_date` DATE COMMENT 'Date the asset was installed and placed into service.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity.',
    `location_latitude` DOUBLE COMMENT 'Geographic latitude of the assets physical location.',
    `location_longitude` DOUBLE COMMENT 'Geographic longitude of the assets physical location.',
    `maintenance_group` STRING COMMENT 'Team or group responsible for maintaining the asset.',
    `maintenance_strategy` STRING COMMENT 'Planned maintenance approach for the asset.. Valid values are `preventive|predictive|reactive|none`',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the asset.',
    `model_number` STRING COMMENT 'Model identifier assigned by the manufacturer.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating time between failures for the asset.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to restore the asset after a failure.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next preventive maintenance.',
    `node_code` STRING COMMENT 'Standard SAP functional location code identifying the node (e.g., 1000‑2000‑3000).',
    `node_name` STRING COMMENT 'Human‑readable name of the asset or functional location.',
    `node_type` STRING COMMENT 'Category of the node within the hierarchy.. Valid values are `plant|area|system|subsystem|equipment`',
    `oee_percent` DECIMAL(18,2) COMMENT 'Combined metric of availability, performance, and quality.',
    `otif_target_percent` DECIMAL(18,2) COMMENT 'Target percentage for delivering orders on time and in full for the assets output.',
    `responsible_department` STRING COMMENT 'Organizational department that owns the asset.',
    `safety_rating` STRING COMMENT 'Safety risk rating assigned to the asset.. Valid values are `high|medium|low`',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the equipment.',
    `updated_by` STRING COMMENT 'User identifier who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `warranty_expiration_date` DATE COMMENT 'Date when the assets manufacturer warranty ends.',
    `created_by` STRING COMMENT 'User identifier who created the record.',
    CONSTRAINT pk_asset_hierarchy PRIMARY KEY(`asset_hierarchy_id`)
) COMMENT 'Defines the parent-child functional location and asset hierarchy used in CMMS for F&B facilities — from plant level down to functional location, system, sub-system, and individual equipment unit. Captures hierarchy node ID, node name, node type (plant, area, system, equipment), parent node reference, functional location code (SAP FL format), hierarchy level, plant assignment, description, and effective dates. Enables roll-up of maintenance KPIs (MTBF, MTTR, availability) across the asset tree and supports work order routing to the correct functional location.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`work_order` (
    `work_order_id` BIGINT COMMENT 'System-generated unique identifier for the work order record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Work Order Reporting aggregates orders per customer account to monitor downtime and service costs.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: Work orders are executed on a specific asset; adding asset_id links the order to its target asset.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: REQUIRED: Work Order Impact on Brand Production Schedule analysis requires brand_id on work_order to assess maintenance effects on brand output.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Site coordination requires linking each work order to the primary customer contact responsible for the location.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Charges from work orders are allocated to cost centers for internal cost performance analysis.',
    `equipment_master_id` BIGINT COMMENT 'Identifier of the equipment or asset to be maintained.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Work order costs are posted to a GL account; essential for maintenance expense reporting.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Associates after‑sale service work orders with the original sales order for warranty validation and service cost allocation.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plan. Business justification: Integrated Production Schedule process ties work orders to supply plans to adjust production quantities when equipment is down.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who requested the work order.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Traceability: Work orders for equipment producing a regulated product must reference the product registration to ensure compliance.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Maintenance expenses affect profit‑center P&L; linking enables profit‑center profitability reporting.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: Work orders for setting up promotional displays are created per promotion event; linking enables scheduling, labor costing, and audit of promotion‑related maintenance.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Needed to track maintenance work orders affecting R&D project schedules and downtime impact for project performance reports.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Production Planning creates work orders for each SKU batch; linking work_order to sku enables the Production Schedule report and cost tracking per SKU.',
    `work_center_id` BIGINT COMMENT 'FK to manufacturing.work_center.work_center_id — Production-critical: maintenance work orders must join to manufacturing work centers to identify which production line is affected during equipment failure. Without this FK, maintenance-to-production ',
    `work_order_template_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order_template. Business justification: Work orders are created from a template; adding work_order_template_id captures this relationship.',
    `parent_work_order_id` BIGINT COMMENT 'Self-referencing FK on work_order (parent_work_order_id)',
    `actual_cost` DECIMAL(18,2) COMMENT 'Final total cost incurred for the work order.',
    `actual_end_date` DATE COMMENT 'Date when the maintenance work was completed.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Recorded labor effort in hours actually spent.',
    `actual_start_date` DATE COMMENT 'Date when the maintenance work actually began.',
    `completion_notes` STRING COMMENT 'Final remarks and observations recorded upon work order closure.',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective measures applied to resolve the issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost values.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total production downtime caused by the maintenance activity.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected total cost for the work order before execution.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Planned labor effort in hours for the work order.',
    `failure_description` STRING COMMENT 'Narrative of the observed failure or issue prompting the work order.',
    `failure_mode_code` STRING COMMENT 'Code representing the mode of failure observed.',
    `functional_location` STRING COMMENT 'Hierarchical location code where the asset resides.',
    `order_issued_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order was officially issued to the maintenance team.',
    `permit_to_work_number` STRING COMMENT 'Identifier of the issued permit to work for the activity.',
    `planned_end_date` DATE COMMENT 'Scheduled completion date for the maintenance activity.',
    `planned_start_date` DATE COMMENT 'Scheduled start date for the maintenance activity.',
    `priority` STRING COMMENT 'Urgency level assigned to the work order.. Valid values are `emergency|urgent|normal|low`',
    `production_impact_flag` BOOLEAN COMMENT 'Indicates whether the work order impacted production output.',
    `root_cause_code` STRING COMMENT 'Standardized code describing the underlying cause of the failure.',
    `safety_permit_required_flag` BOOLEAN COMMENT 'True if a safety permit is required before work can commence.',
    `sap_pm_order_number` STRING COMMENT 'Corresponding SAP Plant Maintenance order number for ERP integration.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the work order record.',
    `work_description` STRING COMMENT 'Detailed description of the maintenance tasks to be performed.',
    `work_order_number` STRING COMMENT 'External work order number used in CMMS and ERP integration.',
    `work_order_status` STRING COMMENT 'Current lifecycle state of the work order. [ENUM-REF-CANDIDATE: created|planned|released|in_progress|completed|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `work_order_type` STRING COMMENT 'Classification of the maintenance activity type. [ENUM-REF-CANDIDATE: preventive|corrective|predictive|emergency|shutdown|inspection|calibration — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Core CMMS work order record representing every maintenance activity executed across F&B production facilities — the primary transactional entity of the maintenance domain. Captures work order number, work order type (preventive, corrective, predictive, emergency, shutdown, inspection, calibration), work order status (created, planned, released, in-progress, completed, closed, cancelled), priority (emergency, urgent, normal, low), asset reference, functional location, failure description, work description, requested by, assigned to (crew/technician), planned start date, planned end date, actual start date, actual end date, estimated labor hours, actual labor hours, estimated cost, actual cost, downtime hours caused, production impact flag, safety permit required flag, permit-to-work number, root cause code, failure mode code, corrective action taken, completion notes, and SAP PM order number for ERP integration.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` (
    `work_order_task_id` BIGINT COMMENT 'Unique identifier for the work order task line item.',
    `employee_id` BIGINT COMMENT 'Identifier of the technician or mechanic assigned to execute the task.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Task execution may require parts from a specific location; the Work Order Task Allocation report depends on this FK.',
    `work_order_id` BIGINT COMMENT 'Identifier of the parent work order that this task belongs to.',
    `predecessor_work_order_task_id` BIGINT COMMENT 'Self-referencing FK on work_order_task (predecessor_work_order_task_id)',
    `actual_duration_minutes` STRING COMMENT 'Actual time in minutes spent on the task.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date‑time when the task was marked completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the task record was initially created in the system.',
    `equipment_tag` STRING COMMENT 'Asset tag or identifier of the equipment on which the task is performed.',
    `is_critical` BOOLEAN COMMENT 'True if the task is classified as critical to production continuity.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Monetary cost of labor for the task, based on labor hours and labor rate.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours charged to the task (derived from actual duration).',
    `maintenance_category` STRING COMMENT 'Category of maintenance activity (preventive, corrective, or predictive).. Valid values are `preventive|corrective|predictive`',
    `part_cost_total` DECIMAL(18,2) COMMENT 'Aggregate cost of all parts used in the task.',
    `part_quantity_used` STRING COMMENT 'Total quantity of parts consumed for the task.',
    `parts_used` STRING COMMENT 'List of part numbers or SKUs consumed during the task.',
    `planned_duration_minutes` STRING COMMENT 'Estimated time in minutes required to complete the task as planned.',
    `priority_level` STRING COMMENT 'Business priority assigned to the task.. Valid values are `low|medium|high|critical`',
    `quality_check_passed` BOOLEAN COMMENT 'Indicates whether the task passed post‑completion quality inspection.',
    `quality_notes` STRING COMMENT 'Comments or observations from the quality inspection.',
    `safety_instructions` STRING COMMENT 'Safety precautions and instructions that must be followed while performing the task.',
    `sequence_number` STRING COMMENT 'Ordinal position of the task within the work order workflow.',
    `skill_required` STRING COMMENT 'Skill or trade required to perform the task (e.g., electrician, mechanic).',
    `task_code` STRING COMMENT 'External reference code for the task, used in work order documentation.',
    `task_description` STRING COMMENT 'Detailed description of the maintenance activity to be performed.',
    `task_type` STRING COMMENT 'Category of the maintenance task (e.g., inspection, lubrication, replacement, adjustment, cleaning, testing).. Valid values are `inspection|lubrication|replacement|adjustment|cleaning|testing`',
    `tools_required` STRING COMMENT 'Comma‑separated list of tools, equipment, or fixtures needed for the task.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the task record.',
    `work_order_task_status` STRING COMMENT 'Current lifecycle state of the task.. Valid values are `pending|in_progress|completed|skipped|canceled`',
    CONSTRAINT pk_work_order_task PRIMARY KEY(`work_order_task_id`)
) COMMENT 'Individual task or operation line within a CMMS work order, representing a discrete step in the maintenance activity sequence. Captures task number, task description, task type (inspection, lubrication, replacement, adjustment, cleaning, testing), assigned technician, planned duration, actual duration, task status (pending, in-progress, completed, skipped), sequence number, required skill/trade, safety instructions, tools required, task completion notes, and actual completion timestamp. Enables granular tracking of multi-step maintenance procedures and supports labor time reporting at the task level.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` (
    `pm_plan_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance plan.',
    `asset_group_id` BIGINT COMMENT 'Identifier of the asset group (e.g., production line) the plan applies to when not asset-specific.',
    `asset_id` BIGINT COMMENT 'Identifier of the specific equipment asset this plan applies to.',
    `crew_id` BIGINT COMMENT 'Identifier of the maintenance crew responsible for executing the plan.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external vendor responsible for the maintenance, if applicable.',
    `work_order_template_id` BIGINT COMMENT 'Reference to the work order template used when generating work orders from this plan.',
    `parent_pm_plan_id` BIGINT COMMENT 'Self-referencing FK on pm_plan (parent_pm_plan_id)',
    `budgeted_annual_cost` DECIMAL(18,2) COMMENT 'Annual budget allocated for this maintenance plan.',
    `calibration_required` BOOLEAN COMMENT 'Indicates if calibration of the equipment is required as part of this plan.',
    `compliance_requirement` STRING COMMENT 'Regulatory compliance requirement(s) applicable to the maintenance activity (e.g., FDA|USDA|ISO22000). [ENUM-REF-CANDIDATE: FDA|USDA|ISO22000|GFSI|EFSA|EPA|FTC|ISO9001|FSSC22000 — promote to reference product]',
    `condition_monitoring_parameter` STRING COMMENT 'Name of the condition monitoring parameter (e.g., vibration, temperature) used for condition-based plans.',
    `condition_threshold_unit` STRING COMMENT 'Unit of the condition threshold value (e.g., mm/s, °C).',
    `condition_threshold_value` DECIMAL(18,2) COMMENT 'Threshold value for the condition monitoring parameter that triggers maintenance.',
    `cost_center_code` STRING COMMENT 'Cost center associated with the maintenance expenses.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the maintenance plan record was created.',
    `cycle_unit` STRING COMMENT 'Unit of measurement for the maintenance_cycle.. Valid values are `days|weeks|months|years|hours|cycles`',
    `documentation_reference` STRING COMMENT 'Link or identifier to the detailed maintenance procedure documentation.',
    `effective_end_date` DATE COMMENT 'Date when the plan expires or is decommissioned (nullable if open-ended).',
    `effective_start_date` DATE COMMENT 'Date when the plan becomes effective.',
    `estimated_labor_hours_per_cycle` DECIMAL(18,2) COMMENT 'Estimated labor hours required to execute the maintenance task each cycle.',
    `estimated_material_cost_per_cycle` DECIMAL(18,2) COMMENT 'Estimated material cost associated with each maintenance cycle.',
    `is_external_vendor` BOOLEAN COMMENT 'Indicates whether external vendor services are required for this plan.',
    `last_execution_date` DATE COMMENT 'Date when the plan was last executed.',
    `last_modified_by` STRING COMMENT 'User identifier who last modified the plan record.',
    `lead_time_days` STRING COMMENT 'Number of days required to schedule resources before the maintenance date.',
    `maintenance_cycle` STRING COMMENT 'Number of cycles between scheduled maintenance events (e.g., 30 days, 500 operating hours).',
    `maintenance_strategy` STRING COMMENT 'Strategic approach for the maintenance activities defined by the plan.. Valid values are `preventive|predictive|reliability_centered`',
    `next_due_date` DATE COMMENT 'Date when the next scheduled maintenance is due.',
    `plan_code` STRING COMMENT 'External reference code for the maintenance plan (e.g., PM-2023-001).',
    `plan_description` STRING COMMENT 'Detailed description of the maintenance plan, including scope and objectives.',
    `plan_name` STRING COMMENT 'Descriptive name of the preventive maintenance plan.',
    `plan_status` STRING COMMENT 'Current operational status of the maintenance plan.. Valid values are `active|inactive|suspended|retired`',
    `plan_type` STRING COMMENT 'Indicates whether the plan is triggered by time, equipment usage counter, or condition monitoring.. Valid values are `time_based|counter_based|condition_based`',
    `priority_level` STRING COMMENT 'Priority of the maintenance plan for scheduling purposes.. Valid values are `low|medium|high|critical`',
    `required_spare_parts` STRING COMMENT 'List or reference to spare parts required for the maintenance task.',
    `safety_risk_level` STRING COMMENT 'Indicates the safety risk associated with the maintenance activity.. Valid values are `low|moderate|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the maintenance plan record.',
    `created_by` STRING COMMENT 'User identifier who created the plan record.',
    CONSTRAINT pk_pm_plan PRIMARY KEY(`pm_plan_id`)
) COMMENT 'Preventive maintenance plan master record defining the scheduled maintenance strategy for an asset or group of assets in F&B facilities. Captures PM plan ID, plan name, plan type (time-based, counter-based, condition-based), maintenance strategy, asset or asset group reference, maintenance cycle (daily, weekly, monthly, quarterly, annual, runtime hours, production cycles), cycle unit, plan description, work order template reference, estimated labor hours per cycle, estimated material cost per cycle, plan status (active, inactive, suspended), next due date, last execution date, lead time for scheduling, and responsible maintenance crew. Drives automatic work order generation in CMMS/SAP PM.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record.',
    `asset_id` BIGINT COMMENT 'Identifier of the equipment or asset to be maintained.',
    `compliance_document_id` BIGINT COMMENT 'Reference to the compliance document associated with this maintenance schedule.',
    `employee_id` BIGINT COMMENT 'Identifier of the primary technician or crew assigned to perform the maintenance.',
    `plant_id` BIGINT COMMENT 'Identifier of the plant or facility where the maintenance will occur.',
    `pm_plan_id` BIGINT COMMENT 'Reference to the preventive maintenance plan that generated this schedule.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order generated from this maintenance schedule.',
    `rescheduled_pm_schedule_id` BIGINT COMMENT 'Self-referencing FK on pm_schedule (rescheduled_pm_schedule_id)',
    `actual_completion_date` DATE COMMENT 'Date on which the maintenance work was actually completed.',
    `actual_duration_minutes` STRING COMMENT 'Actual time taken to complete the maintenance activity.',
    `approval_status` STRING COMMENT 'Current approval state of the maintenance schedule.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule was approved or rejected.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the maintenance activity met regulatory or internal compliance requirements.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual cost incurred for the maintenance activity.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Projected cost for performing the maintenance activity.',
    `counter_reading` DECIMAL(18,2) COMMENT 'Equipment counter (e.g., runtime hours) recorded at the time the schedule was created.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter currency code for cost fields.',
    `downtime_minutes` STRING COMMENT 'Total production downtime incurred due to the maintenance activity.',
    `equipment_condition` STRING COMMENT 'Condition of the equipment at the time of scheduling.. Valid values are `good|fair|poor|critical`',
    `estimated_duration_minutes` STRING COMMENT 'Planned duration of the maintenance activity in minutes.',
    `is_out_of_service` BOOLEAN COMMENT 'True if the equipment is taken out of service pending maintenance.',
    `is_recurring` BOOLEAN COMMENT 'True if the schedule repeats on a regular interval.',
    `last_counter_reading` DECIMAL(18,2) COMMENT 'Most recent equipment counter value prior to this schedule.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection prior to this schedule.',
    `last_updated_by` STRING COMMENT 'User identifier who last modified the schedule record.',
    `maintenance_category` STRING COMMENT 'Broad category describing the nature of the maintenance.. Valid values are `routine|emergency|scheduled`',
    `maintenance_type` STRING COMMENT 'Classification of the maintenance work (preventive, corrective, or predictive).. Valid values are `preventive|corrective|predictive`',
    `next_due_counter` DECIMAL(18,2) COMMENT 'Counter value at which the next preventive maintenance is due.',
    `next_inspection_due_date` DATE COMMENT 'Planned date for the next required inspection after this maintenance.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or instructions related to the maintenance activity.',
    `overdue_days` STRING COMMENT 'Number of days the schedule is past its planned date without completion.',
    `pm_schedule_status` STRING COMMENT 'Current lifecycle status of the maintenance schedule.. Valid values are `open|completed|overdue|skipped|cancelled`',
    `priority` STRING COMMENT 'Priority level assigned to the maintenance activity.. Valid values are `low|medium|high|critical`',
    `recurrence_interval_days` STRING COMMENT 'Number of days between recurring maintenance occurrences.',
    `required_spare_parts` STRING COMMENT 'Comma‑separated list of spare parts needed for the maintenance.',
    `safety_risk_level` STRING COMMENT 'Risk classification for safety associated with the maintenance activity.. Valid values are `low|medium|high`',
    `schedule_number` STRING COMMENT 'Human‑readable business identifier for the maintenance schedule.',
    `schedule_source` STRING COMMENT 'Origin of the schedule creation – either generated automatically by the system or entered manually.. Valid values are `system_generated|manual`',
    `scheduled_date` DATE COMMENT 'Planned calendar date for the preventive maintenance activity.',
    `scheduling_basis` STRING COMMENT 'Basis used to trigger the schedule (calendar date, runtime hours, or production count).. Valid values are `calendar|runtime|production_count`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    `created_by` STRING COMMENT 'User identifier who initially created the schedule record.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Individual scheduled maintenance call generated from a PM plan, representing a specific upcoming or completed preventive maintenance event for an asset. Captures schedule ID, PM plan reference, asset reference, scheduled date, actual completion date, work order generated reference, schedule status (open, completed, overdue, skipped, cancelled), counter reading at scheduling, scheduling basis (calendar, runtime, production count), and overdue days. Provides the operational calendar view of all upcoming PM activities across the facility and enables compliance tracking against the PM plan.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`failure_record` (
    `failure_record_id` BIGINT COMMENT 'Unique identifier for the failure record.',
    `asset_id` BIGINT COMMENT 'Unique identifier of the equipment or asset that experienced the failure.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who reported the failure.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Failure records capture the exact storage location of the affected asset; needed for the Failure Impact Analysis.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order created to address the failure.',
    `root_cause_failure_record_id` BIGINT COMMENT 'Self-referencing FK on failure_record (root_cause_failure_record_id)',
    `comments` STRING COMMENT 'Free‑form notes or observations related to the failure.',
    `compliance_status` STRING COMMENT 'Current compliance status of the failure remediation with regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `corrective_action` STRING COMMENT 'Description of the corrective action taken to resolve the failure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the failure record was first created in the system.',
    `detection_method` STRING COMMENT 'Method by which the failure was identified.. Valid values are `operator_report|sensor_alarm|inspection|predictive_alert`',
    `downtime_end` TIMESTAMP COMMENT 'Timestamp when the equipment was returned to service.',
    `downtime_start` TIMESTAMP COMMENT 'Timestamp when the equipment was taken out of service.',
    `failure_cause` STRING COMMENT 'Root cause that triggered the failure.. Valid values are `wear|fatigue|corrosion|contamination|misalignment|operator_error`',
    `failure_effect` STRING COMMENT 'Impact of the failure on production output.. Valid values are `no_impact|minor_slowdown|line_stoppage|plant_shutdown`',
    `failure_mode` STRING COMMENT 'Technical classification of how the failure manifested.. Valid values are `mechanical|electrical|instrumentation|process|human_error`',
    `failure_number` STRING COMMENT 'Human‑readable sequential number assigned to the failure event.',
    `failure_record_status` STRING COMMENT 'Current lifecycle status of the failure record.. Valid values are `open|closed|cancelled`',
    `failure_timestamp` TIMESTAMP COMMENT 'Date and time when the failure was first detected.',
    `fmea_reference_code` STRING COMMENT 'Code linking to the associated Failure Mode and Effects Analysis record.',
    `is_safety_incident` BOOLEAN COMMENT 'Indicates whether the failure resulted in a safety incident.',
    `maintenance_type` STRING COMMENT 'Classification of the maintenance action associated with the failure.. Valid values are `preventive|corrective|predictive`',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating time between successive failures for the asset.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair the asset after a failure.',
    `preventive_action` STRING COMMENT 'Planned preventive measure to avoid recurrence of the failure.',
    `priority` STRING COMMENT 'Operational priority for addressing the failure.. Valid values are `low|medium|high`',
    `production_loss_quantity` DECIMAL(18,2) COMMENT 'Quantity of product not produced due to the failure.',
    `regulatory_report_flag` BOOLEAN COMMENT 'True if the failure must be reported to regulatory bodies (e.g., FDA).',
    `root_cause_analysis_status` STRING COMMENT 'Current status of the root‑cause investigation.. Valid values are `not_started|in_progress|completed|deferred`',
    `sensor_code` BIGINT COMMENT 'Identifier of the sensor that generated an alarm, if applicable.',
    `severity_level` STRING COMMENT 'Business‑impact severity assigned to the failure.. Valid values are `low|medium|high|critical`',
    `shift` STRING COMMENT 'Work shift during which the failure occurred.. Valid values are `day|night|swing`',
    `total_downtime_hours` DECIMAL(18,2) COMMENT 'Calculated total downtime duration in hours.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the failure record.',
    CONSTRAINT pk_failure_record PRIMARY KEY(`failure_record_id`)
) COMMENT 'Structured failure event record capturing the complete details of an asset breakdown or functional failure at an F&B production facility. Captures failure record ID, asset reference, failure date and time, failure detection method (operator report, sensor alarm, inspection, predictive alert), failure mode (mechanical, electrical, instrumentation, process, human error), failure cause (wear, fatigue, corrosion, contamination, misalignment, operator error), failure effect on production (no impact, minor slowdown, line stoppage, plant shutdown), downtime start, downtime end, total downtime hours, production loss quantity, associated work order reference, root cause analysis status, and FMEA reference code. Supports MTBF/MTTR calculation and reliability engineering analysis.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`spare_part` (
    `spare_part_id` BIGINT COMMENT 'System-generated unique identifier for the spare part record.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Inventory of spare parts must record exact warehouse location for maintenance crews; the Spare Part Location Report relies on this FK.',
    `superseded_spare_part_id` BIGINT COMMENT 'Self-referencing FK on spare_part (superseded_spare_part_id)',
    `cmms_material_master_reference` STRING COMMENT 'Identifier linking the spare part to the CMMS material master record.',
    `compatible_asset_references` STRING COMMENT 'Comma‑separated list of asset identifiers that can use this spare part.',
    `compliance_certifications` STRING COMMENT 'List of regulatory or industry certifications applicable to the part (e.g., FDA, GFSI).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the spare part record was first created.',
    `criticality` STRING COMMENT 'Indicates the importance of the part to production continuity.. Valid values are `critical|non-critical|insurance_spare`',
    `dimensions` STRING COMMENT 'Physical dimensions of the part expressed as Length x Width x Height.',
    `disposal_instructions` STRING COMMENT 'Guidance on environmentally compliant disposal of the part.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the part is classified as hazardous under GHS/OSHA regulations.',
    `is_serialized` BOOLEAN COMMENT 'Indicates whether each unit of the part is tracked with a unique serial number.',
    `last_inventory_check_date` DATE COMMENT 'Date of the most recent physical inventory verification for this part.',
    `lead_time_days` STRING COMMENT 'Average procurement lead time in calendar days.',
    `manufacturer_part_number` STRING COMMENT 'Part number assigned by the original equipment manufacturer.',
    `maximum_stock_level` STRING COMMENT 'Maximum quantity allowed in storage to control inventory cost.',
    `minimum_stock_level` STRING COMMENT 'Minimum quantity to be kept on hand to avoid stock‑outs.',
    `oem_part_number` STRING COMMENT 'Original Equipment Manufacturer part number, if different from the internal part number.',
    `part_category` STRING COMMENT 'Classification of the spare part by functional type.. Valid values are `mechanical|electrical|instrumentation|consumable|lubricant|seal_gasket`',
    `part_number` STRING COMMENT 'Primary part number used internally to identify the spare part.',
    `reorder_point` STRING COMMENT 'Inventory level that triggers a replenishment order.',
    `shelf_life_days` STRING COMMENT 'Number of days the part remains usable from receipt, if applicable.',
    `spare_part_description` STRING COMMENT 'Detailed textual description of the spare part, including function and key characteristics.',
    `spare_part_name` STRING COMMENT 'Human‑readable name of the spare part.',
    `spare_part_status` STRING COMMENT 'Current lifecycle status of the spare part.. Valid values are `active|inactive|discontinued|pending`',
    `standard_cost` DECIMAL(18,2) COMMENT 'Baseline cost of the spare part used for valuation and budgeting.',
    `supplier_reference` STRING COMMENT 'Identifier of the preferred supplier for this spare part.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for inventory transactions (e.g., each, kg, liter).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the spare part record.',
    `warranty_period_months` STRING COMMENT 'Manufacturer warranty period expressed in months.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Physical weight of the part, used for logistics and handling.',
    CONSTRAINT pk_spare_part PRIMARY KEY(`spare_part_id`)
) COMMENT 'Master record for all spare parts, replacement components, and maintenance materials stocked for F&B production equipment. Captures spare part ID, part number, part name, part description, manufacturer part number, OEM part number, part category (mechanical, electrical, instrumentation, consumable, lubricant, seal/gasket), unit of measure, criticality (critical, non-critical, insurance spare), lead time (days), minimum stock level, maximum stock level, reorder point, standard cost, storage location, compatible asset references, shelf life (if applicable), hazardous material flag, and CMMS material master reference. SSOT for spare parts identity in the maintenance domain — distinct from inventory.stock_position which tracks quantities.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` (
    `parts_consumption_id` BIGINT COMMENT 'Unique identifier for the parts consumption record.',
    `employee_id` BIGINT COMMENT 'Identifier of the technician who issued the parts.',
    `spare_part_id` BIGINT COMMENT 'Identifier of the spare part or material consumed.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Parts Consumption Log tracks which storage location parts were issued from; required for cost allocation and audit.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external supplier that provided the spare part.',
    `work_order_id` BIGINT COMMENT 'Identifier of the maintenance work order to which the parts consumption belongs.',
    `reversal_parts_consumption_id` BIGINT COMMENT 'Self-referencing FK on parts_consumption (reversal_parts_consumption_id)',
    `batch_number` STRING COMMENT 'Batch identifier of the part, if applicable, for traceability.',
    `consumption_timestamp` TIMESTAMP COMMENT 'Date and time when the part was issued/consumed.',
    `consumption_type` STRING COMMENT 'Classification of the consumption event (preventive maintenance, corrective repair, or emergency).. Valid values are `preventive|corrective|emergency`',
    `cost_center_code` STRING COMMENT 'Financial cost center associated with the consumption for internal accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consumption record was first created in the system.',
    `goods_issue_doc_number` STRING COMMENT 'SAP MIGO document number that records the goods issue transaction.',
    `line_sequence` STRING COMMENT 'Sequential number of the consumption line within the work order.',
    `lot_number` STRING COMMENT 'Lot number for the part, used for quality and regulatory traceability.',
    `notes` STRING COMMENT 'Free‑text field for additional remarks or observations about the consumption.',
    `parts_consumption_status` STRING COMMENT 'Current processing status of the consumption line.. Valid values are `recorded|reversed|adjusted`',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant or facility where the consumption occurred.',
    `purchase_order_number` STRING COMMENT 'Purchase order number linked to the acquisition of the spare part.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of the part consumed, expressed in the selected unit of measure.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost for the line (quantity * unit cost).',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the part at the time of consumption, in the functional currency.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the quantity (e.g., each, kilogram, liter, meter, box).. Valid values are `EA|KG|L|M|BOX`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consumption record.',
    CONSTRAINT pk_parts_consumption PRIMARY KEY(`parts_consumption_id`)
) COMMENT 'Transactional record of spare parts and materials consumed against a maintenance work order at an F&B facility. Captures consumption ID, work order reference, spare part reference, quantity consumed, unit of measure, consumption date, storage location issued from, actual unit cost at time of consumption, total line cost, technician who issued the parts, and goods issue document number (SAP MIGO reference). Enables actual maintenance material cost tracking, spare parts usage history per asset, and drives replenishment signals to the MRO inventory process.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` (
    `calibration_order_id` BIGINT COMMENT 'System-generated unique identifier for the calibration work order.',
    `employee_id` BIGINT COMMENT 'Identifier of the technician or laboratory that performed the calibration.',
    `asset_id` BIGINT COMMENT 'Reference to the calibrated instrument or measurement device asset.',
    `storage_location_id` BIGINT COMMENT 'Reference to the plant or site where calibration was performed.',
    `previous_calibration_order_id` BIGINT COMMENT 'Self-referencing FK on calibration_order (previous_calibration_order_id)',
    `actual_timestamp` TIMESTAMP COMMENT 'Date and time when the calibration was actually performed.',
    `as_found_reading` DECIMAL(18,2) COMMENT 'Instrument reading measured before any adjustment.',
    `as_left_reading` DECIMAL(18,2) COMMENT 'Instrument reading measured after adjustment (if any).',
    `calibration_method` STRING COMMENT 'Method used for calibration (e.g., laboratory, field, on‑line).',
    `calibration_notes` STRING COMMENT 'Free-text notes captured by the technician or lab.',
    `calibration_order_status` STRING COMMENT 'Current lifecycle state of the calibration order.. Valid values are `draft|scheduled|in_progress|completed|cancelled`',
    `calibration_source` STRING COMMENT 'Whether calibration was performed by internal staff or an external provider.. Valid values are `internal|external`',
    `calibration_standard` STRING COMMENT 'Reference standard or traceable artifact used for the calibration.',
    `calibration_type` STRING COMMENT 'Classification of the calibration activity.. Valid values are `routine|as_found|as_left|post_repair|regulatory`',
    `certificate_number` STRING COMMENT 'Identifier of the issued calibration certificate.',
    `corrective_action` STRING COMMENT 'Action taken if calibration failed or was out of tolerance.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost incurred for the calibration activity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the calibration cost.',
    `instrument_serial_number` STRING COMMENT 'Manufacturer-assigned serial number of the instrument.',
    `instrument_type` STRING COMMENT 'Category of the instrument (e.g., flow meter, temperature sensor, pH meter).',
    `measurement_unit` STRING COMMENT 'Unit of measure for the calibration readings (e.g., °C, psi, %).',
    `next_due_date` DATE COMMENT 'Scheduled date for the next required calibration.',
    `procedure_reference` STRING COMMENT 'Identifier of the documented calibration procedure applied.',
    `regulatory_requirement_reference` STRING COMMENT 'Reference to the regulatory clause (e.g., FDA 21 CFR, NIST) governing the calibration.',
    `result` STRING COMMENT 'Outcome of the calibration activity.. Valid values are `pass|fail|adjusted|out_of_tolerance`',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Planned date and time when the calibration is to be performed.',
    `tolerance_lower` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the calibration reading.',
    `tolerance_upper` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the calibration reading.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the calibration order record.',
    CONSTRAINT pk_calibration_order PRIMARY KEY(`calibration_order_id`)
) COMMENT 'Calibration work order and results record for instrumentation and measurement equipment at F&B production facilities — covering flow meters, temperature sensors, pressure gauges, pH meters, checkweighers, and metal detectors. Captures calibration order ID, instrument asset reference, calibration type (routine, as-found/as-left, post-repair, regulatory), calibration standard used, calibration procedure reference, scheduled date, actual calibration date, technician/lab performing calibration, as-found reading, as-left reading, tolerance limits (upper/lower), calibration result (pass, fail, adjusted, out-of-tolerance), next calibration due date, calibration certificate number, regulatory requirement reference (FDA 21 CFR, NIST traceability), and corrective action if failed. Critical for HACCP CCP instrument compliance.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` (
    `calibration_schedule_id` BIGINT COMMENT 'System generated unique identifier for the calibration schedule record.',
    `asset_id` BIGINT COMMENT 'Unique identifier of the instrument or measurement device that requires calibration.',
    `parent_calibration_schedule_id` BIGINT COMMENT 'Self-referencing FK on calibration_schedule (parent_calibration_schedule_id)',
    `calibration_certificate_number` STRING COMMENT 'Identifier of the certificate issued after successful calibration.',
    `calibration_cost` DECIMAL(18,2) COMMENT 'Monetary cost incurred for the calibration activity.',
    `calibration_currency` STRING COMMENT 'Currency of the calibration cost.. Valid values are `USD|EUR|CAD|GBP`',
    `calibration_duration_minutes` STRING COMMENT 'Estimated or actual time required to complete the calibration.',
    `calibration_frequency` STRING COMMENT 'Planned interval at which the instrument must be calibrated.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `calibration_location` STRING COMMENT 'Plant, line, or area where the calibration will be performed.',
    `calibration_method` STRING COMMENT 'Technique used to perform the calibration.. Valid values are `in_house|external|automated`',
    `calibration_notes` STRING COMMENT 'Free‑form comments or observations recorded during calibration.',
    `calibration_responsible_contact` STRING COMMENT 'Email address of the person or lab responsible for the calibration.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `calibration_result` STRING COMMENT 'Outcome of the most recent calibration activity.. Valid values are `pass|fail|out_of_tolerance`',
    `calibration_standard` STRING COMMENT 'Reference standard or protocol applied during calibration.',
    `calibration_standard_version` STRING COMMENT 'Version identifier of the calibration standard used.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration schedule record was created.',
    `instrument_type` STRING COMMENT 'Category of the instrument based on measurement principle.. Valid values are `temperature|pressure|ph|weight|vision|spectrometer`',
    `last_calibration_date` DATE COMMENT 'Date when the instrument was most recently calibrated.',
    `next_due_date` DATE COMMENT 'Scheduled date for the next required calibration.',
    `overdue_alert_threshold_days` STRING COMMENT 'Number of days past the due date after which an overdue alert is generated.',
    `regulatory_basis` STRING COMMENT 'Regulatory or audit requirement that drives the calibration.. Valid values are `HACCP_CCP|FDA|USDA|Customer_Audit|GFSI`',
    `responsible_party` STRING COMMENT 'Entity responsible for executing the calibration.. Valid values are `internal_lab|external_lab`',
    `schedule_status` STRING COMMENT 'Current operational state of the calibration schedule.. Valid values are `active|suspended|decommissioned`',
    `tolerance_specification` STRING COMMENT 'Acceptable deviation limits for the instrument measurement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the calibration schedule record.',
    CONSTRAINT pk_calibration_schedule PRIMARY KEY(`calibration_schedule_id`)
) COMMENT 'Master calibration schedule defining the required calibration frequency and parameters for each instrument or measurement device at F&B facilities. Captures schedule ID, instrument asset reference, calibration frequency (daily, weekly, monthly, quarterly, annual), calibration method, responsible party (internal lab, external accredited lab), calibration standard required, tolerance specification, regulatory basis (HACCP CCP, FDA, USDA, customer audit requirement), schedule status (active, suspended, decommissioned), last calibration date, next due date, and overdue alert threshold (days). Ensures all HACCP-critical instruments maintain current calibration status.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`crew` (
    `crew_id` BIGINT COMMENT 'System-generated unique identifier for the maintenance crew.',
    `plant_id` BIGINT COMMENT 'Identifier of the plant/facility where the crew is based.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the crew lead or supervisor.',
    `parent_crew_id` BIGINT COMMENT 'Self-referencing FK on crew (parent_crew_id)',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Percentage of scheduled time the crew is available (e.g., 92.5).',
    `average_mttr_minutes` DECIMAL(18,2) COMMENT 'Mean Time To Repair for tasks completed by the crew, expressed in minutes.',
    `capacity_hours_per_shift` DECIMAL(18,2) COMMENT 'Standard number of labor hours the crew can deliver in a single shift.',
    `certifications` STRING COMMENT 'Comma‑separated list of certifications held by the crew (e.g., "Electrical Safety, Confined Space").',
    `cost_center_code` STRING COMMENT 'Financial cost‑center to which crew labor costs are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the crew record was first created in the system.',
    `crew_code` STRING COMMENT 'Business‑assigned code used for scheduling and reporting (e.g., "MC‑001").',
    `crew_name` STRING COMMENT 'Human‑readable name of the crew (e.g., "North Plant Mechanical Team").',
    `crew_status` STRING COMMENT 'Current lifecycle status of the crew.. Valid values are `active|inactive|suspended|pending`',
    `crew_type` STRING COMMENT 'Category of work the crew primarily performs.. Valid values are `mechanical|electrical|instrumentation|utilities|general|contractor`',
    `effective_end_date` DATE COMMENT 'Date when the crew was retired or de‑activated (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the crew became operationally active.',
    `last_assigned_date` DATE COMMENT 'Most recent date the crew was assigned to a work order.',
    `next_available_date` DATE COMMENT 'Projected date when the crew will be free for new assignments.',
    `notes` STRING COMMENT 'Free‑form remarks or operational notes about the crew.',
    `shift_assignment` STRING COMMENT 'Typical shift pattern the crew works.. Valid values are `day|night|rotating`',
    `skill_specializations` STRING COMMENT 'Comma‑separated list of primary skill areas (e.g., "HVAC, PLC, Welding").',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the crew record.',
    CONSTRAINT pk_crew PRIMARY KEY(`crew_id`)
) COMMENT 'Master record for maintenance crews, teams, and work groups organized within F&B production facilities. Captures crew ID, crew name, crew type (mechanical, electrical, instrumentation, utilities, general maintenance, contractor crew), home plant/facility, crew lead employee reference, crew capacity (standard hours per shift), shift assignment, skill specializations, certifications held by crew (electrical safety, confined space, pressure vessel), active status, and cost center assignment. Used for work order assignment, capacity planning, and maintenance labor scheduling. References workforce.employee for individual technician identity.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` (
    `permit_to_work_id` BIGINT COMMENT 'System-generated unique identifier for the permit to work record.',
    `asset_id` BIGINT COMMENT 'Identifier of the equipment or location where the work will be performed.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who requested the permit.',
    `quaternary_permit_updated_by_user_employee_id` BIGINT COMMENT 'System user who last updated the permit record.',
    `quinary_permit_approved_by_employee_id` BIGINT COMMENT 'Identifier of the person who approved the permit.',
    `tertiary_permit_created_by_user_employee_id` BIGINT COMMENT 'System user who created the permit record.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order associated with the permit.',
    `parent_permit_to_work_id` BIGINT COMMENT 'Self-referencing FK on permit_to_work (parent_permit_to_work_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the permit was approved.',
    `closure_signoff_name` STRING COMMENT 'Name of the person who signed off the permit closure.',
    `closure_signoff_timestamp` TIMESTAMP COMMENT 'Timestamp of the closure sign‑off.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit record was first created in the system.',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of an emergency.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the emergency contact.',
    `gas_test_result` STRING COMMENT 'Result of atmospheric gas testing performed before work begins.. Valid values are `pass|fail|not_applicable`',
    `gas_test_timestamp` TIMESTAMP COMMENT 'Date and time when the gas test was performed.',
    `gas_test_value_ppm` DECIMAL(18,2) COMMENT 'Measured concentration of hazardous gas in parts per million.',
    `hazard_description` STRING COMMENT 'Narrative description of hazards identified for the work.',
    `isolation_confirmed` BOOLEAN COMMENT 'Indicates whether all required isolation points have been verified.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the permit.',
    `permit_closure_timestamp` TIMESTAMP COMMENT 'Date and time when the permit was formally closed.',
    `permit_duration_hours` DECIMAL(18,2) COMMENT 'Calculated duration between permit start and expiry, expressed in hours.',
    `permit_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the permit expires.',
    `permit_number` STRING COMMENT 'External reference number assigned to the permit, used in operational documentation.',
    `permit_revision_number` STRING COMMENT 'Sequential revision number for the permit record.',
    `permit_start_timestamp` TIMESTAMP COMMENT 'Date and time when the permit becomes active.',
    `permit_to_work_status` STRING COMMENT 'Current lifecycle status of the permit.. Valid values are `requested|approved|active|suspended|closed|cancelled`',
    `permit_type` STRING COMMENT 'Category of high‑risk activity covered by the permit.. Valid values are `hot_work|confined_space|loto|cold_work|chemical|height`',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the permit request was submitted.',
    `required_ppe` STRING COMMENT 'List of PPE items that must be used during the activity.',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the permit activity.. Valid values are `low|medium|high`',
    `temperature_monitoring_required` BOOLEAN COMMENT 'Indicates if temperature monitoring is required for the work.',
    `temperature_reading_celsius` DECIMAL(18,2) COMMENT 'Recorded temperature in Celsius at the work site, if monitored.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the permit record.',
    CONSTRAINT pk_permit_to_work PRIMARY KEY(`permit_to_work_id`)
) COMMENT 'Safety permit-to-work (PTW) record authorizing high-risk maintenance activities at F&B production facilities — covering hot work, confined space entry, electrical isolation (LOTO), working at height, and chemical handling. Captures permit ID, permit type (hot work, confined space, LOTO/electrical, cold work, chemical, height), associated work order reference, asset/location reference, permit requestor, permit issuer (authorized person), permit start date/time, permit expiry date/time, permit status (requested, approved, active, suspended, closed, cancelled), hazard identification, required PPE, isolation points confirmed flag, gas test results (if applicable), emergency contact, and permit closure sign-off. Mandatory for OSHA compliance and insurance requirements.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` (
    `reliability_event_id` BIGINT COMMENT 'System-generated unique identifier for the reliability engineering event.',
    `asset_id` BIGINT COMMENT 'Unique identifier of the equipment or asset associated with the event.',
    `follow_up_reliability_event_id` BIGINT COMMENT 'Self-referencing FK on reliability_event (follow_up_reliability_event_id)',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual cost incurred for the maintenance changes, in US dollars.',
    `compliance_status` STRING COMMENT 'Current compliance status of the asset after the event.. Valid values are `compliant|non_compliant|pending`',
    `cost_currency` STRING COMMENT 'Currency code of the cost values.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Projected cost to implement the recommended maintenance changes, in US dollars.',
    `event_date` TIMESTAMP COMMENT 'Date and time when the reliability activity occurred.',
    `event_trigger` STRING COMMENT 'Reason that initiated the reliability event.. Valid values are `recurring_failure|new_asset|regulatory_requirement|cost_threshold_breach`',
    `event_type` STRING COMMENT 'Category of reliability activity performed (e.g., RCM analysis, FMEA, etc.).. Valid values are `rcm_analysis|fmea|bad_actor_review|reliability_improvement|root_cause_analysis`',
    `expected_mtbf_improvement_hours` DECIMAL(18,2) COMMENT 'Projected increase in mean time between failures expressed in hours.',
    `facilitator_name` STRING COMMENT 'Name of the person who facilitated the reliability event.',
    `findings_summary` STRING COMMENT 'Brief summary of key findings from the reliability analysis.',
    `follow_up_action_refs` STRING COMMENT 'Identifiers of follow‑up actions or work orders linked to this event.',
    `implementation_status` STRING COMMENT 'Current status of implementing the recommended strategy.. Valid values are `planned|in_progress|completed|deferred|cancelled`',
    `maintenance_strategy_change` STRING COMMENT 'Detailed description of the maintenance strategy alteration.',
    `mtbf_after` DECIMAL(18,2) COMMENT 'Mean time between failures measured after the event.',
    `mtbf_before` DECIMAL(18,2) COMMENT 'Mean time between failures measured before the event.',
    `mtbf_improvement_percent` DECIMAL(18,2) COMMENT 'Percentage improvement in MTBF resulting from the event.',
    `participants` STRING COMMENT 'Comma‑separated list of participants involved in the event.',
    `priority` STRING COMMENT 'Priority of the reliability event for execution planning.. Valid values are `low|medium|high`',
    `recommended_strategy` STRING COMMENT 'Suggested maintenance strategy change based on the event findings.. Valid values are `preventive|predictive|corrective|none`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the reliability event record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reliability event record.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether the event was driven by a regulatory requirement.',
    `risk_assessment` STRING COMMENT 'Risk level assigned to the asset based on the event analysis.. Valid values are `low|medium|high|critical`',
    CONSTRAINT pk_reliability_event PRIMARY KEY(`reliability_event_id`)
) COMMENT 'Asset reliability program event record capturing planned and executed reliability engineering activities — RCM (Reliability Centered Maintenance) analyses, FMEA reviews, bad actor investigations, and reliability improvement initiatives for F&B production assets. Captures event ID, event type (RCM analysis, FMEA, bad actor review, reliability improvement project, root cause analysis), asset or asset group reference, event trigger (recurring failure, new asset, regulatory requirement, cost threshold breach), event date, facilitator, participants, findings summary, recommended maintenance strategy changes, implementation status, expected MTBF improvement, and follow-up action references. Drives continuous improvement of the PM program.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` (
    `asset_condition_id` BIGINT COMMENT 'Unique surrogate key for each asset condition assessment entry.',
    `asset_id` BIGINT COMMENT 'Unique identifier of the manufacturing equipment or asset whose condition is being recorded.',
    `employee_id` BIGINT COMMENT 'Identifier of the person (e.g., technician or engineer) who performed the assessment.',
    `previous_asset_condition_id` BIGINT COMMENT 'Self-referencing FK on asset_condition (previous_asset_condition_id)',
    `assessment_notes` STRING COMMENT 'Additional comments or contextual information captured by the assessor.',
    `assessment_timestamp` TIMESTAMP COMMENT 'Date and time when the condition assessment was performed.',
    `condition_score` DECIMAL(18,2) COMMENT 'Numeric score representing overall asset health; can be a 1‑5 rating or a percentage.',
    `condition_status` STRING COMMENT 'Categorical health status derived from the condition score.. Valid values are `good|fair|poor|critical`',
    `findings_text` STRING COMMENT 'Free‑text description of any notable observations or anomalies identified during the assessment.',
    `method` STRING COMMENT 'Technique used to evaluate the asset condition, such as visual inspection or vibration analysis.. Valid values are `visual_inspection|vibration_analysis|thermography|oil_analysis|ultrasound|motor_current_analysis`',
    `next_assessment_due_date` DATE COMMENT 'Planned date for the subsequent condition assessment.',
    `oil_contamination_level` STRING COMMENT 'Qualitative or numeric indicator of oil cleanliness from oil analysis.',
    `recommended_action` STRING COMMENT 'Prescribed next step based on the assessment outcome.. Valid values are `monitor|schedule_pm|immediate_repair|plan_replacement`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the condition record was initially created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the condition record.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature reading in degrees Celsius from thermography or sensor.',
    `vibration_level_mm_s` DECIMAL(18,2) COMMENT 'Measured vibration amplitude in millimeters per second, captured during vibration analysis.',
    CONSTRAINT pk_asset_condition PRIMARY KEY(`asset_condition_id`)
) COMMENT 'Periodic asset condition assessment record capturing the physical health and condition state of F&B production equipment through inspections, condition monitoring, and predictive maintenance technologies. Captures condition record ID, asset reference, assessment date, assessment method (visual inspection, vibration analysis, thermography, oil analysis, ultrasound, motor current analysis), condition score (1-5 scale or percentage), condition status (good, fair, poor, critical), specific findings (vibration level mm/s, temperature reading °C, oil contamination level), recommended action (monitor, schedule PM, immediate repair, plan replacement), next assessment due date, and assessor reference. Feeds predictive maintenance triggers and asset replacement planning.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` (
    `maintenance_contract_id` BIGINT COMMENT 'System-generated unique identifier for the maintenance contract record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Contract Billing Report links each maintenance contract to the customer account for invoicing and SLA compliance.',
    `bill_to_location_id` BIGINT COMMENT 'Foreign key linking to customer.bill_to_location. Business justification: Billing address for a maintenance contract must reference the customers bill‑to location for accurate invoicing.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external service provider (references procurement.supplier).',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Maintenance service contracts are often tied to the underlying procurement contract; linking enables consolidated contract compliance reporting.',
    `retailer_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.retailer_agreement. Business justification: Retailer agreements often include equipment‑maintenance clauses; linking contracts to agreements supports compliance reporting and joint budgeting.',
    `renewed_maintenance_contract_id` BIGINT COMMENT 'Self-referencing FK on maintenance_contract (renewed_maintenance_contract_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the contract was formally approved by authorized signatories.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at expiry.',
    `compliance_requirements` STRING COMMENT 'Regulatory or industry compliance clauses attached to the contract (e.g., FDA, GFSI).',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether the contract contains confidential information.',
    `confidentiality_level` STRING COMMENT 'Classification level of the contract content.. Valid values are `restricted|confidential|internal|public`',
    `contract_name` STRING COMMENT 'Descriptive name of the maintenance contract.',
    `contract_number` STRING COMMENT 'External reference number or code assigned to the contract by the organization.',
    `contract_type` STRING COMMENT 'Category of the maintenance agreement (e.g., Annual Maintenance Contract, OEM Service Agreement, Time‑and‑Material, Fixed‑Price, SLA‑Based).. Valid values are `amc|oem|time_and_material|fixed_price|sla_based`',
    `contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the contract as agreed with the service provider.',
    `covered_asset_category` STRING COMMENT 'Category or classification of equipment/assets covered (e.g., Production Line, HVAC, Elevator).',
    `covered_asset_ids` STRING COMMENT 'Comma‑separated list of asset identifiers that the contract applies to.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the contract value (e.g., USD, EUR).',
    `document_url` STRING COMMENT 'Link to the stored contract document (PDF, scanned copy, etc.).',
    `end_date` DATE COMMENT 'Date on which the contract expires or terminates (null for open‑ended).',
    `exclusions` STRING COMMENT 'Specific services or items not covered by the contract.',
    `maintenance_contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `active|expired|terminated|pending_renewal|draft`',
    `payment_terms` STRING COMMENT 'Standard payment terms for the contract (e.g., Net 30, 2% 10 Net 30).',
    `regulatory_approval_status` STRING COMMENT 'Current status of required regulatory approvals for the contract.. Valid values are `approved|pending|rejected`',
    `renewal_notice_date` DATE COMMENT 'Date by which a renewal notice must be issued to avoid lapse.',
    `resolution_time_sla_minutes` STRING COMMENT 'Maximum time in minutes to resolve a reported issue after response.',
    `response_time_sla_minutes` STRING COMMENT 'Maximum time in minutes for the provider to respond to an emergency request.',
    `scope_of_services` STRING COMMENT 'Detailed description of services covered under the contract.',
    `start_date` DATE COMMENT 'Date on which the contract becomes binding.',
    `termination_notice_period_days` STRING COMMENT 'Number of days notice required for early termination.',
    `termination_notice_required` BOOLEAN COMMENT 'Indicates whether a formal notice is required to terminate the contract early.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the contract record.',
    CONSTRAINT pk_maintenance_contract PRIMARY KEY(`maintenance_contract_id`)
) COMMENT 'Master record for external maintenance service contracts and OEM service agreements covering F&B production equipment — including annual maintenance contracts (AMC), OEM service agreements, elevator/HVAC service contracts, and specialist contractor agreements. Captures contract ID, contract name, contract type (AMC, OEM service, time-and-material, fixed-price, SLA-based), service provider (references procurement.supplier), covered assets or asset categories, contract start date, contract end date, contract value, payment terms, response time SLA (emergency, urgent, normal), resolution time SLA, scope of services, exclusions, auto-renewal flag, contract status (active, expired, terminated, pending renewal), and contract document reference. Distinct from procurement.purchase_contract which covers raw material sourcing.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` (
    `contractor_visit_id` BIGINT COMMENT 'System-generated unique identifier for each contractor visit record.',
    `maintenance_contract_id` BIGINT COMMENT 'Identifier of the maintenance contract governing the visit.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the external contractor or OEM service provider.',
    `work_order_id` BIGINT COMMENT 'Identifier of the work order associated with the visit.',
    `follow_up_contractor_visit_id` BIGINT COMMENT 'Self-referencing FK on contractor_visit (follow_up_contractor_visit_id)',
    `arrival_timestamp` TIMESTAMP COMMENT 'Date and time when the contractor arrived on site.',
    `contractor_visit_status` STRING COMMENT 'Current lifecycle state of the visit.. Valid values are `scheduled|in_progress|completed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the visit record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.. Valid values are `USD|EUR|CAD|GBP|JPY`',
    `departure_timestamp` TIMESTAMP COMMENT 'Date and time when the contractor left the site.',
    `findings` STRING COMMENT 'Observations, issues, or anomalies identified during the visit.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount billed before taxes, discounts, or adjustments.',
    `invoice_reference` STRING COMMENT 'External invoice number or reference linked to the visit for billing.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes and adjustments.',
    `parts_replaced` STRING COMMENT 'List of parts or components replaced, including part numbers and quantities.',
    `ppe_compliance_confirmed` BOOLEAN COMMENT 'Indicates whether personal protective equipment compliance was verified.',
    `purpose` STRING COMMENT 'Reason for the contractor visit.. Valid values are `scheduled_pm|emergency_repair|inspection|commissioning|warranty_repair`',
    `recommendations` STRING COMMENT 'Suggested actions or follow‑up activities based on the findings.',
    `site_induction_completed` BOOLEAN COMMENT 'Indicates whether the contractor completed the required site safety induction.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the gross amount.',
    `technician_certification` STRING COMMENT 'Certification or qualification held by the technician relevant to the work performed.',
    `technician_name` STRING COMMENT 'Full name of the external technician performing the work.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the visit record.',
    `visit_number` STRING COMMENT 'External reference number assigned to the contractor visit, used in communications and reporting.',
    `visit_timestamp` TIMESTAMP COMMENT 'Date and time when the contractor visit officially started.',
    `work_acceptance_signoff` BOOLEAN COMMENT 'Flag indicating that the site owner accepted the completed work.',
    `work_description` STRING COMMENT 'Narrative description of the work performed during the visit.',
    CONSTRAINT pk_contractor_visit PRIMARY KEY(`contractor_visit_id`)
) COMMENT 'Transactional record for external contractor and OEM service technician visits to F&B production facilities for maintenance, repair, and inspection activities. Captures visit ID, contractor/supplier reference, maintenance contract reference, associated work order reference, visit purpose (scheduled PM, emergency repair, inspection, commissioning, warranty repair), visit date, arrival time, departure time, technician name and certification, work performed description, parts replaced, findings and recommendations, site induction completed flag, PPE compliance confirmed flag, work acceptance sign-off, and invoice reference. Supports contractor management, site safety compliance, and service cost tracking.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` (
    `shutdown_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the shutdown plan.',
    `facility_plant_id` BIGINT COMMENT 'Identifier of the facility/plant where the shutdown will occur.',
    `plant_id` BIGINT COMMENT 'Identifier of the specific plant within the facility.',
    `previous_shutdown_plan_id` BIGINT COMMENT 'Self-referencing FK on shutdown_plan (previous_shutdown_plan_id)',
    `actual_end_date` DATE COMMENT 'Real end date when the shutdown completed.',
    `actual_start_date` DATE COMMENT 'Real start date when the shutdown began.',
    `approval_status` STRING COMMENT 'Current approval state of the shutdown plan.. Valid values are `pending|approved|rejected`',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the shutdown plan.. Valid values are `compliant|non_compliant|pending`',
    `coordinator_name` STRING COMMENT 'Name of the person responsible for coordinating the shutdown.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shutdown plan record was created.',
    `notes` STRING COMMENT 'Additional notes or comments captured by planners.',
    `plan_code` STRING COMMENT 'Business code used to reference the shutdown plan in external systems.',
    `planned_end_date` DATE COMMENT 'Scheduled end date for the shutdown (date only).',
    `planned_start_date` DATE COMMENT 'Scheduled start date for the shutdown (date only).',
    `regulatory_inspection_required` BOOLEAN COMMENT 'Indicates whether a regulatory inspection is required during the shutdown.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk rating (0‑100) for the shutdown based on safety, cost, and schedule impact.',
    `safety_review_completed` BOOLEAN COMMENT 'Flag indicating if a safety review has been completed prior to shutdown execution.',
    `shutdown_plan_description` STRING COMMENT 'Free‑form description providing context or details about the shutdown.',
    `shutdown_plan_name` STRING COMMENT 'Human‑readable name of the shutdown plan.',
    `shutdown_plan_status` STRING COMMENT 'Current lifecycle status of the shutdown plan.. Valid values are `planning|approved|in_progress|completed|cancelled`',
    `shutdown_plan_type` STRING COMMENT 'Category of the shutdown (e.g., annual overhaul, seasonal changeover).. Valid values are `annual_overhaul|seasonal_changeover|capital_project|regulatory_inspection|deep_clean`',
    `total_actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred for the shutdown.',
    `total_actual_downtime_hours` DECIMAL(18,2) COMMENT 'Actual downtime hours incurred during the shutdown.',
    `total_planned_cost` DECIMAL(18,2) COMMENT 'Budgeted cost for the shutdown (currency assumed local).',
    `total_planned_downtime_hours` DECIMAL(18,2) COMMENT 'Total number of downtime hours planned for the shutdown.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shutdown plan record.',
    `work_order_count` STRING COMMENT 'Number of work orders associated with the shutdown.',
    CONSTRAINT pk_shutdown_plan PRIMARY KEY(`shutdown_plan_id`)
) COMMENT 'Master record for planned plant shutdowns, turnarounds, and major overhaul events at F&B production facilities — annual shutdowns, seasonal changeovers, and major capital maintenance windows. Captures shutdown plan ID, shutdown name, shutdown type (annual overhaul, seasonal changeover, capital project, regulatory inspection, deep clean), facility/plant reference, planned start date, planned end date, actual start date, actual end date, shutdown status (planning, approved, in-progress, completed, cancelled), total planned downtime hours, total actual downtime hours, total planned cost, total actual cost, number of work orders included, shutdown coordinator, and approval status. Enables integrated planning of all maintenance activities during production downtime windows.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` (
    `lubrication_route_id` BIGINT COMMENT 'System-generated unique identifier for the lubrication route record.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the route is executed.',
    `crew_id` BIGINT COMMENT 'Identifier of the maintenance crew responsible for executing the route.',
    `parent_lubrication_route_id` BIGINT COMMENT 'Self-referencing FK on lubrication_route (parent_lubrication_route_id)',
    `area_code` STRING COMMENT 'Code of the specific plant area or production line assigned to the route.',
    `average_mechanical_efficiency_pct` DECIMAL(18,2) COMMENT 'Target mechanical efficiency percentage for equipment after lubrication.',
    `created_by_user` STRING COMMENT 'User identifier of the person who created the record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lubrication route record was created.',
    `documentation_reference` STRING COMMENT 'Reference to SOP, work instruction, or external document governing the route.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated total time required to complete the route, expressed in hours.',
    `food_grade_compliance_flag` BOOLEAN COMMENT 'True if the route uses NSF H1/H2 food‑grade lubricants; otherwise false.',
    `frequency` STRING COMMENT 'Planned recurrence interval for the route.. Valid values are `daily|weekly|monthly|quarterly|yearly`',
    `gmp_compliance_flag` BOOLEAN COMMENT 'True if the route complies with GMP requirements.',
    `haccp_control_point` STRING COMMENT 'Indicates whether the route is a critical control point under HACCP.',
    `historical_success_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of past executions that met all quality and safety criteria.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent internal audit of the route.',
    `last_execution_timestamp` TIMESTAMP COMMENT 'Date and time when the route was most recently executed.',
    `lubricant_quantity_per_point_ml` DECIMAL(18,2) COMMENT 'Standard volume of lubricant applied at each point, measured in milliliters.',
    `lubricant_type` STRING COMMENT 'Standard classification of the lubricant used (e.g., synthetic, mineral, semi‑synthetic).',
    `maintenance_strategy` STRING COMMENT 'Strategy applied to the route (e.g., time‑based, condition‑based).',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Average operating time between failures for equipment covered by the route.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time required to repair equipment after a failure.',
    `next_scheduled_timestamp` TIMESTAMP COMMENT 'Planned date and time for the next execution of the route.',
    `nsf_h1_h2_certification` STRING COMMENT 'NSF certification level of the lubricant used on this route.',
    `number_of_points` STRING COMMENT 'Count of individual lubrication points (e.g., bearings, gears) covered by the route.',
    `required_tools` STRING COMMENT 'Comma‑separated list of tools needed to complete the route.',
    `route_code` STRING COMMENT 'Business-assigned alphanumeric code used to reference the lubrication route in work orders and schedules.',
    `route_description` STRING COMMENT 'Detailed description of the purpose, scope, and steps of the lubrication route.',
    `route_name` STRING COMMENT 'Human‑readable name of the lubrication route.',
    `route_status` STRING COMMENT 'Current operational status of the route.. Valid values are `active|suspended|inactive|planned`',
    `route_type` STRING COMMENT 'Indicates whether the route is preventive, corrective, or both.. Valid values are `preventive|corrective|both`',
    `safety_instructions` STRING COMMENT 'Safety precautions and PPE requirements for performing the route.',
    `updated_by_user` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lubrication route record.',
    CONSTRAINT pk_lubrication_route PRIMARY KEY(`lubrication_route_id`)
) COMMENT 'Master record for lubrication routes and rounds defining the structured lubrication program for F&B production equipment — a critical PM sub-program for food-grade lubrication compliance. Captures route ID, route name, route description, plant/area assignment, responsible crew, route frequency (daily, weekly, monthly), estimated duration (hours), number of lube points on route, food-grade lubricant compliance flag (NSF H1/H2 classification), route status (active, suspended), and last execution date. Food-grade lubrication management is a distinct regulatory requirement in F&B manufacturing (NSF H1 lubricants for incidental food contact) that warrants its own master entity.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` (
    `lubrication_event_id` BIGINT COMMENT 'System-generated unique identifier for the lubrication event record.',
    `asset_id` BIGINT COMMENT 'Unique identifier of the equipment or asset receiving lubrication.',
    `lube_point_id` BIGINT COMMENT 'Identifier of the specific lubrication point on the asset.',
    `lubrication_route_id` BIGINT COMMENT 'Identifier of the predefined lubrication route applied to the asset.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the technician who performed the lubrication.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Lubrication events consume lubricants stored in defined locations; linking enables the Lubricant Usage Dashboard.',
    `tertiary_lubrication_updated_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified the lubrication event record.',
    `work_order_id` BIGINT COMMENT 'Identifier of the maintenance work order that includes this lubrication event.',
    `previous_lubrication_event_id` BIGINT COMMENT 'Self-referencing FK on lubrication_event (previous_lubrication_event_id)',
    `application_method` STRING COMMENT 'Method used to apply the lubricant.. Valid values are `grease_gun|oil_can|automatic_lubricator|manual`',
    `batch_number` STRING COMMENT 'Batch identifier of the lubricant for traceability.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the lubrication event met food‑grade compliance requirements.',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action performed if the lube point condition was abnormal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lubrication event record was first created in the system.',
    `event_number` STRING COMMENT 'Human‑readable business number or code assigned to the lubrication event for tracking in maintenance systems.',
    `execution_timestamp` TIMESTAMP COMMENT 'Date and time when the lubrication task was performed.',
    `expiration_date` DATE COMMENT 'Expiration date of the lubricant batch used.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage at the time of lubrication.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the lubrication task is classified as critical for production continuity.',
    `lube_point_condition` STRING COMMENT 'Observed condition of the lubrication point at the time of service.. Valid values are `normal|dry|contaminated|over_lubricated`',
    `lubricant_nsf_classification` STRING COMMENT 'NSF food‑grade classification of the lubricant (H1, H2, 3H, or none).. Valid values are `H1|H2|3H|none`',
    `lubricant_product_name` STRING COMMENT 'Commercial name of the lubricant product used.',
    `lubricant_type` STRING COMMENT 'Category of lubricant applied (e.g., grease, oil, synthetic, food‑grade).. Valid values are `grease|oil|synthetic|food_grade_grease|food_grade_oil`',
    `lubrication_event_status` STRING COMMENT 'Current lifecycle state of the lubrication event.. Valid values are `planned|in_progress|completed|cancelled|deferred`',
    `maintenance_interval_days` STRING COMMENT 'Number of days between scheduled lubrication events for this asset.',
    `next_scheduled_date` DATE COMMENT 'Planned date for the next lubrication event.',
    `notes` STRING COMMENT 'Additional free‑form observations or comments captured by the technician.',
    `quantity_applied` DECIMAL(18,2) COMMENT 'Amount of lubricant applied during the event.',
    `safety_data_sheet_version` STRING COMMENT 'Version identifier of the safety data sheet associated with the lubricant.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature in degrees Celsius at the time of lubrication.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity applied (milliliters, grams, ounces).. Valid values are `ml|g|oz`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the lubrication event record.',
    CONSTRAINT pk_lubrication_event PRIMARY KEY(`lubrication_event_id`)
) COMMENT 'Transactional record capturing the execution of a lubrication route or individual lubrication task at an F&B production facility. Captures event ID, lubrication route reference, asset/lube point reference, execution date, technician reference, lubricant type used (product name, NSF classification H1/H2/3H), quantity applied (ml/g), application method (grease gun, oil can, automatic lubricator), lube point condition observed (normal, dry, contaminated, over-lubricated), corrective action taken, and completion status. Provides the audit trail for food-grade lubrication compliance and supports lubricant consumption tracking.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` (
    `asset_replacement_plan_id` BIGINT COMMENT 'Unique surrogate key for each asset replacement plan record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for overseeing the replacement project.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the asset resides.',
    `asset_id` BIGINT COMMENT 'Identifier of the equipment or asset that the replacement plan targets.',
    `production_line_id` BIGINT COMMENT 'Identifier of the specific production line that uses the asset.',
    `superseded_asset_replacement_plan_id` BIGINT COMMENT 'Self-referencing FK on asset_replacement_plan (superseded_asset_replacement_plan_id)',
    `approval_date` DATE COMMENT 'Date on which the plan received formal approval.',
    `approval_status` STRING COMMENT 'Current approval state of the plan within the capital budgeting process.. Valid values are `proposed|approved|deferred|cancelled`',
    `asset_replacement_plan_status` STRING COMMENT 'Overall lifecycle stage of the replacement plan.. Valid values are `draft|active|completed|archived`',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for the replacement project.',
    `capex_project_reference` STRING COMMENT 'External reference code linking the plan to a capital expenditure project.',
    `comments` STRING COMMENT 'Additional free‑form notes or remarks about the plan.',
    `cost_center_code` STRING COMMENT 'Cost‑center to which the replacement expense will be charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the replacement plan record was first created.',
    `current_asset_age_years` STRING COMMENT 'Age of the existing asset measured in years at the time of plan creation.',
    `depreciation_method` STRING COMMENT 'Accounting depreciation method to be applied to the new asset.. Valid values are `straight_line|double_declining|units_of_production`',
    `depreciation_period_years` STRING COMMENT 'Number of years over which the asset will be depreciated.',
    `effective_from_date` DATE COMMENT 'Date on which the plan becomes effective for budgeting and execution.',
    `effective_until_date` DATE COMMENT 'Optional end date after which the plan is no longer valid.',
    `estimated_refurbishment_cost` DECIMAL(18,2) COMMENT 'Projected cost for refurbishing the existing asset if a refurbishment path is chosen.',
    `estimated_replacement_cost` DECIMAL(18,2) COMMENT 'Projected capital cost required to acquire and install the new asset.',
    `expected_savings_amount` DECIMAL(18,2) COMMENT 'Projected cost savings from the replacement over the assets lifecycle.',
    `funding_source` STRING COMMENT 'Source of capital funding for the replacement.. Valid values are `internal|external|grant`',
    `justification_narrative` STRING COMMENT 'Free‑text explanation of why the replacement is required, including business and operational drivers.',
    `plan_code` STRING COMMENT 'Human‑readable code assigned to the replacement plan for tracking and reference.',
    `planned_replacement_year` STRING COMMENT 'Fiscal year in which the replacement is scheduled to occur.',
    `priority_ranking` STRING COMMENT 'Business‑assigned priority (1 = highest) for the replacement plan.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether the replacement is driven by a regulatory mandate.',
    `remaining_useful_life_years` STRING COMMENT 'Estimated remaining service life of the asset, expressed in years.',
    `replacement_trigger` STRING COMMENT 'Reason that initiates the replacement plan, such as age, condition score threshold, reliability failure, obsolescence, or regulatory requirement.. Valid values are `age|condition_score|reliability_failure|obsolescence|regulatory`',
    `replacement_type` STRING COMMENT 'Category of replacement: like‑for‑like, upgrade, or technology change.. Valid values are `like_for_like|upgrade|technology_change`',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating associated with delaying the replacement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the plan record.',
    CONSTRAINT pk_asset_replacement_plan PRIMARY KEY(`asset_replacement_plan_id`)
) COMMENT 'Capital asset replacement planning record for F&B production equipment reaching end-of-life or requiring major capital refurbishment. Captures plan ID, asset reference, replacement trigger (age, condition score threshold, reliability failure, obsolescence, regulatory requirement), current asset age (years), remaining useful life estimate, replacement type (like-for-like, upgrade, technology change), estimated replacement cost, estimated refurbishment cost (if applicable), planned replacement year, priority ranking, justification narrative, approval status (proposed, approved, deferred, cancelled), capex project reference, and finance fixed asset reference. Feeds the annual capital expenditure planning process and links to finance.fixed_asset for capitalization.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` (
    `maintenance_budget_id` BIGINT COMMENT 'Unique system-generated identifier for each maintenance budget record.',
    `maintenance_contract_id` BIGINT COMMENT 'Foreign key linking to maintenance.maintenance_contract. Business justification: Budgets are often scoped to a maintenance contract; adding maintenance_contract_id captures this association.',
    `parent_maintenance_budget_id` BIGINT COMMENT 'Self-referencing FK on maintenance_budget (parent_maintenance_budget_id)',
    `actual_contractor_cost_ytd` DECIMAL(18,2) COMMENT 'Cumulative external service spend to date.',
    `actual_labor_cost_ytd` DECIMAL(18,2) COMMENT 'Cumulative labor spend incurred to date.',
    `actual_material_cost_ytd` DECIMAL(18,2) COMMENT 'Cumulative spend on parts and consumables to date.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the budget was formally approved.',
    `budget_status` STRING COMMENT 'Current lifecycle state of the budget record.. Valid values are `draft|approved|closed`',
    `budget_type` STRING COMMENT 'Indicates whether the record is an annual plan, a revised forecast, or a rolling 12‑month budget.. Valid values are `annual_plan|revised_forecast|rolling_12_month`',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code responsible for the budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the budget record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency identifier for all monetary amounts.',
    `effective_end_date` DATE COMMENT 'Last calendar day of the budget period.',
    `effective_start_date` DATE COMMENT 'First calendar day of the budget period.',
    `maintenance_category` STRING COMMENT 'Classification of maintenance activity covered by the budget.. Valid values are `preventive|corrective|predictive|shutdown|contractor|spare_parts`',
    `notes` STRING COMMENT 'Optional free‑text comments or remarks about the budget.',
    `planned_contractor_cost` DECIMAL(18,2) COMMENT 'Projected expense for external service contracts.',
    `planned_labor_cost` DECIMAL(18,2) COMMENT 'Projected labor expense for the budget period.',
    `planned_material_cost` DECIMAL(18,2) COMMENT 'Projected cost of spare parts and consumables.',
    `plant_code` STRING COMMENT 'Code identifying the manufacturing plant or facility.',
    `quarter` STRING COMMENT 'Quarter of the fiscal year for the budget (Q1‑Q4).. Valid values are `Q1|Q2|Q3|Q4`',
    `total_actual_cost_ytd` DECIMAL(18,2) COMMENT 'Sum of all actual cost components incurred to date.',
    `total_planned_cost` DECIMAL(18,2) COMMENT 'Sum of all planned cost components for the budget period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the budget record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between total planned cost and total actual cost YTD.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance amount expressed as a percentage of total planned cost.',
    `version_number` STRING COMMENT 'Incremental version used for budget revisions and audit tracking.',
    `year` STRING COMMENT 'Four‑digit calendar year to which the budget applies.',
    CONSTRAINT pk_maintenance_budget PRIMARY KEY(`maintenance_budget_id`)
) COMMENT 'Annual and rolling maintenance budget record tracking planned versus actual maintenance expenditure by plant, asset category, maintenance type, and cost center for F&B facilities. Captures budget ID, budget period (fiscal year, quarter), plant/facility reference, cost center reference, maintenance category (preventive, corrective, predictive, shutdown, contractor, spare parts), budget type (annual plan, revised forecast, rolling 12-month), planned labor cost, planned material cost, planned contractor cost, total planned cost, actual labor cost YTD, actual material cost YTD, actual contractor cost YTD, total actual cost YTD, variance amount, variance percentage, and budget status (draft, approved, closed). Distinct from finance.budget which covers enterprise-wide financial budgeting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` (
    `inspection_round_id` BIGINT COMMENT 'Unique identifier for the inspection round record.',
    `crew_id` BIGINT COMMENT 'Identifier of the crew or operator assigned to execute the inspection round.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the inspection round takes place.',
    `previous_inspection_round_id` BIGINT COMMENT 'Self-referencing FK on inspection_round (previous_inspection_round_id)',
    `area_code` STRING COMMENT 'Code representing the specific area or zone within the plant for the inspection round.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of the inspection round completed (0‑100).',
    `compliance_status` STRING COMMENT 'Overall compliance outcome of the inspection round.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection round record was first created in the system.',
    `execution_timestamp` TIMESTAMP COMMENT 'Actual date and time when the inspection round was performed.',
    `inspection_duration_minutes` STRING COMMENT 'Total time spent executing the inspection round, measured in minutes.',
    `inspection_round_status` STRING COMMENT 'Current workflow state of the inspection round.. Valid values are `scheduled|in_progress|completed|overdue|cancelled`',
    `is_autonomous` BOOLEAN COMMENT 'Indicates whether the round is part of an autonomous maintenance (AM) program.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured by the inspector.',
    `number_of_defects` STRING COMMENT 'Count of defects identified during the inspection round.',
    `number_of_inspection_points` STRING COMMENT 'Total count of distinct inspection points included in the round.',
    `number_of_work_orders` STRING COMMENT 'Count of maintenance work orders generated from defects discovered in the round.',
    `priority_level` STRING COMMENT 'Business‑defined priority of the inspection round.. Valid values are `low|medium|high`',
    `round_name` STRING COMMENT 'Descriptive name of the inspection round (e.g., "Morning Equipment Care").',
    `round_number` STRING COMMENT 'Human‑readable code or number assigned to the inspection round.',
    `round_type` STRING COMMENT 'Category of the inspection round indicating its purpose.. Valid values are `operator_care|maintenance_inspection|safety_inspection|hygiene_inspection|pre_startup_check`',
    `route_description` STRING COMMENT 'Narrative description of the inspection route or path taken during the round.',
    `scheduled_frequency` STRING COMMENT 'Frequency at which the inspection round is scheduled to recur.. Valid values are `hourly|per_shift|daily|weekly|monthly`',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Planned date and time when the inspection round should start.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the inspection round record.',
    CONSTRAINT pk_inspection_round PRIMARY KEY(`inspection_round_id`)
) COMMENT 'Operator and maintenance inspection round record capturing structured walk-around inspections of F&B production equipment and facilities. Captures round ID, round name, round type (operator care round, maintenance inspection, safety inspection, hygiene inspection, pre-startup check), plant/area reference, assigned crew or operator, scheduled frequency (hourly, per shift, daily, weekly), route description, number of inspection points, round status (scheduled, in-progress, completed, overdue), execution date and time, completion percentage, number of defects found, and number of work orders raised from findings. Supports autonomous maintenance (AM) programs and operator-driven defect detection.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` (
    `inspection_finding_id` BIGINT COMMENT 'Unique identifier for the inspection finding record.',
    `asset_id` BIGINT COMMENT 'Identifier of the equipment or asset associated with the finding.',
    `crew_id` BIGINT COMMENT 'Identifier of the team that performed the inspection.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or technician who resolved the finding.',
    `inspection_round_id` BIGINT COMMENT 'Identifier of the inspection round during which the finding was recorded.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Inspection findings are tied to the physical location inspected; required for the Inspection Traceability Report.',
    `work_order_id` BIGINT COMMENT 'Identifier of the corrective work order generated from the finding, if any.',
    `related_inspection_finding_id` BIGINT COMMENT 'Self-referencing FK on inspection_finding (related_inspection_finding_id)',
    `batch_number` STRING COMMENT 'Batch identifier of the product associated with the finding, if applicable.',
    `comments` STRING COMMENT 'Additional free‑form comments or notes related to the finding.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard applicable to the finding.. Valid values are `FDA|GFSI|ISO22000|USDA|EFSA|FSSC22000`',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action planned or taken to address the finding.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the corrective action should be completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding record was first created in the system.',
    `equipment_tag` STRING COMMENT 'Tag or barcode associated with the equipment where the finding was recorded.',
    `finding_timestamp` TIMESTAMP COMMENT 'Date and time when the finding was observed.',
    `finding_type` STRING COMMENT 'Category of the finding recorded during inspection.. Valid values are `defect|abnormality|safety_hazard|hygiene_issue|near_miss|improvement_opportunity`',
    `follow_up_due_date` DATE COMMENT 'Date by which the follow‑up inspection should occur.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether a follow‑up inspection is required after corrective action.',
    `inspection_finding_description` STRING COMMENT 'Detailed narrative describing the observation or defect.',
    `inspection_finding_status` STRING COMMENT 'Current lifecycle status of the finding.. Valid values are `open|work_order_raised|resolved|accepted_risk`',
    `inspection_method` STRING COMMENT 'Method used to conduct the inspection.. Valid values are `visual|automated|sensor`',
    `is_repeat_finding` BOOLEAN COMMENT 'True if this finding has been recorded previously for the same asset or location.',
    `lot_number` STRING COMMENT 'Lot identifier of the raw material or product linked to the finding.',
    `photo_evidence_flag` BOOLEAN COMMENT 'Indicates whether photographic evidence is attached to the finding.',
    `priority_level` STRING COMMENT 'Priority assigned to the finding for remediation scheduling.. Valid values are `high|medium|low`',
    `product_sku` STRING COMMENT 'Stock Keeping Unit of the product related to the finding.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the finding is subject to regulatory compliance requirements.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulatory clause or guideline applicable to the finding.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the finding was resolved or closed.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned to the finding based on severity and impact.',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the finding.',
    `safety_permit_required_flag` BOOLEAN COMMENT 'Indicates if a safety permit is required to address the finding.',
    `severity` STRING COMMENT 'Severity level indicating the impact of the finding.. Valid values are `critical|major|minor|observation`',
    `source_system` STRING COMMENT 'Source system where the finding originated.. Valid values are `SAP_QM|MES|TraceGains|Custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the finding record.',
    CONSTRAINT pk_inspection_finding PRIMARY KEY(`inspection_finding_id`)
) COMMENT 'Individual defect or observation recorded during an inspection round at an F&B production facility. Captures finding ID, inspection round reference, asset reference, finding date and time, finding type (defect, abnormality, safety hazard, hygiene issue, near-miss, improvement opportunity), finding description, severity (critical, major, minor, observation), finding status (open, work order raised, resolved, accepted risk), photo evidence flag, work order generated reference, resolution date, and resolved by reference. Provides the granular defect log that drives corrective work order generation and supports TPM defect elimination programs.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`lube_point` (
    `lube_point_id` BIGINT COMMENT 'Primary key for lube_point',
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: Lube points are attached to a specific asset; replace generic equipment_id with asset_id FK.',
    `parent_lube_point_id` BIGINT COMMENT 'Self-referencing FK on lube_point (parent_lube_point_id)',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the point complies with applicable safety and environmental regulations.',
    `criticality_level` STRING COMMENT 'Importance of the point to equipment reliability; drives maintenance priority.',
    `last_lubricated_timestamp` TIMESTAMP COMMENT 'Date and time when the point was last lubricated.',
    `location_description` STRING COMMENT 'Textual description of the physical location of the lubrication point on the equipment (e.g., bearing housing, gear shaft).',
    `lubrication_interval_days` STRING COMMENT 'Recommended number of days between routine lubrications.',
    `lubrication_interval_hours` STRING COMMENT 'Recommended number of operating hours between routine lubrications.',
    `lubrication_type` STRING COMMENT 'Category of lubricant applied at this point.',
    `lubrication_volume_ml` DECIMAL(18,2) COMMENT 'Standard volume of lubricant applied per service (milliliters).',
    `maintenance_strategy` STRING COMMENT 'Strategy governing how this point is maintained.',
    `next_due_timestamp` TIMESTAMP COMMENT 'Planned date and time for the next lubrication activity.',
    `notes` STRING COMMENT 'Free‑form remarks or special instructions for the lubrication point.',
    `point_code` STRING COMMENT 'Short alphanumeric code used to reference the lubrication point in work orders.',
    `point_name` STRING COMMENT 'Human‑readable name of the lubrication point on equipment.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the lubrication point record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lubrication point record.',
    `safety_rating` STRING COMMENT 'Safety classification of the lubricant at this point.',
    `lube_point_status` STRING COMMENT 'Current operational status of the lubrication point.',
    `viscosity_cst` DECIMAL(18,2) COMMENT 'Viscosity rating of the recommended lubricant in centistokes.',
    CONSTRAINT pk_lube_point PRIMARY KEY(`lube_point_id`)
) COMMENT 'Master reference table for lube_point. Referenced by lube_point_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`asset_group` (
    `asset_group_id` BIGINT COMMENT 'Primary key for asset_group',
    `parent_group_id` BIGINT COMMENT 'Identifier of the parent asset group for hierarchical grouping.',
    `parent_asset_group_id` BIGINT COMMENT 'Self-referencing FK on asset_group (parent_asset_group_id)',
    `asset_count` STRING COMMENT 'Number of individual assets assigned to this group.',
    `capacity` DECIMAL(18,2) COMMENT 'Total production capacity or throughput associated with the group (e.g., kilograms per hour).',
    `asset_group_code` STRING COMMENT 'Business‑defined code used to reference the asset group in external systems.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the asset group.',
    `cost_center_code` STRING COMMENT 'Financial cost‑center associated with the asset group.',
    `created_by_user` STRING COMMENT 'User identifier who created the record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset group record was first created.',
    `depreciation_end_date` DATE COMMENT 'Projected end date for depreciation of the asset group.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate assets in the group.',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation of the asset group begins.',
    `asset_group_description` STRING COMMENT 'Detailed free‑text description of the asset group.',
    `effective_end_date` DATE COMMENT 'Date when the asset group is scheduled to be retired or become inactive (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the asset group became effective.',
    `external_reference_code` STRING COMMENT 'Identifier used by external partners or legacy systems.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the asset group is critical to production continuity.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection.',
    `last_inspection_result` STRING COMMENT 'Outcome of the most recent inspection.',
    `location` STRING COMMENT 'Physical location or plant where the asset group resides.',
    `maintenance_window` STRING COMMENT 'Scheduled regular maintenance window (e.g., "Mon 02:00‑04:00").',
    `asset_group_name` STRING COMMENT 'Human‑readable name of the asset group.',
    `notes` STRING COMMENT 'Additional free‑form remarks or comments.',
    `responsible_department` STRING COMMENT 'Organizational department accountable for the asset group.',
    `risk_level` STRING COMMENT 'Risk classification based on safety, operational, and financial factors.',
    `asset_group_status` STRING COMMENT 'Current lifecycle state of the asset group.',
    `total_value` DECIMAL(18,2) COMMENT 'Aggregate financial value of all assets in the group.',
    `asset_group_type` STRING COMMENT 'Category that classifies the purpose or function of the asset group.',
    `updated_by_user` STRING COMMENT 'User identifier who performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset group record.',
    `version_number` STRING COMMENT 'Incremental version number for optimistic concurrency control.',
    `warranty_expiration_date` DATE COMMENT 'Date when the collective warranty for the asset group expires.',
    CONSTRAINT pk_asset_group PRIMARY KEY(`asset_group_id`)
) COMMENT 'Master reference table for asset_group. Referenced by asset_group_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`maintenance`.`work_order_template` (
    `work_order_template_id` BIGINT COMMENT 'Primary key for work_order_template',
    `parent_work_order_template_id` BIGINT COMMENT 'Self-referencing FK on work_order_template (parent_work_order_template_id)',
    `approval_required` BOOLEAN COMMENT 'Indicates whether the work order must be approved before execution.',
    `approval_role` STRING COMMENT 'Organizational role responsible for approving the work order.',
    `work_order_template_category` STRING COMMENT 'Classification of the template by maintenance type.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Overall cost estimate for the work order, including labor and materials.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the template record was first created.',
    `default_duration_hours` DECIMAL(18,2) COMMENT 'Standard estimated duration for work orders created from this template.',
    `default_priority` STRING COMMENT 'Default priority assigned to work orders generated from this template.',
    `department` STRING COMMENT 'Department that owns and maintains the template.',
    `work_order_template_description` STRING COMMENT 'Detailed description of the purpose and scope of the template.',
    `effective_from` DATE COMMENT 'Date from which the template becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the template is no longer valid (null if open‑ended).',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Projected labor hours required to complete the work.',
    `estimated_material_quantity` DECIMAL(18,2) COMMENT 'Projected quantity of material needed (units depend on material type).',
    `frequency_interval_days` STRING COMMENT 'Number of days between scheduled occurrences for preventive templates.',
    `is_template_shared` BOOLEAN COMMENT 'True if the template is available across multiple plants or business units.',
    `labor_rate` DECIMAL(18,2) COMMENT 'Standard labor rate applied when calculating labor cost.',
    `material_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost of materials required for the work.',
    `plant_location` STRING COMMENT 'Code of the plant or facility where the template is primarily used.',
    `required_certifications` STRING COMMENT 'Comma‑separated list of certifications workers must hold.',
    `required_equipment` STRING COMMENT 'Comma‑separated list of equipment identifiers required for the work.',
    `required_skills` STRING COMMENT 'Comma‑separated list of skill codes needed to perform the work.',
    `safety_procedure_code` STRING COMMENT 'Reference code to the safety procedure applicable to the work.',
    `safety_risk_level` STRING COMMENT 'Risk classification for safety considerations.',
    `work_order_template_status` STRING COMMENT 'Current lifecycle status of the template.',
    `template_code` STRING COMMENT 'Business code used to reference the template in systems and documentation.',
    `template_name` STRING COMMENT 'Human‑readable name of the work order template.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the template record.',
    `version_number` STRING COMMENT 'Version identifier for change management of the template.',
    `work_center` STRING COMMENT 'Identifier of the work center associated with the template.',
    CONSTRAINT pk_work_order_template PRIMARY KEY(`work_order_template_id`)
) COMMENT 'Master reference table for work_order_template. Referenced by work_order_template_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_asset_group_id` FOREIGN KEY (`asset_group_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset_group`(`asset_group_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_asset_hierarchy_id` FOREIGN KEY (`asset_hierarchy_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset_hierarchy`(`asset_hierarchy_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ADD CONSTRAINT `fk_maintenance_asset_parent_asset_id` FOREIGN KEY (`parent_asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ADD CONSTRAINT `fk_maintenance_asset_hierarchy_parent_node_asset_hierarchy_id` FOREIGN KEY (`parent_node_asset_hierarchy_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset_hierarchy`(`asset_hierarchy_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ADD CONSTRAINT `fk_maintenance_asset_hierarchy_parent_asset_hierarchy_id` FOREIGN KEY (`parent_asset_hierarchy_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset_hierarchy`(`asset_hierarchy_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_work_order_template_id` FOREIGN KEY (`work_order_template_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order_template`(`work_order_template_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_parent_work_order_id` FOREIGN KEY (`parent_work_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_predecessor_work_order_task_id` FOREIGN KEY (`predecessor_work_order_task_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order_task`(`work_order_task_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_asset_group_id` FOREIGN KEY (`asset_group_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset_group`(`asset_group_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`crew`(`crew_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_work_order_template_id` FOREIGN KEY (`work_order_template_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order_template`(`work_order_template_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_parent_pm_plan_id` FOREIGN KEY (`parent_pm_plan_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_rescheduled_pm_schedule_id` FOREIGN KEY (`rescheduled_pm_schedule_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ADD CONSTRAINT `fk_maintenance_failure_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ADD CONSTRAINT `fk_maintenance_failure_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ADD CONSTRAINT `fk_maintenance_failure_record_root_cause_failure_record_id` FOREIGN KEY (`root_cause_failure_record_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`failure_record`(`failure_record_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_superseded_spare_part_id` FOREIGN KEY (`superseded_spare_part_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`spare_part`(`spare_part_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`spare_part`(`spare_part_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_reversal_parts_consumption_id` FOREIGN KEY (`reversal_parts_consumption_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`parts_consumption`(`parts_consumption_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ADD CONSTRAINT `fk_maintenance_calibration_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ADD CONSTRAINT `fk_maintenance_calibration_order_previous_calibration_order_id` FOREIGN KEY (`previous_calibration_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`calibration_order`(`calibration_order_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ADD CONSTRAINT `fk_maintenance_calibration_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ADD CONSTRAINT `fk_maintenance_calibration_schedule_parent_calibration_schedule_id` FOREIGN KEY (`parent_calibration_schedule_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`calibration_schedule`(`calibration_schedule_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ADD CONSTRAINT `fk_maintenance_crew_parent_crew_id` FOREIGN KEY (`parent_crew_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`crew`(`crew_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_parent_permit_to_work_id` FOREIGN KEY (`parent_permit_to_work_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_follow_up_reliability_event_id` FOREIGN KEY (`follow_up_reliability_event_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`reliability_event`(`reliability_event_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ADD CONSTRAINT `fk_maintenance_asset_condition_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ADD CONSTRAINT `fk_maintenance_asset_condition_previous_asset_condition_id` FOREIGN KEY (`previous_asset_condition_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset_condition`(`asset_condition_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ADD CONSTRAINT `fk_maintenance_maintenance_contract_renewed_maintenance_contract_id` FOREIGN KEY (`renewed_maintenance_contract_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`maintenance_contract`(`maintenance_contract_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ADD CONSTRAINT `fk_maintenance_contractor_visit_maintenance_contract_id` FOREIGN KEY (`maintenance_contract_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`maintenance_contract`(`maintenance_contract_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ADD CONSTRAINT `fk_maintenance_contractor_visit_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ADD CONSTRAINT `fk_maintenance_contractor_visit_follow_up_contractor_visit_id` FOREIGN KEY (`follow_up_contractor_visit_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`contractor_visit`(`contractor_visit_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_previous_shutdown_plan_id` FOREIGN KEY (`previous_shutdown_plan_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`shutdown_plan`(`shutdown_plan_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ADD CONSTRAINT `fk_maintenance_lubrication_route_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`crew`(`crew_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ADD CONSTRAINT `fk_maintenance_lubrication_route_parent_lubrication_route_id` FOREIGN KEY (`parent_lubrication_route_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`lubrication_route`(`lubrication_route_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ADD CONSTRAINT `fk_maintenance_lubrication_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ADD CONSTRAINT `fk_maintenance_lubrication_event_lube_point_id` FOREIGN KEY (`lube_point_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`lube_point`(`lube_point_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ADD CONSTRAINT `fk_maintenance_lubrication_event_lubrication_route_id` FOREIGN KEY (`lubrication_route_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`lubrication_route`(`lubrication_route_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ADD CONSTRAINT `fk_maintenance_lubrication_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ADD CONSTRAINT `fk_maintenance_lubrication_event_previous_lubrication_event_id` FOREIGN KEY (`previous_lubrication_event_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`lubrication_event`(`lubrication_event_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ADD CONSTRAINT `fk_maintenance_asset_replacement_plan_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ADD CONSTRAINT `fk_maintenance_asset_replacement_plan_superseded_asset_replacement_plan_id` FOREIGN KEY (`superseded_asset_replacement_plan_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset_replacement_plan`(`asset_replacement_plan_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ADD CONSTRAINT `fk_maintenance_maintenance_budget_maintenance_contract_id` FOREIGN KEY (`maintenance_contract_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`maintenance_contract`(`maintenance_contract_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ADD CONSTRAINT `fk_maintenance_maintenance_budget_parent_maintenance_budget_id` FOREIGN KEY (`parent_maintenance_budget_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`maintenance_budget`(`maintenance_budget_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`crew`(`crew_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_previous_inspection_round_id` FOREIGN KEY (`previous_inspection_round_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`inspection_round`(`inspection_round_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ADD CONSTRAINT `fk_maintenance_inspection_finding_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ADD CONSTRAINT `fk_maintenance_inspection_finding_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`crew`(`crew_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ADD CONSTRAINT `fk_maintenance_inspection_finding_inspection_round_id` FOREIGN KEY (`inspection_round_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`inspection_round`(`inspection_round_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ADD CONSTRAINT `fk_maintenance_inspection_finding_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ADD CONSTRAINT `fk_maintenance_inspection_finding_related_inspection_finding_id` FOREIGN KEY (`related_inspection_finding_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lube_point` ADD CONSTRAINT `fk_maintenance_lube_point_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset`(`asset_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lube_point` ADD CONSTRAINT `fk_maintenance_lube_point_parent_lube_point_id` FOREIGN KEY (`parent_lube_point_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`lube_point`(`lube_point_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_group` ADD CONSTRAINT `fk_maintenance_asset_group_parent_group_id` FOREIGN KEY (`parent_group_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset_group`(`asset_group_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_group` ADD CONSTRAINT `fk_maintenance_asset_group_parent_asset_group_id` FOREIGN KEY (`parent_asset_group_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`asset_group`(`asset_group_id`);
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_template` ADD CONSTRAINT `fk_maintenance_work_order_template_parent_work_order_template_id` FOREIGN KEY (`parent_work_order_template_id`) REFERENCES `food_beverage_ecm`.`maintenance`.`work_order_template`(`work_order_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`maintenance` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `food_beverage_ecm`.`maintenance` SET TAGS ('dbx_domain' = 'maintenance');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `asset_group_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Group Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `asset_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Hierarchy Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Responsible Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Network Node Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `parent_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|scrapped');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type (Category of Asset)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'production_equipment|utility|facility|instrumentation');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `book_value` SET TAGS ('dbx_business_glossary_term' = 'Current Book Value (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval (Days)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `class_iso14224` SET TAGS ('dbx_business_glossary_term' = 'Asset Class (ISO 14224)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `dimensions` SET TAGS ('dbx_business_glossary_term' = 'Physical Dimensions');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `health_score` SET TAGS ('dbx_business_glossary_term' = 'Health Score (0‑100)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `maintenance_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval (Days)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'preventive|predictive|run_to_failure');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `operating_status` SET TAGS ('dbx_business_glossary_term' = 'Operating Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `operating_status` SET TAGS ('dbx_value_regex' = 'operational|standby|out_of_service');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating (kW)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `replacement_value` SET TAGS ('dbx_business_glossary_term' = 'Replacement Value (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (0‑100)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag / Barcode');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `asset_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Hierarchy ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `parent_node_asset_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Node ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `parent_asset_hierarchy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|process|utility');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `asset_hierarchy_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `asset_hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `asset_hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `asset_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Asset Subcategory');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `asset_subcategory` SET TAGS ('dbx_value_regex' = 'pump|motor|valve|conveyor|boiler');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Asset Availability (%)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval (Days)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `calibration_required` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `criticality_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `maintenance_group` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Group');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'preventive|predictive|reactive|none');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Asset Manufacturer');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Model Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Functional Location Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Node Name');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Node Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'plant|area|system|subsystem|equipment');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `oee_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (%)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `otif_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On‑Time‑In‑Full Target (%)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Serial Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_hierarchy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `equipment_master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID (ASSET_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Supply Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor ID (REQ_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_template_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Template Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `parent_work_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (ACT_COST)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date (ACT_END)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours (ACT_LAB_HRS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date (ACT_START)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes (COMP_NOTES)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken (CORR_ACTION)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours (DT_HRS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (EST_COST)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours (EST_LAB_HRS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `failure_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Description (FAIL_DESC)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `failure_mode_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Code (FM_CODE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `functional_location` SET TAGS ('dbx_business_glossary_term' = 'Functional Location (FUNC_LOC)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `order_issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Issued Timestamp (ISSUED_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `permit_to_work_number` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work Number (PTW_NO)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date (PLAN_END)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date (PLAN_START)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority (WO_PRIORITY)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'emergency|urgent|normal|low');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `production_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Impact Flag (PROD_IMPACT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code (RC_CODE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `safety_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Required Flag (SAFE_PERMIT_REQ)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `sap_pm_order_number` SET TAGS ('dbx_business_glossary_term' = 'SAP PM Order Number (SAP_PM_NO)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description (WORK_DESC)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number (WO)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status (WO_STATUS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type (WO_TYPE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `work_order_task_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Task ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `predecessor_work_order_task_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Minutes)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completion Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `equipment_tag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Task Indicator');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Category');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_value_regex' = 'preventive|corrective|predictive');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `part_cost_total` SET TAGS ('dbx_business_glossary_term' = 'Total Parts Cost');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `part_quantity_used` SET TAGS ('dbx_business_glossary_term' = 'Part Quantity Used');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `parts_used` SET TAGS ('dbx_business_glossary_term' = 'Parts Used');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `planned_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Minutes)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `quality_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Passed');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Notes');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `safety_instructions` SET TAGS ('dbx_business_glossary_term' = 'Safety Instructions');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `skill_required` SET TAGS ('dbx_business_glossary_term' = 'Required Skill');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_code` SET TAGS ('dbx_business_glossary_term' = 'Task External Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'inspection|lubrication|replacement|adjustment|cleaning|testing');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `tools_required` SET TAGS ('dbx_business_glossary_term' = 'Tools Required');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `work_order_task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `work_order_task_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|skipped|canceled');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` SET TAGS ('dbx_subdomain' = 'maintenance_planning');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Plan ID (PM_PLAN_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `asset_group_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Group ID (ASSET_GROUP_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID (ASSET_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew ID (CREW_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID (VENDOR_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `work_order_template_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Template ID (WORK_ORDER_TEMPLATE_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `parent_pm_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `budgeted_annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Annual Cost (BUDGETED_ANNUAL_COST)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `calibration_required` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required (CALIBRATION_REQ)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement (COMPLIANCE_REQ)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `condition_monitoring_parameter` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring Parameter (COND_MON_PARAM)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `condition_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Condition Threshold Unit (COND_THRESH_UNIT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `condition_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Condition Threshold Value (COND_THRESH_VAL)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CENTER_CODE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `cycle_unit` SET TAGS ('dbx_business_glossary_term' = 'Cycle Unit (CYCLE_UNIT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `cycle_unit` SET TAGS ('dbx_value_regex' = 'days|weeks|months|years|hours|cycles');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Documentation Reference (DOC_REF)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_END_DATE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START_DATE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `estimated_labor_hours_per_cycle` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours per Cycle (EST_LABOR_HRS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `estimated_material_cost_per_cycle` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost per Cycle (EST_MAT_COST)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `is_external_vendor` SET TAGS ('dbx_business_glossary_term' = 'External Vendor Required (EXTERNAL_VENDOR)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `last_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Date (LAST_EXEC_DATE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (LAST_MOD_BY)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (LEAD_TIME_DAYS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `maintenance_cycle` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (MAINTENANCE_CYCLE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy (MAINTENANCE_STRATEGY)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'preventive|predictive|reliability_centered');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date (NEXT_DUE_DATE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Plan Code (PM_PLAN_CODE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Description (PLAN_DESCRIPTION)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Plan Name (PM_PLAN_NAME)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status (PLAN_STATUS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type (PM_PLAN_TYPE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'time_based|counter_based|condition_based');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PRIORITY_LEVEL)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `required_spare_parts` SET TAGS ('dbx_business_glossary_term' = 'Required Spare Parts (REQUIRED_SPARE_PARTS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `safety_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Risk Level (SAFETY_RISK_LEVEL)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `safety_risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'maintenance_planning');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Schedule ID (PM_SCHEDULE_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Plan ID (PM_PLAN_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `rescheduled_pm_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Minutes)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Maintenance Cost');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Maintenance Cost');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `counter_reading` SET TAGS ('dbx_business_glossary_term' = 'Counter Reading at Scheduling');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Equipment Downtime (Minutes)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `equipment_condition` SET TAGS ('dbx_business_glossary_term' = 'Equipment Condition');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `equipment_condition` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Minutes)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `is_out_of_service` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Service Indicator');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Schedule Indicator');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `last_counter_reading` SET TAGS ('dbx_business_glossary_term' = 'Last Counter Reading');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Category');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_value_regex' = 'routine|emergency|scheduled');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|predictive');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `next_due_counter` SET TAGS ('dbx_business_glossary_term' = 'Next Due Counter');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `overdue_days` SET TAGS ('dbx_business_glossary_term' = 'Overdue Days');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `pm_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `pm_schedule_status` SET TAGS ('dbx_value_regex' = 'open|completed|overdue|skipped|cancelled');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `recurrence_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Interval (Days)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `required_spare_parts` SET TAGS ('dbx_business_glossary_term' = 'Required Spare Parts');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `safety_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Risk Level');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `safety_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_business_glossary_term' = 'Schedule Source');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_value_regex' = 'system_generated|manual');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `scheduling_basis` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Basis');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `scheduling_basis` SET TAGS ('dbx_value_regex' = 'calendar|runtime|production_count');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` SET TAGS ('dbx_subdomain' = 'maintenance_planning');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporter Employee Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `root_cause_failure_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Additional Comments');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Failure Detection Method');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'operator_report|sensor_alarm|inspection|predictive_alert');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `downtime_end` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `downtime_start` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `failure_cause` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `failure_cause` SET TAGS ('dbx_value_regex' = 'wear|fatigue|corrosion|contamination|misalignment|operator_error');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `failure_effect` SET TAGS ('dbx_business_glossary_term' = 'Failure Effect on Production');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `failure_effect` SET TAGS ('dbx_value_regex' = 'no_impact|minor_slowdown|line_stoppage|plant_shutdown');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `failure_mode` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|instrumentation|process|human_error');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `failure_number` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Number (FRN)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `failure_record_status` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `failure_record_status` SET TAGS ('dbx_value_regex' = 'open|closed|cancelled');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `failure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `fmea_reference_code` SET TAGS ('dbx_business_glossary_term' = 'FMEA Reference Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `is_safety_incident` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|predictive');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Failure Priority');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `production_loss_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Loss Quantity (Units)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `root_cause_analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `root_cause_analysis_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Failure Severity Level');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Production Shift');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `total_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Downtime (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`failure_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Identifier (SPARE_PART_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `superseded_spare_part_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `cmms_material_master_reference` SET TAGS ('dbx_business_glossary_term' = 'CMMS Material Master Reference (CMMS_MATERIAL_MASTER_REF)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `compatible_asset_references` SET TAGS ('dbx_business_glossary_term' = 'Compatible Asset References (COMPATIBLE_ASSET_REFS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications (COMPLIANCE_CERTIFICATIONS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `criticality` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level (CRITICALITY)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `criticality` SET TAGS ('dbx_value_regex' = 'critical|non-critical|insurance_spare');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `dimensions` SET TAGS ('dbx_business_glossary_term' = 'Dimensions (LxWxH) (DIMENSIONS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `disposal_instructions` SET TAGS ('dbx_business_glossary_term' = 'Disposal Instructions (DISPOSAL_INSTRUCTIONS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag (HAZARDOUS_MATERIAL_FLAG)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `is_serialized` SET TAGS ('dbx_business_glossary_term' = 'Serialized Part Flag (IS_SERIALIZED)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `last_inventory_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Check Date (LAST_INVENTORY_CHECK_DATE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days) (LEAD_TIME_DAYS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MANUFACTURER_PART_NUMBER)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level (MAX_STOCK_LEVEL)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `minimum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level (MIN_STOCK_LEVEL)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `oem_part_number` SET TAGS ('dbx_business_glossary_term' = 'OEM Part Number (OEM_PART_NUMBER)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `part_category` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Category (SPARE_PART_CATEGORY)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `part_category` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|instrumentation|consumable|lubricant|seal_gasket');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number (PART_NUMBER)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (REORDER_POINT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days) (SHELF_LIFE_DAYS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `spare_part_description` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Description (SPARE_PART_DESCRIPTION)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `spare_part_name` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Name (SPARE_PART_NAME)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `spare_part_status` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Status (SPARE_PART_STATUS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `spare_part_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost (STANDARD_COST)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `supplier_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Reference (SUPPLIER_REF)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months) (WARRANTY_PERIOD_MONTHS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`spare_part` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms) (WEIGHT_KG)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `parts_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Parts Consumption ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `reversal_parts_consumption_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consumption Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `consumption_type` SET TAGS ('dbx_business_glossary_term' = 'Consumption Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `consumption_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|emergency');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `goods_issue_doc_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Document Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `parts_consumption_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `parts_consumption_status` SET TAGS ('dbx_value_regex' = 'recorded|reversed|adjusted');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Consumed');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Line Cost (Currency)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost (Currency)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|BOX');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `calibration_order_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Order Identifier (CAL_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier (TECH_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Identifier (INST_ASSET_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Location Identifier (LOC_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `previous_calibration_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Calibration Timestamp (ACT_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `as_found_reading` SET TAGS ('dbx_business_glossary_term' = 'As-Found Reading (AF_READ)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `as_left_reading` SET TAGS ('dbx_business_glossary_term' = 'As-Left Reading (AL_READ)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `calibration_method` SET TAGS ('dbx_business_glossary_term' = 'Calibration Method (METHOD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `calibration_notes` SET TAGS ('dbx_business_glossary_term' = 'Calibration Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `calibration_order_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Order Status (CAL_STATUS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `calibration_order_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|in_progress|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `calibration_source` SET TAGS ('dbx_business_glossary_term' = 'Calibration Source (SOURCE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `calibration_source` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `calibration_standard` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard (CAL_STD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `calibration_type` SET TAGS ('dbx_business_glossary_term' = 'Calibration Type (CAL_TYPE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `calibration_type` SET TAGS ('dbx_value_regex' = 'routine|as_found|as_left|post_repair|regulatory');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number (CERT_NO)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action (CORR_ACT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Calibration Cost Amount (COST_AMT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRT_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `instrument_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Serial Number (SN)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type (INST_TYPE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit (UNIT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date (NEXT_DUE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Calibration Procedure Reference (PROC_REF)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference (REG_REF)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result (RESULT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `result` SET TAGS ('dbx_value_regex' = 'pass|fail|adjusted|out_of_tolerance');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Calibration Timestamp (SCH_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `tolerance_lower` SET TAGS ('dbx_business_glossary_term' = 'Lower Tolerance Limit (TOL_LO)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `tolerance_upper` SET TAGS ('dbx_business_glossary_term' = 'Upper Tolerance Limit (TOL_HI)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` SET TAGS ('dbx_subdomain' = 'maintenance_planning');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Schedule ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `parent_calibration_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_cost` SET TAGS ('dbx_business_glossary_term' = 'Calibration Cost');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_currency` SET TAGS ('dbx_business_glossary_term' = 'Calibration Currency');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Calibration Duration (Minutes)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_frequency` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_location` SET TAGS ('dbx_business_glossary_term' = 'Calibration Location');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_method` SET TAGS ('dbx_business_glossary_term' = 'Calibration Method');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_method` SET TAGS ('dbx_value_regex' = 'in_house|external|automated');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_notes` SET TAGS ('dbx_business_glossary_term' = 'Calibration Notes');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_responsible_contact` SET TAGS ('dbx_business_glossary_term' = 'Calibration Responsible Contact Email');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_responsible_contact` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_responsible_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_responsible_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_result` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_result` SET TAGS ('dbx_value_regex' = 'pass|fail|out_of_tolerance');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_standard` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `calibration_standard_version` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard Version');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'temperature|pressure|ph|weight|vision|spectrometer');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `overdue_alert_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Overdue Alert Threshold (Days)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'HACCP_CCP|FDA|USDA|Customer_Audit|GFSI');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'internal_lab|external_lab');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|suspended|decommissioned');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `tolerance_specification` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Specification');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`calibration_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` SET TAGS ('dbx_subdomain' = 'safety_operations');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Crew Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Home Plant Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Lead Employee Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `parent_crew_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Crew Availability Percentage');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `average_mttr_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average MTTR (Minutes)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `capacity_hours_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Shift Capacity (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `certifications` SET TAGS ('dbx_business_glossary_term' = 'Crew Certifications');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `crew_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Crew Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `crew_name` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Crew Name');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `crew_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Crew Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `crew_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `crew_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Crew Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `crew_type` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|instrumentation|utilities|general|contractor');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `last_assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assigned Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `next_available_date` SET TAGS ('dbx_business_glossary_term' = 'Next Available Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Crew Notes');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_value_regex' = 'day|night|rotating');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `skill_specializations` SET TAGS ('dbx_business_glossary_term' = 'Skill Specializations');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`crew` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` SET TAGS ('dbx_subdomain' = 'safety_operations');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `quaternary_permit_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `quaternary_permit_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `quaternary_permit_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `quinary_permit_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `quinary_permit_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `quinary_permit_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `tertiary_permit_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `tertiary_permit_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `tertiary_permit_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `parent_permit_to_work_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `closure_signoff_name` SET TAGS ('dbx_business_glossary_term' = 'Closure Sign‑off Name');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `closure_signoff_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `closure_signoff_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `closure_signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closure Sign‑off Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `gas_test_result` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Result');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `gas_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `gas_test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `gas_test_value_ppm` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Value (ppm)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `isolation_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Isolation Confirmed Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Permit Notes');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Closure Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Permit Duration (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_revision_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Revision Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Start Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_to_work_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_to_work_status` SET TAGS ('dbx_value_regex' = 'requested|approved|active|suspended|closed|cancelled');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'hot_work|confined_space|loto|cold_work|chemical|height');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Request Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `required_ppe` SET TAGS ('dbx_business_glossary_term' = 'Required Personal Protective Equipment');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `temperature_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Required');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `temperature_reading_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (°C)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` SET TAGS ('dbx_subdomain' = 'maintenance_planning');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `reliability_event_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `follow_up_reliability_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_trigger` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event Trigger');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_trigger` SET TAGS ('dbx_value_regex' = 'recurring_failure|new_asset|regulatory_requirement|cost_threshold_breach');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'rcm_analysis|fmea|bad_actor_review|reliability_improvement|root_cause_analysis');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `expected_mtbf_improvement_hours` SET TAGS ('dbx_business_glossary_term' = 'Expected MTBF Improvement (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Name');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `follow_up_action_refs` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Action References');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|deferred|cancelled');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `maintenance_strategy_change` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Change');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `mtbf_after` SET TAGS ('dbx_business_glossary_term' = 'MTBF After (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `mtbf_before` SET TAGS ('dbx_business_glossary_term' = 'MTBF Before (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `mtbf_improvement_percent` SET TAGS ('dbx_business_glossary_term' = 'MTBF Improvement Percent');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `participants` SET TAGS ('dbx_business_glossary_term' = 'Event Participants');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Event Priority');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `recommended_strategy` SET TAGS ('dbx_business_glossary_term' = 'Recommended Maintenance Strategy');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `recommended_strategy` SET TAGS ('dbx_value_regex' = 'preventive|predictive|corrective|none');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `asset_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Record Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `previous_asset_condition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `condition_score` SET TAGS ('dbx_business_glossary_term' = 'Condition Score');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `findings_text` SET TAGS ('dbx_business_glossary_term' = 'Findings Description');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'visual_inspection|vibration_analysis|thermography|oil_analysis|ultrasound|motor_current_analysis');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `oil_contamination_level` SET TAGS ('dbx_business_glossary_term' = 'Oil Contamination Level');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'monitor|schedule_pm|immediate_repair|plan_replacement');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_condition` ALTER COLUMN `vibration_level_mm_s` SET TAGS ('dbx_business_glossary_term' = 'Vibration Level (mm/s)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` SET TAGS ('dbx_subdomain' = 'maintenance_planning');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `maintenance_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `bill_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bill To Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Service Provider ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `renewed_maintenance_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'amc|oem|time_and_material|fixed_price|sla_based');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `covered_asset_category` SET TAGS ('dbx_business_glossary_term' = 'Covered Asset Category');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `covered_asset_ids` SET TAGS ('dbx_business_glossary_term' = 'Covered Asset IDs');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Contract Exclusions');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `maintenance_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `maintenance_contract_status` SET TAGS ('dbx_value_regex' = 'active|expired|terminated|pending_renewal|draft');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `renewal_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `resolution_time_sla_minutes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time SLA (Minutes)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `response_time_sla_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Time SLA (Minutes)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `termination_notice_required` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Required');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` SET TAGS ('dbx_subdomain' = 'safety_operations');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `contractor_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Visit Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `maintenance_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Identifier (MAINT_CONTRACT_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (CONTRACTOR_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (WORK_ORDER_ID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `follow_up_contractor_visit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Arrival Timestamp (ARRIVAL_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `contractor_visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status (VISIT_STATUS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `contractor_visit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP|JPY');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Departure Timestamp (DEPARTURE_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `findings` SET TAGS ('dbx_business_glossary_term' = 'Findings (FINDINGS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (GROSS_AMT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference (INVOICE_REF)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `parts_replaced` SET TAGS ('dbx_business_glossary_term' = 'Parts Replaced (PARTS_REPLACED)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `ppe_compliance_confirmed` SET TAGS ('dbx_business_glossary_term' = 'PPE Compliance Confirmed (PPE_CONFIRMED)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Visit Purpose (VISIT_PURPOSE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'scheduled_pm|emergency_repair|inspection|commissioning|warranty_repair');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Recommendations (RECOMMENDATIONS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `site_induction_completed` SET TAGS ('dbx_business_glossary_term' = 'Site Induction Completed (INDUCTION_DONE)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `technician_certification` SET TAGS ('dbx_business_glossary_term' = 'Technician Certification (TECH_CERT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Full Name (TECH_NAME)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `technician_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `technician_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_business_glossary_term' = 'Visit Number (VISIT_NO)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `visit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Visit Start Timestamp (VISIT_TS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `work_acceptance_signoff` SET TAGS ('dbx_business_glossary_term' = 'Work Acceptance Sign‑off (WORK_ACCEPTED)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`contractor_visit` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description (WORK_DESC)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` SET TAGS ('dbx_subdomain' = 'maintenance_planning');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Plan Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `facility_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `previous_shutdown_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Coordinator Name');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Notes');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Plan Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `regulatory_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Required');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `safety_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Safety Review Completed');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Description');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Plan Name');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Plan Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_plan_status` SET TAGS ('dbx_value_regex' = 'planning|approved|in_progress|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Plan Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_plan_type` SET TAGS ('dbx_value_regex' = 'annual_overhaul|seasonal_changeover|capital_project|regulatory_inspection|deep_clean');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `total_actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Cost');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `total_actual_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Downtime (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `total_planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Cost');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `total_planned_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Downtime (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `work_order_count` SET TAGS ('dbx_business_glossary_term' = 'Work Order Count');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` SET TAGS ('dbx_subdomain' = 'maintenance_planning');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `lubrication_route_id` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Route Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `parent_lubrication_route_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Area Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `average_mechanical_efficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'Average Mechanical Efficiency (%)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Documentation Reference');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `food_grade_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Food‑Grade Lubricant Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Frequency');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|yearly');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `haccp_control_point` SET TAGS ('dbx_business_glossary_term' = 'HACCP Control Point');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `historical_success_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Historical Success Rate (%)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `last_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `lubricant_quantity_per_point_ml` SET TAGS ('dbx_business_glossary_term' = 'Lubricant Quantity per Point (mL)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `lubricant_type` SET TAGS ('dbx_business_glossary_term' = 'Lubricant Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `mean_time_between_failures_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `next_scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Execution Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `nsf_h1_h2_certification` SET TAGS ('dbx_business_glossary_term' = 'NSF H1/H2 Certification');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `number_of_points` SET TAGS ('dbx_business_glossary_term' = 'Number of Lubrication Points');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `required_tools` SET TAGS ('dbx_business_glossary_term' = 'Required Tools');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Route Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `route_description` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Route Description');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Route Name (LRN)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Route Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'active|suspended|inactive|planned');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Route Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|both');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `safety_instructions` SET TAGS ('dbx_business_glossary_term' = 'Safety Instructions');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_route` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `lubrication_event_id` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Event Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `lube_point_id` SET TAGS ('dbx_business_glossary_term' = 'Lube Point Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `lubrication_route_id` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Route Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `tertiary_lubrication_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `tertiary_lubrication_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `tertiary_lubrication_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `previous_lubrication_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `application_method` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Application Method');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `application_method` SET TAGS ('dbx_value_regex' = 'grease_gun|oil_can|automatic_lubricator|manual');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Lubricant Batch Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Food‑Grade Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Event Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Execution Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lubricant Expiration Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Ambient Humidity Percent');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Lubrication Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `lube_point_condition` SET TAGS ('dbx_business_glossary_term' = 'Lube Point Condition');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `lube_point_condition` SET TAGS ('dbx_value_regex' = 'normal|dry|contaminated|over_lubricated');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `lubricant_nsf_classification` SET TAGS ('dbx_business_glossary_term' = 'NSF Lubricant Classification');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `lubricant_nsf_classification` SET TAGS ('dbx_value_regex' = 'H1|H2|3H|none');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `lubricant_product_name` SET TAGS ('dbx_business_glossary_term' = 'Lubricant Product Name');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `lubricant_type` SET TAGS ('dbx_business_glossary_term' = 'Lubricant Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `lubricant_type` SET TAGS ('dbx_value_regex' = 'grease|oil|synthetic|food_grade_grease|food_grade_oil');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `lubrication_event_status` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Event Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `lubrication_event_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|deferred');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `maintenance_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Maintenance Interval (Days)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Lubrication Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Event Notes');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `quantity_applied` SET TAGS ('dbx_business_glossary_term' = 'Lubricant Quantity Applied');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `safety_data_sheet_version` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Version');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Lubricant Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'ml|g|oz');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lubrication_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `asset_replacement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Replacement Plan ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `superseded_asset_replacement_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'proposed|approved|deferred|cancelled');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `asset_replacement_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Lifecycle Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `asset_replacement_plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|archived');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Amount');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `capex_project_reference` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Project Reference');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `current_asset_age_years` SET TAGS ('dbx_business_glossary_term' = 'Current Asset Age (Years)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `depreciation_period_years` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Period (Years)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `estimated_refurbishment_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Refurbishment Cost');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `estimated_replacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Replacement Cost');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `expected_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Savings Amount');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal|external|grant');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `justification_narrative` SET TAGS ('dbx_business_glossary_term' = 'Justification Narrative');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Replacement Plan Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `planned_replacement_year` SET TAGS ('dbx_business_glossary_term' = 'Planned Replacement Year');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `priority_ranking` SET TAGS ('dbx_business_glossary_term' = 'Priority Ranking');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `replacement_trigger` SET TAGS ('dbx_business_glossary_term' = 'Replacement Trigger');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `replacement_trigger` SET TAGS ('dbx_value_regex' = 'age|condition_score|reliability_failure|obsolescence|regulatory');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `replacement_type` SET TAGS ('dbx_business_glossary_term' = 'Replacement Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `replacement_type` SET TAGS ('dbx_value_regex' = 'like_for_like|upgrade|technology_change');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_replacement_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` SET TAGS ('dbx_subdomain' = 'maintenance_planning');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `maintenance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Budget Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `maintenance_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `parent_maintenance_budget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `actual_contractor_cost_ytd` SET TAGS ('dbx_business_glossary_term' = 'Actual Contractor Cost Year‑to‑Date (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `actual_labor_cost_ytd` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost Year‑to‑Date (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `actual_material_cost_ytd` SET TAGS ('dbx_business_glossary_term' = 'Actual Material Cost Year‑to‑Date (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|approved|closed');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'annual_plan|revised_forecast|rolling_12_month');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Category');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_value_regex' = 'preventive|corrective|predictive|shutdown|contractor|spare_parts');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `planned_contractor_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Contractor Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `planned_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Labor Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `planned_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Material Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter (QTR)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `total_actual_cost_ytd` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Cost Year‑to‑Date (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `total_planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`maintenance_budget` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_round_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Round ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Crew ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `previous_inspection_round_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Area Code');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Minutes)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_round_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Round Status');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_round_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|overdue|cancelled');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `is_autonomous` SET TAGS ('dbx_business_glossary_term' = 'Autonomous Maintenance Flag');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Round Notes');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `number_of_defects` SET TAGS ('dbx_business_glossary_term' = 'Number of Defects Found');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `number_of_inspection_points` SET TAGS ('dbx_business_glossary_term' = 'Number of Inspection Points');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `number_of_work_orders` SET TAGS ('dbx_business_glossary_term' = 'Number of Work Orders Raised');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Inspection Round Priority Level');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `round_name` SET TAGS ('dbx_business_glossary_term' = 'Inspection Round Name');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `round_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Round Number');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `round_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Round Type');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `round_type` SET TAGS ('dbx_value_regex' = 'operator_care|maintenance_inspection|safety_inspection|hygiene_inspection|pre_startup_check');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `route_description` SET TAGS ('dbx_business_glossary_term' = 'Route Description');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `scheduled_frequency` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Frequency');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `scheduled_frequency` SET TAGS ('dbx_value_regex' = 'hourly|per_shift|daily|weekly|monthly');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `inspection_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Finding Identifier (IFID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (AssetID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Team Identifier (ITID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolved By Identifier (RBI)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `inspection_round_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Round Identifier (IRID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (WOID)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `related_inspection_finding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BN)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments (CM)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard (CS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'FDA|GFSI|ISO22000|USDA|EFSA|FSSC22000');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description (CAD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CADD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `equipment_tag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tag (ET)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `finding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Observation Timestamp (FOT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type (FT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'defect|abnormality|safety_hazard|hygiene_issue|near_miss|improvement_opportunity');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Due Date (FUD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required Flag (FURF)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `inspection_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description (FD)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `inspection_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status (FST)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `inspection_finding_status` SET TAGS ('dbx_value_regex' = 'open|work_order_raised|resolved|accepted_risk');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method (IM)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'visual|automated|sensor');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `is_repeat_finding` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Indicator (RFI)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LN)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `photo_evidence_flag` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence Flag (PEF)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PL)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product SKU (SKU)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (RCF)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (RR)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp (RT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code (RCC)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `safety_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Required Flag (SPRF)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity (FS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_QM|MES|TraceGains|Custom');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`inspection_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lube_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lube_point` SET TAGS ('dbx_subdomain' = 'maintenance_planning');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lube_point` ALTER COLUMN `lube_point_id` SET TAGS ('dbx_business_glossary_term' = 'Lube Point Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lube_point` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`lube_point` ALTER COLUMN `parent_lube_point_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_group` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_group` ALTER COLUMN `asset_group_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Group Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`asset_group` ALTER COLUMN `parent_asset_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_template` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_template` ALTER COLUMN `work_order_template_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Template Identifier');
ALTER TABLE `food_beverage_ecm`.`maintenance`.`work_order_template` ALTER COLUMN `parent_work_order_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
