-- Schema for Domain: project | Business: Advertising | Version: v1_mvm
-- Generated on: 2026-05-08 03:52:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`project` COMMENT 'Manages agency project lifecycle, work breakdown structures, task assignments, timelines, milestones, and resource scheduling across campaigns and client engagements. Integrates with Workfront/Monday.com as system of record for project execution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`initiative` (
    `initiative_id` BIGINT COMMENT 'Unique identifier for the agency project or engagement. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client advertiser account for whom this project is being executed.',
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: Projects are delivered under specific agency relationship agreements (AOR, project-based retainer, pitch work). Tracking which relationship governs the work is essential for billing rules, scope bound',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Master agreements govern multi-project client relationships. Agencies link initiatives to MSAs to apply correct rate cards, enforce compliance obligations, and manage multi-year retainer terms across ',
    `attribution_model_id` BIGINT COMMENT 'Foreign key linking to performance.attribution_model. Business justification: Strategic initiatives define attribution methodology for performance evaluation. Real business process: campaign planning phase where strategists select attribution model (last-click, linear, data-dri',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Initiatives are executed on behalf of a specific brand. Brand-level reporting — SOV tracking, brand health metrics, budget utilization by brand — requires linking initiatives to client_brand. initiati',
    `campaign_id` BIGINT COMMENT 'Reference to the associated marketing campaign if this project is part of a broader campaign initiative. Nullable for non-campaign projects.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Projects must be assigned to cost centers for financial reporting, budget allocation, and P&L tracking in agency operations. Essential for departmental profitability analysis and overhead allocation.',
    `parent_initiative_id` BIGINT COMMENT 'Self-referencing FK on initiative (parent_initiative_id)',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Initiatives execute SOW-defined scope. Agencies track SOW-to-project mapping for revenue recognition, deliverable tracking, budget burn analysis, and client invoicing against contractual commitments.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Projects/initiatives frequently engage vendors for media buying, tech platforms, creative production. Tracking primary supplier enables project vendor management, cost allocation, and vendor performan',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred to date for labor, materials, and external expenses. Updated as costs are recorded.',
    `actual_duration_days` STRING COMMENT 'Actual elapsed duration of the project in calendar days. Populated upon project completion.',
    `billing_type` STRING COMMENT 'Commercial model under which the project is billed to the client.. Valid values are `fixed_fee|time_and_materials|retainer|performance_based|hybrid`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget allocated for this project in the agencys reporting currency.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the project budget (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `cancellation_date` DATE COMMENT 'Date when the project was formally cancelled. Populated only for cancelled projects.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the project was cancelled (e.g., client budget cuts, scope changes, strategic pivot).',
    `client_satisfaction_score` DECIMAL(18,2) COMMENT 'Client-reported satisfaction rating for the project, typically on a scale of 1.00 to 5.00. Captured post-delivery or at milestones.',
    `completion_date` DATE COMMENT 'Actual date when all project deliverables were completed and accepted by the client.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this project record was first created in the system.',
    `deliverables_summary` STRING COMMENT 'High-level summary of key deliverables expected from this project (e.g., creative assets, media plans, campaign reports).',
    `delivery_methodology` STRING COMMENT 'Project management methodology applied for planning and execution (e.g., agile sprints, waterfall phases, hybrid approach).. Valid values are `agile|waterfall|hybrid|kanban`',
    `end_date` DATE COMMENT 'Planned or actual date when project work is scheduled to complete or was completed.',
    `health_indicator` STRING COMMENT 'Overall health status of the project based on schedule, budget, scope, and quality metrics. Green indicates on-track, yellow indicates at-risk, red indicates critical issues.. Valid values are `green|yellow|red`',
    `initiative_name` STRING COMMENT 'Human-readable name of the project or engagement, used for identification and reporting.',
    `initiative_status` STRING COMMENT 'Current lifecycle status of the project indicating its stage in the execution workflow.. Valid values are `briefing|planning|in_flight|on_hold|completed|cancelled`',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this project is billable to the client (true) or internal/non-billable (false).',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether this project is subject to confidentiality or non-disclosure agreements requiring restricted access.',
    `kickoff_date` DATE COMMENT 'Date of the formal project kickoff meeting with the client and internal team.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this project record was last updated.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, special instructions, or important observations about the project.',
    `owning_department` STRING COMMENT 'Primary agency department responsible for delivering this project. [ENUM-REF-CANDIDATE: creative|media|strategy|digital|pr|production|account_services — 7 candidates stripped; promote to reference product]',
    `planned_duration_days` STRING COMMENT 'Originally estimated duration of the project in calendar days from start to end.',
    `priority` STRING COMMENT 'Business priority level assigned to the project for resource allocation and scheduling decisions.. Valid values are `critical|high|medium|low`',
    `project_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the project for client communication and billing. Typically follows agency naming convention.. Valid values are `^[A-Z0-9]{6,12}$`',
    `project_type` STRING COMMENT 'Classification of the project based on the primary service offering or deliverable type. [ENUM-REF-CANDIDATE: campaign_production|brand_strategy|media_planning|creative_development|pr_activation|digital_marketing|content_creation|market_research|event_management|retainer_services — 10 candidates stripped; promote to reference product]',
    `risk_level` STRING COMMENT 'Overall risk assessment for the project based on complexity, dependencies, client volatility, and resource constraints.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Detailed narrative describing the project scope, objectives, deliverables, and boundaries.',
    `source_system_code` STRING COMMENT 'Unique project identifier from the originating system of record (Workfront, Monday.com, or other project management platform).',
    `source_system_name` STRING COMMENT 'Name of the project management system from which this project record was ingested.. Valid values are `workfront|monday|asana|jira|smartsheet`',
    `start_date` DATE COMMENT 'Planned or actual date when project work officially begins.',
    CONSTRAINT pk_initiative PRIMARY KEY(`initiative_id`)
) COMMENT 'Master record for an agency project or engagement — the authoritative SSOT for project identity, scope, and lifecycle within the agency. Captures project name, type (campaign production, brand strategy, media planning, PR activation, etc.), status (briefing, planning, in-flight, on-hold, completed, cancelled), priority, start and end dates, planned vs. actual duration, client account reference, associated campaign reference, owning department, project manager, delivery methodology (agile, waterfall, hybrid), source system (Workfront/Monday.com) project ID, and overall health indicator. Serves as the top-level container for all work breakdown structures, tasks, milestones, and resource assignments.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`work_package` (
    `work_package_id` BIGINT COMMENT 'Unique identifier for the work package within the Work Breakdown Structure (WBS). Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Work packages require cost center assignment for labor cost allocation and profitability analysis by discipline. Enables accurate project costing and departmental charge-back in agency financial syste',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project or campaign engagement that this work package belongs to.',
    `parent_work_package_id` BIGINT COMMENT 'Reference to the parent work package in the hierarchical WBS structure. Null for top-level packages.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.audience_segment. Business justification: Advertising work packages are scoped to specific audience segments (e.g., Build Retargeting Segment, Activate Prospecting Audience). Project managers need this link to track segment-specific work ',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Work packages decompose SOW scope. Agencies map WBS elements to SOW scope items for traceability, ensuring all contracted deliverables are planned and no out-of-scope work is executed without authoriz',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: In advertising operations, specific work packages (e.g., creative production, media buying execution) are assigned to external vendors. Linking supplier_id to work_package enables vendor accountabilit',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred for this work package to date. Used for cost variance analysis and Earned Value Management (EVM).',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual labor hours expended on this work package to date. Tracked from time entry systems for variance analysis.',
    `actual_end_date` DATE COMMENT 'Actual date when work on this package was completed. Null if not yet completed.',
    `actual_start_date` DATE COMMENT 'Actual date when work on this package commenced. Null if not yet started.',
    `approval_status` STRING COMMENT 'Current approval state of the work package deliverable. Tracks client or internal stakeholder sign-off.. Valid values are `not_submitted|pending_approval|approved|rejected|approved_with_changes`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this work package. Null if not yet approved.',
    `approved_date` DATE COMMENT 'Date when this work package was formally approved. Null if not yet approved.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of work completed for this package (0.00 to 100.00). Used for progress tracking and Earned Value (EV) calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work package record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for planned and actual cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deliverable_type` STRING COMMENT 'Classification of the primary deliverable produced by this work package (e.g., Creative Brief, Media Plan, Campaign Report, Video Asset). [ENUM-REF-CANDIDATE: creative_brief|media_plan|campaign_report|video_asset|print_ad|digital_banner|social_content|presentation_deck|research_report|strategy_document|press_release — promote to reference product]',
    `discipline` STRING COMMENT 'Primary agency discipline or department responsible for executing this work package (e.g., creative, media, strategy, production, PR). [ENUM-REF-CANDIDATE: creative|media|strategy|production|account_management|public_relations|digital|analytics|content|design — 10 candidates stripped; promote to reference product]',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this work package is billable to the client (true) or non-billable internal work (false).',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether this work package is on the project critical path. Delays to critical path items directly impact project completion date.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work package record was last updated. Supports change tracking and audit requirements.',
    `notes` STRING COMMENT 'Free-form text field for additional context, instructions, risks, or issues related to this work package.',
    `planned_cost` DECIMAL(18,2) COMMENT 'Budgeted cost for this work package including labor, materials, and other direct costs. Baseline for Earned Value Management (EVM).',
    `planned_effort_hours` DECIMAL(18,2) COMMENT 'Estimated total labor hours required to complete this work package. Used for resource capacity planning and baseline cost estimation.',
    `planned_end_date` DATE COMMENT 'Scheduled date when work on this package is planned to be completed. Used for baseline schedule tracking.',
    `planned_start_date` DATE COMMENT 'Scheduled date when work on this package is planned to begin. Used for baseline schedule tracking.',
    `priority` STRING COMMENT 'Business priority level assigned to this work package for resource allocation and scheduling decisions.. Valid values are `critical|high|medium|low`',
    `wbs_code` STRING COMMENT 'Hierarchical alphanumeric code representing the work package position in the WBS (e.g., 1.2.3.1). Enables structured decomposition and rollup reporting.. Valid values are `^[A-Z0-9]+(.[A-Z0-9]+)*$`',
    `wbs_level` STRING COMMENT 'Numeric depth of this work package in the WBS hierarchy (1 = top level, 2 = second level, etc.). Enables level-based filtering and rollup.',
    `work_package_description` STRING COMMENT 'Detailed narrative describing the scope, deliverables, and objectives of this work package. Provides context for resource planning and execution.',
    `work_package_name` STRING COMMENT 'Short, descriptive name of the work package that clearly identifies the deliverable or work scope (e.g., Creative Concept Development, Media Buy Execution).',
    `work_package_status` STRING COMMENT 'Current lifecycle status of the work package indicating progress and execution state.. Valid values are `not_started|in_progress|on_hold|completed|cancelled|under_review`',
    `work_package_type` STRING COMMENT 'Classification of the work package within the WBS structure (deliverable-oriented, milestone, phase, task group, or control account).. Valid values are `deliverable|milestone|phase|task_group|control_account`',
    CONSTRAINT pk_work_package PRIMARY KEY(`work_package_id`)
) COMMENT 'Work Breakdown Structure (WBS) node representing a discrete, manageable unit of work within a project. Captures WBS code, package name, description, parent package reference (enabling hierarchical decomposition), level in the WBS hierarchy, owning discipline or department (creative, media, strategy, production, PR), planned effort hours, actual effort hours, planned cost, actual cost, status, and completion percentage. Enables multi-level decomposition of project scope into deliverable-oriented components aligned to Workfront/Monday.com task groups.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`task` (
    `task_id` BIGINT COMMENT 'Unique identifier for the task. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tasks need cost center tracking for time-based costing and departmental charge-back. Critical for labor cost allocation when time entries roll up to tasks for financial posting.',
    `initiative_id` BIGINT COMMENT 'Reference to the project this task belongs to.',
    `parent_task_id` BIGINT COMMENT 'Self-referencing FK on task (parent_task_id)',
    `primary_predecessor_task_id` BIGINT COMMENT 'Reference to the task that must be completed or started before this task can proceed, based on the dependency type.',
    `work_package_id` BIGINT COMMENT 'Reference to the parent work package that contains this task.',
    `actual_end_date` DATE COMMENT 'The actual date when this task was completed.',
    `actual_start_date` DATE COMMENT 'The actual date when work on this task began.',
    `approval_status` STRING COMMENT 'The current approval status of the task deliverable (not submitted, pending, approved, rejected, changes requested).. Valid values are `not_submitted|pending|approved|rejected|changes_requested`',
    `blocked_reason` STRING COMMENT 'Description of the reason why this task is blocked or cannot proceed.',
    `completed_timestamp` TIMESTAMP COMMENT 'The date and time when this task was marked as complete.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'The percentage of work completed for this task, expressed as a value between 0 and 100.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this task record was first created in the system.',
    `deliverable_type` STRING COMMENT 'The type of deliverable or output expected from this task (e.g., creative asset, media plan, trafficking sheet, approval document).',
    `dependency_type` STRING COMMENT 'The type of dependency relationship this task has with its predecessor (finish-to-start, start-to-start, finish-to-finish, start-to-finish, or none).. Valid values are `finish_to_start|start_to_start|finish_to_finish|start_to_finish|none`',
    `estimated_hours` DECIMAL(18,2) COMMENT 'The estimated number of hours required to complete this task.',
    `is_billable` BOOLEAN COMMENT 'Boolean flag indicating whether the hours logged on this task are billable to the client.',
    `is_milestone` BOOLEAN COMMENT 'Boolean flag indicating whether this task represents a project milestone.',
    `logged_hours` DECIMAL(18,2) COMMENT 'The actual number of hours logged or worked on this task.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this task record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or instructions related to this task.',
    `planned_end_date` DATE COMMENT 'The scheduled date when this task is planned to be completed.',
    `planned_start_date` DATE COMMENT 'The scheduled date when work on this task is planned to begin.',
    `priority` STRING COMMENT 'The priority level assigned to this task indicating its relative importance and urgency.. Valid values are `low|medium|high|urgent|critical`',
    `source_system_name` STRING COMMENT 'The name of the operational system of record from which this task was sourced (e.g., Workfront, Monday.com).. Valid values are `workfront|monday|other`',
    `source_system_task_code` STRING COMMENT 'The unique identifier for this task in the source system (Workfront or Monday.com).',
    `task_description` STRING COMMENT 'Detailed description of the work to be performed in this task.',
    `task_name` STRING COMMENT 'The name or title of the task.',
    `task_status` STRING COMMENT 'Current lifecycle status of the task (not started, in progress, blocked, complete, cancelled, on hold).. Valid values are `not_started|in_progress|blocked|complete|cancelled|on_hold`',
    `task_type` STRING COMMENT 'The category or type of work this task represents (e.g., creative production, copywriting, media trafficking, client review, quality assurance, approval).. Valid values are `creative_production|copywriting|media_trafficking|client_review|qa|approval`',
    CONSTRAINT pk_task PRIMARY KEY(`task_id`)
) COMMENT 'Atomic unit of work assigned to an individual or team within a work package. Captures task name, description, task type (creative production, copy writing, media trafficking, client review, QA, approval, etc.), assigned worker reference, assigned team, planned start date, planned end date, actual start date, actual end date, estimated hours, logged hours, completion percentage, priority, status (not started, in progress, blocked, complete), dependency type, predecessor task reference, and source system task ID from Workfront or Monday.com. The operational heartbeat of project execution tracking.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Unique identifier for the project milestone. Primary key.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: Contract amendments in advertising frequently revise milestone dates and deliverable scope. Linking project_milestone.amendment_id → amendment provides the audit trail showing which amendment triggere',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project to which this milestone belongs.',
    `replanned_from_project_milestone_id` BIGINT COMMENT 'Self-referencing FK on project_milestone (replanned_from_project_milestone_id)',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: Contractual milestone gates in advertising are governed by SLAs (e.g., creative delivery turnaround SLAs). project_milestone.is_contractual_gate flag signals this need. Linking to sla enables SLA brea',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Contractual campaign milestones (e.g., creative delivery gate, campaign launch) are often vendor-dependent in advertising. Linking supplier_id to project_milestone enables vendor-specific milestone tr',
    `work_package_id` BIGINT COMMENT 'Reference to the associated work package or phase within the project structure.',
    `acceptance_criteria` STRING COMMENT 'Specific, measurable criteria that must be met for the milestone to be considered successfully achieved and approved by stakeholders.',
    `actual_date` DATE COMMENT 'Actual date the milestone was achieved or completed. Null if milestone has not yet been reached.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone completion was formally approved by the designated approver. Null if not yet approved.',
    `baseline_date` DATE COMMENT 'Baseline date captured at project approval or contract signature, used for variance analysis and performance measurement against original commitment.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of work completed toward achieving this milestone, expressed as a decimal (0.00 to 100.00). Used for progress tracking and earned value analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system.',
    `deliverable_description` STRING COMMENT 'Detailed description of the tangible deliverable or output associated with this milestone (e.g., Final creative assets in all formats, Campaign performance dashboard, Client presentation deck).',
    `dependency_count` STRING COMMENT 'Number of predecessor tasks or milestones that must be completed before this milestone can be achieved. Used for dependency analysis and scheduling.',
    `forecast_date` DATE COMMENT 'Current forecasted date for milestone completion based on project progress and risk assessment. Updated regularly during project execution.',
    `is_billing_trigger` BOOLEAN COMMENT 'Boolean flag indicating whether achievement of this milestone triggers invoice generation or payment milestone per the client contract.',
    `is_contractual_gate` BOOLEAN COMMENT 'Boolean flag indicating whether this milestone is a contractually binding checkpoint defined in the SOW, requiring formal client sign-off before proceeding.',
    `is_critical_path` BOOLEAN COMMENT 'Boolean flag indicating whether this milestone lies on the project critical path. Delays to critical path milestones directly impact overall project completion date.',
    `milestone_description` STRING COMMENT 'Detailed description of the milestone deliverable, acceptance criteria, and business significance.',
    `milestone_name` STRING COMMENT 'Business-friendly name of the milestone (e.g., Creative Concept Approval, Campaign Launch, Post-Campaign Report Delivery).',
    `milestone_type` STRING COMMENT 'Classification of the milestone by its business function: kickoff (project initiation), creative_review (internal creative approval), client_approval (client sign-off gate), campaign_launch (media go-live), post_campaign_report (campaign performance delivery), billing_trigger (invoice generation event), contractual_gate (SOW-defined checkpoint). [ENUM-REF-CANDIDATE: kickoff|creative_review|client_approval|campaign_launch|post_campaign_report|billing_trigger|contractual_gate — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was last updated.',
    `notes` STRING COMMENT 'Free-text field for additional context, issues, decisions, or stakeholder feedback related to the milestone.',
    `planned_date` DATE COMMENT 'Originally scheduled date for milestone achievement as defined in the project plan or SOW.',
    `project_milestone_status` STRING COMMENT 'Current lifecycle status of the milestone: upcoming (not yet started), in_progress (work underway toward milestone), achieved (successfully completed on or before planned date), missed (completed after planned date or not completed by deadline), deferred (postponed to future date), cancelled (no longer required).. Valid values are `upcoming|in_progress|achieved|missed|deferred|cancelled`',
    `risk_level` STRING COMMENT 'Current risk assessment for on-time milestone achievement: low (on track, no issues), medium (minor concerns, monitoring required), high (significant risk of delay), critical (delay imminent or already occurred).. Valid values are `low|medium|high|critical`',
    `sow_milestone_reference` STRING COMMENT 'External reference code linking this milestone to a contractual milestone defined in the client Statement of Work (SOW). Used for contractual compliance and billing trigger validation.',
    `variance_days` STRING COMMENT 'Calculated variance in days between planned date and actual date. Positive values indicate delay (missed deadline), negative values indicate early completion. Null if milestone not yet achieved.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Significant scheduled checkpoint or deliverable gate within a project lifecycle. Captures milestone name, description, milestone type (kickoff, creative review, client approval, campaign launch, post-campaign report, billing trigger, contractual gate), planned date, actual date, status (upcoming, achieved, missed, deferred), owner, associated work package, linked SOW contractual milestone reference, and variance in days between planned and actual achievement. Used for client reporting, billing triggers, and executive project health dashboards.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`resource_plan` (
    `resource_plan_id` BIGINT COMMENT 'Unique identifier for the resource plan record. Primary key for the resource plan entity.',
    `contract_rate_card_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_card. Business justification: Agency resource plans are costed against negotiated rate cards. resource_plan has cost_rate, role_code, seniority_level that must align with contracted rates. This link enables accurate cost planning ',
    `initiative_id` BIGINT COMMENT 'Reference to the project for which this resource plan is created. Links to the project master entity.',
    `revised_from_resource_plan_id` BIGINT COMMENT 'Self-referencing FK on resource_plan (revised_from_resource_plan_id)',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: Resource plans are scoped not only at the initiative level but also at the work package (WBS node) level — e.g., we need 2 senior copywriters for the Creative Production work package. Adding work_pa',
    `allocation_priority` STRING COMMENT 'The priority level for securing this resource allocation (critical, high, medium, low), used for capacity planning and resource conflict resolution.. Valid values are `critical|high|medium|low`',
    `approval_date` DATE COMMENT 'The date when this resource plan was approved by the project manager or resource manager.',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved this resource plan.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the planned hours for this resource are billable to the client (True) or non-billable/internal (False).',
    `cost_rate` DECIMAL(18,2) COMMENT 'The internal cost rate applied per hour or per FTE for this role, used for capacity planning and project costing.',
    `cost_rate_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the cost rate (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this resource plan record was first created in the system.',
    `department_code` STRING COMMENT 'The code representing the department or cost center responsible for this resource allocation.',
    `department_name` STRING COMMENT 'The name of the department or cost center responsible for this resource allocation.',
    `discipline` STRING COMMENT 'The broad functional discipline or department to which the role belongs (creative, strategy, media, account management, production, analytics, technology, operations). [ENUM-REF-CANDIDATE: creative|strategy|media|account|production|analytics|technology|operations — 8 candidates stripped; promote to reference product]',
    `location_preference` STRING COMMENT 'The preferred work location for this resource allocation (onsite, remote, hybrid, or any).. Valid values are `onsite|remote|hybrid|any`',
    `modified_by` STRING COMMENT 'The name or identifier of the user who last modified this resource plan record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this resource plan record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about this resource plan, including special requirements, constraints, or assumptions.',
    `office_location` STRING COMMENT 'The specific office or geographic location from which the resource is expected to work (e.g., New York, London, Remote).',
    `plan_status` STRING COMMENT 'The current lifecycle status of the resource plan (draft, submitted for approval, approved, active, superseded by newer version, or cancelled).. Valid values are `draft|submitted|approved|active|superseded|cancelled`',
    `plan_version` STRING COMMENT 'Version identifier for the resource plan, enabling tracking of plan iterations and revisions over time (e.g., v1.0, v2.1, draft, final).',
    `planned_fte` DECIMAL(18,2) COMMENT 'The planned Full-Time Equivalent (FTE) allocation for this role during the planning period. 1.0 represents one full-time resource; 0.5 represents half-time allocation.',
    `planned_hours` DECIMAL(18,2) COMMENT 'The total number of hours planned for this role during the planning period.',
    `planning_period_end_date` DATE COMMENT 'The end date of the planning period for which resources are being planned.',
    `planning_period_start_date` DATE COMMENT 'The start date of the planning period for which resources are being planned.',
    `planning_period_type` STRING COMMENT 'The time granularity used for resource planning (week, sprint, month, quarter, or project phase).. Valid values are `week|sprint|month|quarter|phase`',
    `role_code` STRING COMMENT 'The standardized code representing the role or discipline required for this resource plan (e.g., ACD for Art Creative Director, CPY for Copywriter, STR for Strategist).',
    `role_name` STRING COMMENT 'The human-readable name of the role or discipline required (e.g., Art Director, Copywriter, Media Planner, Account Executive).',
    `seniority_level` STRING COMMENT 'The seniority or experience level required for the role (junior, mid-level, senior, lead, principal, director).. Valid values are `junior|mid|senior|lead|principal|director`',
    `skill_requirements` STRING COMMENT 'Specific skills, competencies, or certifications required for the role (e.g., Adobe Creative Suite, Google Ads Certification, Salesforce CRM, Spanish language fluency).',
    `total_planned_cost` DECIMAL(18,2) COMMENT 'The total planned cost for this resource allocation, calculated as planned hours multiplied by cost rate.',
    `created_by` STRING COMMENT 'The name or identifier of the user who created this resource plan record.',
    CONSTRAINT pk_resource_plan PRIMARY KEY(`resource_plan_id`)
) COMMENT 'Forward-looking resource demand plan for a project, capturing the planned allocation of agency talent and capacity across the project timeline. Stores project reference, planning period (week, sprint, month), role or discipline required, planned FTE count, planned hours, skill requirements, seniority level, department, cost rate applied, total planned cost, and plan version. Distinct from talent.resource_allocation (which records confirmed individual assignments) — this is the demand-side capacity plan used for staffing decisions and capacity forecasting at the project level.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`assignment` (
    `assignment_id` BIGINT COMMENT 'Unique identifier for the assignment record. Primary key.',
    `contract_rate_card_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_card. Business justification: project_assignment has billing_rate and cost_rate that must be validated against the contracted rate card header. In advertising agencies, assignment billing rates are governed by client-negotiated ra',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project to which this assignment belongs.',
    `rate_card_line_id` BIGINT COMMENT 'Foreign key linking to contract.rate_card_line. Business justification: Individual assignments in advertising agencies are priced at specific rate card line items (e.g., Senior Art Director at $X/hr per the SOW rate card). rate_card_line has role_title, seniority_level, u',
    `reassigned_from_project_assignment_id` BIGINT COMMENT 'Self-referencing FK on project_assignment (reassigned_from_project_assignment_id)',
    `resource_plan_id` BIGINT COMMENT 'Foreign key linking to project.resource_plan. Business justification: project_assignment (actual staffing) fulfills project_resource_plan (demand plan). Linking the assignment back to the resource plan it was created to fulfill closes the demand-to-actuals loop: agencie',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Resource assignments are scoped to SOWs. Agencies track which SOW funds each assignment for cost allocation, billing rate application, and ensuring resource deployment aligns with contractual scope an',
    `task_id` BIGINT COMMENT 'Reference to the specific task or work package within the project that this assignment addresses.',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: The product description explicitly states project_assignment links a specific worker or team member to a task or work package. The existing FK covers task_id but work_package_id is missing. Some ass',
    `actual_hours` DECIMAL(18,2) COMMENT 'The actual number of hours logged by the worker against the assigned task. Used for utilization tracking and billing.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the workers capacity allocated to this assignment, expressed as a decimal (e.g., 50.00 for 50% allocation).',
    `assigned_timestamp` TIMESTAMP COMMENT 'The date and time when the assignment was created or assigned to the worker.',
    `assignment_role` STRING COMMENT 'The role or capacity in which the worker is assigned to the task (e.g., lead, contributor, reviewer, approver, observer, consultant).. Valid values are `lead|contributor|reviewer|approver|observer|consultant`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment indicating whether it is active, completed, reassigned, on hold, or cancelled.. Valid values are `active|completed|reassigned|on_hold|cancelled`',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the hours worked on this assignment are billable to the client (True) or non-billable (False).',
    `billing_rate` DECIMAL(18,2) COMMENT 'The hourly billing rate applied to this assignment for client invoicing purposes. Confidential business data.',
    `completed_timestamp` TIMESTAMP COMMENT 'The date and time when the assignment was marked as completed by the worker or project manager.',
    `cost_rate` DECIMAL(18,2) COMMENT 'The internal cost rate per hour for the worker on this assignment, used for profitability analysis. Confidential business data.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this assignment record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for billing and cost rates (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'The date on which the worker is scheduled to complete work on the assigned task.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this assignment record was last modified. Audit trail field.',
    `notes` STRING COMMENT 'Additional notes or instructions related to the assignment, such as special requirements or context for the worker.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether the worker is eligible for overtime compensation on this assignment (True) or not (False).',
    `planned_hours` DECIMAL(18,2) COMMENT 'The estimated number of hours allocated for the worker to complete the assigned task.',
    `priority` STRING COMMENT 'The priority level of this assignment relative to other assignments for the worker (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `reassigned_timestamp` TIMESTAMP COMMENT 'The date and time when the assignment was reassigned to a different worker, if applicable.',
    `reassignment_reason` STRING COMMENT 'Free-text explanation for why the assignment was reassigned to a different worker, if applicable.',
    `skill_required` STRING COMMENT 'The primary skill or competency required for this assignment (e.g., copywriting, art direction, media planning, data analysis).',
    `start_date` DATE COMMENT 'The date on which the worker is scheduled to begin work on the assigned task.',
    `utilization_category` STRING COMMENT 'Classification of the assignment for workforce utilization reporting (e.g., client billable, internal project, training, administrative, bench).. Valid values are `client_billable|internal_project|training|administrative|bench`',
    `work_location` STRING COMMENT 'Indicates whether the assignment is to be performed on-site at the client or agency location, remotely, or in a hybrid arrangement.. Valid values are `on_site|remote|hybrid`',
    CONSTRAINT pk_assignment PRIMARY KEY(`assignment_id`)
) COMMENT 'Operational record linking a specific worker or team member to a task or work package within a project. Captures assignee worker reference, task or work package reference, assignment role (lead, contributor, reviewer, approver), planned hours, actual hours logged, assignment start date, assignment end date, allocation percentage, billable flag, billing rate applied, assignment status (active, completed, reassigned), and reassignment reason. Bridges project execution with talent workforce data and enables utilization tracking at the task level.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`project_brief` (
    `project_brief_id` BIGINT COMMENT 'Unique identifier for the project brief record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client advertiser for whom this project is being executed.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Project briefs are scoped to a specific client brand (e.g., Nike Running vs. Nike Basketball), driving brand safety rules, creative direction, and brand-level budget allocation. Advertising PMs always',
    `campaign_id` BIGINT COMMENT 'Reference to the associated campaign that this project brief supports.',
    `client_brief_id` BIGINT COMMENT 'Reference to the originating client brief that this project brief translates into an actionable plan.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: project_brief translates client briefs into actionable agency projects but currently has no direct link to the initiative product that represents the project execution. Adding initiative_id creates th',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Project briefs specify primary target audience segments for campaign planning and creative development. Agencies link briefs to segments to ensure creative deliverables align with audience strategy an',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Project briefs operationalize SOW commitments. Agencies must track which SOW funds each brief to validate scope, budget authority, and deliverable alignment during project kickoff and execution.',
    `superseded_project_brief_id` BIGINT COMMENT 'Self-referencing FK on project_brief (superseded_project_brief_id)',
    `persona_id` BIGINT COMMENT 'Foreign key linking to audience.persona. Business justification: Project briefs reference target personas to guide strategic planning and creative direction. Agencies link briefs to personas to ensure all project deliverables (creative, media, messaging) align with',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the project brief for execution.',
    `approved_date` DATE COMMENT 'Date when the project brief was formally approved for execution.',
    `brand_safety_notes` STRING COMMENT 'Brand safety considerations, content adjacency guidelines, and risk mitigation measures for media placement.',
    `brief_status` STRING COMMENT 'Current lifecycle status of the project brief indicating its stage in the approval and execution workflow.. Valid values are `draft|submitted|approved|in_execution|completed|cancelled`',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget envelope amount.. Valid values are `^[A-Z]{3}$`',
    `budget_envelope_amount` DECIMAL(18,2) COMMENT 'Total budget allocation or envelope amount approved for this project execution.',
    `channel_mix` STRING COMMENT 'Description of the media and marketing channels to be utilized in this project (e.g., digital, TV, OOH, social, CTV).',
    `completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the project was marked as completed.',
    `compliance_requirements` STRING COMMENT 'Regulatory, legal, and compliance requirements applicable to this project (e.g., GDPR, CCPA, FTC guidelines, ASA standards).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project brief record was first created in the system.',
    `creative_direction_notes` STRING COMMENT 'High-level creative direction, brand guidelines, tone, messaging themes, and creative considerations for the project.',
    `execution_start_timestamp` TIMESTAMP COMMENT 'Timestamp when project execution officially began following brief approval.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the project brief is currently active and in use.',
    `key_deliverables` STRING COMMENT 'Comprehensive list of key deliverables, outputs, and work products expected from this project.',
    `key_stakeholders` STRING COMMENT 'List of key stakeholders, decision-makers, and approvers involved in this project from both agency and client sides.',
    `measurement_framework` STRING COMMENT 'Description of the measurement and analytics framework to be used for tracking project performance and outcomes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the project brief record was last modified or updated.',
    `planned_end_date` DATE COMMENT 'Planned completion date for project execution as defined in the project brief.',
    `planned_start_date` DATE COMMENT 'Planned start date for project execution as defined in the project brief.',
    `priority_level` STRING COMMENT 'Priority classification of the project brief indicating urgency and resource allocation priority.. Valid values are `critical|high|medium|low`',
    `project_type` STRING COMMENT 'Classification of the project type indicating the nature of work to be performed.. Valid values are `campaign|creative_development|media_planning|brand_strategy|digital_marketing|content_production`',
    `risk_considerations` STRING COMMENT 'Identified risks, dependencies, and mitigation strategies relevant to project execution.',
    `scope_description` STRING COMMENT 'Detailed description of the project scope, including in-scope and out-of-scope activities.',
    `strategic_objectives` STRING COMMENT 'High-level strategic goals and business objectives that this project aims to achieve for the client.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the project brief was submitted for approval.',
    `success_criteria` STRING COMMENT 'Defined success criteria and key performance indicators (KPIs) that will be used to measure project success.',
    `target_audience_summary` STRING COMMENT 'Summary description of the target audience demographics, psychographics, and behavioral characteristics for this project.',
    `timeline_constraints` STRING COMMENT 'Description of any timeline constraints, critical milestones, or deadline dependencies that impact project scheduling.',
    `title` STRING COMMENT 'The descriptive title of the project brief that summarizes the project scope.',
    CONSTRAINT pk_project_brief PRIMARY KEY(`project_brief_id`)
) COMMENT 'Internal project initiation brief that translates a client brief or SOW into an actionable agency project plan. Captures brief title, project type, originating client brief reference, associated campaign reference, strategic objectives, target audience summary, key deliverables list, channel mix, budget envelope, timeline constraints, success criteria, key stakeholders, creative direction notes, and brief status (draft, approved, in-execution). Distinct from client.client_brief (client-submitted) and creative.creative_brief (creative-specific) — this is the project management layer brief governing overall project execution.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`deliverable_tracker` (
    `deliverable_tracker_id` BIGINT COMMENT 'Unique identifier for the deliverable tracking record. Primary key for operational tracking of project deliverables from brief through final delivery.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this deliverable supports, if applicable. Links deliverable to the broader campaign execution.',
    `contract_deliverable_id` BIGINT COMMENT 'Reference to the contractual deliverable commitment in the Statement of Work (SOW) or Insertion Order (IO). Links operational tracking to contractual obligation.',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project under which this deliverable is being produced.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Deliverables are reviewed and approved at milestone gates (project_milestone has is_billing_trigger and is_contractual_gate flags). Linking deliverable_tracker to project_milestone enables the system ',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Media plans are contractual deliverables tracked through project delivery workflows. Required for client approval gates, billing triggers tied to plan delivery, and SOW compliance verification in agen',
    `project_brief_id` BIGINT COMMENT 'Foreign key linking to project.project_brief. Business justification: Deliverables are defined and scoped in the project_brief (key_deliverables, scope_description, success_criteria). Linking deliverable_tracker to project_brief provides direct traceability from the bri',
    `revision_of_deliverable_tracker_id` BIGINT COMMENT 'Self-referencing FK on deliverable_tracker (revision_of_deliverable_tracker_id)',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Deliverables in advertising (video assets, display creatives, media placements) are produced by specific vendors. Linking supplier_id to deliverable_tracker enables vendor-level delivery performance r',
    `task_id` BIGINT COMMENT 'Foreign key linking to project.task. Business justification: A deliverable is produced by executing specific tasks. deliverable_tracker already links to work_package_id (the container) but lacks a direct link to the specific task that produces the deliverable. ',
    `trafficking_instruction_id` BIGINT COMMENT 'Foreign key linking to media.trafficking_instruction. Business justification: Trafficking instructions are formal deliverables in ad agency project management — they must be authored, reviewed, approved, and sent to ad servers. Project teams track each instruction as a delivera',
    `work_package_id` BIGINT COMMENT 'Reference to the work package or work breakdown structure element that this deliverable belongs to.',
    `actual_delivery_date` DATE COMMENT 'Actual date on which the deliverable was delivered. Used to measure on-time delivery performance and project execution accuracy.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual effort in hours logged against this deliverable. Used to measure estimation accuracy and project profitability.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the deliverable received final client approval. Marks formal acceptance and completion of the deliverable lifecycle.',
    `client_approval_status` STRING COMMENT 'Current approval state from the client perspective. Indicates whether the client has formally accepted the deliverable.. Valid values are `pending|approved|rejected|approved_with_changes|not_required`',
    `compliance_check_status` STRING COMMENT 'Status of regulatory and brand compliance review. Ensures deliverable meets legal, regulatory, and brand guideline requirements before delivery.. Valid values are `not_required|pending|passed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deliverable tracking record was first created in the system. Marks the start of operational tracking.',
    `deliverable_name` STRING COMMENT 'Business name or title of the deliverable being tracked (e.g., Q4 Brand Campaign Video, Media Plan Deck, Trafficking Sheet).',
    `deliverable_status` STRING COMMENT 'Current lifecycle status of the deliverable in the production workflow. Tracks progression from initiation through final delivery. [ENUM-REF-CANDIDATE: not_started|in_production|in_review|approved|delivered|rejected|on_hold|cancelled — 8 candidates stripped; promote to reference product]',
    `deliverable_type` STRING COMMENT 'Classification of the deliverable by format and purpose. Distinguishes creative assets from strategic documents, operational setup files, and reporting outputs. [ENUM-REF-CANDIDATE: creative_asset|media_plan|strategy_deck|report|campaign_setup|trafficking_sheet|presentation|research_report|analytics_dashboard|social_content|video_asset|display_banner|landing_page|email_creative|print_collateral|ooh_creative|other — 17 candidates stripped; promote to reference product]',
    `delivered_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the deliverable was marked as delivered. Provides exact delivery time for Service Level Agreement (SLA) measurement.',
    `delivery_channel` STRING COMMENT 'Method or platform through which the deliverable was or will be transmitted to the recipient (e.g., email, client portal, FTP, DAM system). [ENUM-REF-CANDIDATE: email|client_portal|ftp|dam|cloud_storage|physical_delivery|api|other — 8 candidates stripped; promote to reference product]',
    `delivery_notes` STRING COMMENT 'Free-text notes accompanying the deliverable delivery. May include usage instructions, context, or special handling requirements.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Planned effort in hours required to complete this deliverable. Used for resource planning and capacity management.',
    `file_reference` STRING COMMENT 'File path, URL, or Digital Asset Management (DAM) system reference pointing to the deliverable asset location.',
    `format_specification` STRING COMMENT 'Technical format requirements for the deliverable (e.g., MP4 1920x1080 30fps, PDF print-ready CMYK, HTML5 300x250). Ensures deliverable meets technical specifications.',
    `internal_approval_status` STRING COMMENT 'Internal agency approval status before client submission. Ensures quality control and brand compliance before external delivery.. Valid values are `pending|approved|rejected|not_required`',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this deliverable is billable to the client or is part of non-billable agency overhead or pro-bono work.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this deliverable tracking record. Used for change tracking and audit trail.',
    `planned_delivery_date` DATE COMMENT 'Target date by which the deliverable is scheduled to be completed and delivered to the client or internal stakeholder.',
    `priority` STRING COMMENT 'Business priority level assigned to this deliverable. Drives resource allocation and scheduling decisions.. Valid values are `critical|high|medium|low`',
    `rejection_reason` STRING COMMENT 'Explanation provided when a deliverable is rejected by client or internal reviewer. Captures feedback for rework and process improvement.',
    `review_round_count` STRING COMMENT 'Number of review cycles the deliverable has undergone. Tracks iteration intensity and helps identify scope creep or unclear requirements.',
    `source_system_deliverable_code` STRING COMMENT 'Original identifier from the source project management or work management system (e.g., Workfront task ID, Monday.com item ID).',
    `source_system_name` STRING COMMENT 'Name of the operational system from which this deliverable tracking record originated (e.g., Workfront, Monday.com, Asana).',
    `version_number` STRING COMMENT 'Version identifier for the deliverable (e.g., v1.0, v2.3, Final). Tracks iteration history and ensures version control.',
    CONSTRAINT pk_deliverable_tracker PRIMARY KEY(`deliverable_tracker_id`)
) COMMENT 'Operational tracking record for each project deliverable — monitoring production progress from brief through final delivery. Captures deliverable name, deliverable type (creative asset, media plan, strategy deck, report, campaign setup, trafficking sheet, etc.), associated work package, planned delivery date, actual delivery date, delivery status (not started, in production, in review, approved, delivered, rejected), review round count, client approval status, format specifications, file reference, and delivery channel (email, portal, FTP, DAM). Distinct from contract.deliverable (contractual commitment) — this is the operational production tracking record.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique identifier for the time entry record. Primary key for the time entry entity.',
    `adjusted_time_entry_id` BIGINT COMMENT 'Self-referencing FK on time_entry (adjusted_time_entry_id)',
    `assignment_id` BIGINT COMMENT 'Foreign key linking to project.project_assignment. Business justification: Time entries are submitted by workers who operate under specific project assignments. Linking time_entry to project_assignment provides the assignment context (billing_rate, cost_rate, assignment_role',
    `contract_rate_card_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_card. Business justification: time_entry has billing_rate and cost_rate that must reconcile against the contracted rate card. Advertising agencies bill time against client-negotiated rate cards. This link enables billing validatio',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Time entries must post to cost centers for labor cost allocation, utilization reporting, and departmental P&L. Core requirement for agency financial systems integrating time tracking with GL posting.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Time entries (labor costs) must be charged against the approved finance budget for labor cost tracking and budget consumption reporting. This is core agency resource management — time entries drive bu',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Time entries require GL account assignment for payroll expense posting and revenue recognition. Essential for labor cost capitalization, WIP accounting, and financial statement preparation in agency o',
    `initiative_id` BIGINT COMMENT 'Reference to the project against which this time was logged. Links to the project domain project entity.',
    `rate_card_line_id` BIGINT COMMENT 'Foreign key linking to contract.rate_card_line. Business justification: Time entries in advertising are billed at specific rate card line rates by role and service type. rate_card_line has unit_rate, role_title, service_type matching time_entry billing attributes. This li',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Time is billed against SOWs. Agencies track SOW-level time for client invoicing, utilization reporting, and validating labor charges against SOW rate cards and authorized budget caps.',
    `task_id` BIGINT COMMENT 'Reference to the specific task or deliverable against which time was logged. Links to the project.task entity.',
    `work_package_id` BIGINT COMMENT 'Reference to the work package within the project. Represents a logical grouping of tasks for billing or resource planning purposes.',
    `activity_type` STRING COMMENT 'The type of work activity performed during this time entry. Categorizes time for resource utilization analysis and billing purposes. [ENUM-REF-CANDIDATE: creative_development|strategy|client_management|production|media_planning|quality_assurance|account_services|research|copywriting|design|video_editing|project_management|administrative — promote to reference product]. Valid values are `creative_development|strategy|client_management|production|media_planning|quality_assurance`',
    `approval_status` STRING COMMENT 'Current approval state of the time entry. Tracks the workflow from submission through manager approval for payroll and billing processing.. Valid values are `draft|submitted|approved|rejected|pending_revision`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the time entry was approved or rejected by the approver. Null if not yet reviewed.',
    `billable_amount` DECIMAL(18,2) COMMENT 'The total billable amount for this time entry, calculated as hours_logged multiplied by billing_rate. Null for non-billable entries. Used for revenue recognition and client invoicing.',
    `billing_rate` DECIMAL(18,2) COMMENT 'The hourly billing rate applied to this time entry for client invoicing. May vary by worker role, project contract terms, or activity type. Null for non-billable entries.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total internal cost for this time entry, calculated as hours_logged multiplied by cost_rate. Used for project margin analysis and financial reporting.',
    `cost_rate` DECIMAL(18,2) COMMENT 'The internal cost rate per hour for this worker. Used for project profitability analysis and resource cost tracking. Distinct from billing_rate.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this time entry record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the billable amount (e.g., USD, EUR, GBP). Supports multi-currency project billing.. Valid values are `^[A-Z]{3}$`',
    `entry_date` DATE COMMENT 'The calendar date on which the work was performed. Used for timesheet aggregation and project timeline tracking.',
    `hours_logged` DECIMAL(18,2) COMMENT 'The number of hours worked on this task for the entry date. Supports fractional hours (e.g., 1.5 hours, 0.25 hours).',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this time entry is billable to the client. True for billable time, False for non-billable or internal time.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether this time entry is locked and cannot be edited. True when the entry has been processed for payroll or billing. False for editable entries.',
    `is_overtime` BOOLEAN COMMENT 'Indicates whether this time entry represents overtime hours. True for overtime, False for regular hours. Used for payroll processing and labor cost analysis.',
    `location` STRING COMMENT 'The physical or virtual location where the work was performed. Used for resource allocation analysis and compliance with remote work policies.. Valid values are `office|remote|client_site|hybrid`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this time entry record was last modified. Updated whenever any field changes. Used for change tracking and audit purposes.',
    `notes` STRING COMMENT 'Optional free-text notes or comments provided by the worker describing the work performed. Used for detailed activity tracking and client reporting.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver when rejecting a time entry. Null for approved or pending entries.',
    `source_system_code` STRING COMMENT 'The unique identifier for this time entry in the source system (Workfront or Monday.com). Used for data lineage and reconciliation.',
    `source_system_name` STRING COMMENT 'The name of the system from which this time entry was ingested. Supports multi-system time tracking integration.. Valid values are `workfront|monday_com|workday|manual_entry`',
    `submitted_timestamp` TIMESTAMP COMMENT 'The date and time when the worker submitted this time entry for approval. Null for draft entries.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Individual time entry record submitted by agency staff against a specific project task or work package — the granular time-tracking record at the project level. Captures worker reference, project reference, work package reference, task reference, entry date, hours logged, activity type (creative development, strategy, client management, production, media planning, QA, admin), billable flag, billing rate, billable amount, approval status (submitted, approved, rejected), approver, and source system (Workfront/Monday.com timelog ID). Distinct from talent.timesheet (the aggregated pay-period timesheet header) — this is the line-level project time allocation record.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`project_budget` (
    `project_budget_id` BIGINT COMMENT 'Unique identifier for the project budget record. Primary key.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: Contract amendments in advertising trigger project budget revisions (scope changes, budget increases). Linking project_budget.amendment_id → amendment provides the audit trail showing which amendment ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Agency project budgets are allocated and tracked at brand level for brand-level P&L and budget utilization reporting. Finance teams require direct brand attribution on project budgets to produce brand',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.contract_insertion_order. Business justification: In advertising agencies, project budgets are built directly against Insertion Orders — the IO is the spend authorization document. This link enables IO-to-budget reconciliation reporting, a core finan',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Project budgets are posted to cost centers for management accounting and overhead allocation. project_budget has a denormalized cost_center_code plain attribute but no FK. Linking to cost_center enabl',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Agency project budgets must reconcile against the finance-controlled finance_budget for variance reporting, SOX compliance, and budget approval workflows. Finance teams need to trace project spend bac',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Project budgets need GL account mapping for financial statement integration, accrual posting, and revenue/expense classification. Required for month-end close and financial reporting in agency ERP sys',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project for which this budget is defined. Links to the project master record.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Project budgets allocate funds to specific media plans. Required for variance analysis between planned media spend and project budget, enabling financial forecasting, budget reallocation decisions, an',
    `revised_from_project_budget_id` BIGINT COMMENT 'Self-referencing FK on project_budget (revised_from_project_budget_id)',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Project budgets are allocated from SOW budgets. Finance tracks SOW-to-project budget mapping for billing reconciliation, variance analysis, and ensuring project spend does not exceed contractual autho',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: project_budget contains a `third_party_vendor_budget` attribute, confirming per-vendor budget allocation is tracked. Linking supplier_id enables budget-vs-actual spend reporting by vendor — a standard',
    `vendor_rate_card_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_rate_card. Business justification: In advertising, project budgets for media and production are built from vendor rate cards. Linking vendor_rate_card_id to project_budget enables budget-to-rate-card traceability — auditors and finance',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: project_budget currently carries work_breakdown_structure_code as a free-text string reference to the WBS. Adding a proper FK work_package_id to project.work_package normalizes this relationship, repl',
    `approval_date` DATE COMMENT 'Date on which this budget version was formally approved by the authorized approver or governance body.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget version was formally approved. Captures the precise moment of approval for audit and compliance purposes.',
    `baseline_budget_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this budget version represents the original approved baseline for the project. True for the baseline version, False for revisions.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget: draft (in preparation), submitted (pending approval), approved (active), locked (no further changes), over-budget (exceeded threshold), or closed (project complete).. Valid values are `draft|submitted|approved|locked|over_budget|closed`',
    `budget_type` STRING COMMENT 'Classification of the budget record: original approved (baseline), revised (internal adjustment), client-approved (client sign-off), internal forecast (planning estimate), or contingency (reserve allocation).. Valid values are `original_approved|revised|client_approved|internal_forecast|contingency`',
    `client_approval_date` DATE COMMENT 'Date on which the client formally approved this budget version. Null if not yet client-approved.',
    `client_approved_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this budget version has been formally approved by the client. True if client-approved, False otherwise.',
    `contingency_reserve` DECIMAL(18,2) COMMENT 'Budget reserve allocated for identified risks and known-unknowns. Typically controlled by the project manager and released as needed for scope changes or risk mitigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the source system. Supports audit trail and data lineage.',
    `creative_production_budget` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated to creative development and production activities, including design, video production, photography, and Digital Asset Management (DAM).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date on which this budget version ceases to be effective. Null for the current active budget version.',
    `effective_start_date` DATE COMMENT 'Date from which this budget version becomes effective and active for financial tracking and control.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter to which this project budget primarily applies (Q1, Q2, Q3, Q4). Supports quarterly financial planning and Quarterly Business Review (QBR) processes.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this project budget applies (e.g., 2024, 2025). Enables financial period alignment and year-over-year analysis.. Valid values are `^[0-9]{4}$`',
    `labor_budget` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated to labor costs, including salaries, contractor fees, and Full-Time Equivalent (FTE) resources.',
    `locked_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget version was locked to prevent further modifications. Null if the budget is still open for changes.',
    `management_reserve` DECIMAL(18,2) COMMENT 'Budget reserve allocated for unknown-unknowns and unplanned scope changes. Typically controlled by senior management and requires formal approval to access.',
    `media_budget` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated to media buying and placement costs across all channels (digital, broadcast, print, Out-of-Home (OOH), etc.).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last modified in the source system. Supports change tracking and audit trail.',
    `notes` STRING COMMENT 'Free-text field for additional notes, assumptions, constraints, or context related to this budget version. Supports audit trail and knowledge transfer.',
    `remaining_budget` DECIMAL(18,2) COMMENT 'Calculated remaining budget available for allocation. Typically total_approved_budget minus (total_committed_spend + total_actual_spend).',
    `revision_reason` STRING COMMENT 'Textual explanation of why this budget version was revised from the previous version. Captures scope changes, client requests, cost overruns, or other justifications.',
    `source_system_budget_code` STRING COMMENT 'Original budget identifier from the source system (e.g., Workfront project budget ID, SAP Project Systems (PS) budget ID). Enables traceability and reconciliation.',
    `source_system_name` STRING COMMENT 'Name of the operational system from which this budget record originated (e.g., Workfront, SAP S/4HANA PS, Mediaocean Prisma). Supports data lineage and Extract Transform Load (ETL) auditing.',
    `technology_budget` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated to technology costs, including ad serving platforms, Demand-Side Platform (DSP), Data Management Platform (DMP), analytics tools, and Application Programming Interface (API) integrations.',
    `third_party_vendor_budget` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated to external vendor services, including research firms, data providers, freelancers, and specialized consultants.',
    `total_actual_spend` DECIMAL(18,2) COMMENT 'Cumulative amount of budget that has been actually spent (invoiced and paid or accrued) against this project budget.',
    `total_approved_budget` DECIMAL(18,2) COMMENT 'The total financial envelope approved for this project budget version. Represents the authorized spending limit.',
    `total_committed_spend` DECIMAL(18,2) COMMENT 'Cumulative amount of budget that has been committed through Purchase Orders (PO), Insertion Orders (IO), contracts, or other binding commitments, but not yet invoiced or paid.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total approved budget that has been utilized (committed or spent). Calculated as ((total_committed_spend + total_actual_spend) / total_approved_budget) * 100.',
    `version` STRING COMMENT 'Version identifier for this budget iteration (e.g., v1.0, v2.1, 2024-Q1-Rev3). Enables tracking of budget revisions over the project lifecycle.',
    CONSTRAINT pk_project_budget PRIMARY KEY(`project_budget_id`)
) COMMENT 'Project-level budget record defining the approved financial envelope for a project, distinct from finance.budget (which operates at cost center and campaign level). Captures project reference, budget version, budget type (original approved, revised, client-approved), total approved budget, budget by phase or work package, contingency reserve, management reserve, currency, approval date, approver, budget status (draft, approved, locked, over-budget), total committed spend, total actual spend, and remaining budget. Enables project financial control and client billing reconciliation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_parent_initiative_id` FOREIGN KEY (`parent_initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`work_package` ADD CONSTRAINT `fk_project_work_package_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`work_package` ADD CONSTRAINT `fk_project_work_package_parent_work_package_id` FOREIGN KEY (`parent_work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`task` ADD CONSTRAINT `fk_project_task_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`task` ADD CONSTRAINT `fk_project_task_parent_task_id` FOREIGN KEY (`parent_task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`project`.`task` ADD CONSTRAINT `fk_project_task_primary_predecessor_task_id` FOREIGN KEY (`primary_predecessor_task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`project`.`task` ADD CONSTRAINT `fk_project_task_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_replanned_from_project_milestone_id` FOREIGN KEY (`replanned_from_project_milestone_id`) REFERENCES `advertising_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `advertising_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ADD CONSTRAINT `fk_project_resource_plan_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ADD CONSTRAINT `fk_project_resource_plan_revised_from_resource_plan_id` FOREIGN KEY (`revised_from_resource_plan_id`) REFERENCES `advertising_ecm`.`project`.`resource_plan`(`resource_plan_id`);
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ADD CONSTRAINT `fk_project_resource_plan_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`assignment` ADD CONSTRAINT `fk_project_assignment_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`assignment` ADD CONSTRAINT `fk_project_assignment_reassigned_from_project_assignment_id` FOREIGN KEY (`reassigned_from_project_assignment_id`) REFERENCES `advertising_ecm`.`project`.`assignment`(`assignment_id`);
ALTER TABLE `advertising_ecm`.`project`.`assignment` ADD CONSTRAINT `fk_project_assignment_resource_plan_id` FOREIGN KEY (`resource_plan_id`) REFERENCES `advertising_ecm`.`project`.`resource_plan`(`resource_plan_id`);
ALTER TABLE `advertising_ecm`.`project`.`assignment` ADD CONSTRAINT `fk_project_assignment_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`project`.`assignment` ADD CONSTRAINT `fk_project_assignment_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_superseded_project_brief_id` FOREIGN KEY (`superseded_project_brief_id`) REFERENCES `advertising_ecm`.`project`.`project_brief`(`project_brief_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `advertising_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_project_brief_id` FOREIGN KEY (`project_brief_id`) REFERENCES `advertising_ecm`.`project`.`project_brief`(`project_brief_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_revision_of_deliverable_tracker_id` FOREIGN KEY (`revision_of_deliverable_tracker_id`) REFERENCES `advertising_ecm`.`project`.`deliverable_tracker`(`deliverable_tracker_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_adjusted_time_entry_id` FOREIGN KEY (`adjusted_time_entry_id`) REFERENCES `advertising_ecm`.`project`.`time_entry`(`time_entry_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `advertising_ecm`.`project`.`assignment`(`assignment_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_revised_from_project_budget_id` FOREIGN KEY (`revised_from_project_budget_id`) REFERENCES `advertising_ecm`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`project` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `advertising_ecm`.`project` SET TAGS ('dbx_domain' = 'project');
ALTER TABLE `advertising_ecm`.`project`.`initiative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`initiative` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative ID');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `attribution_model_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `parent_initiative_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Project Cost');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Days)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `billing_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Type');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `billing_type` SET TAGS ('dbx_value_regex' = 'fixed_fee|time_and_materials|retainer|performance_based|hybrid');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Amount');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `client_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Client Satisfaction Score');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `deliverables_summary` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Summary');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `delivery_methodology` SET TAGS ('dbx_business_glossary_term' = 'Delivery Methodology');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `delivery_methodology` SET TAGS ('dbx_value_regex' = 'agile|waterfall|hybrid|kanban');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `health_indicator` SET TAGS ('dbx_business_glossary_term' = 'Project Health Indicator');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `health_indicator` SET TAGS ('dbx_value_regex' = 'green|yellow|red');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `health_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `health_indicator` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `initiative_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `initiative_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `initiative_status` SET TAGS ('dbx_value_regex' = 'briefing|planning|in_flight|on_hold|completed|cancelled');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential Flag');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `kickoff_date` SET TAGS ('dbx_business_glossary_term' = 'Kickoff Date');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Project Notes');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `owning_department` SET TAGS ('dbx_business_glossary_term' = 'Owning Department');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Days)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Project ID');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `source_system_name` SET TAGS ('dbx_value_regex' = 'workfront|monday|asana|jira|smartsheet');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `advertising_ecm`.`project`.`work_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`work_package` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `parent_work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Package Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_approval|approved|rejected|approved_with_changes');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Owning Discipline');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path Flag');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Work Package Notes');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `planned_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Effort Hours');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Package Priority');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `wbs_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]+(.[A-Z0-9]+)*$');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `wbs_level` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Level');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `work_package_description` SET TAGS ('dbx_business_glossary_term' = 'Work Package Description');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `work_package_name` SET TAGS ('dbx_business_glossary_term' = 'Work Package Name');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `work_package_status` SET TAGS ('dbx_business_glossary_term' = 'Work Package Status');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `work_package_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|on_hold|completed|cancelled|under_review');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `work_package_type` SET TAGS ('dbx_business_glossary_term' = 'Work Package Type');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `work_package_type` SET TAGS ('dbx_value_regex' = 'deliverable|milestone|phase|task_group|control_account');
ALTER TABLE `advertising_ecm`.`project`.`task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`project`.`task` SET TAGS ('dbx_subdomain' = 'delivery_execution');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `parent_task_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `primary_predecessor_task_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Task Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected|changes_requested');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `dependency_type` SET TAGS ('dbx_business_glossary_term' = 'Dependency Type');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `dependency_type` SET TAGS ('dbx_value_regex' = 'finish_to_start|start_to_start|finish_to_finish|start_to_finish|none');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `is_milestone` SET TAGS ('dbx_business_glossary_term' = 'Is Milestone Flag');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `logged_hours` SET TAGS ('dbx_business_glossary_term' = 'Logged Hours');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Task Notes');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent|critical');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `source_system_name` SET TAGS ('dbx_value_regex' = 'workfront|monday|other');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `source_system_task_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Task Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Task Name');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|blocked|complete|cancelled|on_hold');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'creative_production|copywriting|media_trafficking|client_review|qa|approval');
ALTER TABLE `advertising_ecm`.`project`.`milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`milestone` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `replanned_from_project_milestone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approved Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Milestone Completion Percentage');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `dependency_count` SET TAGS ('dbx_business_glossary_term' = 'Dependency Count');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `is_billing_trigger` SET TAGS ('dbx_business_glossary_term' = 'Is Billing Trigger Flag');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `is_contractual_gate` SET TAGS ('dbx_business_glossary_term' = 'Is Contractual Gate Flag');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path Flag');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `project_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `project_milestone_status` SET TAGS ('dbx_value_regex' = 'upcoming|in_progress|achieved|missed|deferred|cancelled');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Milestone Risk Level');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `sow_milestone_reference` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Milestone Reference');
ALTER TABLE `advertising_ecm`.`project`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Milestone Variance in Days');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `resource_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Plan ID');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `revised_from_resource_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `cost_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `cost_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate Currency');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `cost_rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `location_preference` SET TAGS ('dbx_business_glossary_term' = 'Location Preference');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `location_preference` SET TAGS ('dbx_value_regex' = 'onsite|remote|hybrid|any');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|superseded|cancelled');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `planned_fte` SET TAGS ('dbx_business_glossary_term' = 'Planned Full-Time Equivalent (FTE)');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Type');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_value_regex' = 'week|sprint|month|quarter|phase');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Role Code');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Role Name');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `seniority_level` SET TAGS ('dbx_value_regex' = 'junior|mid|senior|lead|principal|director');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `skill_requirements` SET TAGS ('dbx_business_glossary_term' = 'Skill Requirements');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `total_planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Cost');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `total_planned_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`project`.`assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`project`.`assignment` SET TAGS ('dbx_subdomain' = 'delivery_execution');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `rate_card_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `reassigned_from_project_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `resource_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_value_regex' = 'lead|contributor|reviewer|approver|observer|consultant');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|completed|reassigned|on_hold|cancelled');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `billing_rate` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `billing_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `cost_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `reassigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reassigned Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `reassignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Reason');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `skill_required` SET TAGS ('dbx_business_glossary_term' = 'Skill Required');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `utilization_category` SET TAGS ('dbx_business_glossary_term' = 'Utilization Category');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `utilization_category` SET TAGS ('dbx_value_regex' = 'client_billable|internal_project|training|administrative|bench');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `advertising_ecm`.`project`.`assignment` ALTER COLUMN `work_location` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `project_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Project Brief Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `client_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brief Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `superseded_project_brief_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Target Persona Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `brand_safety_notes` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Notes');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `brief_status` SET TAGS ('dbx_business_glossary_term' = 'Project Brief Status');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `brief_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|in_execution|completed|cancelled');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `budget_envelope_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Envelope Amount');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `budget_envelope_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `creative_direction_notes` SET TAGS ('dbx_business_glossary_term' = 'Creative Direction Notes');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `execution_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `key_deliverables` SET TAGS ('dbx_business_glossary_term' = 'Key Deliverables List');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `key_stakeholders` SET TAGS ('dbx_business_glossary_term' = 'Key Stakeholders');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `measurement_framework` SET TAGS ('dbx_business_glossary_term' = 'Measurement Framework');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'campaign|creative_development|media_planning|brand_strategy|digital_marketing|content_production');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `risk_considerations` SET TAGS ('dbx_business_glossary_term' = 'Risk Considerations');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `strategic_objectives` SET TAGS ('dbx_business_glossary_term' = 'Strategic Objectives');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `success_criteria` SET TAGS ('dbx_business_glossary_term' = 'Success Criteria');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `target_audience_summary` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Summary');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `timeline_constraints` SET TAGS ('dbx_business_glossary_term' = 'Timeline Constraints');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Project Brief Title');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` SET TAGS ('dbx_subdomain' = 'delivery_execution');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `deliverable_tracker_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Tracker ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `contract_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Deliverable ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `project_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Project Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `revision_of_deliverable_tracker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `trafficking_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Instruction Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `client_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Status');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `client_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|approved_with_changes|not_required');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|passed|failed');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Name');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `deliverable_status` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Status');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `file_reference` SET TAGS ('dbx_business_glossary_term' = 'File Reference');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `format_specification` SET TAGS ('dbx_business_glossary_term' = 'Format Specification');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Status');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Priority');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `review_round_count` SET TAGS ('dbx_business_glossary_term' = 'Review Round Count');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `source_system_deliverable_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Deliverable ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` SET TAGS ('dbx_subdomain' = 'delivery_execution');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `adjusted_time_entry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Project Assignment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `rate_card_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'creative_development|strategy|client_management|production|media_planning|quality_assurance');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|pending_revision');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `billable_amount` SET TAGS ('dbx_business_glossary_term' = 'Billable Amount');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `billable_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `billing_rate` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `billing_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `cost_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Date');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `hours_logged` SET TAGS ('dbx_business_glossary_term' = 'Hours Logged');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Locked Flag');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `is_overtime` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `location` SET TAGS ('dbx_value_regex' = 'office|remote|client_site|hybrid');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Notes');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `source_system_name` SET TAGS ('dbx_value_regex' = 'workfront|monday_com|workday|manual_entry');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `revised_from_project_budget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `baseline_budget_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Budget Flag');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|locked|over_budget|closed');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'original_approved|revised|client_approved|internal_forecast|contingency');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `client_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Approved Flag');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `contingency_reserve` SET TAGS ('dbx_business_glossary_term' = 'Contingency Reserve');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `creative_production_budget` SET TAGS ('dbx_business_glossary_term' = 'Creative Production Budget');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `labor_budget` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `locked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Locked Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `management_reserve` SET TAGS ('dbx_business_glossary_term' = 'Management Reserve');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `media_budget` SET TAGS ('dbx_business_glossary_term' = 'Media Budget');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `remaining_budget` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Reason');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `source_system_budget_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Budget Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `technology_budget` SET TAGS ('dbx_business_glossary_term' = 'Technology Budget');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `third_party_vendor_budget` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Vendor Budget');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `total_actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Spend');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `total_approved_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Budget');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `total_committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Spend');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Utilization Percentage');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
