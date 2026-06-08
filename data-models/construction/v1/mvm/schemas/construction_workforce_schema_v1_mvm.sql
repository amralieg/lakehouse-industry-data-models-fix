-- Schema for Domain: workforce | Business: Construction | Version: v1_mvm
-- Generated on: 2026-05-07 09:27:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `construction_ecm`.`workforce` COMMENT 'Construction workforce management domain tracking labor resources, crew assignments, time tracking, production rates, skill certifications, labor cost coding, field personnel deployment, and site access records. Manages craft labor, supervision, and project-based staffing distinct from corporate HR functions. Integrates with HCSS HeavyJob for timesheets and SAP SuccessFactors for HCM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `construction_ecm`.`workforce`.`craft_worker` (
    `craft_worker_id` BIGINT COMMENT 'Unique identifier for the craft worker record. Primary key for the craft worker entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Payroll & compliance reports require each worker to be linked to the employing client account for tax, insurance and HSE reporting.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the primary construction project to which the craft worker is currently assigned as their home base.',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: A craft worker is classified under a specific labor cost code that defines their trade, skill level, wage classification, and burden rates. Adding labor_cost_code_id normalizes the craft_code string i',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: REQUIRED: Workers are employed by a contract party (contractor/sub‑contractor); linking supports payroll, insurance, and compliance reporting.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Each permit designates a responsible worker (permit holder) to ensure compliance; linking enables accountability audits.',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Standardize trade information by referencing skill_trade; remove redundant primary_trade_code and primary_trade_name from craft_worker.',
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

CREATE OR REPLACE TABLE `construction_ecm`.`workforce`.`crew` (
    `crew_id` BIGINT COMMENT 'Unique identifier for the construction crew. Primary key for the crew entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Crew budgeting and resource allocation dashboards aggregate crew costs per client account, needing a direct account FK.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: REQUIRED: Crew allocation is planned per contract agreement; linking allows crew costs and productivity to be attributed to the agreement.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this crew is currently assigned. A crew may be reassigned between projects over its lifecycle.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for crew cost allocation reports that roll crew labor costs to the projects cost center, enabling accurate budgeting and variance analysis per cost center.',
    `cost_code_id` BIGINT COMMENT 'Reference to the home cost code for this crew. Used for labor cost allocation and job costing when crew time is not charged to a specific activity cost code.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the worker record of the foreman or crew lead responsible for supervising this crew. The foreman is accountable for crew productivity, safety, and quality.',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Crews operate under a specific site HSE plan governing their PPE requirements, induction procedures, and emergency response protocols. Linking crew to hse_plan enables crew-level HSE compliance report',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: Crews are assigned to specific labor cost codes for job cost tracking and payroll classification. While crew has cost_code_id (finance domain), the workforce-domain labor_cost_code provides trade-spec',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Hot‑work permits assign a specific crew; tracking crew per permit is required for safety compliance reports.',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: A crew in construction is typically organized around a primary trade discipline (e.g., ironworker crew, pipefitter crew, concrete crew). Adding skill_trade_id to crew directly classifies the crews pr',
    `average_hourly_rate` DECIMAL(18,2) COMMENT 'Blended average hourly labor rate for the crew, calculated across all crew members. Used for cost estimation and Earned Value Management (EVM) calculations. Currency is USD unless otherwise specified in project configuration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was first created in the system. Used for audit trail and data lineage tracking.',
    `crew_code` STRING COMMENT 'Business identifier code for the crew used in field operations and timekeeping systems. Typically alphanumeric and unique within a project or division.. Valid values are `^[A-Z0-9]{4,12}$`',
    `crew_name` STRING COMMENT 'Human-readable name of the crew, often reflecting the crew type, foreman name, or project assignment (e.g., Smith Concrete Gang, MEP Crew A).',
    `crew_status` STRING COMMENT 'Current operational status of the crew in its lifecycle. Active crews are deployed and working; inactive crews are not currently assigned; mobilizing/demobilizing crews are in transition; standby crews are available but not deployed; disbanded crews are permanently closed.. Valid values are `active|inactive|mobilizing|demobilizing|standby|disbanded`',
    `crew_type` STRING COMMENT 'Classification of the crew based on trade or discipline. Defines the primary craft or work scope the crew is organized to perform. [ENUM-REF-CANDIDATE: civil|structural|concrete|mep|electrical|plumbing|hvac|finishing|earthworks|piling — 10 candidates stripped; promote to reference product]',
    `days_since_last_incident` STRING COMMENT 'Number of calendar days since the last recordable safety incident for this crew. Used for safety milestone recognition and Total Recordable Incident Rate (TRIR) tracking. Null if no incidents have occurred.',
    `demobilization_date` DATE COMMENT 'Planned or actual date when the crew will be or was demobilized from the current project. Null for active crews with no planned demobilization.',
    `home_location` STRING COMMENT 'Primary site, yard, or facility where this crew is based or reports to. May be a project site, equipment yard, or regional office.',
    `is_union_crew` BOOLEAN COMMENT 'Flag indicating whether this is a union crew subject to collective bargaining agreements and union work rules. True if union, false if non-union or open shop.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was last updated. Used for audit trail, change tracking, and data synchronization across systems.',
    `last_safety_incident_date` DATE COMMENT 'Date of the most recent recordable safety incident involving this crew. Used for safety performance tracking and Lost Time Injury (LTI) frequency calculations. Null if no incidents have occurred.',
    `mobilization_date` DATE COMMENT 'Date when the crew was mobilized and became operational on the current project or assignment. Used for crew lifecycle tracking and project staffing history.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this crew record. Used for audit trail and accountability in crew management.',
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

CREATE OR REPLACE TABLE `construction_ecm`.`workforce`.`crew_assignment` (
    `crew_assignment_id` BIGINT COMMENT 'Primary key for crew_assignment',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Crew scheduling assigns crews to specific activities; required for dispatch, labor tracking, and activity labor cost reporting.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project where the crew assignment is active. Links to the project entity.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: Milestone-driven crew deployment: construction crews are assigned to execute specific contract milestones. Project managers track which crew assignment is responsible for delivering each milestone for',
    `cost_code_id` BIGINT COMMENT 'Identifier of the cost code used for labor cost allocation. Links to the cost code entity for job costing and financial tracking.',
    `craft_worker_id` BIGINT COMMENT 'Identifier of the craft worker assigned to the crew. Links to the individual workforce member.',
    `crew_id` BIGINT COMMENT 'Identifier of the crew to which the worker is assigned. Links to the crew entity.',
    `itp_id` BIGINT COMMENT 'Foreign key linking to quality.itp. Business justification: Pre-task quality planning: before a crew begins work, the ITP governing that work package must be referenced on the crew assignment so hold points and witness requirements are known. Construction QA/Q',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: A crew assignment places a craft worker in a specific role on a project, and that role is classified by a labor cost code defining the trade, skill level, and wage classification for that assignment. ',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: crew_assignment currently stores labor_rate as a DECIMAL(15,2) scalar value and labor_rate_currency as a string — both are denormalized copies of data that belongs in the labor_rate reference table. A',
    `lookahead_plan_id` BIGINT COMMENT 'Foreign key linking to schedule.lookahead_plan. Business justification: Crew assignments are the formal commitments that fulfill lookahead plan work packages in LPS construction scheduling. Linking crew_assignment to lookahead_plan enables calculation of Percent Plan Comp',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Construction crew assignments to specific activities require active work permits (confined space entry, hot work, excavation permits). A site supervisor must verify a valid compliance_permit before as',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: High-risk crew assignments require a valid PTW before work commences. Linking crew_assignment to permit_to_work enables verification that assigned crews have active permits, supports PTW closure workf',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Crew assignments are scoped to project phases in construction — phase gate reviews require crew-level resource tracking per phase. A construction workforce manager expects crew assignments to be attri',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: Crew assignments are site-specific in construction — HSE site inductions, access control, and productivity reporting are managed at site level. crew_assignment has work_location as a plain text field ',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Crew assignments for specific work activities require an acknowledged SWMS before work begins. Linking crew_assignment to swms enables pre-work safety compliance verification — confirming the assigned',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element to which the crew assignment is allocated. Enables tracking of labor allocation to specific work packages.',
    `assignment_end_date` DATE COMMENT 'Date when the workers assignment to the crew ends. Null for open-ended assignments. Marks the effective end of the crew membership period.',
    `assignment_notes` STRING COMMENT 'Free-text notes or comments related to the crew assignment. May include special instructions, restrictions, or contextual information.',
    `assignment_number` STRING COMMENT 'Business identifier for the crew assignment. Human-readable reference number used in field operations and timekeeping systems.',
    `assignment_reason` STRING COMMENT 'Business reason or justification for the crew assignment. May include project need, skill requirement, backfill, or resource leveling.',
    `assignment_start_date` DATE COMMENT 'Date when the workers assignment to the crew begins. Marks the effective start of the crew membership period.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the crew assignment. Tracks whether the assignment is currently active, temporarily suspended, or has ended.. Valid values are `active|inactive|suspended|completed|terminated`',
    `assignment_type` STRING COMMENT 'Classification of the crew assignment duration and nature. Distinguishes between permanent crew members, temporary assignments, seasonal workers, and project-specific staffing.. Valid values are `permanent|temporary|seasonal|project_based`',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether labor hours from this crew assignment are billable to the client. Relevant for cost-plus and time-and-materials contracts.',
    `craft_type` STRING COMMENT 'Craft or trade classification of the worker for this assignment (e.g., carpenter, electrician, pipefitter, ironworker, concrete finisher). Aligns with union classifications and skill requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the crew assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `crew_role` STRING COMMENT 'Role of the worker within the crew. Defines the workers responsibility level and function within the crew structure.. Valid values are `laborer|operator|foreman|lead|journeyman|apprentice`',
    `demobilization_date` DATE COMMENT 'Date when the worker was demobilized from the project site. Marks the end of on-site presence for this crew assignment.',
    `hse_orientation_completed_flag` BOOLEAN COMMENT 'Indicates whether the worker has completed mandatory HSE orientation for this crew assignment. Required before site access is granted.',
    `hse_orientation_date` DATE COMMENT 'Date when the worker completed HSE orientation for this crew assignment. Used for compliance tracking and re-certification scheduling.',
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
    `source_system` STRING COMMENT 'Name of the operational system from which the crew assignment record originated (e.g., HCSS HeavyJob, SAP SuccessFactors, Procore). Used for data lineage and integration tracking.',
    `source_system_code` STRING COMMENT 'Unique identifier of the crew assignment record in the source operational system. Enables traceability back to the system of record.',
    `termination_reason` STRING COMMENT 'Reason for ending the crew assignment if terminated before planned end date. Includes completion, reassignment, performance issues, or project cancellation.',
    `union_affiliation` STRING COMMENT 'Union or labor organization affiliation for this crew assignment (e.g., IBEW, Carpenters Union, Laborers Union). Null for non-union assignments.',
    `union_local_number` STRING COMMENT 'Local union chapter number for this crew assignment. Used for labor compliance reporting and union dues tracking.',
    CONSTRAINT pk_crew_assignment PRIMARY KEY(`crew_assignment_id`)
) COMMENT 'Transactional record linking individual craft workers to a specific crew for a defined period on a project. Captures worker role within the crew (laborer, operator, foreman, lead), assignment start and end dates, cost code, WBS element, shift, and assignment status. Enables tracking of crew composition changes over time and supports labor cost allocation.';

CREATE OR REPLACE TABLE `construction_ecm`.`workforce`.`timesheet` (
    `timesheet_id` BIGINT COMMENT 'Unique identifier for the timesheet record. Primary key for the timesheet entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: REQUIRED: Timesheet entries must be billed to the correct contract agreement; the FK enables accurate invoicing and milestone payment tracking.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project where the work was performed.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: Milestone-based billing support: timesheets coded to contract milestones enable milestone billing verification. Construction contract administrators require this link to validate labor hours claimed a',
    `cost_code_id` BIGINT COMMENT 'Identifier of the cost code used for labor cost allocation and job costing. Enables tracking of labor costs by activity type.',
    `craft_worker_id` BIGINT COMMENT 'Identifier of the craft worker who performed the work. Links to the workforce master data.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: In construction field operations (particularly HCSS HeavyJob), daily timesheets are entered at the crew level — a foreman submits time for their entire crew. Adding crew_id to the timesheet header lin',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Timesheets capture the rate applied; referencing labor_rate provides the authoritative rate definition and removes the duplicated hourly_rate column.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Regulatory reporting requires labor hours to be charged to the specific permit under which work was performed.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Phase-level labor cost reporting is a standard construction finance requirement for monthly project reviews and cost-to-complete analysis. Timesheets need direct phase attribution to support phase-lev',
    `progress_billing_id` BIGINT COMMENT 'Foreign key linking to finance.progress_billing. Business justification: In T&M contracts, approved timesheets are the source documents for progress billing applications. Construction billing teams pull approved timesheets by billing period to generate progress billing cla',
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
    `location_code` STRING COMMENT 'Code identifying the specific site location or work area where the labor was performed. Enables location-based cost tracking and site access control.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet record was last modified. Audit trail for record updates.',
    `notes` STRING COMMENT 'Free-text notes or comments about the work performed, issues encountered, or special circumstances. Provides context for time entries.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked beyond the standard work period. Typically paid at 1.5x the regular rate.',
    `pay_type` STRING COMMENT 'The compensation method applied to this timesheet entry. Determines how labor costs are calculated.. Valid values are `hourly|salary|per_diem|piece_rate`',
    `payroll_period` STRING COMMENT 'Identifier of the payroll period to which this timesheet belongs. Used for grouping timesheets for payroll processing.',
    `production_quantity` DECIMAL(18,2) COMMENT 'Quantity of work units produced during the timesheet period. Used for productivity rate calculation and earned value analysis.',
    `production_unit` STRING COMMENT 'Unit of measure for the production quantity (e.g., cubic yards, linear feet, square meters, each). Enables standardized productivity tracking.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular hours worked during the standard work period. Typically up to 8 hours per day or 40 hours per week.',
    `rejection_reason` STRING COMMENT 'Explanation provided when a timesheet is rejected. Enables corrective action and quality improvement in time tracking.',
    `shift_type` STRING COMMENT 'The type of work shift during which the labor was performed. Affects pay rates and scheduling.. Valid values are `day|night|swing|rotating`',
    `source_system` STRING COMMENT 'System or application from which the timesheet data originated. Primarily HCSS HeavyJob for field operations, but may include other sources.. Valid values are `hcss_heavyjob|procore|manual_entry|mobile_app`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet was submitted for approval. Marks the transition from draft to submitted status in the workflow.',
    `total_hours` DECIMAL(18,2) COMMENT 'Total hours worked across all categories (regular, overtime, double-time). Sum of all hour types for the timesheet entry.',
    `union_local` STRING COMMENT 'Union local chapter number to which the worker belongs. Required for union reporting and compliance with collective bargaining agreements.',
    `weather_condition` STRING COMMENT 'Weather conditions during the work period. Impacts productivity rates and may justify schedule delays or Extension of Time (EOT) claims.. Valid values are `clear|rain|snow|extreme_heat|extreme_cold|wind`',
    `work_classification` STRING COMMENT 'Classification of the work activity type. Distinguishes between productive work, non-productive time, rework, standby, and travel time for productivity analysis.. Valid values are `productive|non_productive|rework|standby|travel`',
    `work_date` DATE COMMENT 'The calendar date on which the work was performed. Core business event timestamp for labor tracking.',
    `work_order_number` STRING COMMENT 'Reference number of the work order or task assignment associated with this timesheet. Links labor hours to specific work packages.',
    CONSTRAINT pk_timesheet PRIMARY KEY(`timesheet_id`)
) COMMENT 'Daily field timesheet record capturing hours worked by a craft worker on a specific project, cost code, and WBS element. Sourced from HCSS HeavyJob. Captures regular hours, overtime hours, double-time hours, shift type, work classification, pay type, equipment operated, and approval status. Core transactional record for labor cost coding and payroll processing in field operations.';

CREATE OR REPLACE TABLE `construction_ecm`.`workforce`.`timesheet_line` (
    `timesheet_line_id` BIGINT COMMENT 'Unique identifier for the timesheet line item. Primary key for granular labor allocation tracking within a daily timesheet.',
    `activity_id` BIGINT COMMENT 'Reference to the specific project activity or task performed. Links labor hours to scheduled activities for progress tracking and resource leveling.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment unit operated or supported during this labor allocation. Captures operator-equipment pairing for equipment utilization analysis and maintenance scheduling.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the labor was performed. Enables project-level labor cost rollup and resource tracking.',
    `cost_code_id` BIGINT COMMENT 'Reference to the detailed cost code for labor allocation. Supports split-coding of hours across multiple cost centers within a single shift for accurate job costing.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the field worker or crew member who performed the labor. Links to the workforce master record for the individual.',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Inspection labor cost reporting: when an inspector or crew logs time performing an inspection, the timesheet line should reference the inspection record. Construction project controls require cost-per',
    `job_cost_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.job_cost_transaction. Business justification: When posted_to_job_cost_flag=true, each timesheet line generates a job_cost_transaction record. Construction cost accountants require this link for labor cost audit trails, certified payroll reconcili',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Timesheet lines record work details; linking to labor_rate centralizes rate information and removes duplicated hourly_rate and burden_rate columns.',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: Rework labor cost tracking: when a timesheet_line records rework hours (is_rework=true), it must reference the NCR that triggered the rework. Construction cost control and client billing dispute resol',
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
    `posted_to_job_cost_flag` BOOLEAN COMMENT 'Indicates whether this timesheet line has been posted to the job costing system for project financial tracking. Ensures labor costs are captured in project actuals.',
    `posted_to_payroll_flag` BOOLEAN COMMENT 'Indicates whether this timesheet line has been posted to the payroll system for worker compensation. Prevents duplicate payment processing.',
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

CREATE OR REPLACE TABLE `construction_ecm`.`workforce`.`labor_cost_code` (
    `labor_cost_code_id` BIGINT COMMENT 'Unique identifier for the labor cost code record. Primary key.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Labor cost codes must map to finance cost codes for job costing integration — the bridge between workforce cost classification and financial cost classification. Standard in construction ERP (HCSS to ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Labor cost codes in construction encode prevailing wage classifications, union jurisdiction rules, and OSHA training requirements — all driven by specific regulatory obligations. A construction cost e',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Labor cost codes classify trades; linking to skill_trade centralizes trade definitions and removes duplicate trade attributes.',
    `budget_category` STRING COMMENT 'High-level budget classification for financial planning and cost control. Determines how labor costs are aggregated in project budgets and Earned Value Management (EVM) reporting.. Valid values are `direct_labor|indirect_labor|supervision|premium_time|mobilization`',
    `burden_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to base hourly rate to account for payroll taxes, workers compensation insurance, benefits, and other indirect labor costs. Expressed as a percentage (e.g., 45.50 for 45.5%).',
    `cost_code_status` STRING COMMENT 'Current lifecycle status of the labor cost code. Only active codes are available for timesheet entry and new project assignments.. Valid values are `active|inactive|deprecated|pending_approval`',
    `craft_discipline` STRING COMMENT 'Standardized craft discipline category for workforce competency classification. Defines the primary skill domain for this labor cost code. [ENUM-REF-CANDIDATE: ironworker|pipefitter|electrician|carpenter|heavy_equipment_operator|concrete_finisher|welder|plumber|hvac_technician|mason|roofer|painter|laborer|foreman|superintendent — promote to reference product]. Valid values are `ironworker|pipefitter|electrician|carpenter|heavy_equipment_operator|concrete_finisher`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this labor cost code record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date after which this labor cost code is no longer valid for new assignments. Null for open-ended cost codes. Historical timesheets retain the code for audit purposes.',
    `effective_start_date` DATE COMMENT 'The date from which this labor cost code becomes valid and available for use in timesheets and project cost allocation.',
    `hcss_cost_code_mapping` STRING COMMENT 'The corresponding cost code identifier in HCSS HeavyJob field operations system. Used for timesheet integration and production tracking synchronization.',
    `hourly_rate_base` DECIMAL(18,2) COMMENT 'Standard base hourly wage rate for this labor cost code in the organizations default currency. Excludes burden, benefits, and premium time multipliers. Used for budget estimation and cost forecasting.',
    `hse_risk_level` STRING COMMENT 'The inherent Health, Safety, and Environment risk classification for this labor activity. Determines inspection frequency, permit-to-work requirements, and safety supervision levels.. Valid values are `low|medium|high|critical`',
    `is_prevailing_wage_applicable` BOOLEAN COMMENT 'Indicates whether this cost code is subject to prevailing wage requirements on government-funded projects (Davis-Bacon Act, state prevailing wage laws).',
    `is_union_classification` BOOLEAN COMMENT 'Indicates whether this labor cost code represents a union-covered trade classification subject to collective bargaining agreements and union work rules.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last updated this labor cost code record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this labor cost code record was last modified.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to base hourly rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Null if overtime is not applicable to this cost code.',
    `ppe_requirements` STRING COMMENT 'Comma-separated list of mandatory Personal Protective Equipment items required for workers assigned to this cost code (e.g., hard hat, safety glasses, steel-toed boots, fall protection harness, respirator).',
    `prevailing_wage_classification` STRING COMMENT 'The official prevailing wage classification code as defined by federal or state labor departments (e.g., Davis-Bacon Act classifications). Used to determine minimum wage rates for government-funded projects.',
    `productivity_unit_of_measure` STRING COMMENT 'The standard unit of measure used to track production rates for this labor classification (e.g., cubic yards of concrete, linear feet of pipe, square feet of formwork, tons of steel erected).',
    `required_certification_types` STRING COMMENT 'Comma-separated list of mandatory certifications, licenses, or qualifications required for workers assigned to this cost code (e.g., OSHA 30-Hour, Journeyman License, Crane Operator Certification, Confined Space Entry).',
    `requires_site_access_clearance` BOOLEAN COMMENT 'Indicates whether workers assigned to this cost code require special site access clearance, background checks, or security credentials (common for energy, defense, or critical infrastructure projects).',
    `sap_wbs_element` STRING COMMENT 'The SAP Project Systems Work Breakdown Structure element code that this labor cost code maps to for integration with SAP S/4HANA financial and project accounting modules.',
    `skill_level` STRING COMMENT 'The proficiency or seniority level associated with this cost code classification. Determines base wage rates and crew assignment eligibility.. Valid values are `apprentice|journeyman|foreman|superintendent|master`',
    `standard_crew_size` STRING COMMENT 'The typical number of workers in a standard crew for this trade classification. Used for resource planning and crew assignment optimization.',
    `union_jurisdiction` STRING COMMENT 'The labor union or trade association that holds jurisdiction over this craft discipline (e.g., International Brotherhood of Electrical Workers, United Association of Plumbers and Pipefitters). Null for non-union classifications.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this labor cost code record in the system.',
    CONSTRAINT pk_labor_cost_code PRIMARY KEY(`labor_cost_code_id`)
) COMMENT 'Unified reference master for labor cost codes and trade/skill classifications used to classify and allocate field labor expenditure and define workforce competency categories. Captures cost code identifier, description, trade code, trade name, craft discipline (ironworker, pipefitter, electrician, carpenter, etc.), union jurisdiction, prevailing wage classification, required certification types, budget category, SAP PS (Project Systems) WBS mapping, and active status. Serves as the single source of truth for both cost allocation and trade/skill classification — the authoritative taxonomy of construction trades and their cost coding. Integrates with SAP S/4HANA Project Systems and HCSS HeavyJob cost coding structures. Referenced by timesheets, labor rates, agency orders, and staffing plans for consistent trade and cost classification.';

CREATE OR REPLACE TABLE `construction_ecm`.`workforce`.`craft_certification` (
    `craft_certification_id` BIGINT COMMENT 'Unique identifier for the craft certification record. Primary key.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the craft worker who holds this certification. Links to the workforce master record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Construction compliance audits verify that each craft certification satisfies a specific regulatory obligation (OSHA mandate, state licensing law, union jurisdiction rule). Compliance managers need to',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Craft certifications reference a trade; linking to skill_trade consolidates trade metadata and eliminates redundant trade_category column.',
    `training_id` BIGINT COMMENT 'Foreign key linking to safety.training. Business justification: Craft certifications are earned through completion of safety training programs. Linking certification records to the training event enables full traceability from training delivery to certification is',
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
    `source_system` STRING COMMENT 'The name of the operational system from which this certification record originated. Examples include SAP SuccessFactors, HCSS HeavyJob, or Intelex. Supports data lineage and integration troubleshooting.',
    `training_completion_date` DATE COMMENT 'The date on which the worker completed the training program associated with this certification.',
    `training_hours_required` DECIMAL(18,2) COMMENT 'The total number of training hours required to obtain or renew this certification. Used for workforce development planning and compliance tracking.',
    `verification_date` DATE COMMENT 'The date on which the certification was last verified by the company or issuing body. Used to track compliance audit trails.',
    `verification_status` STRING COMMENT 'The current verification state of the certification. Indicates whether the credential has been validated by the issuing body or internal compliance team, and whether it is currently active and valid for site access and work assignment.. Valid values are `Verified|Pending|Expired|Revoked|Suspended|Not Verified`',
    `verified_by` STRING COMMENT 'The name or identifier of the person or system that performed the verification. Supports audit and accountability requirements.',
    CONSTRAINT pk_craft_certification PRIMARY KEY(`craft_certification_id`)
) COMMENT 'Master record for a specific trade certification, license, or qualification held by a craft worker. Captures certification type (OSHA 10/30, NCCER credentials, rigger, scaffolder, welder qualification, crane operator NCCCO, confined space, etc.), issuing body, issue date, expiry date, certification number, verification status, and renewal requirements. Supports site access control (workers cannot badge in without valid certs), workforce competency management, and compliance with project-specific qualification requirements. Distinct from apprenticeship_progression which tracks cumulative hours and level advancement — this product tracks discrete credentials already earned.';

CREATE OR REPLACE TABLE `construction_ecm`.`workforce`.`skill_trade` (
    `skill_trade_id` BIGINT COMMENT 'Unique identifier for the construction trade skill or craft discipline record. Primary key.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each skill trade in construction is governed by a specific regulatory obligation (state licensing law, OSHA training mandate, apprenticeship ratio requirement). skill_trade has osha_training_requireme',
    `apprenticeship_duration_hours` STRING COMMENT 'Standard duration of apprenticeship training program in hours (e.g., 8000 hours for journeyman electrician). Used for workforce development planning and training program management.',
    `apprenticeship_required_flag` BOOLEAN COMMENT 'Indicates whether formal apprenticeship training is required or recommended for this trade skill. True if apprenticeship is a standard pathway; false otherwise.',
    `average_hourly_rate_usd` DECIMAL(18,2) COMMENT 'Average or benchmark hourly labor rate for journeyman-level workers in this trade, in US dollars. Used for project cost estimation and budget planning. Actual rates vary by geography, project type, and union agreements.',
    `bim_integration_level` STRING COMMENT 'Level of BIM (Building Information Modeling) technology integration and digital literacy expected for this trade (none, basic, intermediate, advanced). Used for technology training planning and digital construction readiness.. Valid values are `none|basic|intermediate|advanced`',
    `certification_issuing_body` STRING COMMENT 'Name of the organization or regulatory body that issues the required certification for this trade (e.g., NCCER, AWS, NCCCO, state licensing board). Used for credential verification and compliance tracking.',
    `certification_type_required` STRING COMMENT 'Type of professional certification, license, or credential required to perform work in this trade (e.g., NCCER certification, state electrical license, AWS welding certification, NCCCO crane operator certification). Multiple certifications may be listed as comma-separated values.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade skill record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date when this trade skill classification was retired or became obsolete. Null for currently active trades. Used for temporal validity and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when this trade skill classification became active and available for use in workforce planning and assignment. Used for temporal validity and historical tracking.',
    `equipment_dependency_flag` BOOLEAN COMMENT 'Indicates whether this trade requires specialized heavy equipment or machinery to perform work (e.g., crane operators require cranes, equipment operators require excavators). True if equipment-dependent; false if primarily manual labor.',
    `hazard_exposure_level` STRING COMMENT 'Classification of typical occupational hazard exposure level for this trade (low, moderate, high, extreme). Used for risk assessment, insurance rating, and HSE planning.. Valid values are `low|moderate|high|extreme`',
    `labor_shortage_indicator` STRING COMMENT 'Current market assessment of labor availability for this trade (surplus, balanced, shortage, critical shortage). Used for strategic workforce planning and recruitment prioritization.. Valid values are `surplus|balanced|shortage|critical_shortage`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade skill record was last updated or modified. Used for audit trail and change tracking.',
    `mep_discipline_flag` BOOLEAN COMMENT 'Indicates whether this trade is part of the MEP (Mechanical, Electrical, and Plumbing) disciplines. True for electricians, pipefitters, HVAC technicians, plumbers; false for structural and civil trades.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations related to this trade skill classification. May include regional variations, specialty sub-disciplines, or unique requirements.',
    `osha_training_requirement` STRING COMMENT 'Specific OSHA training courses or certifications required for this trade (e.g., OSHA 10-hour, OSHA 30-hour, confined space, fall protection, scaffolding). Used for safety compliance and site access control.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Standard overtime pay multiplier for this trade (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Used for labor cost calculation and payroll processing.',
    `physical_demand_rating` STRING COMMENT 'Classification of physical exertion and strength requirements for this trade (light, medium, heavy, very heavy). Used for workforce health management and ergonomic planning.. Valid values are `light|medium|heavy|very_heavy`',
    `ppe_requirements` STRING COMMENT 'Standard personal protective equipment required for workers in this trade (e.g., hard hat, safety glasses, steel-toed boots, gloves, fall protection harness, welding helmet). Used for safety planning and PPE procurement.',
    `prevailing_wage_classification` STRING COMMENT 'Official wage classification code used for prevailing wage determination on public works projects, as defined by Davis-Bacon Act or state-specific prevailing wage laws. Critical for labor cost estimation and compliance on government-funded projects.',
    `productivity_unit_of_measure` STRING COMMENT 'Standard unit of measure used to track productivity for this trade (e.g., linear feet of pipe installed per day, cubic yards of concrete placed per hour, square feet of drywall hung per shift). Used for production tracking and earned value management (EVM).',
    `seasonal_demand_pattern` STRING COMMENT 'Description of typical seasonal demand fluctuation for this trade (e.g., high demand in summer for outdoor trades, year-round for indoor MEP work). Used for workforce capacity planning and recruitment timing.',
    `skill_level_tiers` STRING COMMENT 'Defined progression tiers or grades within this trade (e.g., apprentice, journeyman, foreman, general foreman, superintendent). Used for career path planning and labor rate determination. Typically stored as comma-separated hierarchy.',
    `standard_crew_size` STRING COMMENT 'Typical or recommended crew size for efficient work execution in this trade (e.g., 4-person ironworker crew, 2-person electrician crew). Used for resource planning and scheduling.',
    `trade_category` STRING COMMENT 'High-level classification grouping of the trade skill (structural, mechanical, electrical, civil, finishing, equipment operation, specialty). Used for workforce segmentation and reporting. [ENUM-REF-CANDIDATE: structural|mechanical|electrical|civil|finishing|equipment_operation|specialty — 7 candidates stripped; promote to reference product]',
    `trade_code` STRING COMMENT 'Standardized alphanumeric code identifying the construction trade or craft discipline (e.g., IW for ironworker, EL for electrician, CP for carpenter). Used for workforce planning, labor rate determination, and crew composition.. Valid values are `^[A-Z0-9]{2,10}$`',
    `trade_name` STRING COMMENT 'Full descriptive name of the construction trade or craft discipline (e.g., Ironworker, Pipefitter, Electrician, Carpenter, Concrete Finisher, Heavy Equipment Operator, Rigger, Welder).',
    `trade_status` STRING COMMENT 'Current lifecycle status of the trade skill classification. Active trades are available for workforce planning and assignment; inactive trades are no longer used; obsolete trades are deprecated; emerging trades are newly recognized.. Valid values are `active|inactive|obsolete|emerging`',
    `travel_requirement_typical` STRING COMMENT 'Typical geographic travel requirement for workers in this trade (none, local, regional, national, international). Used for workforce planning and per diem budgeting.. Valid values are `none|local|regional|national|international`',
    `union_jurisdiction_code` STRING COMMENT 'Code identifying the labor union or trade union that has jurisdiction over this craft discipline (e.g., IBEW for electricians, UA for pipefitters, IUOE for operators). Used for labor relations, collective bargaining, and compliance.',
    `union_jurisdiction_name` STRING COMMENT 'Full name of the labor union or trade union with jurisdiction over this craft (e.g., International Brotherhood of Electrical Workers, United Association of Plumbers and Pipefitters).',
    CONSTRAINT pk_skill_trade PRIMARY KEY(`skill_trade_id`)
) COMMENT 'Reference classification of construction trade skills and craft disciplines (e.g., ironworker, pipefitter, electrician, carpenter, concrete finisher, heavy equipment operator, rigger, welder). Captures trade code, trade name, union jurisdiction, prevailing wage classification, and required certification types. Used for workforce planning, crew composition, and labor rate determination.';

CREATE OR REPLACE TABLE `construction_ecm`.`workforce`.`labor_mobilization` (
    `labor_mobilization_id` BIGINT COMMENT 'Unique identifier for the labor mobilization record. Primary key for tracking worker movement to/from project sites.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Labor mobilization is triggered by and tracked against specific schedule activities — the activitys planned start date drives the mobilization date. Construction project controls teams monitor mobili',
    `cash_flow_forecast_id` BIGINT COMMENT 'Foreign key linking to finance.cash_flow_forecast. Business justification: Labor mobilization events (travel, accommodation, per diem) represent significant discrete cash outflows. Construction finance teams link mobilization records to cash flow forecasts to capture mobiliz',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to quality.checklist. Business justification: Site induction compliance: labor_mobilization tracks hse_orientation_completed_flag and hse_orientation_date driven by a specific site induction checklist. Linking to the checklist record enables audi',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: Milestone-triggered mobilization: labor mobilization events (Notice to Proceed, phase starts) are directly triggered by contract milestones. Construction schedulers track which milestone authorized ea',
    `cost_code_id` BIGINT COMMENT 'Cost code to which mobilization expenses will be charged. Links to project cost accounting structure.',
    `craft_worker_id` BIGINT COMMENT 'Identifier of the craft worker or supervisor being mobilized. Links to the workforce master record.',
    `crew_assignment_id` BIGINT COMMENT 'Identifier of the crew the worker is assigned to at the destination project. Null if not yet assigned.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project site the worker is mobilizing to. Null for demobilizations.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: Mobilization costs (travel bookings, accommodation, transport) generate vendor invoices that must be matched to the mobilization event for cost control and reimbursement processing. Construction proje',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Mobilizing labor to a site often depends on a site‑access or work permit; linking validates permit compliance before mobilization.',
    `primary_labor_construction_project_id` BIGINT COMMENT 'Identifier of the project site the worker is mobilizing from. Null for initial mobilizations.',
    `project_engagement_id` BIGINT COMMENT 'Foreign key linking to client.project_engagement. Business justification: Labor mobilization is triggered by NTP dates and engagement start dates recorded on project_engagement. Construction operations track mobilization events against specific client contract engagements f',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: Labor mobilization is fundamentally about deploying workers to a specific physical site. Mobilization logistics — accommodation, travel, site access badges — are site-specific, not just project-specif',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Cross-jurisdiction labor mobilization triggers specific regulatory obligations (work authorization, local hire mandates, immigration compliance). labor_mobilization already has compliance_permit_id fo',
    `site_mobilization_id` BIGINT COMMENT 'Foreign key linking to site.site_mobilization. Business justification: Labor mobilization events are planned and executed in direct response to a site mobilization event. Project controls teams reconcile labor mobilization costs against site mobilization budgets and trac',
    `staffing_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.staffing_plan. Business justification: Labor mobilizations are triggered by staffing plans — when a staffing plan calls for workers to be deployed to a project, mobilization records are created to track the physical movement of those worke',
    `accommodation_booking_reference` STRING COMMENT 'Booking confirmation number for temporary accommodation (hotel, camp, rental housing).',
    `accommodation_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost of temporary accommodation for the mobilization period.',
    `accommodation_required_flag` BOOLEAN COMMENT 'Indicates whether temporary accommodation is required at the destination site (True) or not (False).',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time the worker arrived at the destination project site, recorded for compliance and payroll purposes.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time the worker departed from the origin project site, recorded for compliance and payroll purposes.',
    `approval_date` DATE COMMENT 'Date the mobilization request was formally approved by authorized personnel.',
    `craft_code` STRING COMMENT 'Code representing the workers primary trade or craft skill (e.g., CARP for carpenter, ELEC for electrician, WELD for welder).. Valid values are `^[A-Z]{2,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mobilization record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this mobilization record.. Valid values are `^[A-Z]{3}$`',
    `demobilization_date` DATE COMMENT 'Date the worker is scheduled to depart from the origin project site. Null for initial mobilizations.',
    `hse_orientation_completed_flag` BOOLEAN COMMENT 'Indicates whether the worker has completed mandatory HSE (Health Safety and Environment) site orientation at the destination project (True) or not (False).',
    `hse_orientation_date` DATE COMMENT 'Date the worker completed HSE (Health Safety and Environment) orientation training at the destination site.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the mobilization record was last updated or modified.',
    `mobilization_date` DATE COMMENT 'Date the worker is scheduled to arrive at the destination project site and begin work.',
    `mobilization_number` STRING COMMENT 'Business identifier for the mobilization transaction. Format: MOB-YYYYMMDD followed by sequence number.. Valid values are `^MOB-[0-9]{8}$`',
    `mobilization_reason` STRING COMMENT 'Business justification or reason for the mobilization (e.g., project ramp-up, skill shortage, emergency response, project closeout).',
    `mobilization_status` STRING COMMENT 'Current status of the mobilization transaction in its lifecycle workflow.. Valid values are `planned|approved|in_transit|completed|cancelled`',
    `mobilization_type` STRING COMMENT 'Type of mobilization event: initial (first assignment to project), transfer (move between projects), demobilization (release from project), remobilization (return after temporary leave).. Valid values are `initial|transfer|demobilization|remobilization`',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the mobilization transaction for operational reference.',
    `per_diem_duration_days` STRING COMMENT 'Number of days the worker is entitled to receive per diem allowance.',
    `per_diem_eligible_flag` BOOLEAN COMMENT 'Indicates whether the worker is eligible for per diem allowance during mobilization (True) or not (False).',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily per diem allowance rate in the projects currency for meals and incidental expenses.',
    `site_access_badge_issued_flag` BOOLEAN COMMENT 'Indicates whether a site access badge or credential has been issued to the worker at the destination site (True) or not (False).',
    `special_requirements` STRING COMMENT 'Any special requirements or considerations for the mobilization such as medical accommodations, dietary restrictions, security clearances, or equipment transport needs.',
    `total_mobilization_cost` DECIMAL(18,2) COMMENT 'Total estimated or actual cost of the mobilization including travel, accommodation, per diem, and administrative expenses.',
    `travel_booking_reference` STRING COMMENT 'Booking confirmation number or reference code for travel arrangements (flight, train, rental car).',
    `travel_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost of travel arrangements including airfare, ground transportation, and related expenses.',
    `travel_mode` STRING COMMENT 'Primary mode of transportation arranged for the workers mobilization journey.. Valid values are `air|ground|rail|company_vehicle|personal_vehicle|not_applicable`',
    CONSTRAINT pk_labor_mobilization PRIMARY KEY(`labor_mobilization_id`)
) COMMENT 'Transactional record tracking the mobilization or demobilization of a craft worker or supervisor to/from a project site. Captures mobilization type (initial, transfer, demobilization), origin and destination project, travel arrangement details, per diem entitlement, mobilization date, demobilization date, and associated cost. Supports project staffing planning and labor cost forecasting.';

CREATE OR REPLACE TABLE `construction_ecm`.`workforce`.`staffing_plan` (
    `staffing_plan_id` BIGINT COMMENT 'Primary key for staffing_plan',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: REQUIRED: Staffing plans are approved per contract agreement for budgeting and compliance; linking ensures plan totals roll up to the correct agreement.',
    `bid_opportunity_id` BIGINT COMMENT 'Foreign key linking to bid.bid_opportunity. Business justification: Staffing plans are developed during bid pursuit to assess labor resource availability and cost before committing to a bid opportunity. This supports the go/no-go decision process. Construction workfor',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this staffing plan is defined.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links staffing plan headcount to the cost center responsible for payroll budgeting, used in the Staffing Budget vs. Cost Center variance report.',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Staffing plans must align with the project HSE plan — peak headcount, trade mix, and mobilization schedules are direct inputs to HSE resource planning (induction capacity, PPE procurement, emergency r',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: A staffing plan defines planned headcount and labor hours by trade and cost classification. Adding labor_cost_code_id to staffing_plan links the plan to the specific labor cost code being planned, ena',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Staffing plans require labor rate references to calculate planned labor costs (total_planned_labor_hours × rate = planned cost). Adding labor_rate_id to staffing_plan links the plan to the applicable ',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Staffing plans in construction are explicitly phase-driven — workforce ramp-up/ramp-down planning aligns with phase boundaries (civil, structural, MEP, commissioning). Phase-level headcount planning i',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Staffing plans define planned labor headcount and hours that must reconcile against the labor budget line in project_budget. Construction project controllers link staffing plans to budget line items t',
    `project_engagement_id` BIGINT COMMENT 'Foreign key linking to client.project_engagement. Business justification: Staffing plans are developed in direct response to contract awards captured in project_engagement, which defines NTP dates, headcount obligations, and labor commitments. Construction workforce planner',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Construction staffing plans must satisfy regulatory obligations around local hire percentages, apprenticeship ratios, and EEO workforce composition mandates. A compliance officer expects staffing plan',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: Staffing plans are formally developed against an approved schedule baseline — the baseline defines the labor demand curve (ramp-up, peak, ramp-down) that the staffing plan must satisfy. Construction p',
    `scope_id` BIGINT COMMENT 'Foreign key linking to contract.contract_scope. Business justification: Scope-based labor planning: staffing plans are built against specific contract scope packages in construction. Project controls require direct traceability from contract scope to its staffing plan for',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Staffing plans are developed at trade package level to plan headcount and labor hours for each subcontract scope during bid and pre-construction phases. Construction workforce planners align staffing ',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element this staffing plan applies to, enabling phase-specific or activity-specific workforce planning.',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Staffing plans in construction are structured around schedule WBS nodes (work packages/control accounts) for labor resource loading. This link enables earned value management — comparing planned labor',
    `accommodation_required_flag` BOOLEAN COMMENT 'Indicates whether worker accommodation (camps, hotels, per diem) is required for this staffing plan, typically true for remote or large-scale projects.',
    `actual_headcount` STRING COMMENT 'Actual number of workers deployed as of the last reporting period, enabling planned vs. actual variance analysis.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Actual labor hours worked as of the last reporting period, supporting Earned Value Management (EVM) and productivity tracking.',
    `agency_headcount` STRING COMMENT 'Number of workers planned to be sourced through temporary staffing agencies or labor brokers.',
    `approval_date` DATE COMMENT 'Date on which this staffing plan was formally approved and authorized for execution.',
    `approved_by` STRING COMMENT 'Name or identifier of the project manager, PMO lead, or executive who approved this staffing plan.',
    `baseline_flag` BOOLEAN COMMENT 'Indicates whether this staffing plan is the approved baseline against which all future revisions and actuals will be compared.',
    `craft_labor_headcount` STRING COMMENT 'Number of skilled trade workers (carpenters, electricians, welders, masons, etc.) planned for the period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this staffing plan record was first created in the system.',
    `direct_hire_headcount` STRING COMMENT 'Number of workers planned to be sourced through direct employment by the general contractor or project owner.',
    `headcount_variance` STRING COMMENT 'Difference between planned and actual headcount (actual minus planned), indicating over- or under-staffing relative to the plan.',
    `labor_hours_variance` DECIMAL(18,2) COMMENT 'Difference between planned and actual labor hours (actual minus planned), supporting cost and schedule performance analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this staffing plan record was last updated, supporting audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional context, assumptions, constraints, or special instructions related to this staffing plan.',
    `peak_headcount` STRING COMMENT 'Maximum number of workers required at any single point during the planning period, critical for site logistics, accommodation, and safety planning.',
    `peak_headcount_date` DATE COMMENT 'Date on which the peak headcount is expected to occur, enabling targeted resource mobilization and site readiness planning.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the staffing plan indicating its approval state and operational validity.. Valid values are `draft|approved|active|superseded|cancelled|archived`',
    `plan_type` STRING COMMENT 'Classification of the staffing plan indicating its purpose (baseline for original plan, forecast for updated projections, scenario for what-if analysis).. Valid values are `baseline|forecast|revised|scenario|contingency`',
    `plan_version` STRING COMMENT 'Version identifier for the staffing plan, enabling tracking of plan revisions and baseline comparisons (e.g., V1.0, V2.1, Baseline, Revised).',
    `planning_period_end_date` DATE COMMENT 'End date of the time period covered by this staffing plan, defining the conclusion of the workforce deployment window.',
    `planning_period_start_date` DATE COMMENT 'Start date of the time period covered by this staffing plan, defining the beginning of the workforce deployment window.',
    `ramp_down_end_date` DATE COMMENT 'Date when workforce demobilization is complete, marking the end of the labor deployment for this plan.',
    `ramp_down_start_date` DATE COMMENT 'Date when workforce demobilization begins, marking the start of the labor reduction curve as project activities wind down.',
    `ramp_up_end_date` DATE COMMENT 'Date when workforce reaches full planned strength, marking the end of the mobilization phase.',
    `ramp_up_start_date` DATE COMMENT 'Date when workforce mobilization and ramp-up begins, marking the start of the labor deployment curve.',
    `site_access_requirements` STRING COMMENT 'Description of site access prerequisites for workers (security clearances, background checks, client-specific badging), critical for mobilization planning.',
    `skill_certification_requirements` STRING COMMENT 'Summary of mandatory certifications and qualifications required for workers in this staffing plan (e.g., OSHA 30, Confined Space, Rigging Level II), supporting compliance and safety planning.',
    `source_system` STRING COMMENT 'Identifier of the operational system from which this staffing plan record originated (e.g., SAP SuccessFactors, Oracle Primavera P6, Procore).',
    `sourcing_strategy` STRING COMMENT 'Primary workforce sourcing approach for this staffing plan, defining how labor will be procured and managed.. Valid values are `direct_hire|subcontract|mixed|agency|joint_venture`',
    `subcontractor_headcount` STRING COMMENT 'Number of workers planned to be provided by subcontractors under contract to the general contractor.',
    `supervision_headcount` STRING COMMENT 'Number of supervisory personnel (foremen, superintendents, site managers) planned for the period.',
    `support_staff_headcount` STRING COMMENT 'Number of support personnel (site engineers, QA/QC inspectors, safety officers, administrative staff) planned for the period.',
    `total_planned_headcount` STRING COMMENT 'Total number of workers planned across all trades and roles for this staffing plan period, representing the aggregate workforce requirement.',
    `total_planned_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours planned across all workers and trades for the planning period, used for cost estimation and productivity forecasting.',
    `trade_mix_breakdown` STRING COMMENT 'Structured breakdown of planned headcount by trade category (e.g., Concrete:50|Steel:30|Electrical:25|Plumbing:20), supporting trade-specific procurement and scheduling.',
    `transportation_required_flag` BOOLEAN COMMENT 'Indicates whether worker transportation (buses, flights, shuttles) is required for this staffing plan, impacting mobilization logistics and costs.',
    CONSTRAINT pk_staffing_plan PRIMARY KEY(`staffing_plan_id`)
) COMMENT 'Master record for a project-level workforce staffing plan defining the planned headcount, trade mix, and labor hours required by project phase, WBS element, and time period. Captures planned vs. actual headcount, peak labor requirements, trade breakdown, source strategy (direct hire, subcontract, agency), ramp-up/ramp-down curves, and plan version. Supports workforce forecasting, labor procurement decisions, and project mobilization planning. Integrates with SAP SuccessFactors workforce planning.';

CREATE OR REPLACE TABLE `construction_ecm`.`workforce`.`labor_rate` (
    `labor_rate_id` BIGINT COMMENT 'Unique identifier for the labor rate record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Rate tables are defined per client account to support project cost estimating and billing accuracy.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this labor rate applies. Nullable for enterprise-wide or agreement-level rates that are not project-specific.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Connects labor rate definitions to the cost center that applies the rates, supporting the Labor Rate Master report used in payroll processing.',
    `cost_code_id` BIGINT COMMENT 'Reference to the labor cost code that categorizes this rate for job costing and financial reporting. Links to the WBS (Work Breakdown Structure) and SAP cost elements.',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to client.client_framework_agreement. Business justification: Framework agreements in construction establish pre-agreed labor rate schedules (rate cards) applicable across multiple call-off projects. Linking labor_rate to client_framework_agreement enables rate ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Labor rates map to GL accounts to determine how labor costs are classified in the chart of accounts (direct labor, burden, overhead). Payroll accountants require this mapping for automated journal ent',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: Link labor_rate to labor_cost_code to associate each rate with its cost code definition, enabling removal of duplicate cost code attributes from labor_rate.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Prevailing wage labor rates (Davis-Bacon, state wage laws) are mandated by specific regulatory obligations. labor_rate has certified_payroll_required_flag and prevailing_wage_determination_number — a ',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Labor rates are defined per trade classification — a pipefitter rate differs from an ironworker rate. Adding skill_trade_id to labor_rate directly links the rate record to the authoritative skill_trad',
    `apprentice_ratio` DECIMAL(18,2) COMMENT 'The maximum allowable ratio of apprentices to journeymen for this trade classification, as defined by union agreements or prevailing wage law (e.g., 1:3 means one apprentice per three journeymen). Nullable if not applicable.',
    `base_hourly_rate` DECIMAL(18,2) COMMENT 'The straight-time hourly wage rate paid to the worker for regular hours (typically up to 8 hours per day or 40 hours per week). Excludes fringe benefits and burden.',
    `certified_payroll_required_flag` BOOLEAN COMMENT 'Indicates whether this rate is subject to certified payroll reporting requirements under prevailing wage law (True) or not (False). Used to trigger compliance workflows in HCSS HeavyJob and Viewpoint Vista.',
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
    `prevailing_wage_determination_number` STRING COMMENT 'The official reference number of the government-issued prevailing wage determination (e.g., Davis-Bacon wage decision number) that mandates this rate. Nullable for non-prevailing-wage projects.',
    `profit_margin_percentage` DECIMAL(18,2) COMMENT 'The profit margin percentage applied to the fully burdened labor cost for bid pricing. Used in EPC (Engineering, Procurement, and Construction) and GMP (Guaranteed Maximum Price) contracts. Nullable if not applicable.',
    `rate_code` STRING COMMENT 'Business identifier for the labor rate. Typically a concatenation of trade classification, skill level, and agreement reference used in estimating and job costing systems.',
    `rate_status` STRING COMMENT 'Current lifecycle status of the labor rate record. Active rates are used in cost estimation and job costing. Expired or superseded rates are retained for historical cost analysis and audit trails.. Valid values are `active|pending|expired|superseded|suspended`',
    `rate_type` STRING COMMENT 'Classification of the rate basis: union (collective bargaining agreement), prevailing_wage (government-mandated), open_shop (non-union competitive), project_specific (negotiated for a single project), or market_rate (regional benchmark).. Valid values are `union|prevailing_wage|open_shop|project_specific|market_rate`',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional hourly premium paid for non-standard shifts (e.g., night shift, swing shift). Nullable if not applicable. Used in 24/7 operations and accelerated project schedules.',
    `skill_level` STRING COMMENT 'The skill or seniority level within the trade classification. Determines the applicable wage scale and supervisory responsibility.. Valid values are `apprentice|journeyman|foreman|general_foreman|superintendent`',
    `source_system` STRING COMMENT 'The operational system from which this labor rate record originated (e.g., SAP S/4HANA, Viewpoint Vista, HCSS HeavyJob, Procore). Used for data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'The unique identifier of this labor rate record in the source operational system. Used for traceability and incremental data synchronization.',
    `subsistence_rate` DECIMAL(18,2) COMMENT 'Daily subsistence allowance for lodging and living expenses when workers are required to stay overnight away from home. Nullable if not applicable. Used in remote project cost planning.',
    `total_loaded_hourly_rate` DECIMAL(18,2) COMMENT 'The all-in hourly cost including base wage, fringe benefits, payroll burden, overhead, and profit. This is the rate used for project cost estimation, Bill of Quantities (BOQ) pricing, and Earned Value Management (EVM) calculations.',
    `travel_zone` STRING COMMENT 'The geographic travel zone or radius from the union hall or home base that determines eligibility for travel pay, per diem, and subsistence. Nullable if not applicable.',
    `union_local` STRING COMMENT 'The union local or labor organization that governs this rate (e.g., IBEW Local 134, Carpenters Local 1). Nullable for non-union or open-shop rates.',
    CONSTRAINT pk_labor_rate PRIMARY KEY(`labor_rate_id`)
) COMMENT 'Reference record defining the all-in labor rates (base wage, fringe benefits, burden, overhead) for each trade classification under a specific labor agreement or project. Captures trade classification, effective date range, straight-time rate, overtime rate, double-time rate, fringe benefit rate, payroll burden percentage, and total loaded rate. Used for project cost estimation, bid pricing (BOQ), and job cost control.';

CREATE OR REPLACE TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` (
    `trade_staffing_requirement_id` BIGINT COMMENT 'Primary key for the trade_staffing_requirement association',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking this trade allocation to the specific construction trade or craft discipline',
    `staffing_plan_id` BIGINT COMMENT 'Foreign key linking this trade allocation to its parent staffing plan',
    `peak_headcount_date` DATE COMMENT 'Date on which peak headcount for this specific trade is expected within the staffing plan. Moved from staffing_plan where it existed as a plan-level scalar, now correctly scoped per trade.',
    `planned_headcount` STRING COMMENT 'Number of workers of this trade planned for deployment within this staffing plan. Trade-specific value that cannot reside on the plan-level staffing_plan record.',
    `planned_labor_hours` DECIMAL(18,2) COMMENT 'Total planned labor hours for this trade within this staffing plan. Trade-specific value used for earned value management and labor cost forecasting.',
    `ramp_down_end_date` DATE COMMENT 'Date when demobilization of this trade is complete within the staffing plan. Moved from staffing_plan where it existed as a plan-level scalar, now correctly scoped per trade.',
    `ramp_up_start_date` DATE COMMENT 'Date when mobilization of this trade begins within the staffing plan. Trade-specific ramp-up schedule that varies by discipline.',
    CONSTRAINT pk_trade_staffing_requirement PRIMARY KEY(`trade_staffing_requirement_id`)
) COMMENT 'This association product represents the planned deployment of a specific construction trade within a specific staffing plan. It captures the trade-level workforce allocation — planned headcount, labor hours, ramp-up/ramp-down schedule, and peak demand — for each trade discipline required by a staffing plan. Each record links one staffing_plan to one skill_trade with attributes that exist only in the context of this trade-within-plan allocation. Recognized as a core workforce planning artifact in HCSS HeavyJob and SAP SuccessFactors.. Existence Justification: In construction workforce planning, a staffing plan is inherently a multi-trade document — a single project phase requires ironworkers, pipefitters, electricians, and carpenters simultaneously. The current model forces one staffing_plan record per trade (via a scalar skill_trade_id FK), which fragments what is operationally a single plan into multiple records. The correct model is a trade allocation record that captures planned headcount, labor hours, and schedule curves for each trade within a given staffing plan — a recognized artifact in HCSS HeavyJob and SAP SuccessFactors workforce planning.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `construction_ecm`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `construction_ecm`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `construction_ecm`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `construction_ecm`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `construction_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `construction_ecm`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `construction_ecm`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `construction_ecm`.`workforce`.`timesheet`(`timesheet_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ADD CONSTRAINT `fk_workforce_labor_cost_code_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ADD CONSTRAINT `fk_workforce_craft_certification_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ADD CONSTRAINT `fk_workforce_craft_certification_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `construction_ecm`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `construction_ecm`.`workforce`.`crew_assignment`(`crew_assignment_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `construction_ecm`.`workforce`.`staffing_plan`(`staffing_plan_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `construction_ecm`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `construction_ecm`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `construction_ecm`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` ADD CONSTRAINT `fk_workforce_trade_staffing_requirement_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `construction_ecm`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` ADD CONSTRAINT `fk_workforce_trade_staffing_requirement_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `construction_ecm`.`workforce`.`staffing_plan`(`staffing_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `construction_ecm`.`workforce` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `construction_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` SET TAGS ('dbx_subdomain' = 'field_personnel');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Craft Worker ID');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Home Project ID');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'direct_hire|agency|union_referral|subcontractor');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `hourly_base_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Base Rate');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `hourly_base_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_value_regex' = 'mobilized|demobilized|on_leave|available');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `osha_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Certification Expiry Date');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `osha_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Certification Flag');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate Multiplier');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `ppe_size_boots` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Size Boots');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `ppe_size_pants` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Size Pants');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `ppe_size_shirt` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Size Shirt');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|confidential|secret|top_secret');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_business_glossary_term' = 'Site Access Badge Number');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'apprentice|journeyman|master|foreman');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `supervisory_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Role Flag');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `supervisory_title` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Title');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation Flag');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `union_local_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,6}$');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `worker_status` SET TAGS ('dbx_business_glossary_term' = 'Worker Status');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `worker_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `construction_ecm`.`workforce`.`craft_worker` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `construction_ecm`.`workforce`.`crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`workforce`.`crew` SET TAGS ('dbx_subdomain' = 'field_personnel');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Foreman ID');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `average_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Hourly Rate');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `average_hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('dbx_business_glossary_term' = 'Crew Code');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `crew_name` SET TAGS ('dbx_business_glossary_term' = 'Crew Name');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `crew_status` SET TAGS ('dbx_business_glossary_term' = 'Crew Status');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `crew_status` SET TAGS ('dbx_value_regex' = 'active|inactive|mobilizing|demobilizing|standby|disbanded');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `crew_type` SET TAGS ('dbx_business_glossary_term' = 'Crew Type');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `days_since_last_incident` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Incident');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `home_location` SET TAGS ('dbx_business_glossary_term' = 'Home Location');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `is_union_crew` SET TAGS ('dbx_business_glossary_term' = 'Is Union Crew');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `last_safety_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Incident Date');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `planned_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Planned Crew Size');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `productivity_rate` SET TAGS ('dbx_business_glossary_term' = 'Productivity Rate');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `productivity_uom` SET TAGS ('dbx_business_glossary_term' = 'Productivity Unit of Measure (UOM)');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `quality_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|rotating|extended');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Crew Size');
ALTER TABLE `construction_ecm`.`workforce`.`crew` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` SET TAGS ('dbx_subdomain' = 'field_personnel');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Identifier');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `itp_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `lookahead_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|completed|terminated');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|seasonal|project_based');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `craft_type` SET TAGS ('dbx_business_glossary_term' = 'Craft Type');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `crew_role` SET TAGS ('dbx_business_glossary_term' = 'Crew Role');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `crew_role` SET TAGS ('dbx_value_regex' = 'laborer|operator|foreman|lead|journeyman|apprentice');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `hse_orientation_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Orientation Completed Flag');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `hse_orientation_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Orientation Date');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `per_diem_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Eligible Flag');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `ppe_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Issued Flag');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|rotating');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_business_glossary_term' = 'Site Access Badge Number');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `site_access_badge_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `construction_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` SET TAGS ('dbx_subdomain' = 'labor_tracking');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `progress_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Billing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|pending_review');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `craft_classification` SET TAGS ('dbx_business_glossary_term' = 'Craft Classification');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `craft_classification` SET TAGS ('dbx_value_regex' = 'carpenter|electrician|plumber|welder|ironworker|laborer');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours Worked');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `equipment_operated` SET TAGS ('dbx_business_glossary_term' = 'Equipment Operated');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Notes');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours Worked');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `pay_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Type');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `pay_type` SET TAGS ('dbx_value_regex' = 'hourly|salary|per_diem|piece_rate');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `payroll_period` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Quantity');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|rotating');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'hcss_heavyjob|procore|manual_entry|mobile_app');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `union_local` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|rain|snow|extreme_heat|extreme_cold|wind');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `work_classification` SET TAGS ('dbx_business_glossary_term' = 'Work Classification');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `work_classification` SET TAGS ('dbx_value_regex' = 'productive|non_productive|rework|standby|travel');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` SET TAGS ('dbx_subdomain' = 'labor_tracking');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `timesheet_line_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Line ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `job_cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Job Cost Transaction Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Header ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|posted');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `craft_code` SET TAGS ('dbx_business_glossary_term' = 'Craft Code');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `craft_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `is_rework` SET TAGS ('dbx_business_glossary_term' = 'Is Rework Flag');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `posted_to_job_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to Job Cost Flag');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `posted_to_payroll_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to Payroll Flag');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Quantity');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `production_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `production_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'day|night|swing|overtime');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Hours');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `union_local_code` SET TAGS ('dbx_business_glossary_term' = 'Union Local Code');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `union_local_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `work_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `construction_ecm`.`workforce`.`timesheet_line` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` SET TAGS ('dbx_subdomain' = 'labor_tracking');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code ID');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'direct_labor|indirect_labor|supervision|premium_time|mobilization');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `burden_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate Percentage');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `burden_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `cost_code_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Status');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `cost_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `craft_discipline` SET TAGS ('dbx_business_glossary_term' = 'Craft Discipline');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `craft_discipline` SET TAGS ('dbx_value_regex' = 'ironworker|pipefitter|electrician|carpenter|heavy_equipment_operator|concrete_finisher');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `hcss_cost_code_mapping` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Cost Code Mapping');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `hourly_rate_base` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate Base');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `hourly_rate_base` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Level');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `is_prevailing_wage_applicable` SET TAGS ('dbx_business_glossary_term' = 'Is Prevailing Wage Applicable');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `is_prevailing_wage_applicable` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `is_prevailing_wage_applicable` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `is_union_classification` SET TAGS ('dbx_business_glossary_term' = 'Is Union Classification');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('dbx_business_glossary_term' = 'Prevailing Wage Classification');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `productivity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Productivity Unit of Measure');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `required_certification_types` SET TAGS ('dbx_business_glossary_term' = 'Required Certification Types');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `requires_site_access_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Site Access Clearance');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'apprentice|journeyman|foreman|superintendent|master');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `standard_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Standard Crew Size');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `union_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Union Jurisdiction');
ALTER TABLE `construction_ecm`.`workforce`.`labor_cost_code` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` SET TAGS ('dbx_subdomain' = 'field_personnel');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `craft_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Craft Certification ID');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'Entry|Intermediate|Advanced|Master|Journeyman|Apprentice');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `issuing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Issuing State or Province');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `project_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Project Requirement Flag');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency (Months)');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `site_access_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Site Access Required Flag');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `training_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Required');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Verified|Pending|Expired|Revoked|Suspended|Not Verified');
ALTER TABLE `construction_ecm`.`workforce`.`craft_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` SET TAGS ('dbx_subdomain' = 'field_personnel');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Identifier (ID)');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `apprenticeship_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Apprenticeship Duration Hours');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `apprenticeship_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Apprenticeship Required Flag');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `average_hourly_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Hourly Rate United States Dollars (USD)');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `average_hourly_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `bim_integration_level` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Integration Level');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `bim_integration_level` SET TAGS ('dbx_value_regex' = 'none|basic|intermediate|advanced');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `certification_issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Issuing Body');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `certification_type_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Type Required');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `equipment_dependency_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Dependency Flag');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `hazard_exposure_level` SET TAGS ('dbx_business_glossary_term' = 'Hazard Exposure Level');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `hazard_exposure_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|extreme');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `labor_shortage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Labor Shortage Indicator');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `labor_shortage_indicator` SET TAGS ('dbx_value_regex' = 'surplus|balanced|shortage|critical_shortage');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `mep_discipline_flag` SET TAGS ('dbx_business_glossary_term' = 'Mechanical Electrical and Plumbing (MEP) Discipline Flag');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Trade Notes');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `osha_training_requirement` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Training Requirement');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `physical_demand_rating` SET TAGS ('dbx_business_glossary_term' = 'Physical Demand Rating');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `physical_demand_rating` SET TAGS ('dbx_value_regex' = 'light|medium|heavy|very_heavy');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('dbx_business_glossary_term' = 'Prevailing Wage Classification');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `productivity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Productivity Unit of Measure');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `seasonal_demand_pattern` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Demand Pattern');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `skill_level_tiers` SET TAGS ('dbx_business_glossary_term' = 'Skill Level Tiers');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `standard_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Standard Crew Size');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `trade_category` SET TAGS ('dbx_business_glossary_term' = 'Trade Category');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `trade_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Code');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `trade_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `trade_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Status');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `trade_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|emerging');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `travel_requirement_typical` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Typical');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `travel_requirement_typical` SET TAGS ('dbx_value_regex' = 'none|local|regional|national|international');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `union_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Union Jurisdiction Code');
ALTER TABLE `construction_ecm`.`workforce`.`skill_trade` ALTER COLUMN `union_jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Union Jurisdiction Name');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` SET TAGS ('dbx_subdomain' = 'field_personnel');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `labor_mobilization_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Mobilization ID');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `cash_flow_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Forecast Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment ID');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Project ID');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `primary_labor_construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Project ID');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `project_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Project Engagement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `site_mobilization_id` SET TAGS ('dbx_business_glossary_term' = 'Site Mobilization Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `staffing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Staffing Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `accommodation_booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Booking Reference');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `accommodation_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Cost Estimate');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `accommodation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Required Flag');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `craft_code` SET TAGS ('dbx_business_glossary_term' = 'Craft Code');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `craft_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `hse_orientation_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Orientation Completed Flag');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `hse_orientation_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Orientation Date');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_number` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Number');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_number` SET TAGS ('dbx_value_regex' = '^MOB-[0-9]{8}$');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_reason` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Reason');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_value_regex' = 'planned|approved|in_transit|completed|cancelled');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_type` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Type');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_type` SET TAGS ('dbx_value_regex' = 'initial|transfer|demobilization|remobilization');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Notes');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `per_diem_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Duration Days');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `per_diem_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Eligible Flag');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `site_access_badge_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Site Access Badge Issued Flag');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `special_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Requirements');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `total_mobilization_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Mobilization Cost');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `travel_booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Travel Booking Reference');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `travel_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Travel Cost Estimate');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `travel_mode` SET TAGS ('dbx_business_glossary_term' = 'Travel Mode');
ALTER TABLE `construction_ecm`.`workforce`.`labor_mobilization` ALTER COLUMN `travel_mode` SET TAGS ('dbx_value_regex' = 'air|ground|rail|company_vehicle|personal_vehicle|not_applicable');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` SET TAGS ('dbx_subdomain' = 'staffing_planning');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `staffing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Staffing Plan Identifier');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `bid_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Opportunity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `project_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Project Engagement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `scope_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `accommodation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Required Flag');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `actual_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `agency_headcount` SET TAGS ('dbx_business_glossary_term' = 'Agency Headcount');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `baseline_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Flag');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `craft_labor_headcount` SET TAGS ('dbx_business_glossary_term' = 'Craft Labor Headcount');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `direct_hire_headcount` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Headcount');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `headcount_variance` SET TAGS ('dbx_business_glossary_term' = 'Headcount Variance');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `labor_hours_variance` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours Variance');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `peak_headcount` SET TAGS ('dbx_business_glossary_term' = 'Peak Headcount');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `peak_headcount_date` SET TAGS ('dbx_business_glossary_term' = 'Peak Headcount Date');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|superseded|cancelled|archived');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'baseline|forecast|revised|scenario|contingency');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `ramp_down_end_date` SET TAGS ('dbx_business_glossary_term' = 'Ramp-Down End Date');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `ramp_down_start_date` SET TAGS ('dbx_business_glossary_term' = 'Ramp-Down Start Date');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `ramp_up_end_date` SET TAGS ('dbx_business_glossary_term' = 'Ramp-Up End Date');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `ramp_up_start_date` SET TAGS ('dbx_business_glossary_term' = 'Ramp-Up Start Date');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `site_access_requirements` SET TAGS ('dbx_business_glossary_term' = 'Site Access Requirements');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `skill_certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Skill Certification Requirements');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_value_regex' = 'direct_hire|subcontract|mixed|agency|joint_venture');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `subcontractor_headcount` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Headcount');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `supervision_headcount` SET TAGS ('dbx_business_glossary_term' = 'Supervision Headcount');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `support_staff_headcount` SET TAGS ('dbx_business_glossary_term' = 'Support Staff Headcount');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `total_planned_headcount` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Headcount');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `total_planned_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Labor Hours');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `trade_mix_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Trade Mix Breakdown');
ALTER TABLE `construction_ecm`.`workforce`.`staffing_plan` ALTER COLUMN `transportation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Required Flag');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` SET TAGS ('dbx_subdomain' = 'labor_tracking');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate ID');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Client Framework Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `apprentice_ratio` SET TAGS ('dbx_business_glossary_term' = 'Apprentice to Journeyman Ratio');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `base_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Hourly Wage Rate');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `certified_payroll_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certified Payroll Required Flag');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `double_time_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Double-Time Hourly Wage Rate');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Rate Escalation Clause');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `fringe_benefit_rate` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefit Hourly Rate');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Labor Jurisdiction');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Notes');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `overhead_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overhead Percentage');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `overtime_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hourly Wage Rate');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `payroll_burden_percentage` SET TAGS ('dbx_business_glossary_term' = 'Payroll Burden Percentage');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Daily Rate');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `prevailing_wage_determination_number` SET TAGS ('dbx_business_glossary_term' = 'Prevailing Wage Determination Number');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `prevailing_wage_determination_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `prevailing_wage_determination_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `profit_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Profit Margin Percentage');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Code');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Status');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|superseded|suspended');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Type');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'union|prevailing_wage|open_shop|project_specific|market_rate');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Hourly Rate');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'apprentice|journeyman|foreman|general_foreman|superintendent');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `subsistence_rate` SET TAGS ('dbx_business_glossary_term' = 'Subsistence Daily Rate');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `total_loaded_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Total Loaded Hourly Rate');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `travel_zone` SET TAGS ('dbx_business_glossary_term' = 'Travel Zone');
ALTER TABLE `construction_ecm`.`workforce`.`labor_rate` ALTER COLUMN `union_local` SET TAGS ('dbx_business_glossary_term' = 'Union Local');
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` SET TAGS ('dbx_subdomain' = 'staffing_planning');
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` SET TAGS ('dbx_association_edges' = 'workforce.staffing_plan,workforce.skill_trade');
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` ALTER COLUMN `trade_staffing_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Staffing Requirement - Trade Staffing Requirement Id');
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Staffing Requirement - Skill Trade Id');
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` ALTER COLUMN `staffing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Staffing Requirement - Staffing Plan Id');
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` ALTER COLUMN `peak_headcount_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Peak Headcount Date');
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` ALTER COLUMN `planned_headcount` SET TAGS ('dbx_business_glossary_term' = 'Planned Trade Headcount');
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` ALTER COLUMN `planned_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Trade Labor Hours');
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` ALTER COLUMN `ramp_down_end_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Ramp-Down End Date');
ALTER TABLE `construction_ecm`.`workforce`.`trade_staffing_requirement` ALTER COLUMN `ramp_up_start_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Ramp-Up Start Date');
