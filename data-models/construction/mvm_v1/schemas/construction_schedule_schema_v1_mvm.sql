-- Schema for Domain: schedule | Business: Construction | Version: v1_mvm
-- Generated on: 2026-05-07 09:27:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `construction_ecm`.`schedule` COMMENT 'Project scheduling domain managing CPM (Critical Path Method) networks, activity sequencing, resource leveling, critical path analysis, progress tracking, baseline comparisons, look-ahead plans, and schedule performance metrics (SPI). Integrates with Oracle Primavera P6 for schedule exports and EVM (Earned Value Management) for project control.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`activity` (
    `activity_id` BIGINT COMMENT 'Unique system-generated identifier for the schedule activity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Construction activities are executed under a specific contract agreement. Direct activity-to-contract traceability is required for progress reporting, payment certification, and EOT claim substantiati',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Needed for project status dashboards that aggregate activity progress per construction project; each activity must be directly linked to its project.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Each activity has a designated foreman/supervisor responsible for safety and execution; needed for safety incident reporting and activity oversight.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Construction activities are executed against specific drawings (e.g., Install rebar per drawing S-201). Look-ahead planning, field execution, and as-built tracking all require activity-to-drawing li',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Environmental impact assessments are tied to specific construction activities (e.g., earthworks) for regulatory reporting and mitigation planning.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Cost coding of schedule activities for budgeting and earned value reporting requires linking each activity to a finance cost_code entity.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Permit compliance tracking: each scheduled activity must reference the required construction permit to ensure legal start and permit status monitoring.',
    `project_baseline_id` BIGINT COMMENT 'Identifier of the schedule baseline to which this activity belongs.',
    `schedule_calendar_id` BIGINT COMMENT 'Identifier of the calendar to which the activity is assigned.',
    `scope_id` BIGINT COMMENT 'Foreign key linking to contract.contract_scope. Business justification: Schedule activities are performed within a defined contract scope item. This link enables scope-activity traceability required for progress measurement, payment certification, and variation assessment',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Activities are governed by technical specifications (e.g., concrete pour activity references spec section 03300 for mix design and curing). Schedulers confirm specification readiness before activity s',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Schedule activities are executed under specific trade packages — this is fundamental to subcontract management, progress payment certification, and scope verification. Construction schedulers assign e',
    `wbs_element_id` BIGINT COMMENT 'FK to project.wbs_element.wbs_element_id — Core project-centric reporting spine: every schedule activity must link to a WBS element for earned value, progress reporting, and cost integration. Without this FK, schedule-to-project reporting is b',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Activities belong to a WBS node; linking provides hierarchy and removes redundant wbs_code column.',
    `activity_code` STRING COMMENT 'Business identifier code assigned to the activity (e.g., unique activity number).',
    `activity_description` STRING COMMENT 'Detailed textual description of the work to be performed.',
    `activity_name` STRING COMMENT 'Human‑readable name or title of the activity.',
    `activity_status` STRING COMMENT 'Current lifecycle status of the activity.. Valid values are `not_started|in_progress|completed|suspended|cancelled`',
    `activity_type` STRING COMMENT 'Classification of the activity based on its nature (task‑dependent, resource‑dependent, level of effort, or milestone).. Valid values are `task_dependent|resource_dependent|level_of_effort|milestone`',
    `actual_finish_date` DATE COMMENT 'Date the activity actually finished.',
    `actual_start_date` DATE COMMENT 'Date the activity actually started.',
    `constraint_date` DATE COMMENT 'Date associated with the scheduling constraint, if applicable.',
    `constraint_type` STRING COMMENT 'Scheduling constraint applied to the activity.. Valid values are `asap|start_no_earlier_than|finish_no_later_than|mandatory|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the activity record was first created.',
    `critical_path_flag` BOOLEAN COMMENT 'True if the activity lies on the critical path.',
    `free_float_days` STRING COMMENT 'Free float available for the activity in days.',
    `original_duration_days` STRING COMMENT 'Planned duration of the activity in calendar days at creation.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current percent complete of the activity (0‑100).',
    `planned_finish_date` DATE COMMENT 'Scheduled finish date as originally planned.',
    `planned_start_date` DATE COMMENT 'Scheduled start date as originally planned.',
    `remaining_duration_days` STRING COMMENT 'Remaining duration in days based on current progress.',
    `total_float_days` STRING COMMENT 'Total float available for the activity in days.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the activity record.',
    CONSTRAINT pk_activity PRIMARY KEY(`activity_id`)
) COMMENT 'Core CPM (Critical Path Method) schedule activity representing a discrete unit of work within a project WBS. Captures activity ID, name, WBS code, activity type (task-dependent, resource-dependent, level of effort, milestone), planned/actual start and finish dates, original duration, remaining duration, percent complete, calendar assignment, constraint types (start-no-earlier-than, finish-no-later-than, mandatory), float values (total float, free float), critical path flag, activity status (not started, in progress, completed, suspended), and activity code assignments for filtering and grouping. The foundational scheduling entity from which all schedule analysis, critical path calculation, and progress measurement derives.';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`activity_relationship` (
    `activity_relationship_id` BIGINT COMMENT 'System-generated unique identifier for the activity relationship record.',
    `activity_id` BIGINT COMMENT 'Identifier of the predecessor activity in the CPM network.',
    `activity_relationship_description` STRING COMMENT 'Free-text notes or comments describing the purpose or special conditions of the relationship.',
    `activity_relationship_status` STRING COMMENT 'Current lifecycle status of the relationship record.. Valid values are `active|inactive|deleted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the relationship record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the relationship becomes effective in the schedule.',
    `effective_until` DATE COMMENT 'Date when the relationship expires or is no longer valid (nullable).',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether this relationship lies on the projects critical path (true) or not (false).',
    `is_driving` BOOLEAN COMMENT 'Flag indicating whether this relationship drives the schedule logic (true) or is a passive link (false).',
    `lag_duration` DECIMAL(18,2) COMMENT 'Numeric amount of lag (or lead if negative) applied to the relationship, expressed in the units defined by lag_time_unit.',
    `lag_time_unit` STRING COMMENT 'Unit of measure for lag_duration (e.g., days, hours, minutes).. Valid values are `days|hours|minutes`',
    `relationship_source` STRING COMMENT 'Origin of the relationship record: exported from scheduling tool or entered manually.. Valid values are `system_export|manual_entry`',
    `relationship_type` STRING COMMENT 'Logical dependency type defining how the predecessor and successor activities are linked.. Valid values are `FS|SS|FF|SF`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the relationship record.',
    CONSTRAINT pk_activity_relationship PRIMARY KEY(`activity_relationship_id`)
) COMMENT 'Logical dependency links between schedule activities defining the CPM network logic. Captures predecessor and successor activity references, relationship type (Finish-to-Start, Start-to-Start, Finish-to-Finish, Start-to-Finish), lag/lead duration, lag time unit, driving relationship flag, and relationship source (scheduling tool export, manual entry). Enables critical path calculation, schedule network analysis, and what-if scenario modeling for delay impact assessment.';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`schedule_baseline` (
    `schedule_baseline_id` BIGINT COMMENT 'System-generated unique identifier for the schedule baseline record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: A schedule baseline is formally accepted and incorporated into the contract agreement as the contractual programme. In construction, the accepted baseline is a contract document; linking schedule_base',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which this baseline belongs.',
    `project_engagement_id` BIGINT COMMENT 'Foreign key linking to client.project_engagement. Business justification: Contractual baseline approval: the approved schedule baseline is a contractual deliverable under the client engagement. Linking enables direct traceability for EOT and variation claims, and supports c',
    `approval_date` DATE COMMENT 'Date on which the baseline was formally approved for use.',
    `baseline_type` STRING COMMENT 'Classification of the baseline indicating its purpose: original contract baseline, current working baseline, or supplemental revision.. Valid values are `original|current|supplemental`',
    `bcws_amount` DECIMAL(18,2) COMMENT 'Monetary value of work scheduled in the baseline, used for Earned Value calculations.',
    `change_reason` STRING COMMENT 'Reason or justification for creating a supplemental or revised baseline.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the baseline record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values in the baseline.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `data_date` DATE COMMENT 'The date representing the snapshot of schedule data used to create the baseline.',
    `finish_date` DATE COMMENT 'Planned finish date of the schedule baseline.',
    `is_current` BOOLEAN COMMENT 'Indicates whether this baseline is the active baseline for schedule comparisons.',
    `revision_date` DATE COMMENT 'Date on which the baseline was last revised or re‑baselined.',
    `schedule_baseline_description` STRING COMMENT 'Free‑form text describing the purpose, scope, or notable characteristics of the baseline.',
    `schedule_baseline_name` STRING COMMENT 'Human‑readable name given to the schedule baseline (e.g., "Original Contract Baseline").',
    `schedule_baseline_status` STRING COMMENT 'Current lifecycle state of the baseline record.. Valid values are `draft|approved|rejected|archived`',
    `schedule_tool_project_ref` STRING COMMENT 'External identifier of the project within the scheduling tool (e.g., Primavera project code).',
    `source_system` STRING COMMENT 'The originating scheduling system that generated the baseline.. Valid values are `primavera|sap|other`',
    `start_date` DATE COMMENT 'Planned start date of the schedule baseline.',
    `total_duration_days` STRING COMMENT 'Calculated total duration of the baseline in calendar days.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the baseline record.',
    `version_number` STRING COMMENT 'Sequential version number indicating the order of baseline revisions.',
    CONSTRAINT pk_schedule_baseline PRIMARY KEY(`schedule_baseline_id`)
) COMMENT 'Approved project schedule baseline snapshot capturing the time-phased plan against which actual progress is measured. Stores baseline name, baseline type (original, current, supplemental), approval date, approved-by reference, baseline start and finish dates, total baseline duration, baseline data date, and scheduling tool baseline project reference. Supports EVM (Earned Value Management) calculations including BCWS (Budgeted Cost of Work Scheduled) and variance analysis. Multiple baselines per project are supported (original contract baseline, re-baselined approved revisions).';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`baseline_activity` (
    `baseline_activity_id` BIGINT COMMENT 'Unique surrogate key for the baseline activity record.',
    `activity_id` BIGINT COMMENT 'Reference to the master activity definition (work breakdown element).',
    `itp_line_id` BIGINT COMMENT 'Foreign key linking to quality.itp_line. Business justification: Baseline activity durations in construction are planned to include ITP hold point and witness point durations from specific ITP lines. Baseline planning and schedule validation reports reference ITP l',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: baseline_activity is a frozen snapshot of activity data captured at a specific baseline approval. It currently references project.project_baseline (cross-domain) but has no FK to schedule.schedule_bas',
    `wbs_node_id` BIGINT COMMENT 'Identifier of the WBS element that groups this activity.',
    `baseline_activity_status` STRING COMMENT 'Current lifecycle status of the activity within the baseline.. Valid values are `planned|in_progress|completed|on_hold|cancelled`',
    `baseline_constraint_date` DATE COMMENT 'Date associated with the constraint type, if applicable.',
    `baseline_constraint_type` STRING COMMENT 'Scheduling constraint applied to the activity in the baseline.. Valid values are `as_soon_as_possible|start_on|finish_on|must_start_on|must_finish_on|none`',
    `baseline_cost` DECIMAL(18,2) COMMENT 'Planned cost for the activity as captured in the approved baseline.',
    `baseline_cost_variance` DECIMAL(18,2) COMMENT 'Difference between actual cost incurred and baseline cost estimate.',
    `baseline_early_finish` DATE COMMENT 'Earliest possible finish date for the activity in the approved baseline.',
    `baseline_early_start` DATE COMMENT 'Earliest possible start date for the activity in the approved baseline.',
    `baseline_is_critical` BOOLEAN COMMENT 'True if the activity lies on the critical path of the baseline schedule.',
    `baseline_late_finish` DATE COMMENT 'Latest permissible finish date for the activity in the approved baseline.',
    `baseline_late_start` DATE COMMENT 'Latest permissible start date for the activity in the approved baseline.',
    `baseline_milestone_flag` BOOLEAN COMMENT 'Indicates whether the activity is defined as a milestone in the baseline.',
    `baseline_original_duration` STRING COMMENT 'Planned duration of the activity at baseline approval, expressed in whole days.',
    `baseline_percent_complete` DECIMAL(18,2) COMMENT 'Planned percentage of work completed for the activity at the baseline snapshot.',
    `baseline_remaining_duration` STRING COMMENT 'Remaining planned duration as of the latest progress update, based on the baseline.',
    `baseline_resource_type` STRING COMMENT 'Category of resources assigned to the activity in the baseline.. Valid values are `labor|equipment|material|subcontractor`',
    `baseline_resource_units` DECIMAL(18,2) COMMENT 'Total resource units (e.g., labor hours, equipment hours) planned for the activity in the baseline.',
    `baseline_schedule_variance` STRING COMMENT 'Difference between actual start/finish and baseline dates, expressed in days.',
    `baseline_total_float` STRING COMMENT 'Amount of scheduling flexibility (float) for the activity in the baseline, expressed in days.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the baseline activity record was created in the data lake.',
    `line_sequence` STRING COMMENT 'Sequential order of the activity within the baseline schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the baseline activity record.',
    CONSTRAINT pk_baseline_activity PRIMARY KEY(`baseline_activity_id`)
) COMMENT 'Baseline-frozen snapshot of each activitys planned dates, durations, and resource assignments at the time a schedule baseline was approved. Stores baseline early start, baseline early finish, baseline late start, baseline late finish, baseline original duration, baseline remaining duration, baseline percent complete, and baseline total float for each activity within a specific baseline. Enables schedule variance analysis (SV = BCWP - BCWS) and start/finish variance reporting against the approved plan.';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`resource` (
    `resource_id` BIGINT COMMENT 'Primary key for resource',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Resource Costing & Compliance: tying resource equipment_category to the master asset_category allows accurate cost rates, depreciation tracking, and regulatory reporting on equipment usage.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Each resource type (labor, plant, material) maps to a cost_code for job costing. The plain cost_account_code on resource is a denormalized representation of finance.cost_code. Proper FK enables automa',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Schedule resources often represent individual workers; linking enables labor allocation reports and compliance with union and safety regulations.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.master. Business justification: Construction scheduling tools (P6, MS Project) model materials as schedule resources. schedule.resource has a denormalized material_category. Linking resource to material.master enables material resou',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Resources (workers, equipment) are subject to specific regulatory obligations (e.g., asbestos removal workers under EPA regulations, crane operators under WorkSafe obligations). The existing plain-tex',
    `schedule_calendar_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_calendar. Business justification: resource has a calendar_name STRING attribute that is a denormalized reference to the schedule_calendar table. Resources in Primavera P6 are assigned work calendars that define their availability (wor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: RESOURCE PLANNING: External subcontractor/vendor provides the resource; procurement contracts vendor, schedule assigns resource to activities. Linking enables traceability of vendor‑supplied labor/equ',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Planned availability of the resource expressed as a percent of total time.',
    `billing_rate_per_hour` DECIMAL(18,2) COMMENT 'Rate used for billing external parties for labor resources.',
    `certification_requirements` STRING COMMENT 'Required certifications or trainings for the resource (e.g., OSHA, LEED).',
    `cost_center` STRING COMMENT 'Organizational cost centre responsible for the resource.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the resource record was first created in the system.',
    `default_units_per_time` DECIMAL(18,2) COMMENT 'Default allocation quantity when the resource is assigned without explicit units.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the resource over its useful life.. Valid values are `straight_line|declining_balance`',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `effective_end_date` DATE COMMENT 'Date when the resource is no longer available (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the resource becomes available for scheduling.',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Score reflecting the resources environmental impact (e.g., emissions, waste).',
    `is_external` BOOLEAN COMMENT 'True if the resource is provided by an external subcontractor or supplier.',
    `is_overtime_allowed` BOOLEAN COMMENT 'Indicates whether overtime work is permitted for this resource.',
    `labor_category` STRING COMMENT 'Category of labor (e.g., skilled, unskilled, supervisory).',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date‑time when the resource was last assigned to an activity.',
    `lead_time_days` STRING COMMENT 'Number of days required to procure or mobilize the resource.',
    `max_concurrent_assignments` STRING COMMENT 'Maximum number of activities the resource can be assigned to simultaneously.',
    `max_units_per_period` DECIMAL(18,2) COMMENT 'Maximum quantity of the resource that can be allocated in a scheduling period.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the resource.',
    `overtime_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to the price when the resource works overtime.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Cost charged for one unit of the resource, used for cost‑loaded schedules.',
    `procurement_source` STRING COMMENT 'Indicates whether the resource is sourced internally or from an external vendor.. Valid values are `internal|external`',
    `resource_code` STRING COMMENT 'External identifier or catalogue number for the resource.',
    `resource_description` STRING COMMENT 'Free‑form description providing additional context about the resource.',
    `resource_name` STRING COMMENT 'Human‑readable name of the resource as used in schedules.',
    `resource_role` STRING COMMENT 'Functional role of the resource in the project (e.g., carpenter, electrician).',
    `resource_status` STRING COMMENT 'Current lifecycle status of the resource.. Valid values are `active|inactive|retired|planned`',
    `resource_type` STRING COMMENT 'Classification of the resource (e.g., labor, material, equipment, subcontractor).. Valid values are `labor|material|equipment|subcontractor`',
    `safety_rating` STRING COMMENT 'Safety classification of the resource based on internal assessments.. Valid values are `A|B|C|D|E`',
    `site_location` STRING COMMENT 'Identifier of the construction site or location where the resource is primarily used.',
    `skill_set` STRING COMMENT 'Comma‑separated list of skills or competencies associated with the resource.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the resource (e.g., hour, day, kilogram).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the resource record.',
    `utilization_rate` DECIMAL(18,2) COMMENT 'Historical or planned utilization of the resource expressed as a percent.',
    CONSTRAINT pk_resource PRIMARY KEY(`resource_id`)
) COMMENT 'Resource definitions assigned to schedule activities for resource-loaded scheduling and leveling. Captures resource name, resource type (labor, non-labor, material), unit of measure, max units per time period, default units per time, price per unit, resource calendar, overtime factor, and resource role. Sourced from the enterprise scheduling tool resource dictionary. Supports resource leveling, resource histograms, and cost-loaded schedule generation. Distinct from workforce employee records — this is the scheduling resource abstraction used for capacity planning and EVM cost loading.';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` (
    `activity_resource_assignment_id` BIGINT COMMENT 'System-generated unique identifier for the resource assignment to an activity.',
    `activity_id` BIGINT COMMENT 'Identifier of the project activity to which the resource is assigned.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Equipment Assignment Planning: linking each activity resource assignment to a specific asset enables the Equipment Allocation Report and ensures compliance with the daily equipment utilization schedul',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Resource assignments are charged to cost centers; linking enables accurate cost allocation and financial reporting per cost center.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Posting resource assignment costs to GL accounts requires linking assignments to finance.gl_account for proper ledger entries.',
    `job_cost_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.job_cost_transaction. Business justification: Resource assignments generate actual cost postings as job_cost_transactions when timesheets, plant returns, and material issues are processed. Linking assignment to transaction enables actual vs. plan',
    `resource_id` BIGINT COMMENT 'Identifier of the resource (labor, equipment, material, etc.) assigned to the activity.',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Tracks which subcontract provides the assigned resources, enabling accurate cost allocation and subcontractor performance analysis.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Cost incurred to date for the resource consumption.',
    `actual_finish_date` DATE COMMENT 'Date when the resource actually completed work on the activity.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Resource units actually consumed to date.',
    `actual_start_date` DATE COMMENT 'Date when the resource actually began work on the activity.',
    `approval_status` STRING COMMENT 'Current approval state of the assignment.. Valid values are `pending|approved|rejected`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the resource assignment.. Valid values are `planned|active|completed|closed|cancelled|on_hold`',
    `change_order_number` STRING COMMENT 'Reference to a change order that modified this assignment.',
    `compliance_status` STRING COMMENT 'Indicates whether the assignment meets regulatory or contract compliance requirements.. Valid values are `compliant|non_compliant|exempt`',
    `cost_account_code` STRING COMMENT 'Accounting code used for cost allocation of this assignment.',
    `cost_rate` DECIMAL(18,2) COMMENT 'Standard cost per unit of the resource (e.g., $ per hour).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was first created.',
    `distribution_curve` STRING COMMENT 'Shape of the resource loading over time for the assignment.. Valid values are `front_loaded|back_loaded|bell|linear|custom|none`',
    `finish_date` DATE COMMENT 'Scheduled finish date for the resource on the activity.',
    `is_critical_path` BOOLEAN COMMENT 'True if the assignment lies on the project’s critical path.',
    `labor_category` STRING COMMENT 'Classification of labor skill level for the assigned resource.. Valid values are `skilled|unskilled|supervisor|foreman|other`',
    `line_sequence` STRING COMMENT 'Sequential order of the assignment within the activity.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the assignment.',
    `overtime_quantity` DECIMAL(18,2) COMMENT 'Additional resource units worked as overtime.',
    `overtime_rate` DECIMAL(18,2) COMMENT 'Cost per overtime unit of the resource.',
    `planned_cost` DECIMAL(18,2) COMMENT 'Budgeted cost associated with the planned quantity of the resource.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Budgeted amount of resource units (e.g., hours, cubic meters) planned for the assignment.',
    `remaining_cost` DECIMAL(18,2) COMMENT 'Budgeted cost minus actual cost, representing cost remaining.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Planned units minus actual units, representing work left.',
    `resource_location` STRING COMMENT 'Site or location where the resource is deployed for the activity.',
    `resource_role` STRING COMMENT 'Specific role the resource performs on the activity.. Valid values are `foreman|operator|installer|inspector|supervisor|other`',
    `resource_type` STRING COMMENT 'Category of the assigned resource (e.g., labor, equipment).. Valid values are `labor|equipment|material|subcontractor|tool|other`',
    `safety_risk_level` STRING COMMENT 'Risk classification for safety associated with the assignment.. Valid values are `low|medium|high|critical`',
    `start_date` DATE COMMENT 'Scheduled start date for the resource on the activity.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., hours, cubic meters).. Valid values are `hours|days|m3|kg|units|percent`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assignment record.',
    `wbs_code` STRING COMMENT 'WBS element to which the assignment belongs.',
    CONSTRAINT pk_activity_resource_assignment PRIMARY KEY(`activity_resource_assignment_id`)
) COMMENT 'Assignment of a schedule resource to a specific activity, capturing the planned and actual resource consumption. Stores assigned resource reference, activity reference, budgeted units, actual units to date, remaining units, budgeted cost, actual cost, remaining cost, resource distribution curve (front-loaded, back-loaded, bell, linear), overtime units, and assignment status. Enables resource-loaded schedule analysis, cost-loaded CPM, and EVM BCWP (Budgeted Cost of Work Performed) calculations.';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`wbs_node` (
    `wbs_node_id` BIGINT COMMENT 'System-generated unique identifier for the WBS node.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the parent project to which the WBS belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: WBS nodes are allocated to cost centers for budgeting; linking provides cost‑center roll‑up for each WBS element.',
    `parent_wbs_wbs_node_id` BIGINT COMMENT 'Identifier of the immediate parent WBS node; null for top‑level nodes.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: WBS nodes representing permit-gated work packages (e.g., Earthworks — Zone A requiring specific excavation permit) must reference the applicable permit. Construction project controls use this for pe',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: WBS work packages are scoped against specific regulatory obligations (e.g., Environmental Mitigation Works WBS element tied to EPA obligation). This link supports compliance cost tracking by WBS, re',
    `actual_cost` DECIMAL(18,2) COMMENT 'Cost incurred to date for the node.',
    `actual_duration_days` STRING COMMENT 'Actual elapsed days from start to finish.',
    `actual_finish_date` DATE COMMENT 'Date when work actually completed for the node.',
    `actual_start_date` DATE COMMENT 'Date when work actually commenced on the node.',
    `baseline_finish_date` DATE COMMENT 'Baseline finish date used for Earned Value Management comparisons.',
    `baseline_start_date` DATE COMMENT 'Baseline start date used for Earned Value Management comparisons.',
    `budgeted_cost` DECIMAL(18,2) COMMENT 'Original cost estimate for the node before any revisions.',
    `change_order_indicator` BOOLEAN COMMENT 'True if the node has been impacted by a change order.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the WBS node record was created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether the node lies on the projects critical path.',
    `deleted_flag` BOOLEAN COMMENT 'True if the node has been logically deleted; false otherwise.',
    `earned_value_method` STRING COMMENT 'Technique used to calculate earned value for the node.. Valid values are `fixed_formula|percent_complete|weighted_milestones|level_of_effort`',
    `external_reference` STRING COMMENT 'Identifier of the node in external systems (e.g., Primavera activity ID).',
    `is_milestone` BOOLEAN COMMENT 'True if the node represents a project milestone.',
    `notes` STRING COMMENT 'Free‑form notes or comments captured by planners.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current progress expressed as a percentage of total planned effort.',
    `planned_cost` DECIMAL(18,2) COMMENT 'Budgeted cost allocated to the node.',
    `planned_duration_days` STRING COMMENT 'Planned duration of the node in calendar days.',
    `planned_finish_date` DATE COMMENT 'Scheduled finish date as originally planned.',
    `planned_start_date` DATE COMMENT 'Scheduled start date as originally planned.',
    `risk_level` STRING COMMENT 'Qualitative risk rating assigned to the node.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the WBS node record.',
    `wbs_code` STRING COMMENT 'Unique hierarchical code assigned to the WBS node, used for identification and reporting.',
    `wbs_level` STRING COMMENT 'Depth of the node within the WBS hierarchy (1 = top level).',
    `wbs_name` STRING COMMENT 'Descriptive name of the WBS node representing the scope element.',
    `wbs_node_description` STRING COMMENT 'Detailed textual description of the scope element.',
    `wbs_node_status` STRING COMMENT 'Current lifecycle status of the WBS node.. Valid values are `planned|active|completed|on_hold|cancelled`',
    `wbs_type` STRING COMMENT 'Classification of the node (e.g., project summary, work package, activity, milestone).. Valid values are `project_summary|wbs_summary|work_package|control_account|activity|milestone`',
    CONSTRAINT pk_wbs_node PRIMARY KEY(`wbs_node_id`)
) COMMENT 'Work Breakdown Structure (WBS) hierarchy node defining the decomposition of project scope into manageable components. Captures WBS code, WBS name, WBS level, parent WBS reference, WBS type (project summary, WBS summary, work package), anticipated start and finish dates, earned value technique (fixed formula, percent complete, weighted milestones, level of effort), and WBS status. Provides the hierarchical framework for schedule organization, cost control, progress reporting, and EVM roll-up calculations.';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`schedule_calendar` (
    `schedule_calendar_id` BIGINT COMMENT 'System-generated unique identifier for the work calendar.',
    `break_time_minutes_per_day` STRING COMMENT 'Total minutes of mandatory break time deducted from the workday.',
    `calendar_category` STRING COMMENT 'Higher‑level grouping of calendars for reporting (standard, custom, or regional).. Valid values are `standard|custom|regional`',
    `calendar_code` STRING COMMENT 'Business identifier or code assigned to the calendar (e.g., "CAL‑US‑NY").',
    `calendar_name` STRING COMMENT 'Human‑readable name of the calendar used in scheduling tools.',
    `calendar_type` STRING COMMENT 'Classification of the calendar: global (company‑wide), project‑specific, or resource‑specific.. Valid values are `global|project|resource`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calendar record was first created in the source system.',
    `effective_end_date` DATE COMMENT 'Date on which the calendar ceases to be active; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the calendar becomes active for scheduling calculations.',
    `holiday_exceptions` STRING COMMENT 'Comma‑separated list or description of holidays and non‑working dates that override the regular schedule.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this calendar is the default for its scope.',
    `max_overtime_hours_per_day` DECIMAL(18,2) COMMENT 'Upper limit of overtime hours that can be applied in a single day.',
    `overtime_allowed` BOOLEAN COMMENT 'Indicates if overtime hours may be scheduled under this calendar.',
    `schedule_calendar_description` STRING COMMENT 'Free‑form description providing additional context about the calendar.',
    `schedule_calendar_status` STRING COMMENT 'Current lifecycle status of the calendar.. Valid values are `active|inactive|archived|pending`',
    `shift_pattern` STRING COMMENT 'Definition of work shifts applied to the calendar.. Valid values are `single|double|custom`',
    `source_system` STRING COMMENT 'Name of the originating system (e.g., "Primavera P6").',
    `timezone` STRING COMMENT 'IANA time‑zone identifier (e.g., "America/New_York") that the calendar operates in.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the calendar record.',
    `version_number` STRING COMMENT 'Incremental version of the calendar definition for change tracking.',
    `work_days_per_week` STRING COMMENT 'Number of days in a week that are considered working days.',
    `work_hours_per_day` DECIMAL(18,2) COMMENT 'Standard number of productive hours defined for a typical workday.',
    `work_week_definition` STRING COMMENT 'Encoded representation (e.g., JSON string) of which days of the week are working days.',
    CONSTRAINT pk_schedule_calendar PRIMARY KEY(`schedule_calendar_id`)
) COMMENT 'Work calendars defining working and non-working time periods used in schedule calculations. Captures calendar name, calendar type (global, project, resource), standard work hours per day, work week definition (working days per week), holiday exceptions, shift patterns, and time zone. Imported from the enterprise scheduling tool calendar configuration. Determines activity duration calculations, float computations, and resource availability windows. Critical for multi-site international projects operating across different regional calendars and public holiday schedules.';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`progress_update` (
    `progress_update_id` BIGINT COMMENT 'Unique surrogate key for the schedule progress update record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Progress updates are submitted under a specific contract agreement for interim payment certification. Construction contracts require periodic progress reports tied to the contract; this link enables p',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which this progress update belongs.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Progress updates drive Earned Value calculations (BCWP, SPI, SV) that must reconcile against the approved project_budget. Finance teams join progress_update to project_budget for period-end EVM report',
    `project_engagement_id` BIGINT COMMENT 'Foreign key linking to client.project_engagement. Business justification: Client progress reporting: project_engagement defines reporting_frequency and satisfaction_score. Linking progress_update to project_engagement enables client-facing reporting dashboards and satisfact',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: EVM metrics (BCWP, BCWS, SPI, SV) in progress_update are only meaningful when measured against a specific approved baseline. Without a FK to schedule_baseline, it is impossible to determine which base',
    `actual_finish_date` DATE COMMENT 'Actual finish date of the activity or work package as of this reporting period.',
    `actual_start_date` DATE COMMENT 'Actual start date of the activity or work package as of this reporting period.',
    `actual_units` DECIMAL(18,2) COMMENT 'Actual quantity of work units performed (e.g., labor hours, cubic meters).',
    `bcwp` DECIMAL(18,2) COMMENT 'Earned Value (BCWP) in project currency.',
    `bcws` DECIMAL(18,2) COMMENT 'Planned Value (BCWS) in project currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the progress update record was initially created in the system.',
    `critical_activity_count` STRING COMMENT 'Number of activities currently on the critical path.',
    `critical_path_completion_date` DATE COMMENT 'Estimated completion date of the critical path at this reporting period.',
    `forecast_completion_date` DATE COMMENT 'Projected date for project completion based on current performance trends.',
    `is_critical_path_changed` BOOLEAN COMMENT 'Flag indicating whether the critical path has changed compared to the previous reporting period.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations related to the progress update.',
    `path_drift_indicator` STRING COMMENT 'Indicator of whether the critical path is on schedule, drifting, or off track.. Valid values are `on_track|drift|off_track`',
    `percent_complete_duration` DECIMAL(18,2) COMMENT 'Percentage of duration completed (0-100).',
    `percent_complete_units` DECIMAL(18,2) COMMENT 'Percentage of work units completed (0-100).',
    `period_number` STRING COMMENT 'Sequential number of the reporting period within the project schedule.',
    `progress_update_status` STRING COMMENT 'Current lifecycle status of the progress update record.. Valid values are `draft|submitted|approved|rejected`',
    `remaining_duration` STRING COMMENT 'Remaining duration in days for the activity or work package.',
    `remaining_units` DECIMAL(18,2) COMMENT 'Remaining quantity of work units to be performed.',
    `reporting_date` DATE COMMENT 'Date for which the progress update snapshot is recorded.',
    `reporting_frequency` STRING COMMENT 'Frequency at which progress updates are generated for the project.. Valid values are `daily|weekly|monthly|quarterly|yearly`',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period covered by this update.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period covered by this update.',
    `reporting_status` STRING COMMENT 'Current status of the reporting period (e.g., pending, completed, overdue).. Valid values are `pending|completed|overdue`',
    `spi` DECIMAL(18,2) COMMENT 'Schedule Performance Index calculated as BCWP divided by BCWS.',
    `sv` DECIMAL(18,2) COMMENT 'Schedule Variance (BCWP minus BCWS) in project currency.',
    `sv_percent` DECIMAL(18,2) COMMENT 'Schedule Variance expressed as a percentage of BCWS.',
    `total_float` DECIMAL(18,2) COMMENT 'Total float (slack) in days for the critical path.',
    `update_source` STRING COMMENT 'Origin of the data for this progress update (e.g., field report, Primavera P6 import, HCSS HeavyJob).. Valid values are `field_report|p6_import|heavyjob`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the progress update record.',
    CONSTRAINT pk_progress_update PRIMARY KEY(`progress_update_id`)
) COMMENT 'Periodic schedule progress update record capturing actual performance data, EVM metrics, and critical path state at a specific data date. Stores actual start/finish dates, remaining duration, percent complete (duration, units, physical), actual/remaining units, update source (field report, P6 import, HCSS HeavyJob), reporting period definition (period number, dates, frequency, status), EVM metrics (BCWP, BCWS, SPI, SV, SV%, forecast completion date), and critical path snapshot (project completion date, total float, critical activity count, path drift indicator). Represents the single transactional record of schedule state per reporting period. Enables schedule performance trending, SPI reporting, and critical path monitoring over time.';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`lookahead_plan` (
    `lookahead_plan_id` BIGINT COMMENT 'Unique identifier for the lookahead plan record.',
    `cash_flow_forecast_id` BIGINT COMMENT 'Foreign key linking to finance.cash_flow_forecast. Business justification: The 4–6 week lookahead plan drives short-term cash flow forecasting. Finance teams use lookahead_plan horizon, planned_cost, and readiness_status to build near-term cash_flow_forecast. Construction tr',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which this lookahead plan belongs.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: In Last Planner System (LPS) construction scheduling, each lookahead plan is assigned to a specific crew responsible for executing the planned work front. The lookahead_plan.crew_ready_flag confirms c',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Last Planner System lookahead planning explicitly requires HSE readiness verification against the governing HSE plan before work is committed. Construction planners confirm SWMS, PTW, and TBM requirem',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Last Planner System 3-6 week lookahead plans explicitly track design package readiness as a constraint on planned work. Constraint logs in lookahead planning identify design package not issued as a ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Last Planner System lookahead plans require permit validity checks as a standard constraint before committing work. Construction planners must confirm the applicable permit is active and conditions me',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Lookahead plans must account for upcoming regulatory obligation deadlines as constraints (e.g., noise monitoring submission, heritage inspection). Construction planners use this link to flag regulator',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Lookahead planning in construction requires risk assessments to be completed and approved before work is committed to the short-interval schedule. The readiness_status on lookahead_plan depends on ris',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: A lookahead plan is derived from and measured against a specific approved schedule baseline. The lookahead_plan currently stores schedule_version as a free-text string, which is a denormalized referen',
    `scope_id` BIGINT COMMENT 'Foreign key linking to contract.contract_scope. Business justification: Lookahead plans in construction are prepared for specific contract scope items to ensure resource readiness and constraint removal. Linking lookahead_plan to contract_scope enables project controls te',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Last Planner System lookahead plans are organized by trade package — superintendents confirm trade package readiness (crew_ready_flag, material_ready_flag, equipment_ready_flag) for each package in th',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: A lookahead plan (3-week or 6-week rolling window) is typically scoped to a specific WBS node or work front within the project WBS hierarchy. The lookahead_plan has zone_code and work_front as string ',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Lookahead plans (Last Planner System) are built per work front in construction. The plain work_front string column on lookahead_plan is a clear denormalization of site.work_front. Construction plann',
    `change_order_flag` BOOLEAN COMMENT 'True if any change orders are expected within the lookahead window.',
    `constraint_description` STRING COMMENT 'Detailed description of the identified constraint.',
    `constraint_type` STRING COMMENT 'Primary constraint type affecting the planned work.. Valid values are `material|permit|crew|equipment|weather|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lookahead plan record was created in the system.',
    `crew_ready_flag` BOOLEAN COMMENT 'True if the necessary crew is confirmed available for the lookahead period.',
    `critical_path_flag` BOOLEAN COMMENT 'True if any activity in the lookahead is on the project critical path.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values in the plan.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `end_date` DATE COMMENT 'Last calendar date of the lookahead period.',
    `equipment_ready_flag` BOOLEAN COMMENT 'True if required equipment is confirmed available for the lookahead period.',
    `horizon_weeks` STRING COMMENT 'Number of weeks covered by the lookahead window.',
    `is_lps_enabled` BOOLEAN COMMENT 'True if the lookahead follows the Last Planner System methodology.',
    `material_ready_flag` BOOLEAN COMMENT 'True if all required materials are confirmed available for the lookahead period.',
    `notes` STRING COMMENT 'Free‑text comments or observations related to the lookahead plan.',
    `pending_activities` STRING COMMENT 'Number of activities still pending readiness.',
    `percent_plan_complete` DECIMAL(18,2) COMMENT 'Percentage of planned activities that are ready to be executed (0‑100).',
    `plan_date` DATE COMMENT 'Date on which the lookahead plan was generated.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the lookahead plan.. Valid values are `draft|approved|active|completed|cancelled`',
    `planned_cost` DECIMAL(18,2) COMMENT 'Estimated total cost for the activities in the lookahead period.',
    `ppc_actual_percent` DECIMAL(18,2) COMMENT 'Actual Percent Plan Complete achieved during the lookahead period.',
    `ppc_target_percent` DECIMAL(18,2) COMMENT 'Target Percent Plan Complete (PPC) for the lookahead period.',
    `readiness_status` STRING COMMENT 'Overall readiness status of the work front for execution.. Valid values are `ready|not_ready|partial`',
    `ready_activities` STRING COMMENT 'Number of activities marked as ready for execution.',
    `risk_level` STRING COMMENT 'Overall risk level associated with the lookahead plan.. Valid values are `low|medium|high|critical`',
    `start_date` DATE COMMENT 'First calendar date of the lookahead period.',
    `total_activities` STRING COMMENT 'Total number of activities scheduled in the lookahead window.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lookahead plan record.',
    `weather_impact_flag` BOOLEAN COMMENT 'True if adverse weather conditions are expected to impact the lookahead activities.',
    `zone_code` STRING COMMENT 'Alphanumeric code representing the specific site zone for the plan.',
    CONSTRAINT pk_lookahead_plan PRIMARY KEY(`lookahead_plan_id`)
) COMMENT 'Short-interval look-ahead schedule (typically 3-week or 6-week rolling window) used for near-term construction planning and crew coordination. Captures look-ahead period dates, horizon (weeks), responsible superintendent/foreman, work front or zone, constraint identification, and readiness status (materials, permits, crew, equipment confirmed). Supports Last Planner System (LPS) and Percent Plan Complete (PPC) tracking. Bridges the gap between the master CPM schedule and daily site execution. The header record for lookahead_activity line items.';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`schedule_milestone` (
    `schedule_milestone_id` BIGINT COMMENT 'System‑generated unique identifier for the schedule milestone. _canonical_skip_reason: Entity does not fit a predefined role, treated as OTHER.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: In CPM scheduling, a milestone is typically modeled as a zero-duration activity in the network. schedule_milestone represents contractually significant or internally critical schedule events that corr',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract to which the milestone is tied.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which the milestone belongs.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Milestones are owned by a responsible foreman; linking supports accountability, progress reporting, and compliance audits.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Permit-gated milestones (e.g., Environmental Permit Issued, Construction Permit Obtained) are standard in construction project schedules. Linking the milestone directly to the compliance_permit en',
    `plan_id` BIGINT COMMENT 'Foreign key linking to quality.quality_plan. Business justification: Construction schedule milestones (mechanical completion, ready-for-commissioning, handover) are governed by Quality Plan requirements that define what must be achieved and evidenced before milestone c',
    `project_engagement_id` BIGINT COMMENT 'Foreign key linking to client.project_engagement. Business justification: Client milestone reporting: construction contracts require milestones (NTP, handover, DLP) to be tracked against the specific client engagement for EOT claims, LD exposure reporting, and client satisf',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Schedule milestones frequently represent regulatory obligation deadlines (e.g., EPA clearance milestone, heritage inspection milestone). Construction schedulers and compliance managers jointly track w',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Schedule milestones represent regulatory submission deadlines (e.g., EPA Annual Report Submitted, Noise Monitoring Report Due). Construction project controls teams track milestone achievement agai',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Key construction milestones (commissioning, first energization, handover, hot work commencement) require specific risk assessments as gate conditions. Construction project managers and HSE managers us',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: schedule_milestone stores baseline_date as a snapshot value representing the approved baseline date for the milestone. This baseline_date is only meaningful in the context of a specific approved sched',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Milestones are part of the WBS hierarchy; linking removes redundant wbs_code.',
    `actual_date` DATE COMMENT 'Date the milestone was actually achieved; null if not yet achieved.',
    `baseline_date` DATE COMMENT 'Original baseline date from the approved project schedule before any re‑baselines.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'True if the milestone lies on the projects critical path, affecting overall project duration.',
    `forecast_date` DATE COMMENT 'Most recent forecasted date for milestone completion based on progress and risk analysis.',
    `ld_exposure_flag` BOOLEAN COMMENT 'Indicates whether the milestone triggers liquidated damages if missed.',
    `ld_rate_per_day` DECIMAL(18,2) COMMENT 'Monetary amount charged per day of delay when the LD exposure flag is true.',
    `location` STRING COMMENT 'Physical site or geographic location where the milestone is to be achieved.',
    `planned_date` DATE COMMENT 'Date originally scheduled for the milestone according to the baseline CPM schedule.',
    `risk_level` STRING COMMENT 'Risk rating assigned to the milestone based on impact and probability of delay.. Valid values are `low|medium|high`',
    `schedule_milestone_description` STRING COMMENT 'Detailed narrative describing the purpose and scope of the milestone.',
    `schedule_milestone_name` STRING COMMENT 'Human‑readable name of the milestone as defined in the contract or project plan.',
    `schedule_milestone_status` STRING COMMENT 'Current status of the milestone reflecting progress and risk.. Valid values are `not_started|at_risk|achieved|missed`',
    `schedule_milestone_type` STRING COMMENT 'Classification of the milestone (e.g., contract‑driven, internal project, client‑required, or regulatory).. Valid values are `contract|internal|client|regulatory`',
    `sequence` STRING COMMENT 'Ordinal position of the milestone within the overall schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the milestone record.',
    `variance_days` STRING COMMENT 'Difference in days between planned (or baseline) date and actual/forecast date.',
    CONSTRAINT pk_schedule_milestone PRIMARY KEY(`schedule_milestone_id`)
) COMMENT 'Key project milestone records representing contractually significant or internally critical schedule events with zero duration. Captures milestone name, milestone type (contract milestone, internal milestone, client milestone, regulatory milestone), planned date, forecast date, actual achieved date, milestone status (not started, at risk, achieved, missed), contract reference, liquidated damages (LD) exposure flag, LD rate per day, and milestone owner. Derived from contract schedule requirements and master CPM schedule milestone activities. Enables contract compliance tracking, LD exposure monitoring, and executive schedule reporting.';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`delay_event` (
    `delay_event_id` BIGINT COMMENT 'System-generated unique identifier for the delay event record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Delay events are formally notified under a specific contract agreement per contractual notice provisions. Linking delay_event to agreement enables contract administrators to track all delay notices is',
    `authority_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.authority_notice. Business justification: Stop-work authority notices are a primary cause of construction delay events. Linking delay_event to the authority_notice that triggered it is essential for EOT claim substantiation, dispute resolutio',
    `change_notice_id` BIGINT COMMENT 'Foreign key linking to design.change_notice. Business justification: EOT (Extension of Time) claims and delay analysis require linking delay events to originating design change notices. Claims managers and contract administrators use this link to substantiate employer-',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: Formal delay events must be substantiated by daily log entries that documented the delay as it occurred. Construction contract administrators and claims specialists link delay events to daily logs for',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Unexpected EIA findings (e.g., heritage discovery, contamination) directly cause delay events requiring schedule revision. Construction project controls teams must link the delay to the specific EIA f',
    `hse_inspection_id` BIGINT COMMENT 'Foreign key linking to safety.hse_inspection. Business justification: HSE inspections that issue stop-work orders directly cause schedule delays. Construction project controls teams must link the delay event to the triggering inspection for EOT claims, delay analysis, a',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Safety incidents (LTIs, fatalities, stop-work orders) are a primary cause of schedule delays in construction. EOT claims and delay analysis reports must reference the causative incident. Construction ',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to site.instruction. Business justification: Delay events caused by site instructions (variation orders, engineers instructions) must reference the originating instruction for EOT claim substantiation. Construction contract administrators link ',
    `job_cost_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.job_cost_transaction. Business justification: Delay events generate actual cost postings (idle plant, extended preliminaries, acceleration). Claims managers and QSs link delay events to job_cost_transaction records for EOT prolongation cost claim',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: NCR-driven delay tracking is a core construction process: failed inspections and non-conformances trigger rework that causes schedule delays. EOT claims and delay analysis reports require linking dela',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: EOT claim substantiation requires identifying which permit delay caused the schedule impact. Construction project controls teams routinely link delay events to the specific permit (e.g., delayed plann',
    `project_engagement_id` BIGINT COMMENT 'Foreign key linking to client.project_engagement. Business justification: EOT and LD claim management: delay events trigger EOT claims and LD exposure calculations that are governed by the client engagements contractual terms (eot_days_granted, liquidated_damages_rate, dis',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory obligations (e.g., mandatory environmental shutdown periods, heritage protection requirements) directly cause schedule delay events. Linking delay_event to the triggering regulatory_obligat',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: Unanswered RFIs are a primary cause of construction delays. Delay analysis reports and EOT claims must link delay events to the causative RFI. Construction claims specialists and schedulers routinely ',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: Delay events affect a specific schedule baseline and may be tied to an EOT claim; linking creates proper relationships and removes string reference columns.',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Delay events are attributed to specific trade packages (subcontractor-caused delays) for EOT claims and liquidated damages assessment. delay_event has vendor_id but no trade_package link; construction',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: DELAY CLAIMS: Delay events often stem from vendor delivery or performance; linking to vendor supports root‑cause analysis and EOT claim justification.',
    `approval_date` DATE COMMENT 'Date when the delay event record was approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the delay event record.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 currency code for the cost impact amount.',
    `created_by_user` STRING COMMENT 'System user who created the delay event record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delay event record was first created in the system.',
    `delay_category` STRING COMMENT 'Legal/contractual classification of the delay.. Valid values are `excusable_compensable|excusable_non_compensable|non_excusable`',
    `delay_duration_calendar_days` STRING COMMENT 'Total number of calendar days the event delayed the schedule.',
    `delay_duration_working_days` STRING COMMENT 'Total number of working days the event delayed the schedule, accounting for non‑working days.',
    `delay_event_description` STRING COMMENT 'Detailed narrative describing the cause and nature of the delay.',
    `delay_event_status` STRING COMMENT 'Current processing status of the delay event record.. Valid values are `open|in_review|approved|rejected|closed`',
    `eot_claim_status` STRING COMMENT 'Current status of the linked Extension of Time claim.. Valid values are `pending|approved|rejected`',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the delay event ended or is expected to end.',
    `event_name` STRING COMMENT 'Descriptive name given to the delay event.',
    `event_start_timestamp` TIMESTAMP COMMENT 'Date and time when the delay event began.',
    `event_type` STRING COMMENT 'Category of the delay event such as weather, design change, employer instruction, utility conflict, permit delay, labor dispute, material shortage, or force majeure. [ENUM-REF-CANDIDATE: weather|design_change|employer_instruction|utility_conflict|permit_delay|labor_dispute|material_shortage|force_majeure — promote to reference product]',
    `impact_on_cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost impact associated with the delay.',
    `impact_on_critical_path` BOOLEAN COMMENT 'Indicates whether the delay impacts the project critical path (true/false).',
    `last_modified_by_user` STRING COMMENT 'System user who last modified the delay event record.',
    `mitigation_measures` STRING COMMENT 'Actions taken to mitigate or recover from the delay.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the delay event.',
    `risk_rating` STRING COMMENT 'Risk rating associated with the delay event.. Valid values are `low|medium|high`',
    `severity_level` STRING COMMENT 'Severity rating of the delays impact on schedule and cost.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Originating operational system that supplied the delay event data.. Valid values are `primavera|procore|bim360|viewpoint|hcsh|aconex`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the delay event record.',
    CONSTRAINT pk_delay_event PRIMARY KEY(`delay_event_id`)
) COMMENT 'Discrete delay event record capturing a specific occurrence that caused or is causing schedule delay. Stores event name, event type (weather, design change, employer instruction, utility conflict, permit delay, labor dispute, material shortage, force majeure), event start date, event end date, impacted activities, delay duration (calendar days, working days), responsibility party (employer, contractor, third party, neutral), delay category (excusable compensable, excusable non-compensable, non-excusable), linked EOT claim reference, and mitigation measures taken. Supports delay analysis (as-planned vs as-built, time impact analysis, windows analysis).';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` (
    `lookahead_activity_commitment_id` BIGINT COMMENT 'Primary key for the lookahead_activity_commitment association',
    `activity_id` BIGINT COMMENT 'Foreign key linking to the CPM schedule activity included in this lookahead commitment.',
    `lookahead_plan_id` BIGINT COMMENT 'Foreign key linking to the lookahead plan window in which this activity commitment is tracked.',
    `commitment_status` STRING COMMENT 'Last Planner System commitment status for this activity in this window. Tracks whether the foreman/superintendent made a formal commitment to complete this activity and whether it was fulfilled — the basis for PPC calculation.',
    `constraint_description` STRING COMMENT 'Detailed description of the constraint affecting this activity in this lookahead window. Belongs to the association because the same activity may have different constraints in different planning windows.',
    `constraint_type` STRING COMMENT 'Type of constraint blocking or affecting this activity within this specific lookahead window. Constraint type may differ across windows as constraints are resolved or new ones emerge.',
    `crew_ready_flag` BOOLEAN COMMENT 'True if the required crew is confirmed available for this activity within this lookahead window. Per-activity confirmation within a specific plan, not a property of the activity or plan alone.',
    `equipment_ready_flag` BOOLEAN COMMENT 'True if required equipment is confirmed available for this activity within this lookahead window. Equipment availability is confirmed at the activity-plan level.',
    `lookahead_finish_date` DATE COMMENT 'Finish date used in the look‑ahead planning window. [Moved from activity: Same reasoning as lookahead_start_date — this is a per-window planning date, not a fixed property of the activity. Storing it on the activity flattens the rolling-window model. It belongs to the association as planned_finish_date.]',
    `lookahead_start_date` DATE COMMENT 'Start date used in the look‑ahead planning window. [Moved from activity: This date is window-specific — the same activity has a different planned start date in each successive lookahead window as near-term planning is refined. Storing it on the activity record implies a single lookahead window per activity, which is incorrect for LPS. It belongs to the association as planned_start_date.]',
    `material_ready_flag` BOOLEAN COMMENT 'True if all required materials are confirmed available for this activity within this lookahead window. Readiness is assessed per activity per planning window.',
    `planned_finish_date` DATE COMMENT 'The planned finish date for this activity as scheduled within this specific lookahead window. Moved from activity.lookahead_finish_date because this date is window-specific, not a fixed property of the activity.',
    `planned_start_date` DATE COMMENT 'The planned start date for this activity as scheduled within this specific lookahead window. May differ from the CPM baseline start date and varies per lookahead window as near-term planning is refined.',
    `readiness_status` STRING COMMENT 'Overall readiness status of this specific activity within this lookahead plan window. Tracks whether all preconditions (crew, materials, equipment, permits) are confirmed for this activity in this planning period.',
    `reason_not_completed` STRING COMMENT 'If commitment_status is NOT_COMPLETED, captures the root cause reason. Used for LPS variance analysis and continuous improvement. Belongs to the association as it describes why a specific commitment in a specific window was not fulfilled.',
    CONSTRAINT pk_lookahead_activity_commitment PRIMARY KEY(`lookahead_activity_commitment_id`)
) COMMENT 'This association product represents the Commitment between a CPM schedule activity and a short-interval lookahead plan within the Last Planner System (LPS). It captures the per-activity readiness state, constraint status, and commitment fulfillment for each activity as it appears in a specific rolling lookahead window. Each record links one activity to one lookahead_plan and carries readiness flags, constraint details, and window-specific planning dates that exist only in the context of this activity-plan pairing. This is the operational record that drives PPC (Percent Plan Complete) tracking and near-term crew coordination.. Existence Justification: In construction project controls, a CPM schedule activity can appear in multiple lookahead plans across successive rolling windows (e.g., an activity first appears in the 6-week window, then the 3-week window, then the 1-week window as it approaches execution). Conversely, each lookahead plan contains many activities. The Last Planner System explicitly models this as a commitment tracking mechanism where each activity-plan pairing carries its own readiness state (crew, materials, equipment confirmed), constraint status, and commitment fulfillment — data that belongs to neither the activity nor the plan alone.';

CREATE OR REPLACE TABLE `construction_ecm`.`schedule`.`activity_delay_impact` (
    `activity_delay_impact_id` BIGINT COMMENT 'Primary key for the activity_delay_impact association',
    `activity_id` BIGINT COMMENT 'Foreign key linking to the schedule activity impacted by the delay event',
    `delay_event_id` BIGINT COMMENT 'Foreign key linking to the delay event that caused the impact on this activity',
    `activity_ids_impacted` STRING COMMENT 'Comma‑separated list of activity identifiers that are affected by the delay. [Moved from delay_event: This comma-separated STRING field is a denormalized anti-pattern that was compensating for the missing association table. Once the activity_delay_impact association table exists, this field is redundant and should be retired.]',
    `delay_duration_calendar_days` STRING COMMENT 'Number of calendar days this specific activity is delayed by this delay event. Used for contractual EOT calculations where calendar days are the contractual measure.',
    `delay_duration_working_days` STRING COMMENT 'Number of working days this specific activity is delayed by this delay event, accounting for the activitys assigned calendar. May differ from the event-level duration due to calendar and sequencing effects.',
    `eot_claim_status` STRING COMMENT 'Current status of the Extension of Time entitlement assessment for this specific activity-event combination. EOT entitlement is assessed per impacted activity, not per event globally.',
    `impact_on_cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost impact attributable to this delay event on this specific activity. The total event cost impact is the sum of per-activity impacts, enabling granular cost recovery claims.',
    `impact_on_critical_path` BOOLEAN COMMENT 'Indicates whether this specific activitys position on the critical path is affected by this delay event. A delay event may impact the critical path for some activities but not others depending on float consumption.',
    CONSTRAINT pk_activity_delay_impact PRIMARY KEY(`activity_delay_impact_id`)
) COMMENT 'This association product represents the formal impact record between a delay_event and an activity in construction project controls. It captures the specific quantum of delay, critical path effect, and EOT entitlement for each activity affected by each delay event. Each record links one delay_event to one activity and carries attributes that exist only in the context of that specific event-activity impact relationship, supporting delay analysis methodologies (as-planned vs as-built, time impact analysis, windows analysis) per SCL Protocol and AACE RP 29R-03.. Existence Justification: In construction project controls, a single delay event (e.g., a severe weather event or a design change instruction) routinely impacts multiple schedule activities simultaneously, and a single activity can be impacted by multiple distinct delay events over its lifecycle. This is a formally managed operational relationship in delay analysis disciplines (SCL Protocol, AACE RP 29R-03): project controls engineers actively create, update, and close individual delay impact records per activity per event, tracking quantum of delay, critical path effect, and EOT entitlement at the activity level. The relationship is not derivable from existing transactional joins — it requires its own records with per-activity impact data.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_schedule_calendar_id` FOREIGN KEY (`schedule_calendar_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_calendar`(`schedule_calendar_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ADD CONSTRAINT `fk_schedule_activity_relationship_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_schedule_calendar_id` FOREIGN KEY (`schedule_calendar_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_calendar`(`schedule_calendar_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `construction_ecm`.`schedule`.`resource`(`resource_id`);
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_parent_wbs_wbs_node_id` FOREIGN KEY (`parent_wbs_wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `construction_ecm`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `construction_ecm`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ADD CONSTRAINT `fk_schedule_lookahead_activity_commitment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ADD CONSTRAINT `fk_schedule_lookahead_activity_commitment_lookahead_plan_id` FOREIGN KEY (`lookahead_plan_id`) REFERENCES `construction_ecm`.`schedule`.`lookahead_plan`(`lookahead_plan_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` ADD CONSTRAINT `fk_schedule_activity_delay_impact_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `construction_ecm`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` ADD CONSTRAINT `fk_schedule_activity_delay_impact_delay_event_id` FOREIGN KEY (`delay_event_id`) REFERENCES `construction_ecm`.`schedule`.`delay_event`(`delay_event_id`);

-- ========= TAGS =========
ALTER SCHEMA `construction_ecm`.`schedule` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `construction_ecm`.`schedule` SET TAGS ('dbx_domain' = 'schedule');
ALTER TABLE `construction_ecm`.`schedule`.`activity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`schedule`.`activity` SET TAGS ('dbx_subdomain' = 'activity_planning');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `project_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline ID');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `schedule_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Calendar ID');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `scope_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Activity Name');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|suspended|cancelled');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'task_dependent|resource_dependent|level_of_effort|milestone');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `constraint_date` SET TAGS ('dbx_business_glossary_term' = 'Constraint Date');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'asap|start_no_earlier_than|finish_no_later_than|mandatory|none');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `free_float_days` SET TAGS ('dbx_business_glossary_term' = 'Free Float (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `original_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Original Duration (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `remaining_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Remaining Duration (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `total_float_days` SET TAGS ('dbx_business_glossary_term' = 'Total Float (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` SET TAGS ('dbx_subdomain' = 'activity_planning');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Relationship ID');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Activity ID');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_description` SET TAGS ('dbx_business_glossary_term' = 'Relationship Description');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path Relationship');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `is_driving` SET TAGS ('dbx_business_glossary_term' = 'Is Driving Relationship');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `lag_duration` SET TAGS ('dbx_business_glossary_term' = 'Lag Duration');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `lag_time_unit` SET TAGS ('dbx_business_glossary_term' = 'Lag Time Unit');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `lag_time_unit` SET TAGS ('dbx_value_regex' = 'days|hours|minutes');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_source` SET TAGS ('dbx_business_glossary_term' = 'Relationship Source');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_source` SET TAGS ('dbx_value_regex' = 'system_export|manual_entry');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type (Finish-to-Start, Start-to-Start, Finish-to-Finish, Start-to-Finish)');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'FS|SS|FF|SF');
ALTER TABLE `construction_ecm`.`schedule`.`activity_relationship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` SET TAGS ('dbx_subdomain' = 'baseline_control');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline ID');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `project_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Project Engagement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Approval Date');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `baseline_type` SET TAGS ('dbx_business_glossary_term' = 'Baseline Type');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `baseline_type` SET TAGS ('dbx_value_regex' = 'original|current|supplemental');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `bcws_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Scheduled (BCWS)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `bcws_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Baseline Change Reason');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Baseline Record Created Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Baseline Currency Code');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `data_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Data Date');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `finish_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Baseline Flag');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Revision Date');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_description` SET TAGS ('dbx_business_glossary_term' = 'Baseline Description');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_name` SET TAGS ('dbx_business_glossary_term' = 'Baseline Name');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_status` SET TAGS ('dbx_business_glossary_term' = 'Baseline Status');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_status` SET TAGS ('dbx_value_regex' = 'draft|approved|rejected|archived');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_tool_project_ref` SET TAGS ('dbx_business_glossary_term' = 'Schedule Tool Project Reference');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Baseline Source System');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'primavera|sap|other');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `total_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Baseline Total Duration (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Baseline Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_baseline` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Baseline Version Number');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` SET TAGS ('dbx_subdomain' = 'baseline_control');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Activity Identifier');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Identifier');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Line Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Identifier');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_activity_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|on_hold|cancelled');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_constraint_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Constraint Date');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Baseline Constraint Type');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_constraint_type` SET TAGS ('dbx_value_regex' = 'as_soon_as_possible|start_on|finish_on|must_start_on|must_finish_on|none');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_cost` SET TAGS ('dbx_business_glossary_term' = 'Baseline Cost Estimate');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Baseline Cost Variance');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_early_finish` SET TAGS ('dbx_business_glossary_term' = 'Baseline Early Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_early_start` SET TAGS ('dbx_business_glossary_term' = 'Baseline Early Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_is_critical` SET TAGS ('dbx_business_glossary_term' = 'Baseline Critical Activity Indicator');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_late_finish` SET TAGS ('dbx_business_glossary_term' = 'Baseline Late Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_late_start` SET TAGS ('dbx_business_glossary_term' = 'Baseline Late Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_milestone_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Flag');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_original_duration` SET TAGS ('dbx_business_glossary_term' = 'Baseline Original Duration (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Baseline Percent Complete');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_remaining_duration` SET TAGS ('dbx_business_glossary_term' = 'Baseline Remaining Duration (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_resource_type` SET TAGS ('dbx_business_glossary_term' = 'Baseline Resource Type');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_resource_type` SET TAGS ('dbx_value_regex' = 'labor|equipment|material|subcontractor');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_resource_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Resource Units');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_schedule_variance` SET TAGS ('dbx_business_glossary_term' = 'Baseline Schedule Variance (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_total_float` SET TAGS ('dbx_business_glossary_term' = 'Baseline Total Float (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `construction_ecm`.`schedule`.`baseline_activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`schedule`.`resource` SET TAGS ('dbx_subdomain' = 'resource_management');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `schedule_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Calendar Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Availability Percentage');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `billing_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Per Hour');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `default_units_per_time` SET TAGS ('dbx_business_glossary_term' = 'Default Units Per Time');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `depreciation_rate` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `environmental_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Score');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'External Resource Flag');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `is_overtime_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overtime Allowed Flag');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `max_concurrent_assignments` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Assignments');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `max_units_per_period` SET TAGS ('dbx_business_glossary_term' = 'Maximum Units Per Period');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Resource Notes');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `overtime_factor` SET TAGS ('dbx_business_glossary_term' = 'Overtime Factor');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `procurement_source` SET TAGS ('dbx_business_glossary_term' = 'Procurement Source');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `procurement_source` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `resource_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Code');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `resource_description` SET TAGS ('dbx_business_glossary_term' = 'Resource Description');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'Resource Name');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `resource_role` SET TAGS ('dbx_business_glossary_term' = 'Resource Role');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `resource_status` SET TAGS ('dbx_business_glossary_term' = 'Resource Status');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `resource_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|planned');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'labor|material|equipment|subcontractor');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `site_location` SET TAGS ('dbx_business_glossary_term' = 'Site Location');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `skill_set` SET TAGS ('dbx_business_glossary_term' = 'Skill Set');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`resource` ALTER COLUMN `utilization_rate` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` SET TAGS ('dbx_subdomain' = 'resource_management');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `activity_resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Resource Assignment ID');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `job_cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Job Cost Transaction Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource ID');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|closed|cancelled|on_hold');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `cost_account_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Code');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `distribution_curve` SET TAGS ('dbx_business_glossary_term' = 'Distribution Curve');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `distribution_curve` SET TAGS ('dbx_value_regex' = 'front_loaded|back_loaded|bell|linear|custom|none');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Indicator');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `labor_category` SET TAGS ('dbx_value_regex' = 'skilled|unskilled|supervisor|foreman|other');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `overtime_quantity` SET TAGS ('dbx_business_glossary_term' = 'Overtime Quantity');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `overtime_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `remaining_cost` SET TAGS ('dbx_business_glossary_term' = 'Remaining Cost');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_location` SET TAGS ('dbx_business_glossary_term' = 'Resource Location');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_role` SET TAGS ('dbx_business_glossary_term' = 'Resource Role');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_role` SET TAGS ('dbx_value_regex' = 'foreman|operator|installer|inspector|supervisor|other');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'labor|equipment|material|subcontractor|tool|other');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `safety_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Risk Level');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `safety_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'hours|days|m3|kg|units|percent');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`activity_resource_assignment` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` SET TAGS ('dbx_subdomain' = 'activity_planning');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Node ID');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `parent_wbs_wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Parent WBS Node ID');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `baseline_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `baseline_start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `budgeted_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `change_order_indicator` SET TAGS ('dbx_business_glossary_term' = 'Change Order Indicator');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `deleted_flag` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `earned_value_method` SET TAGS ('dbx_business_glossary_term' = 'Earned Value Method');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `earned_value_method` SET TAGS ('dbx_value_regex' = 'fixed_formula|percent_complete|weighted_milestones|level_of_effort');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `is_milestone` SET TAGS ('dbx_business_glossary_term' = 'Milestone Indicator');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'WBS Node Notes');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `wbs_level` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Level');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `wbs_name` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Name');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `wbs_node_description` SET TAGS ('dbx_business_glossary_term' = 'WBS Node Description');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `wbs_node_status` SET TAGS ('dbx_business_glossary_term' = 'WBS Node Status');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `wbs_node_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|on_hold|cancelled');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `wbs_type` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Type');
ALTER TABLE `construction_ecm`.`schedule`.`wbs_node` ALTER COLUMN `wbs_type` SET TAGS ('dbx_value_regex' = 'project_summary|wbs_summary|work_package|control_account|activity|milestone');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` SET TAGS ('dbx_subdomain' = 'baseline_control');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `schedule_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Calendar ID');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `break_time_minutes_per_day` SET TAGS ('dbx_business_glossary_term' = 'Break Time Minutes Per Day');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `calendar_category` SET TAGS ('dbx_business_glossary_term' = 'Calendar Category');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `calendar_category` SET TAGS ('dbx_value_regex' = 'standard|custom|regional');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Calendar Code (CAL_CODE)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Calendar Name (CAL_NAME)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_business_glossary_term' = 'Calendar Type (CAL_TYPE)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_value_regex' = 'global|project|resource');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `holiday_exceptions` SET TAGS ('dbx_business_glossary_term' = 'Holiday Exceptions');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Calendar');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `max_overtime_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Overtime Hours Per Day');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `overtime_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overtime Allowed');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `schedule_calendar_description` SET TAGS ('dbx_business_glossary_term' = 'Calendar Description');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `schedule_calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Calendar Status');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `schedule_calendar_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single|double|custom');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `work_days_per_week` SET TAGS ('dbx_business_glossary_term' = 'Work Days Per Week');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `work_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Work Hours Per Day');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_calendar` ALTER COLUMN `work_week_definition` SET TAGS ('dbx_business_glossary_term' = 'Work Week Definition');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` SET TAGS ('dbx_subdomain' = 'progress_tracking');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `progress_update_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Update ID');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `project_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Project Engagement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `actual_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Units');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `bcwp` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Performed (BCWP)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `bcws` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Scheduled (BCWS)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `critical_activity_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Activity Count');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `critical_path_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Completion Date');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `forecast_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `is_critical_path_changed` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Change Flag');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Update Notes');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `path_drift_indicator` SET TAGS ('dbx_business_glossary_term' = 'Path Drift Indicator');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `path_drift_indicator` SET TAGS ('dbx_value_regex' = 'on_track|drift|off_track');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `percent_complete_duration` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete (Duration)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `percent_complete_units` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete (Units)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Number');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `progress_update_status` SET TAGS ('dbx_business_glossary_term' = 'Progress Update Status');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `progress_update_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `remaining_duration` SET TAGS ('dbx_business_glossary_term' = 'Remaining Duration (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `remaining_units` SET TAGS ('dbx_business_glossary_term' = 'Remaining Units');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|yearly');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Reporting Status');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `reporting_status` SET TAGS ('dbx_value_regex' = 'pending|completed|overdue');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `spi` SET TAGS ('dbx_business_glossary_term' = 'Schedule Performance Index (SPI)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `sv` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (SV)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `sv_percent` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance Percent (SV%)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `total_float` SET TAGS ('dbx_business_glossary_term' = 'Total Float (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `update_source` SET TAGS ('dbx_business_glossary_term' = 'Update Source');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `update_source` SET TAGS ('dbx_value_regex' = 'field_report|p6_import|heavyjob');
ALTER TABLE `construction_ecm`.`schedule`.`progress_update` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` SET TAGS ('dbx_subdomain' = 'progress_tracking');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `lookahead_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Plan ID');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `cash_flow_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Forecast Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `scope_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `change_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Order Flag');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `constraint_description` SET TAGS ('dbx_business_glossary_term' = 'Constraint Description');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'material|permit|crew|equipment|weather|none');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `crew_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Ready Flag');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Lookahead End Date');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `equipment_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Ready Flag');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Horizon Weeks');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `is_lps_enabled` SET TAGS ('dbx_business_glossary_term' = 'Last Planner System Enabled');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `material_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Ready Flag');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `pending_activities` SET TAGS ('dbx_business_glossary_term' = 'Pending Activities');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `percent_plan_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Plan Complete');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `plan_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Generation Date');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Plan Status');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|completed|cancelled');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `ppc_actual_percent` SET TAGS ('dbx_business_glossary_term' = 'PPC Actual Percent');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `ppc_target_percent` SET TAGS ('dbx_business_glossary_term' = 'PPC Target Percent');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Readiness Status');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `readiness_status` SET TAGS ('dbx_value_regex' = 'ready|not_ready|partial');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `ready_activities` SET TAGS ('dbx_business_glossary_term' = 'Ready Activities');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `total_activities` SET TAGS ('dbx_business_glossary_term' = 'Total Activities');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `weather_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Impact Flag');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_plan` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` SET TAGS ('dbx_subdomain' = 'activity_planning');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Milestone ID');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `project_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Project Engagement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `ld_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Exposure Flag');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `ld_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Rate Per Day');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Milestone Location');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Milestone Risk Level');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_status` SET TAGS ('dbx_value_regex' = 'not_started|at_risk|achieved|missed');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_type` SET TAGS ('dbx_value_regex' = 'contract|internal|client|regulatory');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence Number');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`schedule_milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` SET TAGS ('dbx_subdomain' = 'progress_tracking');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `delay_event_id` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Identifier');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `authority_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Authority Notice Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `change_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Change Notice Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Env Impact Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `hse_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Inspection Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Instruction Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `job_cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Job Cost Transaction Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `project_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Project Engagement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `delay_category` SET TAGS ('dbx_business_glossary_term' = 'Delay Category');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `delay_category` SET TAGS ('dbx_value_regex' = 'excusable_compensable|excusable_non_compensable|non_excusable');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `delay_duration_calendar_days` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration (Calendar Days)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `delay_duration_working_days` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration (Working Days)');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `delay_event_description` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Description');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `delay_event_status` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Status');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `delay_event_status` SET TAGS ('dbx_value_regex' = 'open|in_review|approved|rejected|closed');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `eot_claim_status` SET TAGS ('dbx_business_glossary_term' = 'EOT Claim Status');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `eot_claim_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delay Event End Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Name');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Start Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Type');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `impact_on_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `impact_on_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Impact Flag');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'primavera|procore|bim360|viewpoint|hcsh|aconex');
ALTER TABLE `construction_ecm`.`schedule`.`delay_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` SET TAGS ('dbx_subdomain' = 'activity_planning');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` SET TAGS ('dbx_association_edges' = 'schedule.activity,schedule.lookahead_plan');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `lookahead_activity_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Activity Commitment - Lookahead Activity Commitment Id');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Activity Commitment - Activity Id');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `lookahead_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Activity Commitment - Lookahead Plan Id');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'LPS Commitment Status');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `constraint_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Constraint Description');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Constraint Type');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `crew_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Ready Flag');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `equipment_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Ready Flag');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `lookahead_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Look‑Ahead Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `lookahead_start_date` SET TAGS ('dbx_business_glossary_term' = 'Look‑Ahead Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `material_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Ready Flag');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Planned Finish Date');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Planned Start Date');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Readiness Status');
ALTER TABLE `construction_ecm`.`schedule`.`lookahead_activity_commitment` ALTER COLUMN `reason_not_completed` SET TAGS ('dbx_business_glossary_term' = 'Reason Not Completed');
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` SET TAGS ('dbx_subdomain' = 'progress_tracking');
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` SET TAGS ('dbx_association_edges' = 'schedule.delay_event,schedule.activity');
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` ALTER COLUMN `activity_delay_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Delay Impact - Activity Delay Impact Id');
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Delay Impact - Activity Id');
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` ALTER COLUMN `delay_event_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Delay Impact - Delay Event Id');
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` ALTER COLUMN `activity_ids_impacted` SET TAGS ('dbx_business_glossary_term' = 'Impacted Activity IDs');
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` ALTER COLUMN `delay_duration_calendar_days` SET TAGS ('dbx_business_glossary_term' = 'Calendar Day Delay Quantum');
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` ALTER COLUMN `delay_duration_working_days` SET TAGS ('dbx_business_glossary_term' = 'Working Day Delay Quantum');
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` ALTER COLUMN `eot_claim_status` SET TAGS ('dbx_business_glossary_term' = 'EOT Claim Status');
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` ALTER COLUMN `impact_on_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Activity-Level Cost Impact');
ALTER TABLE `construction_ecm`.`schedule`.`activity_delay_impact` ALTER COLUMN `impact_on_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Impact Flag');
