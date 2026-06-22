-- Schema for Domain: workforce | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-22 17:24:54

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`workforce` COMMENT 'Construction workforce management domain tracking labor resources, crew assignments, time tracking, production rates, skill certifications, labor cost coding, field personnel deployment, and site access records. Manages craft labor, supervision, and project-based staffing distinct from corporate HR functions. Integrates with HCSS HeavyJob for timesheets and SAP SuccessFactors for HCM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`craft_worker` (
    `craft_worker_id` BIGINT COMMENT 'Unique identifier for the craft worker record. Primary key for the craft worker entity.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the primary construction project to which the craft worker is currently assigned as their home base.',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: craft_worker.craft_code is a STRING storing the trade/skill classification code. labor_cost_code is the authoritative master for labor cost codes and trade/skill classifications in the workforce domai',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: REQUIRED: Workers are employed by a contract party (contractor/sub‑contractor); linking supports payroll, insurance, and compliance reporting.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: REQUIRED: Vendor‑Supplied Labor Tracking – each subcontractor worker must be linked to the vendor that supplies them for compliance and cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the craft worker record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the workers compensation (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `demobilization_date` DATE COMMENT 'Date the craft worker was demobilized from their project assignment, if applicable.',
    `email_address` STRING COMMENT 'Primary email address for the craft worker used for communication and system access.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the craft workers designated emergency contact person.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the craft workers designated emergency contact person.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the craft worker (e.g., spouse, parent, sibling, friend).',
    `employment_type` STRING COMMENT 'Classification of the workers employment relationship with the organization: direct hire (permanent employee), agency (temporary staffing), union referral (union hall dispatch), or subcontractor (independent contractor).. Valid values are `direct_hire|agency|union_referral|subcontractor`',
    `first_name` STRING COMMENT 'Legal first name of the craft worker as recorded in HR systems.',
    `hire_date` DATE COMMENT 'Date the craft worker was hired or first engaged by the organization.',
    `hourly_base_rate` DECIMAL(18,2) COMMENT 'Standard hourly wage rate for the craft worker in their primary trade classification, excluding overtime premiums and benefits.',
    `last_name` STRING COMMENT 'Legal last name of the craft worker as recorded in HR systems.',
    `middle_name` STRING COMMENT 'Middle name or initial of the craft worker, if applicable.',
    `mobilization_date` DATE COMMENT 'Date the craft worker was mobilized to their current project assignment.',
    `mobilization_status` STRING COMMENT 'Current deployment status of the craft worker: mobilized (actively deployed to a project site), demobilized (released from project), on_leave (temporarily unavailable), or available (ready for assignment).. Valid values are `mobilized|demobilized|on_leave|available`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the craft worker record was last modified in the system.',
    `osha_certification_expiry_date` DATE COMMENT 'Expiration date of the craft workers OSHA safety certification, if applicable.',
    `osha_certification_flag` BOOLEAN COMMENT 'Indicates whether the craft worker holds valid OSHA safety training certification (e.g., OSHA 10-hour or 30-hour).',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base hourly rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time).',
    `phone_number` STRING COMMENT 'Primary contact phone number for the craft worker for emergency contact and field coordination.',
    `ppe_size_boots` STRING COMMENT 'Boot size for issuing Personal Protective Equipment (PPE) such as steel-toed safety boots.',
    `ppe_size_pants` STRING COMMENT 'Pants size for issuing Personal Protective Equipment (PPE) such as work pants and coveralls.',
    `ppe_size_shirt` STRING COMMENT 'Shirt size for issuing Personal Protective Equipment (PPE) such as high-visibility vests and work shirts. [ENUM-REF-CANDIDATE: XS|S|M|L|XL|XXL|XXXL — 7 candidates stripped; promote to reference product]',
    `security_clearance_level` STRING COMMENT 'Security clearance level held by the craft worker for access to restricted project sites (e.g., government, defense, critical infrastructure projects).. Valid values are `none|basic|confidential|secret|top_secret`',
    `site_access_badge_number` STRING COMMENT 'Unique badge or access card number issued to the craft worker for site entry and time tracking at construction sites.. Valid values are `^[A-Z0-9]{6,15}$`',
    `skill_level` STRING COMMENT 'Proficiency level of the craft worker in their primary trade: apprentice (in training), journeyman (certified tradesperson), master (advanced certification), or foreman (supervisory level).. Valid values are `apprentice|journeyman|master|foreman`',
    `supervisory_role_flag` BOOLEAN COMMENT 'Indicates whether the craft worker currently holds a supervisory role such as working foreman or crew lead (True) or is a non-supervisory hourly worker (False).',
    `supervisory_title` STRING COMMENT 'Job title for supervisory role if applicable (e.g., Working Foreman, Crew Lead, General Foreman).',
    `termination_date` DATE COMMENT 'Date the craft workers employment or engagement was terminated, if applicable.',
    `union_affiliation_flag` BOOLEAN COMMENT 'Indicates whether the craft worker is affiliated with a labor union (True) or non-union (False).',
    `union_local_number` STRING COMMENT 'Local union chapter number the worker belongs to, if union-affiliated.. Valid values are `^[0-9]{1,6}$`',
    `union_name` STRING COMMENT 'Name of the labor union the worker is affiliated with, if applicable (e.g., International Brotherhood of Electrical Workers, United Association of Plumbers).',
    `worker_status` STRING COMMENT 'Current lifecycle status of the craft worker record: active (currently employed and available), inactive (temporarily not working), suspended (disciplinary or safety hold), or terminated (employment ended).. Valid values are `active|inactive|suspended|terminated`',
    `years_of_experience` STRING COMMENT 'Total number of years of experience the craft worker has in their primary trade.',
    CONSTRAINT pk_craft_worker PRIMARY KEY(`craft_worker_id`)
) COMMENT 'Master record for all craft labor personnel deployed on construction projects including hourly trade workers and working foremen/supervisors. Captures worker identity, trade classification (from skill_trade taxonomy), employment type (direct hire, agency, union referral), union affiliation and local, craft code, supervisory role flag, home project assignment, mobilization status, security clearance level, and field deployment history. SSOT for individual field worker identity in the workforce domain. Workers may hold multiple trade classifications and rotate between craft and supervisory roles across projects. Integrates with SAP SuccessFactors for HCM master data and HCSS HeavyJob for field time tracking.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`crew` (
    `crew_id` BIGINT COMMENT 'Unique identifier for the construction crew. Primary key for the crew entity.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this crew is currently assigned. A crew may be reassigned between projects over its lifecycle.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for crew cost allocation reports that roll crew labor costs to the projects cost center, enabling accurate budgeting and variance analysis per cost center.',
    `cost_code_id` BIGINT COMMENT 'Reference to the home cost code for this crew. Used for labor cost allocation and job costing when crew time is not charged to a specific activity cost code.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the worker record of the foreman or crew lead responsible for supervising this crew. The foreman is accountable for crew productivity, safety, and quality.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.project_site. Business justification: On multi-site projects, crews are assigned to specific project sites. Site-level crew tracking drives site access management, safety headcount reporting, and site-specific productivity analysis. crew.',
    `average_hourly_rate` DECIMAL(18,2) COMMENT 'Blended average hourly labor rate for the crew, calculated across all crew members. Used for cost estimation and Earned Value Management (EVM) calculations. Currency is USD unless otherwise specified in project configuration.',
    `crew_code` STRING COMMENT 'Business identifier code for the crew used in field operations and timekeeping systems. Typically alphanumeric and unique within a project or division.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was first created in the system. Used for audit trail and data lineage tracking.',
    `crew_status` STRING COMMENT 'Current operational status of the crew in its lifecycle. Active crews are deployed and working; inactive crews are not currently assigned; mobilizing/demobilizing crews are in transition; standby crews are available but not deployed; disbanded crews are permanently closed.. Valid values are `active|inactive|mobilizing|demobilizing|standby|disbanded`',
    `crew_type` STRING COMMENT 'Classification of the crew based on trade or discipline. Defines the primary craft or work scope the crew is organized to perform. [ENUM-REF-CANDIDATE: civil|structural|concrete|mep|electrical|plumbing|hvac|finishing|earthworks|piling — 10 candidates stripped; promote to reference product]',
    `days_since_last_incident` STRING COMMENT 'Number of calendar days since the last recordable safety incident for this crew. Used for safety milestone recognition and Total Recordable Incident Rate (TRIR) tracking. Null if no incidents have occurred.',
    `demobilization_date` DATE COMMENT 'Planned or actual date when the crew will be or was demobilized from the current project. Null for active crews with no planned demobilization.',
    `is_union_crew` BOOLEAN COMMENT 'Flag indicating whether this is a union crew subject to collective bargaining agreements and union work rules. True if union, false if non-union or open shop.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was last updated. Used for audit trail, change tracking, and data synchronization across systems.',
    `last_safety_incident_date` DATE COMMENT 'Date of the most recent recordable safety incident involving this crew. Used for safety performance tracking and Lost Time Injury (LTI) frequency calculations. Null if no incidents have occurred.',
    `mobilization_date` DATE COMMENT 'Date when the crew was mobilized and became operational on the current project or assignment. Used for crew lifecycle tracking and project staffing history.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this crew record. Used for audit trail and accountability in crew management.',
    `crew_name` STRING COMMENT 'Human-readable name of the crew, often reflecting the crew type, foreman name, or project assignment (e.g., Smith Concrete Gang, MEP Crew A).',
    `notes` STRING COMMENT 'Free-text field for additional information about the crew, such as special skills, project-specific arrangements, or operational constraints. Used by project management and field supervision.',
    `planned_crew_size` STRING COMMENT 'Target or planned number of workers for this crew based on project staffing plans and Work Breakdown Structure (WBS) resource requirements.',
    `productivity_rate` DECIMAL(18,2) COMMENT 'Standard or historical productivity rate for this crew, expressed in units per hour (e.g., cubic yards of concrete per hour, linear feet of pipe per hour). Unit of measure depends on crew type and work scope.',
    `productivity_uom` STRING COMMENT 'Unit of measure for the productivity rate (e.g., CY/HR for cubic yards per hour, LF/HR for linear feet per hour, EA/HR for each per hour). Aligns with Bill of Quantities (BOQ) units.',
    `quality_rating` STRING COMMENT 'Current quality performance rating for the crew based on Quality Assurance/Quality Control (QA/QC) inspections, Non-Conformance Reports (NCR), and rework rates. Used for crew selection and quality incentive programs.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `required_certifications` STRING COMMENT 'Comma-separated list of skill certifications or licenses required for crew members (e.g., OSHA 30, Confined Space, Rigging Level II). Used for crew qualification verification and compliance with Inspection and Test Plans (ITP).',
    `safety_rating` STRING COMMENT 'Current safety performance rating for the crew based on Health Safety and Environment (HSE) inspections, incident history, and compliance with Safe Work Method Statements (SWMS). Used for crew selection and safety incentive programs.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `shift_end_time` TIMESTAMP COMMENT 'Standard end time for the crews shift in HH:MM format (24-hour clock). Used for timesheet validation and labor hour planning.',
    `shift_start_time` TIMESTAMP COMMENT 'Standard start time for the crews shift in HH:MM format (24-hour clock). Used for timesheet validation and site access control.',
    `shift_type` STRING COMMENT 'Standard shift pattern for this crew. Day shift is typical daytime hours; night shift is overnight; swing shift is evening; rotating shifts alternate; extended shifts are longer than standard 8-hour shifts.. Valid values are `day|night|swing|rotating|extended`',
    `size` STRING COMMENT 'Current number of workers assigned to this crew, including the foreman. Used for resource planning and productivity rate calculations.',
    `union_affiliation` STRING COMMENT 'Name of the labor union or trade association to which the majority of crew members belong, if applicable. Null for non-union crews. Relevant for labor relations, collective bargaining agreements, and jurisdictional work rules.',
    CONSTRAINT pk_crew PRIMARY KEY(`crew_id`)
) COMMENT 'Master record for a named field crew or gang deployed on a construction project. Captures crew name, crew type (civil, MEP, structural, concrete, etc.), foreman assignment, home cost code, project assignment, crew size, and active status. A crew is the primary unit of field labor organization in construction operations. Distinct from individual worker records.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` (
    `crew_assignment_id` BIGINT COMMENT 'Primary key for crew_assignment',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project where the crew assignment is active. Links to the project entity.',
    `cost_code_id` BIGINT COMMENT 'Identifier of the cost code used for labor cost allocation. Links to the cost code entity for job costing and financial tracking.',
    `craft_worker_id` BIGINT COMMENT 'Identifier of the craft worker assigned to the crew. Links to the individual workforce member.',
    `crew_id` BIGINT COMMENT 'Identifier of the crew to which the worker is assigned. Links to the crew entity.',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: crew_assignment already tracks hse_orientation_completed_flag and hse_orientation_date. Linking to hse_plan identifies which plan version governed the induction, enabling audit verification that orien',
    `itp_line_id` BIGINT COMMENT 'Foreign key linking to quality.itp_line. Business justification: Crew assignments execute specific ITP line activities; linking enables hold-point release workflows and QC verification that assigned crews are working against the correct inspection test plan line — ',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: crew_assignment.craft_type is a STRING storing the trade/craft classification for the assignment. This is a denormalized reference to the labor_cost_code master. Adding labor_cost_code_id to crew_assi',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Construction regulatory compliance requires a valid Permit to Work before crew deployment to high-risk activities (confined space, hot work, heights). Linking crew_assignment to the governing PTW enfo',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Construction schedules assign crews to specific contractual milestones (e.g., structural completion, commissioning). Milestone-crew traceability is required for schedule adherence reporting, LD exposu',
    `resource_id` BIGINT COMMENT 'Foreign key linking to schedule.resource. Business justification: Crew assignments fulfill scheduled resource demands. Linking crew_assignment to the schedule resource catalog enables resource utilization tracking — comparing planned resource quantities (schedule.re',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: WHS regulations (e.g., Australian WHS Act) require a current SWMS to govern each high-risk construction work assignment. Linking crew_assignment to the applicable SWMS enables compliance verification ',
    `assignment_end_date` DATE COMMENT 'Date when the workers assignment to the crew ends. Null for open-ended assignments. Marks the effective end of the crew membership period.',
    `assignment_notes` STRING COMMENT 'Free-text notes or comments related to the crew assignment. May include special instructions, restrictions, or contextual information.',
    `assignment_number` STRING COMMENT 'Business identifier for the crew assignment. Human-readable reference number used in field operations and timekeeping systems.',
    `assignment_reason` STRING COMMENT 'Business reason or justification for the crew assignment. May include project need, skill requirement, backfill, or resource leveling.',
    `assignment_start_date` DATE COMMENT 'Date when the workers assignment to the crew begins. Marks the effective start of the crew membership period.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the crew assignment. Tracks whether the assignment is currently active, temporarily suspended, or has ended.. Valid values are `active|inactive|suspended|completed|terminated`',
    `assignment_type` STRING COMMENT 'Classification of the crew assignment duration and nature. Distinguishes between permanent crew members, temporary assignments, seasonal workers, and project-specific staffing.. Valid values are `permanent|temporary|seasonal|project_based`',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether labor hours from this crew assignment are billable to the client. Relevant for cost-plus and time-and-materials contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the crew assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `crew_role` STRING COMMENT 'Role of the worker within the crew. Defines the workers responsibility level and function within the crew structure.. Valid values are `laborer|operator|foreman|lead|journeyman|apprentice`',
    `demobilization_date` DATE COMMENT 'Date when the worker was demobilized from the project site. Marks the end of on-site presence for this crew assignment.',
    `hse_orientation_completed_flag` BOOLEAN COMMENT 'Indicates whether the worker has completed mandatory HSE orientation for this crew assignment. Required before site access is granted.',
    `hse_orientation_date` DATE COMMENT 'Date when the worker completed HSE orientation for this crew assignment. Used for compliance tracking and re-certification scheduling.',
    `labor_rate` DECIMAL(18,2) COMMENT 'Hourly labor rate for the worker in this crew assignment. Used for cost allocation and job costing. Rate may vary by project, craft, and role.',
    `labor_rate_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the labor rate (e.g., USD, EUR, GBP).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the crew assignment record was last updated. Used for audit trail and change tracking.',
    `mobilization_date` DATE COMMENT 'Date when the worker was mobilized to the project site for this crew assignment. Relevant for remote or multi-site projects requiring worker relocation.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether the worker is eligible for overtime pay in this crew assignment. Driven by labor agreements, regulations, and contract terms.',
    `per_diem_eligible_flag` BOOLEAN COMMENT 'Indicates whether the worker is eligible for per diem allowances during this crew assignment. Typically applies to workers assigned away from their home location.',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily per diem allowance rate for the worker in this crew assignment. Covers meals, lodging, and incidental expenses for remote assignments.',
    `planned_end_date` DATE COMMENT 'Originally planned end date for the crew assignment. Used for schedule variance analysis and workforce planning.',
    `planned_start_date` DATE COMMENT 'Originally planned start date for the crew assignment. Used for schedule variance analysis and workforce planning.',
    `ppe_issued_flag` BOOLEAN COMMENT 'Indicates whether required PPE has been issued to the worker for this crew assignment. Tracks compliance with safety equipment requirements.',
    `shift_type` STRING COMMENT 'Shift schedule for the crew assignment. Defines the working hours pattern (day shift, night shift, swing shift, or rotating schedule).. Valid values are `day|night|swing|rotating`',
    `site_access_badge_number` STRING COMMENT 'Site access badge or credential number issued to the worker for this crew assignment. Used for site security and access control tracking.',
    `source_system_code` STRING COMMENT 'Unique identifier of the crew assignment record in the source operational system. Enables traceability back to the system of record.',
    `termination_reason` STRING COMMENT 'Reason for ending the crew assignment if terminated before planned end date. Includes completion, reassignment, performance issues, or project cancellation.',
    `union_affiliation` STRING COMMENT 'Union or labor organization affiliation for this crew assignment (e.g., IBEW, Carpenters Union, Laborers Union). Null for non-union assignments.',
    `union_local_number` STRING COMMENT 'Local union chapter number for this crew assignment. Used for labor compliance reporting and union dues tracking.',
    CONSTRAINT pk_crew_assignment PRIMARY KEY(`crew_assignment_id`)
) COMMENT 'Transactional record linking individual craft workers to a specific crew for a defined period on a project. Captures worker role within the crew (laborer, operator, foreman, lead), assignment start and end dates, cost code, WBS element, shift, and assignment status. Enables tracking of crew composition changes over time and supports labor cost allocation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`timesheet` (
    `timesheet_id` BIGINT COMMENT 'Unique identifier for the timesheet record. Primary key for the timesheet entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: REQUIRED: Timesheet entries must be billed to the correct contract agreement; the FK enables accurate invoicing and milestone payment tracking.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project where the work was performed.',
    `cost_code_id` BIGINT COMMENT 'Identifier of the cost code used for labor cost allocation and job costing. Enables tracking of labor costs by activity type.',
    `craft_worker_id` BIGINT COMMENT 'Identifier of the craft worker who performed the work. Links to the workforce master data.',
    `crew_assignment_id` BIGINT COMMENT 'Foreign key linking to workforce.crew_assignment. Business justification: A daily timesheet is filed by a craft worker who is active under a specific crew assignment for that work period. Linking timesheet directly to crew_assignment enables: (1) direct crew-level labor cos',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Timesheets capture the rate applied; referencing labor_rate provides the authoritative rate definition and removes the duplicated hourly_rate column.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Phase-level labor cost reporting requires timesheets tagged to a project phase. Finance and project controls produce phase cost-to-complete reports using timesheet actuals aggregated by phase. Standar',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.project_site. Business justification: Timesheets must be tagged to a project site for site-level labor cost reporting, site payroll reconciliation, and multi-site cost allocation. timesheet.location_code is a plain-text denormalization of',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element to which the labor hours are charged. Enables project cost control at the work package level.',
    `approval_status` STRING COMMENT 'Current approval status of the timesheet entry in the workflow. Determines whether the timesheet can be processed for payroll and job costing.. Valid values are `draft|submitted|approved|rejected|pending_review`',
    `approved_by` STRING COMMENT 'Username or identifier of the person who approved the timesheet. Provides audit trail for timesheet approval workflow.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet was approved. Critical for payroll processing cutoff and audit compliance.',
    `craft_classification` STRING COMMENT 'The trade or craft classification of the worker for this timesheet entry. Determines applicable pay rates and union rules.. Valid values are `carpenter|electrician|plumber|welder|ironworker|laborer`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the labor cost amount. Enables multi-currency project cost tracking.. Valid values are `^[A-Z]{3}$`',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of double-time hours worked, typically on holidays or after extended overtime. Paid at 2x the regular rate.',
    `equipment_operated` STRING COMMENT 'Description or identifier of equipment operated by the worker during this timesheet period. Used for equipment utilization tracking and operator certification validation.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the labor hours are billable to the client or are non-billable overhead. Critical for revenue recognition and client invoicing.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost for this timesheet entry, calculated from hours worked and applicable pay rates. Core metric for job costing and project financial management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet record was last modified. Audit trail for record updates.',
    `notes` STRING COMMENT 'Free-text notes or comments about the work performed, issues encountered, or special circumstances. Provides context for time entries.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked beyond the standard work period. Typically paid at 1.5x the regular rate.',
    `pay_type` DECIMAL(18,2) COMMENT 'The compensation method applied to this timesheet entry. Determines how labor costs are calculated.',
    `payroll_period` DECIMAL(18,2) COMMENT 'Identifier of the payroll period to which this timesheet belongs. Used for grouping timesheets for payroll processing.',
    `production_quantity` DECIMAL(18,2) COMMENT 'Quantity of work units produced during the timesheet period. Used for productivity rate calculation and earned value analysis.',
    `production_unit` STRING COMMENT 'Unit of measure for the production quantity (e.g., cubic yards, linear feet, square meters, each). Enables standardized productivity tracking.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular hours worked during the standard work period. Typically up to 8 hours per day or 40 hours per week.',
    `rejection_reason` STRING COMMENT 'Explanation provided when a timesheet is rejected. Enables corrective action and quality improvement in time tracking.',
    `shift_type` STRING COMMENT 'The type of work shift during which the labor was performed. Affects pay rates and scheduling.. Valid values are `day|night|swing|rotating`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet was submitted for approval. Marks the transition from draft to submitted status in the workflow.',
    `total_hours` DECIMAL(18,2) COMMENT 'Total hours worked across all categories (regular, overtime, double-time). Sum of all hour types for the timesheet entry.',
    `union_local` STRING COMMENT 'Union local chapter number to which the worker belongs. Required for union reporting and compliance with collective bargaining agreements.',
    `weather_condition` STRING COMMENT 'Weather conditions during the work period. Impacts productivity rates and may justify schedule delays or Extension of Time (EOT) claims.. Valid values are `clear|rain|snow|extreme_heat|extreme_cold|wind`',
    `work_classification` STRING COMMENT 'Classification of the work activity type. Distinguishes between productive work, non-productive time, rework, standby, and travel time for productivity analysis.. Valid values are `productive|non_productive|rework|standby|travel`',
    `work_date` DATE COMMENT 'The calendar date on which the work was performed. Core business event timestamp for labor tracking.',
    `work_order_number` STRING COMMENT 'Reference number of the work order or task assignment associated with this timesheet. Links labor hours to specific work packages.',
    CONSTRAINT pk_timesheet PRIMARY KEY(`timesheet_id`)
) COMMENT 'Daily field timesheet record capturing hours worked by a craft worker on a specific project, cost code, and WBS element. Sourced from HCSS HeavyJob. Captures regular hours, overtime hours, double-time hours, shift type, work classification, pay type, equipment operated, and approval status. Core transactional record for labor cost coding and payroll processing in field operations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` (
    `timesheet_line_id` BIGINT COMMENT 'Unique identifier for the timesheet line item. Primary key for granular labor allocation tracking within a daily timesheet.',
    `activity_id` BIGINT COMMENT 'Reference to the specific project activity or task performed. Links labor hours to scheduled activities for progress tracking and resource leveling.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment unit operated or supported during this labor allocation. Captures operator-equipment pairing for equipment utilization analysis and maintenance scheduling.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the labor was performed. Enables project-level labor cost rollup and resource tracking.',
    `cost_code_id` BIGINT COMMENT 'Reference to the detailed cost code for labor allocation. Supports split-coding of hours across multiple cost centers within a single shift for accurate job costing.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the field worker or crew member who performed the labor. Links to the workforce master record for the individual.',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Timesheet lines record work details; linking to labor_rate centralizes rate information and removes duplicated hourly_rate and burden_rate columns.',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: Rework labor hours (timesheet_line.is_rework=true) must be attributed to the originating NCR for rework cost tracking and NCR cost-impact reporting — a mandatory construction quality and cost control ',
    `punch_item_id` BIGINT COMMENT 'Foreign key linking to quality.punch_item. Business justification: Labor hours spent closing punch items must be tracked against specific punch items for handover cost reporting and punch-list closeout labor attribution — a standard construction project closeout and ',
    `timesheet_id` BIGINT COMMENT 'Reference to the parent daily timesheet record. Links this line item to the overall timesheet submission for a worker on a specific date.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element where labor was applied. Enables activity-level labor tracking for Earned Value Management (EVM) and Critical Path Method (CPM) scheduling.',
    `approval_status` STRING COMMENT 'Current approval workflow state for this timesheet line. Tracks progression from field entry through supervisor approval to payroll posting.. Valid values are `draft|submitted|approved|rejected|posted`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this timesheet line was approved. Lifecycle event timestamp for approval workflow tracking and audit compliance.',
    `craft_code` STRING COMMENT 'Standardized code identifying the labor craft or trade performed (e.g., carpenter, electrician, heavy equipment operator, concrete finisher). Used for skill-based labor cost analysis and union reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this timesheet line record was first created in the system. Audit trail timestamp for record creation tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for labor cost amount. Supports multi-currency projects and international joint ventures.. Valid values are `^[A-Z]{3}$`',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of double-time labor hours allocated to this cost code and activity. Compensated at 2x regular rate, typically for holidays or extended overtime per union agreements.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this labor allocation is billable to the client under the contract terms. Supports reimbursable cost tracking for cost-plus and time-and-materials contracts.',
    `is_rework` BOOLEAN COMMENT 'Indicates whether this labor was performed to correct defective work or address a Non-Conformance Report (NCR). Used for quality cost tracking and root cause analysis.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost for this line item (hours × burden rate). Principal monetary value for job costing, EVM cost tracking, and project financial management.',
    `line_number` STRING COMMENT 'Sequential line number within the parent timesheet. Determines the order of labor allocation entries for a single workers daily timesheet.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this timesheet line record was last modified. Audit trail timestamp for change tracking and data lineage.',
    `notes` STRING COMMENT 'Free-text notes or comments about this labor allocation. Captures field conditions, work delays, safety observations, or other contextual information for the timesheet line.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime labor hours allocated to this cost code and activity. Typically compensated at premium rates (1.5x or 2x) per labor agreements and OSHA regulations.',
    `posted_to_job_cost_flag` DECIMAL(18,2) COMMENT 'Indicates whether this timesheet line has been posted to the job costing system for project financial tracking. Ensures labor costs are captured in project actuals.',
    `posted_to_payroll_flag` DECIMAL(18,2) COMMENT 'Indicates whether this timesheet line has been posted to the payroll system for worker compensation. Prevents duplicate payment processing.',
    `production_quantity` DECIMAL(18,2) COMMENT 'Quantity of work produced during this labor allocation (e.g., cubic yards of concrete poured, linear feet of pipe installed, square feet of formwork erected). Enables productivity rate calculation.',
    `production_unit` STRING COMMENT 'Unit of measure for production quantity (e.g., CY for cubic yards, LF for linear feet, SF for square feet, EA for each). Standardized per Bill of Quantities (BOQ) conventions.. Valid values are `^[A-Z]{2,10}$`',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular (straight-time) labor hours allocated to this cost code and activity. Used for standard labor cost calculation and productivity analysis.',
    `shift_code` STRING COMMENT 'Identifies the work shift during which labor was performed. Supports shift-differential pay calculations and 24-hour site operations tracking.. Valid values are `day|night|swing|overtime`',
    `total_hours` DECIMAL(18,2) COMMENT 'Total labor hours for this line item (sum of regular, overtime, and double-time hours). Used for resource loading and earned value calculations.',
    `union_local_code` STRING COMMENT 'Code identifying the labor union local chapter for this worker. Required for union labor reporting, fringe benefit calculations, and collective bargaining agreement compliance.. Valid values are `^[A-Z0-9]{2,10}$`',
    `weather_condition` STRING COMMENT 'Weather condition during the work period. Impacts productivity rates and may justify schedule delays or Extension of Time (EOT) claims per FIDIC contract terms. [ENUM-REF-CANDIDATE: clear|rain|snow|wind|extreme_heat|extreme_cold|fog — 7 candidates stripped; promote to reference product]',
    `work_date` DATE COMMENT 'The calendar date on which the labor was performed. Principal business event timestamp for labor allocation and daily production tracking.',
    `work_location_code` STRING COMMENT 'Site-specific location code where labor was performed (e.g., building zone, elevation level, grid coordinate). Supports spatial tracking and site logistics management.. Valid values are `^[A-Z0-9]{2,15}$`',
    `work_order_number` STRING COMMENT 'External work order or service order number if labor was performed under a specific work authorization. Links to maintenance orders or change orders.. Valid values are `^[A-Z0-9-]{5,20}$`',
    CONSTRAINT pk_timesheet_line PRIMARY KEY(`timesheet_line_id`)
) COMMENT 'Individual line item within a daily timesheet record, capturing granular labor allocation to a specific cost code, activity, WBS element, or equipment unit within a single shift. Supports split-coding of hours across multiple cost centers in a single day. Enables detailed job costing and EVM (Earned Value Management) labor tracking at the activity level.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` (
    `labor_cost_code_id` BIGINT COMMENT 'Unique identifier for the labor cost code record. Primary key.',
    `cost_code_id` BIGINT COMMENT 'Foreign key reference to finance.cost_code.cost_code_id',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each labor cost code maps to a specific GL account for payroll journal posting (e.g., direct labor expense, burden accounts). Construction controllers require this mapping to generate correct payroll ',
    `budget_category` DECIMAL(18,2) COMMENT 'High-level budget classification for financial planning and cost control. Determines how labor costs are aggregated in project budgets and Earned Value Management (EVM) reporting.',
    `burden_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to base hourly rate to account for payroll taxes, workers compensation insurance, benefits, and other indirect labor costs. Expressed as a percentage (e.g., 45.50 for 45.5%).',
    `cost_code` DECIMAL(18,2) COMMENT 'The unique alphanumeric cost code identifier used to classify and allocate field labor expenditure. This is the externally-known business identifier used in timesheets, job costing, and financial reporting.',
    `cost_code_description` DECIMAL(18,2) COMMENT 'Detailed textual description of the labor cost code explaining its purpose, scope, and typical usage in project cost allocation.',
    `cost_code_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the labor cost code. Only active codes are available for timesheet entry and new project assignments.',
    `craft_discipline` STRING COMMENT 'Standardized craft discipline category for workforce competency classification. Defines the primary skill domain for this labor cost code. [ENUM-REF-CANDIDATE: ironworker|pipefitter|electrician|carpenter|heavy_equipment_operator|concrete_finisher|welder|plumber|hvac_technician|mason|roofer|painter|laborer|foreman|superintendent — promote to reference product]. Valid values are `ironworker|pipefitter|electrician|carpenter|heavy_equipment_operator|concrete_finisher`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this labor cost code record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date after which this labor cost code is no longer valid for new assignments. Null for open-ended cost codes. Historical timesheets retain the code for audit purposes.',
    `effective_start_date` DATE COMMENT 'The date from which this labor cost code becomes valid and available for use in timesheets and project cost allocation.',
    `hcss_cost_code_mapping` DECIMAL(18,2) COMMENT 'The corresponding cost code identifier in HCSS HeavyJob field operations system. Used for timesheet integration and production tracking synchronization.',
    `hourly_rate_base` DECIMAL(18,2) COMMENT 'Standard base hourly wage rate for this labor cost code in the organizations default currency. Excludes burden, benefits, and premium time multipliers. Used for budget estimation and cost forecasting.',
    `hse_risk_level` STRING COMMENT 'The inherent Health, Safety, and Environment risk classification for this labor activity. Determines inspection frequency, permit-to-work requirements, and safety supervision levels.. Valid values are `low|medium|high|critical`',
    `is_prevailing_wage_applicable` DECIMAL(18,2) COMMENT 'Indicates whether this cost code is subject to prevailing wage requirements on government-funded projects (Davis-Bacon Act, state prevailing wage laws).',
    `is_union_classification` BOOLEAN COMMENT 'Indicates whether this labor cost code represents a union-covered trade classification subject to collective bargaining agreements and union work rules.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last updated this labor cost code record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this labor cost code record was last modified.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to base hourly rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Null if overtime is not applicable to this cost code.',
    `ppe_requirements` STRING COMMENT 'Comma-separated list of mandatory Personal Protective Equipment items required for workers assigned to this cost code (e.g., hard hat, safety glasses, steel-toed boots, fall protection harness, respirator).',
    `prevailing_wage_classification` DECIMAL(18,2) COMMENT 'The official prevailing wage classification code as defined by federal or state labor departments (e.g., Davis-Bacon Act classifications). Used to determine minimum wage rates for government-funded projects.',
    `productivity_unit_of_measure` STRING COMMENT 'The standard unit of measure used to track production rates for this labor classification (e.g., cubic yards of concrete, linear feet of pipe, square feet of formwork, tons of steel erected).',
    `required_certification_types` STRING COMMENT 'Comma-separated list of mandatory certifications, licenses, or qualifications required for workers assigned to this cost code (e.g., OSHA 30-Hour, Journeyman License, Crane Operator Certification, Confined Space Entry).',
    `requires_site_access_clearance` BOOLEAN COMMENT 'Indicates whether workers assigned to this cost code require special site access clearance, background checks, or security credentials (common for energy, defense, or critical infrastructure projects).',
    `skill_level` STRING COMMENT 'The proficiency or seniority level associated with this cost code classification. Determines base wage rates and crew assignment eligibility.. Valid values are `apprentice|journeyman|foreman|superintendent|master`',
    `standard_crew_size` STRING COMMENT 'The typical number of workers in a standard crew for this trade classification. Used for resource planning and crew assignment optimization.',
    `union_jurisdiction` STRING COMMENT 'The labor union or trade association that holds jurisdiction over this craft discipline (e.g., International Brotherhood of Electrical Workers, United Association of Plumbers and Pipefitters). Null for non-union classifications.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this labor cost code record in the system.',
    CONSTRAINT pk_labor_cost_code PRIMARY KEY(`labor_cost_code_id`)
) COMMENT 'Unified reference master for labor cost codes and trade/skill classifications used to classify and allocate field labor expenditure and define workforce competency categories. Captures cost code identifier, description, trade code, trade name, craft discipline (ironworker, pipefitter, electrician, carpenter, etc.), union jurisdiction, prevailing wage classification, required certification types, budget category, SAP PS (Project Systems) WBS mapping, and active status. Serves as the single source of truth for both cost allocation and trade/skill classification — the authoritative taxonomy of construction trades and their cost coding. Integrates with SAP S/4HANA Project Systems and HCSS HeavyJob cost coding structures. Referenced by timesheets, labor rates, agency orders, and staffing plans for consistent trade and cost classification.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`craft_certification` (
    `craft_certification_id` BIGINT COMMENT 'Unique identifier for the craft certification record. Primary key.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the craft worker who holds this certification. Links to the workforce master record.',
    `certification_level` STRING COMMENT 'The proficiency or skill level represented by this certification. Used to match workers to project requirements and determine pay grades.. Valid values are `Entry|Intermediate|Advanced|Master|Journeyman|Apprentice`',
    `certification_name` STRING COMMENT 'The full descriptive name of the certification as issued by the certifying body. Provides human-readable detail beyond the type code.',
    `certification_number` STRING COMMENT 'The unique certificate or credential number issued by the certifying body. Used for verification and audit purposes.',
    `certification_type` STRING COMMENT 'The category or type of certification held by the worker. Defines the specific trade skill, safety qualification, or competency credential. [ENUM-REF-CANDIDATE: OSHA 10|OSHA 30|NCCER Core|NCCER Craft|Rigger|Scaffolder|Welder|Crane Operator|Confined Space|Fall Protection|Forklift|Electrical|HVAC|Plumbing|First Aid|CPR|Hazmat|Asbestos|Lead Abatement — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was first created in the system. Used for audit trail and data lineage tracking.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the scanned or digital copy of the certification document stored in the document management system. Supports audit and verification workflows.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Nullable for certifications that do not expire.',
    `issue_date` DATE COMMENT 'The date on which the certification was originally issued to the worker.',
    `issuing_body` STRING COMMENT 'The organization or authority that issued the certification. Examples include OSHA (Occupational Safety and Health Administration), NCCER (National Center for Construction Education and Research), NCCCO (National Commission for the Certification of Crane Operators), AWS (American Welding Society), or state licensing boards.',
    `issuing_country_code` STRING COMMENT 'The three-letter ISO country code representing the country in which the certification was issued. Used for international workforce management and cross-border project assignments.. Valid values are `^[A-Z]{3}$`',
    `issuing_state_province` STRING COMMENT 'The state or province in which the certification was issued. Relevant for certifications that are jurisdiction-specific, such as state contractor licenses or provincial trade qualifications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was last updated. Supports change tracking and audit compliance.',
    `next_renewal_date` DATE COMMENT 'The date by which the certification must be renewed to remain valid. Used for proactive workforce planning and compliance alerts.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, or remarks related to the certification. May include details on restrictions, endorsements, or verification challenges.',
    `project_requirement_flag` BOOLEAN COMMENT 'Indicates whether this certification is required by specific project contracts or client specifications. True if the certification is a project-specific qualification requirement, False if it is a general workforce credential.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this certification is required to meet federal, state, or local regulatory requirements. True if the certification is mandated by law or regulation, False if it is voluntary or company-specific.',
    `renewal_frequency_months` STRING COMMENT 'The number of months between required renewals for this certification. Nullable if renewal is not required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this certification requires periodic renewal. True if renewal is required, False if the certification is permanent or does not expire.',
    `site_access_required_flag` BOOLEAN COMMENT 'Indicates whether this certification is mandatory for site access control. True if workers cannot badge in without a valid certification of this type, False otherwise. Supports HSE (Health Safety and Environment) compliance and access control integration.',
    `training_completion_date` DATE COMMENT 'The date on which the worker completed the training program associated with this certification.',
    `training_hours_required` DECIMAL(18,2) COMMENT 'The total number of training hours required to obtain or renew this certification. Used for workforce development planning and compliance tracking.',
    `verification_date` DATE COMMENT 'The date on which the certification was last verified by the company or issuing body. Used to track compliance audit trails.',
    `verification_status` STRING COMMENT 'The current verification state of the certification. Indicates whether the credential has been validated by the issuing body or internal compliance team, and whether it is currently active and valid for site access and work assignment.. Valid values are `Verified|Pending|Expired|Revoked|Suspended|Not Verified`',
    `verified_by` STRING COMMENT 'The name or identifier of the person or system that performed the verification. Supports audit and accountability requirements.',
    CONSTRAINT pk_craft_certification PRIMARY KEY(`craft_certification_id`)
) COMMENT 'Master record for a specific trade certification, license, or qualification held by a craft worker. Captures certification type (OSHA 10/30, NCCER credentials, rigger, scaffolder, welder qualification, crane operator NCCCO, confined space, etc.), issuing body, issue date, expiry date, certification number, verification status, and renewal requirements. Supports site access control (workers cannot badge in without valid certs), workforce competency management, and compliance with project-specific qualification requirements. Distinct from apprenticeship_progression which tracks cumulative hours and level advancement — this product tracks discrete credentials already earned.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`labor_rate` (
    `labor_rate_id` BIGINT COMMENT 'Unique identifier for the labor rate record. Primary key.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this labor rate applies. Nullable for enterprise-wide or agreement-level rates that are not project-specific.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Connects labor rate definitions to the cost center that applies the rates, supporting the Labor Rate Master report used in payroll processing.',
    `cost_code_id` BIGINT COMMENT 'Reference to the labor cost code that categorizes this rate for job costing and financial reporting. Links to the WBS (Work Breakdown Structure) and SAP cost elements.',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: Link labor_rate to labor_cost_code to associate each rate with its cost code definition, enabling removal of duplicate cost code attributes from labor_rate.',
    `apprentice_ratio` DECIMAL(18,2) COMMENT 'The maximum allowable ratio of apprentices to journeymen for this trade classification, as defined by union agreements or prevailing wage law (e.g., 1:3 means one apprentice per three journeymen). Nullable if not applicable.',
    `base_hourly_rate` DECIMAL(18,2) COMMENT 'The straight-time hourly wage rate paid to the worker for regular hours (typically up to 8 hours per day or 40 hours per week). Excludes fringe benefits and burden.',
    `certified_payroll_required_flag` DECIMAL(18,2) COMMENT 'Indicates whether this rate is subject to certified payroll reporting requirements under prevailing wage law (True) or not (False). Used to trigger compliance workflows in HCSS HeavyJob and Viewpoint Vista.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this labor rate record was first created in the source system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (e.g., USD, CAD, EUR, GBP). Required for multi-currency projects and international joint ventures.. Valid values are `^[A-Z]{3}$`',
    `double_time_hourly_rate` DECIMAL(18,2) COMMENT 'The hourly wage rate for double-time hours, typically 2.0x the base rate for hours worked on Sundays, holidays, or beyond a threshold (e.g., over 12 hours per day). Nullable if not applicable.',
    `effective_end_date` DATE COMMENT 'The date on which this labor rate expires or is superseded. Nullable for open-ended rates. Used to manage rate changes and contract renewals.',
    `effective_start_date` DATE COMMENT 'The date from which this labor rate becomes effective. Used for rate escalation tracking and historical cost analysis.',
    `escalation_clause` STRING COMMENT 'Description of any contractual escalation provisions that adjust this rate over time (e.g., annual CPI adjustment, fixed percentage increase, renegotiation trigger). Nullable if no escalation applies.',
    `fringe_benefit_rate` DECIMAL(18,2) COMMENT 'The hourly cost of fringe benefits (health insurance, pension, vacation, training funds, etc.) as defined by the labor agreement or prevailing wage determination. Added to base wage to calculate total compensation.',
    `jurisdiction` STRING COMMENT 'The geographic or contractual jurisdiction where this rate applies (e.g., Cook County IL, State of California, Federal Davis-Bacon). Used to enforce prevailing wage compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this labor rate record was last modified in the source system. Used for incremental data refresh and audit trail.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or clarifications regarding this labor rate (e.g., project-specific adjustments, negotiated exceptions, compliance notes).',
    `overhead_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to cover indirect costs and general overhead (field supervision, small tools, consumables, field office, etc.). Used in bid pricing and Guaranteed Maximum Price (GMP) calculations. Nullable if not applicable.',
    `overtime_hourly_rate` DECIMAL(18,2) COMMENT 'The hourly wage rate for overtime hours, typically 1.5x the base rate for hours beyond 8 per day or 40 per week, as defined by labor agreements or prevailing wage law.',
    `payroll_burden_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to gross wages to cover employer-paid payroll taxes (FICA, FUTA, SUTA, workers compensation insurance, general liability insurance). Expressed as a percentage (e.g., 35.50 for 35.5%).',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily per diem allowance for meals and incidental expenses when workers are mobilized away from their home location. Nullable if not applicable. Used in labor mobilization cost calculations.',
    `prevailing_wage_determination_number` DECIMAL(18,2) COMMENT 'The official reference number of the government-issued prevailing wage determination (e.g., Davis-Bacon wage decision number) that mandates this rate. Nullable for non-prevailing-wage projects.',
    `profit_margin_percentage` DECIMAL(18,2) COMMENT 'The profit margin percentage applied to the fully burdened labor cost for bid pricing. Used in EPC (Engineering, Procurement, and Construction) and GMP (Guaranteed Maximum Price) contracts. Nullable if not applicable.',
    `rate_code` DECIMAL(18,2) COMMENT 'Business identifier for the labor rate. Typically a concatenation of trade classification, skill level, and agreement reference used in estimating and job costing systems.',
    `rate_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the labor rate record. Active rates are used in cost estimation and job costing. Expired or superseded rates are retained for historical cost analysis and audit trails.',
    `rate_type` DECIMAL(18,2) COMMENT 'Classification of the rate basis: union (collective bargaining agreement), prevailing_wage (government-mandated), open_shop (non-union competitive), project_specific (negotiated for a single project), or market_rate (regional benchmark).',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional hourly premium paid for non-standard shifts (e.g., night shift, swing shift). Nullable if not applicable. Used in 24/7 operations and accelerated project schedules.',
    `skill_level` STRING COMMENT 'The skill or seniority level within the trade classification. Determines the applicable wage scale and supervisory responsibility.. Valid values are `apprentice|journeyman|foreman|general_foreman|superintendent`',
    `source_system_code` STRING COMMENT 'The unique identifier of this labor rate record in the source operational system. Used for traceability and incremental data synchronization.',
    `subsistence_rate` DECIMAL(18,2) COMMENT 'Daily subsistence allowance for lodging and living expenses when workers are required to stay overnight away from home. Nullable if not applicable. Used in remote project cost planning.',
    `total_loaded_hourly_rate` DECIMAL(18,2) COMMENT 'The all-in hourly cost including base wage, fringe benefits, payroll burden, overhead, and profit. This is the rate used for project cost estimation, Bill of Quantities (BOQ) pricing, and Earned Value Management (EVM) calculations.',
    `trade_classification` STRING COMMENT 'The craft or trade classification for which this rate applies (e.g., Carpenter, Electrician, Pipefitter, Ironworker, Heavy Equipment Operator, Laborer). Aligns with union jurisdictions and prevailing wage schedules.',
    `travel_zone` STRING COMMENT 'The geographic travel zone or radius from the union hall or home base that determines eligibility for travel pay, per diem, and subsistence. Nullable if not applicable.',
    `union_local` STRING COMMENT 'The union local or labor organization that governs this rate (e.g., IBEW Local 134, Carpenters Local 1). Nullable for non-union or open-shop rates.',
    CONSTRAINT pk_labor_rate PRIMARY KEY(`labor_rate_id`)
) COMMENT 'Reference record defining the all-in labor rates (base wage, fringe benefits, burden, overhead) for each trade classification under a specific labor agreement or project. Captures trade classification, effective date range, straight-time rate, overtime rate, double-time rate, fringe benefit rate, payroll burden percentage, and total loaded rate. Used for project cost estimation, bid pricing (BOQ), and job cost control.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew_assignment`(`crew_assignment_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `vibe_construction_v1`.`workforce`.`timesheet`(`timesheet_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ADD CONSTRAINT `fk_workforce_craft_certification_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`workforce` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` SET TAGS ('dbx_subdomain' = 'field_personnel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Craft Worker ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Home Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'direct_hire|agency|union_referral|subcontractor');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `hourly_base_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Base Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `hourly_base_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `middle_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_value_regex' = 'mobilized|demobilized|on_leave|available');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `osha_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Certification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `osha_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Certification Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate Multiplier');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `ppe_size_boots` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Size Boots');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `ppe_size_pants` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Size Pants');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `ppe_size_shirt` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Size Shirt');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|confidential|secret|top_secret');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_business_glossary_term' = 'Site Access Badge Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'apprentice|journeyman|master|foreman');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `supervisory_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Role Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `supervisory_title` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Title');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `union_local_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,6}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `union_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `worker_status` SET TAGS ('dbx_business_glossary_term' = 'Worker Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `worker_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` SET TAGS ('dbx_subdomain' = 'field_personnel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Foreman ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `average_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Hourly Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `average_hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('dbx_business_glossary_term' = 'Crew Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_status` SET TAGS ('dbx_business_glossary_term' = 'Crew Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_status` SET TAGS ('dbx_value_regex' = 'active|inactive|mobilizing|demobilizing|standby|disbanded');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_type` SET TAGS ('dbx_business_glossary_term' = 'Crew Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `days_since_last_incident` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Incident');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `is_union_crew` SET TAGS ('dbx_business_glossary_term' = 'Is Union Crew');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `last_safety_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Incident Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_name` SET TAGS ('dbx_business_glossary_term' = 'Crew Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `planned_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Planned Crew Size');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `productivity_rate` SET TAGS ('dbx_business_glossary_term' = 'Productivity Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `productivity_uom` SET TAGS ('dbx_business_glossary_term' = 'Productivity Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `quality_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|rotating|extended');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Crew Size');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` SET TAGS ('dbx_subdomain' = 'field_personnel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Identifier');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|completed|terminated');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|seasonal|project_based');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `crew_role` SET TAGS ('dbx_business_glossary_term' = 'Crew Role');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `crew_role` SET TAGS ('dbx_value_regex' = 'laborer|operator|foreman|lead|journeyman|apprentice');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `hse_orientation_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Orientation Completed Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `hse_orientation_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Orientation Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `labor_rate` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `labor_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `labor_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Currency');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `per_diem_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Eligible Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `ppe_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Issued Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|rotating');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_business_glossary_term' = 'Site Access Badge Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` SET TAGS ('dbx_subdomain' = 'labor_tracking');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|pending_review');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `craft_classification` SET TAGS ('dbx_business_glossary_term' = 'Craft Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `craft_classification` SET TAGS ('dbx_value_regex' = 'carpenter|electrician|plumber|welder|ironworker|laborer');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours Worked');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `equipment_operated` SET TAGS ('dbx_business_glossary_term' = 'Equipment Operated');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours Worked');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `pay_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `payroll_period` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Quantity');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|rotating');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `union_local` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|rain|snow|extreme_heat|extreme_cold|wind');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `work_classification` SET TAGS ('dbx_business_glossary_term' = 'Work Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `work_classification` SET TAGS ('dbx_value_regex' = 'productive|non_productive|rework|standby|travel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` SET TAGS ('dbx_subdomain' = 'labor_tracking');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `timesheet_line_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Line ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `punch_item_id` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Header ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|posted');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `craft_code` SET TAGS ('dbx_business_glossary_term' = 'Craft Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `craft_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `is_rework` SET TAGS ('dbx_business_glossary_term' = 'Is Rework Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `posted_to_job_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to Job Cost Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `posted_to_payroll_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to Payroll Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Quantity');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `production_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'day|night|swing|overtime');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `union_local_code` SET TAGS ('dbx_business_glossary_term' = 'Union Local Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `union_local_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `work_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` SET TAGS ('dbx_subdomain' = 'labor_tracking');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `burden_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `burden_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `cost_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `cost_code_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Description');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `cost_code_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `craft_discipline` SET TAGS ('dbx_business_glossary_term' = 'Craft Discipline');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `craft_discipline` SET TAGS ('dbx_value_regex' = 'ironworker|pipefitter|electrician|carpenter|heavy_equipment_operator|concrete_finisher');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `hcss_cost_code_mapping` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Cost Code Mapping');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `hourly_rate_base` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate Base');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `hourly_rate_base` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `is_prevailing_wage_applicable` SET TAGS ('dbx_business_glossary_term' = 'Is Prevailing Wage Applicable');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `is_prevailing_wage_applicable` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `is_prevailing_wage_applicable` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `is_union_classification` SET TAGS ('dbx_business_glossary_term' = 'Is Union Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('dbx_business_glossary_term' = 'Prevailing Wage Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `productivity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Productivity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `required_certification_types` SET TAGS ('dbx_business_glossary_term' = 'Required Certification Types');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `requires_site_access_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Site Access Clearance');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'apprentice|journeyman|foreman|superintendent|master');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `standard_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Standard Crew Size');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `union_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Union Jurisdiction');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` SET TAGS ('dbx_subdomain' = 'field_personnel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `craft_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Craft Certification ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'Entry|Intermediate|Advanced|Master|Journeyman|Apprentice');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `issuing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Issuing State or Province');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `project_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Project Requirement Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency (Months)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `site_access_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Site Access Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `training_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Required');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Verified|Pending|Expired|Revoked|Suspended|Not Verified');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` SET TAGS ('dbx_subdomain' = 'labor_tracking');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `apprentice_ratio` SET TAGS ('dbx_business_glossary_term' = 'Apprentice to Journeyman Ratio');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `base_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Hourly Wage Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `certified_payroll_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certified Payroll Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `double_time_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Double-Time Hourly Wage Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Rate Escalation Clause');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `fringe_benefit_rate` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefit Hourly Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Labor Jurisdiction');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `overhead_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overhead Percentage');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `overtime_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hourly Wage Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `payroll_burden_percentage` SET TAGS ('dbx_business_glossary_term' = 'Payroll Burden Percentage');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Daily Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `prevailing_wage_determination_number` SET TAGS ('dbx_business_glossary_term' = 'Prevailing Wage Determination Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `prevailing_wage_determination_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `prevailing_wage_determination_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `profit_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Profit Margin Percentage');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Hourly Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'apprentice|journeyman|foreman|general_foreman|superintendent');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `subsistence_rate` SET TAGS ('dbx_business_glossary_term' = 'Subsistence Daily Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `total_loaded_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Total Loaded Hourly Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `trade_classification` SET TAGS ('dbx_business_glossary_term' = 'Trade Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `travel_zone` SET TAGS ('dbx_business_glossary_term' = 'Travel Zone');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `union_local` SET TAGS ('dbx_business_glossary_term' = 'Union Local');
