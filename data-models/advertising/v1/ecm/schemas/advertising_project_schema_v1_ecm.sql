-- Schema for Domain: project | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`project` COMMENT 'Manages agency project lifecycle, work breakdown structures, task assignments, timelines, milestones, and resource scheduling across campaigns and client engagements. Integrates with Workfront/Monday.com as system of record for project execution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`initiative` (
    `initiative_id` BIGINT COMMENT 'Unique identifier for the agency project or engagement. Primary key.',
    `worker_id` BIGINT COMMENT 'Reference to the account director overseeing client relationship and project governance.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client advertiser account for whom this project is being executed.',
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: Projects are delivered under specific agency relationship agreements (AOR, project-based retainer, pitch work). Tracking which relationship governs the work is essential for billing rules, scope bound',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Master agreements govern multi-project client relationships. Agencies link initiatives to MSAs to apply correct rate cards, enforce compliance obligations, and manage multi-year retainer terms across ',
    `attribution_model_id` BIGINT COMMENT 'Foreign key linking to performance.attribution_model. Business justification: Strategic initiatives define attribution methodology for performance evaluation. Real business process: campaign planning phase where strategists select attribution model (last-click, linear, data-dri',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Initiatives execute brand-specific work requiring access to brand guidelines, assets, positioning, and compliance rules. Core operational link for project setup and brand governance in advertising del',
    `campaign_id` BIGINT COMMENT 'Reference to the associated marketing campaign if this project is part of a broader campaign initiative. Nullable for non-campaign projects.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Projects must be assigned to cost centers for financial reporting, budget allocation, and P&L tracking in agency operations. Essential for departmental profitability analysis and overhead allocation.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Initiatives execute SOW-defined scope. Agencies track SOW-to-project mapping for revenue recognition, deliverable tracking, budget burn analysis, and client invoicing against contractual commitments.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Projects/initiatives frequently engage vendors for media buying, tech platforms, creative production. Tracking primary supplier enables project vendor management, cost allocation, and vendor performan',
    `parent_initiative_id` BIGINT COMMENT 'Self-referencing FK on initiative (parent_initiative_id)',
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
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Work packages deliver brand-specific outputs (creative assets, media plans, PR materials). Tracking brand context at work package level enables brand compliance validation and portfolio reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Work packages require cost center assignment for labor cost allocation and profitability analysis by discipline. Enables accurate project costing and departmental charge-back in agency financial syste',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project or campaign engagement that this work package belongs to.',
    `parent_work_package_id` BIGINT COMMENT 'Reference to the parent work package in the hierarchical WBS structure. Null for top-level packages.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Work packages decompose SOW scope. Agencies map WBS elements to SOW scope items for traceability, ensuring all contracted deliverables are planned and no out-of-scope work is executed without authoriz',
    `worker_id` BIGINT COMMENT 'Primary resource (employee or contractor) assigned as owner/lead for this work package. Links to talent/resource management system.',
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
    `worker_id` BIGINT COMMENT 'Reference to the individual worker or employee assigned to complete this task.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tasks need cost center tracking for time-based costing and departmental charge-back. Critical for labor cost allocation when time entries roll up to tasks for financial posting.',
    `initiative_id` BIGINT COMMENT 'Reference to the project this task belongs to.',
    `org_unit_id` BIGINT COMMENT 'Reference to the team assigned to this task.',
    `predecessor_task_id` BIGINT COMMENT 'Reference to the task that must be completed or started before this task can proceed, based on the dependency type.',
    `work_package_id` BIGINT COMMENT 'Reference to the parent work package that contains this task.',
    `parent_task_id` BIGINT COMMENT 'Self-referencing FK on task (parent_task_id)',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`project_milestone` (
    `project_milestone_id` BIGINT COMMENT 'Unique identifier for the project milestone. Primary key.',
    `worker_id` BIGINT COMMENT 'Reference to the employee authorized to approve milestone completion and sign off on deliverables.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.milestone. Business justification: Contractual milestones trigger payment and acceptance gates. Project teams must track which project milestones satisfy contract obligations to enable billing, client sign-off, and revenue recognition ',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project to which this milestone belongs.',
    `primary_project_worker_id` BIGINT COMMENT 'Reference to the employee responsible for ensuring milestone completion and stakeholder coordination.',
    `work_package_id` BIGINT COMMENT 'Reference to the associated work package or phase within the project structure.',
    `replanned_from_project_milestone_id` BIGINT COMMENT 'Self-referencing FK on project_milestone (replanned_from_project_milestone_id)',
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
    CONSTRAINT pk_project_milestone PRIMARY KEY(`project_milestone_id`)
) COMMENT 'Significant scheduled checkpoint or deliverable gate within a project lifecycle. Captures milestone name, description, milestone type (kickoff, creative review, client approval, campaign launch, post-campaign report, billing trigger, contractual gate), planned date, actual date, status (upcoming, achieved, missed, deferred), owner, associated work package, linked SOW contractual milestone reference, and variance in days between planned and actual achievement. Used for client reporting, billing triggers, and executive project health dashboards.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`resource_plan` (
    `resource_plan_id` BIGINT COMMENT 'Unique identifier for the resource plan record. Primary key for the resource plan entity.',
    `initiative_id` BIGINT COMMENT 'Reference to the project for which this resource plan is created. Links to the project master entity.',
    `position_id` BIGINT COMMENT 'Foreign key linking to talent.position. Business justification: Resource plans specify role requirements for initiatives; linking to position enables headcount planning alignment, budget-to-actual position cost comparison, position utilization forecasting, and wor',
    `revised_from_resource_plan_id` BIGINT COMMENT 'Self-referencing FK on resource_plan (revised_from_resource_plan_id)',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`project_assignment` (
    `project_assignment_id` BIGINT COMMENT 'Unique identifier for the assignment record. Primary key.',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project to which this assignment belongs.',
    `position_id` BIGINT COMMENT 'Foreign key linking to talent.position. Business justification: Assignments staff workers into project roles; linking to position enables position utilization tracking, role-based capacity planning, position cost rate application for billing, and position-level re',
    `worker_id` BIGINT COMMENT 'Reference to the worker or team member assigned to the task. Links to talent workforce data.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Resource assignments are scoped to SOWs. Agencies track which SOW funds each assignment for cost allocation, billing rate application, and ensuring resource deployment aligns with contractual scope an',
    `talent_engagement_id` BIGINT COMMENT 'Foreign key linking to talent.engagement. Business justification: When assignments staff external talent (freelancers, contractors), linking to engagement enables contract compliance tracking, rate validation against agreed terms, usage rights verification, and enga',
    `task_id` BIGINT COMMENT 'Reference to the specific task or work package within the project that this assignment addresses.',
    `reassigned_from_project_assignment_id` BIGINT COMMENT 'Self-referencing FK on project_assignment (reassigned_from_project_assignment_id)',
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
    CONSTRAINT pk_project_assignment PRIMARY KEY(`project_assignment_id`)
) COMMENT 'Operational record linking a specific worker or team member to a task or work package within a project. Captures assignee worker reference, task or work package reference, assignment role (lead, contributor, reviewer, approver), planned hours, actual hours logged, assignment start date, assignment end date, allocation percentage, billable flag, billing rate applied, assignment status (active, completed, reassigned), and reassignment reason. Bridges project execution with talent workforce data and enables utilization tracking at the task level.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`dependency` (
    `dependency_id` BIGINT COMMENT 'Unique identifier for the project dependency record.',
    `initiative_id` BIGINT COMMENT 'Reference to the project containing this dependency relationship.',
    `successor_entity_task_id` BIGINT COMMENT 'Reference to the specific task or milestone that depends on the predecessor. The entity type is determined by successor_entity_type.',
    `task_id` BIGINT COMMENT 'Reference to the specific task or milestone that must complete before the successor can begin. The entity type is determined by predecessor_entity_type.',
    `linked_dependency_id` BIGINT COMMENT 'Self-referencing FK on dependency (linked_dependency_id)',
    `constraint_type` STRING COMMENT 'Rigidity level of the dependency constraint. Hard: must be enforced, cannot be violated. Soft: should be enforced but can be overridden with approval. Preferred: advisory only, used for optimization.. Valid values are `hard|soft|preferred`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the dependency record was first created in the system.',
    `dependency_category` STRING COMMENT 'Classification of the dependency nature. Mandatory: legally or contractually required. Discretionary: based on best practices or preferences. External: involves third parties or external entities. Internal: within the organizations control.. Valid values are `mandatory|discretionary|external|internal`',
    `dependency_status` STRING COMMENT 'Current state of the dependency relationship. Active: dependency is enforced. Waived: dependency temporarily ignored by project manager approval. Violated: successor started before predecessor completed. Suspended: dependency enforcement paused. Resolved: dependency satisfied and closed.. Valid values are `active|waived|violated|suspended|resolved`',
    `dependency_type` STRING COMMENT 'Logical relationship type between predecessor and successor. Finish-to-start (FS): successor cannot start until predecessor finishes. Start-to-start (SS): successor cannot start until predecessor starts. Finish-to-finish (FF): successor cannot finish until predecessor finishes. Start-to-finish (SF): successor cannot finish until predecessor starts.. Valid values are `finish_to_start|start_to_start|finish_to_finish|start_to_finish`',
    `float_days` DECIMAL(18,2) COMMENT 'Total float or slack time available in this dependency relationship. Number of days the successor can be delayed without impacting the project completion date.',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether this dependency is part of the project critical path. True when any delay in this dependency directly impacts the project completion date.',
    `is_cross_project` BOOLEAN COMMENT 'Indicates whether this dependency spans across multiple projects. True when predecessor and successor belong to different projects, enabling portfolio-level critical path analysis.',
    `lag_days` DECIMAL(18,2) COMMENT 'Number of working days to delay the successor after the predecessor relationship is satisfied. Positive values create a waiting period between activities.',
    `lead_days` DECIMAL(18,2) COMMENT 'Number of working days the successor can start before the predecessor relationship is satisfied. Allows overlapping or fast-tracking of activities.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified the dependency record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the dependency record was last updated.',
    `notes` STRING COMMENT 'Additional context, constraints, or special instructions related to this dependency relationship. Free-text field for project team collaboration.',
    `predecessor_entity_type` STRING COMMENT 'Type of the predecessor entity in the dependency relationship. Indicates whether the predecessor is a task or milestone.. Valid values are `task|milestone`',
    `risk_impact_level` STRING COMMENT 'Assessment of schedule risk if this dependency is violated or delayed. Critical: project completion at risk. High: major milestone impact. Medium: moderate schedule impact. Low: minor impact. Negligible: no material impact.. Valid values are `critical|high|medium|low|negligible`',
    `source_system` STRING COMMENT 'Name of the operational system from which this dependency record originated. Typically Workfront, Monday.com, or other project management platform.',
    `source_system_code` STRING COMMENT 'Unique identifier of this dependency record in the source operational system. Enables traceability and reconciliation with upstream systems.',
    `successor_entity_type` STRING COMMENT 'Type of the successor entity in the dependency relationship. Indicates whether the successor is a task or milestone.. Valid values are `task|milestone`',
    `violation_date` DATE COMMENT 'Date when the dependency was violated, if applicable. Recorded when successor activity started or finished before the predecessor relationship was satisfied.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the project manager or authority who approved the dependency waiver.',
    `waiver_approved_date` DATE COMMENT 'Date when the dependency waiver was formally approved.',
    `waiver_reason` STRING COMMENT 'Business justification for waiving or suspending the dependency. Captures the rationale when project manager overrides the dependency constraint.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the dependency record. Typically the project manager or project coordinator.',
    CONSTRAINT pk_dependency PRIMARY KEY(`dependency_id`)
) COMMENT 'Defines scheduling dependencies between tasks or milestones within and across projects. Captures predecessor entity type (task or milestone), predecessor entity reference, successor entity type, successor entity reference, dependency type (finish-to-start, start-to-start, finish-to-finish, start-to-finish), lag days, lead days, is_cross_project flag, and dependency status (active, waived, violated). Enables critical path analysis and schedule risk identification across the project portfolio.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`schedule_baseline` (
    `schedule_baseline_id` BIGINT COMMENT 'Unique identifier for the schedule baseline record. Primary key.',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project for which this schedule baseline was created.',
    `prior_schedule_baseline_id` BIGINT COMMENT 'Self-referencing FK on schedule_baseline (prior_schedule_baseline_id)',
    `approval_date` DATE COMMENT 'Date on which this baseline was formally approved and locked for use as the measurement reference.',
    `approver_name` STRING COMMENT 'Name of the individual (project sponsor, client stakeholder, or program manager) who approved this baseline.',
    `approver_role` STRING COMMENT 'Role or title of the approver (e.g., Project Sponsor, Client Director, Program Manager).',
    `baseline_description` STRING COMMENT 'Detailed description of the baseline scope, assumptions, and context at the time of approval.',
    `baseline_name` STRING COMMENT 'Human-readable name or label for this baseline (e.g., Q1 2024 Client Approved Baseline, Post-Scope-Change Baseline).',
    `baseline_notes` STRING COMMENT 'Additional notes, comments, or context provided by the project manager or approver at the time of baseline creation.',
    `baseline_snapshot_timestamp` TIMESTAMP COMMENT 'Exact timestamp when this baseline snapshot was captured from the project management system (Workfront, Monday.com).',
    `baseline_status` STRING COMMENT 'Current lifecycle status of the baseline (draft during creation, pending-approval awaiting sign-off, approved and locked, active as current baseline, superseded by newer version, or archived for historical reference).. Valid values are `draft|pending-approval|approved|active|superseded|archived`',
    `baseline_type` STRING COMMENT 'Classification of the baseline indicating its purpose or trigger (original baseline at project start, re-baseline after scope change, client-approved milestone baseline, internal planning baseline, interim checkpoint, or final approved baseline).. Valid values are `original|re-baseline|client-approved|internal|interim|final`',
    `baseline_version_number` STRING COMMENT 'Sequential version number of this baseline. Increments with each re-baseline event (e.g., 1 for original, 2 for first re-baseline).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this baseline record was first created in the project management system.',
    `critical_path_duration_days` STRING COMMENT 'Duration in days of the critical path as identified in this baseline schedule.',
    `is_current_baseline` BOOLEAN COMMENT 'Boolean flag indicating whether this is the currently active baseline against which project performance is being measured (True) or a historical/superseded baseline (False).',
    `milestone_count` STRING COMMENT 'Total number of milestones included in this baseline schedule.',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified this baseline record (e.g., status change, notes update).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this baseline record was last modified in the project management system.',
    `planned_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total planned cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `planned_end_date` DATE COMMENT 'Baseline planned end date for the project or phase captured in this baseline.',
    `planned_start_date` DATE COMMENT 'Baseline planned start date for the project or phase captured in this baseline.',
    `re_baseline_reason` STRING COMMENT 'Explanation or justification for creating a new baseline (e.g., Scope change approved by client, Resource reallocation, Major milestone shift). Null for original baseline.',
    `re_baseline_trigger_event` STRING COMMENT 'Specific event or change request that triggered the re-baseline (e.g., change request number, client directive reference).',
    `source_system` STRING COMMENT 'System of record from which this baseline was extracted (e.g., Workfront, Monday.com, MS Project). [ENUM-REF-CANDIDATE: workfront|monday|ms-project|smartsheet|asana|jira|other — 7 candidates stripped; promote to reference product]',
    `source_system_baseline_code` STRING COMMENT 'Native baseline identifier or version key from the source project management system.',
    `task_count` STRING COMMENT 'Total number of tasks or work packages included in this baseline schedule.',
    `total_float_days` STRING COMMENT 'Total float or slack available in the baseline schedule (difference between latest and earliest finish dates).',
    `total_planned_cost` DECIMAL(18,2) COMMENT 'Total planned cost (Budget at Completion - BAC) for the project as captured in this baseline. Used for cost variance and Earned Value Management (EVM) calculations.',
    `total_planned_duration_days` STRING COMMENT 'Total planned duration of the project in calendar days as captured in this baseline.',
    `total_planned_effort_hours` DECIMAL(18,2) COMMENT 'Total planned effort in hours across all tasks and resources as captured in this baseline. Used for Earned Value Management (EVM) calculations.',
    `created_by` STRING COMMENT 'Name or identifier of the user who created this baseline record in the project management system.',
    CONSTRAINT pk_schedule_baseline PRIMARY KEY(`schedule_baseline_id`)
) COMMENT 'Immutable snapshot of the approved project schedule at a specific point in time — capturing the baseline against which actual progress is measured. Stores baseline version number, baseline name, baseline type (original, re-baseline, client-approved), approval date, approver, total planned duration, planned start date, planned end date, total planned effort hours, total planned cost, and the reason for re-baselining if applicable. Enables earned value management (EVM) and schedule variance (SV) calculations across the project lifecycle.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`change_request` (
    `change_request_id` BIGINT COMMENT 'Unique identifier for the change request. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Scope changes may require contract amendments. Agencies track which master agreement governs change approval authority, amendment thresholds, and client sign-off requirements per contractual change co',
    `client_contact_id` BIGINT COMMENT 'Identifier of the individual authorized to approve or reject the change request.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Scope changes often driven by brand strategy shifts, repositioning, or crisis events. Change impact assessment requires brand context for compliance and stakeholder communication.',
    `campaign_id` BIGINT COMMENT 'Identifier of the campaign associated with this change request, if applicable.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Change requests impact project budgets and require linkage for budget amendment tracking, approval workflows, and financial impact analysis. Critical for scope change management and budget variance co',
    `initiative_id` BIGINT COMMENT 'Identifier of the project to which this change request applies.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Scope changes to media plans require formal change control. Links change impact assessment to media budget/flight adjustments, enabling SOW amendment tracking, client approval workflows, and financial',
    `primary_change_client_contact_id` BIGINT COMMENT 'Identifier of the individual contact who submitted the change request.',
    `sow_id` BIGINT COMMENT 'Identifier of the Statement of Work (SOW) that may require amendment due to this change request.',
    `superseded_change_request_id` BIGINT COMMENT 'Self-referencing FK on change_request (superseded_change_request_id)',
    `approval_date` DATE COMMENT 'Date on which the change request was formally approved or rejected.',
    `approval_notes` STRING COMMENT 'Comments or rationale provided by the approver regarding the approval or rejection decision.',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise date and time when the change request was approved or rejected, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `approver_name` STRING COMMENT 'Full name of the individual who approved or rejected the change request.',
    `billing_impact_flag` BOOLEAN COMMENT 'Indicates whether this change request has an impact on client billing (True) or not (False).',
    `change_request_description` STRING COMMENT 'Detailed narrative describing the requested change, including rationale, context, and business justification.',
    `change_request_status` STRING COMMENT 'Current lifecycle status of the change request: submitted, under review, approved, rejected, deferred, or implemented.. Valid values are `submitted|under_review|approved|rejected|deferred|implemented`',
    `change_type` STRING COMMENT 'Classification of the change request by the dimension being modified: scope addition, scope reduction, timeline extension, budget increase, resource change, or deliverable modification.. Valid values are `scope_addition|scope_reduction|timeline_extension|budget_increase|resource_change|deliverable_modification`',
    `client_approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal client approval is required for this change request (True) or if internal approval is sufficient (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this change request record was first created in the system, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `deferral_reason` STRING COMMENT 'Explanation for why the change request was deferred to a later date or phase, if applicable.',
    `impact_assessment_notes` STRING COMMENT 'Detailed narrative describing the assessed impact of the change request on scope, schedule, budget, quality, and resources.',
    `impact_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the impact cost delta.. Valid values are `^[A-Z]{3}$`',
    `impact_cost_delta` DECIMAL(18,2) COMMENT 'Estimated financial impact of the change request, expressed as a positive or negative delta from the original budget.',
    `impact_effort_hours_delta` DECIMAL(18,2) COMMENT 'Estimated change in effort hours required to implement this change request, expressed as a positive or negative delta from the original project plan.',
    `impact_timeline_delta_days` STRING COMMENT 'Estimated change in project timeline measured in days, expressed as a positive or negative delta from the original schedule.',
    `implementation_date` DATE COMMENT 'Date on which the approved change request was implemented into the project plan.',
    `priority` STRING COMMENT 'Business priority level assigned to the change request: critical, high, medium, or low.. Valid values are `critical|high|medium|low`',
    `rejection_reason` STRING COMMENT 'Detailed explanation for why the change request was rejected, if applicable.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the change request, typically formatted as CR-NNNNNN.. Valid values are `^CR-[0-9]{6,10}$`',
    `requestor_email` STRING COMMENT 'Email address of the individual who submitted the change request.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_name` STRING COMMENT 'Full name of the individual who submitted the change request.',
    `requestor_type` STRING COMMENT 'Classification of the party initiating the change request: client, internal agency team, vendor, or partner.. Valid values are `client|internal|vendor|partner`',
    `review_completion_date` DATE COMMENT 'Date on which the review of the change request was completed.',
    `review_start_date` DATE COMMENT 'Date on which the formal review of the change request began.',
    `scope_creep_flag` BOOLEAN COMMENT 'Indicates whether this change request represents scope creep (True) or a legitimate change within project governance (False).',
    `sow_amendment_reference` STRING COMMENT 'Reference number or identifier of the SOW amendment document generated as a result of this approved change request.',
    `submission_date` DATE COMMENT 'Date on which the change request was formally submitted.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the change request was submitted, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `title` STRING COMMENT 'Short descriptive title summarizing the nature of the change request.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this change request record was last modified in the system, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_change_request PRIMARY KEY(`change_request_id`)
) COMMENT 'Formal record of a requested change to project scope, timeline, budget, or deliverables — the agencys project change control mechanism. Captures change request number, title, description, change type (scope addition, scope reduction, timeline extension, budget increase, resource change), requestor (client or internal), submission date, impact assessment (effort hours delta, cost delta, timeline delta), priority, approval status (submitted, under review, approved, rejected, deferred), approver, approval date, and linked SOW amendment reference. Critical for managing scope creep and client billing adjustments.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`project_brief` (
    `project_brief_id` BIGINT COMMENT 'Unique identifier for the project brief record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client advertiser for whom this project is being executed.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Project briefs specify primary target audience segments for campaign planning and creative development. Agencies link briefs to segments to ensure creative deliverables align with audience strategy an',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Briefs specify which brand the project serves, driving creative direction, compliance requirements, and success criteria. Essential for brief intake and scope definition in advertising operations.',
    `campaign_id` BIGINT COMMENT 'Reference to the associated campaign that this project brief supports.',
    `client_brief_id` BIGINT COMMENT 'Reference to the originating client brief that this project brief translates into an actionable plan.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: project_brief translates client briefs into actionable agency projects but currently has no direct link to the initiative product that represents the project execution. Adding initiative_id creates th',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Project briefs operationalize SOW commitments. Agencies must track which SOW funds each brief to validate scope, budget authority, and deliverable alignment during project kickoff and execution.',
    `persona_id` BIGINT COMMENT 'Foreign key linking to audience.persona. Business justification: Project briefs reference target personas to guide strategic planning and creative direction. Agencies link briefs to personas to ensure all project deliverables (creative, media, messaging) align with',
    `superseded_project_brief_id` BIGINT COMMENT 'Self-referencing FK on project_brief (superseded_project_brief_id)',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`status_update` (
    `status_update_id` BIGINT COMMENT 'Unique identifier for the project status update record. Primary key.',
    `initiative_id` BIGINT COMMENT 'Reference to the project this status update pertains to. Links to the project master record in Workfront or Monday.com.',
    `worker_id` BIGINT COMMENT 'Reference to the employee or user who authored and submitted this status update. Links to the employee or user master record in Workday HCM or identity management system.',
    `project_milestone_id` BIGINT COMMENT 'FK to project.project_milestone',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Status reports are delivered per SOW reporting obligations. Agencies track SOW-level status to fulfill contractual reporting requirements, communicate progress against SOW milestones, and manage clien',
    `previous_status_update_id` BIGINT COMMENT 'Self-referencing FK on status_update (previous_status_update_id)',
    `accomplishments` STRING COMMENT 'Narrative description of key accomplishments, milestones achieved, and deliverables completed during the reporting period.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this status update was approved for distribution. Nullable if approval is not required or not yet granted.',
    `author_name` STRING COMMENT 'Full name of the person who authored this status update. Typically the project manager or account lead.',
    `budget_burn_to_date` DECIMAL(18,2) COMMENT 'Cumulative budget spent or committed to date as of the end of this reporting period. Represents actual cost incurred against the total project budget.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget burn amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `budget_status` STRING COMMENT 'Status of the project budget and financial performance. Indicates whether the project is on budget, under budget, over budget, at risk of overrun, or in critical overrun.. Valid values are `on_budget|under_budget|over_budget|at_risk|critical`',
    `client_facing_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this status update is intended for external client distribution (True) or internal use only (False).',
    `comments` STRING COMMENT 'Additional comments, notes, or context provided by the author or reviewers. Free-form text field for supplementary information.',
    `decisions_required` STRING COMMENT 'Narrative description of pending decisions, approvals, or actions required from stakeholders or leadership to unblock progress or resolve issues.',
    `distribution_list` STRING COMMENT 'Comma-separated or semicolon-separated list of email addresses or user identifiers to whom this status update was distributed. Supports client-facing and internal stakeholder communication.',
    `executive_summary` STRING COMMENT 'High-level executive summary of the project status, suitable for senior leadership and client executives. Concise overview of health, progress, and key issues.',
    `issues_and_blockers` STRING COMMENT 'Narrative description of current issues, blockers, impediments, and challenges affecting project progress. Includes problem statements and impact assessment.',
    `next_milestone_date` DATE COMMENT 'Scheduled date for the next major milestone or deliverable.',
    `overall_status` STRING COMMENT 'Overall health status of the project using RAG (Red/Amber/Green) or equivalent traffic-light indicator. Red indicates critical issues, Amber indicates caution or risk, Green indicates on track.. Valid values are `red|amber|green|on_track|at_risk|off_track`',
    `percentage_complete` DECIMAL(18,2) COMMENT 'Overall project completion percentage as of the end of this reporting period. Expressed as a decimal value between 0.00 and 100.00.',
    `planned_activities` STRING COMMENT 'Narrative description of planned activities, tasks, and milestones scheduled for the next reporting period.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the data platform. Audit field for data lineage and governance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last updated in the data platform. Audit field for data lineage and governance.',
    `report_type` STRING COMMENT 'Type or cadence of the status report: weekly, monthly, quarterly, ad hoc, or milestone-based.. Valid values are `weekly|monthly|quarterly|ad_hoc|milestone`',
    `reporting_period_end_date` DATE COMMENT 'The end date of the reporting period covered by this status update (e.g., weekly or monthly cycle end).',
    `reporting_period_start_date` DATE COMMENT 'The start date of the reporting period covered by this status update (e.g., weekly or monthly cycle start).',
    `resource_status` STRING COMMENT 'Status of resource availability and allocation for the project. Indicates whether resources are adequate, constrained, critically short, over-allocated, or under-allocated.. Valid values are `adequate|constrained|critical|over_allocated|under_allocated`',
    `risk_status` STRING COMMENT 'Overall risk level for the project during this reporting period. Indicates the severity of identified risks: low, medium, high, critical, or none.. Valid values are `low|medium|high|critical|none`',
    `schedule_status` STRING COMMENT 'Status of the project schedule and timeline adherence. Indicates whether the project is on schedule, ahead, behind, at risk of delay, or in critical delay.. Valid values are `on_schedule|ahead|behind|at_risk|critical`',
    `source_system` STRING COMMENT 'The system of record from which this status update was captured or generated (e.g., Workfront, Monday.com, Jira, Asana, Smartsheet, or manual entry).. Valid values are `workfront|monday|jira|asana|smartsheet|manual`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when this status update was submitted or published. Represents the business event timestamp for the status report creation.',
    CONSTRAINT pk_status_update PRIMARY KEY(`status_update_id`)
) COMMENT 'Periodic project status report record capturing the health and progress of a project at a point in time. Stores reporting period, overall RAG status (Red/Amber/Green), schedule status, budget status, resource status, risk status, accomplishments in the period, planned activities for next period, issues and blockers, decisions required, budget burn to date, percentage complete, author, and distribution list. Supports client-facing weekly/monthly status reporting and internal portfolio review cadences.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`risk_register` (
    `risk_register_id` BIGINT COMMENT 'Unique identifier for the risk or issue record in the project risk register.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Brand-specific risks (reputation damage, compliance violations, crisis escalation) require brand context for assessment and mitigation. Risk management process in advertising depends on brand linkage.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign affected by this risk or issue, supporting cross-functional impact assessment and campaign performance analysis.',
    `initiative_id` BIGINT COMMENT 'Reference to the project or campaign engagement to which this risk or issue belongs.',
    `worker_id` BIGINT COMMENT 'Reference to the individual accountable for monitoring the risk or issue and executing the mitigation strategy, typically a project manager, account lead, or functional manager.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Risks are managed at SOW level. Agencies track SOW-specific risks for client reporting, mitigation planning, and assessing impact on contractual deliverables, timelines, and budget commitments.',
    `work_package_id` BIGINT COMMENT 'Reference to the specific work package or deliverable most directly affected by this risk or issue, enabling granular impact analysis and resource reallocation.',
    `escalated_from_risk_register_id` BIGINT COMMENT 'Self-referencing FK on risk_register (escalated_from_risk_register_id)',
    `actual_resolution_date` DATE COMMENT 'Date when the risk was successfully mitigated or closed, or the issue was resolved, enabling measurement of resolution cycle time and effectiveness.',
    `client_communicated_date` DATE COMMENT 'Date when the risk or issue was formally communicated to the client, tracking transparency and compliance with contractual reporting obligations.',
    `client_visibility_flag` BOOLEAN COMMENT 'Indicates whether this risk or issue has been communicated to the client or should be included in client-facing status reports, supporting transparency and relationship management.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk or issue was formally closed, supporting cycle time analysis and resolution effectiveness measurement.',
    `contingency_plan` STRING COMMENT 'Fallback plan or alternative course of action to be executed if the risk materializes or the mitigation strategy proves insufficient.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk or issue record was first created in the data platform, supporting audit trail and data lineage requirements.',
    `escalation_date` DATE COMMENT 'Date when the risk or issue was escalated to a higher authority or stakeholder group, tracking the timeline of escalation actions.',
    `escalation_level` STRING COMMENT 'Indicates the organizational level to which the risk or issue has been escalated for decision-making or additional resources, supporting governance and accountability.. Valid values are `none|project_manager|account_director|executive|client`',
    `estimated_cost_impact` DECIMAL(18,2) COMMENT 'Projected financial impact on project budget if the risk materializes or the issue is not resolved, expressed in the project currency, supporting budget contingency planning.',
    `estimated_schedule_impact_days` STRING COMMENT 'Projected delay in project timeline measured in days if the risk materializes or the issue is not resolved, supporting schedule contingency and client expectation management.',
    `identified_date` DATE COMMENT 'Date when the risk or issue was first identified and logged in the register, establishing the baseline for tracking age and response time.',
    `impact_rating` STRING COMMENT 'Qualitative assessment of the severity of consequences if the risk materializes or the issue is not resolved, considering effects on timeline, budget, quality, and client satisfaction.. Valid values are `very_low|low|medium|high|very_high`',
    `mitigation_strategy` STRING COMMENT 'Planned actions and approach to reduce the probability or impact of the risk, or to resolve the issue, including preventive measures and corrective actions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this risk or issue record, enabling change tracking and supporting incremental data processing patterns.',
    `notes` STRING COMMENT 'Free-text field for additional context, updates, lessons learned, or historical commentary on the risk or issue lifecycle, supporting knowledge management and retrospectives.',
    `probability_rating` STRING COMMENT 'Qualitative assessment of the likelihood that the risk will occur, used in conjunction with impact rating to calculate risk score and prioritize mitigation efforts.. Valid values are `very_low|low|medium|high|very_high`',
    `risk_issue_number` STRING COMMENT 'Business-facing identifier or tracking number for the risk or issue, often used in client communications and status reports.',
    `risk_register_category` STRING COMMENT 'Business domain or functional area affected by the risk or issue, enabling categorization for reporting and trend analysis across the agency portfolio. [ENUM-REF-CANDIDATE: resource|timeline|budget|client|technical|regulatory|creative|vendor|scope|quality — 10 candidates stripped; promote to reference product]',
    `risk_register_description` STRING COMMENT 'Detailed narrative describing the nature, context, and potential consequences of the risk or issue.',
    `risk_register_status` STRING COMMENT 'Current lifecycle state of the risk or issue, tracking progression from identification through resolution or escalation.. Valid values are `open|mitigated|closed|escalated|monitoring`',
    `risk_register_type` STRING COMMENT 'Classification indicating whether this entry is a potential risk (future threat or opportunity), an active issue (current problem), or an assumption underlying project planning.. Valid values are `risk|issue|assumption`',
    `risk_score` STRING COMMENT 'Quantitative risk priority score calculated from probability and impact ratings, used to rank and prioritize risks for management attention and resource allocation.',
    `source_system_name` STRING COMMENT 'Name of the operational system from which this risk or issue record was ingested, supporting data lineage and multi-system integration scenarios.',
    `source_system_risk_code` STRING COMMENT 'Original identifier from the upstream project management system of record such as Workfront or Monday.com, enabling traceability and reconciliation with operational tools.',
    `target_resolution_date` DATE COMMENT 'Planned or committed date by which the risk mitigation actions should be completed or the issue should be resolved, used for tracking adherence to resolution commitments.',
    `title` STRING COMMENT 'Short, descriptive title summarizing the risk or issue for quick identification in dashboards and reports.',
    CONSTRAINT pk_risk_register PRIMARY KEY(`risk_register_id`)
) COMMENT 'Project risk and issue register capturing identified risks, issues, and assumptions that may impact project delivery. Stores risk/issue title, description, category (resource, timeline, budget, client, technical, regulatory, creative), type (risk or issue), probability rating, impact rating, risk score, mitigation strategy, contingency plan, owner, status (open, mitigated, closed, escalated), target resolution date, and actual resolution date. Enables proactive project risk management and escalation workflows across the agency portfolio.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`deliverable_tracker` (
    `deliverable_tracker_id` BIGINT COMMENT 'Unique identifier for the deliverable tracking record. Primary key for operational tracking of project deliverables from brief through final delivery.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Deliverables are brand assets requiring validation against brand guidelines, tone, visual identity. Quality control and brand compliance processes depend on this link in advertising delivery.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this deliverable supports, if applicable. Links deliverable to the broader campaign execution.',
    `client_contact_id` BIGINT COMMENT 'Reference to the primary client contact who will receive and approve this deliverable.',
    `contract_deliverable_id` BIGINT COMMENT 'Reference to the contractual deliverable commitment in the Statement of Work (SOW) or Insertion Order (IO). Links operational tracking to contractual obligation.',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project under which this deliverable is being produced.',
    `org_unit_id` BIGINT COMMENT 'Reference to the team responsible for this deliverable (e.g., creative team, media planning team, analytics team).',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Media plans are contractual deliverables tracked through project delivery workflows. Required for client approval gates, billing triggers tied to plan delivery, and SOW compliance verification in agen',
    `tracking_pixel_id` BIGINT COMMENT 'Foreign key linking to performance.tracking_pixel. Business justification: Creative deliverables require tracking implementation for performance measurement. Real business process: creative QA and trafficking workflow where each deliverable (banner, video, landing page) must',
    `work_package_id` BIGINT COMMENT 'Reference to the work package or work breakdown structure element that this deliverable belongs to.',
    `worker_id` BIGINT COMMENT 'Reference to the worker or team member responsible for producing and delivering this deliverable.',
    `revision_of_deliverable_tracker_id` BIGINT COMMENT 'Self-referencing FK on deliverable_tracker (revision_of_deliverable_tracker_id)',
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
    `worker_id` BIGINT COMMENT 'Reference to the manager or project lead who approved or rejected this time entry. Null if not yet reviewed.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Time entries must post to cost centers for labor cost allocation, utilization reporting, and departmental P&L. Core requirement for agency financial systems integrating time tracking with GL posting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Time entries require GL account assignment for payroll expense posting and revenue recognition. Essential for labor cost capitalization, WIP accounting, and financial statement preparation in agency o',
    `initiative_id` BIGINT COMMENT 'Reference to the project against which this time was logged. Links to the project domain project entity.',
    `primary_time_worker_id` BIGINT COMMENT 'Reference to the agency staff member who logged this time entry. Links to the talent domain worker entity.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Time is billed against SOWs. Agencies track SOW-level time for client invoicing, utilization reporting, and validating labor charges against SOW rate cards and authorized budget caps.',
    `task_id` BIGINT COMMENT 'Reference to the specific task or deliverable against which time was logged. Links to the project.task entity.',
    `work_package_id` BIGINT COMMENT 'Reference to the work package within the project. Represents a logical grouping of tasks for billing or resource planning purposes.',
    `adjusted_time_entry_id` BIGINT COMMENT 'Self-referencing FK on time_entry (adjusted_time_entry_id)',
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
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Project budgets need GL account mapping for financial statement integration, accrual posting, and revenue/expense classification. Required for month-end close and financial reporting in agency ERP sys',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project for which this budget is defined. Links to the project master record.',
    `worker_id` BIGINT COMMENT 'Reference to the individual (typically project manager or account director) who owns and is accountable for this project budget. Links to the employee master record.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Project budgets allocate funds to specific media plans. Required for variance analysis between planned media spend and project budget, enabling financial forecasting, budget reallocation decisions, an',
    `primary_project_worker_id` BIGINT COMMENT 'Reference to the individual (employee or executive) who approved this budget version. Links to the employee or user master record.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Project budgets are allocated from SOW budgets. Finance tracks SOW-to-project budget mapping for billing reconciliation, variance analysis, and ensuring project spend does not exceed contractual autho',
    `revised_from_project_budget_id` BIGINT COMMENT 'Self-referencing FK on project_budget (revised_from_project_budget_id)',
    `approval_date` DATE COMMENT 'Date on which this budget version was formally approved by the authorized approver or governance body.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget version was formally approved. Captures the precise moment of approval for audit and compliance purposes.',
    `baseline_budget_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this budget version represents the original approved baseline for the project. True for the baseline version, False for revisions.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget: draft (in preparation), submitted (pending approval), approved (active), locked (no further changes), over-budget (exceeded threshold), or closed (project complete).. Valid values are `draft|submitted|approved|locked|over_budget|closed`',
    `budget_type` STRING COMMENT 'Classification of the budget record: original approved (baseline), revised (internal adjustment), client-approved (client sign-off), internal forecast (planning estimate), or contingency (reserve allocation).. Valid values are `original_approved|revised|client_approved|internal_forecast|contingency`',
    `client_approval_date` DATE COMMENT 'Date on which the client formally approved this budget version. Null if not yet client-approved.',
    `client_approved_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this budget version has been formally approved by the client. True if client-approved, False otherwise.',
    `contingency_reserve` DECIMAL(18,2) COMMENT 'Budget reserve allocated for identified risks and known-unknowns. Typically controlled by the project manager and released as needed for scope changes or risk mitigation.',
    `cost_center_code` STRING COMMENT 'Cost center code to which this project budget is allocated. Enables financial tracking and Profit and Loss (P&L) reporting by organizational unit.',
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
    `work_breakdown_structure_code` STRING COMMENT 'Work Breakdown Structure (WBS) element code associated with this budget. Enables hierarchical project decomposition and budget tracking at the work package level.',
    CONSTRAINT pk_project_budget PRIMARY KEY(`project_budget_id`)
) COMMENT 'Project-level budget record defining the approved financial envelope for a project, distinct from finance.budget (which operates at cost center and campaign level). Captures project reference, budget version, budget type (original approved, revised, client-approved), total approved budget, budget by phase or work package, contingency reserve, management reserve, currency, approval date, approver, budget status (draft, approved, locked, over-budget), total committed spend, total actual spend, and remaining budget. Enables project financial control and client billing reconciliation.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`approval_workflow` (
    `approval_workflow_id` BIGINT COMMENT 'Unique identifier for the approval workflow instance. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client or advertiser for whom this approval workflow is being executed, if applicable.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign associated with this approval workflow, if the artifact is campaign-specific.',
    `guideline_id` BIGINT COMMENT 'Foreign key linking to brand.brand_guideline. Business justification: Approval workflows validate creative/content against specific brand guideline versions. Real compliance process ensuring brand consistency and regulatory adherence in advertising production.',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project under which this approval workflow is executed.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Media plans require multi-stage approvals (strategy, legal, client). Tracks approval chain for audit compliance, regulatory documentation, and client sign-off workflows required for SOW execution auth',
    `worker_id` BIGINT COMMENT 'Reference to the specific individual or user assigned as approver for the current stage.',
    `project_template_id` BIGINT COMMENT 'Reference to the workflow template or approval process definition used for this instance.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: SOW-governed work requires approval workflows. Agencies enforce SOW-defined approval chains for deliverables, creative assets, and scope changes to ensure contractual compliance and client acceptance ',
    `resubmitted_approval_workflow_id` BIGINT COMMENT 'Self-referencing FK on approval_workflow (resubmitted_approval_workflow_id)',
    `approver_comments` STRING COMMENT 'Textual comments, feedback, or notes provided by the approver when rendering their decision.',
    `approver_role` STRING COMMENT 'Role or function of the approver for the current stage (e.g., Creative Director, Account Manager, Client Stakeholder, Legal Counsel, Finance Manager).',
    `artifact_name` STRING COMMENT 'Human-readable name or title of the artifact being approved.',
    `artifact_reference` STRING COMMENT 'Reference identifier or code of the specific artifact being approved (e.g., creative asset ID, brief document ID, change request number).',
    `artifact_type` STRING COMMENT 'Type of project artifact requiring approval: brief (project brief, campaign brief), deliverable (creative asset, media plan), change request (scope change, timeline change), budget (budget allocation, budget revision), plan (media plan, campaign plan), or proof (creative proof, design proof).. Valid values are `brief|deliverable|change_request|budget|plan|proof`',
    `assigned_approver_name` STRING COMMENT 'Full name of the individual assigned as approver for the current stage.',
    `client_facing_flag` BOOLEAN COMMENT 'Boolean indicator whether this approval workflow involves client stakeholders or is purely internal agency approval.',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the approval workflow was fully completed (all stages approved or workflow terminated).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this approval workflow record was first created in the data platform.',
    `current_stage` STRING COMMENT 'Name or identifier of the current approval stage in the workflow (e.g., Creative Review, Client Review, Legal Review, Final Approval).',
    `decision` STRING COMMENT 'Decision rendered by the approver for the current stage: approved (unconditional approval), rejected (approval denied), approved_with_comments (conditional approval with feedback), pending (decision not yet made).. Valid values are `approved|rejected|approved_with_comments|pending`',
    `decision_date` DATE COMMENT 'Date when the approval decision was made for the current stage.',
    `decision_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the approval decision was made for the current stage.',
    `due_date` DATE COMMENT 'Target date by which the approval decision is expected or required for the current stage.',
    `escalation_date` DATE COMMENT 'Date when the workflow was escalated to a higher authority or management level.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator whether this workflow has been escalated to a higher authority due to delays, conflicts, or special circumstances.',
    `escalation_reason` STRING COMMENT 'Reason or justification for escalating the approval workflow (e.g., missed deadline, approver unavailable, conflicting feedback).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this approval workflow record was last modified or updated in the data platform.',
    `notes` STRING COMMENT 'Additional free-text notes or context about the approval workflow instance, used for documentation and audit purposes.',
    `priority` STRING COMMENT 'Priority level assigned to this approval workflow instance, indicating urgency and business criticality.. Valid values are `low|medium|high|urgent`',
    `rejection_reason` STRING COMMENT 'Specific reason or rationale provided when an approval is rejected, used for audit and process improvement.',
    `source_system_name` STRING COMMENT 'Name of the operational system from which this approval workflow record originated (e.g., Workfront, Monday.com, Asana).',
    `source_system_workflow_code` STRING COMMENT 'Original workflow instance identifier from the source system of record (e.g., Workfront approval ID, Monday.com approval ID).',
    `stage_sequence` STRING COMMENT 'Numeric sequence position of the current stage within the overall workflow (e.g., 1 for first stage, 2 for second stage).',
    `submission_date` DATE COMMENT 'Date when the artifact was submitted for approval and the workflow instance was initiated.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the artifact was submitted for approval and the workflow instance was initiated.',
    `submitter_name` STRING COMMENT 'Full name of the individual who submitted the artifact for approval.',
    `total_stages` STRING COMMENT 'Total number of approval stages defined in this workflow instance.',
    `workflow_instance_reference` STRING COMMENT 'Business-readable reference number or code for this workflow instance, used for tracking and communication.',
    `workflow_status` STRING COMMENT 'Current overall status of the approval workflow instance: pending (not yet started), in_progress (awaiting approver action), approved (all stages approved), rejected (one or more stages rejected), cancelled (workflow terminated), escalated (sent to higher authority).. Valid values are `pending|in_progress|approved|rejected|cancelled|escalated`',
    CONSTRAINT pk_approval_workflow PRIMARY KEY(`approval_workflow_id`)
) COMMENT 'Tracks formal approval workflow instances for project artifacts — including creative proofs, media plans, project briefs, change requests, and deliverables requiring structured sign-off. Captures workflow instance reference, artifact type (brief, deliverable, change request, budget, plan), artifact reference, workflow template used, current stage, stage sequence, approver role, assigned approver, submission date, decision (approved, rejected, approved with comments), decision date, comments, and escalation flag. Enables audit trails for client and internal approval processes across the project lifecycle.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`sprint` (
    `sprint_id` BIGINT COMMENT 'Unique identifier for the sprint record. Primary key.',
    `initiative_id` BIGINT COMMENT 'Reference to the parent project under which this sprint is executed.',
    `worker_id` BIGINT COMMENT 'Reference to the product owner responsible for backlog prioritization and sprint goal definition.',
    `sprint_worker_id` BIGINT COMMENT 'Reference to the scrum master facilitating this sprint. Responsible for removing blockers and ensuring agile process adherence.',
    `previous_sprint_id` BIGINT COMMENT 'Self-referencing FK on sprint (previous_sprint_id)',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Total hours logged by the team during the sprint. Used for time tracking and resource utilization analysis.',
    `blockers_identified` STRING COMMENT 'List or description of impediments, blockers, or risks encountered during the sprint that hindered progress.',
    `carry_over_story_points` DECIMAL(18,2) COMMENT 'Story points from incomplete work carried forward to the next sprint. Indicates scope creep or planning accuracy issues.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the sprint was officially closed after retrospective and review ceremonies. Marks the end of the sprint lifecycle.',
    `completed_story_points` DECIMAL(18,2) COMMENT 'Total story points or effort units actually completed by sprint end. Used to calculate velocity and team performance.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of planned work completed by sprint end. Calculated as (completed_story_points / planned_story_points) * 100.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sprint record was first created in the system. Used for audit trail and data lineage.',
    `duration_days` STRING COMMENT 'The length of the sprint in calendar days. Typically 1-4 weeks (7-28 days) in agile practice.',
    `end_date` DATE COMMENT 'The date when the sprint is scheduled to conclude. Defines the time-box boundary for the iteration.',
    `goal` STRING COMMENT 'The primary objective or outcome the team commits to achieving during this sprint. Defines the sprints business purpose.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the sprint work is billable to the client. Used for revenue recognition and client invoicing.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sprint record was last updated. Used for change tracking and audit purposes.',
    `notes` STRING COMMENT 'General notes, comments, or additional context about the sprint. Used for documentation and knowledge sharing.',
    `planned_capacity_hours` DECIMAL(18,2) COMMENT 'Total available team hours for the sprint, accounting for vacations, meetings, and other commitments. Used for capacity planning.',
    `planned_story_points` DECIMAL(18,2) COMMENT 'Total story points or effort units committed at sprint planning. Represents the teams capacity forecast.',
    `retrospective_date` DATE COMMENT 'Date when the sprint retrospective ceremony was conducted for team reflection and process improvement.',
    `retrospective_notes` STRING COMMENT 'Summary of lessons learned, team feedback, and improvement actions identified during the sprint retrospective ceremony.',
    `review_date` DATE COMMENT 'Date when the sprint review ceremony was conducted to demonstrate completed work to stakeholders.',
    `source_system_name` STRING COMMENT 'Name of the operational system of record from which this sprint data originated (e.g., Workfront, Monday.com, Jira).. Valid values are `workfront|monday|jira|asana|other`',
    `source_system_sprint_code` STRING COMMENT 'Original sprint identifier from the source project management system (Workfront, Monday.com, Jira). Used for data lineage and reconciliation.',
    `sprint_name` STRING COMMENT 'Human-readable name or label for the sprint (e.g., Q1 Campaign Launch Sprint, Creative Development Sprint 3).',
    `sprint_number` STRING COMMENT 'Sequential number of the sprint within the project (e.g., Sprint 1, Sprint 2). Used for ordering and identification.',
    `sprint_status` STRING COMMENT 'Current lifecycle status of the sprint. Tracks progression through agile ceremonies and execution phases.. Valid values are `planning|active|review|retrospective|closed|cancelled`',
    `start_date` DATE COMMENT 'The date when the sprint officially begins. Marks the start of the time-boxed iteration.',
    `team_size` STRING COMMENT 'Number of team members assigned to this sprint. Used for capacity and velocity normalization.',
    `velocity` DECIMAL(18,2) COMMENT 'The rate of story points completed per sprint. Key metric for forecasting future sprint capacity and project timelines.',
    CONSTRAINT pk_sprint PRIMARY KEY(`sprint_id`)
) COMMENT 'Agile sprint or iteration record for projects managed using agile/scrum methodology — capturing the time-boxed execution cycle within a project. Stores sprint name, sprint number, sprint goal, project reference, start date, end date, planned story points or effort, completed story points or effort, velocity, sprint status (planning, active, review, retrospective, closed), sprint retrospective notes, and blockers identified. Supports agencies running agile delivery for digital, technology, and data-driven campaign projects.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`project_template` (
    `project_template_id` BIGINT COMMENT 'Unique identifier for the project template. Primary key.',
    `contract_template_id` BIGINT COMMENT 'External identifier linking this template to the corresponding project template in Workfront project management system, enabling synchronization and system integration.',
    `derived_from_project_template_id` BIGINT COMMENT 'Self-referencing FK on project_template (derived_from_project_template_id)',
    `approved_by` STRING COMMENT 'Username or identifier of the agency leadership or PMO (Project Management Office) member who approved this template for active use, ensuring quality and standardization.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this template was formally approved for use, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX), marking the transition to active status.',
    `budget_range_max` DECIMAL(18,2) COMMENT 'The maximum typical project budget in agency currency for which this template is appropriate, used to guide template selection based on client budget constraints.',
    `budget_range_min` DECIMAL(18,2) COMMENT 'The minimum typical project budget in agency currency for which this template is appropriate, used to guide template selection based on client budget constraints.',
    `complexity_level` STRING COMMENT 'Classification of the project complexity this template is designed for, indicating the scale, coordination requirements, and resource intensity (low, medium, high, enterprise).. Valid values are `low|medium|high|enterprise`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this template record was first created in the system, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget range values (e.g., USD, EUR, GBP) to ensure consistent financial planning across international operations.. Valid values are `^[A-Z]{3}$`',
    `default_duration_days` STRING COMMENT 'The standard number of calendar days from project kickoff to final delivery that this template is designed to accommodate, used for initial timeline estimation.',
    `deprecated_timestamp` TIMESTAMP COMMENT 'Date and time when this template was marked as deprecated and no longer recommended for new projects, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX), supporting template lifecycle management.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Total estimated labor hours across all roles and tasks defined in this template, used for resource capacity planning and budget estimation.',
    `modified_by` STRING COMMENT 'Username or identifier of the agency user who most recently modified this template, used for change tracking and template governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this template record was last modified in the system, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX), used for version control and audit trails.',
    `notes` STRING COMMENT 'Free-form text field for additional context, usage guidelines, lessons learned, or special considerations when applying this template to client engagements.',
    `project_template_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and intended use cases for this project template, including what types of client engagements it best serves.',
    `project_type` STRING COMMENT 'The category of project this template is designed for, such as TV production, digital campaign, brand strategy, media plan, PR activation, or social content series.. Valid values are `tv_production|digital_campaign|brand_strategy|media_plan|pr_activation|social_content_series`',
    `recommended_team_composition` STRING COMMENT 'Structured description of the recommended team roles and Full-Time Equivalent (FTE) allocations for this template (e.g., Account Director 0.2 FTE, Creative Director 0.3 FTE, Media Planner 0.5 FTE, Copywriter 0.4 FTE) to guide resource assignment.',
    `requires_client_approval` BOOLEAN COMMENT 'Boolean flag indicating whether projects created from this template require formal client sign-off at key milestones, affecting approval workflow configuration.',
    `requires_legal_review` BOOLEAN COMMENT 'Boolean flag indicating whether projects using this template require legal or compliance review (e.g., for regulatory advertising claims, data privacy, or contractual obligations), triggering appropriate review workflows.',
    `standard_milestones` STRING COMMENT 'Comma-separated or structured list of key milestone events and deliverables that are standard checkpoints in projects using this template (e.g., Creative Approval, Media Plan Sign-off, Campaign Launch, QBR).',
    `standard_phases` STRING COMMENT 'Comma-separated or structured list of the standard project phases included in this template (e.g., Discovery, Strategy, Creative Development, Production, Launch, Optimization) defining the high-level work breakdown structure (WBS).',
    `standard_task_list` STRING COMMENT 'Structured or delimited list of the standard tasks and activities that comprise this template, defining the detailed work breakdown and task sequences for typical project execution.',
    `success_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage of projects created from this template that were completed on time and within budget, used to assess template quality and refine best practices.',
    `target_client_segment` STRING COMMENT 'Description of the client segment or industry vertical this template is optimized for (e.g., CPG brands, automotive, financial services, retail, technology) to aid in template selection.',
    `template_code` STRING COMMENT 'Short alphanumeric code used as a business identifier for the template in project planning and resource management systems.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `template_name` STRING COMMENT 'The business name of the project template used for identification and selection by project managers and account teams.',
    `template_status` STRING COMMENT 'Current lifecycle status of the template indicating whether it is available for use (active), no longer recommended (deprecated), in development (draft), pending approval (under review), or retired (archived).. Valid values are `active|deprecated|draft|under_review|archived`',
    `usage_count` STRING COMMENT 'The number of times this template has been used to create actual projects, providing insight into template popularity and effectiveness for continuous improvement.',
    `version` STRING COMMENT 'Version number of the template following semantic versioning convention (e.g., v1.0, v2.1.3) to track template evolution and updates.. Valid values are `^v?d+.d+(.d+)?$`',
    `created_by` STRING COMMENT 'Username or identifier of the agency user who originally created this template, used for template governance and accountability.',
    CONSTRAINT pk_project_template PRIMARY KEY(`project_template_id`)
) COMMENT 'Reusable project plan template defining standard work breakdown structures, task sequences, milestone patterns, and resource role requirements for common project types at the agency. Captures template name, project type (TV production, digital campaign, brand strategy, media plan, PR activation, social content series), template version, default duration, standard phases, standard milestones, standard task list, recommended team composition by role, and template status (active, deprecated). Enables rapid project setup and consistency across similar engagements.';

CREATE OR REPLACE TABLE `advertising_ecm`.`project`.`workflow_step` (
    `workflow_step_id` BIGINT COMMENT 'Primary key for workflow_step',
    `predecessor_step_id` BIGINT COMMENT 'Reference to the workflow step that must be completed before this step can begin.',
    `approval_workflow_id` BIGINT COMMENT 'Reference to the parent workflow or process template that this step belongs to.',
    `previous_workflow_step_id` BIGINT COMMENT 'Self-referencing FK on workflow_step (previous_workflow_step_id)',
    `approval_role` STRING COMMENT 'The role or position responsible for approving this workflow step (e.g., Creative Director, Account Manager, Client).',
    `assigned_role` STRING COMMENT 'The default role or position assigned to execute this workflow step.',
    `automation_enabled` BOOLEAN COMMENT 'Indicates whether this workflow step can be executed automatically without manual intervention.',
    `automation_script` STRING COMMENT 'Reference to the automation script or integration endpoint used to execute this step automatically.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether time and resources spent on this workflow step are billable to the client.',
    `cost_center` STRING COMMENT 'Cost center or department code associated with this workflow step for financial tracking and allocation.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this workflow step definition.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this workflow step record was first created in the system.',
    `deliverable_type` STRING COMMENT 'Type of deliverable or output expected from this workflow step (e.g., Creative Asset, Media Plan, Client Presentation).',
    `dependency_type` STRING COMMENT 'Type of dependency relationship between this step and its predecessor step.',
    `workflow_step_description` STRING COMMENT 'Detailed description of the workflow step purpose, activities, and expected outcomes.',
    `effective_end_date` DATE COMMENT 'Date after which this workflow step definition is no longer active or available for use.',
    `effective_start_date` DATE COMMENT 'Date from which this workflow step definition becomes active and available for use.',
    `escalation_role` STRING COMMENT 'The role or position to which this workflow step should be escalated if threshold is exceeded.',
    `escalation_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours after which this step should be escalated if not completed.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Standard estimated time in hours required to complete this workflow step.',
    `external_system_code` STRING COMMENT 'Identifier for this workflow step in external project management systems such as Workfront or Monday.com.',
    `instructions` STRING COMMENT 'Detailed instructions or guidelines for executing this workflow step.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this workflow step is required and cannot be skipped in the workflow execution.',
    `is_parallel_eligible` BOOLEAN COMMENT 'Indicates whether this step can be executed in parallel with other steps in the workflow.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this workflow step definition.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this workflow step record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about this workflow step.',
    `notification_template` STRING COMMENT 'Reference to the notification or communication template triggered when this step is reached or completed.',
    `planned_effort_hours` DECIMAL(18,2) COMMENT 'Planned labor effort in hours allocated for this workflow step.',
    `quality_checklist` STRING COMMENT 'Reference to the quality assurance checklist or criteria that must be met for this step to be considered complete.',
    `requires_approval` BOOLEAN COMMENT 'Indicates whether this workflow step requires formal approval before proceeding to the next step.',
    `sequence_number` STRING COMMENT 'Numeric ordering of this step within the parent workflow, indicating execution order.',
    `sla_duration_hours` DECIMAL(18,2) COMMENT 'Maximum time in hours allowed for this step to be completed per service level agreement.',
    `workflow_step_status` STRING COMMENT 'Current lifecycle status of the workflow step indicating its availability for use.',
    `step_category` STRING COMMENT 'Business domain or functional area that this workflow step belongs to.',
    `step_code` STRING COMMENT 'Unique business code or identifier for the workflow step used across systems and reporting.',
    `step_name` STRING COMMENT 'Human-readable name of the workflow step (e.g., Creative Review, Client Approval, Media Placement).',
    `step_type` STRING COMMENT 'Classification of the workflow step indicating its functional purpose within the workflow.',
    `version_number` STRING COMMENT 'Version identifier for this workflow step definition, supporting version control and change management.',
    CONSTRAINT pk_workflow_step PRIMARY KEY(`workflow_step_id`)
) COMMENT 'Master reference table for workflow_step. Referenced by workflow_step_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`project`.`initiative` ADD CONSTRAINT `fk_project_initiative_parent_initiative_id` FOREIGN KEY (`parent_initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`work_package` ADD CONSTRAINT `fk_project_work_package_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`work_package` ADD CONSTRAINT `fk_project_work_package_parent_work_package_id` FOREIGN KEY (`parent_work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`task` ADD CONSTRAINT `fk_project_task_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`task` ADD CONSTRAINT `fk_project_task_predecessor_task_id` FOREIGN KEY (`predecessor_task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`project`.`task` ADD CONSTRAINT `fk_project_task_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`task` ADD CONSTRAINT `fk_project_task_parent_task_id` FOREIGN KEY (`parent_task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_replanned_from_project_milestone_id` FOREIGN KEY (`replanned_from_project_milestone_id`) REFERENCES `advertising_ecm`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ADD CONSTRAINT `fk_project_resource_plan_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ADD CONSTRAINT `fk_project_resource_plan_revised_from_resource_plan_id` FOREIGN KEY (`revised_from_resource_plan_id`) REFERENCES `advertising_ecm`.`project`.`resource_plan`(`resource_plan_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ADD CONSTRAINT `fk_project_project_assignment_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ADD CONSTRAINT `fk_project_project_assignment_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ADD CONSTRAINT `fk_project_project_assignment_reassigned_from_project_assignment_id` FOREIGN KEY (`reassigned_from_project_assignment_id`) REFERENCES `advertising_ecm`.`project`.`project_assignment`(`project_assignment_id`);
ALTER TABLE `advertising_ecm`.`project`.`dependency` ADD CONSTRAINT `fk_project_dependency_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`dependency` ADD CONSTRAINT `fk_project_dependency_successor_entity_task_id` FOREIGN KEY (`successor_entity_task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`project`.`dependency` ADD CONSTRAINT `fk_project_dependency_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`project`.`dependency` ADD CONSTRAINT `fk_project_dependency_linked_dependency_id` FOREIGN KEY (`linked_dependency_id`) REFERENCES `advertising_ecm`.`project`.`dependency`(`dependency_id`);
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ADD CONSTRAINT `fk_project_schedule_baseline_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ADD CONSTRAINT `fk_project_schedule_baseline_prior_schedule_baseline_id` FOREIGN KEY (`prior_schedule_baseline_id`) REFERENCES `advertising_ecm`.`project`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `advertising_ecm`.`project`.`change_request` ADD CONSTRAINT `fk_project_change_request_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`change_request` ADD CONSTRAINT `fk_project_change_request_superseded_change_request_id` FOREIGN KEY (`superseded_change_request_id`) REFERENCES `advertising_ecm`.`project`.`change_request`(`change_request_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ADD CONSTRAINT `fk_project_project_brief_superseded_project_brief_id` FOREIGN KEY (`superseded_project_brief_id`) REFERENCES `advertising_ecm`.`project`.`project_brief`(`project_brief_id`);
ALTER TABLE `advertising_ecm`.`project`.`status_update` ADD CONSTRAINT `fk_project_status_update_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`status_update` ADD CONSTRAINT `fk_project_status_update_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `advertising_ecm`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `advertising_ecm`.`project`.`status_update` ADD CONSTRAINT `fk_project_status_update_previous_status_update_id` FOREIGN KEY (`previous_status_update_id`) REFERENCES `advertising_ecm`.`project`.`status_update`(`status_update_id`);
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_escalated_from_risk_register_id` FOREIGN KEY (`escalated_from_risk_register_id`) REFERENCES `advertising_ecm`.`project`.`risk_register`(`risk_register_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ADD CONSTRAINT `fk_project_deliverable_tracker_revision_of_deliverable_tracker_id` FOREIGN KEY (`revision_of_deliverable_tracker_id`) REFERENCES `advertising_ecm`.`project`.`deliverable_tracker`(`deliverable_tracker_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_task_id` FOREIGN KEY (`task_id`) REFERENCES `advertising_ecm`.`project`.`task`(`task_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_work_package_id` FOREIGN KEY (`work_package_id`) REFERENCES `advertising_ecm`.`project`.`work_package`(`work_package_id`);
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ADD CONSTRAINT `fk_project_time_entry_adjusted_time_entry_id` FOREIGN KEY (`adjusted_time_entry_id`) REFERENCES `advertising_ecm`.`project`.`time_entry`(`time_entry_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_revised_from_project_budget_id` FOREIGN KEY (`revised_from_project_budget_id`) REFERENCES `advertising_ecm`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ADD CONSTRAINT `fk_project_approval_workflow_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ADD CONSTRAINT `fk_project_approval_workflow_project_template_id` FOREIGN KEY (`project_template_id`) REFERENCES `advertising_ecm`.`project`.`project_template`(`project_template_id`);
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ADD CONSTRAINT `fk_project_approval_workflow_resubmitted_approval_workflow_id` FOREIGN KEY (`resubmitted_approval_workflow_id`) REFERENCES `advertising_ecm`.`project`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `advertising_ecm`.`project`.`sprint` ADD CONSTRAINT `fk_project_sprint_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `advertising_ecm`.`project`.`initiative`(`initiative_id`);
ALTER TABLE `advertising_ecm`.`project`.`sprint` ADD CONSTRAINT `fk_project_sprint_previous_sprint_id` FOREIGN KEY (`previous_sprint_id`) REFERENCES `advertising_ecm`.`project`.`sprint`(`sprint_id`);
ALTER TABLE `advertising_ecm`.`project`.`project_template` ADD CONSTRAINT `fk_project_project_template_derived_from_project_template_id` FOREIGN KEY (`derived_from_project_template_id`) REFERENCES `advertising_ecm`.`project`.`project_template`(`project_template_id`);
ALTER TABLE `advertising_ecm`.`project`.`workflow_step` ADD CONSTRAINT `fk_project_workflow_step_predecessor_step_id` FOREIGN KEY (`predecessor_step_id`) REFERENCES `advertising_ecm`.`project`.`workflow_step`(`workflow_step_id`);
ALTER TABLE `advertising_ecm`.`project`.`workflow_step` ADD CONSTRAINT `fk_project_workflow_step_approval_workflow_id` FOREIGN KEY (`approval_workflow_id`) REFERENCES `advertising_ecm`.`project`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `advertising_ecm`.`project`.`workflow_step` ADD CONSTRAINT `fk_project_workflow_step_previous_workflow_step_id` FOREIGN KEY (`previous_workflow_step_id`) REFERENCES `advertising_ecm`.`project`.`workflow_step`(`workflow_step_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`project` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `advertising_ecm`.`project` SET TAGS ('dbx_domain' = 'project');
ALTER TABLE `advertising_ecm`.`project`.`initiative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`initiative` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative ID');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Account Director ID');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `attribution_model_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`initiative` ALTER COLUMN `parent_initiative_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `advertising_ecm`.`project`.`work_package` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `parent_work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Package Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`work_package` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Resource Identifier (ID)');
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
ALTER TABLE `advertising_ecm`.`project`.`task` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Worker Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `predecessor_task_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Task Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`task` ALTER COLUMN `parent_task_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approver Employee Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `primary_project_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Owner Employee Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `replanned_from_project_milestone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approved Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Milestone Completion Percentage');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `dependency_count` SET TAGS ('dbx_business_glossary_term' = 'Dependency Count');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `is_billing_trigger` SET TAGS ('dbx_business_glossary_term' = 'Is Billing Trigger Flag');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `is_contractual_gate` SET TAGS ('dbx_business_glossary_term' = 'Is Contractual Gate Flag');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path Flag');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `project_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `project_milestone_status` SET TAGS ('dbx_value_regex' = 'upcoming|in_progress|achieved|missed|deferred|cancelled');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Milestone Risk Level');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `sow_milestone_reference` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Milestone Reference');
ALTER TABLE `advertising_ecm`.`project`.`project_milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Milestone Variance in Days');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `resource_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Plan ID');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`resource_plan` ALTER COLUMN `revised_from_resource_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `project_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `talent_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `reassigned_from_project_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_value_regex' = 'lead|contributor|reviewer|approver|observer|consultant');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|completed|reassigned|on_hold|cancelled');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `billing_rate` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `billing_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `cost_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `reassigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reassigned Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `reassignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Reason');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `skill_required` SET TAGS ('dbx_business_glossary_term' = 'Skill Required');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `utilization_category` SET TAGS ('dbx_business_glossary_term' = 'Utilization Category');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `utilization_category` SET TAGS ('dbx_value_regex' = 'client_billable|internal_project|training|administrative|bench');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `advertising_ecm`.`project`.`project_assignment` ALTER COLUMN `work_location` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `advertising_ecm`.`project`.`dependency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`dependency` SET TAGS ('dbx_subdomain' = 'change_governance');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `dependency_id` SET TAGS ('dbx_business_glossary_term' = 'Dependency Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `successor_entity_task_id` SET TAGS ('dbx_business_glossary_term' = 'Successor Entity Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Entity Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `linked_dependency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'hard|soft|preferred');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `dependency_category` SET TAGS ('dbx_business_glossary_term' = 'Dependency Category');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `dependency_category` SET TAGS ('dbx_value_regex' = 'mandatory|discretionary|external|internal');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `dependency_status` SET TAGS ('dbx_business_glossary_term' = 'Dependency Status');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `dependency_status` SET TAGS ('dbx_value_regex' = 'active|waived|violated|suspended|resolved');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `dependency_type` SET TAGS ('dbx_business_glossary_term' = 'Dependency Type');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `dependency_type` SET TAGS ('dbx_value_regex' = 'finish_to_start|start_to_start|finish_to_finish|start_to_finish');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `float_days` SET TAGS ('dbx_business_glossary_term' = 'Float Days');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path Flag');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `is_cross_project` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Project Dependency Flag');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `lag_days` SET TAGS ('dbx_business_glossary_term' = 'Lag Days');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `lead_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Days');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dependency Notes');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `predecessor_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Entity Type');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `predecessor_entity_type` SET TAGS ('dbx_value_regex' = 'task|milestone');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `risk_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Impact Level');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `risk_impact_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `successor_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Successor Entity Type');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `successor_entity_type` SET TAGS ('dbx_value_regex' = 'task|milestone');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `violation_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Date');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved Date');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `advertising_ecm`.`project`.`dependency` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `prior_schedule_baseline_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Approval Date');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Baseline Approver Name');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Baseline Approver Role');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `baseline_description` SET TAGS ('dbx_business_glossary_term' = 'Baseline Description');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `baseline_name` SET TAGS ('dbx_business_glossary_term' = 'Baseline Name');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `baseline_notes` SET TAGS ('dbx_business_glossary_term' = 'Baseline Notes');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `baseline_snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Baseline Snapshot Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `baseline_status` SET TAGS ('dbx_business_glossary_term' = 'Baseline Status');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `baseline_status` SET TAGS ('dbx_value_regex' = 'draft|pending-approval|approved|active|superseded|archived');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `baseline_type` SET TAGS ('dbx_business_glossary_term' = 'Baseline Type');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `baseline_type` SET TAGS ('dbx_value_regex' = 'original|re-baseline|client-approved|internal|interim|final');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `baseline_version_number` SET TAGS ('dbx_business_glossary_term' = 'Baseline Version Number');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `critical_path_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Duration (Days)');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `is_current_baseline` SET TAGS ('dbx_business_glossary_term' = 'Is Current Baseline Flag');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Count');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `planned_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Currency Code');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `planned_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `re_baseline_reason` SET TAGS ('dbx_business_glossary_term' = 'Re-Baseline Reason');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `re_baseline_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Re-Baseline Trigger Event');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `source_system_baseline_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Baseline Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `task_count` SET TAGS ('dbx_business_glossary_term' = 'Task Count');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `total_float_days` SET TAGS ('dbx_business_glossary_term' = 'Total Float (Days)');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `total_planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Cost');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `total_planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Duration (Days)');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `total_planned_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Effort (Hours)');
ALTER TABLE `advertising_ecm`.`project`.`schedule_baseline` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`project`.`change_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`project`.`change_request` SET TAGS ('dbx_subdomain' = 'change_governance');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request ID');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Contact ID');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `primary_change_client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Contact ID');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) ID');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `superseded_change_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `billing_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Impact Flag');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `change_request_description` SET TAGS ('dbx_business_glossary_term' = 'Change Request Description');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `change_request_status` SET TAGS ('dbx_business_glossary_term' = 'Change Request Status');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `change_request_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|approved|rejected|deferred|implemented');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'scope_addition|scope_reduction|timeline_extension|budget_increase|resource_change|deliverable_modification');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `client_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Required Flag');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `deferral_reason` SET TAGS ('dbx_business_glossary_term' = 'Deferral Reason');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `impact_assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Notes');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `impact_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Impact Cost Currency');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `impact_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `impact_cost_delta` SET TAGS ('dbx_business_glossary_term' = 'Impact Cost Delta');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `impact_cost_delta` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `impact_effort_hours_delta` SET TAGS ('dbx_business_glossary_term' = 'Impact Effort Hours Delta');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `impact_timeline_delta_days` SET TAGS ('dbx_business_glossary_term' = 'Impact Timeline Delta Days');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Request Priority');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Change Request Number');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^CR-[0-9]{6,10}$');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `requestor_type` SET TAGS ('dbx_business_glossary_term' = 'Requestor Type');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `requestor_type` SET TAGS ('dbx_value_regex' = 'client|internal|vendor|partner');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `scope_creep_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope Creep Flag');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `sow_amendment_reference` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Amendment Reference');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Change Request Title');
ALTER TABLE `advertising_ecm`.`project`.`change_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `project_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Project Brief Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `client_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brief Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Target Persona Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_brief` ALTER COLUMN `superseded_project_brief_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `advertising_ecm`.`project`.`status_update` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`project`.`status_update` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `status_update_id` SET TAGS ('dbx_business_glossary_term' = 'Status Update Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Author Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `previous_status_update_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `accomplishments` SET TAGS ('dbx_business_glossary_term' = 'Accomplishments in Period');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `budget_burn_to_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Burn to Date');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'on_budget|under_budget|over_budget|at_risk|critical');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `client_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Facing Flag');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `decisions_required` SET TAGS ('dbx_business_glossary_term' = 'Decisions Required');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `executive_summary` SET TAGS ('dbx_business_glossary_term' = 'Executive Summary');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `issues_and_blockers` SET TAGS ('dbx_business_glossary_term' = 'Issues and Blockers');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `next_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Next Milestone Date');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `overall_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Red-Amber-Green (RAG) Status');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `overall_status` SET TAGS ('dbx_value_regex' = 'red|amber|green|on_track|at_risk|off_track');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `percentage_complete` SET TAGS ('dbx_business_glossary_term' = 'Percentage Complete');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `planned_activities` SET TAGS ('dbx_business_glossary_term' = 'Planned Activities for Next Period');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|ad_hoc|milestone');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `resource_status` SET TAGS ('dbx_business_glossary_term' = 'Resource Status');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `resource_status` SET TAGS ('dbx_value_regex' = 'adequate|constrained|critical|over_allocated|under_allocated');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical|none');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'on_schedule|ahead|behind|at_risk|critical');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'workfront|monday|jira|asana|smartsheet|manual');
ALTER TABLE `advertising_ecm`.`project`.`status_update` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` SET TAGS ('dbx_subdomain' = 'change_governance');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register ID');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Related Campaign ID');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Risk or Issue Owner ID');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Related Work Package ID');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `escalated_from_risk_register_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `client_communicated_date` SET TAGS ('dbx_business_glossary_term' = 'Client Communicated Date');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `client_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Visibility Flag');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `contingency_plan` SET TAGS ('dbx_business_glossary_term' = 'Contingency Plan');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|project_manager|account_director|executive|client');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `estimated_schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Schedule Impact Days');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `impact_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Risk or Issue Notes');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `probability_rating` SET TAGS ('dbx_business_glossary_term' = 'Probability Rating');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `probability_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `risk_issue_number` SET TAGS ('dbx_business_glossary_term' = 'Risk or Issue Number');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `risk_register_category` SET TAGS ('dbx_business_glossary_term' = 'Risk or Issue Category');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `risk_register_description` SET TAGS ('dbx_business_glossary_term' = 'Risk or Issue Description');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `risk_register_status` SET TAGS ('dbx_business_glossary_term' = 'Risk or Issue Status');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `risk_register_status` SET TAGS ('dbx_value_regex' = 'open|mitigated|closed|escalated|monitoring');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `risk_register_type` SET TAGS ('dbx_business_glossary_term' = 'Risk or Issue Type');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `risk_register_type` SET TAGS ('dbx_value_regex' = 'risk|issue|assumption');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `source_system_risk_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Risk ID');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `advertising_ecm`.`project`.`risk_register` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Risk or Issue Title');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `deliverable_tracker_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Tracker ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `contract_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Deliverable ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `tracking_pixel_id` SET TAGS ('dbx_business_glossary_term' = 'Tracking Pixel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner ID');
ALTER TABLE `advertising_ecm`.`project`.`deliverable_tracker` ALTER COLUMN `revision_of_deliverable_tracker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `advertising_ecm`.`project`.`time_entry` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `primary_time_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`time_entry` ALTER COLUMN `adjusted_time_entry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `advertising_ecm`.`project`.`project_budget` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `primary_project_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `revised_from_project_budget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
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
ALTER TABLE `advertising_ecm`.`project`.`project_budget` ALTER COLUMN `work_breakdown_structure_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` SET TAGS ('dbx_subdomain' = 'change_governance');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Guideline Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Approver Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `project_template_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Template Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `resubmitted_approval_workflow_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `approver_comments` SET TAGS ('dbx_business_glossary_term' = 'Approver Comments');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `artifact_name` SET TAGS ('dbx_business_glossary_term' = 'Artifact Name');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `artifact_reference` SET TAGS ('dbx_business_glossary_term' = 'Artifact Reference Identifier');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `artifact_type` SET TAGS ('dbx_business_glossary_term' = 'Artifact Type');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `artifact_type` SET TAGS ('dbx_value_regex' = 'brief|deliverable|change_request|budget|plan|proof');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `assigned_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Approver Name');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `assigned_approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `client_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Facing Flag');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Workflow Completed Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `current_stage` SET TAGS ('dbx_business_glossary_term' = 'Current Approval Stage');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|approved_with_comments|pending');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Due Date');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Workflow Notes');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Approval Priority');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `source_system_workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Workflow Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `stage_sequence` SET TAGS ('dbx_business_glossary_term' = 'Stage Sequence Number');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Workflow Submission Date');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Workflow Submission Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `submitter_name` SET TAGS ('dbx_business_glossary_term' = 'Submitter Name');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `submitter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `total_stages` SET TAGS ('dbx_business_glossary_term' = 'Total Workflow Stages');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `workflow_instance_reference` SET TAGS ('dbx_business_glossary_term' = 'Workflow Instance Reference Number');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `advertising_ecm`.`project`.`approval_workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|approved|rejected|cancelled|escalated');
ALTER TABLE `advertising_ecm`.`project`.`sprint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`sprint` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `sprint_id` SET TAGS ('dbx_business_glossary_term' = 'Sprint Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Product Owner Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `sprint_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Scrum Master Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `previous_sprint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort in Hours');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `blockers_identified` SET TAGS ('dbx_business_glossary_term' = 'Blockers Identified');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `carry_over_story_points` SET TAGS ('dbx_business_glossary_term' = 'Carry Over Story Points');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sprint Closed Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `completed_story_points` SET TAGS ('dbx_business_glossary_term' = 'Completed Story Points');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sprint Completion Percentage');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Sprint Duration in Days');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Sprint End Date');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `goal` SET TAGS ('dbx_business_glossary_term' = 'Sprint Goal');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sprint Notes');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `planned_capacity_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Capacity in Hours');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `planned_story_points` SET TAGS ('dbx_business_glossary_term' = 'Planned Story Points');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `retrospective_date` SET TAGS ('dbx_business_glossary_term' = 'Sprint Retrospective Date');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `retrospective_notes` SET TAGS ('dbx_business_glossary_term' = 'Sprint Retrospective Notes');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Sprint Review Date');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `source_system_name` SET TAGS ('dbx_value_regex' = 'workfront|monday|jira|asana|other');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `source_system_sprint_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Sprint Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `sprint_name` SET TAGS ('dbx_business_glossary_term' = 'Sprint Name');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `sprint_number` SET TAGS ('dbx_business_glossary_term' = 'Sprint Number');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `sprint_status` SET TAGS ('dbx_business_glossary_term' = 'Sprint Status');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `sprint_status` SET TAGS ('dbx_value_regex' = 'planning|active|review|retrospective|closed|cancelled');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Sprint Start Date');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Team Size');
ALTER TABLE `advertising_ecm`.`project`.`sprint` ALTER COLUMN `velocity` SET TAGS ('dbx_business_glossary_term' = 'Sprint Velocity');
ALTER TABLE `advertising_ecm`.`project`.`project_template` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`project`.`project_template` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `project_template_id` SET TAGS ('dbx_business_glossary_term' = 'Project Template Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Workfront Template Identifier (ID)');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `derived_from_project_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `budget_range_max` SET TAGS ('dbx_business_glossary_term' = 'Budget Range Maximum');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `budget_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `budget_range_min` SET TAGS ('dbx_business_glossary_term' = 'Budget Range Minimum');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `budget_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `complexity_level` SET TAGS ('dbx_business_glossary_term' = 'Complexity Level');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `complexity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|enterprise');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `default_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Default Duration in Days');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `deprecated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Template Notes');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `project_template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'tv_production|digital_campaign|brand_strategy|media_plan|pr_activation|social_content_series');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `recommended_team_composition` SET TAGS ('dbx_business_glossary_term' = 'Recommended Team Composition');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `requires_client_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Client Approval Flag');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `requires_legal_review` SET TAGS ('dbx_business_glossary_term' = 'Requires Legal Review Flag');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `standard_milestones` SET TAGS ('dbx_business_glossary_term' = 'Standard Milestones');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `standard_phases` SET TAGS ('dbx_business_glossary_term' = 'Standard Phases');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `standard_task_list` SET TAGS ('dbx_business_glossary_term' = 'Standard Task List');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `success_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Success Rate Percentage');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `target_client_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Client Segment');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|draft|under_review|archived');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Template Version');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^v?d+.d+(.d+)?$');
ALTER TABLE `advertising_ecm`.`project`.`project_template` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`project`.`workflow_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`project`.`workflow_step` SET TAGS ('dbx_subdomain' = 'change_governance');
ALTER TABLE `advertising_ecm`.`project`.`workflow_step` ALTER COLUMN `workflow_step_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Step Identifier');
ALTER TABLE `advertising_ecm`.`project`.`workflow_step` ALTER COLUMN `previous_workflow_step_id` SET TAGS ('dbx_self_ref_fk' = 'true');
