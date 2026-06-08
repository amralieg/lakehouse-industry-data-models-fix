-- Schema for Domain: workforce | Business: Mining | Version: v1_ecm
-- Generated on: 2026-05-05 10:54:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`workforce` COMMENT 'Manages the mine workforce including employee and contractor records, competency and certification tracking, roster and fatigue management, shift assignments, payroll integration via SAP HR, and labor relations. Supports MSHA and ISO 45001 compliance by linking workforce data to HSE training requirements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key for the employee master data product.',
    `cost_centre_id` BIGINT COMMENT 'Cost centre to which the employees labor costs are allocated. Links to finance cost centre master data for budgeting and variance analysis.',
    `supervisor_employee_id` BIGINT COMMENT 'Employee identifier of the direct supervisor or line manager. Establishes reporting hierarchy for approvals and performance management.',
    `date_of_birth` DATE COMMENT 'Employee date of birth. Used for age verification for hazardous work assignments, retirement planning, and demographic reporting.',
    `department` STRING COMMENT 'Organizational department or functional area to which the employee belongs (e.g., Mining Operations, Processing, Maintenance, Geology).',
    `email_address` STRING COMMENT 'Primary corporate email address for the employee. Used for official communications, system access, and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the primary emergency contact person. Used for incident response and critical notifications.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the primary emergency contact. Used for immediate notification in case of workplace incidents or emergencies.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee (e.g., spouse, parent, sibling). [ENUM-REF-CANDIDATE: spouse|partner|parent|sibling|child|friend|other — 7 candidates stripped; promote to reference product]',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employment relationship. Active employees are eligible for rostering and payroll.. Valid values are `active|on-leave|suspended|terminated`',
    `employment_type` STRING COMMENT 'Classification of employment arrangement. Determines entitlements, rostering rules, and payroll processing.. Valid values are `full-time|part-time|casual|fixed-term`',
    `first_name` STRING COMMENT 'Legal first name of the employee as recorded in employment contract and identity documents.',
    `fte` DECIMAL(18,2) COMMENT 'Full-time equivalent value representing the proportion of full-time hours worked. 1.0000 = full-time, 0.5000 = half-time. Used for headcount reporting and labor cost allocation.',
    `gender` STRING COMMENT 'Employee gender identity. Used for diversity reporting and compliance with equal employment opportunity regulations.. Valid values are `male|female|non-binary|prefer not to say`',
    `hire_date` DATE COMMENT 'Date the employee commenced employment with the organization. Used for seniority calculations, leave accruals, and service awards.',
    `induction_completed_date` DATE COMMENT 'Date the employee completed mandatory site safety induction training. Required before site access is granted.',
    `induction_expiry_date` DATE COMMENT 'Date when the site induction certification expires and refresher training is required.',
    `job_code` STRING COMMENT 'Standardized code representing the job classification. Used for competency mapping, training requirements, and workforce planning.',
    `job_title` STRING COMMENT 'Official job title or position name. Reflects the employees role and level within the organizational hierarchy.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the employee as recorded in employment contract and identity documents.',
    `medical_fitness_expiry_date` DATE COMMENT 'Date when the current medical fitness certification expires. Triggers re-examination requirements for continued mine site access.',
    `medical_fitness_status` STRING COMMENT 'Current medical fitness status for mine work. Determines eligibility for hazardous work assignments and operational roles.. Valid values are `fit|fit-with-restrictions|temporarily-unfit|permanently-unfit`',
    `mobile_phone` STRING COMMENT 'Primary mobile phone number for the employee. Used for emergency contact, shift notifications, and operational communications.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number, Tax File Number, National Insurance Number). Used for tax reporting and legal compliance.',
    `pay_grade` STRING COMMENT 'Salary grade or pay band assigned to the employee. Determines compensation range and eligibility for benefits.',
    `ppe_size_boots` STRING COMMENT 'Boot size for safety footwear issuance. Used for procurement and inventory management of safety boots.',
    `ppe_size_hardhat` STRING COMMENT 'Hard hat size for head protection issuance. Used for procurement and inventory management of safety helmets.. Valid values are `S|M|L|XL`',
    `ppe_size_pants` STRING COMMENT 'Pants size for PPE uniform issuance. Used for procurement and inventory management of safety clothing.',
    `ppe_size_shirt` STRING COMMENT 'Shirt size for PPE uniform issuance. Used for procurement and inventory management of safety clothing. [ENUM-REF-CANDIDATE: XS|S|M|L|XL|XXL|XXXL — 7 candidates stripped; promote to reference product]',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in workplace communications and systems. May differ from legal name.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the system. Used for audit trail and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last modified. Used for audit trail and change tracking.',
    `sap_personnel_number` STRING COMMENT 'Eight-digit personnel number assigned in SAP S/4HANA HR module. Used for payroll integration, time management, and organizational assignment.. Valid values are `^[0-9]{8}$`',
    `site_assignment` STRING COMMENT 'Primary mine site or operational location where the employee is assigned. Used for site access control, roster planning, and HSE compliance.',
    `termination_date` DATE COMMENT 'Date the employment relationship ended. Null for active employees. Used for final payroll processing and access revocation.',
    `termination_reason` STRING COMMENT 'Reason for employment termination. Used for turnover analysis, exit interview tracking, and regulatory reporting.. Valid values are `resignation|retirement|redundancy|dismissal|end-of-contract|deceased`',
    `union_membership` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union. Used for collective bargaining agreement application and dues deduction.',
    `union_name` STRING COMMENT 'Name of the labor union to which the employee belongs, if applicable. Null for non-union employees.',
    `work_schedule_pattern` STRING COMMENT 'Standard roster pattern for the employee (e.g., 4-on-3-off, 7-on-7-off, day shift, night shift). Used for fatigue management and roster generation.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for all mine employees including full-time, part-time, and casual workers. Captures personal details, employment classification, site assignment, cost centre, SAP HR personnel number, employment status, and demographic data. Serves as the SSOT for all employee identity and employment attributes across the mining operation.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`contractor` (
    `contractor_id` BIGINT COMMENT 'Unique identifier for the contractor record. Primary key for the contractor master data product.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Contractor labour costs must be allocated to cost centres for financial reporting, AISC calculation, and contractor vs employee cost analysis. Essential for Mining operations tracking contractor expen',
    `procurement_vendor_id` BIGINT COMMENT 'Reference to the contracting company or labour-hire firm that employs this contractor. Links to the counterparty master for billing and insurance verification.',
    `roster_id` BIGINT COMMENT 'Foreign key linking to workforce.roster. Business justification: contractor.roster_pattern is currently a STRING (denormalized). Should be normalized to contractor.roster_id → roster.roster_id. Contractors follow defined roster patterns just like employees. Adding ',
    `abn` STRING COMMENT 'Australian Business Number for contractors operating as sole traders or through their own entity. Used for tax reporting and payment processing. Null for contractors employed through labour-hire firms.. Valid values are `^d{11}$`',
    `contract_reference` STRING COMMENT 'Reference number of the master services agreement or labour-hire contract under which this contractor is engaged. Links to procurement contract management system.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `contractor_number` STRING COMMENT 'Business identifier assigned to the contractor for external reference and integration with procurement and payroll systems. Typically assigned by SAP HR or contractor management system.. Valid values are `^[A-Z0-9]{6,12}$`',
    `contractor_status` STRING COMMENT 'Current lifecycle status of the contractor record. Active contractors are available for roster assignment. Suspended contractors cannot access sites pending investigation. Terminated or completed contractors have ended their engagement.. Valid values are `active|on_leave|suspended|terminated|completed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contractor record was first created in the system. Used for audit trail and data lineage tracking.',
    `email_address` STRING COMMENT 'Primary email address for contractor communication including safety alerts, roster changes, and compliance notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the contractors nominated emergency contact person. Used for critical incident notification and medical emergency coordination.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the contractors nominated emergency contact person. Must be verified and kept current for critical incident response.. Valid values are `^+?[1-9]d{1,14}$`',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact person to the contractor. Used to determine notification priority and next-of-kin status in critical incidents. [ENUM-REF-CANDIDATE: spouse|partner|parent|sibling|child|friend|other — 7 candidates stripped; promote to reference product]',
    `engagement_end_date` DATE COMMENT 'Planned or actual end date of the contractors engagement. Null for ongoing engagements. Populated for fixed-term contracts or upon termination.',
    `engagement_start_date` DATE COMMENT 'Date on which the contractors engagement commenced. Used for tenure calculation, anniversary tracking, and long-service leave accrual where applicable.',
    `engagement_type` STRING COMMENT 'Classification of the contractor engagement model. Labour-hire for general workforce augmentation, specialist for technical expertise, EPCM for engineering/construction, shutdown for planned maintenance campaigns, and trade-specific categories for mining operations. [ENUM-REF-CANDIDATE: labour_hire|specialist|epcm|shutdown|maintenance|drilling|processing|haulage|exploration — 9 candidates stripped; promote to reference product]',
    `family_name` STRING COMMENT 'The surname or family name of the contractor as recorded on official identification documents. Required for site access and emergency contact purposes.',
    `given_name` STRING COMMENT 'The first or given name of the contractor as recorded on official identification documents. Required for site access and emergency contact purposes.',
    `induction_completion_date` DATE COMMENT 'Date on which the contractor completed their most recent site induction training. Used to calculate induction expiry and trigger refresher notifications.',
    `induction_status` STRING COMMENT 'Status of the contractors site-specific safety induction training. Completed status is mandatory before first site entry. Inductions expire annually and require refresher training.. Valid values are `not_started|in_progress|completed|expired|refresher_required`',
    `insurance_expiry_date` DATE COMMENT 'Date on which the contractors insurance coverage expires. Automated alerts are triggered 60 and 30 days before expiry to ensure continuous coverage.',
    `insurance_status` STRING COMMENT 'Status of the contractors required insurance coverage including public liability, professional indemnity, and workers compensation. Current status is mandatory for site access. Managed by procurement and risk teams.. Valid values are `current|expiring_soon|expired|not_provided|under_review`',
    `maximum_engagement_duration_days` STRING COMMENT 'Maximum allowable duration in days for this contractor engagement as specified in the master services agreement or labour-hire contract. Used to prevent inadvertent permanent employment obligations.',
    `medical_assessment_date` DATE COMMENT 'Date of the contractors most recent pre-employment or periodic medical assessment. Medical assessments are required every 1-3 years depending on role and age.',
    `medical_expiry_date` DATE COMMENT 'Date on which the current medical fitness certification expires. Contractors must complete reassessment before this date to maintain site access.',
    `medical_fitness_status` STRING COMMENT 'Current medical fitness status for mine site work. Fit status is required for operational roles. Fit-with-restrictions status requires documented work limitations. Assessment results are managed by occupational health provider.. Valid values are `fit|fit_with_restrictions|temporarily_unfit|permanently_unfit|assessment_pending`',
    `mobile_phone` STRING COMMENT 'Mobile phone number for emergency contact, shift notifications, and site access coordination. Must be reachable during rostered shifts.. Valid values are `^+?[1-9]d{1,14}$`',
    `notes` STRING COMMENT 'Free-text field for additional information about the contractor including special skills, work restrictions, accommodation preferences, or administrative notes. Not used for sensitive medical or disciplinary information.',
    `rehire_eligible_flag` BOOLEAN COMMENT 'Indicates whether the contractor is eligible for future re-engagement. False for contractors terminated for safety violations, performance issues, or policy breaches. Used in contractor selection and onboarding processes.',
    `site_access_clearance_date` DATE COMMENT 'Date on which site access clearance was granted. Used to calculate clearance age and trigger periodic re-verification.',
    `site_access_clearance_status` STRING COMMENT 'Current status of the contractors site access clearance. Approved status is required for physical entry to mine sites. Suspended or revoked status triggers immediate access card deactivation.. Valid values are `pending|approved|suspended|revoked|expired`',
    `site_access_expiry_date` DATE COMMENT 'Date on which site access clearance expires. Contractors must complete re-induction and medical assessment before this date to maintain site access.',
    `statutory_role_authorisation` STRING COMMENT 'Statutory mining role that the contractor is authorised to perform under mining safety legislation. Most contractors have none as statutory roles typically require direct employment. Specific authorisation and appointment documentation required for non-none values. [ENUM-REF-CANDIDATE: none|site_senior_executive|mine_manager|deputy|supervisor|competent_person|shotfirer — 7 candidates stripped; promote to reference product]',
    `tax_file_number` STRING COMMENT 'Tax file number for payroll tax withholding and reporting. Encrypted at rest and access-controlled per Australian Taxation Office requirements.. Valid values are `^d{8,9}$`',
    `termination_reason` STRING COMMENT 'Reason for contractor engagement termination. Used for workforce analytics, rehire eligibility assessment, and contractor management improvement. Null for active contractors. [ENUM-REF-CANDIDATE: contract_completion|voluntary_resignation|performance|safety_violation|project_cancellation|redundancy|other — 7 candidates stripped; promote to reference product]',
    `trade_classification` STRING COMMENT 'Primary trade or skill classification for the contractor (e.g., Electrician, Fitter, Boilermaker, Geologist, Surveyor, Heavy Equipment Operator, Process Technician). Used for competency matching and roster planning. [ENUM-REF-CANDIDATE: electrician|fitter|boilermaker|geologist|surveyor|operator|technician|engineer|rigger|welder — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this contractor record was last modified. Used for audit trail, change tracking, and data synchronization.',
    `work_location_type` STRING COMMENT 'Classification of the contractors work location arrangement. FIFO (Fly-In Fly-Out) and DIDO (Drive-In Drive-Out) require accommodation and travel logistics. Residential contractors live in nearby towns. Remote contractors work at isolated sites.. Valid values are `fifo|dido|residential|local|remote`',
    CONSTRAINT pk_contractor PRIMARY KEY(`contractor_id`)
) COMMENT 'Master record for all contracted workers and labour-hire personnel engaged at mine sites. Captures contractor company affiliation, contract reference, ABN/tax identifier, site access clearance, induction status, trade classification, engagement type (labour-hire, specialist, EPCM, shutdown), insurance/indemnity status, and maximum engagement duration. Distinct from employee as contractors are managed under separate WHS obligations, billing arrangements, and cannot access certain statutory roles without specific authorisation.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the position record. Primary key for the position master data.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Positions are budgeted and funded through cost centres. Required for headcount planning, organizational design, budget allocation, and aligning workforce structure with financial reporting. Position h',
    `employee_id` BIGINT COMMENT 'Reference to the employee currently filling this position. Null if position is vacant.',
    `reporting_position_id` BIGINT COMMENT 'Reference to the position_id of the direct manager or supervisor position. Defines the reporting hierarchy for organizational structure.',
    `tenement_id` BIGINT COMMENT 'Mine site or facility location code where the position is based (e.g., PILBARA, KALGOORLIE, OLYMPIC_DAM).',
    `approval_date` DATE COMMENT 'Date when this position was formally approved for inclusion in the organizational structure and budget.',
    `approved_by` STRING COMMENT 'Name or identifier of the manager or executive who approved the creation or modification of this position. Used for governance and audit trail.',
    `contractor_employee_ratio` DECIMAL(18,2) COMMENT 'Planned ratio of contractor FTE to employee FTE for this position or role family. Used for workforce mix optimization and OPEX planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was first created in the system.',
    `critical_skills_gap` STRING COMMENT 'Assessment of the difficulty in filling this position due to skills scarcity in the labor market. Used for workforce planning and talent acquisition strategy.. Valid values are `none|low|medium|high|critical`',
    `direct_reports_count` STRING COMMENT 'Number of positions that directly report to this position. Used for span-of-control analysis and organizational design.',
    `effective_from_date` DATE COMMENT 'Date from which this position record becomes active and valid in the organizational structure.',
    `effective_to_date` DATE COMMENT 'Date until which this position record is valid. Null for currently active positions with no planned end date.',
    `fifo_residential_split` STRING COMMENT 'Planned split of workforce between FIFO and residential arrangements for this position, expressed as a ratio (e.g., 70/30 means 70% FIFO, 30% residential). Used for accommodation and logistics planning.. Valid values are `^[0-9]{1,3}/[0-9]{1,3}$`',
    `grade_band` STRING COMMENT 'Salary grade and band classification for the position, used for compensation benchmarking and career progression. Format: Letter (A-E) followed by number (1-5).. Valid values are `^[A-E][1-5]$`',
    `headcount_budget` DECIMAL(18,2) COMMENT 'Approved full-time equivalent (FTE) headcount allocation for this position. May be fractional for part-time or shared roles (e.g., 0.5 FTE, 1.0 FTE).',
    `is_leadership_role` BOOLEAN COMMENT 'Flag indicating whether this position has direct reports and is classified as a leadership or management role. True if leadership; False otherwise.',
    `is_statutory_role` BOOLEAN COMMENT 'Flag indicating whether this position is a statutory or regulatory-required role under MSHA, state mining acts, or ISO 45001 (e.g., Mine Manager, Ventilation Officer, Explosives Controller). True if statutory; False otherwise.',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles together for workforce planning and career development purposes. [ENUM-REF-CANDIDATE: operations|processing|maintenance|geology|engineering|hse|supply_chain|finance|hr|it|corporate — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was last updated or modified.',
    `lom_alignment` STRING COMMENT 'Classification of the positions duration relative to the mines Life of Mine plan. LOM-aligned positions are tied to the mines operational lifespan; project-based positions are tied to specific capital projects.. Valid values are `permanent|lom_aligned|project_based|temporary`',
    `planned_headcount_fy` DECIMAL(18,2) COMMENT 'Planned full-time equivalent (FTE) headcount for this position in the current financial year, used for annual budget workforce modeling.',
    `planned_headcount_fy_plus_1` DECIMAL(18,2) COMMENT 'Planned full-time equivalent (FTE) headcount for this position in the next financial year (FY+1), used for multi-year workforce planning.',
    `planned_headcount_fy_plus_2` DECIMAL(18,2) COMMENT 'Planned full-time equivalent (FTE) headcount for this position two financial years ahead (FY+2), used for long-term workforce planning aligned with LOM.',
    `position_code` STRING COMMENT 'Business identifier for the position, typically used in SAP HR and workforce planning systems. Unique alphanumeric code assigned to each approved position.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_description` STRING COMMENT 'Detailed narrative description of the positions responsibilities, accountabilities, and key performance indicators. May reference formal position description documents.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position. Active: filled and operational; Vacant: approved but unfilled; Frozen: temporarily suspended; Planned: future position for LOM planning; Closed: permanently eliminated.. Valid values are `active|vacant|frozen|planned|closed`',
    `roster_pattern` STRING COMMENT 'Standard roster or shift pattern for the position (e.g., 2-weeks-on-1-week-off, 8-days-on-6-days-off, day-shift-only, 12-hour-rotating). Used for fatigue management and workforce planning.',
    `succession_plan_status` STRING COMMENT 'Current state of succession planning for this position. Critical for statutory roles and key leadership positions to ensure continuity.. Valid values are `no_plan|identified|in_development|ready_now`',
    `title` STRING COMMENT 'Official job title for the position as defined in the organizational structure (e.g., Mine Superintendent, Geologist, Maintenance Planner, HSE Coordinator).',
    `workforce_type` STRING COMMENT 'Classification of the workforce engagement model for this position. FIFO: Fly-In Fly-Out roster; Residential: permanent site-based.. Valid values are `employee|contractor|casual|fifo|residential`',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Organisational structure and position master defining the mine workforce hierarchy. Captures organisational units (departments, functions) with unit name, type, parent unit, cost centre mapping, site, and manager for all operational areas including mine operations, processing plant, maintenance, geology, HSE, and corporate functions. At position level captures position title, job family, grade band, reporting line, site location, department, cost centre, headcount budget, vacancy status, incumbent employee, and workforce planning attributes (planned headcount by period, FIFO vs residential split, contractor vs employee ratio, critical skills gaps, succession planning for statutory roles, LOM alignment). Serves as the SSOT for organisational hierarchy, approved positions, and workforce planning assumptions. Supports SAP HR organisational management and annual budget workforce modelling.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`roster` (
    `roster_id` BIGINT COMMENT 'Unique identifier for the roster pattern. Primary key.',
    `department_id` BIGINT COMMENT 'Identifier of the department or operational unit to which this roster pattern applies (e.g., Mining Operations, Processing, Maintenance, Geology). Links to the organizational structure.',
    `tenement_id` BIGINT COMMENT 'Identifier of the mine site or operational location where this roster pattern is applied. Links to the site master data.',
    `accommodation_type` STRING COMMENT 'Type of accommodation provided or required for workers on this roster pattern. Camp Single for individual camp rooms, Camp Shared for shared camp rooms, Hotel for commercial accommodation, Self-Arranged for worker-sourced accommodation, Not Applicable for residential rosters.. Valid values are `Camp Single|Camp Shared|Hotel|Self-Arranged|Not Applicable`',
    `allowance_code` STRING COMMENT 'Code identifying the standard allowance or loading applicable to this roster pattern (e.g., FIFO_ALLOW, REMOTE_ALLOW, SHIFT_LOAD). Links to payroll allowance master data for compensation calculations.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `annual_leave_accrual_rate` DECIMAL(18,2) COMMENT 'Rate at which annual leave accrues per day worked under this roster pattern, expressed as a decimal (e.g., 0.0833 for 1/12th of a day per day worked). Used for payroll integration and leave balance calculations.',
    `approval_date` DATE COMMENT 'Date on which this roster pattern was formally approved for use. Supports audit trail and compliance verification.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this roster pattern for operational use. Supports governance and accountability tracking.',
    `compliance_framework` STRING COMMENT 'Regulatory or industry framework governing this roster pattern (e.g., MSHA Part 46, ISO 45001, National Employment Standards Australia, Fair Work Act). Supports audit and compliance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this roster pattern record was first created in the system. Supports audit trail and data lineage tracking.',
    `cycle_length_days` STRING COMMENT 'Total number of days in one complete roster rotation cycle (e.g., 14 for an 8/6 roster, 21 for a 14/7 roster, 7 for a 4/3 roster). Used to calculate roster recurrence and workforce planning.',
    `days_off` STRING COMMENT 'Number of consecutive rest days in the roster cycle (e.g., 6 in an 8/6 roster, 7 in a 14/7 roster, 14 in a 28/14 roster).',
    `days_on` STRING COMMENT 'Number of consecutive working days in the roster cycle (e.g., 8 in an 8/6 roster, 14 in a 14/7 roster, 28 in a 28/14 roster).',
    `demobilisation_lead_time_days` STRING COMMENT 'Number of days required to demobilise workers from this roster pattern, including handover, travel arrangements, and exit procedures. Supports workforce transition planning.',
    `effective_from_date` DATE COMMENT 'Date from which this roster pattern becomes active and available for workforce scheduling. Supports temporal roster management and historical tracking.',
    `effective_to_date` DATE COMMENT 'Date until which this roster pattern remains active. Null indicates the roster is currently active with no planned end date. Supports roster lifecycle management and historical analysis.',
    `fatigue_risk_rating` STRING COMMENT 'Assessed fatigue risk level associated with this roster pattern based on shift length, consecutive days worked, and recovery time. Used for health and safety compliance and workforce wellbeing monitoring.. Valid values are `Low|Medium|High|Critical`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this roster pattern record was last updated. Supports change tracking and audit compliance.',
    `maximum_consecutive_shifts` STRING COMMENT 'Maximum number of consecutive shifts an employee can work under this roster pattern before mandatory rest, as defined by safety regulations and fatigue management policies.',
    `minimum_rest_hours` DECIMAL(18,2) COMMENT 'Minimum number of rest hours required between consecutive shifts under this roster pattern, ensuring compliance with occupational health and safety standards.',
    `mobilisation_lead_time_days` STRING COMMENT 'Number of days required to mobilise workers onto this roster pattern, including travel arrangements, accommodation booking, and induction scheduling. Critical for workforce planning and project ramp-up.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, or operational notes related to this roster pattern (e.g., Requires pre-approval for overtime, Seasonal roster for wet season operations, Pilot program for new shift pattern).',
    `overtime_eligibility_flag` BOOLEAN COMMENT 'Indicates whether workers on this roster pattern are eligible for overtime payments. True if overtime applies, False if roster includes all-in compensation or salary arrangements.',
    `roster_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the roster pattern (e.g., FIFO_8_6, DIDO_14_7, RES_4_3). Used for operational reference and system integration.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `roster_name` STRING COMMENT 'Full descriptive name of the roster pattern (e.g., Fly-In Fly-Out 8 Days On 6 Days Off, Drive-In Drive-Out 14/7 Day Shift, Residential 4 On 3 Off Continental).',
    `roster_status` STRING COMMENT 'Current lifecycle status of the roster pattern. Active indicates in use, Inactive indicates temporarily suspended, Pending indicates awaiting approval or implementation, Retired indicates permanently discontinued.. Valid values are `Active|Inactive|Pending|Retired`',
    `roster_type` STRING COMMENT 'Classification of the roster arrangement. FIFO (Fly-In Fly-Out) for air-transported workers, DIDO (Drive-In Drive-Out) for road-commuting workers, Residential for permanent on-site or local workers, Casual for irregular schedules, Contractor for third-party labor.. Valid values are `FIFO|DIDO|Residential|Casual|Contractor`',
    `shift_duration_hours` DECIMAL(18,2) COMMENT 'Standard duration of each shift in hours (e.g., 12.0 for twelve-hour shifts, 10.0 for ten-hour shifts, 8.0 for eight-hour shifts). Supports fatigue risk assessment and payroll calculations.',
    `shift_pattern` STRING COMMENT 'The shift rotation pattern within the roster cycle. Day Only for single day shifts, Night Only for single night shifts, Day-Night Rotating for alternating day/night, Continental for 12-hour rotating shifts, Split Shift for multiple shifts per day, Flexible for variable scheduling.. Valid values are `Day Only|Night Only|Day-Night Rotating|Continental|Split Shift|Flexible`',
    `transport_mode` STRING COMMENT 'Primary mode of transport used for worker mobilisation and demobilisation under this roster pattern. Charter Flight for dedicated aircraft, Commercial Flight for scheduled airlines, Bus for road transport, Private Vehicle for self-drive, Not Applicable for residential rosters.. Valid values are `Charter Flight|Commercial Flight|Bus|Private Vehicle|Not Applicable`',
    CONSTRAINT pk_roster PRIMARY KEY(`roster_id`)
) COMMENT 'Roster pattern master defining scheduled work rotation cycles used across mine operations including FIFO (fly-in fly-out), DIDO (drive-in drive-out), and residential arrangements. Captures roster name, cycle length (e.g. 8/6, 14/7, 28/14, 4/3), shift pattern (day-only, day-night rotating, continental), site, applicable department, fatigue risk rating, maximum consecutive shifts, and effective dates. Foundation for shift scheduling, fatigue management compliance, and mobilisation planning.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Unique identifier for the shift schedule record. Primary key for the shift schedule entity.',
    `crew_id` BIGINT COMMENT 'Reference to the designated crew or work team assigned to this shift.',
    `department_id` BIGINT COMMENT 'Reference to the operational department or functional area (e.g., drilling, haulage, processing, maintenance) for which this shift is scheduled.',
    `drill_program_id` BIGINT COMMENT 'Foreign key linking to exploration.drill_program. Business justification: Drilling shifts are scheduled to support specific drill programs for resource allocation, production tracking, and cost attribution. Essential for workforce planning and program progress monitoring.',
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that created this shift schedule record.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user or system account that last modified this shift schedule record.',
    `primary_shift_employee_id` BIGINT COMMENT 'Reference to the employee assigned as the shift supervisor or shift boss responsible for this shift.',
    `roster_id` BIGINT COMMENT 'Reference to the roster cycle or rotation pattern this shift belongs to (e.g., 4-on-3-off, 7-on-7-off, FIFO rotation).',
    `tenement_id` BIGINT COMMENT 'Reference to the mine site or operational location where this shift is scheduled.',
    `actual_headcount` STRING COMMENT 'Actual number of workers who reported for duty on this shift. Updated after shift commencement for attendance tracking.',
    `actual_production_tonnes` DECIMAL(18,2) COMMENT 'Actual production achieved during the shift measured in tonnes. Updated after shift completion for performance analysis.',
    `comments` STRING COMMENT 'Additional free-text comments or notes about the shift schedule, including special instructions, operational constraints, or administrative remarks.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this shift schedule record was first created in the system. Used for audit trail and data lineage.',
    `equipment_availability_percent` DECIMAL(18,2) COMMENT 'Percentage of planned equipment that was available and operational during the shift. Key metric for Overall Equipment Effectiveness (OEE) calculation.',
    `fatigue_override_approved` BOOLEAN COMMENT 'Indicates whether a fatigue management override has been approved by authorized personnel (True/False). Used when operational requirements necessitate deviation from standard fatigue limits.',
    `fatigue_risk_assessment_completed` BOOLEAN COMMENT 'Indicates whether fatigue risk assessment has been completed for this shift (True/False). Required for ISO 45001 fatigue management compliance.',
    `fatigue_risk_level` STRING COMMENT 'Assessed fatigue risk level for the shift based on roster patterns, consecutive shifts, and hours worked (low, moderate, high, critical).. Valid values are `low|moderate|high|critical`',
    `incident_count` STRING COMMENT 'Number of safety incidents, near-misses, or reportable events that occurred during the shift. Used for Lost Time Injury Frequency Rate (LTIFR) and Total Recordable Injury Frequency Rate (TRIFR) calculations.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this shift schedule record is currently active and valid (True) or has been logically deleted or superseded (False).',
    `last_modified_datetime` TIMESTAMP COMMENT 'Date and time when this shift schedule record was last updated. Used for audit trail and change tracking.',
    `payroll_integration_status` STRING COMMENT 'Status of shift hours integration with SAP HR payroll system (pending, submitted, approved, rejected, processed).. Valid values are `pending|submitted|approved|rejected|processed`',
    `payroll_submission_datetime` TIMESTAMP COMMENT 'Date and time when shift hours were submitted to the payroll system for processing.',
    `planned_headcount` STRING COMMENT 'Target number of workers planned to be assigned to this shift. Used for capacity planning and resource allocation.',
    `production_area` STRING COMMENT 'Specific production area, pit, underground level, or processing plant section where the shift crew will operate (e.g., North Pit, Level 5 West, Concentrator Plant 2).',
    `production_target_tonnes` DECIMAL(18,2) COMMENT 'Planned production target for the shift measured in tonnes of ore or material to be moved. Used for shift performance tracking.',
    `safety_briefing_completed` BOOLEAN COMMENT 'Indicates whether the mandatory pre-shift safety briefing has been completed (True/False). Required for MSHA and ISO 45001 compliance.',
    `safety_briefing_datetime` TIMESTAMP COMMENT 'Date and time when the pre-shift safety briefing was conducted. Required for regulatory compliance documentation.',
    `scheduled_duration_hours` DECIMAL(18,2) COMMENT 'Planned duration of the shift in hours (e.g., 8.00, 10.00, 12.00). Used for shift planning and fatigue management calculations.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned end date and time for the shift in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned start date and time for the shift in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `shift_handover_notes` STRING COMMENT 'Free-text notes documenting key information to be handed over from the previous shift or to the next shift (equipment status, incidents, production issues, safety concerns).',
    `shift_number` STRING COMMENT 'Business identifier for the shift schedule, typically a human-readable shift number or code used operationally (e.g., DAY-001, NIGHT-045).',
    `shift_priority` STRING COMMENT 'Priority classification of the shift based on operational criticality (critical, high, normal, low). Used for resource allocation and contingency planning.. Valid values are `critical|high|normal|low`',
    `shift_status` STRING COMMENT 'Current lifecycle status of the shift schedule (draft, scheduled, confirmed, in_progress, completed, cancelled, suspended). [ENUM-REF-CANDIDATE: draft|scheduled|confirmed|in_progress|completed|cancelled|suspended — 7 candidates stripped; promote to reference product]',
    `shift_type` STRING COMMENT 'Classification of the shift based on time of day or rotation pattern (day, night, afternoon, swing, rotating).. Valid values are `day|night|afternoon|swing|rotating`',
    `weather_condition` STRING COMMENT 'Recorded or forecasted weather conditions relevant to the shift (e.g., clear, rain, high wind, extreme heat). Important for open-pit operations and safety planning.',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Shift schedule header and individual worker-to-shift assignment records for mine operations. Header captures scheduled start/end datetime, shift type (day/night/afternoon), crew designation, site location, department, planned headcount, and roster cycle reference. Assignment detail lines capture individual employee or contractor assignment to the shift including assignment status (scheduled, confirmed, swapped, absent), role on shift, crew, actual start/end times, hours worked, overtime flag, and fatigue management override approvals. Serves as both the operational shift plan and the transactional time-and-attendance record of who worked when. Supports fatigue risk management per ISO 45001, MSHA compliance, and payroll hours integration.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`fatigue_record` (
    `fatigue_record_id` BIGINT COMMENT 'Primary key for fatigue_record',
    `incident_id` BIGINT COMMENT 'Identifier of the HSE incident that triggered this fatigue assessment, if applicable (for post-incident assessments).',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor being assessed for fatigue risk.',
    `roster_id` BIGINT COMMENT 'Identifier of the roster cycle (e.g., 14 days on / 7 days off) within which this assessment occurred.',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the shift assignment for which the fatigue assessment was conducted.',
    `assessment_datetime` TIMESTAMP COMMENT 'Date and time when the fatigue risk assessment was conducted.',
    `assessment_location` STRING COMMENT 'Physical location where the fatigue assessment was conducted (e.g., mine gate, pre-start area, occupational health clinic, control room).',
    `assessment_method` STRING COMMENT 'Method or tool used to assess fatigue risk, such as Fatigue Risk Management System (FRMS), biomathematical modeling, self-report questionnaire, supervisor observation, fitness for work testing, or actigraphy device.. Valid values are `FRMS|Biomathematical Model|Self-Report|Supervisor Observation|Fitness for Work Test|Actigraphy`',
    `assessment_outcome` STRING COMMENT 'Outcome of the fatigue assessment determining the workers fitness status: Fit for Work, Unfit for Work, Restricted Duties, or Referred for Medical Review.. Valid values are `Fit for Work|Unfit for Work|Restricted Duties|Referred for Medical Review`',
    `assessment_trigger` STRING COMMENT 'Event or condition that triggered the fatigue assessment: Scheduled Pre-Start, Random Check, Supervisor Concern, Self-Report, Post-Incident, or Extended Hours Threshold.. Valid values are `Scheduled Pre-Start|Random Check|Supervisor Concern|Self-Report|Post-Incident|Extended Hours Threshold`',
    `compliance_status` STRING COMMENT 'Indicates whether the workers fatigue status is compliant with regulatory and company fatigue management policies: Compliant, Non-Compliant, or Exemption Granted.. Valid values are `Compliant|Non-Compliant|Exemption Granted`',
    `consecutive_days_on_site` STRING COMMENT 'Number of consecutive days the worker has been on-site without a rest day, used to assess cumulative fatigue risk.',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions taken in response to the fatigue assessment, such as mandatory rest period, shift reassignment, transportation to accommodation, or referral to occupational health services.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fatigue assessment record was first created in the system.',
    `cumulative_hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours worked by the individual over the assessment period (typically 7, 14, or 28 days) leading up to the assessment.',
    `exemption_approved_by` BIGINT COMMENT 'Identifier of the manager or authority who approved the fatigue policy exemption.',
    `exemption_reason` STRING COMMENT 'Justification for granting an exemption to fatigue management policy (e.g., emergency response, critical maintenance, senior management approval).',
    `fatigue_risk_level` STRING COMMENT 'Categorical classification of fatigue risk level based on the risk score: Low, Moderate, High, or Severe.. Valid values are `Low|Moderate|High|Severe`',
    `fatigue_risk_score` DECIMAL(18,2) COMMENT 'Quantitative fatigue risk score calculated by the assessment method, typically on a scale (e.g., 0-100) where higher values indicate greater fatigue risk.',
    `follow_up_due_datetime` TIMESTAMP COMMENT 'Scheduled date and time for the required follow-up assessment or medical review.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up fatigue assessment or medical review is required based on this assessment outcome.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fatigue assessment record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text notes recorded by the assessor regarding observations, worker comments, or contextual information relevant to the fatigue assessment.',
    `previous_assessment_datetime` TIMESTAMP COMMENT 'Date and time of the most recent prior fatigue assessment for this worker, used to track assessment frequency and trend analysis.',
    `previous_fatigue_risk_score` DECIMAL(18,2) COMMENT 'Fatigue risk score from the most recent prior assessment, enabling trend comparison.',
    `sleep_opportunity_hours` DECIMAL(18,2) COMMENT 'Estimated or reported hours of sleep opportunity available to the worker in the 24-hour period prior to assessment.',
    `time_of_day_category` STRING COMMENT 'Classification of the time of day when the assessment occurred, relevant for circadian rhythm considerations (Day Shift, Night Shift, Swing Shift, Circadian Low Point).. Valid values are `Day Shift|Night Shift|Swing Shift|Circadian Low Point`',
    `work_restriction_description` STRING COMMENT 'Description of any work restrictions or limitations imposed as a result of the fatigue assessment (e.g., no heavy equipment operation, reduced shift length, mandatory rest break).',
    CONSTRAINT pk_fatigue_record PRIMARY KEY(`fatigue_record_id`)
) COMMENT 'Fatigue risk assessment record for individual workers capturing cumulative hours worked, days on-site, sleep opportunity hours, fatigue risk score, assessment method (Fatigue Risk Management System - FRMS), assessor, assessment datetime, outcome (fit/unfit/restricted), and any corrective actions taken. Supports ISO 45001 and MSHA fatigue management compliance.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`competency` (
    `competency_id` BIGINT COMMENT 'Unique identifier for the competency record. Serves as the primary key for both framework-level competency definitions and individual worker attainment records.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee or contractor who conducted the competency assessment. Null for third-party certifications or framework definitions.',
    `competency_employee_id` BIGINT COMMENT 'Foreign key reference to the individual employee or contractor who holds this competency attainment. Null for framework-level competency definitions that are not yet attained by any worker.',
    `tenement_id` BIGINT COMMENT 'Foreign key reference to the mine site for which this competency attainment is valid. Null for portable competencies or framework definitions.',
    `applicable_role` STRING COMMENT 'The job role, position, or position family to which this competency applies (e.g., Haul Truck Operator, Shotfirer, Surface Supervisor, Mill Operator). May be a comma-separated list for competencies applicable to multiple roles.',
    `assessment_method` STRING COMMENT 'The method by which the worker was assessed for this competency: written_exam, practical_assessment, on_job_observation, simulation, portfolio (evidence-based), interview, third_party_certification (external body). [ENUM-REF-CANDIDATE: written_exam|practical_assessment|on_job_observation|simulation|portfolio|interview|third_party_certification — 7 candidates stripped; promote to reference product]',
    `assessment_score` DECIMAL(18,2) COMMENT 'The numeric score or result achieved in the competency assessment (e.g., exam percentage, practical assessment grade). Null for pass/fail assessments without numeric scoring.',
    `attainment_date` DATE COMMENT 'The date on which the worker successfully attained or was awarded this competency. Null for framework-level definitions.',
    `attainment_status` STRING COMMENT 'Current lifecycle status of the competency attainment: current (valid and in-date), expiring_soon (within alert threshold), expired (past expiry_date), suspended (temporarily invalid), revoked (permanently withdrawn), pending_renewal (renewal in progress).. Valid values are `current|expiring_soon|expired|suspended|revoked|pending_renewal`',
    `certificate_number` STRING COMMENT 'The unique certificate, ticket, or license number issued by the governing body or training provider as evidence of competency attainment. Critical for statutory ticket tracking and MSHA compliance.',
    `competency_category` STRING COMMENT 'Hierarchical grouping or discipline area for the competency (e.g., Mining Operations, Processing, Maintenance, HSE, Geology, Engineering). Supports competency framework navigation and gap analysis reporting.',
    `competency_code` STRING COMMENT 'Unique business identifier for the competency. Used for external reference and integration with training systems, MSHA reporting, and SAP HR competency catalogs.. Valid values are `^[A-Z0-9]{4,20}$`',
    `competency_name` STRING COMMENT 'Full descriptive name of the competency (e.g., Shotfirer Certificate, Surface Supervisor Examination, Haul Truck Operation Level 3, First Aid CPR).',
    `competency_type` STRING COMMENT 'Classification of the competency by purpose: statutory (legally mandated certificates), operational (production skills), safety (HSE training), technical (specialized equipment or process), leadership (supervisory), environmental (environmental management).. Valid values are `statutory|operational|safety|technical|leadership|environmental`',
    `cost_per_attainment` DECIMAL(18,2) COMMENT 'The total cost incurred to attain this competency, including training fees, assessor costs, travel, and lost production time. Used for training budget planning and OPEX allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this competency record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost_per_attainment (e.g., USD, AUD, CAD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `evidence_reference` STRING COMMENT 'Reference to the supporting evidence or documentation for this competency attainment (e.g., file path, document management system ID, training record reference). Supports audit and compliance verification.',
    `expiry_alert_days` STRING COMMENT 'The number of days before expiry_date at which an alert should be triggered to initiate renewal. Supports proactive competency management and compliance risk mitigation.',
    `expiry_date` DATE COMMENT 'The date on which this competency attainment expires and must be renewed. Calculated from attainment_date + validity_period_months. Null for lifetime competencies or framework definitions.',
    `governing_body` STRING COMMENT 'The regulatory authority, industry body, or certification organization that defines or mandates this competency (e.g., MSHA, State Mining Inspectorate, ICMM, internal company standard). Critical for statutory competency tracking.',
    `issuing_body` STRING COMMENT 'The organization or authority that issued the certificate or credential (e.g., State Mining Inspectorate, MSHA, Registered Training Organization, internal company training department).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this competency record was last updated. Supports change tracking and audit trail for competency lifecycle management.',
    `last_verification_date` DATE COMMENT 'The date on which this competency attainment was last verified or audited for currency and validity. Supports periodic competency audits and ISO 45001 compliance.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this competency is mandatory for the applicable role (True) or optional/recommended (False). Mandatory competencies trigger compliance alerts if not held.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to this competency or attainment (e.g., restrictions, exemptions, special arrangements).',
    `pass_threshold` DECIMAL(18,2) COMMENT 'The minimum score or threshold required to pass the competency assessment. Used to determine attainment success and identify workers requiring reassessment.',
    `prerequisite_competencies` STRING COMMENT 'Comma-separated list of competency codes or IDs that must be held before this competency can be attained. Supports competency pathway modeling and training sequencing.',
    `renewal_method` STRING COMMENT 'The method by which the competency is renewed: reassessment (full practical reassessment), refresher_training (attend training course), continuing_education (accumulate CPD points), reexamination (written or practical exam), automatic (no action required).. Valid values are `reassessment|refresher_training|continuing_education|reexamination|automatic`',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the competency must be renewed or reassessed upon expiry (True) or is a one-time attainment (False).',
    `required_proficiency_level` STRING COMMENT 'The minimum proficiency or mastery level required for the competency: awareness (general understanding), basic (can perform with supervision), intermediate (can perform independently), advanced (can train others), expert (subject matter expert).. Valid values are `awareness|basic|intermediate|advanced|expert`',
    `site_specific_flag` BOOLEAN COMMENT 'Indicates whether this competency is specific to a particular mine site (True) or is portable across all company sites (False). Site-specific competencies require retraining on site transfer.',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'The total number of training hours completed to attain this competency. Used for MSHA annual training hour reporting and training cost allocation.',
    `training_provider` STRING COMMENT 'The name of the training organization, Registered Training Organization (RTO), or internal training department that delivered the training leading to this competency attainment.',
    `validity_period_months` STRING COMMENT 'The number of months for which the competency remains valid once attained. Null indicates no expiry (lifetime competency). Used to calculate expiry dates and trigger renewal alerts.',
    `verified_by` BIGINT COMMENT 'Foreign key reference to the employee who conducted the last verification or audit of this competency attainment.',
    CONSTRAINT pk_competency PRIMARY KEY(`competency_id`)
) COMMENT 'Competency framework master and individual worker attainment records for the mine workforce. Framework level defines competency name, type (statutory, operational, safety, technical), applicable role/position, required proficiency level, governing body (MSHA, state mining regulator), validity period, and renewal requirements. Attainment detail records capture individual employee or contractor competency holdings including attainment date, expiry date, assessment method, assessor, certificate number, issuing body, current status (current, expiring, expired, suspended), and evidence reference. Serves as the SSOT for both what competencies exist and who holds them. Supports MSHA statutory ticket tracking (shotfirer, SSE, OCE), competency gap analysis, expiry alerting, and ISO 45001 training compliance.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Unique identifier for the training course record. Primary key.',
    `approval_date` DATE COMMENT 'Date when the training course was formally approved for delivery. Used for audit trails and compliance documentation.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this training course for inclusion in the catalogue. Typically a training manager, HSE manager, or competent person.',
    `assessment_method` STRING COMMENT 'Method used to assess participant competency upon course completion. Written exam is theory-based testing; practical demonstration is hands-on skill assessment; simulation uses equipment simulators; observation is workplace-based assessment; portfolio is evidence-based review; none indicates no formal assessment.. Valid values are `written_exam|practical_demonstration|simulation|observation|portfolio|none`',
    `certificate_validity_period_months` STRING COMMENT 'Number of months that the certification remains valid before refresher or recertification training is required. Used to trigger training renewal notifications and maintain compliance. Nullable for courses with no expiry.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether successful completion of this course results in a formal certificate or credential being issued to the participant. True for statutory, regulatory, and competency-based training.',
    `competency_framework_code` STRING COMMENT 'Code linking this training course to the organizational competency framework or national qualifications framework. Used to map training outcomes to required competencies for roles and positions.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Standard cost charged per participant for delivery of this training course. Includes instructor fees, materials, facility hire, and assessment costs. Used for training budget planning and cost allocation.',
    `course_category` STRING COMMENT 'High-level classification of the training course type. Induction covers site orientation and onboarding; safety statutory includes MSHA-mandated and regulatory training; equipment operation covers mobile equipment and machinery; technical skills includes trade and specialist competencies; leadership covers supervisory and management development; compliance includes HSE and legal requirements; emergency response covers first aid and crisis management. [ENUM-REF-CANDIDATE: induction|safety_statutory|equipment_operation|technical_skills|leadership|compliance|emergency_response — 7 candidates stripped; promote to reference product]',
    `course_code` STRING COMMENT 'Unique alphanumeric code assigned to the training course for identification and scheduling purposes. Used across training management systems and employee records.. Valid values are `^[A-Z0-9]{4,12}$`',
    `course_content_summary` STRING COMMENT 'High-level summary of the topics, modules, and learning outcomes covered in the training course. Used for course selection, training needs analysis, and compliance documentation.',
    `course_materials_provided` STRING COMMENT 'Description of training materials, resources, and equipment provided to participants, such as manuals, workbooks, personal protective equipment, or access to online learning platforms.',
    `course_name` STRING COMMENT 'Full descriptive name of the training course as it appears in the training catalogue and on certificates.',
    `course_status` STRING COMMENT 'Current lifecycle status of the training course in the catalogue. Active courses are available for scheduling; inactive courses are temporarily unavailable; under review courses are being updated or audited; retired courses are no longer offered; pending approval courses are awaiting accreditation or management sign-off.. Valid values are `active|inactive|under_review|retired|pending_approval`',
    `course_type` STRING COMMENT 'Indicates whether the course is an initial qualification, periodic refresher, mandatory recertification, advanced level, or specialized competency training.. Valid values are `initial|refresher|recertification|advanced|specialized`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training course record was first created in the system. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per participant. Used for multi-currency training budgets and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_mode` STRING COMMENT 'Method by which the training is delivered. Classroom is instructor-led in-person; online is e-learning or virtual; blended combines classroom and online; on-the-job is workplace-based practical training; simulation uses equipment simulators; field practical is hands-on training at operational sites.. Valid values are `classroom|online|blended|on_the_job|simulation|field_practical`',
    `duration_days` DECIMAL(18,2) COMMENT 'Total duration of the training course measured in working days. Used for multi-day courses and workforce planning. Nullable for courses under one day.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training course measured in hours, including classroom time, practical exercises, and assessments. Used for scheduling, resource planning, and MSHA compliance reporting.',
    `effective_from_date` DATE COMMENT 'Date from which this training course becomes available in the catalogue and can be scheduled for delivery. Used for version control and regulatory compliance tracking.',
    `effective_to_date` DATE COMMENT 'Date on which this training course is retired or superseded by a new version. Nullable for courses with no planned end date. Used for training record integrity and historical reporting.',
    `iso_45001_compliance_flag` BOOLEAN COMMENT 'Indicates whether this course supports ISO 45001 Occupational Health and Safety Management System requirements for worker competence, awareness, and participation. True for courses aligned with ISO 45001 clauses 7.2 and 7.3.',
    `language_of_delivery` STRING COMMENT 'Primary language in which the training course is delivered, using ISO 639-3 three-letter language codes. Used for workforce planning and ensuring training accessibility for diverse workforces.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training course record was last updated. Used for change tracking, audit trails, and data quality monitoring.',
    `last_review_date` DATE COMMENT 'Date when the training course content, delivery method, and effectiveness were last reviewed and validated. Used to ensure training remains current with regulations, technology, and operational practices.',
    `learning_objectives` STRING COMMENT 'Specific, measurable learning objectives that participants will achieve upon successful completion of the training course. Used for competency mapping and training effectiveness evaluation.',
    `linked_competencies` STRING COMMENT 'Comma-separated list of competency codes or identifiers that this training course develops or certifies. Used to track which competencies are satisfied upon successful course completion.',
    `maximum_participants` STRING COMMENT 'Maximum number of participants that can be enrolled in a single delivery of this training course. Determined by classroom capacity, equipment availability, or instructor-to-student ratio requirements.',
    `msha_compliance_flag` BOOLEAN COMMENT 'Indicates whether this course satisfies MSHA Part 48 training requirements for new miner training, annual refresher training, or task training. True for courses that meet MSHA standards and are reported to MSHA.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next periodic review of the training course. Used to trigger course audits, content updates, and compliance verification.',
    `pass_mark_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required to successfully complete the training course and receive certification. Nullable for courses without formal assessment.',
    `prerequisite_courses` STRING COMMENT 'Comma-separated list of course codes that must be completed before a worker can enroll in this training course. Used to enforce training pathways and competency progression.',
    `provider_accreditation_number` STRING COMMENT 'Official accreditation or registration number of the training provider issued by relevant regulatory or industry body. Required for statutory and compliance training courses.',
    `provider_name` STRING COMMENT 'Name of the organization or entity delivering the training course. May be internal training department, external Registered Training Organization (RTO), equipment manufacturer, or industry association.',
    `refresher_required_flag` BOOLEAN COMMENT 'Indicates whether periodic refresher training is required to maintain competency or certification. True for MSHA annual refresher, first aid recertification, and time-limited competencies.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this training course is mandated by mining regulations, occupational health and safety law, or industry standards. True for MSHA Part 48 training, statutory safety training, and ISO 45001 required competencies.',
    `target_audience` STRING COMMENT 'Description of the intended participants for this training course, such as new hires, equipment operators, supervisors, contractors, or specific job roles. Used for course assignment and workforce planning.',
    `version_number` STRING COMMENT 'Version identifier for the training course content and curriculum. Incremented when course materials, learning objectives, or assessment methods are updated. Used for training record accuracy and audit trails.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Training course catalogue defining all available training programs for mine workforce including induction, statutory safety training, equipment operation, first aid, and technical skills. Captures course name, course code, delivery mode (classroom, online, on-the-job), duration, provider, linked competencies, regulatory requirement flag, and MSHA/ISO 45001 compliance mapping.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`training_enrolment` (
    `training_enrolment_id` BIGINT COMMENT 'Unique identifier for the training enrolment record. Primary key for the training enrolment entity.',
    `previous_enrolment_training_enrolment_id` BIGINT COMMENT 'Identifier of the previous training enrolment record that this refresher training is renewing or updating.',
    `employee_id` BIGINT COMMENT 'Identifier of the worker enrolled in the training. Links to the worker master record.',
    `tenement_id` BIGINT COMMENT 'Identifier of the mine site where the training or induction was conducted.',
    `tertiary_training_assessor_employee_id` BIGINT COMMENT 'Identifier of the assessor who evaluated the workers competency.',
    `training_course_id` BIGINT COMMENT 'Identifier of the training course or program. Links to the training course catalog.',
    `access_clearance_date` DATE COMMENT 'Date when site or area access clearance was granted to the worker following induction completion.',
    `access_clearance_granted_flag` BOOLEAN COMMENT 'Indicates whether site or area access clearance was granted to the worker upon successful completion of the induction.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved by the worker in the training assessment, typically as a percentage.',
    `attendance_percentage` DECIMAL(18,2) COMMENT 'Percentage of training sessions attended by the worker, calculated as attended hours divided by required hours.',
    `certificate_expiry_date` DATE COMMENT 'Date when the training certificate expires and requires renewal or refresher training.',
    `certificate_issue_date` DATE COMMENT 'Date when the training certificate was issued to the worker.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a training certificate was issued to the worker upon successful completion.',
    `certificate_number` STRING COMMENT 'Unique reference number of the training certificate issued to the worker.',
    `competency_level_achieved` STRING COMMENT 'Level of competency achieved by the worker upon completion of the training.. Valid values are `foundation|intermediate|advanced|expert|not_achieved`',
    `completion_date` DATE COMMENT 'Date when the worker completed the training course or induction.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this training enrolment, including course fees, materials, and travel expenses.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training enrolment record was first created in the system.',
    `delivery_location` STRING COMMENT 'Physical or virtual location where the training was delivered (site name, training center, online platform).',
    `delivery_method` STRING COMMENT 'Method or format used to deliver the training to the worker.. Valid values are `classroom|online|on_the_job|blended|simulation|field_demonstration`',
    `enrolment_date` DATE COMMENT 'Date when the worker was enrolled in the training course.',
    `enrolment_status` STRING COMMENT 'Current status of the training enrolment in its lifecycle.. Valid values are `enrolled|in_progress|completed|withdrawn|failed|expired`',
    `induction_modules_completed` STRING COMMENT 'Comma-separated list or description of specific induction modules completed by the worker.',
    `induction_type` STRING COMMENT 'Type of site induction completed by the worker, categorizing the scope and level of access granted.. Valid values are `site_general|area_specific|task_specific|contractor|visitor|emergency_response`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training enrolment record was last updated or modified in the system.',
    `mandatory_training_flag` BOOLEAN COMMENT 'Indicates whether this training is mandatory for the workers role or site access under regulatory or company policy.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations recorded by the trainer, assessor, or training coordinator regarding this enrolment.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training assessment, typically as a percentage.',
    `refresher_training_flag` BOOLEAN COMMENT 'Indicates whether this enrolment is for refresher or recertification training rather than initial training.',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory requirement or standard that this training fulfills (e.g., MSHA Part 46, MSHA Part 48, ISO 45001).',
    `scheduled_training_date` DATE COMMENT 'Scheduled date for the training session or course commencement.',
    `training_hours_completed` DECIMAL(18,2) COMMENT 'Total number of training hours completed by the worker for this enrolment.',
    `training_hours_required` DECIMAL(18,2) COMMENT 'Total number of training hours required to complete the course or meet regulatory requirements.',
    `training_outcome` STRING COMMENT 'Final outcome or result of the training assessment.. Valid values are `pass|fail|incomplete|not_assessed|withdrawn`',
    `training_provider` STRING COMMENT 'Name of the organization or entity that provided the training (internal department, external training company, contractor).',
    CONSTRAINT pk_training_enrolment PRIMARY KEY(`training_enrolment_id`)
) COMMENT 'Training enrolment, completion, and site/role induction record for individual workers. Captures enrolment date, scheduled training date, completion date, training outcome (pass/fail/incomplete), score, trainer/assessor, delivery location, hours completed, certificate issued flag, and for inductions: induction type (site general, area-specific, task-specific, contractor), modules completed, and induction certificate reference. Covers all training events from formal courses through mandatory pre-access site inductions required under MSHA Part 46/48 and state mining regulations. Provides the transactional audit trail for training compliance, induction verification at site access gates, and ISO 45001 workforce competency requirements.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`medical_fitness` (
    `medical_fitness_id` BIGINT COMMENT 'Unique identifier for the occupational health and medical fitness assessment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the mine worker or contractor undergoing the medical fitness assessment.',
    `tenement_id` BIGINT COMMENT 'Identifier of the mine site or operational location to which this medical fitness assessment applies.',
    `assessment_date` DATE COMMENT 'Date on which the medical fitness assessment was conducted.',
    `assessment_location` STRING COMMENT 'Location where the medical fitness assessment was conducted (on-site clinic, off-site facility, mobile unit, or remote telehealth).. Valid values are `on-site-clinic|off-site-facility|mobile-unit|remote-telehealth`',
    `assessment_time` TIMESTAMP COMMENT 'Precise date and time when the medical fitness assessment was performed.',
    `assessment_type` STRING COMMENT 'Type of medical fitness assessment conducted (pre-employment, periodic, return-to-work, task-specific, drug and alcohol screening, or exit examination).. Valid values are `pre-employment|periodic|return-to-work|task-specific|drug-alcohol-screening|exit`',
    `audiogram_baseline_established` BOOLEAN COMMENT 'Indicates whether this assessment established a baseline audiogram for future noise-induced hearing loss comparisons.',
    `biological_markers_tested` STRING COMMENT 'List of biological markers or substances tested during biological monitoring (e.g., blood lead level, urinary arsenic, silica exposure markers).',
    `biological_monitoring_conducted` BOOLEAN COMMENT 'Indicates whether biological monitoring for occupational exposure to hazardous substances (e.g., heavy metals, silica) was conducted.',
    `biological_monitoring_result` STRING COMMENT 'Result of biological monitoring for occupational exposure (within limits, elevated, action level exceeded, or medical removal required).. Valid values are `within-limits|elevated|action-level-exceeded|medical-removal-required`',
    `certificate_expiry_date` DATE COMMENT 'Expiry date of the medical clearance certificate, after which a new assessment is required.',
    `certificate_number` STRING COMMENT 'Unique reference number of the medical clearance certificate issued to the worker.',
    `compliance_status` STRING COMMENT 'Compliance status of the medical fitness assessment with MSHA and ISO 45001 requirements (compliant, non-compliant, pending, or exemption granted).. Valid values are `compliant|non-compliant|pending|exemption-granted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this medical fitness assessment record was first created in the system.',
    `drug_alcohol_test_conducted` BOOLEAN COMMENT 'Indicates whether a drug and alcohol screening test was conducted as part of this assessment.',
    `drug_alcohol_test_datetime` TIMESTAMP COMMENT 'Date and time when the drug and alcohol screening test sample was collected.',
    `drug_alcohol_test_method` STRING COMMENT 'Method used for drug and alcohol testing (urine, breath, saliva, blood, or hair follicle analysis).. Valid values are `urine|breath|saliva|blood|hair-follicle`',
    `drug_alcohol_test_result` STRING COMMENT 'Result of the drug and alcohol screening test (negative, positive, inconclusive, refused, or not tested).. Valid values are `negative|positive|inconclusive|refused|not-tested`',
    `examining_physician_name` STRING COMMENT 'Full name of the occupational health physician or medical practitioner who conducted the assessment.',
    `exemption_approved_by` STRING COMMENT 'Name or identifier of the authority who approved the medical fitness exemption.',
    `exemption_reason` STRING COMMENT 'Reason for exemption from standard medical fitness requirements if an exemption was granted.',
    `fitness_outcome` STRING COMMENT 'Overall medical fitness determination outcome (fit, fit with restrictions, temporarily unfit, permanently unfit, or pending review).. Valid values are `fit|fit-with-restrictions|temporarily-unfit|permanently-unfit|pending-review`',
    `fitness_outcome_date` DATE COMMENT 'Date on which the fitness outcome determination was finalized and communicated.',
    `follow_up_due_date` DATE COMMENT 'Date by which the required follow-up medical assessment or testing must be completed.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether follow-up medical assessment, specialist referral, or additional testing is required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this medical fitness assessment record was last modified or updated.',
    `medical_clearance_certificate_issued` BOOLEAN COMMENT 'Indicates whether a formal medical clearance certificate was issued to the worker following the assessment.',
    `medical_facility_name` STRING COMMENT 'Name of the medical facility, clinic, or occupational health center where the assessment was conducted.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic medical fitness review or reassessment.',
    `nihl_monitoring_conducted` BOOLEAN COMMENT 'Indicates whether noise-induced hearing loss audiometric monitoring was conducted as part of this assessment.',
    `nihl_monitoring_result` STRING COMMENT 'Result of the noise-induced hearing loss audiometric monitoring (normal, threshold shift detected, significant hearing loss, or follow-up required).. Valid values are `normal|threshold-shift-detected|significant-hearing-loss|follow-up-required`',
    `notes` STRING COMMENT 'Additional notes, observations, or comments recorded by the examining physician during the medical fitness assessment.',
    `respiratory_function_result` STRING COMMENT 'Result of respiratory function testing (normal, mild impairment, moderate impairment, severe impairment, or follow-up required).. Valid values are `normal|mild-impairment|moderate-impairment|severe-impairment|follow-up-required`',
    `respiratory_function_test_conducted` BOOLEAN COMMENT 'Indicates whether respiratory function testing (spirometry) was conducted to assess lung capacity and detect occupational lung disease.',
    `restricted_tasks` STRING COMMENT 'Specific mining tasks or activities that the worker is restricted from performing based on the medical assessment.',
    `restriction_category` STRING COMMENT 'Category of work restriction imposed if the worker is deemed fit with restrictions (physical limitation, environmental restriction, task restriction, equipment restriction, or none).. Valid values are `physical-limitation|environmental-restriction|task-restriction|equipment-restriction|none`',
    `restriction_details` STRING COMMENT 'Detailed description of specific work restrictions, limitations, or accommodations required for the worker to perform duties safely.',
    `review_frequency_months` STRING COMMENT 'Frequency in months at which periodic medical fitness reviews are required for this worker based on role, age, or health status.',
    `substances_detected` STRING COMMENT 'List of substances detected in the drug and alcohol screening test if result was positive.',
    `vision_test_conducted` BOOLEAN COMMENT 'Indicates whether vision testing was conducted to assess visual acuity and fitness for safety-critical tasks.',
    `vision_test_result` STRING COMMENT 'Result of vision testing (meets standard, corrective lenses required, does not meet standard, or follow-up required).. Valid values are `meets-standard|corrective-lenses-required|does-not-meet-standard|follow-up-required`',
    CONSTRAINT pk_medical_fitness PRIMARY KEY(`medical_fitness_id`)
) COMMENT 'Occupational health and medical fitness assessment record for mine workers including drug and alcohol (D&A) testing. Captures assessment type (pre-employment, periodic, return-to-work, task-specific, drug/alcohol screening), assessment date, examining physician, fitness outcome (fit/fit with restrictions/unfit), restriction details, next review date, D&A test result and method, noise-induced hearing loss (NIHL) monitoring status, and biological monitoring results. Supports MSHA medical surveillance, site D&A testing programs, and ISO 45001 health monitoring requirements.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Unique identifier for the payroll processing record. Primary key for the payroll record entity.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Payroll costs are the largest component of Mining OPEX and must be allocated to cost centres for financial reporting, AISC calculation, management accounting, and budget variance analysis. Payroll_rec',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor for whom this payroll record was generated. Links to the worker master data in the workforce domain.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll record was approved for payment. Critical audit field for payroll governance.',
    `approved_by` STRING COMMENT 'The name or identifier of the payroll officer or manager who approved this payroll record for payment. Used for audit and accountability purposes.',
    `bank_account_number` STRING COMMENT 'The employees bank account number to which net pay is transferred via electronic funds transfer. Confidential financial information.. Valid values are `^[0-9]{6,20}$`',
    `bank_bsb_code` STRING COMMENT 'The six-digit BSB code identifying the bank branch for electronic funds transfer. Used in Australian banking systems.. Valid values are `^[0-9]{6}$`',
    `base_pay_amount` DECIMAL(18,2) COMMENT 'The base salary or wage amount for the pay period, excluding allowances, overtime, and other variable pay components. Calculated based on contracted hours and hourly or annual rate.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Discretionary or performance-based bonus payment included in this payroll record. May include safety bonuses, production bonuses, or annual incentive payments.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll record was first created in the system. Audit field for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payroll record (e.g., AUD for Australian Dollar, USD for US Dollar).. Valid values are `^[A-Z]{3}$`',
    `fifo_allowance_amount` DECIMAL(18,2) COMMENT 'Allowance paid to workers on FIFO rosters to compensate for travel and time away from home. Common in remote mining operations.',
    `garnishment_amount` DECIMAL(18,2) COMMENT 'Court-ordered or statutory deduction from the employees pay for child support, debt repayment, or other legal obligations.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total gross pay for the pay period, calculated as the sum of base pay, all allowances, overtime, bonuses, and other earnings before any deductions.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total number of regular hours worked during the pay period, excluding overtime. Used as the basis for base pay calculation for hourly workers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll record was last updated or modified. Audit field for change tracking and data lineage.',
    `leading_hand_allowance_amount` DECIMAL(18,2) COMMENT 'Additional allowance paid to workers in supervisory or leading hand roles who coordinate small teams or work groups.',
    `leave_hours_paid` DECIMAL(18,2) COMMENT 'Total number of leave hours paid during the pay period, including annual leave, sick leave, and other paid time off.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'The final take-home pay amount for the employee, calculated as gross pay minus total deductions. This is the amount paid to the employee.',
    `notes` STRING COMMENT 'Free-text field for payroll officers to record notes, exceptions, adjustments, or special circumstances related to this payroll record.',
    `other_deductions_amount` DECIMAL(18,2) COMMENT 'Sum of all other voluntary or mandatory deductions not otherwise categorized, such as health insurance premiums, salary sacrifice arrangements, or loan repayments.',
    `overtime_amount` DECIMAL(18,2) COMMENT 'Total overtime pay calculated for the pay period based on overtime hours worked and applicable overtime rates.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total number of overtime hours worked during the pay period, eligible for overtime pay rates (typically time-and-a-half or double-time).',
    `pay_period_end_date` DATE COMMENT 'The last date of the pay period covered by this payroll record. Defines the end of the earnings calculation window.',
    `pay_period_start_date` DATE COMMENT 'The first date of the pay period covered by this payroll record. Defines the beginning of the earnings calculation window.',
    `pay_run_reference` STRING COMMENT 'Unique reference number assigned to the payroll batch or pay run in which this record was processed. Used for audit and reconciliation purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `payment_date` DATE COMMENT 'The date on which the net pay was or will be disbursed to the employee. Represents the actual payment transaction date.',
    `payment_method` STRING COMMENT 'The method by which the net pay is disbursed to the employee. Electronic funds transfer (EFT) is the most common method in modern payroll systems.. Valid values are `electronic_funds_transfer|cheque|cash|payroll_card`',
    `payroll_area` STRING COMMENT 'SAP HR payroll area code representing the organizational grouping for payroll processing (e.g., by site, region, or pay frequency). Determines pay calendar and processing rules.. Valid values are `^[A-Z0-9]{2,6}$`',
    `payroll_status` STRING COMMENT 'Current processing status of the payroll record. Tracks the record through the payroll lifecycle from draft calculation to final payment.. Valid values are `draft|approved|processed|paid|reversed|cancelled`',
    `shift_allowance_amount` DECIMAL(18,2) COMMENT 'Allowance paid for working non-standard shifts such as night shift, afternoon shift, or rotating rosters.',
    `site_allowance_amount` DECIMAL(18,2) COMMENT 'Allowance paid to workers assigned to remote or challenging mine sites. Compensates for site-specific conditions and living arrangements.',
    `superannuation_amount` DECIMAL(18,2) COMMENT 'Employer superannuation (pension) contribution made on behalf of the employee. Mandatory in jurisdictions such as Australia under the Superannuation Guarantee.',
    `tax_withheld_amount` DECIMAL(18,2) COMMENT 'Income tax withheld from the employees gross pay as required by tax legislation. Remitted to the tax authority on behalf of the employee.',
    `total_deductions_amount` DECIMAL(18,2) COMMENT 'Sum of all deductions applied to the gross pay, including tax, superannuation, union dues, garnishments, and other deductions.',
    `union_dues_amount` DECIMAL(18,2) COMMENT 'Union membership dues deducted from the employees pay as authorized by the employee. Remitted to the relevant labor union.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Payroll processing record capturing the periodic pay calculation for each employee including base pay, allowances (site allowance, FIFO allowance, leading hand allowance), overtime, deductions, superannuation, and net pay. Captures pay period, pay run reference, SAP HR payroll area, payment method, and payroll status. Integrates with SAP FI/CO for cost centre posting.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`employment_agreement` (
    `employment_agreement_id` BIGINT COMMENT 'Primary key for employment_agreement',
    `superseded_agreement_employment_agreement_id` BIGINT COMMENT 'Identifier of the previous employment agreement that this agreement replaces, establishing agreement lineage and succession.',
    `tenement_id` BIGINT COMMENT 'Identifier of the mine site or operational location to which this agreement applies. Links to site master data.',
    `agreement_name` STRING COMMENT 'Full legal name of the employment agreement as registered with regulatory authorities or as documented in the contract.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the employment agreement, used for reference in payroll, HR systems, and regulatory lodgements.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the employment agreement. Active agreements govern current employment conditions; expired agreements may continue to apply until replaced. [ENUM-REF-CANDIDATE: Draft|Lodged|Approved|Active|Expired|Terminated|Suspended|Under Review — 8 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the employment agreement. EBA = Enterprise Bargaining Agreement, AWA = Australian Workplace Agreement. Determines the legal framework and compliance requirements.. Valid values are `EBA|AWA|Individual Contract|Collective Agreement|Modern Award|Common Law Contract`',
    `annual_leave_entitlement_weeks` DECIMAL(18,2) COMMENT 'Number of weeks of annual leave accrued per year under this agreement. May exceed statutory minimum for certain rosters or classifications.',
    `approval_date` DATE COMMENT 'Date on which the agreement was approved by the regulatory authority and became legally enforceable.',
    `approved_by` STRING COMMENT 'Name of the regulatory authority or tribunal that approved the agreement (e.g., Fair Work Commission, relevant state industrial relations commission).',
    `ballot_approval_percentage` DECIMAL(18,2) COMMENT 'Percentage of employees who voted in favor of the agreement during the ballot process.',
    `ballot_date` DATE COMMENT 'Date on which employees voted to approve the agreement, if a ballot was conducted as part of the approval process.',
    `base_pay_rate` DECIMAL(18,2) COMMENT 'Standard base hourly or annual pay rate specified in the agreement for the covered classification. Excludes allowances and overtime.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employment agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this agreement (e.g., AUD, USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `dispute_resolution_process` STRING COMMENT 'Description of the formal process for resolving disputes between employer and employees under this agreement, including escalation steps and arbitration provisions.',
    `document_reference` STRING COMMENT 'File path, URL, or document management system reference to the full legal text of the employment agreement.',
    `effective_from_date` DATE COMMENT 'Date from which the employment agreement terms become legally binding and applicable to covered employees.',
    `effective_to_date` DATE COMMENT 'Date on which the employment agreement expires or ceases to be in force. Nullable for open-ended agreements or those with automatic renewal clauses.',
    `employer_party` STRING COMMENT 'Legal name of the employer entity that is a party to the agreement. May be the parent company or a specific subsidiary operating the mine site.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this employment agreement record was last updated in the system.',
    `lodgement_date` DATE COMMENT 'Date on which the agreement was formally lodged with the regulatory authority for approval.',
    `maximum_consecutive_shifts` STRING COMMENT 'Maximum number of consecutive shifts an employee may work under this agreement before mandatory rest period, aligned with fatigue management requirements.',
    `minimum_rest_hours` DECIMAL(18,2) COMMENT 'Minimum number of hours of rest required between shifts or after a roster cycle, as mandated by the agreement and fatigue management protocols.',
    `negotiation_start_date` DATE COMMENT 'Date on which formal negotiations for this agreement commenced between employer and employee representatives.',
    `nominal_expiry_date` DATE COMMENT 'Scheduled expiry date as stated in the agreement document, which may differ from actual cessation date if the agreement continues to apply post-expiry pending replacement.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or administrative notes related to the agreement.',
    `notice_period_weeks` DECIMAL(18,2) COMMENT 'Required notice period in weeks for termination of employment by either party, as specified in the agreement.',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base pay rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time).',
    `pay_rate_unit` STRING COMMENT 'Unit of measure for the base pay rate (hourly, daily, annual, or per shift).. Valid values are `Hourly|Daily|Annual|Per Shift`',
    `redundancy_entitlement_weeks` DECIMAL(18,2) COMMENT 'Number of weeks of redundancy pay per year of service as specified in the agreement, which may exceed statutory minimums.',
    `regulatory_lodgement_reference` STRING COMMENT 'Reference number or identifier assigned by the regulatory authority (e.g., Fair Work Commission) upon lodgement or approval of the agreement.',
    `shift_allowance_amount` DECIMAL(18,2) COMMENT 'Fixed allowance amount payable per shift for shift work, night work, or roster-specific conditions as specified in the agreement.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Ordinary hours of work per week as defined in the agreement, before overtime provisions apply.',
    `union_party` STRING COMMENT 'Name of the trade union or employee representative body that is a party to the agreement. Null for individual non-union agreements.',
    `workforce_classification` STRING COMMENT 'Category of workforce covered by this agreement, such as production operators, maintenance technicians, administrative staff, or contractors. Determines applicability of terms.',
    CONSTRAINT pk_employment_agreement PRIMARY KEY(`employment_agreement_id`)
) COMMENT 'Enterprise bargaining agreement (EBA) and individual employment agreement master record. Captures agreement type (EBA, AWA, individual contract), agreement name, effective date, expiry date, applicable workforce classification, key terms (pay rates, allowances, hours of work, dispute resolution), union party, and regulatory lodgement reference. Governs employment conditions across the mine workforce.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`labour_case` (
    `labour_case_id` BIGINT COMMENT 'Unique identifier for the labour case record. Primary key.',
    `department_id` BIGINT COMMENT 'Identifier of the department or organizational unit to which the subject employee belongs.',
    `incident_id` BIGINT COMMENT 'Identifier linking the labour case to a related Health Safety and Environment (HSE) incident, if the case arose from a safety breach or incident.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who is the subject of the labour case (e.g., the employee facing disciplinary action or lodging a grievance).',
    `quaternary_labour_employee_id` BIGINT COMMENT 'Identifier of the Human Resources (HR) Business Partner assigned to manage and oversee the labour case.',
    `tenement_id` BIGINT COMMENT 'Identifier of the mine site or operational location where the incident or issue occurred.',
    `tertiary_labour_investigator_employee_id` BIGINT COMMENT 'Identifier of the employee or Human Resources (HR) professional assigned to conduct the investigation.',
    `appeal_lodgement_date` DATE COMMENT 'Date when an appeal against the labour case decision was formally lodged.',
    `appeal_outcome` STRING COMMENT 'Final outcome of the appeal process, indicating whether the original decision was upheld, overturned, or modified.. Valid values are `original_decision_upheld|decision_overturned|decision_modified|appeal_withdrawn`',
    `appeal_status` STRING COMMENT 'Status of any appeal lodged against the original decision or outcome of the labour case.. Valid values are `no_appeal|appeal_lodged|appeal_in_progress|appeal_upheld|appeal_dismissed`',
    `case_category` STRING COMMENT 'Specific sub-classification of the case type. For disciplinary cases: verbal warning, written warning, Performance Improvement Plan (PIP), suspension, termination. For grievances: pay dispute, discrimination, bullying, harassment, Enterprise Bargaining Agreement (EBA) interpretation, working conditions. [ENUM-REF-CANDIDATE: verbal_warning|written_warning|pip|suspension|termination|pay_dispute|discrimination|bullying|harassment|eba_interpretation|working_conditions|safety_breach|policy_violation|other — promote to reference product]',
    `case_notes` STRING COMMENT 'General notes and observations recorded throughout the lifecycle of the labour case for internal reference and documentation.',
    `case_number` STRING COMMENT 'Externally-known unique case reference number assigned to the labour case for tracking and documentation purposes.. Valid values are `^LC-[0-9]{8}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the labour case indicating its progression through the resolution workflow.. Valid values are `open|under_investigation|pending_review|resolved|closed|escalated`',
    `case_type` STRING COMMENT 'Classification of the labour case indicating the nature of the workforce relations matter being managed.. Valid values are `disciplinary|grievance|dispute|appeal|investigation|performance`',
    `confidentiality_level` STRING COMMENT 'Classification level indicating the sensitivity and access restrictions for the labour case documentation.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the labour case record was first created in the system.',
    `escalation_history` STRING COMMENT 'Chronological record of escalation events, including dates, escalation reasons, and parties involved at each level.',
    `escalation_level` STRING COMMENT 'Numeric indicator of how many times the case has been escalated to higher management or external authorities (0 = no escalation).',
    `fair_work_notification_date` DATE COMMENT 'Date when the labour case was formally notified to Fair Work Australia or Fair Work Commission.',
    `fair_work_notification_flag` BOOLEAN COMMENT 'Indicates whether the case has been notified to Fair Work Australia or Fair Work Commission as required by legislation.',
    `incident_date` DATE COMMENT 'Date when the underlying incident or issue that triggered the labour case occurred.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the incident, issue, or circumstances that led to the labour case being opened.',
    `investigation_completion_date` DATE COMMENT 'Date when the formal investigation was completed and findings were documented.',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation into the labour case commenced.',
    `investigation_status` STRING COMMENT 'Current status of the formal investigation process associated with the labour case.. Valid values are `not_started|in_progress|completed|suspended|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the labour case record was last updated or modified.',
    `legal_representation_flag` BOOLEAN COMMENT 'Indicates whether either party has engaged legal representation or legal counsel in the labour case proceedings.',
    `lodgement_date` DATE COMMENT 'Date when the labour case was formally lodged or initiated in the system.',
    `policy_breach_reference` STRING COMMENT 'Reference code or identifier of the company policy, Standard Operating Procedure (SOP), or regulation that was breached, if applicable.',
    `resolution_date` DATE COMMENT 'Date when the labour case was formally resolved and a final outcome was determined.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution outcome, actions taken, and any agreements or conditions imposed.',
    `resolution_outcome` STRING COMMENT 'Final outcome or decision reached for the labour case after investigation and review processes. [ENUM-REF-CANDIDATE: upheld|partially_upheld|not_upheld|withdrawn|settled|mediated|dismissed — 7 candidates stripped; promote to reference product]',
    `severity_level` STRING COMMENT 'Assessment of the severity or seriousness of the labour case based on the nature of the incident and potential impact.. Valid values are `low|medium|high|critical`',
    `union_involvement_flag` BOOLEAN COMMENT 'Indicates whether a union representative or union official is involved in the labour case proceedings.',
    `union_representative_name` STRING COMMENT 'Name of the union representative or official involved in the case, if applicable.',
    `witness_employee_ids` STRING COMMENT 'Comma-separated list of employee identifiers for witnesses involved in or providing testimony for the labour case.',
    CONSTRAINT pk_labour_case PRIMARY KEY(`labour_case_id`)
) COMMENT 'Formal workforce case management record covering all disciplinary actions, grievances, disputes, and appeals. Captures case type (disciplinary, grievance, dispute, appeal, investigation), parties involved (subject employee, complainant, witnesses), issue/lodgement date, incident description, category (for disciplinary: verbal warning, written warning, PIP, suspension, termination; for grievance: pay dispute, discrimination, bullying, harassment, EBA interpretation, working conditions), investigation status, union involvement flag, Fair Work notification status, resolution outcome, escalation history, appeal status, HR business partner, and linkage to any HSE incident or policy breach. Serves as the SSOT for all formal workforce relations cases. Supports labour relations management, Fair Work Act compliance, union consultation obligations, and legal documentation requirements.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`crew` (
    `crew_id` BIGINT COMMENT 'Unique identifier for the mine crew record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Crews are the operational unit for production cost tracking in Mining. Crew costs (labour, equipment, consumables) must be allocated to cost centres for unit cost analysis, AISC reporting, and product',
    `department_id` BIGINT COMMENT 'Reference to the organizational department or operational unit to which this crew belongs. Used for cost allocation and reporting hierarchy.',
    `employee_id` BIGINT COMMENT 'Reference to the employee record of the crew supervisor or shift boss responsible for this crew. Key contact for operational decisions and safety accountability.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.processing_plant. Business justification: Crew shift planning, competency alignment, and production accountability require primary plant assignment. Crews operate specific processing plants with plant-specific training, PPE, and emergency pro',
    `roster_id` BIGINT COMMENT 'Reference to the roster pattern (e.g., FIFO 2-weeks-on/1-week-off, 4-on/4-off) that governs this crews work cycle. Links to roster master for cycle details.',
    `tenement_id` BIGINT COMMENT 'Reference to the mine site where this crew is based. Links to site master for location, jurisdiction, and operational context.',
    `communication_channel` STRING COMMENT 'Primary radio channel, frequency, or communication system identifier used by this crew for operational coordination and emergency response.',
    `competency_requirements` STRING COMMENT 'Summary of mandatory competencies, certifications, or qualifications required for crew members (e.g., Haul Truck Operator Ticket, First Aid Level 2, Confined Space Entry). Used for crew assignment validation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was first created in the system. Used for audit trail and data lineage.',
    `crew_code` STRING COMMENT 'Unique business identifier code for the crew, used in operational systems and shift reporting. Typically alphanumeric format assigned by site management.. Valid values are `^[A-Z0-9]{4,12}$`',
    `crew_name` STRING COMMENT 'Human-readable name of the crew, typically reflecting shift pattern, operational area, or supervisor name (e.g., Alpha Day Shift, Bravo Night Crew, Processing Team 3).',
    `crew_status` STRING COMMENT 'Current operational status of the crew. Active crews are available for shift scheduling; inactive/disbanded crews are historical records.. Valid values are `active|inactive|suspended|disbanded|planned`',
    `crew_type` STRING COMMENT 'Classification of crew by primary operational function. Determines skill requirements, equipment assignments, and production reporting categories.. Valid values are `mining|processing|maintenance|drill_and_blast|load_and_haul|haulage`',
    `effective_from_date` DATE COMMENT 'Date from which this crew configuration became or will become active. Supports temporal crew structure changes and historical reporting.',
    `effective_to_date` DATE COMMENT 'Date until which this crew configuration is valid. Null for currently active crews. Used for crew lifecycle management and historical analysis.',
    `emergency_muster_point` STRING COMMENT 'Designated emergency assembly location for this crew in case of evacuation or emergency. Critical for emergency response and headcount verification.',
    `equipment_fleet_assignment` STRING COMMENT 'Description of primary equipment or fleet assigned to this crew (e.g., Haul Trucks 101-110, Excavator EX-05, Processing Train 2). Used for equipment utilization and maintenance coordination.',
    `fatigue_risk_rating` STRING COMMENT 'Assessed fatigue risk level for this crews roster pattern and shift configuration. Used for ISO 45001 compliance and fatigue management planning.. Valid values are `low|medium|high|critical`',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this crew record. Used for audit trail and change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was last updated. Used for audit trail and change tracking.',
    `maximum_consecutive_shifts` STRING COMMENT 'Maximum number of consecutive shifts allowed for crew members under this crews roster pattern. Enforced for fatigue management and regulatory compliance.',
    `minimum_rest_hours` DECIMAL(18,2) COMMENT 'Minimum rest period in hours required between shifts for crew members. Enforced for fatigue management and regulatory compliance.',
    `nominal_headcount` STRING COMMENT 'Standard or planned number of workers assigned to this crew when fully staffed. Used for roster planning and manning variance analysis.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or contextual information about the crew configuration.',
    `operational_area` STRING COMMENT 'Primary operational area or zone where this crew works (e.g., Pit 3 East, Processing Plant A, Underground Level 5). Used for location-based safety and production reporting.',
    `ppe_requirements` STRING COMMENT 'Mandatory PPE requirements specific to this crews operational area and tasks. Used for safety compliance and pre-start checks.',
    `pre_start_meeting_location` STRING COMMENT 'Designated location for crew pre-start safety meetings and toolbox talks. Critical for safety communication and attendance tracking.',
    `production_target_per_shift` DECIMAL(18,2) COMMENT 'Standard production target for this crew per shift, measured in the unit specified in production_target_unit. Used for performance tracking and incentive calculations.',
    `production_target_unit` STRING COMMENT 'Unit of measure for this crews production targets (e.g., tonnes for haulage crews, BCM for mining crews, hours for maintenance crews).. Valid values are `tonnes|bcm|hours|meters|cycles`',
    `shift_duration_hours` DECIMAL(18,2) COMMENT 'Standard duration of a single shift for this crew in hours. Used for fatigue management and labor cost calculations.',
    `shift_pattern` STRING COMMENT 'Standard shift timing pattern for this crew. Determines start/end times and handover protocols.. Valid values are `day|night|swing|rotating|continuous`',
    `shift_start_time` TIMESTAMP COMMENT 'Standard start time for this crews shift in HH:mm format (24-hour clock). Used for pre-start meeting scheduling and attendance tracking.',
    `created_by` STRING COMMENT 'User identifier or system account that created this crew record. Used for audit trail and accountability.',
    CONSTRAINT pk_crew PRIMARY KEY(`crew_id`)
) COMMENT 'Mine crew master record defining operational work crews that form the basis of shift-based mine operations. Captures crew name, crew code, crew type (mining, processing, maintenance, drill-and-blast, load-and-haul), home site, supervisor, nominal headcount, roster pattern, and active status. Crews are the primary organisational unit for shift scheduling, production reporting, safety toolbox talks, and pre-start meetings. Links to shift_schedule for manning and to org_unit for departmental reporting.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`mobilisation` (
    `mobilisation_id` BIGINT COMMENT 'Unique identifier for the workforce mobilisation record. Primary key for tracking individual worker movement events to and from mine sites.',
    `accommodation_allocation_id` BIGINT COMMENT 'Identifier of the accommodation room or unit allocated to the worker during their site rotation. Links to camp management systems.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: FIFO mobilisation costs (flights, accommodation, transport) are significant OPEX in remote Mining operations and must be allocated to cost centres for accurate unit cost calculation, AISC reporting, a',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor being mobilised or demobilised. Links to the workforce master record to identify the individual.',
    `roster_cycle_id` BIGINT COMMENT 'Identifier of the roster cycle this mobilisation supports. Links the movement to the planned work schedule and rotation pattern.',
    `tenement_id` BIGINT COMMENT 'Identifier of the mine site to which the worker is being mobilised or from which they are being demobilised. Critical for remote FIFO/DIDO operations.',
    `return_mobilisation_id` BIGINT COMMENT 'Self-referencing FK on mobilisation (return_mobilisation_id)',
    `accommodation_check_in_datetime` TIMESTAMP COMMENT 'Date and time the worker checked into their allocated accommodation. Used for occupancy tracking and billing.',
    `accommodation_check_out_datetime` TIMESTAMP COMMENT 'Date and time the worker checked out of their accommodation. Used for occupancy tracking and room turnover planning.',
    `accommodation_cost_amount` DECIMAL(18,2) COMMENT 'Cost of accommodation for this rotation period. Allocated to the appropriate cost centre for workforce budgeting.',
    `accommodation_type` STRING COMMENT 'Type of accommodation provided to the worker during their site rotation. Varies by site facilities and worker grade.. Valid values are `single_room|shared_room|donger|village_unit|hotel|motel`',
    `actual_demobilisation_datetime` TIMESTAMP COMMENT 'Actual date and time the worker departed from site. Captured from site exit systems or travel manifest.',
    `actual_mobilisation_datetime` TIMESTAMP COMMENT 'Actual date and time the worker departed for site. Captured from travel manifest or check-in systems.',
    `arrival_location` STRING COMMENT 'City, airport code, or location where the worker arrived. Typically the nearest airport or transport hub to the mine site.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if the mobilisation was cancelled. Used for workforce planning analysis and cost recovery where applicable.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost amounts. Typically AUD for Australian mining operations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this mobilisation record was created in the system. Used for audit trail and data lineage tracking.',
    `delay_reason` STRING COMMENT 'Reason for delay if the mobilisation was delayed. Common causes include weather, mechanical issues, or operational changes.',
    `departure_location` STRING COMMENT 'City, airport code, or location from which the worker departed. Typically the workers home base for FIFO operations.',
    `emergency_contact_name` STRING COMMENT 'Name of the emergency contact person for this worker during their site rotation. Updated at each mobilisation for current accuracy.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact person. Critical for incident response and family notification in remote operations.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the worker (spouse, parent, sibling, friend). Used for emergency notification protocols.',
    `flight_number` STRING COMMENT 'Flight number for air travel mobilisations. Used for manifest tracking and arrival/departure confirmation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time this mobilisation record was last updated. Used for audit trail and change tracking throughout the mobilisation lifecycle.',
    `manifest_confirmed` BOOLEAN COMMENT 'Flag indicating whether the worker has been confirmed on the flight or bus manifest. Used for headcount reconciliation and safety accountability.',
    `medical_clearance_verified` BOOLEAN COMMENT 'Flag indicating whether current medical fitness clearance has been verified prior to mobilisation. Mandatory for MSHA and ISO 45001 compliance.',
    `mobilisation_number` STRING COMMENT 'Business reference number for the mobilisation event. Used for tracking and reporting purposes across travel booking, accommodation, and payroll systems.',
    `mobilisation_status` STRING COMMENT 'Current lifecycle status of the mobilisation event. Tracks progression from planning through to completion or cancellation. [ENUM-REF-CANDIDATE: planned|booked|in_transit|arrived|completed|cancelled|delayed|no_show — 8 candidates stripped; promote to reference product]',
    `mobilisation_type` STRING COMMENT 'Classification of the movement event. Distinguishes between standard mobilisation, demobilisation, rotation changes, emergency movements, and inter-site transfers.. Valid values are `mobilisation|demobilisation|rotation_change|emergency_mobilisation|emergency_demobilisation|site_transfer`',
    `no_show_flag` BOOLEAN COMMENT 'Flag indicating whether the worker failed to appear for scheduled travel. Triggers workforce planning adjustments and potential disciplinary action.',
    `notes` STRING COMMENT 'Free-text notes capturing additional information about the mobilisation event. Used for special arrangements, issues, or follow-up actions.',
    `pre_mobilisation_checklist_completed` BOOLEAN COMMENT 'Flag indicating whether the pre-mobilisation checklist has been completed. Includes medical fitness, training currency, and PPE readiness.',
    `scheduled_demobilisation_date` DATE COMMENT 'Planned date for the worker to demobilise from site. Used for return travel booking and roster planning.',
    `scheduled_mobilisation_date` DATE COMMENT 'Planned date for the worker to mobilise to site. Used for travel booking and accommodation planning.',
    `site_arrival_datetime` TIMESTAMP COMMENT 'Confirmed date and time the worker arrived at the mine site. Captured from site access control or check-in systems.',
    `site_departure_datetime` TIMESTAMP COMMENT 'Confirmed date and time the worker departed from the mine site. Captured from site exit control systems.',
    `site_induction_completed_datetime` TIMESTAMP COMMENT 'Date and time the site-specific induction was completed. Required before the worker can commence work on site.',
    `site_induction_required` BOOLEAN COMMENT 'Flag indicating whether a site-specific induction is required upon arrival. Typically true for first-time mobilisations or after extended absence.',
    `total_mobilisation_cost_amount` DECIMAL(18,2) COMMENT 'Total cost of the mobilisation event including travel, accommodation, and any other associated costs. Key metric for workforce logistics cost management.',
    `training_currency_verified` BOOLEAN COMMENT 'Flag indicating whether all mandatory training and competencies are current prior to mobilisation. Critical for site access authorization.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for the mobilisation or demobilisation. Critical for cost allocation and logistics planning in remote operations. [ENUM-REF-CANDIDATE: flight|charter_flight|bus|private_vehicle|company_vehicle|helicopter|train — 7 candidates stripped; promote to reference product]',
    `travel_booking_reference` STRING COMMENT 'Booking confirmation number or reference code from the travel provider. Used for manifest reconciliation and travel expense tracking.',
    `travel_cost_amount` DECIMAL(18,2) COMMENT 'Total cost of travel for this mobilisation event including flights, bus, or other transport. Major cost component for remote mine operations.',
    `travel_provider` STRING COMMENT 'Name of the airline, bus company, or charter service provider used for the journey. Used for vendor management and cost reconciliation.',
    CONSTRAINT pk_mobilisation PRIMARY KEY(`mobilisation_id`)
) COMMENT 'Workforce mobilisation and demobilisation record tracking the movement of FIFO/DIDO workers to and from mine sites. Captures travel booking, flight/bus manifest, accommodation allocation, mobilisation date, demobilisation date, site arrival/departure confirmation, travel provider, cost allocation, and emergency contact updates. Critical for remote mine operations where workforce logistics are a major operational and cost management activity.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`workforce_project_contract` (
    `workforce_project_contract_id` BIGINT COMMENT 'Primary key for workforce_project_contract',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to the capital project for which this contract was established',
    `contractor_id` BIGINT COMMENT 'Foreign key linking to the contractor engaged under this project contract',
    `project_contract_id` BIGINT COMMENT 'Unique identifier for this project contract record. Primary key for the association.',
    `award_date` DATE COMMENT 'Date on which this contract was formally awarded to the contractor following tender evaluation or direct negotiation.',
    `contract_end_date` DATE COMMENT 'Scheduled or actual completion date for this contract. May be extended through formal variation processes.',
    `contract_number` STRING COMMENT 'Business identifier for the contract between this contractor and capital project. Used for external reference, invoicing, and legal documentation.',
    `contract_start_date` DATE COMMENT 'Date on which this contract becomes effective and the contractor is authorized to commence work on the capital project.',
    `contract_status` STRING COMMENT 'Current lifecycle status of this project contract: draft (under negotiation), awarded (signed but not yet commenced), active (work in progress), suspended (temporarily halted), completed (work finished and accepted), terminated (contract ended early).',
    `contract_type` STRING COMMENT 'Classification of the contract commercial model: lump_sum (fixed price for defined scope), schedule_of_rates (pre-agreed rates applied to actual quantities), cost_plus (reimbursable costs plus fee), unit_rate (price per unit of work), alliance (shared risk/reward), epcm (engineering procurement construction management).',
    `contract_value` DECIMAL(18,2) COMMENT 'Total financial value of this contract in the projects currency. For lump sum contracts this is the fixed price; for schedule of rates this is the estimated value based on forecast quantities.',
    `payment_terms` STRING COMMENT 'Payment schedule and terms specific to this contract (e.g., Monthly progress claims, Net 30 days from invoice, Milestone-based payments). Defines when and how the contractor is paid for work on this project.',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Value of the performance bond or bank guarantee required from the contractor to secure performance obligations under this contract. Typically 10% of contract value.',
    `practical_completion_date` DATE COMMENT 'Date on which the contractor achieved practical completion of their scope under this contract, triggering defects liability period and retention release.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each progress payment withheld as security until contract completion and defects liability period expiry. Typical values range from 5% to 10%.',
    `scope_summary` STRING COMMENT 'High-level description of the work scope covered by this contract for this specific project (e.g., Civil earthworks for tailings dam raise, Electrical installation for crusher plant, Mechanical commissioning of conveyor system).',
    CONSTRAINT pk_workforce_project_contract PRIMARY KEY(`workforce_project_contract_id`)
) COMMENT 'This association product represents the Contract between contractor and capital_project. It captures the formal engagement agreement under which a contractor provides services to a specific capital project. Each record links one contractor to one capital_project with contract-specific terms, financial arrangements, scope definition, and performance obligations that exist only in the context of this contractual relationship.. Existence Justification: In mining capital projects, contractors are engaged through formal contracts to deliver specific scopes of work (civil, electrical, mechanical, commissioning). A single contractor can hold multiple contracts across different capital projects simultaneously, and each capital project engages multiple contractors for different work packages. The business actively manages these contracts as distinct operational entities with contract-specific terms, financial arrangements, scope definitions, and performance obligations.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` (
    `contractor_tenement_engagement_id` BIGINT COMMENT 'Primary key for contractor_tenement_engagement',
    `contractor_id` BIGINT COMMENT 'Foreign key linking to the contractor master record',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to the tenement master record',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this engagement record was created',
    `engagement_code` BIGINT COMMENT 'Unique identifier for this contractor-tenement engagement record. Primary key.',
    `engagement_end_date` DATE COMMENT 'Planned or actual end date of the contractors engagement at this specific tenement. Null for ongoing engagements.',
    `engagement_start_date` DATE COMMENT 'Date on which the contractors engagement at this specific tenement commenced. Tracks site-specific engagement periods.',
    `induction_completion_date` DATE COMMENT 'Date on which the contractor completed their most recent site induction training for this specific tenement.',
    `induction_status` STRING COMMENT 'Status of the contractors site-specific safety induction training for this tenement. Completed status is required for operational work.',
    `scope_of_work` STRING COMMENT 'Description of the contractors work scope and responsibilities at this specific tenement. Varies by site and engagement.',
    `site_access_clearance_date` DATE COMMENT 'Date on which site access clearance was granted for this specific tenement. Used to calculate clearance age and renewal requirements.',
    `site_access_clearance_status` STRING COMMENT 'Current status of the contractors site access clearance for this specific tenement. Approved status is required for site entry.',
    `site_access_expiry_date` DATE COMMENT 'Date on which site access clearance expires for this specific tenement. Contractors must complete re-induction before this date.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this engagement record was last updated',
    CONSTRAINT pk_contractor_tenement_engagement PRIMARY KEY(`contractor_tenement_engagement_id`)
) COMMENT 'This association product represents the engagement contract between a contractor and a specific tenement. It captures site-specific access clearances, induction status, and engagement periods that exist only in the context of a contractor working at a particular tenement. Each record links one contractor to one tenement with attributes tracking the contractors authorization, clearances, and work scope for that specific site.. Existence Justification: In mining operations, contractors routinely work across multiple tenements either sequentially (moving between sites as projects complete) or concurrently (specialists serving multiple sites). Each tenement engages multiple contractors for different trades and scopes. The business actively manages these engagements as distinct operational records, tracking site-specific clearances, inductions, and work authorizations that vary by tenement.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`position_competency_requirement` (
    `position_competency_requirement_id` BIGINT COMMENT 'Unique identifier for this position-competency requirement record. Primary key for the association.',
    `competency_id` BIGINT COMMENT 'Foreign key linking to the competency that is required for this position',
    `position_id` BIGINT COMMENT 'Foreign key linking to the position that requires this competency',
    `approval_date` DATE COMMENT 'Date when this competency requirement was formally approved for this position.',
    `approved_by` STRING COMMENT 'Name or identifier of the manager, HR business partner, or regulatory compliance officer who approved this competency requirement for this position.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position-competency requirement record was first created in the system.',
    `criticality_rating` STRING COMMENT 'Assessment of how critical this competency is to the safe and effective performance of this position. Critical ratings typically apply to statutory roles and high-risk operational positions. This attribute was explicitly identified in the detection phase relationship data.',
    `effective_from_date` DATE COMMENT 'Date from which this competency requirement becomes effective for this position. Supports temporal tracking of changing competency requirements as roles evolve or regulations change. This attribute was explicitly identified in the detection phase relationship data.',
    `effective_to_date` DATE COMMENT 'Date until which this competency requirement is valid for this position. Null for currently active requirements. Supports historical tracking of competency requirement changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this position-competency requirement record was last updated or modified.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this competency is mandatory for this position (True) or desirable/optional (False). Mandatory competencies must be held before the position can be filled or must be attained within a specified onboarding period. This attribute was explicitly identified in the detection phase relationship data.',
    `onboarding_grace_period_days` STRING COMMENT 'Number of days after position commencement within which this competency must be attained if not held at hire. Null if competency must be held before position start. Used for workforce planning and training scheduling.',
    `required_competencies` STRING COMMENT 'Comma-separated list of mandatory competencies, certifications, or qualifications required for the position (e.g., First Aid, Confined Space Entry, Shotfirer License, Engineering Degree). Used for compliance and succession planning. [Moved from position: This STRING field in position contains a comma-separated list of competency codes, which is a denormalized representation of the M:N relationship. This data belongs in the association table as individual position_competency_requirement records, enabling proper normalization, competency gap queries, and proficiency-level tracking per competency per position.]',
    `required_proficiency_level` STRING COMMENT 'The minimum proficiency or mastery level required for this competency in this position: awareness (basic understanding), working (can perform with supervision), proficient (independent performance), expert (can teach others). This attribute was explicitly identified in the detection phase relationship data.',
    `verification_frequency_months` STRING COMMENT 'The frequency (in months) at which this competency requirement should be verified for incumbents in this position. Used for compliance auditing and competency gap monitoring. This attribute was explicitly identified in the detection phase relationship data.',
    CONSTRAINT pk_position_competency_requirement PRIMARY KEY(`position_competency_requirement_id`)
) COMMENT 'This association product represents the competency requirements matrix between positions and competencies in the mine workforce. It captures which competencies are required for which positions, at what proficiency level, and with what criticality. Each record links one position to one competency with attributes that define the requirement parameters including mandatory status, proficiency expectations, verification frequency, and effective dates. This enables competency gap analysis, succession planning, training needs assessment, and regulatory compliance tracking for statutory roles.. Existence Justification: In mining workforce management, positions require multiple competencies (e.g., a Mine Supervisor position requires shotfirer certificate, first aid, risk assessment, and supervisory competencies), and each competency is required by multiple positions (e.g., first aid is required for field operators, supervisors, emergency response roles, and statutory positions). HR and operations teams actively manage competency requirement matrices that define which competencies are mandatory for which positions, at what proficiency levels, with what criticality ratings, and with specific verification frequencies for compliance auditing.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`department` (
    `department_id` BIGINT COMMENT 'Primary key for department',
    `competency_framework_id` BIGINT COMMENT 'Reference to the competency framework that defines required skills, certifications, and training for employees in this department. Used to ensure workforce capability and compliance with industry standards.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who manages this department. Used for organizational hierarchy, approval workflows, and reporting lines.',
    `parent_department_id` BIGINT COMMENT 'Reference to the parent department in the organizational hierarchy. Null for top-level departments. Enables hierarchical reporting structures and roll-up of workforce metrics.',
    `site_id` BIGINT COMMENT 'Reference to the mine site or facility where this department operates. Links department to physical location for workforce planning and compliance reporting.',
    `budget_allocation_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated to this department for operational expenses including payroll, equipment, supplies, and training. Used for financial planning and variance analysis.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocation amount. Supports multi-currency operations for global mining companies.',
    `closure_date` DATE COMMENT 'Date when the department was officially closed or disbanded. Null for active departments. Used for historical record-keeping and workforce transition planning.',
    `cost_center_code` STRING COMMENT 'Financial accounting code used to track expenses and budget allocation for this department. Used in payroll integration and financial reporting systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this department record was first created in the system. Used for audit trail and data lineage tracking.',
    `department_code` STRING COMMENT 'Short alphanumeric code used to identify the department in operational systems and reporting. Typically used in payroll, timekeeping, and cost allocation systems.',
    `department_name` STRING COMMENT 'Full official name of the department as used in organizational charts and formal communications.',
    `department_type` STRING COMMENT 'Classification of the department based on its primary function within the mining operation. Operations departments are directly involved in extraction and processing, maintenance departments handle equipment upkeep, engineering departments manage technical design and planning, safety departments oversee health and safety compliance, administration departments provide corporate support, and support departments provide auxiliary services.',
    `department_description` STRING COMMENT 'Detailed description of the departments responsibilities, scope of work, and role within the mining operation. Used for organizational documentation and onboarding materials.',
    `effective_from_date` DATE COMMENT 'Date from which the current department configuration became effective. Used for tracking organizational changes and historical reporting.',
    `effective_to_date` DATE COMMENT 'Date until which the current department configuration is valid. Null for current configurations. Used for managing organizational restructuring and historical analysis.',
    `emergency_contact_phone` STRING COMMENT 'Primary phone number for reaching the department manager or designated contact in emergency situations. Used for incident response and business continuity planning.',
    `established_date` DATE COMMENT 'Date when the department was officially created or established within the organization. Used for historical tracking and organizational evolution analysis.',
    `fatigue_management_required` BOOLEAN COMMENT 'Indicates whether this department is subject to formal fatigue management protocols due to shift work, extended hours, or safety-critical operations. True for departments requiring fatigue risk assessment and monitoring, false for standard office-based departments.',
    `headcount_capacity` STRING COMMENT 'Maximum number of employees and contractors that can be assigned to this department based on operational requirements and budget allocation. Used for workforce planning and resource allocation.',
    `is_unionized` BOOLEAN COMMENT 'Indicates whether this department is covered by a collective bargaining agreement. True for unionized departments, false for non-union departments. Affects payroll rules, grievance procedures, and workforce policies.',
    `payroll_integration_enabled` BOOLEAN COMMENT 'Indicates whether this department is integrated with the SAP HR payroll system for automated time and attendance processing. True for departments with active payroll integration, false for departments managed outside the standard payroll system.',
    `physical_location` STRING COMMENT 'Physical location or building where the department is primarily based within the mine site. Examples include administration building, maintenance workshop, processing plant, underground level 5, or pit operations office.',
    `requires_msha_certification` BOOLEAN COMMENT 'Indicates whether employees in this department must hold valid MSHA certifications to perform their duties. True for departments with direct mining operations exposure, false for administrative and support departments.',
    `safety_risk_level` STRING COMMENT 'Assessment of the inherent safety risk associated with work performed by this department. Critical for underground mining and blasting operations, high for heavy equipment operation and processing, medium for maintenance and logistics, low for administrative functions. Drives HSE training requirements and safety protocols.',
    `shift_pattern` STRING COMMENT 'Standard shift rotation pattern used by this department. Day shift operates during daylight hours, night shift operates overnight, rotating patterns alternate between day and night, FIFO (Fly-In Fly-Out) involves extended on-site periods followed by off-site rest, and continuous operations run 24/7. Critical for roster management and fatigue compliance.',
    `department_status` STRING COMMENT 'Current operational status of the department. Active departments are fully operational, inactive departments are temporarily not in use, suspended departments are under review or restructuring, and closed departments have been permanently disbanded.',
    `union_affiliation` STRING COMMENT 'Name of the labor union representing employees in this department, if applicable. Null for non-unionized departments. Used for labor relations, collective bargaining, and compliance with union agreements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this department record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Master reference table for department. Referenced by department_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`roster_cycle` (
    `roster_cycle_id` BIGINT COMMENT 'Primary key for roster_cycle',
    `preceding_roster_cycle_id` BIGINT COMMENT 'Self-referencing FK on roster_cycle (preceding_roster_cycle_id)',
    `applicable_site_types` STRING COMMENT 'Comma-separated list of mine site types where this roster cycle is applicable (e.g., underground, open_pit, processing_plant, port_facility). [ENUM-REF-CANDIDATE: underground|open_pit|processing_plant|port_facility|exploration|maintenance_facility|administrative — promote to reference product]',
    `approved_by` STRING COMMENT 'Name or identifier of the workforce manager or HR personnel who approved this roster cycle for operational use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this roster cycle was approved for operational use.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this roster cycle record was first created in the system.',
    `cycle_code` STRING COMMENT 'Business identifier code for the roster cycle pattern (e.g., FIFO_2_1, 4ON_3OFF). Used for external reference and reporting.',
    `cycle_name` STRING COMMENT 'Human-readable name describing the roster cycle pattern (e.g., Fly-In Fly-Out 2 weeks on 1 week off, Four On Three Off).',
    `cycle_type` STRING COMMENT 'Classification of the roster cycle based on work arrangement: fifo (Fly-In Fly-Out), dido (Drive-In Drive-Out), residential (on-site accommodation), local_commute (daily commute), offshore (marine/offshore operations), continuous (24/7 operations).',
    `roster_cycle_description` STRING COMMENT 'Detailed description of the roster cycle including shift patterns, rotation details, and any special conditions or requirements.',
    `effective_from_date` DATE COMMENT 'Date from which this roster cycle becomes active and available for assignment.',
    `effective_to_date` DATE COMMENT 'Date until which this roster cycle remains active. Null for open-ended cycles.',
    `fatigue_risk_rating` STRING COMMENT 'Assessed fatigue risk level associated with this roster cycle based on work hours, shift patterns, and rest periods. Used for ISO 45001 and MSHA compliance.',
    `hours_per_shift` DECIMAL(18,2) COMMENT 'Standard number of hours per shift within this roster cycle (e.g., 12.0 for twelve-hour shifts).',
    `is_continuous_operation` BOOLEAN COMMENT 'Indicates whether this roster cycle supports 24/7 continuous operations (True) or standard operational hours (False).',
    `max_consecutive_work_days` STRING COMMENT 'Maximum number of consecutive work days permitted under this roster cycle before mandatory rest period. Used for fatigue risk management.',
    `min_rest_hours_between_shifts` DECIMAL(18,2) COMMENT 'Minimum required rest hours between consecutive shifts to ensure fatigue management compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this roster cycle record was last modified.',
    `payroll_cycle_alignment` STRING COMMENT 'Indicates how this roster cycle aligns with payroll processing periods for SAP HR integration.',
    `requires_accommodation` BOOLEAN COMMENT 'Indicates whether workers on this roster cycle require on-site or company-provided accommodation (True for FIFO/DIDO/residential rosters).',
    `rest_days` STRING COMMENT 'Number of consecutive rest/off days in the roster cycle (e.g., 7 days for a 1-week-off roster).',
    `shifts_per_day` STRING COMMENT 'Number of shifts per 24-hour period in this roster cycle (e.g., 2 for day/night rotation, 3 for continuous operations).',
    `roster_cycle_status` STRING COMMENT 'Current lifecycle status of the roster cycle. Active cycles are available for assignment; deprecated cycles are retained for historical reference only.',
    `total_cycle_days` STRING COMMENT 'Total number of days in one complete roster cycle (work_days + rest_days). Used for scheduling and rotation planning.',
    `travel_allowance_eligible` BOOLEAN COMMENT 'Indicates whether workers on this roster cycle are eligible for travel allowances (typically True for FIFO/DIDO arrangements).',
    `union_agreement_reference` STRING COMMENT 'Reference to the enterprise bargaining agreement or union contract that governs this roster cycle arrangement.',
    `work_days` STRING COMMENT 'Number of consecutive work days in the roster cycle (e.g., 14 days for a 2-week-on roster).',
    CONSTRAINT pk_roster_cycle PRIMARY KEY(`roster_cycle_id`)
) COMMENT 'Master reference table for roster_cycle. Referenced by roster_cycle_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`accommodation_allocation` (
    `accommodation_allocation_id` BIGINT COMMENT 'Primary key for accommodation_allocation',
    `accommodation_unit_id` BIGINT COMMENT 'Reference to the specific accommodation unit (room, cabin, dormitory) allocated.',
    `approved_by_employee_id` BIGINT COMMENT 'Reference to the supervisor or manager who approved this accommodation allocation.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor assigned to this accommodation.',
    `roster_cycle_id` BIGINT COMMENT 'Reference to the roster cycle associated with this accommodation allocation, linking accommodation to shift patterns.',
    `site_id` BIGINT COMMENT 'Reference to the mine site where the accommodation is located.',
    `previous_accommodation_allocation_id` BIGINT COMMENT 'Self-referencing FK on accommodation_allocation (previous_accommodation_allocation_id)',
    `accessibility_required` BOOLEAN COMMENT 'Indicates whether the allocation requires accessibility features for persons with disabilities.',
    `allocation_number` STRING COMMENT 'Business-facing unique identifier for the accommodation allocation, used in operational communications and reporting.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the accommodation allocation. Tracks progression from initial request through active occupancy to completion or cancellation.',
    `allocation_type` STRING COMMENT 'Classification of the accommodation allocation based on the nature and duration of the assignment.',
    `approval_date` DATE COMMENT 'Date when the accommodation allocation was approved by the authorized approver.',
    `cancellation_date` DATE COMMENT 'Date when the accommodation allocation was cancelled.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the accommodation allocation was cancelled, if applicable.',
    `check_in_date` DATE COMMENT 'Date when the employee is scheduled to or did check into the allocated accommodation.',
    `check_out_date` DATE COMMENT 'Date when the employee is scheduled to or did check out of the allocated accommodation.',
    `compliance_verification_date` DATE COMMENT 'Date when compliance verification was completed for this accommodation allocation.',
    `compliance_verified` BOOLEAN COMMENT 'Indicates whether the accommodation allocation has been verified for compliance with Mine Safety and Health Administration (MSHA) and ISO 45001 requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accommodation allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the daily rate amount.',
    `daily_rate_amount` DECIMAL(18,2) COMMENT 'Daily charge or cost for the accommodation allocation, used for payroll deductions or cost allocation.',
    `effective_end_date` DATE COMMENT 'Date on which the accommodation allocation expires or is scheduled to terminate.',
    `effective_start_date` DATE COMMENT 'Date from which the accommodation allocation becomes effective and binding.',
    `extension_count` STRING COMMENT 'Number of times this accommodation allocation has been extended beyond its original end date.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this accommodation allocation record is currently active and valid for operational use.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accommodation allocation record was last updated or modified.',
    `meal_plan_included` BOOLEAN COMMENT 'Indicates whether a meal plan is included as part of the accommodation allocation.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the accommodation allocation for operational reference.',
    `occupancy_type` STRING COMMENT 'Type of occupancy arrangement for the allocated accommodation unit.',
    `payment_method` STRING COMMENT 'Method by which the accommodation cost is paid or recovered.',
    `priority_level` STRING COMMENT 'Priority classification for the accommodation allocation, used for allocation decisions during capacity constraints.',
    `special_requirements` STRING COMMENT 'Free-text description of any special accommodation requirements such as accessibility needs, medical considerations, or cultural preferences.',
    `transportation_provided` BOOLEAN COMMENT 'Indicates whether transportation between accommodation and work site is provided as part of the allocation.',
    CONSTRAINT pk_accommodation_allocation PRIMARY KEY(`accommodation_allocation_id`)
) COMMENT 'Master reference table for accommodation_allocation. Referenced by accommodation_allocation_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`accommodation_unit` (
    `accommodation_unit_id` BIGINT COMMENT 'Primary key for accommodation_unit',
    `adjacent_accommodation_unit_id` BIGINT COMMENT 'Self-referencing FK on accommodation_unit (adjacent_accommodation_unit_id)',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the unit meets accessibility standards for persons with disabilities.',
    `accommodation_facility_id` BIGINT COMMENT 'Reference to the parent accommodation facility or camp where this unit is located.',
    `asset_tag_number` STRING COMMENT 'Physical asset tag or inventory control number assigned to the accommodation unit.',
    `building_block` STRING COMMENT 'Building block, wing, or section identifier within the accommodation facility.',
    `commissioning_date` DATE COMMENT 'Date when the accommodation unit was first commissioned and made available for occupancy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accommodation unit record was first created in the system.',
    `current_occupancy_count` STRING COMMENT 'Current number of persons occupying this unit.',
    `daily_rate_amount` DECIMAL(18,2) COMMENT 'Standard daily rate charged for occupancy of this accommodation unit.',
    `decommissioning_date` DATE COMMENT 'Date when the accommodation unit was decommissioned and removed from service.',
    `emergency_exit_accessible` BOOLEAN COMMENT 'Indicates whether the unit has accessible emergency exit routes.',
    `fire_safety_compliant` BOOLEAN COMMENT 'Indicates whether the unit meets fire safety standards and regulations.',
    `floor_level` STRING COMMENT 'Floor or level where the accommodation unit is located (e.g., Ground, 1, 2, Basement).',
    `furnishing_standard` STRING COMMENT 'Classification of the furnishing and amenity level provided in the unit.',
    `gender_allocation` STRING COMMENT 'Gender allocation policy for the accommodation unit.',
    `has_air_conditioning` BOOLEAN COMMENT 'Indicates whether the unit is equipped with air conditioning.',
    `has_ensuite_bathroom` BOOLEAN COMMENT 'Indicates whether the unit has a private ensuite bathroom.',
    `has_heating` BOOLEAN COMMENT 'Indicates whether the unit is equipped with heating system.',
    `has_internet_access` BOOLEAN COMMENT 'Indicates whether the unit has internet connectivity available.',
    `last_maintenance_date` DATE COMMENT 'Date when the unit last underwent maintenance or inspection.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this accommodation unit record was last modified.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date when the next scheduled maintenance or inspection is planned.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the accommodation unit.',
    `occupancy_capacity` STRING COMMENT 'Maximum number of persons that can be accommodated in this unit.',
    `ownership_type` STRING COMMENT 'Classification of the ownership or tenure arrangement for the accommodation unit.',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the daily rate amount.',
    `smoking_policy` STRING COMMENT 'Smoking policy applicable to the accommodation unit.',
    `unit_area_sqm` DECIMAL(18,2) COMMENT 'Total floor area of the accommodation unit measured in square meters.',
    `unit_name` STRING COMMENT 'Human-readable name or label for the accommodation unit.',
    `unit_number` STRING COMMENT 'The externally-known unique identifier or code for the accommodation unit (e.g., room number, cabin number, unit designation).',
    `unit_status` STRING COMMENT 'Current operational status of the accommodation unit in its lifecycle.',
    `unit_type` STRING COMMENT 'Classification of the accommodation unit based on its configuration and capacity.',
    CONSTRAINT pk_accommodation_unit PRIMARY KEY(`accommodation_unit_id`)
) COMMENT 'Master reference table for accommodation_unit. Referenced by accommodation_unit_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`workforce`.`competency_framework` (
    `competency_framework_id` BIGINT COMMENT 'Primary key for competency_framework',
    `parent_competency_framework_id` BIGINT COMMENT 'Self-referencing FK on competency_framework (parent_competency_framework_id)',
    `applicable_roles` STRING COMMENT 'Comma-separated list or description of job roles to which this competency framework applies (e.g., drill operators, blast crew, maintenance technicians).',
    `applicable_sites` STRING COMMENT 'Mining sites or operational locations where this competency framework is applicable. May be all sites or specific locations.',
    `approval_authority` STRING COMMENT 'Role or position title of the authority responsible for approving changes to this competency framework.',
    `assessment_method` STRING COMMENT 'Primary method used to assess competency against this framework.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether formal certification is required upon successful completion of competencies within this framework.',
    `competency_level_count` STRING COMMENT 'Number of proficiency levels defined within this competency framework (e.g., beginner, intermediate, advanced, expert).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this competency framework record was first created in the system.',
    `competency_framework_description` STRING COMMENT 'Detailed description of the competency framework including its purpose, scope, and application within mining operations.',
    `digital_badge_enabled_flag` BOOLEAN COMMENT 'Indicates whether successful completion of this competency framework results in issuance of a digital badge or credential.',
    `effective_date` DATE COMMENT 'Date when this version of the competency framework becomes active and applicable to workforce assessments.',
    `expiry_date` DATE COMMENT 'Date when this competency framework version is no longer valid or has been superseded by a newer version. Null for frameworks without expiration.',
    `external_framework_id` STRING COMMENT 'Identifier used for this competency framework in external systems such as SAP HR or learning management systems.',
    `framework_category` STRING COMMENT 'Categorization indicating the strategic importance and maturity of the competency framework.',
    `framework_code` STRING COMMENT 'Unique business identifier code for the competency framework used across systems and documentation.',
    `framework_name` STRING COMMENT 'Full descriptive name of the competency framework.',
    `framework_type` STRING COMMENT 'Classification of the competency framework by its primary focus area within mining operations.',
    `industry_standard_reference` STRING COMMENT 'Reference to external industry standards or frameworks that this competency framework aligns with, such as MSHA regulations or ISO 45001 requirements.',
    `integration_system_code` STRING COMMENT 'Code identifying the external system (e.g., SAP HR, LMS) where this competency framework is synchronized or originated.',
    `language_available` STRING COMMENT 'Languages in which this competency framework documentation and assessments are available, using ISO 639-1 codes.',
    `last_review_date` DATE COMMENT 'Date when this competency framework was last reviewed for accuracy, relevance, and regulatory compliance.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this competency framework is mandatory for specific roles or operations within the mining organization.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this competency framework record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this competency framework to ensure continued relevance and compliance.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this competency framework.',
    `owner_department` STRING COMMENT 'Department or business unit responsible for maintaining and governing this competency framework (e.g., HR, HSE, Operations).',
    `prerequisite_frameworks` STRING COMMENT 'Comma-separated list of competency framework codes that must be completed before this framework can be undertaken.',
    `regulatory_alignment` STRING COMMENT 'Specific regulatory requirements or compliance standards that this competency framework addresses, including MSHA, ISO 45001, and local mining regulations.',
    `renewal_period_months` STRING COMMENT 'Number of months after which competency certification under this framework must be renewed or reassessed. Null if no renewal required.',
    `review_frequency_months` STRING COMMENT 'Standard interval in months between scheduled reviews of this competency framework.',
    `competency_framework_status` STRING COMMENT 'Current lifecycle status of the competency framework indicating its availability for use in workforce planning and training.',
    `training_hours_required` DECIMAL(18,2) COMMENT 'Total number of training hours typically required to achieve competency under this framework.',
    `version` STRING COMMENT 'Version number of the competency framework following semantic versioning to track revisions and updates.',
    CONSTRAINT pk_competency_framework PRIMARY KEY(`competency_framework_id`)
) COMMENT 'Master reference table for competency_framework. Referenced by competency_framework_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ADD CONSTRAINT `fk_workforce_contractor_roster_id` FOREIGN KEY (`roster_id`) REFERENCES `mining_ecm`.`workforce`.`roster`(`roster_id`);
ALTER TABLE `mining_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reporting_position_id` FOREIGN KEY (`reporting_position_id`) REFERENCES `mining_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `mining_ecm`.`workforce`.`roster` ADD CONSTRAINT `fk_workforce_roster_department_id` FOREIGN KEY (`department_id`) REFERENCES `mining_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `mining_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_department_id` FOREIGN KEY (`department_id`) REFERENCES `mining_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_primary_shift_employee_id` FOREIGN KEY (`primary_shift_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_roster_id` FOREIGN KEY (`roster_id`) REFERENCES `mining_ecm`.`workforce`.`roster`(`roster_id`);
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ADD CONSTRAINT `fk_workforce_fatigue_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ADD CONSTRAINT `fk_workforce_fatigue_record_roster_id` FOREIGN KEY (`roster_id`) REFERENCES `mining_ecm`.`workforce`.`roster`(`roster_id`);
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ADD CONSTRAINT `fk_workforce_fatigue_record_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `mining_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `mining_ecm`.`workforce`.`competency` ADD CONSTRAINT `fk_workforce_competency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`competency` ADD CONSTRAINT `fk_workforce_competency_competency_employee_id` FOREIGN KEY (`competency_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ADD CONSTRAINT `fk_workforce_training_enrolment_previous_enrolment_training_enrolment_id` FOREIGN KEY (`previous_enrolment_training_enrolment_id`) REFERENCES `mining_ecm`.`workforce`.`training_enrolment`(`training_enrolment_id`);
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ADD CONSTRAINT `fk_workforce_training_enrolment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ADD CONSTRAINT `fk_workforce_training_enrolment_tertiary_training_assessor_employee_id` FOREIGN KEY (`tertiary_training_assessor_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ADD CONSTRAINT `fk_workforce_training_enrolment_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `mining_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ADD CONSTRAINT `fk_workforce_medical_fitness_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ADD CONSTRAINT `fk_workforce_employment_agreement_superseded_agreement_employment_agreement_id` FOREIGN KEY (`superseded_agreement_employment_agreement_id`) REFERENCES `mining_ecm`.`workforce`.`employment_agreement`(`employment_agreement_id`);
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ADD CONSTRAINT `fk_workforce_labour_case_department_id` FOREIGN KEY (`department_id`) REFERENCES `mining_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ADD CONSTRAINT `fk_workforce_labour_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ADD CONSTRAINT `fk_workforce_labour_case_quaternary_labour_employee_id` FOREIGN KEY (`quaternary_labour_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ADD CONSTRAINT `fk_workforce_labour_case_tertiary_labour_investigator_employee_id` FOREIGN KEY (`tertiary_labour_investigator_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_department_id` FOREIGN KEY (`department_id`) REFERENCES `mining_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `mining_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_roster_id` FOREIGN KEY (`roster_id`) REFERENCES `mining_ecm`.`workforce`.`roster`(`roster_id`);
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ADD CONSTRAINT `fk_workforce_mobilisation_accommodation_allocation_id` FOREIGN KEY (`accommodation_allocation_id`) REFERENCES `mining_ecm`.`workforce`.`accommodation_allocation`(`accommodation_allocation_id`);
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ADD CONSTRAINT `fk_workforce_mobilisation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ADD CONSTRAINT `fk_workforce_mobilisation_roster_cycle_id` FOREIGN KEY (`roster_cycle_id`) REFERENCES `mining_ecm`.`workforce`.`roster_cycle`(`roster_cycle_id`);
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ADD CONSTRAINT `fk_workforce_mobilisation_return_mobilisation_id` FOREIGN KEY (`return_mobilisation_id`) REFERENCES `mining_ecm`.`workforce`.`mobilisation`(`mobilisation_id`);
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ADD CONSTRAINT `fk_workforce_workforce_project_contract_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `mining_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ADD CONSTRAINT `fk_workforce_contractor_tenement_engagement_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `mining_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ADD CONSTRAINT `fk_workforce_position_competency_requirement_competency_id` FOREIGN KEY (`competency_id`) REFERENCES `mining_ecm`.`workforce`.`competency`(`competency_id`);
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ADD CONSTRAINT `fk_workforce_position_competency_requirement_position_id` FOREIGN KEY (`position_id`) REFERENCES `mining_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `mining_ecm`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_competency_framework_id` FOREIGN KEY (`competency_framework_id`) REFERENCES `mining_ecm`.`workforce`.`competency_framework`(`competency_framework_id`);
ALTER TABLE `mining_ecm`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_parent_department_id` FOREIGN KEY (`parent_department_id`) REFERENCES `mining_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `mining_ecm`.`workforce`.`roster_cycle` ADD CONSTRAINT `fk_workforce_roster_cycle_preceding_roster_cycle_id` FOREIGN KEY (`preceding_roster_cycle_id`) REFERENCES `mining_ecm`.`workforce`.`roster_cycle`(`roster_cycle_id`);
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_allocation` ADD CONSTRAINT `fk_workforce_accommodation_allocation_accommodation_unit_id` FOREIGN KEY (`accommodation_unit_id`) REFERENCES `mining_ecm`.`workforce`.`accommodation_unit`(`accommodation_unit_id`);
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_allocation` ADD CONSTRAINT `fk_workforce_accommodation_allocation_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_allocation` ADD CONSTRAINT `fk_workforce_accommodation_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `mining_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_allocation` ADD CONSTRAINT `fk_workforce_accommodation_allocation_roster_cycle_id` FOREIGN KEY (`roster_cycle_id`) REFERENCES `mining_ecm`.`workforce`.`roster_cycle`(`roster_cycle_id`);
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_allocation` ADD CONSTRAINT `fk_workforce_accommodation_allocation_previous_accommodation_allocation_id` FOREIGN KEY (`previous_accommodation_allocation_id`) REFERENCES `mining_ecm`.`workforce`.`accommodation_allocation`(`accommodation_allocation_id`);
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_unit` ADD CONSTRAINT `fk_workforce_accommodation_unit_adjacent_accommodation_unit_id` FOREIGN KEY (`adjacent_accommodation_unit_id`) REFERENCES `mining_ecm`.`workforce`.`accommodation_unit`(`accommodation_unit_id`);
ALTER TABLE `mining_ecm`.`workforce`.`competency_framework` ADD CONSTRAINT `fk_workforce_competency_framework_parent_competency_framework_id` FOREIGN KEY (`parent_competency_framework_id`) REFERENCES `mining_ecm`.`workforce`.`competency_framework`(`competency_framework_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `mining_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `mining_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on-leave|suspended|terminated');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full-time|part-time|casual|fixed-term');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `fte` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non-binary|prefer not to say');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `induction_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Site Induction Completed Date');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `induction_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Site Induction Expiry Date');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `medical_fitness_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Fitness Expiry Date');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `medical_fitness_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Fitness Status');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_value_regex' = 'fit|fit-with-restrictions|temporarily-unfit|permanently-unfit');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `ppe_size_boots` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Boot Size');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `ppe_size_hardhat` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Hard Hat Size');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `ppe_size_hardhat` SET TAGS ('dbx_value_regex' = 'S|M|L|XL');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `ppe_size_pants` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Pants Size');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `ppe_size_shirt` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Shirt Size');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `sap_personnel_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Personnel Number');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `sap_personnel_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `site_assignment` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Assignment');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'resignation|retirement|redundancy|dismissal|end-of-contract|deceased');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `union_membership` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Status');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `mining_ecm`.`workforce`.`employee` ALTER COLUMN `work_schedule_pattern` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Pattern');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `procurement_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Company Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `roster_id` SET TAGS ('dbx_business_glossary_term' = 'Roster Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `abn` SET TAGS ('dbx_business_glossary_term' = 'Australian Business Number (ABN)');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `abn` SET TAGS ('dbx_value_regex' = '^d{11}$');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `abn` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `abn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `contract_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `contractor_number` SET TAGS ('dbx_business_glossary_term' = 'Contractor Number');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `contractor_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `contractor_status` SET TAGS ('dbx_business_glossary_term' = 'Contractor Status');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `contractor_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|terminated|completed');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contractor Email Address');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Contractor Engagement Type');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Family Name');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Given Name');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `given_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `induction_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Induction Completion Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `induction_status` SET TAGS ('dbx_business_glossary_term' = 'Site Induction Status');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `induction_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|expired|refresher_required');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `insurance_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance and Indemnity Status');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `insurance_status` SET TAGS ('dbx_value_regex' = 'current|expiring_soon|expired|not_provided|under_review');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `maximum_engagement_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Engagement Duration (Days)');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Assessment Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_assessment_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_assessment_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Fitness Expiry Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Fitness Status');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_value_regex' = 'fit|fit_with_restrictions|temporarily_unfit|permanently_unfit|assessment_pending');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Contractor Mobile Phone Number');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contractor Notes');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `rehire_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible Flag');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `site_access_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Site Access Clearance Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `site_access_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Site Access Clearance Status');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `site_access_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|approved|suspended|revoked|expired');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `site_access_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Site Access Expiry Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `statutory_role_authorisation` SET TAGS ('dbx_business_glossary_term' = 'Statutory Role Authorisation');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `tax_file_number` SET TAGS ('dbx_business_glossary_term' = 'Tax File Number (TFN)');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `tax_file_number` SET TAGS ('dbx_value_regex' = '^d{8,9}$');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `tax_file_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `tax_file_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `trade_classification` SET TAGS ('dbx_business_glossary_term' = 'Trade Classification');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `mining_ecm`.`workforce`.`contractor` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'fifo|dido|residential|local|remote');
ALTER TABLE `mining_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Employee Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `reporting_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Position Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `contractor_employee_ratio` SET TAGS ('dbx_business_glossary_term' = 'Contractor to Employee Ratio');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `critical_skills_gap` SET TAGS ('dbx_business_glossary_term' = 'Critical Skills Gap');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `critical_skills_gap` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `direct_reports_count` SET TAGS ('dbx_business_glossary_term' = 'Direct Reports Count');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `fifo_residential_split` SET TAGS ('dbx_business_glossary_term' = 'Fly-In Fly-Out (FIFO) to Residential Split');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `fifo_residential_split` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}/[0-9]{1,3}$');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `grade_band` SET TAGS ('dbx_business_glossary_term' = 'Grade Band');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `grade_band` SET TAGS ('dbx_value_regex' = '^[A-E][1-5]$');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `grade_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `headcount_budget` SET TAGS ('dbx_business_glossary_term' = 'Headcount Budget');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `is_leadership_role` SET TAGS ('dbx_business_glossary_term' = 'Is Leadership Role');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `is_statutory_role` SET TAGS ('dbx_business_glossary_term' = 'Is Statutory Role');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `lom_alignment` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Alignment');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `lom_alignment` SET TAGS ('dbx_value_regex' = 'permanent|lom_aligned|project_based|temporary');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `planned_headcount_fy` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount Financial Year (FY)');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `planned_headcount_fy_plus_1` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount Financial Year (FY) Plus 1');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `planned_headcount_fy_plus_2` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount Financial Year (FY) Plus 2');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|vacant|frozen|planned|closed');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `roster_pattern` SET TAGS ('dbx_business_glossary_term' = 'Roster Pattern');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `succession_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Status');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `succession_plan_status` SET TAGS ('dbx_value_regex' = 'no_plan|identified|in_development|ready_now');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `workforce_type` SET TAGS ('dbx_business_glossary_term' = 'Workforce Type');
ALTER TABLE `mining_ecm`.`workforce`.`position` ALTER COLUMN `workforce_type` SET TAGS ('dbx_value_regex' = 'employee|contractor|casual|fifo|residential');
ALTER TABLE `mining_ecm`.`workforce`.`roster` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`roster` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `roster_id` SET TAGS ('dbx_business_glossary_term' = 'Roster ID');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `accommodation_type` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Type');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `accommodation_type` SET TAGS ('dbx_value_regex' = 'Camp Single|Camp Shared|Hotel|Self-Arranged|Not Applicable');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `allowance_code` SET TAGS ('dbx_business_glossary_term' = 'Allowance Code');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `allowance_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `annual_leave_accrual_rate` SET TAGS ('dbx_business_glossary_term' = 'Annual Leave Accrual Rate');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `cycle_length_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Length (Days)');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `days_off` SET TAGS ('dbx_business_glossary_term' = 'Days Off');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `days_on` SET TAGS ('dbx_business_glossary_term' = 'Days On');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `demobilisation_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Demobilisation Lead Time (Days)');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `fatigue_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Rating');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `fatigue_risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `maximum_consecutive_shifts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Consecutive Shifts');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `minimum_rest_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rest Hours');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `mobilisation_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Mobilisation Lead Time (Days)');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Roster Notes');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `overtime_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility Flag');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `roster_code` SET TAGS ('dbx_business_glossary_term' = 'Roster Code');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `roster_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `roster_name` SET TAGS ('dbx_business_glossary_term' = 'Roster Name');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `roster_status` SET TAGS ('dbx_business_glossary_term' = 'Roster Status');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `roster_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending|Retired');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `roster_type` SET TAGS ('dbx_business_glossary_term' = 'Roster Type');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `roster_type` SET TAGS ('dbx_value_regex' = 'FIFO|DIDO|Residential|Casual|Contractor');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `shift_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration (Hours)');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'Day Only|Night Only|Day-Night Rotating|Continental|Split Shift|Flexible');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `mining_ecm`.`workforce`.`roster` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'Charter Flight|Commercial Flight|Bus|Private Vehicle|Not Applicable');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `drill_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `primary_shift_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Supervisor Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `primary_shift_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `primary_shift_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `roster_id` SET TAGS ('dbx_business_glossary_term' = 'Roster Cycle Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `actual_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `actual_production_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Actual Production in Tonnes');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `equipment_availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Equipment Availability Percentage');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `fatigue_override_approved` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Override Approved Flag');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `fatigue_risk_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Assessment Completed Flag');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `fatigue_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Level');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `fatigue_risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Count');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `payroll_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Integration Status');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `payroll_integration_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|approved|rejected|processed');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `payroll_submission_datetime` SET TAGS ('dbx_business_glossary_term' = 'Payroll Submission Date and Time');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `planned_headcount` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `production_area` SET TAGS ('dbx_business_glossary_term' = 'Production Area');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `production_target_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Production Target in Tonnes');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `safety_briefing_completed` SET TAGS ('dbx_business_glossary_term' = 'Safety Briefing Completed Flag');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `safety_briefing_datetime` SET TAGS ('dbx_business_glossary_term' = 'Safety Briefing Date and Time');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Duration in Hours');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_handover_notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Handover Notes');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_number` SET TAGS ('dbx_business_glossary_term' = 'Shift Number');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_priority` SET TAGS ('dbx_business_glossary_term' = 'Shift Priority');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Status');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|afternoon|swing|rotating');
ALTER TABLE `mining_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` SET TAGS ('dbx_subdomain' = 'health_safety');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `fatigue_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Record Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `roster_id` SET TAGS ('dbx_business_glossary_term' = 'Roster Cycle ID');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `assessment_datetime` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date and Time');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `assessment_location` SET TAGS ('dbx_business_glossary_term' = 'Assessment Location');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Management System (FRMS) Assessment Method');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'FRMS|Biomathematical Model|Self-Report|Supervisor Observation|Fitness for Work Test|Actigraphy');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_value_regex' = 'Fit for Work|Unfit for Work|Restricted Duties|Referred for Medical Review');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `assessment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Assessment Trigger');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `assessment_trigger` SET TAGS ('dbx_value_regex' = 'Scheduled Pre-Start|Random Check|Supervisor Concern|Self-Report|Post-Incident|Extended Hours Threshold');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Exemption Granted');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `consecutive_days_on_site` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Days On-Site');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `cumulative_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Hours Worked');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `exemption_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Exemption Approved By');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `fatigue_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Level');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `fatigue_risk_level` SET TAGS ('dbx_value_regex' = 'Low|Moderate|High|Severe');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `fatigue_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Score');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `follow_up_due_datetime` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date and Time');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `previous_assessment_datetime` SET TAGS ('dbx_business_glossary_term' = 'Previous Assessment Date and Time');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `previous_fatigue_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Previous Fatigue Risk Score');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `sleep_opportunity_hours` SET TAGS ('dbx_business_glossary_term' = 'Sleep Opportunity Hours');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `time_of_day_category` SET TAGS ('dbx_business_glossary_term' = 'Time of Day Category');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `time_of_day_category` SET TAGS ('dbx_value_regex' = 'Day Shift|Night Shift|Swing Shift|Circadian Low Point');
ALTER TABLE `mining_ecm`.`workforce`.`fatigue_record` ALTER COLUMN `work_restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Work Restriction Description');
ALTER TABLE `mining_ecm`.`workforce`.`competency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`competency` SET TAGS ('dbx_subdomain' = 'training_development');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Competency ID');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor ID');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `competency_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `competency_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `competency_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `applicable_role` SET TAGS ('dbx_business_glossary_term' = 'Applicable Role or Position');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score or Result');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `attainment_date` SET TAGS ('dbx_business_glossary_term' = 'Competency Attainment Date');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `attainment_status` SET TAGS ('dbx_business_glossary_term' = 'Competency Attainment Status');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `attainment_status` SET TAGS ('dbx_value_regex' = 'current|expiring_soon|expired|suspended|revoked|pending_renewal');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `competency_category` SET TAGS ('dbx_business_glossary_term' = 'Competency Category');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `competency_code` SET TAGS ('dbx_business_glossary_term' = 'Competency Code');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `competency_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `competency_name` SET TAGS ('dbx_business_glossary_term' = 'Competency Name');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `competency_type` SET TAGS ('dbx_business_glossary_term' = 'Competency Type');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `competency_type` SET TAGS ('dbx_value_regex' = 'statutory|operational|safety|technical|leadership|environmental');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `cost_per_attainment` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Attainment');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `cost_per_attainment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference or Document Link');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `expiry_alert_days` SET TAGS ('dbx_business_glossary_term' = 'Expiry Alert Threshold (Days)');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Competency Expiry Date');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body or Regulator');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body or Organization');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Competency Flag');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Competency Notes or Comments');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `pass_threshold` SET TAGS ('dbx_business_glossary_term' = 'Pass Threshold or Minimum Score');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `prerequisite_competencies` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Competencies');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `renewal_method` SET TAGS ('dbx_business_glossary_term' = 'Renewal Method');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `renewal_method` SET TAGS ('dbx_value_regex' = 'reassessment|refresher_training|continuing_education|reexamination|automatic');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `required_proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Required Proficiency Level');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `required_proficiency_level` SET TAGS ('dbx_value_regex' = 'awareness|basic|intermediate|advanced|expert');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `site_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'Site-Specific Competency Flag');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration (Hours)');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider or Organization');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period (Months)');
ALTER TABLE `mining_ecm`.`workforce`.`competency` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By (Worker ID)');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'training_development');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'written_exam|practical_demonstration|simulation|observation|portfolio|none');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `certificate_validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Certificate Validity Period in Months');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `competency_framework_code` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Code');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Participant');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `course_content_summary` SET TAGS ('dbx_business_glossary_term' = 'Course Content Summary');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `course_materials_provided` SET TAGS ('dbx_business_glossary_term' = 'Course Materials Provided');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Course Name');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|retired|pending_approval');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `course_type` SET TAGS ('dbx_value_regex' = 'initial|refresher|recertification|advanced|specialized');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'classroom|online|blended|on_the_job|simulation|field_practical');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Duration in Days');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration in Hours');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `iso_45001_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Compliance Flag');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `language_of_delivery` SET TAGS ('dbx_business_glossary_term' = 'Language of Delivery');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `language_of_delivery` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `learning_objectives` SET TAGS ('dbx_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `linked_competencies` SET TAGS ('dbx_business_glossary_term' = 'Linked Competencies');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `maximum_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `msha_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Mine Safety and Health Administration (MSHA) Compliance Flag');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `pass_mark_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pass Mark Percentage');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `prerequisite_courses` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Courses');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `provider_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Provider Accreditation Number');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Name');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `refresher_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Refresher Required Flag');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `mining_ecm`.`workforce`.`training_course` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` SET TAGS ('dbx_subdomain' = 'training_development');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `training_enrolment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrolment ID');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `previous_enrolment_training_enrolment_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Enrolment ID');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `tertiary_training_assessor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor ID');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `tertiary_training_assessor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `tertiary_training_assessor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `access_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Access Clearance Date');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `access_clearance_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Access Clearance Granted Flag');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `attendance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attendance Percentage');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `competency_level_achieved` SET TAGS ('dbx_business_glossary_term' = 'Competency Level Achieved');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `competency_level_achieved` SET TAGS ('dbx_value_regex' = 'foundation|intermediate|advanced|expert|not_achieved');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|online|on_the_job|blended|simulation|field_demonstration');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `enrolment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrolment Date');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `enrolment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrolment Status');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `enrolment_status` SET TAGS ('dbx_value_regex' = 'enrolled|in_progress|completed|withdrawn|failed|expired');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `induction_modules_completed` SET TAGS ('dbx_business_glossary_term' = 'Induction Modules Completed');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `induction_type` SET TAGS ('dbx_business_glossary_term' = 'Induction Type');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `induction_type` SET TAGS ('dbx_value_regex' = 'site_general|area_specific|task_specific|contractor|visitor|emergency_response');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `mandatory_training_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `refresher_training_flag` SET TAGS ('dbx_business_glossary_term' = 'Refresher Training Flag');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `scheduled_training_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Training Date');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `training_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Completed');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `training_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Required');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `training_outcome` SET TAGS ('dbx_business_glossary_term' = 'Training Outcome');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `training_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|incomplete|not_assessed|withdrawn');
ALTER TABLE `mining_ecm`.`workforce`.`training_enrolment` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` SET TAGS ('dbx_subdomain' = 'health_safety');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_fitness_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Fitness Assessment ID');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_fitness_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_fitness_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_location` SET TAGS ('dbx_business_glossary_term' = 'Assessment Location');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_location` SET TAGS ('dbx_value_regex' = 'on-site-clinic|off-site-facility|mobile-unit|remote-telehealth');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_time` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'pre-employment|periodic|return-to-work|task-specific|drug-alcohol-screening|exit');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `audiogram_baseline_established` SET TAGS ('dbx_business_glossary_term' = 'Audiogram Baseline Established');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `biological_markers_tested` SET TAGS ('dbx_business_glossary_term' = 'Biological Markers Tested');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `biological_markers_tested` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `biological_markers_tested` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `biological_monitoring_conducted` SET TAGS ('dbx_business_glossary_term' = 'Biological Monitoring Conducted');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `biological_monitoring_result` SET TAGS ('dbx_business_glossary_term' = 'Biological Monitoring Result');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `biological_monitoring_result` SET TAGS ('dbx_value_regex' = 'within-limits|elevated|action-level-exceeded|medical-removal-required');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `biological_monitoring_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `biological_monitoring_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Certificate Expiry Date');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Certificate Number');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending|exemption-granted');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_conducted` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol (D&A) Test Conducted');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_datetime` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol (D&A) Test Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_datetime` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_datetime` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_method` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol (D&A) Test Method');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_method` SET TAGS ('dbx_value_regex' = 'urine|breath|saliva|blood|hair-follicle');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_result` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol (D&A) Test Result');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|inconclusive|refused|not-tested');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `examining_physician_name` SET TAGS ('dbx_business_glossary_term' = 'Examining Physician Name');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `examining_physician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `exemption_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Exemption Approved By');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `fitness_outcome` SET TAGS ('dbx_business_glossary_term' = 'Fitness Outcome');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `fitness_outcome` SET TAGS ('dbx_value_regex' = 'fit|fit-with-restrictions|temporarily-unfit|permanently-unfit|pending-review');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `fitness_outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Fitness Outcome Date');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_clearance_certificate_issued` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Certificate Issued');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_clearance_certificate_issued` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_clearance_certificate_issued` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Facility Name');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `nihl_monitoring_conducted` SET TAGS ('dbx_business_glossary_term' = 'Noise-Induced Hearing Loss (NIHL) Monitoring Conducted');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `nihl_monitoring_result` SET TAGS ('dbx_business_glossary_term' = 'Noise-Induced Hearing Loss (NIHL) Monitoring Result');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `nihl_monitoring_result` SET TAGS ('dbx_value_regex' = 'normal|threshold-shift-detected|significant-hearing-loss|follow-up-required');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `nihl_monitoring_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `nihl_monitoring_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `respiratory_function_result` SET TAGS ('dbx_business_glossary_term' = 'Respiratory Function Test Result');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `respiratory_function_result` SET TAGS ('dbx_value_regex' = 'normal|mild-impairment|moderate-impairment|severe-impairment|follow-up-required');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `respiratory_function_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `respiratory_function_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `respiratory_function_test_conducted` SET TAGS ('dbx_business_glossary_term' = 'Respiratory Function Test Conducted');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `restricted_tasks` SET TAGS ('dbx_business_glossary_term' = 'Restricted Tasks');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `restricted_tasks` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `restriction_category` SET TAGS ('dbx_business_glossary_term' = 'Restriction Category');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `restriction_category` SET TAGS ('dbx_value_regex' = 'physical-limitation|environmental-restriction|task-restriction|equipment-restriction|none');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `restriction_details` SET TAGS ('dbx_business_glossary_term' = 'Restriction Details');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `restriction_details` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `substances_detected` SET TAGS ('dbx_business_glossary_term' = 'Substances Detected');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `substances_detected` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `substances_detected` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `vision_test_conducted` SET TAGS ('dbx_business_glossary_term' = 'Vision Test Conducted');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `vision_test_result` SET TAGS ('dbx_business_glossary_term' = 'Vision Test Result');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `vision_test_result` SET TAGS ('dbx_value_regex' = 'meets-standard|corrective-lenses-required|does-not-meet-standard|follow-up-required');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `vision_test_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `vision_test_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Identifier (ID)');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,20}$');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_bsb_code` SET TAGS ('dbx_business_glossary_term' = 'Bank State Branch (BSB) Code');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_bsb_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `base_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Payment Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `fifo_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Fly-In Fly-Out (FIFO) Allowance Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Garnishment Deduction Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `leading_hand_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Leading Hand Allowance Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `leave_hours_paid` SET TAGS ('dbx_business_glossary_term' = 'Leave Hours Paid');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Notes');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `other_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_run_reference` SET TAGS ('dbx_business_glossary_term' = 'Pay Run Reference Number');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_run_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'electronic_funds_transfer|cheque|cash|payroll_card');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_area` SET TAGS ('dbx_business_glossary_term' = 'Payroll Area Code');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Status');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_value_regex' = 'draft|approved|processed|paid|reversed|cancelled');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `shift_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Allowance Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `site_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Site Allowance Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `superannuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Superannuation Contribution Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withheld Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions Amount');
ALTER TABLE `mining_ecm`.`workforce`.`payroll_record` ALTER COLUMN `union_dues_amount` SET TAGS ('dbx_business_glossary_term' = 'Union Dues Deduction Amount');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `employment_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Agreement Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `superseded_agreement_employment_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Agreement ID');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'EBA|AWA|Individual Contract|Collective Agreement|Modern Award|Common Law Contract');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `annual_leave_entitlement_weeks` SET TAGS ('dbx_business_glossary_term' = 'Annual Leave Entitlement Weeks');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `ballot_approval_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ballot Approval Percentage');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `ballot_date` SET TAGS ('dbx_business_glossary_term' = 'Ballot Date');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Rate');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `dispute_resolution_process` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Process');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `employer_party` SET TAGS ('dbx_business_glossary_term' = 'Employer Party');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `lodgement_date` SET TAGS ('dbx_business_glossary_term' = 'Lodgement Date');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `maximum_consecutive_shifts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Consecutive Shifts');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `minimum_rest_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rest Hours');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `nominal_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Nominal Expiry Date');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `notice_period_weeks` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Weeks');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate Multiplier');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `pay_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Unit');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `pay_rate_unit` SET TAGS ('dbx_value_regex' = 'Hourly|Daily|Annual|Per Shift');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `redundancy_entitlement_weeks` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Entitlement Weeks');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `redundancy_entitlement_weeks` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `regulatory_lodgement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Lodgement Reference');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `shift_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Allowance Amount');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `shift_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `union_party` SET TAGS ('dbx_business_glossary_term' = 'Union Party');
ALTER TABLE `mining_ecm`.`workforce`.`employment_agreement` ALTER COLUMN `workforce_classification` SET TAGS ('dbx_business_glossary_term' = 'Workforce Classification');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `labour_case_id` SET TAGS ('dbx_business_glossary_term' = 'Labour Case ID');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident ID');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Employee ID');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `quaternary_labour_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner ID');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `quaternary_labour_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `quaternary_labour_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `tertiary_labour_investigator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator Employee ID');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `tertiary_labour_investigator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `tertiary_labour_investigator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `appeal_lodgement_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Lodgement Date');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'original_decision_upheld|decision_overturned|decision_modified|appeal_withdrawn');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'no_appeal|appeal_lodged|appeal_in_progress|appeal_upheld|appeal_dismissed');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Case Category');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^LC-[0-9]{8}$');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_review|resolved|closed|escalated');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'disciplinary|grievance|dispute|appeal|investigation|performance');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `escalation_history` SET TAGS ('dbx_business_glossary_term' = 'Escalation History');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `escalation_history` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `fair_work_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Fair Work Notification Date');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `fair_work_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Work Notification Flag');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `incident_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|suspended|cancelled');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `legal_representation_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Representation Flag');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `lodgement_date` SET TAGS ('dbx_business_glossary_term' = 'Lodgement Date');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `policy_breach_reference` SET TAGS ('dbx_business_glossary_term' = 'Policy Breach Reference');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `union_involvement_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Involvement Flag');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `union_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Union Representative Name');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `union_representative_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `witness_employee_ids` SET TAGS ('dbx_business_glossary_term' = 'Witness Employee IDs');
ALTER TABLE `mining_ecm`.`workforce`.`labour_case` ALTER COLUMN `witness_employee_ids` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`crew` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `roster_id` SET TAGS ('dbx_business_glossary_term' = 'Roster Pattern Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `competency_requirements` SET TAGS ('dbx_business_glossary_term' = 'Competency Requirements');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('dbx_business_glossary_term' = 'Crew Code');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `crew_name` SET TAGS ('dbx_business_glossary_term' = 'Crew Name');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `crew_status` SET TAGS ('dbx_business_glossary_term' = 'Crew Status');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `crew_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|disbanded|planned');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `crew_type` SET TAGS ('dbx_business_glossary_term' = 'Crew Type');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `crew_type` SET TAGS ('dbx_value_regex' = 'mining|processing|maintenance|drill_and_blast|load_and_haul|haulage');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `emergency_muster_point` SET TAGS ('dbx_business_glossary_term' = 'Emergency Muster Point');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `equipment_fleet_assignment` SET TAGS ('dbx_business_glossary_term' = 'Equipment Fleet Assignment');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `fatigue_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Rating');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `fatigue_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `maximum_consecutive_shifts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Consecutive Shifts');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `minimum_rest_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rest Hours');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `nominal_headcount` SET TAGS ('dbx_business_glossary_term' = 'Nominal Headcount');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Crew Notes');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `operational_area` SET TAGS ('dbx_business_glossary_term' = 'Operational Area');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `pre_start_meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Pre-Start Meeting Location');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `production_target_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Production Target Per Shift');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `production_target_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Target Unit');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `production_target_unit` SET TAGS ('dbx_value_regex' = 'tonnes|bcm|hours|meters|cycles');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `shift_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration Hours');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'day|night|swing|rotating|continuous');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `mining_ecm`.`workforce`.`crew` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `mobilisation_id` SET TAGS ('dbx_business_glossary_term' = 'Mobilisation ID');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `accommodation_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Allocation ID');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `roster_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Roster Cycle ID');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `return_mobilisation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `accommodation_check_in_datetime` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Check-In Date Time');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `accommodation_check_out_datetime` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Check-Out Date Time');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `accommodation_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Cost Amount');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `accommodation_type` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Type');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `accommodation_type` SET TAGS ('dbx_value_regex' = 'single_room|shared_room|donger|village_unit|hotel|motel');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `actual_demobilisation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Demobilisation Date Time');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `actual_mobilisation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Mobilisation Date Time');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `arrival_location` SET TAGS ('dbx_business_glossary_term' = 'Arrival Location');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `delay_reason` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `departure_location` SET TAGS ('dbx_business_glossary_term' = 'Departure Location');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `manifest_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Manifest Confirmed');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `medical_clearance_verified` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Verified');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `medical_clearance_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `medical_clearance_verified` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `mobilisation_number` SET TAGS ('dbx_business_glossary_term' = 'Mobilisation Number');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `mobilisation_status` SET TAGS ('dbx_business_glossary_term' = 'Mobilisation Status');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `mobilisation_type` SET TAGS ('dbx_business_glossary_term' = 'Mobilisation Type');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `mobilisation_type` SET TAGS ('dbx_value_regex' = 'mobilisation|demobilisation|rotation_change|emergency_mobilisation|emergency_demobilisation|site_transfer');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No Show Flag');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `pre_mobilisation_checklist_completed` SET TAGS ('dbx_business_glossary_term' = 'Pre-Mobilisation Checklist Completed');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `scheduled_demobilisation_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Demobilisation Date');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `scheduled_mobilisation_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Mobilisation Date');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `site_arrival_datetime` SET TAGS ('dbx_business_glossary_term' = 'Site Arrival Date Time');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `site_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Site Departure Date Time');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `site_induction_completed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Site Induction Completed Date Time');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `site_induction_required` SET TAGS ('dbx_business_glossary_term' = 'Site Induction Required');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `total_mobilisation_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Mobilisation Cost Amount');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `training_currency_verified` SET TAGS ('dbx_business_glossary_term' = 'Training Currency Verified');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `travel_booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Travel Booking Reference');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `travel_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Travel Cost Amount');
ALTER TABLE `mining_ecm`.`workforce`.`mobilisation` ALTER COLUMN `travel_provider` SET TAGS ('dbx_business_glossary_term' = 'Travel Provider');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` SET TAGS ('dbx_association_edges' = 'workforce.contractor,project.capital_project');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `workforce_project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'workforce_project_contract Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Contract - Capital Project Id');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Project Contract - Contractor Id');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Project Contract ID');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `practical_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Practical Completion Date');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `mining_ecm`.`workforce`.`workforce_project_contract` ALTER COLUMN `scope_summary` SET TAGS ('dbx_business_glossary_term' = 'Scope Summary');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` SET TAGS ('dbx_association_edges' = 'workforce.contractor,tenement.tenement');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `contractor_tenement_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'contractor_tenement_engagement Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Tenement Engagement - Contractor Id');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Tenement Engagement - Tenement Id');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `engagement_code` SET TAGS ('dbx_business_glossary_term' = 'Engagement Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `induction_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Induction Completion Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `induction_status` SET TAGS ('dbx_business_glossary_term' = 'Induction Status');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `scope_of_work` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `site_access_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Site Access Clearance Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `site_access_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Site Access Clearance Status');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `site_access_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Site Access Expiry Date');
ALTER TABLE `mining_ecm`.`workforce`.`contractor_tenement_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` SET TAGS ('dbx_subdomain' = 'training_development');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` SET TAGS ('dbx_association_edges' = 'workforce.position,workforce.competency');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `position_competency_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Position Competency Requirement ID');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Position Competency Requirement - Competency Id');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Competency Requirement - Position Id');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `onboarding_grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Grace Period Days');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `required_competencies` SET TAGS ('dbx_business_glossary_term' = 'Required Competencies');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `required_proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Required Proficiency Level');
ALTER TABLE `mining_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `verification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Verification Frequency Months');
ALTER TABLE `mining_ecm`.`workforce`.`department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`department` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `mining_ecm`.`workforce`.`department` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`department` ALTER COLUMN `budget_allocation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`department` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`department` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`roster_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`roster_cycle` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `mining_ecm`.`workforce`.`roster_cycle` ALTER COLUMN `roster_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Roster Cycle Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`roster_cycle` ALTER COLUMN `preceding_roster_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_allocation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_allocation` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_allocation` ALTER COLUMN `accommodation_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Allocation Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_allocation` ALTER COLUMN `previous_accommodation_allocation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_unit` SET TAGS ('dbx_subdomain' = 'operational_scheduling');
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_unit` ALTER COLUMN `accommodation_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Unit Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_unit` ALTER COLUMN `adjacent_accommodation_unit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`accommodation_unit` ALTER COLUMN `daily_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`workforce`.`competency_framework` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`workforce`.`competency_framework` SET TAGS ('dbx_subdomain' = 'training_development');
ALTER TABLE `mining_ecm`.`workforce`.`competency_framework` ALTER COLUMN `competency_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Identifier');
ALTER TABLE `mining_ecm`.`workforce`.`competency_framework` ALTER COLUMN `parent_competency_framework_id` SET TAGS ('dbx_self_ref_fk' = 'true');
