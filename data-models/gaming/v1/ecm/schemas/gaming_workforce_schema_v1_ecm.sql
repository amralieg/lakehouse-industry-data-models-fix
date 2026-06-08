-- Schema for Domain: workforce | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`workforce` COMMENT 'Manages all employee, contractor, and studio talent data including headcount planning, organizational structure, compensation, benefits, performance management, developer skill matrices, and HR records sourced from SAP S/4HANA HR module. Supports studio capacity planning for game development production scheduling and IGDA workforce standards compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key sourced from SAP S/4HANA HR module personnel number.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game studio to which the employee is assigned. Links to the studio master data for organizational hierarchy, project assignment, and capacity planning.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Employee is classified under a standardized job profile. Job profile is the master definition of role family, competencies, and career track. Removing job_family from employee as it is defined in job_',
    `manager_employee_id` BIGINT COMMENT 'Employee ID of the direct manager or supervisor. Establishes reporting hierarchy for organizational structure, performance management, and approval workflows.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Employee occupies an authorized position. Position is the headcount slot; employee is the person filling it. This is a fundamental HR relationship. FK will be nullable (employee may be between positio',
    `annual_salary` DECIMAL(18,2) COMMENT 'Base annual salary for the employee in local currency. Used for payroll processing, compensation analysis, and budget planning. Excludes bonuses and equity.',
    `compensation_grade` STRING COMMENT 'Internal compensation band or grade level assigned to the employee. Used for salary benchmarking, promotion planning, and pay equity analysis.',
    `cost_center` STRING COMMENT 'Financial cost center code to which the employees compensation and expenses are allocated. Used for budgeting, financial reporting, and project cost tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in the HR system. Used for data lineage, audit trail, and record lifecycle tracking.',
    `data_retention_expiry_date` DATE COMMENT 'Date when the employee record is eligible for archival or deletion per data retention policies. Calculated based on termination date and regulatory retention requirements.',
    `date_of_birth` DATE COMMENT 'Date of birth of the employee. Used for age verification, benefits eligibility, retirement planning, and COPPA compliance for employees under 18.',
    `department` STRING COMMENT 'Organizational department to which the employee belongs (e.g., Game Development, Live Operations, Platform Engineering, Player Support). Used for cost center allocation and organizational reporting.',
    `email_address` STRING COMMENT 'Corporate email address assigned to the employee. Primary communication channel for internal collaboration, project management in Jira, and business correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the employees designated emergency contact person. Used for critical incident response and employee safety protocols.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the employees designated emergency contact. Used for critical incident response and employee safety protocols.',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee within the organization. Determines access rights, payroll processing, and benefits eligibility.. Valid values are `active|on_leave|suspended|terminated|retired|deceased`',
    `employment_type` STRING COMMENT 'Classification of employment arrangement. Determines benefits eligibility, work hour expectations, and compensation structure. Supports studio capacity planning for game development production scheduling.. Valid values are `full_time|part_time|contractor|intern|temporary`',
    `first_name` STRING COMMENT 'Legal first name of the employee as recorded in HR system. Used for payroll, benefits administration, and official communications.',
    `gdpr_consent_date` DATE COMMENT 'Date when the employee provided GDPR consent. Used for consent audit trail and compliance verification.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the employee has provided explicit consent for processing of personal data under GDPR requirements. Required for EU-based employees and data processing compliance.',
    `hire_date` DATE COMMENT 'Date the employee officially started employment with the organization. Used for tenure calculations, benefits vesting, anniversary recognition, and retention analytics.',
    `igda_member` BOOLEAN COMMENT 'Indicates whether the employee is a member of the International Game Developers Association. Used for professional development tracking and industry engagement metrics.',
    `is_remote_eligible` BOOLEAN COMMENT 'Indicates whether the employees role is eligible for remote work arrangements. Used for workforce planning, office space allocation, and flexible work policy administration.',
    `job_title` STRING COMMENT 'Official job title of the employee as recorded in HR system. Reflects role, seniority, and functional area (e.g., Senior Game Designer, Lead Programmer, QA Tester).',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified the employee record. Used for audit trail and change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was last updated. Used for change tracking, data freshness assessment, and audit compliance.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the employee as recorded in HR system. Used for payroll, benefits administration, and official communications.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal performance review. Used to track review cycles and ensure timely performance management processes.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number in USA, National Insurance Number in UK). Used for tax reporting, payroll processing, and legal compliance.',
    `office_location` STRING COMMENT 'Physical office or campus location where the employee is based (e.g., Seattle HQ, Tokyo Studio, London Office). Used for facilities management, travel planning, and regional workforce analytics.',
    `performance_rating` STRING COMMENT 'Most recent annual performance review rating. Used for merit increase decisions, promotion eligibility, performance improvement plans, and talent management.. Valid values are `exceeds|meets|needs_improvement|unsatisfactory|not_rated`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee. Used for emergency contact, business communication, and HR outreach.',
    `primary_skill` STRING COMMENT 'The employees primary area of expertise or specialization (e.g., Gameplay Programming, Character Art, Level Design, QA Testing). Used for resource allocation and project matching.',
    `salary_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the employees salary. Supports multi-currency payroll processing for global workforce. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CAD|AUD|KRW|CNY — 8 candidates stripped; promote to reference product]',
    `seniority_level` STRING COMMENT 'Career level indicating experience, responsibility, and decision-making authority. Used for compensation bands, reporting structure, and succession planning. [ENUM-REF-CANDIDATE: junior|mid|senior|lead|principal|director|vp|c_level — 8 candidates stripped; promote to reference product]',
    `skill_tags` STRING COMMENT 'Comma-separated list of technical and functional skills possessed by the employee (e.g., Unity, Unreal Engine, C++, Game Design, QA Automation). Used for developer skill matrices, project staffing, and talent pool analysis.',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Null for active employees. Used for offboarding, final payroll processing, benefits termination, and turnover analytics.',
    `work_location` STRING COMMENT 'Primary work arrangement indicating where the employee performs their duties. Used for facilities planning, collaboration tool provisioning, and workforce distribution analytics.. Valid values are `on_site|remote|hybrid`',
    `work_permit_expiry_date` DATE COMMENT 'Expiration date of the employees work permit or visa. Null for citizens and permanent residents. Used for proactive renewal management and compliance risk mitigation.',
    `work_permit_status` STRING COMMENT 'Legal work authorization status for the employee in their work location country. Used for compliance tracking, visa renewal management, and international mobility planning.. Valid values are `citizen|permanent_resident|work_visa|pending|not_required`',
    `years_of_experience` STRING COMMENT 'Total years of professional experience in the gaming industry. Used for seniority assessment, compensation benchmarking, and skill level estimation.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for all full-time and part-time employees across all studios and corporate functions. Captures personal details, employment status, hire date, termination date, employment type, work location, studio assignment, job family, seniority level, IGDA membership status, and GDPR/COPPA consent flags. Single source of truth for employee identity across the gaming enterprise. Primary source system: SAP S/4HANA HR.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`contractor` (
    `contractor_id` BIGINT COMMENT 'Unique identifier for the contractor record. Primary key.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game studio to which this contractor is currently assigned.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Contractor engagement is based on a job profile defining the role requirements and competencies. Skill_specialization on contractor is kept as it may be more specific than job_profile technical_skills',
    `employee_id` BIGINT COMMENT 'Identifier of the full-time employee who serves as the contractors direct manager or project lead.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Contractor is assigned to an organizational unit within the studio. Contractors work within org units just like employees. No columns removed as contractor table doesnt have redundant org unit fields',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Contractor can fill an authorized position when position.is_contractor_eligible = true. This links the contractor engagement to the formal headcount position they are filling. FK will be nullable (not',
    `background_check_status` STRING COMMENT 'Status of background verification process for the contractor, if required by studio policy or project sensitivity.. Valid values are `not_required|pending|cleared|failed|expired`',
    `benefits_eligible` BOOLEAN COMMENT 'Indicates whether the contractor is eligible for any company benefits. Typically false for contractors, distinguishing them from employees.',
    `clearance_level` STRING COMMENT 'Security clearance level granted to the contractor for access to confidential game development assets, source code, and unreleased content.. Valid values are `none|basic|standard|elevated|full_access`',
    `contract_end_date` DATE COMMENT 'Date when the contractor engagement is scheduled to end. May be extended through contract amendments.',
    `contract_start_date` DATE COMMENT 'Date when the contractor engagement officially begins and the contractor is authorized to perform work.',
    `contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the contractor engagement for fixed-price or capped contracts.',
    `contracting_agency_name` STRING COMMENT 'Name of the staffing agency or contracting firm providing the contractor, if applicable. Null for direct freelancers.',
    `contractor_number` STRING COMMENT 'Business identifier for the contractor, typically assigned by HR or procurement systems. Format: CTR-########.. Valid values are `^CTR-[0-9]{8}$`',
    `contractor_status` STRING COMMENT 'Current lifecycle status of the contractor engagement. Active contractors have system access and can be assigned to projects.. Valid values are `active|inactive|suspended|pending_onboarding|contract_expired|terminated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contractor record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contractor payment (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `daily_rate` DECIMAL(18,2) COMMENT 'Daily billing rate for the contractor in the contract currency. Used for day-rate engagements.',
    `email_address` STRING COMMENT 'Primary email address for contractor communication and system access provisioning.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `engagement_type` STRING COMMENT 'Classification of the contractor engagement model. Determines compliance obligations and payment processing rules.. Valid values are `freelance|agency_contractor|statement_of_work|independent_consultant|temporary_worker|project_based`',
    `equipment_issued` BOOLEAN COMMENT 'Indicates whether company equipment (laptop, development kit, peripherals) has been issued to the contractor.',
    `full_name` STRING COMMENT 'Full legal name of the contractor as it appears on contracts and tax documents.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Hourly billing rate for the contractor in the contract currency. Used for time-and-materials engagements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contractor record was most recently updated.',
    `nda_signed_date` DATE COMMENT 'Date when the contractor signed the non-disclosure agreement protecting confidential game development information and unreleased content.',
    `onboarding_completed_date` DATE COMMENT 'Date when the contractor completed all onboarding requirements including training, compliance certifications, and system access setup.',
    `payment_terms` STRING COMMENT 'Payment schedule and terms for the contractor (e.g., Net 30, Bi-Weekly, Monthly, Upon Milestone Completion).',
    `performance_rating` STRING COMMENT 'Most recent performance assessment rating for the contractor, used for contract renewal and future engagement decisions.. Valid values are `not_rated|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the contractor.',
    `rehire_eligible` BOOLEAN COMMENT 'Indicates whether the contractor is eligible for future re-engagement based on past performance and conduct.',
    `remote_work_location` STRING COMMENT 'Geographic location from which the contractor performs work, if remote. Used for tax nexus and compliance tracking.',
    `skill_specialization` STRING COMMENT 'Primary skill area or discipline for which the contractor was engaged (e.g., 3D Artist, QA Tester, Level Designer, Gameplay Programmer, Audio Engineer, Localization Specialist).',
    `statement_of_work_reference` STRING COMMENT 'Reference number or identifier for the statement of work document governing this contractor engagement.',
    `system_access_provisioned` BOOLEAN COMMENT 'Indicates whether the contractor has been granted access to required development systems, tools, and platforms (Perforce, Jira, game engines, SDKs).',
    `tax_classification` STRING COMMENT 'Tax treatment classification for the contractor determining withholding and reporting obligations.. Valid values are `1099_us|w2_us|ir35_inside_uk|ir35_outside_uk|international_exempt|vat_registered`',
    `tax_id_number` STRING COMMENT 'Tax identification number for the contractor (SSN, EIN, VAT number, or equivalent based on jurisdiction).',
    `termination_reason` STRING COMMENT 'Reason for contractor engagement termination, if applicable (e.g., contract completion, project cancellation, performance issues, policy violation).',
    `time_tracking_required` BOOLEAN COMMENT 'Indicates whether the contractor must submit timesheets for billing and project cost tracking purposes.',
    `work_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the contractor performs work. Determines labor law compliance requirements.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_contractor PRIMARY KEY(`contractor_id`)
) COMMENT 'Master record for external contractors, freelancers, and contingent workers engaged by studios for game development, QA playtesting, art production, and live operations. Tracks engagement type, contracting agency, statement-of-work reference, clearance level, studio assignment, skill specialization, and contract period. Distinct from employee as contractors have no benefits eligibility and follow different compliance obligations (IR35, 1099 classification).';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center associated with this organizational unit for financial tracking and budget allocation.',
    `game_studio_id` BIGINT COMMENT 'Reference to the game studio entity if this organizational unit is a studio or belongs to a studio. Null for corporate or non-studio units.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy. Null for top-level units (e.g., corporate headquarters).',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total annual operating budget allocated to this organizational unit in the enterprises base currency. Includes compensation, benefits, tools, and operational expenses. Used for financial planning and variance analysis.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the annual budget amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system. Used for audit trail and data lineage.',
    `current_headcount` STRING COMMENT 'Current number of active employees and contractors assigned to this organizational unit. Updated regularly for capacity planning and resource allocation.',
    `development_methodology` STRING COMMENT 'Primary software development or project management methodology used by this organizational unit. Null for non-development units. Used for process standardization and productivity benchmarking.. Valid values are `agile|scrum|kanban|waterfall|hybrid`',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit ceased or will cease operations. Null for currently active units. Used for historical organizational structure analysis and compliance reporting.',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit became or will become operational. Used for historical organizational structure reporting and workforce planning.',
    `functional_area` STRING COMMENT 'Primary functional discipline or business area this organizational unit supports. Aligns with core business processes and enables cross-studio functional reporting. [ENUM-REF-CANDIDATE: game_development|engineering|art|design|qa|live_ops|publishing|marketing|finance|hr|legal|it|operations|esports|community — 15 candidates stripped; promote to reference product]',
    `headcount_budget` STRING COMMENT 'Approved headcount capacity for this organizational unit. Used for workforce planning, hiring targets, and studio capacity analysis for game development production scheduling.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this organizational units time and costs are directly billable to game development projects (true) or represents overhead/support functions (false). Used for project costing and profitability analysis.',
    `is_remote_first` BOOLEAN COMMENT 'Indicates whether this organizational unit operates primarily as a remote/distributed team (true) or requires physical presence at a studio location (false). Impacts workforce planning and collaboration tooling.',
    `location_city` STRING COMMENT 'Primary city where this organizational unit is physically located. Null for fully remote or virtual units.',
    `location_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary location of this organizational unit (e.g., USA, CAN, GBR, JPN). Null for fully remote or virtual units.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units purpose, responsibilities, and scope. Used for onboarding, organizational charts, and internal documentation.',
    `primary_game_engine` STRING COMMENT 'Primary game engine technology this organizational unit specializes in or uses for development. Null for non-development units. Used for skill matrix planning and technology stack reporting.. Valid values are `unity|unreal|proprietary|other`',
    `sprint_length_weeks` STRING COMMENT 'Standard sprint or iteration length in weeks for agile teams. Null for non-agile units. Used for capacity planning and velocity tracking in Jira.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the organizational units primary location (e.g., America/Los_Angeles, Europe/London). Used for scheduling, capacity planning, and cross-studio collaboration.',
    `unit_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the organizational unit across the enterprise. Used in HR systems, financial reporting, and project management tools.. Valid values are `^[A-Z0-9]{2,10}$`',
    `unit_name` STRING COMMENT 'Full business name of the organizational unit (e.g., Core Engine Team, Seattle Studio, Live Operations Department).',
    `unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. Active = operational; Inactive = temporarily suspended; Planned = approved but not yet operational; Dissolved = permanently closed; Restructuring = undergoing organizational change.. Valid values are `active|inactive|planned|dissolved|restructuring`',
    `unit_type` STRING COMMENT 'Classification of the organizational unit within the hierarchy. Studio = top-level game development studio; Department = functional area within studio or corporate; Team = cross-functional group; Squad = agile delivery unit; Pod = small specialized group; Division = corporate business unit.. Valid values are `studio|department|team|squad|pod|division`',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit hierarchy representing studios, departments, teams, and squads within the gaming enterprise. Captures unit name, unit type (studio, department, squad, pod), parent unit, cost center reference, studio location, headcount budget, and effective dates. Supports organizational structure reporting, capacity planning for game development production scheduling, and studio-level headcount analytics.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the authorized headcount position within the organizational structure.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game studio or development center where this position is located.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Position is defined by a job profile template. Job profile contains the standardized role definition, competencies, and requirements. Removing job_family, discipline, and seniority_band from position ',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit (department, team, division) to which this position belongs.',
    `reports_to_position_id` BIGINT COMMENT 'Identifier of the position to which this position reports in the organizational hierarchy.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the position creation or modification request.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or manager who approved the position for headcount planning.',
    `approved_date` DATE COMMENT 'Date when the position was approved for inclusion in the authorized headcount plan.',
    `cost_center` STRING COMMENT 'Financial cost center code for budget allocation and expense tracking associated with this position.. Valid values are `^[0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was first created in the HR system.',
    `education_requirement` STRING COMMENT 'Minimum educational qualification required for the position (e.g., Bachelors in Computer Science, portfolio-based for artists).',
    `effective_end_date` DATE COMMENT 'Date when the position is scheduled to be eliminated or frozen. Null for ongoing positions.',
    `effective_start_date` DATE COMMENT 'Date when the position becomes active and available for hiring or assignment.',
    `employment_type` STRING COMMENT 'Type of employment relationship expected for this position (full-time, part-time, contract, temporary, internship).. Valid values are `full_time|part_time|contract|temporary|intern`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation for the position. 1.0 represents full-time, 0.5 represents half-time. Used for headcount planning and capacity management.',
    `is_bonus_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for performance-based bonus compensation.',
    `is_contractor_eligible` BOOLEAN COMMENT 'Indicates whether the position can be filled by a contractor or contingent worker rather than a full-time employee.',
    `is_equity_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for equity compensation (stock options, RSUs).',
    `is_remote_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for remote or distributed work arrangements.',
    `job_grade` STRING COMMENT 'Internal compensation grade level assigned to the position for salary band determination and career progression.',
    `location_city` STRING COMMENT 'City where the position is physically located or based.',
    `location_country` STRING COMMENT 'Three-letter ISO country code where the position is based.. Valid values are `^[A-Z]{3}$`',
    `min_years_experience` STRING COMMENT 'Minimum number of years of relevant industry experience required for the position.',
    `modified_by` STRING COMMENT 'User identifier of the HR administrator or manager who last modified the position record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was last modified in the HR system.',
    `position_code` STRING COMMENT 'Business identifier for the position used in HR systems and organizational charts. Typically follows company-specific coding scheme.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_description` STRING COMMENT 'Detailed description of the position responsibilities, accountabilities, and key deliverables.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position indicating whether it is available for hiring, currently occupied, or temporarily frozen.. Valid values are `open|filled|frozen|eliminated|pending_approval`',
    `salary_currency` STRING COMMENT 'Three-letter ISO currency code for salary range values.. Valid values are `^[A-Z]{3}$`',
    `salary_range_max` DECIMAL(18,2) COMMENT 'Maximum annual salary for the position in local currency. Used for compensation planning and pay equity analysis.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'Minimum annual salary for the position in local currency. Used for compensation planning and pay equity analysis.',
    `skill_profile` STRING COMMENT 'Required technical and functional skills for the position (e.g., Unity, Unreal Engine, C++, Maya, Substance Painter, Jira, Agile methodologies).',
    `title` STRING COMMENT 'Official job title for the position as it appears in organizational structure and job postings.',
    `created_by` STRING COMMENT 'User identifier of the HR administrator or manager who created the position record.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized headcount positions within the organizational structure, representing approved roles that can be filled by employees or contractors. Captures position title, job family, discipline (engineering, art, design, QA, production, marketing), seniority band, studio assignment, org unit, FTE allocation, position status (open, filled, frozen), and requisition linkage. Enables headcount planning and studio capacity management for game development production scheduling.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile. Primary key for the job profile catalog.',
    `reports_to_job_profile_id` BIGINT COMMENT 'Job profile identifier of the direct manager role for this position. Defines the standard reporting relationship in the organizational hierarchy.',
    `career_level` STRING COMMENT 'Seniority level within the career track. Defines experience expectations, scope of responsibility, and position in organizational hierarchy. [ENUM-REF-CANDIDATE: entry|junior|mid|senior|lead|principal|director|vp|c_level — 9 candidates stripped; promote to reference product]',
    `career_track` STRING COMMENT 'Career progression path for this job profile. Individual Contributor focuses on technical or creative depth; Management focuses on people leadership; Executive focuses on strategic leadership.. Valid values are `individual_contributor|management|executive`',
    `core_competencies` STRING COMMENT 'Comma-separated list of essential skills, technical proficiencies, and behavioral competencies required for success in this job profile. Examples: C++ programming, Unreal Engine, 3D modeling, Agile methodology, player empathy, cross-functional collaboration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this job profile is retired or deprecated. Null for currently active profiles with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this job profile becomes active and available for use in position creation and workforce planning.',
    `employment_type` STRING COMMENT 'Standard employment relationship type for this job profile. Defines benefits eligibility, contract terms, and workforce planning categorization.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `flsa_classification` STRING COMMENT 'US Fair Labor Standards Act classification determining overtime eligibility. Exempt employees are salaried and not eligible for overtime; non-exempt employees are eligible for overtime pay.. Valid values are `exempt|non_exempt`',
    `igda_discipline_classification` STRING COMMENT 'IGDA-aligned discipline classification for standardized industry benchmarking and workforce reporting. Enables cross-studio and cross-company talent comparisons.',
    `job_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying this job profile across all studios and corporate functions. Used for position requisition, compensation benchmarking, and HR system integration.. Valid values are `^[A-Z0-9]{4,12}$`',
    `job_description` STRING COMMENT 'Comprehensive narrative description of the job profile including purpose, key responsibilities, deliverables, and success criteria. Used for job postings, performance management, and organizational design.',
    `job_family` STRING COMMENT 'High-level functional grouping of the job role. Defines the primary discipline or business function to which this job belongs. [ENUM-REF-CANDIDATE: engineering|art|design|qa|production|esports_operations|community_management|marketing|finance|hr|legal|it|operations|executive — 14 candidates stripped; promote to reference product]',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of the job profile. Active profiles are available for position creation; inactive profiles are retired; draft profiles are under development.. Valid values are `active|inactive|draft|under_review|deprecated`',
    `job_sub_family` STRING COMMENT 'Specialized sub-category within the job family. Examples: Gameplay Engineering, Character Art, Level Design, Automation QA, Live Operations Production, Tournament Operations.',
    `job_title` STRING COMMENT 'Official job title as it appears in employment contracts, organizational charts, and external job postings. Examples: Senior Game Designer, Lead Graphics Engineer, Community Manager, Esports Operations Coordinator.',
    `key_responsibilities` STRING COMMENT 'Structured list of primary duties and accountabilities for this job profile. Used for performance evaluation, role clarity, and workload planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was last updated. Used for change tracking and audit trail.',
    `last_reviewed_date` DATE COMMENT 'Date when this job profile was last reviewed and validated by HR and business leadership. Used for compliance audits and ensuring profile currency.',
    `minimum_education_level` STRING COMMENT 'Minimum formal education level required for this job profile. Used for candidate screening and job posting requirements.. Valid values are `high_school|associate|bachelor|master|phd|none`',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for this job profile. Used for candidate screening and compensation benchmarking.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this job profile. Used for proactive profile maintenance and alignment with evolving business needs.',
    `pay_grade_band` STRING COMMENT 'Compensation band code defining the salary range for this job profile. Used for compensation benchmarking, budget planning, and offer letter generation.. Valid values are `^[A-Z0-9]{2,6}$`',
    `physical_requirements` STRING COMMENT 'Description of physical demands and working conditions for this job profile. Examples: prolonged sitting, repetitive motion, ability to lift equipment, extended screen time. Used for ADA compliance and workplace accommodation planning.',
    `preferred_certifications` STRING COMMENT 'Comma-separated list of professional certifications or licenses that are preferred but not required. Used for candidate evaluation and professional development planning.',
    `preferred_education_level` STRING COMMENT 'Preferred formal education level for optimal candidate fit. Used for candidate evaluation and talent pipeline development.. Valid values are `high_school|associate|bachelor|master|phd|none`',
    `preferred_years_experience` STRING COMMENT 'Preferred number of years of relevant professional experience for optimal candidate fit. Used for candidate evaluation and talent pipeline development.',
    `remote_work_eligibility` STRING COMMENT 'Remote work policy applicable to this job profile. Defines whether the role can be performed remotely, requires hybrid presence, or must be on-site.. Valid values are `on_site|hybrid|fully_remote|location_dependent`',
    `required_certifications` STRING COMMENT 'Comma-separated list of professional certifications or licenses required for this job profile. Examples: PMP, Certified Scrum Master, Unity Certified Developer, AWS Solutions Architect.',
    `security_clearance_required` BOOLEAN COMMENT 'Indicates whether this job profile requires background checks or security clearance due to access to sensitive IP, financial data, or player data.',
    `span_of_control_max` STRING COMMENT 'Maximum number of direct reports expected for this job profile if it is a management role. Used for organizational design and capacity planning.',
    `span_of_control_min` STRING COMMENT 'Minimum number of direct reports expected for this job profile if it is a management role. Used for organizational design and capacity planning.',
    `technical_skills` STRING COMMENT 'Comma-separated list of specific technical tools, platforms, programming languages, or software applications required for this job profile. Examples: Unity, Perforce, Jira, Maya, Substance Painter, Python, SQL.',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of work time requiring business travel. Used for candidate expectations, expense budgeting, and work-life balance planning.',
    `version_number` STRING COMMENT 'Version number of this job profile definition. Incremented when significant changes are made to responsibilities, requirements, or compensation bands.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Catalog of standardized job roles and job families used across all studios and corporate functions. Defines job title, job family (engineering, art, design, QA, production, esports operations, community management), career track, IGDA-aligned discipline classification, required certifications, and pay grade band. Serves as the reference taxonomy for position creation, skill matrix alignment, and compensation benchmarking.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`skill_matrix` (
    `skill_matrix_id` BIGINT COMMENT 'Unique identifier for the skill matrix record. Primary key for the skill matrix data product.',
    `contractor_id` BIGINT COMMENT 'Foreign key linking to workforce.contractor. Business justification: The product description states Developer and studio talent capability inventory - contractors are talent. Studios track contractor skills for project staffing decisions (which contractor has Unreal ',
    `dev_project_id` BIGINT COMMENT 'Unique identifier for the game development project where this skill was most recently applied or is currently being used. Links to project master data. Used for project-specific skill gap analysis and team composition planning.',
    `game_studio_id` BIGINT COMMENT 'Unique identifier for the game development studio or organizational unit where the employee is assigned. Used for studio-level skill inventory and capacity planning. Links to studio master data.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee or contractor whose skill is being tracked. Links to the workforce employee master data.',
    `assessment_date` DATE COMMENT 'Date when the skill proficiency was last assessed or validated. Critical for tracking skill currency and identifying when reassessment is needed.',
    `certification_date` DATE COMMENT 'Date when the certification was earned or awarded. Used to track certification currency and identify when recertification may be required.',
    `certification_expiry_date` DATE COMMENT 'Date when the certification expires and requires renewal or recertification. Nullable for certifications that do not expire.',
    `certification_name` STRING COMMENT 'Name of the professional certification or credential earned for this skill, if applicable. Examples include Unity Certified Developer, Unreal Engine Certified Instructor, AWS Certified Solutions Architect, Certified Scrum Master (CSM), or platform-specific certifications.',
    `certification_provider` STRING COMMENT 'Organization or institution that issued the certification. Examples include Unity Technologies, Epic Games, Scrum Alliance, Microsoft, Amazon Web Services (AWS), or platform holders (Sony, Microsoft, Nintendo).',
    `certification_status` STRING COMMENT 'Current validity status of the certification. Active indicates the certification is current and valid, expired indicates it has lapsed, pending renewal indicates recertification is in progress, and revoked indicates the certification was withdrawn by the issuing body.. Valid values are `active|expired|pending_renewal|revoked`',
    `ceu_credits` DECIMAL(18,2) COMMENT 'Number of continuing education unit credits earned upon successful completion of the learning program. Used for professional development tracking and certification maintenance requirements.',
    `completion_date` DATE COMMENT 'Date when the employee successfully completed the learning program or training course. Nullable if the program is still in progress or was not completed.',
    `completion_status` STRING COMMENT 'Current status of the employees progress in the learning program. Completed indicates successful finish, in progress indicates active participation, not started indicates enrollment without activity, failed indicates unsuccessful completion, and withdrawn indicates the employee dropped out.. Valid values are `completed|in_progress|not_started|failed|withdrawn`',
    `compliance_training_flag` BOOLEAN COMMENT 'Boolean indicator of whether this learning program is mandatory compliance training required by law, regulation, or company policy. True indicates mandatory compliance training (GDPR, COPPA, PCI DSS, harassment prevention, security awareness). False indicates non-compliance training. Critical for audit trail and regulatory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this skill matrix record was first created in the system. Used for audit trail and data lineage tracking.',
    `endorsement_count` STRING COMMENT 'Number of peer or manager endorsements received for this skill. Endorsements provide social validation of skill proficiency and are used to supplement formal assessments. Similar to LinkedIn skill endorsements but internal to the organization.',
    `enrollment_date` DATE COMMENT 'Date when the employee enrolled in the learning program or training course. Used to track learning journey timelines and program participation rates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this skill matrix record was most recently updated. Used for audit trail, change tracking, and data freshness monitoring.',
    `last_used_date` DATE COMMENT 'Most recent date when the employee actively used this skill in a project, sprint, or work assignment. Used to identify skill currency and detect skill atrophy. Sourced from project management systems (Jira) or time tracking systems.',
    `learning_program_name` STRING COMMENT 'Name of the training course, workshop, or learning program the employee is enrolled in or has completed to develop this skill. Examples include internal onboarding programs, vendor training (Unity Learn, Unreal Online Learning), or third-party courses (Coursera, Udemy, LinkedIn Learning).',
    `learning_provider` STRING COMMENT 'Organization or platform providing the training or learning program. Examples include internal HR/L&D teams, Unity Technologies, Epic Games, Coursera, Udemy, LinkedIn Learning, or specialized game development training providers.',
    `learning_type` STRING COMMENT 'Classification of the learning program purpose. Mandatory compliance indicates required training for regulatory or policy adherence (General Data Protection Regulation (GDPR), Childrens Online Privacy Protection Act (COPPA), Payment Card Industry Data Security Standard (PCI DSS), harassment prevention). Voluntary development indicates employee-initiated professional growth. Onboarding indicates new hire orientation. Upskilling indicates deepening existing skills. Reskilling indicates learning new skills for role transition.. Valid values are `mandatory_compliance|voluntary_development|onboarding|upskilling|reskilling`',
    `manager_assessment_score` STRING COMMENT 'Managers rated proficiency score for this skill on a scale of 1 to 10. Provides objective assessment to complement self-assessment. Used for performance reviews, promotion decisions, and skill gap analysis.',
    `next_assessment_date` DATE COMMENT 'Scheduled date for the next skill proficiency assessment or review. Used to ensure regular skill validation and maintain skill inventory currency. Typically scheduled annually or bi-annually depending on skill criticality.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or comments about the skill assessment, learning progress, or development plan. Used by managers and HR to capture qualitative insights that do not fit structured fields.',
    `pass_fail_status` STRING COMMENT 'Outcome of the learning program assessment or examination. Pass indicates successful completion of all requirements, fail indicates unsuccessful completion, and not applicable indicates the program does not have a pass/fail assessment.. Valid values are `pass|fail|not_applicable`',
    `proficiency_level` STRING COMMENT 'Current proficiency rating for the employee in this specific skill. Levels range from beginner (basic familiarity) to master (industry-recognized expert, can mentor others and define best practices).. Valid values are `beginner|intermediate|advanced|expert|master`',
    `record_status` STRING COMMENT 'Current lifecycle status of this skill matrix record. Active indicates the record is current and valid. Inactive indicates the skill is no longer tracked for this employee (e.g., employee left or skill is no longer relevant). Archived indicates historical record retained for compliance or analytics.. Valid values are `active|inactive|archived`',
    `self_assessment_score` STRING COMMENT 'Employees self-rated proficiency score for this skill on a scale of 1 to 10. Used to compare self-perception with manager assessment and identify confidence gaps or Dunning-Kruger effects. Supports career development conversations.',
    `skill_category` STRING COMMENT 'High-level classification of the skill domain. Categories include game engine proficiency, programming language, art discipline (3D modeling, animation, concept art), quality assurance (QA) methodology, platform software development kit (SDK) knowledge, and design discipline (level design, systems design, narrative design).. Valid values are `game_engine|programming_language|art_discipline|qa_methodology|platform_sdk|design_discipline`',
    `skill_gap_flag` BOOLEAN COMMENT 'Boolean indicator of whether this skill represents a gap between current proficiency and required proficiency for the employees role or career path. True indicates a development need. False indicates proficiency meets or exceeds requirements. Used to prioritize learning and development investments.',
    `skill_name` STRING COMMENT 'Specific name of the skill or competency being assessed. Examples include Unity, Unreal Engine, C++, Python, High-Level Shading Language (HLSL), Maya, Blender, Substance Painter, Perforce, Jira, Agile QA, platform-specific SDKs (Steamworks, PlayStation SDK, Xbox GDK).',
    `skill_priority` STRING COMMENT 'Business priority level assigned to this skill based on current and future project needs. Critical indicates the skill is essential for current production and in high demand. High indicates strong business need. Medium indicates moderate need. Low indicates nice-to-have or surplus capacity. Used for learning and development investment prioritization.. Valid values are `critical|high|medium|low`',
    `skill_status` STRING COMMENT 'Current lifecycle status of the skill in the employees capability portfolio. Active indicates the skill is currently used and maintained. Dormant indicates the skill is not currently used but remains valid. Deprecated indicates the skill is obsolete or no longer relevant to the business. Target indicates the skill is a development goal not yet achieved.. Valid values are `active|dormant|deprecated|target`',
    `source_system` STRING COMMENT 'Name of the operational system from which this skill matrix record originated. Examples include SAP S/4HANA HR, internal learning management system (LMS), or talent management platform. Used for data lineage and troubleshooting.',
    `target_proficiency_level` STRING COMMENT 'Desired proficiency level for this skill based on the employees role requirements or career development plan. Used to measure skill gap and track progress toward development goals.. Valid values are `beginner|intermediate|advanced|expert|master`',
    `training_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the learning program, including tuition, materials, and any associated fees. Denominated in the companys reporting currency. Used for learning and development budget tracking and return on investment (ROI) analysis.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of professional experience the employee has with this specific skill, including work at previous employers. Used for capacity planning and team composition analysis.',
    CONSTRAINT pk_skill_matrix PRIMARY KEY(`skill_matrix_id`)
) COMMENT 'Developer and studio talent capability inventory capturing individual proficiency ratings, certifications, learning program enrollments, and training completions across technical and creative disciplines. Tracks employee or contractor, skill category (game engine proficiency, programming language, art discipline, QA methodology, platform SDK knowledge), specific skill (Unity, Unreal Engine, C++, Python, HLSL), proficiency level, assessment date, and assessor. Includes learning records: course/certification name, provider, enrollment date, completion date, pass/fail status, CEU credits, cost, and learning type (mandatory compliance vs voluntary development). Mandatory compliance training tracked: GDPR, COPPA, PCI DSS, harassment prevention. Single source of truth for workforce capabilities and professional development. Critical for studio capacity planning, sprint team assembly, skill gap analysis, and compliance training audit.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'Unique identifier for the headcount plan record. Primary key for workforce capacity planning entries.',
    `dev_project_id` BIGINT COMMENT 'Reference to the game development project this headcount plan supports. Nullable for studio-wide or department-level plans not tied to a specific project.',
    `employee_id` BIGINT COMMENT 'Reference to the user (typically HR director, studio head, or finance executive) who approved this headcount plan.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Headcount planning is directly tied to approved budget versions for workforce cost forecasting. Finance and HR jointly manage headcount budgets; requisition approvals depend on budget availability. Ga',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (studio, department, division) for which this headcount plan applies.',
    `approved_fte_art` DECIMAL(18,2) COMMENT 'Approved headcount target for art discipline expressed in Full-Time Equivalent (FTE) units. Includes concept artists, 3D modelers, animators, VFX artists, and UI/UX designers.',
    `approved_fte_design` DECIMAL(18,2) COMMENT 'Approved headcount target for design discipline expressed in Full-Time Equivalent (FTE) units. Includes game designers, level designers, systems designers, narrative designers, and economy designers.',
    `approved_fte_engineering` DECIMAL(18,2) COMMENT 'Approved headcount target for engineering discipline expressed in Full-Time Equivalent (FTE) units. Includes software engineers, technical artists, engine programmers, and technical designers.',
    `approved_fte_other` DECIMAL(18,2) COMMENT 'Approved headcount target for other disciplines not categorized above (e.g., audio, localization, analytics, DevOps, IT support) expressed in Full-Time Equivalent (FTE) units.',
    `approved_fte_production` DECIMAL(18,2) COMMENT 'Approved headcount target for production discipline expressed in Full-Time Equivalent (FTE) units. Includes producers, project managers, scrum masters, and program managers.',
    `approved_fte_qa` DECIMAL(18,2) COMMENT 'Approved headcount target for Quality Assurance (QA) discipline expressed in Full-Time Equivalent (FTE) units. Includes QA testers, automation engineers, and compliance testers.',
    `approved_fte_total` DECIMAL(18,2) COMMENT 'Total approved headcount target across all disciplines expressed in Full-Time Equivalent (FTE) units. Sum of all discipline-specific FTE targets.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this headcount plan was approved. Nullable for plans still in draft or submitted status.',
    `capacity_gap_fte` DECIMAL(18,2) COMMENT 'The difference between approved FTE total and current filled FTE total. Positive values indicate unfilled capacity; negative values indicate over-staffing relative to plan.',
    `contractor_fte_actual` DECIMAL(18,2) COMMENT 'Current actual contractor and temporary workforce expressed in Full-Time Equivalent (FTE) units. Reflects engaged contractors as of the snapshot date.',
    `contractor_fte_budget` DECIMAL(18,2) COMMENT 'Approved budget allocation for contractor and temporary workforce expressed in Full-Time Equivalent (FTE) units. Supports flexible capacity planning for project peaks and specialized skills.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this headcount plan record was first created in the system.',
    `current_filled_fte_art` DECIMAL(18,2) COMMENT 'Current actual headcount for art discipline expressed in Full-Time Equivalent (FTE) units. Reflects filled positions as of the snapshot date.',
    `current_filled_fte_design` DECIMAL(18,2) COMMENT 'Current actual headcount for design discipline expressed in Full-Time Equivalent (FTE) units. Reflects filled positions as of the snapshot date.',
    `current_filled_fte_engineering` DECIMAL(18,2) COMMENT 'Current actual headcount for engineering discipline expressed in Full-Time Equivalent (FTE) units. Reflects filled positions as of the snapshot date.',
    `current_filled_fte_other` DECIMAL(18,2) COMMENT 'Current actual headcount for other disciplines expressed in Full-Time Equivalent (FTE) units. Reflects filled positions as of the snapshot date.',
    `current_filled_fte_production` DECIMAL(18,2) COMMENT 'Current actual headcount for production discipline expressed in Full-Time Equivalent (FTE) units. Reflects filled positions as of the snapshot date.',
    `current_filled_fte_qa` DECIMAL(18,2) COMMENT 'Current actual headcount for Quality Assurance (QA) discipline expressed in Full-Time Equivalent (FTE) units. Reflects filled positions as of the snapshot date.',
    `current_filled_fte_total` DECIMAL(18,2) COMMENT 'Total current actual headcount across all disciplines expressed in Full-Time Equivalent (FTE) units. Sum of all discipline-specific filled FTE counts.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter this headcount plan belongs to (Q1, Q2, Q3, Q4). Nullable for plans spanning multiple quarters or non-quarterly periods.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year this headcount plan belongs to (e.g., 2024).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this headcount plan record was last modified. Updated with each revision or status change.',
    `notes` STRING COMMENT 'Free-text notes and comments about this headcount plan. May include assumptions, constraints, hiring priorities, or special considerations.',
    `open_requisition_count_art` STRING COMMENT 'Number of open job requisitions for art discipline. Represents active hiring demand.',
    `open_requisition_count_design` STRING COMMENT 'Number of open job requisitions for design discipline. Represents active hiring demand.',
    `open_requisition_count_engineering` STRING COMMENT 'Number of open job requisitions for engineering discipline. Represents active hiring demand.',
    `open_requisition_count_other` STRING COMMENT 'Number of open job requisitions for other disciplines. Represents active hiring demand.',
    `open_requisition_count_production` STRING COMMENT 'Number of open job requisitions for production discipline. Represents active hiring demand.',
    `open_requisition_count_qa` STRING COMMENT 'Number of open job requisitions for Quality Assurance (QA) discipline. Represents active hiring demand.',
    `open_requisition_count_total` STRING COMMENT 'Total number of open job requisitions across all disciplines. Sum of all discipline-specific open requisition counts.',
    `plan_name` STRING COMMENT 'Business-friendly name or identifier for this headcount plan (e.g., Q1 2024 Studio A Expansion, Project Phoenix Ramp-Up).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the headcount plan: draft (in preparation), submitted (pending approval), approved (finalized and active), locked (frozen for reporting), archived (historical record).. Valid values are `draft|submitted|approved|locked|archived`',
    `plan_version` STRING COMMENT 'Version number of this headcount plan. Increments with each revision to support change tracking and audit trail.',
    `planning_period_end_date` DATE COMMENT 'The end date of the planning period covered by this headcount plan.',
    `planning_period_start_date` DATE COMMENT 'The start date of the planning period covered by this headcount plan.',
    `planning_period_type` STRING COMMENT 'The granularity or type of planning period this headcount plan covers: sprint (agile iteration), milestone (game development phase), quarter (business quarter), fiscal year, or annual.. Valid values are `sprint|milestone|quarter|fiscal_year|annual`',
    `snapshot_date` DATE COMMENT 'The date as of which the current filled FTE and contractor FTE actual values were captured. Supports point-in-time workforce capacity reporting.',
    `utilization_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of approved FTE capacity that is currently filled. Calculated as (current_filled_fte_total / approved_fte_total) * 100. Measures staffing efficiency and capacity utilization.',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'Studio, department, and project-level workforce capacity planning records capturing approved FTE targets, contractor budget allocations, hiring forecasts, and discipline breakdowns by sprint, milestone, quarter, and fiscal year. Tracks org unit, planning period, approved headcount by discipline (engineering, art, design, QA, production), current filled count, open requisition count, contractor FTE equivalent, available vs allocated FTE, utilization rates, capacity gaps, and plan status (draft, approved, locked). Single source of truth for all workforce capacity planning. Directly supports game development production scheduling, studio capacity planning, GaaS live operations staffing, and project-level resource allocation.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`compensation` (
    `compensation_id` BIGINT COMMENT 'Unique identifier for the compensation record. Primary key for the compensation data product.',
    `employee_id` BIGINT COMMENT 'Employee ID of the manager who approved this compensation change. Links to employee master data for approval audit trail.',
    `compensation_employee_id` BIGINT COMMENT 'Unique identifier for the employee receiving this compensation. Links to the employee master data in the workforce domain.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compensation planning and approval workflows require cost center assignment for budget validation and headcount cost forecasting. Finance teams use this for annual planning, merit increase cycles, and',
    `game_studio_id` BIGINT COMMENT 'Identifier for the game studio or organizational unit where the employee is assigned. Links to studio master data for studio-level compensation reporting.',
    `previous_compensation_id` BIGINT COMMENT 'Reference to the prior compensation record for this employee. Creates a historical chain of compensation changes for audit and analysis. Null for initial compensation record.',
    `allowance_amount` DECIMAL(18,2) COMMENT 'Total amount of additional allowances (housing, transportation, relocation, etc.) included in this compensation record. Business-confidential financial data.',
    `allowance_type` STRING COMMENT 'Category of allowance provided to the employee. Distinguishes between housing, transportation, relocation, remote work stipends, and education allowances.. Valid values are `housing|transportation|relocation|remote_work|education|none`',
    `approval_status` STRING COMMENT 'Current approval and lifecycle status of the compensation record. Tracks workflow from draft through approval to active status.. Valid values are `draft|pending_approval|approved|rejected|active|superseded`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this compensation record was approved. Part of the approval audit trail for compliance and governance.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Annual base salary amount for the employee. Excludes bonuses, equity, and other variable compensation. Business-confidential financial data.',
    `bonus_target_amount` DECIMAL(18,2) COMMENT 'Target annual bonus amount for the employee based on performance objectives and company performance. Actual bonus may vary. Business-confidential financial data.',
    `bonus_target_percentage` DECIMAL(18,2) COMMENT 'Target bonus expressed as a percentage of base salary. Used for calculating variable compensation eligibility. Business-confidential classification data.',
    `change_reason` STRING COMMENT 'Business reason for this compensation change. Distinguishes between new hires, promotions, merit increases, market adjustments, cost-of-living adjustments, retention actions, demotions, and transfers. [ENUM-REF-CANDIDATE: new_hire|promotion|merit_increase|market_adjustment|cost_of_living|retention|demotion|transfer — 8 candidates stripped; promote to reference product]',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'Commission rate as a percentage of sales or revenue for commission-eligible roles. Used to calculate variable compensation for sales and business development roles. Business-confidential classification data.',
    `compensation_type` STRING COMMENT 'Category of compensation payment. Distinguishes between base salary, performance bonus, equity grants, commissions, allowances, and overtime pay.. Valid values are `base_salary|bonus|equity_grant|commission|allowance|overtime`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compensation record was first created in the system. Part of the audit trail for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this compensation record (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this compensation arrangement ends or is superseded by a new compensation record. Null for current active compensation.',
    `effective_start_date` DATE COMMENT 'Date when this compensation arrangement becomes effective. Marks the beginning of the compensation period for this record.',
    `equity_grant_quantity` DECIMAL(18,2) COMMENT 'Number of equity units (stock options, RSUs, or shares) granted to the employee. Business-confidential financial data.',
    `equity_grant_type` STRING COMMENT 'Type of equity compensation granted. Includes stock options, Restricted Stock Units (RSUs), restricted stock, or performance shares. Business-confidential classification data.. Valid values are `stock_option|rsu|restricted_stock|performance_share|none`',
    `equity_vesting_schedule` STRING COMMENT 'Vesting schedule for equity grants describing when equity becomes exercisable or transferable (e.g., 4-year vest with 1-year cliff, monthly vesting). Business-confidential terms.',
    `job_title` STRING COMMENT 'Job title or position associated with this compensation record at the time of the compensation event. Captures title for historical compensation analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this compensation record was last updated. Part of the audit trail for change tracking and compliance.',
    `market_benchmark_percentile` DECIMAL(18,2) COMMENT 'Percentile position of this compensation relative to market benchmark data for the role and geography. Used for competitive compensation analysis. Business-confidential analytical data.',
    `notes` STRING COMMENT 'Free-text notes providing additional context for this compensation record. May include special terms, conditions, or explanations for non-standard compensation arrangements.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for overtime pay under labor regulations and company policy. True for non-exempt employees, false for exempt employees.',
    `pay_equity_band` STRING COMMENT 'Pay equity band or range assigned for pay equity analysis and compliance reporting. Used to ensure fair compensation practices across demographics. Business-confidential classification data.',
    `pay_frequency` STRING COMMENT 'Frequency at which the employee receives compensation payments. Determines payroll cycle and payment schedule.. Valid values are `monthly|bi_weekly|weekly|semi_monthly|annual`',
    `pay_grade` STRING COMMENT 'Organizational pay grade or band assigned to this compensation record. Determines salary range and eligibility for benefits. Business-confidential classification data.',
    `review_cycle` STRING COMMENT 'Type of review cycle that triggered this compensation record. Distinguishes between regular annual reviews, promotions, market adjustments, and ad-hoc changes.. Valid values are `annual|semi_annual|quarterly|ad_hoc|promotion|market_adjustment`',
    `total_compensation_amount` DECIMAL(18,2) COMMENT 'Total annual compensation including base salary, target bonus, equity grant value, and allowances. Represents the full compensation package value. Business-confidential financial data.',
    CONSTRAINT pk_compensation PRIMARY KEY(`compensation_id`)
) COMMENT 'Employee compensation records capturing base salary, bonus target, equity grants, pay grade, pay frequency, currency, effective date, and compensation review cycle. Sourced from SAP S/4HANA HR Payroll and Compensation Management modules. Tracks compensation history per employee, compensation type (base, bonus, equity, allowance), and approval status. Supports IGDA workforce standards compliance and pay equity analysis.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment record. Primary key for the benefit enrollment entity.',
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan being enrolled in. Links to the benefit plan catalog.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Benefits costs (employer contributions) must be allocated to cost centers for accurate departmental overhead calculation and P&L reporting. Gaming studios track fully-loaded labor costs including bene',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee enrolling in benefits. Links to the employee master record.',
    `annual_election_amount` DECIMAL(18,2) COMMENT 'Total annual dollar amount elected by employee for benefits with annual limits such as Flexible Spending Accounts (FSA) or Health Savings Accounts (HSA). Represents annual contribution cap elected.',
    `approval_date` DATE COMMENT 'Date when the benefit enrollment was approved by HR or management. Null if approval is not required or still pending.',
    `approval_status` STRING COMMENT 'Status of managerial or HR approval for the benefit enrollment. Some enrollments or changes may require approval workflow before becoming effective.. Valid values are `approved|pending_approval|rejected|not_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the HR administrator or manager who approved the benefit enrollment. Null if approval is not required or still pending.',
    `beneficiary_designation` STRING COMMENT 'Name or identifier of designated beneficiary for benefits with death benefit provisions such as life insurance or retirement accounts. Confidential employee election.',
    `beneficiary_relationship` STRING COMMENT 'Relationship of the designated beneficiary to the employee. Used for life insurance, retirement accounts, and other benefits with beneficiary designations. [ENUM-REF-CANDIDATE: spouse|child|parent|sibling|domestic_partner|other|estate — 7 candidates stripped; promote to reference product]',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or benefit provider administering the plan. Examples include Aetna, Blue Cross Blue Shield, Fidelity, etc.',
    `cobra_eligible_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this enrollment is eligible for COBRA continuation coverage upon termination of employment. True if eligible for continuation, false otherwise.',
    `cobra_end_date` DATE COMMENT 'Date when COBRA continuation coverage ends. Typically 18 or 36 months after qualifying event depending on circumstances. Null if COBRA is ongoing or not applicable.',
    `cobra_start_date` DATE COMMENT 'Date when COBRA continuation coverage begins following a qualifying event such as employment termination. Null if COBRA has not been elected or is not applicable.',
    `contribution_election_percentage` DECIMAL(18,2) COMMENT 'Percentage of salary the employee elects to contribute to retirement or savings plans such as 401k or stock purchase plans. Null for non-contributory benefits.',
    `contribution_frequency` STRING COMMENT 'Frequency at which benefit contributions are deducted from employee payroll and remitted to benefit provider. Aligns with payroll cycle.. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `coverage_tier` STRING COMMENT 'Level of coverage elected indicating who is covered under the benefit plan: employee only, employee plus spouse, employee plus children, or full family coverage.. Valid values are `employee_only|employee_spouse|employee_children|employee_family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit enrollment record was first created in the system. Audit field for data lineage and compliance tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this enrollment record. Typically USD for US-based gaming studios but may vary for international studios.. Valid values are `^[A-Z]{3}$`',
    `dependent_count` STRING COMMENT 'Number of dependents covered under this benefit enrollment. Zero for employee-only coverage, one or more for family coverage tiers.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employee contributes per pay period toward the benefit premium or cost. Represents employee share of benefit cost deducted from payroll.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employer contributes per pay period toward the benefit premium or cost. Represents employer subsidy or match for the benefit.',
    `employer_match_percentage` DECIMAL(18,2) COMMENT 'Percentage of employee contribution that the employer matches for retirement or savings plans. Represents employer matching formula for 401k or similar plans.',
    `enrollment_date` DATE COMMENT 'Date when the employee submitted or completed the benefit enrollment election. Distinct from effective date as enrollment may occur before coverage begins.',
    `enrollment_effective_date` DATE COMMENT 'Date when the benefit coverage begins and becomes active for the employee. Critical for determining coverage periods and premium calculations.',
    `enrollment_end_date` DATE COMMENT 'Date when the benefit coverage ends or is scheduled to end. Null for ongoing active enrollments. Populated upon termination, cancellation, or plan year end.',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment confirmation number provided to employee for reference and tracking.. Valid values are `^BEN-[0-9]{8}$`',
    `enrollment_period_type` STRING COMMENT 'Type of enrollment period during which the election was made. Open enrollment is annual election window, new hire is initial enrollment upon joining, qualifying life event allows mid-year changes due to marriage/birth/etc, special enrollment covers other permitted election windows.. Valid values are `open_enrollment|new_hire|qualifying_life_event|special_enrollment`',
    `enrollment_source` STRING COMMENT 'Channel or method through which the benefit enrollment was submitted. Tracks whether employee self-enrolled via portal, HR entered on behalf, paper form was processed, or automatic enrollment occurred.. Valid values are `employee_self_service|hr_admin|benefits_portal|paper_form|call_center|auto_enrollment`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the benefit enrollment. Active indicates coverage is in effect, pending indicates awaiting approval or effective date, waived indicates employee declined coverage, terminated indicates coverage has ended, suspended indicates temporary hold, cancelled indicates enrollment was voided.. Valid values are `active|pending|waived|terminated|suspended|cancelled`',
    `group_number` STRING COMMENT 'Group policy number identifying the employer group under which this benefit is provided. Used by carriers to identify the employer plan sponsor.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit enrollment record was last updated or modified. Audit field for change tracking and compliance.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the benefit enrollment. May include special circumstances, documentation requirements, or administrative notes.',
    `plan_type` STRING COMMENT 'Category of benefit plan enrolled. Includes health insurance, dental, vision, life insurance, disability, 401k retirement, employee stock purchase plan, wellness programs, flexible spending account, and health savings account. [ENUM-REF-CANDIDATE: health|dental|vision|life_insurance|disability|retirement_401k|stock_purchase|wellness|fsa|hsa — 10 candidates stripped; promote to reference product]',
    `plan_year_end_date` DATE COMMENT 'End date of the benefit plan year for this enrollment. Marks the conclusion of the annual benefit period and triggers renewal or re-enrollment processes.',
    `plan_year_start_date` DATE COMMENT 'Start date of the benefit plan year for this enrollment. Defines the annual period for benefit coverage, contribution limits, and renewal cycles.',
    `policy_number` STRING COMMENT 'Insurance policy or contract number assigned by the carrier for this benefit enrollment. Used for claims processing and carrier coordination.',
    `qualifying_event_date` DATE COMMENT 'Date when the qualifying life event occurred that permitted the enrollment or change. Used to validate eligibility for special enrollment period and determine coverage effective date rules.',
    `qualifying_event_type` STRING COMMENT 'Type of qualifying life event that triggered a special enrollment period allowing mid-year benefit changes. Null or none if enrollment occurred during standard open enrollment or new hire period. [ENUM-REF-CANDIDATE: marriage|divorce|birth|adoption|death|employment_change|loss_of_coverage|none — 8 candidates stripped; promote to reference product]',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Total benefit premium or cost per pay period, combining both employee and employer contributions. Represents full cost of coverage.',
    `vesting_schedule` STRING COMMENT 'Vesting schedule applied to employer contributions for retirement plans. Defines when employee gains ownership of employer-contributed funds. Immediate means fully vested, cliff means vesting occurs at specific year, graded means incremental vesting over years. [ENUM-REF-CANDIDATE: immediate|cliff_1yr|cliff_2yr|cliff_3yr|graded_3yr|graded_5yr|graded_6yr — 7 candidates stripped; promote to reference product]',
    `waiver_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the employee actively waived or declined this benefit plan. True if waived, false if enrolled. Used to track voluntary declinations for compliance and reporting.',
    `waiver_reason` STRING COMMENT 'Reason provided by employee for waiving or declining the benefit coverage. Captured for compliance reporting and to understand coverage gaps. Null if benefit was not waived. [ENUM-REF-CANDIDATE: spouse_coverage|other_employer_coverage|medicare|medicaid|cost|not_needed|other — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Employee benefit enrollment records capturing elected benefit plans, coverage tiers, enrollment effective dates, dependent coverage, and benefit cost contributions. Tracks benefit plan type (health, dental, vision, 401k, stock purchase, wellness), enrollment status, waiver records, and open enrollment period. Sourced from SAP S/4HANA HR Benefits Administration module. Supports ERISA compliance and total compensation reporting.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key.',
    `dev_project_id` BIGINT COMMENT 'Identifier of the primary game development project the employee was assigned to during the review period. Links performance to specific game titles and production milestones.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game studio or organizational unit where the employee is assigned. Used for studio-level performance analytics and capacity planning.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Performance review evaluates employee against the competencies and expectations defined in their job profile. Job profile defines core_competencies, technical_skills, and career_level expectations. Re',
    `employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed (reviewee). Links to employee master data in SAP S/4HANA HR module.',
    `review_cycle_id` BIGINT COMMENT 'Identifier of the review cycle or period (e.g., annual review 2024, mid-year review Q2 2024). Links to review cycle configuration.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the employee conducting the review (typically direct manager or supervisor).',
    `calibration_committee_notes` STRING COMMENT 'Confidential notes and rationale from the calibration committee regarding rating adjustments or validation. Used to ensure fairness and consistency in performance ratings across the organization.',
    `calibration_status` STRING COMMENT 'Status indicating whether the review has been through calibration committee review to ensure rating consistency across teams and studios. Values: not_calibrated (review not yet submitted to calibration), pending_calibration (awaiting calibration committee review), calibrated (reviewed and approved by calibration committee with no changes), calibration_adjusted (rating adjusted by calibration committee for consistency).. Valid values are `not_calibrated|pending_calibration|calibrated|calibration_adjusted`',
    `collaboration_rating` STRING COMMENT 'Rating for collaboration, teamwork, and cross-functional communication skills. Critical for game development teams working in agile sprints and cross-discipline collaboration.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `collaboration_score` DECIMAL(18,2) COMMENT 'Numeric score for collaboration rating on a standardized scale (e.g., 1.00 to 5.00).',
    `compensation_increase_percentage` DECIMAL(18,2) COMMENT 'Recommended percentage increase in base compensation based on performance rating (e.g., 5.50 represents a 5.5% salary increase). Confidential field used for compensation planning and budgeting.',
    `compensation_increase_recommended` BOOLEAN COMMENT 'Boolean flag indicating whether the reviewer recommends a compensation increase (salary raise, bonus, equity grant) based on performance. True if increase is recommended, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was first created in the system. Used for audit trail and data lineage tracking.',
    `development_plan_required` BOOLEAN COMMENT 'Boolean flag indicating whether a formal development plan or Performance Improvement Plan (PIP) is required based on the review outcome. True if development plan is required, False otherwise.',
    `employee_acknowledgement_date` DATE COMMENT 'Date when the employee acknowledged receipt and review of their performance evaluation. Indicates the employee has been informed of the review outcome.',
    `employee_acknowledgement_signature` STRING COMMENT 'Digital signature or acknowledgement token confirming the employee has reviewed and acknowledged the performance review. Used for compliance and record-keeping.',
    `employee_self_assessment` STRING COMMENT 'Employees self-assessment narrative describing their own performance, accomplishments, challenges, and development goals for the review period. Submitted prior to manager review.',
    `goal_achievement_percentage` DECIMAL(18,2) COMMENT 'Percentage of individual goals and objectives (OKRs) achieved during the review period (e.g., 85.50 represents 85.5% goal achievement). Calculated from individual goal tracking aligned to game development milestones.',
    `goals_met_count` STRING COMMENT 'Number of individual goals fully achieved during the review period.',
    `goals_total_count` STRING COMMENT 'Total number of individual goals set for the employee during the review period.',
    `innovation_rating` STRING COMMENT 'Rating for innovation, creativity, and problem-solving abilities. Particularly important for game designers, artists, and engineers developing new gameplay mechanics and features.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `innovation_score` DECIMAL(18,2) COMMENT 'Numeric score for innovation rating on a standardized scale (e.g., 1.00 to 5.00).',
    `leadership_rating` STRING COMMENT 'Rating for leadership capabilities including mentoring, decision-making, and team management. Applicable to lead developers, producers, directors, and managers. Set to not_applicable for individual contributor roles without leadership responsibilities.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding|not_applicable`',
    `leadership_score` DECIMAL(18,2) COMMENT 'Numeric score for leadership rating on a standardized scale (e.g., 1.00 to 5.00). Null if not applicable to role.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was last modified. Updated whenever any field in the review is changed. Used for audit trail and change tracking.',
    `overall_rating` STRING COMMENT 'Overall performance rating assigned to the employee for the review period. Ratings: outstanding (exceptional performance exceeding all goals), exceeds_expectations (consistently exceeds performance standards), meets_expectations (fully meets all performance standards), needs_improvement (performance below expectations requiring development), unsatisfactory (performance significantly below standards).. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall performance rating on a standardized scale (e.g., 1.00 to 5.00, where 5.00 is outstanding). Used for compensation calculations and talent analytics.',
    `promotion_readiness_level` STRING COMMENT 'Assessment of the employees readiness for promotion to the next level. Values: ready_now (ready for immediate promotion), ready_1_year (ready within 1 year with development), ready_2_years (ready within 2 years with development), not_ready (not ready for promotion), not_applicable (at terminal level or not applicable).. Valid values are `ready_now|ready_1_year|ready_2_years|not_ready|not_applicable`',
    `promotion_recommended` BOOLEAN COMMENT 'Boolean flag indicating whether the reviewer recommends the employee for promotion based on performance during the review period. True if promotion is recommended, False otherwise.',
    `review_approval_date` DATE COMMENT 'Date when the performance review was approved by the calibration committee or senior management.',
    `review_completion_date` DATE COMMENT 'Date when the performance review was delivered to the employee and the review process was completed.',
    `review_period_end_date` DATE COMMENT 'End date of the performance period being evaluated (e.g., 2024-12-31 for annual review covering calendar year 2024).',
    `review_period_start_date` DATE COMMENT 'Start date of the performance period being evaluated (e.g., 2024-01-01 for annual review covering calendar year 2024).',
    `review_status` STRING COMMENT 'Current lifecycle status of the performance review: draft (in progress by reviewer), submitted (awaiting manager approval), manager_review (under manager evaluation), calibration (in calibration committee review), approved (finalized and approved), completed (delivered to employee), cancelled (review cancelled). [ENUM-REF-CANDIDATE: draft|submitted|manager_review|calibration|approved|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `review_submission_date` DATE COMMENT 'Date when the reviewer submitted the completed performance review for approval.',
    `review_type` STRING COMMENT 'Type of performance review: annual (yearly comprehensive review), mid_year (semi-annual checkpoint), probation (new hire evaluation), project_end (post-project assessment), promotion (evaluation for advancement), pip (Performance Improvement Plan review).. Valid values are `annual|mid_year|probation|project_end|promotion|pip`',
    `reviewer_comments` STRING COMMENT 'Detailed narrative comments from the reviewer summarizing the employees performance, strengths, areas for improvement, and specific examples. Confidential feedback shared with the employee during the review discussion.',
    `technical_competency_rating` STRING COMMENT 'Rating for technical skills and competencies specific to the employees role (e.g., programming, game design, art creation, engine proficiency). Aligned to IGDA competency frameworks for game development roles.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `technical_competency_score` DECIMAL(18,2) COMMENT 'Numeric score for technical competency rating on a standardized scale (e.g., 1.00 to 5.00).',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Employee performance review records capturing review cycle, review period, overall rating, competency ratings, goal achievement scores, reviewer, reviewee, calibration status, and promotion recommendation. Supports annual and mid-year review cycles aligned to game development milestone cadences. Tracks IGDA-aligned competency frameworks for game developers, artists, designers, and production staff. Feeds into compensation review and career development planning.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`learning_enrollment` (
    `learning_enrollment_id` BIGINT COMMENT 'Unique identifier for the learning enrollment record. Primary key.',
    `contractor_id` BIGINT COMMENT 'Foreign key linking to workforce.contractor. Business justification: The product description explicitly states Employee and contractor training and learning program enrollment records. Contractors require onboarding training, compliance training (NDA, security, GDPR)',
    `course_id` BIGINT COMMENT 'Identifier of the course or certification program.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game studio or organizational unit to which the learner belongs at the time of enrollment.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor enrolled in the learning program.',
    `actual_completion_date` DATE COMMENT 'Date when the learner actually completed the course or certification. Null if not yet completed.',
    `attendance_percentage` DECIMAL(18,2) COMMENT 'Percentage of training sessions attended by the learner, applicable to instructor-led or scheduled courses.',
    `certification_earned` STRING COMMENT 'Name of the certification or credential earned upon successful completion (e.g., Unity Certified Developer, Unreal Engine Blueprint Professional).',
    `certification_expiry_date` DATE COMMENT 'Date when the earned certification expires and requires renewal. Null if certification does not expire.',
    `ceu_credits` DECIMAL(18,2) COMMENT 'Number of continuing education unit credits earned upon successful completion of the course.',
    `completion_status` STRING COMMENT 'Outcome of the learning program (pass, fail, incomplete, in progress, not started).. Valid values are `pass|fail|incomplete|in_progress|not_started`',
    `compliance_category` STRING COMMENT 'Category of compliance training if applicable (GDPR, COPPA, PCI DSS, harassment prevention, information security, data privacy, workplace safety, ethics, none). [ENUM-REF-CANDIDATE: gdpr|coppa|pci_dss|harassment_prevention|information_security|data_privacy|workplace_safety|ethics|none — 9 candidates stripped; promote to reference product]',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost of the training program in the base currency. Includes tuition, materials, and any associated fees.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `course_name` STRING COMMENT 'Full name of the course or certification program (e.g., Unity Advanced Rendering, Unreal Engine Blueprint Scripting, GDPR Compliance Training).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `delivery_method` STRING COMMENT 'Format in which the training is delivered (online, in-person, hybrid, self-paced, instructor-led, virtual classroom).. Valid values are `online|in_person|hybrid|self_paced|instructor_led|virtual_classroom`',
    `discipline` STRING COMMENT 'Category of the learning program aligned with game development functions (game engine training, platform SDK certification, leadership development, technical skills, QA, art and design, audio engineering, narrative design, project management, compliance training, soft skills). [ENUM-REF-CANDIDATE: game_engine_training|platform_sdk_certification|leadership_development|technical_skills|quality_assurance|art_and_design|audio_engineering|narrative_design|project_management|compliance_training|soft_skills — 11 candidates stripped; promote to reference product]',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the course in hours.',
    `enrollment_date` DATE COMMENT 'Date when the employee or contractor was enrolled in the learning program.',
    `enrollment_number` STRING COMMENT 'Business identifier for the enrollment, typically generated by the learning management system.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment (enrolled, in progress, completed, withdrawn, failed, expired).. Valid values are `enrolled|in_progress|completed|withdrawn|failed|expired`',
    `enrollment_type` STRING COMMENT 'Method by which the learner was enrolled (self-enrolled, manager-assigned, HR-assigned, system-assigned for mandatory training).. Valid values are `self_enrolled|manager_assigned|hr_assigned|system_assigned`',
    `feedback_comments` STRING COMMENT 'Free-text comments provided by the learner about the course experience.',
    `feedback_rating` DECIMAL(18,2) COMMENT 'Learners rating of the course quality, typically on a scale of 1.00 to 5.00.',
    `funding_source` STRING COMMENT 'Source of funding for the training (company-funded, employee-funded, shared, grant, scholarship).. Valid values are `company_funded|employee_funded|shared|grant|scholarship`',
    `instructor_name` STRING COMMENT 'Name of the instructor or facilitator for instructor-led training. Null for self-paced courses.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the training is mandatory (true) or voluntary (false). Mandatory training includes compliance courses such as GDPR, COPPA, PCI DSS, harassment prevention.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was last updated.',
    `learning_provider` STRING COMMENT 'Name of the organization or platform providing the training (e.g., Unity Learn, Coursera, LinkedIn Learning, internal studio training).',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the course or certification, typically as a percentage.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score or grade achieved by the learner, typically as a percentage (0.00 to 100.00).',
    `source_system` STRING COMMENT 'Name of the source system from which the enrollment record originated (e.g., SAP S/4HANA HR Learning Solution, external LMS).',
    `start_date` DATE COMMENT 'Date when the learner began the course or training program.',
    `target_completion_date` DATE COMMENT 'Planned or required date by which the learner should complete the course.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training is conducted (e.g., studio office, conference center, online platform URL).',
    `withdrawal_date` DATE COMMENT 'Date when the learner withdrew from the course. Null if not withdrawn.',
    `withdrawal_reason` STRING COMMENT 'Reason provided for withdrawing from the course before completion. Null if not withdrawn.',
    CONSTRAINT pk_learning_enrollment PRIMARY KEY(`learning_enrollment_id`)
) COMMENT 'Employee and contractor training and learning program enrollment records. Captures course or certification name, learning provider, discipline (game engine training, platform SDK certification, leadership development, IGDA professional development), enrollment date, completion date, pass/fail status, CEU credits, and cost. Tracks mandatory compliance training (GDPR, COPPA, PCI DSS, harassment prevention) and voluntary skill development. Sourced from SAP S/4HANA HR Learning Solution.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`absence_record` (
    `absence_record_id` BIGINT COMMENT 'Unique identifier for the employee absence record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or HR representative who approved or rejected the absence request. Links to the employee master record.',
    `dev_project_id` BIGINT COMMENT 'Identifier of the game development project the employee was assigned to during the absence period. Used for sprint capacity planning and resource allocation. Links to the development project master record.',
    `primary_absence_employee_id` BIGINT COMMENT 'Identifier of the employee who took the absence. Links to the employee master record.',
    `sprint_id` BIGINT COMMENT 'Identifier of the development sprint during which the absence occurred. Used to adjust sprint velocity and capacity. Links to the sprint master record.',
    `absence_reason` STRING COMMENT 'Free-text description of the reason for the absence provided by the employee. May contain sensitive health or personal information. Confidential.',
    `absence_status` STRING COMMENT 'Current approval and lifecycle status of the absence request: pending (awaiting approval), approved (approved by manager), rejected (denied), cancelled (withdrawn by employee), completed (employee has returned to work).. Valid values are `pending|approved|rejected|cancelled|completed`',
    `absence_type_code` STRING COMMENT 'Type of leave taken: PTO (Paid Time Off), SICK (Sick Leave), PARENTAL (Parental Leave), FMLA (Family and Medical Leave Act), BEREAVEMENT (Bereavement Leave), CRUNCH_RECOVERY (Crunch Recovery Leave for post-release rest periods).. Valid values are `PTO|SICK|PARENTAL|FMLA|BEREAVEMENT|CRUNCH_RECOVERY`',
    `accrual_balance_after` DECIMAL(18,2) COMMENT 'Employees leave accrual balance (in days) after this absence was deducted. Used for leave entitlement tracking.',
    `accrual_balance_before` DECIMAL(18,2) COMMENT 'Employees leave accrual balance (in days) before this absence was taken. Used for leave entitlement tracking.',
    `approval_date` DATE COMMENT 'Date when the absence request was approved by the manager. Format: yyyy-MM-dd. Nullable if not yet approved.',
    `business_days_count` STRING COMMENT 'Number of business days (excluding weekends and holidays) covered by the absence. Used for capacity planning and sprint scheduling.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation provided by the employee if the absence request was cancelled. Nullable if not cancelled.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this absence record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail.',
    `duration_days` DECIMAL(18,2) COMMENT 'Total duration of the absence in calendar days, including partial days (e.g., 5.5 days for a half-day absence). Calculated from start_date and end_date.',
    `end_date` DATE COMMENT 'Last date of the absence period. Format: yyyy-MM-dd. Nullable for open-ended leaves.',
    `impact_on_sprint` STRING COMMENT 'Assessed impact of the absence on sprint delivery: none (no impact), low (minimal impact), medium (moderate impact requiring task reassignment), high (significant impact on sprint goals), critical (sprint goals at risk).. Valid values are `none|low|medium|high|critical`',
    `is_fmla_qualified` BOOLEAN COMMENT 'Indicates whether the absence qualifies under FMLA regulations (True) or not (False). Used for compliance tracking.',
    `is_paid` BOOLEAN COMMENT 'Indicates whether the absence is paid leave (True) or unpaid leave (False). Determines payroll impact.',
    `is_statutory_leave` BOOLEAN COMMENT 'Indicates whether the absence is mandated by statutory law (True) such as parental leave, sick leave, or bereavement leave under local labor laws, or discretionary (False).',
    `medical_certificate_received` BOOLEAN COMMENT 'Indicates whether the required medical certificate has been received and verified (True) or not (False). Nullable if not required.',
    `medical_certificate_required` BOOLEAN COMMENT 'Indicates whether a medical certificate or doctors note is required for this absence (True) or not (False). Typically required for sick leave exceeding a threshold duration.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this absence record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the absence record, entered by HR, manager, or employee. May include handover instructions or special arrangements.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver if the absence request was rejected. Nullable if not rejected.',
    `request_date` DATE COMMENT 'Date when the employee submitted the absence request. Format: yyyy-MM-dd.',
    `return_to_work_date` DATE COMMENT 'Actual date the employee returned to work after the absence. Format: yyyy-MM-dd. Nullable if absence is ongoing or employee has not yet returned.',
    `start_date` DATE COMMENT 'First date of the absence period. Format: yyyy-MM-dd.',
    CONSTRAINT pk_absence_record PRIMARY KEY(`absence_record_id`)
) COMMENT 'Employee absence and leave records capturing leave type (PTO, sick leave, parental leave, FMLA, bereavement, crunch recovery leave), start date, end date, duration in days, approval status, approver, and return-to-work date. Sourced from SAP S/4HANA HR Time Management module. Supports studio capacity planning by tracking developer availability during game development sprints and crunch periods. Tracks FMLA and statutory leave compliance.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` (
    `recruitment_requisition_id` BIGINT COMMENT 'Unique identifier for the recruitment requisition record. Primary key for the recruitment requisition entity.',
    `cost_center_id` BIGINT COMMENT 'Financial cost center that will bear the compensation and benefits expenses for this position. Used for budget tracking and financial planning.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Requisition approval workflows require validation against approved budget line items. Hiring managers must demonstrate budget availability before opening positions. Gaming studios enforce budget contr',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game development studio or organizational unit where the position is located. Used for studio capacity planning and headcount allocation.',
    `job_profile_id` BIGINT COMMENT 'Reference to the standardized job profile defining role responsibilities, required skills, and compensation band for this position.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the specific organizational unit (department, team) within the studio where the position will be assigned.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Requisitions are opened to fill specific authorized positions. This links the DEMAND (requisition) to the SUPPLY (authorized position). Strong business relationship - requisitions exist to fill positi',
    `employee_id` BIGINT COMMENT 'Employee identifier of the hiring manager who will supervise the new hire and is responsible for final candidate selection.',
    `tertiary_recruitment_approved_by_employee_id` BIGINT COMMENT 'Employee identifier of the HR or executive leader who granted final approval for this requisition.',
    `approval_date` DATE COMMENT 'Date when the requisition received final approval from hiring manager and HR leadership to proceed with candidate sourcing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was first created in the system. Used for audit trail and data lineage.',
    `discipline` STRING COMMENT 'Functional discipline or specialization area for the position (e.g., Game Design, Engineering, Art, Animation, QA, Esports Operations, Live Ops).',
    `diversity_hiring_flag` BOOLEAN COMMENT 'Indicates whether this requisition is part of a diversity and inclusion hiring initiative. Supports diversity pipeline analytics.',
    `education_level_required` STRING COMMENT 'Minimum educational qualification required for the position (e.g., Bachelors Degree in Computer Science, equivalent industry experience).',
    `employment_type` STRING COMMENT 'Classification of the employment relationship for this position (full-time employee, contractor, intern, etc.).. Valid values are `full_time|part_time|contractor|temporary|intern|seasonal`',
    `headcount_type` STRING COMMENT 'Classification indicating whether this is a net-new position, a backfill for a departure, or a replacement for an internal transfer.. Valid values are `new_position|backfill|replacement|expansion`',
    `is_relocation_offered` BOOLEAN COMMENT 'Indicates whether the company will provide relocation assistance for candidates moving to the studio location.',
    `is_remote_eligible` BOOLEAN COMMENT 'Indicates whether the position allows remote work arrangements. Supports distributed studio workforce models.',
    `is_visa_sponsorship_available` BOOLEAN COMMENT 'Indicates whether the company will sponsor work visas for international candidates. Critical for global talent acquisition.',
    `job_description` STRING COMMENT 'Detailed description of the role responsibilities, required skills, qualifications, and experience. Used for job postings and candidate screening.',
    `location_city` STRING COMMENT 'City where the position is physically located or where the studio office is based.',
    `location_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the position location. Used for compliance with local labor laws and GDPR data residency requirements.. Valid values are `^[A-Z]{3}$`',
    `min_years_experience` STRING COMMENT 'Minimum number of years of relevant industry experience required for the position.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was last updated. Used for change tracking and audit compliance.',
    `number_of_openings` STRING COMMENT 'Quantity of positions to be filled under this single requisition. Supports bulk hiring for studio expansion or project ramp-up.',
    `position_level` STRING COMMENT 'Seniority level of the position within the organizational hierarchy. Used for compensation banding and career progression planning. [ENUM-REF-CANDIDATE: entry|mid|senior|lead|principal|director|executive — 7 candidates stripped; promote to reference product]',
    `position_title` STRING COMMENT 'The official job title for the open position (e.g., Senior Game Designer, Lead Gameplay Programmer, Esports Operations Manager).',
    `preferred_skills` STRING COMMENT 'Comma-separated list of desirable but not mandatory skills that would enhance candidate fit for the role.',
    `priority_level` STRING COMMENT 'Business priority assigned to this requisition. Critical priority indicates positions blocking game development milestones or live operations.. Valid values are `low|medium|high|critical`',
    `required_skills` STRING COMMENT 'Comma-separated list of mandatory technical and functional skills for the position (e.g., Unity, Unreal Engine, C++, game design, esports operations).',
    `requisition_close_date` DATE COMMENT 'Date when the requisition was closed (filled, cancelled, or withdrawn). End of the time-to-fill measurement period.',
    `requisition_number` STRING COMMENT 'Business identifier for the requisition, externally visible and used for tracking and communication across HR systems and hiring managers.. Valid values are `^REQ-[0-9]{6,10}$`',
    `requisition_open_date` DATE COMMENT 'Date when the requisition was approved and opened for active candidate sourcing. Start of the time-to-fill measurement period.',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the requisition in the hiring workflow. Tracks progression from draft through approval to closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|open|on_hold|filled|cancelled|closed — 8 candidates stripped; promote to reference product]',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary range (e.g., USD, EUR, GBP). Supports multi-currency compensation for global studios.. Valid values are `^[A-Z]{3}$`',
    `salary_range_max` DECIMAL(18,2) COMMENT 'Maximum annual salary or hourly rate for the position. Upper bound of the compensation band for this role level.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'Minimum annual salary or hourly rate for the position. Used for budget planning and candidate expectation management.',
    `sourcing_channels` STRING COMMENT 'Comma-separated list of candidate sourcing channels approved for this requisition (e.g., job boards, referrals, campus recruiting, esports talent pipeline, LinkedIn, industry events).',
    `target_start_date` DATE COMMENT 'Desired onboarding date for the new hire. Used for production scheduling and studio capacity planning.',
    `time_to_fill_days` STRING COMMENT 'Calculated number of days from requisition open date to close date. Key performance indicator (KPI) for recruitment efficiency.',
    `total_candidates_applied` STRING COMMENT 'Total number of candidates who submitted applications for this requisition. Used for source channel effectiveness analysis.',
    `total_candidates_interviewed` STRING COMMENT 'Total number of candidates who progressed to interview stage. Used for funnel conversion analysis.',
    `total_offers_extended` STRING COMMENT 'Total number of job offers extended to candidates for this requisition. Used for offer acceptance rate calculation.',
    CONSTRAINT pk_recruitment_requisition PRIMARY KEY(`recruitment_requisition_id`)
) COMMENT 'Headcount requisition and talent acquisition records managing the end-to-end hiring pipeline from requisition approval through candidate management to offer acceptance. Requisition details: requisition number, position reference, job profile, hiring manager, recruiter, studio location, target start date, status, sourcing channels, time-to-fill. Candidate records: candidate name, contact details, source channel (referral, job board, campus, esports talent pipeline), application date, pipeline stage (applied, screened, interviewed, offered, hired, rejected), portfolio URL, discipline, interview scores, and GDPR consent for data retention. Single source of truth for all talent acquisition activity. Supports hiring velocity reporting, source channel effectiveness, and diversity pipeline analytics for game development and esports operations roles.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`candidate` (
    `candidate_id` BIGINT COMMENT 'Unique identifier for the candidate record. Primary key for the candidate entity.',
    `application_id` BIGINT COMMENT 'External application identifier assigned when candidate submits application. Business-facing reference number used in candidate communications and ATS tracking.. Valid values are `^APP-[0-9]{8}$`',
    `employee_id` BIGINT COMMENT 'Employee ID of the hiring manager for the target role. Used for interview coordination and hiring decision tracking.',
    `candidate_recruiter_employee_id` BIGINT COMMENT 'Employee ID of the recruiter or talent acquisition specialist managing this candidate. Used for workload balancing and recruiter performance metrics.',
    `candidate_referrer_employee_id` BIGINT COMMENT 'Employee ID of the internal employee who referred this candidate. Used for employee referral bonus tracking and referral program effectiveness analysis. Null if candidate was not referred by an employee.',
    `game_studio_id` BIGINT COMMENT 'Studio or organizational unit the candidate is being recruited for. Supports studio-specific headcount planning and capacity management.',
    `player_account_id` BIGINT COMMENT 'Foreign key linking to player.player_account. Business justification: Gaming companies actively recruit from their player communities (passionate players make better developers/designers). Linking candidates to their player accounts enables recruiters to assess product ',
    `recruitment_requisition_id` BIGINT COMMENT 'Foreign key linking to workforce.recruitment_requisition. Business justification: Candidate applies to a specific recruitment requisition. This is the core relationship in the hiring pipeline. No columns removed as candidate has application-specific fields (application_date, applic',
    `application_date` DATE COMMENT 'Date when the candidate submitted their application. Used for time-to-hire metrics and recruitment funnel analysis.',
    `application_status` STRING COMMENT 'Current stage of the candidate in the recruitment pipeline. Tracks progression from initial application through final hiring decision or rejection. [ENUM-REF-CANDIDATE: applied|screened|interviewed|offered|hired|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `background_check_status` STRING COMMENT 'Status of pre-employment background check process. Required for compliance with industry security standards and child safety regulations (COPPA). Confidential screening data.. Valid values are `not_started|in_progress|cleared|flagged|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was first created in the system. Used for audit trail and recruitment funnel time-to-hire analysis.',
    `current_employer` STRING COMMENT 'Name of candidates current employer. Used for conflict of interest checks and competitive intelligence. Confidential to protect candidate privacy during active employment.',
    `current_job_title` STRING COMMENT 'Candidates current job title or most recent role. Used for seniority assessment and role mapping to internal job architecture.',
    `data_retention_expiry_date` DATE COMMENT 'Date when candidate data must be purged per GDPR right to be forgotten and data retention policies. Typically set based on application date plus retention period for non-hired candidates.',
    `discipline` STRING COMMENT 'Primary functional discipline or role category the candidate is applying for (e.g., Game Designer, Software Engineer, 3D Artist, Producer, QA Tester, Esports Coach, Community Manager). Aligns with studio skill matrices and workforce planning categories.',
    `earliest_start_date` DATE COMMENT 'Earliest date the candidate can begin employment. Critical for sprint planning and project milestone staffing.',
    `email_address` STRING COMMENT 'Primary email address for candidate communication. Used for interview scheduling, offer letters, and recruitment correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expected_salary_amount` DECIMAL(18,2) COMMENT 'Candidates expected annual salary or compensation. Used for budget alignment and offer preparation. Confidential financial information.',
    `expected_salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for expected salary. Supports international recruitment and multi-currency compensation planning.. Valid values are `^[A-Z]{3}$`',
    `first_name` STRING COMMENT 'Legal first name of the candidate as provided in application. Used for formal communications and background checks.',
    `gdpr_consent_date` DATE COMMENT 'Date when GDPR consent was obtained from the candidate. Used for consent expiration tracking and data retention policy enforcement.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether candidate has provided explicit consent for data retention and processing under GDPR. Required for EU candidate data retention compliance.',
    `interview_count` STRING COMMENT 'Total number of interviews conducted with this candidate. Used for recruitment process efficiency analysis and candidate experience optimization.',
    `is_remote_eligible` BOOLEAN COMMENT 'Indicates whether the candidate is eligible and willing to work remotely. Supports distributed team planning and remote-first studio operations.',
    `last_interview_date` DATE COMMENT 'Date of the most recent interview with this candidate. Used for follow-up scheduling and recruitment velocity tracking.',
    `last_name` STRING COMMENT 'Legal last name of the candidate as provided in application. Used for formal communications and background checks.',
    `location_city` STRING COMMENT 'City where the candidate currently resides. Used for relocation planning and remote work eligibility assessment.',
    `location_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for candidates current location. Used for work authorization and visa requirement assessment.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was last modified. Used for audit trail and data freshness tracking.',
    `notes` STRING COMMENT 'Free-text notes and observations from recruiters and hiring managers. Used for candidate evaluation context and interview coordination. Confidential evaluation data.',
    `notice_period_days` STRING COMMENT 'Number of days notice required at candidates current employer before they can start. Used for project staffing timeline planning and start date negotiation.',
    `offer_accepted_date` DATE COMMENT 'Date when candidate accepted the employment offer. Triggers onboarding workflow and marks successful recruitment completion.',
    `offer_extended_date` DATE COMMENT 'Date when employment offer was extended to the candidate. Used for offer acceptance rate analysis and time-to-hire metrics.',
    `overall_rating` DECIMAL(18,2) COMMENT 'Aggregate rating score from all interviewers, typically on a scale of 1.00 to 5.00. Used for candidate ranking and hiring decision support. Confidential evaluation data.',
    `phone_number` STRING COMMENT 'Primary contact phone number for candidate. Used for interview coordination and urgent recruitment communications.',
    `portfolio_url` STRING COMMENT 'Web link to candidates professional portfolio, demo reel, GitHub repository, ArtStation profile, or other work samples. Critical for evaluating creative and technical talent in game development roles.. Valid values are `^https?://.*$`',
    `preferred_game_engine` STRING COMMENT 'Game engine the candidate has primary expertise in. Critical for matching candidates to studio technology stacks and project requirements.. Valid values are `unity|unreal|proprietary|godot|other`',
    `primary_skill` STRING COMMENT 'Candidates primary technical or creative skill (e.g., Unity, Unreal Engine, C++, Character Animation, Level Design, Live Ops Management). Used for skill gap analysis and team composition planning.',
    `rejection_reason` STRING COMMENT 'Reason for candidate rejection if application status is rejected. Used for recruitment process improvement and legal compliance documentation. Confidential to protect candidate privacy.',
    `requires_visa_sponsorship` BOOLEAN COMMENT 'Indicates whether the candidate requires work visa sponsorship for the target role location. Critical for immigration planning and hiring timeline estimation.',
    `secondary_skills` STRING COMMENT 'Comma-separated list of additional skills and competencies. Supports cross-functional team placement and multi-disciplinary project staffing.',
    `source_channel` STRING COMMENT 'Channel through which the candidate was sourced. Tracks recruitment marketing effectiveness and talent pipeline origins. Esports talent pipeline represents candidates identified through competitive gaming and esports community engagement. [ENUM-REF-CANDIDATE: referral|job_board|campus|esports_talent_pipeline|linkedin|career_site|recruiter_outreach — 7 candidates stripped; promote to reference product]',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of relevant professional experience in the gaming industry or related fields. Used for seniority assessment and compensation benchmarking.',
    CONSTRAINT pk_candidate PRIMARY KEY(`candidate_id`)
) COMMENT 'Candidate master records for individuals in the recruitment pipeline for employee positions. Captures candidate name, contact details, source channel (referral, job board, campus, esports talent pipeline), application date, current stage (applied, screened, interviewed, offered, hired, rejected), portfolio URL, discipline, and GDPR consent for data retention. Distinct from employee as candidates have not yet been hired. Supports talent acquisition for game development and esports operations roles.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` (
    `studio_capacity_plan_id` BIGINT COMMENT 'Unique identifier for the studio capacity plan record.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this capacity plan and associated labor costs are allocated.',
    `dev_project_id` BIGINT COMMENT 'Reference to the game development project or title that this capacity allocation supports. Nullable for studio-wide capacity planning not tied to a specific project.',
    `game_studio_id` BIGINT COMMENT 'Reference to the game studio for which this capacity plan is defined.',
    `milestone_id` BIGINT COMMENT 'Reference to the game development milestone (e.g., Alpha, Beta, Gold Master) that this capacity plan supports. Nullable for non-milestone-based planning.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Studio capacity plan should be linked to the specific org unit being planned. Capacity planning operates at org_unit + discipline + seniority level. This enables rolling up capacity plans by org unit ',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically studio head, HR director, or production director) who approved this capacity plan.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Studio capacity planning for title development requires profit center linkage for P&L forecasting and resource allocation across titles. Gaming studios allocate capacity to profit centers (titles/plat',
    `allocated_fte` DECIMAL(18,2) COMMENT 'The number of full-time equivalent staff allocated to the project or work stream during the planning period.',
    `approval_status` STRING COMMENT 'The approval status of the capacity plan: pending (awaiting review), approved (approved by authorized approver), rejected (not approved), or revision_requested (requires changes before approval).. Valid values are `pending|approved|rejected|revision_requested`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the capacity plan was approved.',
    `available_fte` DECIMAL(18,2) COMMENT 'The total number of full-time equivalent staff available in the studio for this discipline and seniority band during the planning period, including existing headcount and approved hires.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The total labor budget allocated for this capacity plan during the planning period, including salaries, contractor fees, and benefits.',
    `budget_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `capacity_gap_fte` DECIMAL(18,2) COMMENT 'The capacity gap calculated as demand FTE minus available FTE. Positive values indicate a shortage; negative values indicate surplus capacity.',
    `contractor_count` STRING COMMENT 'The number of external contractors or temporary staff planned to supplement internal capacity during the planning period.',
    `contractor_fte` DECIMAL(18,2) COMMENT 'The full-time equivalent capacity provided by contractors during the planning period, accounting for part-time and short-term engagements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this capacity plan record was first created in the system.',
    `demand_fte` DECIMAL(18,2) COMMENT 'The total FTE demand required by the project or studio operations during the planning period, based on project scope and production schedule.',
    `development_methodology` STRING COMMENT 'The software development methodology used by the studio or project: agile, scrum, kanban, waterfall, or hybrid. Influences sprint planning and capacity allocation patterns.. Valid values are `agile|scrum|kanban|waterfall|hybrid`',
    `discipline` STRING COMMENT 'The game development discipline for which capacity is being planned: engineering (programmers), art (artists, animators), design (game designers), QA (quality assurance testers), production (producers, project managers), audio (sound designers, composers), narrative (writers), or UI/UX (user interface and experience designers). [ENUM-REF-CANDIDATE: engineering|art|design|qa|production|audio|narrative|ui_ux|data_analytics|devops|live_ops — promote to reference product]',
    `game_engine` STRING COMMENT 'The primary game engine technology used by the studio or project, which influences skill requirements and capacity planning: Unity, Unreal Engine, proprietary engine, or other.. Valid values are `unity|unreal|proprietary|other`',
    `is_baseline` BOOLEAN COMMENT 'Boolean flag indicating whether this is the baseline (original approved) capacity plan for the period. True if baseline, False if a revised or forecast version.',
    `location_city` STRING COMMENT 'The city where the studio is located, supporting multi-location capacity planning and geographic workforce distribution analysis.',
    `location_country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code for the studio location (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `modified_by` STRING COMMENT 'The username or system identifier of the user who last modified this capacity plan record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this capacity plan record was last modified.',
    `notes` STRING COMMENT 'Free-text notes and comments about the capacity plan, including assumptions, constraints, risks, and mitigation strategies.',
    `onsite_fte` DECIMAL(18,2) COMMENT 'The number of FTE working onsite at the studio location during the planning period.',
    `plan_code` STRING COMMENT 'Business identifier code for the capacity plan, typically combining studio code, quarter, and version (e.g., STU_NYC_Q1_2024_V1).. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `plan_name` STRING COMMENT 'Human-readable name for the capacity plan (e.g., NYC Studio Q1 2024 Capacity Plan).',
    `plan_status` STRING COMMENT 'The current lifecycle status of the capacity plan: draft (being prepared), submitted (awaiting approval), approved (approved by management), active (currently in effect), closed (planning period completed), or cancelled (plan abandoned).. Valid values are `draft|submitted|approved|active|closed|cancelled`',
    `planning_period_end_date` DATE COMMENT 'The end date of the planning period covered by this capacity plan.',
    `planning_period_start_date` DATE COMMENT 'The start date of the planning period covered by this capacity plan.',
    `planning_period_type` STRING COMMENT 'The granularity of the planning period: sprint (agile sprint cycle), milestone (game development milestone), quarter (fiscal quarter), month, year, or custom.. Valid values are `sprint|milestone|quarter|month|year|custom`',
    `remote_fte` DECIMAL(18,2) COMMENT 'The number of FTE working remotely during the planning period, supporting remote-first or hybrid workforce planning.',
    `seniority_band` STRING COMMENT 'The seniority level of staff being planned: junior, mid-level, senior, lead, principal, or director.. Valid values are `junior|mid|senior|lead|principal|director`',
    `sprint_number` STRING COMMENT 'The sprint number within the project or release cycle, if planning period type is sprint. Nullable for non-sprint planning periods.',
    `utilization_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of available FTE that is allocated to billable or project work, calculated as (allocated FTE / available FTE) * 100. Used to measure studio efficiency and capacity planning accuracy.',
    `version_number` STRING COMMENT 'The version number of this capacity plan, incremented when the plan is revised or updated during the planning period.',
    `created_by` STRING COMMENT 'The username or system identifier of the user who created this capacity plan record.',
    CONSTRAINT pk_studio_capacity_plan PRIMARY KEY(`studio_capacity_plan_id`)
) COMMENT 'Studio-level capacity planning records mapping available developer and production staff FTE to game development project demands by sprint, milestone, and quarter. Captures studio, project or title reference, planning period, discipline breakdown (engineering, art, design, QA, production), available FTE, allocated FTE, utilization rate, contractor supplement count, and capacity gap. Directly supports game development production scheduling and GaaS live operations staffing.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique identifier for the payroll run execution event. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Primary cost center to which payroll expenses from this run are allocated. Used for departmental cost tracking and budget variance analysis.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game studio or business unit for which this payroll run is executed. Supports studio-level labor cost reporting and capacity planning.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Payroll runs are jurisdiction-specific for tax and labor law compliance (different rules per country/state). Required for payroll compliance reporting, tax filing by jurisdiction, and multi-country st',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Payroll runs are executed by specific legal entities for statutory compliance, tax filing, and regulatory reporting. Each legal entity has distinct payroll calendars, tax jurisdictions, and filing req',
    `payroll_calendar_id` BIGINT COMMENT 'Identifier of the payroll calendar that defines the schedule of pay periods and payment dates for this run. Links to the master payroll calendar configuration.',
    `reversal_run_payroll_run_id` BIGINT COMMENT 'Reference to the payroll run that reverses this run if corrections or cancellations are needed. Null if this run has not been reversed.',
    `approval_status` STRING COMMENT 'Approval workflow status for this payroll run. Payroll runs typically require manager or finance approval before posting to GL and disbursing payments.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this payroll run for processing and payment. Part of audit trail for payroll governance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll run was approved. Used for audit trails and compliance with segregation of duties requirements.',
    `check_date` DATE COMMENT 'Date printed on physical checks or used as the effective date for electronic payments. May differ from payment_date for banking processing reasons.',
    `company_code` STRING COMMENT 'Legal entity or company code in the ERP system for which this payroll run is executed. Used for multi-entity financial consolidation and statutory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll run record was first created in the system. Used for audit trails and process timing analysis.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this payroll run (e.g., USD, EUR, GBP). Supports multi-currency payroll for global studios.. Valid values are `^[A-Z]{3}$`',
    `error_count` STRING COMMENT 'Number of errors or exceptions encountered during payroll run processing. Used for quality monitoring and process improvement.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year to which this payroll run belongs. Used for monthly financial close and reporting.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this payroll run belongs for financial reporting purposes. Supports year-over-year labor cost analysis.',
    `gl_document_number` STRING COMMENT 'Document number of the GL posting created for this payroll run. Links payroll data to financial accounting records for reconciliation and audit.',
    `gl_posting_date` DATE COMMENT 'Date when payroll expenses and liabilities are posted to the General Ledger for financial reporting. Critical for period-end close and GAAP compliance.',
    `is_reversal` BOOLEAN COMMENT 'Flag indicating whether this payroll run is a reversal of a previous run. True if this run reverses a prior run, false for normal runs.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this payroll run record. Part of audit trail for change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll run record was last modified. Used for audit trails and tracking changes to payroll runs.',
    `pay_group_code` STRING COMMENT 'Code identifying the pay group (e.g., salaried, hourly, contractors, executives) that this payroll run processes. Pay groups segment employees by payment frequency and rules.',
    `pay_period_end_date` DATE COMMENT 'End date of the pay period covered by this payroll run. Defines the close of the earnings and deductions calculation window.',
    `pay_period_start_date` DATE COMMENT 'Start date of the pay period covered by this payroll run. Defines the beginning of the earnings and deductions calculation window.',
    `payment_date` DATE COMMENT 'Scheduled date when employees will receive payment for this payroll run. Used for cash flow planning and employee communication.',
    `payment_method_summary` STRING COMMENT 'Summary of payment methods used in this run (e.g., 85% direct deposit, 10% check, 5% paycard). Provides high-level view of disbursement channels.',
    `payroll_area` STRING COMMENT 'Organizational grouping that defines payroll processing frequency and rules (e.g., US-Monthly, UK-Weekly, CA-Biweekly). Combines geography and payment frequency.',
    `payroll_run_name` STRING COMMENT 'Descriptive name for this payroll run (e.g., January 2024 Salaried, Q4 Bonus Run, Off-Cycle Correction). Improves readability in reports and user interfaces.',
    `posted_by` STRING COMMENT 'User ID or name of the person who posted this payroll run to the General Ledger. Part of audit trail for financial posting governance.',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll run was posted to the General Ledger. Marks the point when payroll expenses became part of official financial records.',
    `processing_notes` STRING COMMENT 'Free-text notes about special circumstances, exceptions, or issues encountered during this payroll run. Used for documentation and knowledge transfer.',
    `run_execution_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll run calculation was executed. Used for audit trails and troubleshooting processing issues.',
    `run_number` STRING COMMENT 'Business identifier for the payroll run, typically a sequential or formatted code used for external reference and audit trails.',
    `run_status` STRING COMMENT 'Current lifecycle status of the payroll run: draft (prepared but not executed), in-progress (currently processing), completed (calculation finished), posted (posted to General Ledger), cancelled (run voided), or failed (processing error).. Valid values are `draft|in-progress|completed|posted|cancelled|failed`',
    `run_type` STRING COMMENT 'Type of payroll run execution: regular (scheduled periodic payroll), off-cycle (unscheduled mid-period run), bonus (special bonus payment run), correction (adjustment run), final (termination payroll), or advance (early payment).. Valid values are `regular|off-cycle|bonus|correction|final|advance`',
    `total_employee_deductions` DECIMAL(18,2) COMMENT 'Sum of all employee-side deductions (income tax, social security, benefits, garnishments, 401k contributions) withheld from gross pay in this payroll run.',
    `total_employees_processed` STRING COMMENT 'Count of employees included in this payroll run. Used for reconciliation and validation that all expected employees were paid.',
    `total_employer_contributions` DECIMAL(18,2) COMMENT 'Sum of all employer-side contributions (employer portion of social security, health insurance, retirement matching, payroll taxes) for this payroll run. Represents additional labor cost beyond gross pay.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'Sum of all gross earnings (base salary, overtime, bonuses, allowances) for all employees in this payroll run before any deductions. Key metric for labor cost reporting.',
    `total_net_pay` DECIMAL(18,2) COMMENT 'Sum of all net pay (gross pay minus all deductions) for all employees in this payroll run. Represents the total cash disbursement amount.',
    `total_tax_withheld` DECIMAL(18,2) COMMENT 'Sum of all tax withholdings (federal, state, local income tax, social security, Medicare) for all employees in this payroll run. Used for tax remittance and statutory reporting.',
    `warning_count` STRING COMMENT 'Number of warnings generated during payroll run processing. Warnings indicate potential issues that did not prevent processing but require review.',
    `created_by` STRING COMMENT 'User ID or name of the person who initiated this payroll run. Part of audit trail for payroll governance and segregation of duties.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Payroll processing and payment records capturing run-level execution events and individual employee pay details (payslips). Run-level: payroll period, pay group, run type (regular, off-cycle, bonus), run status, total gross/net pay, total deductions, employer contributions, currency, and GL posting date. Employee-level (payslip): individual gross pay, net pay, itemized earnings (base, overtime, bonus, allowances), itemized deductions (tax, benefits, garnishments, 401k), payment method, pay period dates, and payslip document reference. Single source of truth for all payroll and employee pay data. Supports payroll audit, finance reconciliation, labor cost reporting, employee self-service pay statements, and statutory reporting (W-2, P60). Primary source system: SAP S/4HANA HR Payroll.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`payslip` (
    `payslip_id` BIGINT COMMENT 'Unique identifier for the payslip record. Primary key.',
    `compensation_id` BIGINT COMMENT 'Foreign key linking to workforce.compensation. Business justification: Payslip is generated based on the employees active compensation record. Compensation defines base salary, bonus target, equity grants. No columns removed because payslip contains execution-specific a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payroll accounting requires cost center allocation for labor cost distribution to departments, projects, and titles. Essential for financial reporting, variance analysis, and departmental P&L. Gaming ',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom this payslip belongs. Links to the employee master record.',
    `payroll_run_id` BIGINT COMMENT 'Identifier of the payroll run cycle during which this payslip was generated. Links to the payroll run master.',
    `allowances_total` DECIMAL(18,2) COMMENT 'Sum of all allowances such as housing, transportation, meal, or other stipends provided to the employee.',
    `approved_by` STRING COMMENT 'User ID or name of the payroll administrator or manager who approved this payslip for payment.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this payslip was approved for payment.',
    `bank_account_last_four` STRING COMMENT 'Last four digits of the employees bank account number used for direct deposit, for verification and audit purposes.. Valid values are `^[0-9]{4}$`',
    `base_salary` DECIMAL(18,2) COMMENT 'The regular base salary or wage amount earned by the employee during the pay period before any additions or deductions.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Discretionary or performance-based bonus payment included in this payslip.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Sales commission or incentive payment earned during the pay period.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary amounts on this payslip are denominated.. Valid values are `^[A-Z]{3}$`',
    `dental_insurance_deduction` DECIMAL(18,2) COMMENT 'Employee contribution toward dental insurance premiums deducted from gross pay.',
    `employer_401k_match` DECIMAL(18,2) COMMENT 'Employers matching contribution to the employees 401(k) retirement plan for this pay period.',
    `employer_health_insurance_contribution` DECIMAL(18,2) COMMENT 'Employers contribution toward the employees health insurance premiums for this pay period.',
    `employer_medicare_contribution` DECIMAL(18,2) COMMENT 'Employers matching contribution to Medicare tax for this pay period.',
    `employer_social_security_contribution` DECIMAL(18,2) COMMENT 'Employers matching contribution to social security tax for this pay period.',
    `federal_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of federal income tax withheld from the employees gross pay for the pay period.',
    `garnishment_deduction` DECIMAL(18,2) COMMENT 'Court-ordered wage garnishment amount deducted from gross pay for child support, alimony, tax levies, or other legal obligations.',
    `generated_timestamp` TIMESTAMP COMMENT 'The date and time when this payslip record was generated by the payroll system.',
    `gross_pay` DECIMAL(18,2) COMMENT 'Total earnings before any deductions, calculated as the sum of base salary, overtime, bonuses, commissions, and allowances.',
    `health_insurance_deduction` DECIMAL(18,2) COMMENT 'Employee contribution toward health insurance premiums deducted from gross pay.',
    `local_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of local or municipal income tax withheld from the employees gross pay for the pay period.',
    `medicare_tax` DECIMAL(18,2) COMMENT 'Employee portion of Medicare tax (FICA) withheld from gross pay.',
    `net_pay` DECIMAL(18,2) COMMENT 'The final take-home pay amount disbursed to the employee after all deductions, calculated as gross pay minus total deductions.',
    `other_deductions_total` DECIMAL(18,2) COMMENT 'Sum of all other miscellaneous deductions not categorized above, such as union dues, charitable contributions, or loan repayments.',
    `overtime_pay` DECIMAL(18,2) COMMENT 'Additional compensation for hours worked beyond the standard work schedule during the pay period.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid (weekly, biweekly, semimonthly, or monthly).. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_period_end_date` DATE COMMENT 'The last date of the pay period covered by this payslip.',
    `pay_period_start_date` DATE COMMENT 'The first date of the pay period covered by this payslip.',
    `payment_date` DATE COMMENT 'The date on which the net pay was or will be disbursed to the employee.',
    `payment_method` STRING COMMENT 'The method by which net pay is disbursed to the employee (direct deposit, physical check, cash, or wire transfer).. Valid values are `direct_deposit|check|cash|wire_transfer`',
    `payslip_number` STRING COMMENT 'Human-readable unique payslip document number assigned by the payroll system for reference and audit purposes.',
    `payslip_status` STRING COMMENT 'Current lifecycle status of the payslip record indicating whether it is in draft, approved for payment, paid, voided, or corrected.. Valid values are `draft|approved|paid|voided|corrected`',
    `retirement_401k_deduction` DECIMAL(18,2) COMMENT 'Employee contribution to 401(k) retirement plan deducted from gross pay on a pre-tax or post-tax basis.',
    `social_security_tax` DECIMAL(18,2) COMMENT 'Employee portion of social security tax (FICA) withheld from gross pay.',
    `state_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of state income tax withheld from the employees gross pay for the pay period.',
    `total_deductions` DECIMAL(18,2) COMMENT 'Sum of all deductions including taxes, benefits, retirement contributions, garnishments, and other withholdings.',
    `vision_insurance_deduction` DECIMAL(18,2) COMMENT 'Employee contribution toward vision insurance premiums deducted from gross pay.',
    `year_to_date_401k_contribution` DECIMAL(18,2) COMMENT 'Cumulative employee 401(k) contributions from the beginning of the calendar or fiscal year through the end of this pay period.',
    `year_to_date_federal_tax` DECIMAL(18,2) COMMENT 'Cumulative federal income tax withheld from the employees pay from the beginning of the calendar or fiscal year through the end of this pay period.',
    `year_to_date_gross_pay` DECIMAL(18,2) COMMENT 'Cumulative gross pay earned by the employee from the beginning of the calendar or fiscal year through the end of this pay period.',
    `year_to_date_net_pay` DECIMAL(18,2) COMMENT 'Cumulative net pay received by the employee from the beginning of the calendar or fiscal year through the end of this pay period.',
    `year_to_date_state_tax` DECIMAL(18,2) COMMENT 'Cumulative state income tax withheld from the employees pay from the beginning of the calendar or fiscal year through the end of this pay period.',
    CONSTRAINT pk_payslip PRIMARY KEY(`payslip_id`)
) COMMENT 'Individual employee payslip records generated per payroll run capturing gross pay, net pay, itemized earnings (base salary, overtime, bonus, allowances), itemized deductions (tax withholding, benefits, garnishments, 401k), employer contributions, pay period start and end dates, and payment method. Sourced from SAP S/4HANA HR Payroll. Supports employee self-service, payroll audit, and statutory reporting (W-2, P60).';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`workforce_event` (
    `workforce_event_id` BIGINT COMMENT 'Unique identifier for the workforce event record. Primary key for the workforce event entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the first-level approver in the approval chain for this workforce event. Null if approval is not required or not yet reached this level.',
    `alt5_workforce_approval_level_2_employee_id` BIGINT COMMENT 'Identifier of the second-level approver in the approval chain for this workforce event. Null if approval is not required or not yet reached this level.',
    `alt5_workforce_final_approver_employee_id` BIGINT COMMENT 'Identifier of the final approver who authorized this workforce event for execution. Typically a senior leader or HR director for significant actions.',
    `compensation_id` BIGINT COMMENT 'Foreign key linking to workforce.compensation. Business justification: Workforce event (promotion, transfer, compensation change) should reference the NEW compensation record created as a result of the event. This links the event to the compensation record it triggered. ',
    `primary_workforce_employee_id` BIGINT COMMENT 'Identifier of the employee or contractor to whom this event applies. Links to the employee master record.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game studio the employee worked at before this event. Null for hire events. Tracks studio-to-studio transfers in multi-studio organizations.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit the employee belonged to before this event. Null for hire events. Used to track organizational movement history.',
    `position_id` BIGINT COMMENT 'Identifier of the position held by the employee before this event. Null for hire events. Captures the prior state for transfer, promotion, and role change events.',
    `quaternary_workforce_initiating_manager_employee_id` BIGINT COMMENT 'Identifier of the manager who initiated or requested this workforce event. Captures the originator of the HR action for audit and approval tracking.',
    `quinary_workforce_hr_business_partner_employee_id` BIGINT COMMENT 'Identifier of the HR business partner responsible for processing and supporting this workforce event. Links to the HR professional managing the action.',
    `tertiary_workforce_new_manager_employee_id` BIGINT COMMENT 'Identifier of the manager the employee reports to after this event. Null for termination and retirement events. Captures new reporting relationship.',
    `approval_level_1_date` DATE COMMENT 'Date on which the first-level approver approved this workforce event. Null if not yet approved at this level.',
    `approval_level_2_date` DATE COMMENT 'Date on which the second-level approver approved this workforce event. Null if not yet approved at this level.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for compensation amounts. Applies to both previous and new compensation amounts.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this workforce event record was first created in the system. Audit field for record creation tracking.',
    `effective_date` DATE COMMENT 'Date on which the workforce event becomes effective and the employment status change takes effect. This is the business event date for the HR action.',
    `event_status` STRING COMMENT 'Current lifecycle status of the workforce event in the approval and execution workflow.. Valid values are `draft|pending_approval|approved|executed|cancelled|rejected`',
    `event_type` STRING COMMENT 'Type of HR lifecycle event. Categorizes the nature of the employment status change. [ENUM-REF-CANDIDATE: hire|rehire|transfer|promotion|demotion|role_change|studio_transfer|leave_of_absence|return_from_leave|termination_voluntary|termination_involuntary|retirement|contract_extension|contract_renewal — promote to reference product]',
    `final_approval_date` DATE COMMENT 'Date on which the final approver authorized this workforce event. Marks the completion of the approval workflow.',
    `leave_end_date` DATE COMMENT 'Planned or actual date on which the leave of absence ends. Only populated for leave_of_absence and return_from_leave event types.',
    `leave_start_date` DATE COMMENT 'Date on which the leave of absence begins. Only populated for leave_of_absence event types.',
    `leave_type` STRING COMMENT 'Type of leave of absence. Only populated for leave_of_absence event types. Categorizes the nature of the leave for compliance and benefits administration.. Valid values are `medical|parental|sabbatical|military|personal|unpaid`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this workforce event record was last modified. Audit field for tracking changes to the event record during the approval workflow.',
    `new_compensation_amount` DECIMAL(18,2) COMMENT 'Base compensation amount for the employee after this event. Null for termination and retirement events. Captures compensation changes resulting from the HR action.',
    `new_employment_type` STRING COMMENT 'Employment classification assigned to the employee after this event. Null for termination and retirement events. Captures employment type after the HR action.. Valid values are `full_time|part_time|contractor|intern|temporary`',
    `new_job_grade` STRING COMMENT 'Job grade or level assigned to the employee after this event. Null for termination and retirement events. Captures grade changes for promotions and demotions.',
    `new_job_title` STRING COMMENT 'Job title assigned to the employee after this event. Null for termination and retirement events. Captures the new role designation.',
    `notes` STRING COMMENT 'Free-text notes and comments about this workforce event. Captures additional context, special circumstances, or instructions related to the HR action.',
    `previous_compensation_amount` DECIMAL(18,2) COMMENT 'Base compensation amount for the employee before this event. Null for hire events. Used to track compensation changes associated with promotions, demotions, and role changes.',
    `previous_employment_type` STRING COMMENT 'Employment classification held by the employee before this event. Null for hire events. Tracks changes in employment status such as contractor to full-time conversion.. Valid values are `full_time|part_time|contractor|intern|temporary`',
    `previous_job_grade` STRING COMMENT 'Job grade or level held by the employee before this event. Null for hire events. Used to track career progression and compensation band changes.',
    `previous_job_title` STRING COMMENT 'Job title held by the employee before this event. Null for hire events. Provides human-readable context for role changes and promotions.',
    `reason_code` STRING COMMENT 'Standardized code representing the reason for the workforce event. Used for categorization and reporting of HR actions.',
    `reason_description` STRING COMMENT 'Detailed textual description of the reason for the workforce event. Provides additional context beyond the reason code.',
    `rehire_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire after termination. Only populated for termination and retirement events. Used for talent pool management.',
    `rejection_reason` STRING COMMENT 'Textual explanation for why this workforce event was rejected during the approval process. Null if the event was not rejected.',
    `termination_type` STRING COMMENT 'Classification of termination event. Only populated for termination and retirement event types. Distinguishes voluntary resignation from involuntary termination.. Valid values are `voluntary|involuntary|retirement|end_of_contract|mutual_agreement`',
    CONSTRAINT pk_workforce_event PRIMARY KEY(`workforce_event_id`)
) COMMENT 'HR lifecycle event records capturing significant employment status changes for employees and contractors. Event types include hire, rehire, transfer, promotion, demotion, role change, studio transfer, leave of absence, return from leave, termination (voluntary/involuntary), and retirement. Captures event type, effective date, previous state, new state, initiating manager, HR business partner, and approval chain. Sourced from SAP S/4HANA HR Actions (Infotype 0000). Provides full employment history audit trail.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique identifier for the time entry record. Primary key.',
    `absence_record_id` BIGINT COMMENT 'Foreign key linking to workforce.absence_record. Business justification: Time entry for leave/absence should reference the absence record for data consistency. When entry_type is leave/absence, this FK links to the formal absence record. Removing leave_type, absence_start_',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor who approved or rejected the time entry. Supports audit trail and approval workflow tracking.',
    `contractor_id` BIGINT COMMENT 'Foreign key linking to workforce.contractor. Business justification: Time entries track hours worked for billing and project costing. Contractors submit time entries just like employees - they bill hours to projects. The product currently only has primary_time_employee',
    `cost_center_id` BIGINT COMMENT 'Cost center to which the time entry is charged. Supports financial reporting and studio budget allocation tracking.',
    `dev_project_id` BIGINT COMMENT 'Identifier of the game development project or title to which worked time is allocated. Used for project cost tracking and studio capacity planning.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game studio or development location where the employee is assigned. Supports studio-level capacity utilization and headcount reporting.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit or team to which the time entry is attributed. Enables team-level time tracking and capacity analysis.',
    `primary_time_employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who recorded this time entry. Links to workforce employee or contractor records.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Billable time tracking for work-for-hire projects, engine licensing, and shared services requires profit center attribution for revenue recognition and intercompany billing. Gaming studios with multip',
    `activity_type` STRING COMMENT 'Specific type of work activity performed during worked time: development, QA (Quality Assurance), playtesting, live operations, design, art, audio, programming, meetings, training, or administrative tasks. Enables skill-based capacity analysis. [ENUM-REF-CANDIDATE: development|qa|playtesting|live_ops|design|art|audio|programming|meetings|training|admin — 11 candidates stripped; promote to reference product]',
    `approval_status` STRING COMMENT 'Current approval status of the time entry: pending manager review, approved, rejected, submitted awaiting approval, or auto-approved per policy. Critical for time entry workflow and payroll processing.. Valid values are `pending|approved|rejected|submitted|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry was approved or rejected. Part of the approval audit trail.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the time entry is billable to an external client or internal project budget. True for billable time, false for non-billable overhead or administrative time.',
    `billing_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the billing rate (e.g., USD, EUR, GBP). Supports multi-currency project cost tracking.. Valid values are `^[A-Z]{3}$`',
    `billing_rate` DECIMAL(18,2) COMMENT 'Hourly billing rate applied to this time entry for project cost allocation or client invoicing. Confidential financial data used for revenue recognition and project profitability analysis.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this time entry requires special compliance review or tracking (e.g., excessive overtime during crunch, FMLA leave, minor employee hours). True for entries requiring compliance attention.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting compliance-related details, exceptions, or approvals for this time entry. Used for audit documentation and regulatory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was first created in the system. Part of the record lifecycle audit trail.',
    `entry_date` DATE COMMENT 'The calendar date for which time is being recorded. Core business event date for time tracking.',
    `entry_notes` STRING COMMENT 'Free-text notes or comments provided by the employee to describe the work performed, absence reason, or other relevant context. Supports detailed time tracking and audit documentation.',
    `entry_type` STRING COMMENT 'Classification of the time entry: worked time on projects, absence, leave, overtime, training, or meetings. Determines which fields are populated and how time is processed.. Valid values are `worked_time|absence|leave|overtime|training|meeting`',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total hours worked on the entry date. Populated for worked_time and overtime entry types. Used for project cost allocation and capacity utilization tracking.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified the time entry record. Part of the audit trail for data governance and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was last modified. Updated whenever any field in the record changes. Supports change tracking and audit compliance.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Hours worked beyond standard work schedule. Critical for crunch period monitoring and overtime compliance tracking per labor regulations.',
    `payroll_period` STRING COMMENT 'Payroll period identifier to which this time entry is assigned (e.g., 2024-01, 2024-W15). Links time entries to specific payroll cycles for compensation processing.',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether this time entry has been processed in a payroll run. True once included in payroll, false for pending entries. Prevents duplicate payroll processing.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver when rejecting a time entry. Populated only when approval_status is rejected. Supports employee feedback and time entry correction workflow.',
    `return_to_work_date` DATE COMMENT 'Actual date the employee returned to work following an absence or leave. Used to confirm leave closure and update availability for capacity planning.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the employee submitted the time entry for approval. Part of the time entry lifecycle audit trail.',
    `time_zone` STRING COMMENT 'Time zone in which the time entry was recorded (e.g., America/Los_Angeles, Europe/London). Critical for distributed team coordination and accurate time tracking across global studios.',
    `work_location` STRING COMMENT 'Physical or virtual location where the work was performed: office, remote, hybrid, or client site. Supports remote work tracking and location-based compliance reporting.. Valid values are `office|remote|hybrid|client_site`',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Employee and contractor time management records capturing hours worked, project allocations, and all absence/leave periods. For worked time: hours per day, project or title allocation, cost center, activity type (development, QA, playtesting, live ops, meetings, training), overtime hours, and approval status. For absences and leave: leave type (PTO, sick leave, parental leave, FMLA, bereavement, crunch recovery leave), start/end dates, duration, approval status, approver, and return-to-work date. Single source of truth for all employee time and availability data. Supports project cost allocation, studio capacity utilization tracking, overtime compliance monitoring during crunch periods, FMLA/statutory leave compliance, and developer availability for sprint planning. Primary source system: SAP S/4HANA HR Time Management (CATS).';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`disciplinary_case` (
    `disciplinary_case_id` BIGINT COMMENT 'Unique identifier for the disciplinary case record. Primary key.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game studio or organizational unit where the employee was assigned at the time of the incident.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Disciplinary cases cite violated policies (code of conduct, data handling policies, security policies). Required for policy violation tracking, enforcement reporting, and linking HR actions to complia',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who is the subject of the disciplinary case.',
    `quaternary_disciplinary_investigating_officer_employee_id` BIGINT COMMENT 'Identifier of the HR or legal professional conducting the formal investigation of the case.',
    `quinary_disciplinary_manager_employee_id` BIGINT COMMENT 'Identifier of the direct manager of the employee subject to disciplinary action at the time of the incident.',
    `tertiary_disciplinary_hr_business_partner_employee_id` BIGINT COMMENT 'Identifier of the HR business partner assigned to manage and oversee this disciplinary case.',
    `appeal_date` DATE COMMENT 'Date when the employee filed a formal appeal of the disciplinary decision. Null if no appeal was filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the employee filed a formal appeal of the disciplinary outcome. True if appeal was filed.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal process if an appeal was filed. Null if no appeal or appeal still pending.. Valid values are `upheld|overturned|modified|pending`',
    `case_number` STRING COMMENT 'Externally-known unique case reference number assigned by HR system for tracking and audit purposes.. Valid values are `^DC-[0-9]{6,10}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the disciplinary case in the HR workflow.. Valid values are `open|under_investigation|pending_review|resolved|closed|escalated`',
    `case_summary` STRING COMMENT 'Detailed narrative summary of the disciplinary case including facts, context, and circumstances surrounding the incident.',
    `case_type` STRING COMMENT 'Classification of the disciplinary case indicating the nature of the issue being addressed.. Valid values are `performance_improvement_plan|code_of_conduct_violation|harassment_complaint|workplace_safety_incident|termination_for_cause|attendance_violation`',
    `closed_date` DATE COMMENT 'Date when the disciplinary case was formally closed in the HR system after all follow-up actions completed.',
    `confidentiality_level` STRING COMMENT 'Classification of the confidentiality requirements for this case determining access controls and disclosure restrictions.. Valid values are `standard|high|executive|legal`',
    `corrective_action_plan` STRING COMMENT 'Detailed plan outlining specific corrective actions, performance improvement steps, or behavioral expectations required of the employee.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this disciplinary case record was first created in the HR system.',
    `data_retention_expiry_date` DATE COMMENT 'Date when this disciplinary case record is eligible for archival or deletion per data retention policy and regulatory requirements.',
    `eeoc_reportable_flag` BOOLEAN COMMENT 'Indicates whether this case must be reported to EEOC for compliance with federal employment discrimination reporting requirements. True if reportable.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up review or check-in to assess compliance with corrective action plan or monitor behavior.',
    `incident_date` DATE COMMENT 'Date when the underlying incident or behavior that triggered the disciplinary case occurred.',
    `incident_description` STRING COMMENT 'Detailed description of the specific incident or behavior that led to the disciplinary action.',
    `investigation_notes` STRING COMMENT 'Confidential notes and findings from the investigation process. Restricted access for HR and legal personnel only.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this disciplinary case record for audit trail purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this disciplinary case record was last updated or modified in the HR system.',
    `legal_counsel_assigned` STRING COMMENT 'Name or identifier of the legal counsel or law firm assigned to advise on this case if legal involvement is required.',
    `legal_hold_date` DATE COMMENT 'Date when the legal hold was placed on this case record. Null if no legal hold is active.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether this case is subject to legal hold for litigation, regulatory investigation, or legal proceedings. True if under legal hold.',
    `open_date` DATE COMMENT 'Date when the disciplinary case was officially opened and entered into the HR system.',
    `outcome` STRING COMMENT 'Final outcome or disciplinary action taken as a result of the case resolution. [ENUM-REF-CANDIDATE: no_action|verbal_warning|written_warning|final_warning|suspension|demotion|termination|performance_improvement_plan|training_required — 9 candidates stripped; promote to reference product]',
    `outcome_description` STRING COMMENT 'Detailed explanation of the outcome, including specific actions taken, conditions imposed, or remediation steps required.',
    `policy_violated` STRING COMMENT 'Reference to the specific company policy, code of conduct section, or workplace rule that was violated.',
    `prior_case_count` STRING COMMENT 'Number of prior disciplinary cases on record for this employee at the time this case was opened. Used for progressive discipline assessment.',
    `resolution_date` DATE COMMENT 'Date when the disciplinary case was resolved and outcome determined. Null if case is still open.',
    `severity_level` STRING COMMENT 'Classification of the severity of the disciplinary issue based on impact to workplace, team, or company policy.. Valid values are `minor|moderate|major|critical`',
    `witness_employee_ids` STRING COMMENT 'Comma-separated list of employee identifiers who witnessed the incident or provided testimony. Confidential for witness protection.',
    CONSTRAINT pk_disciplinary_case PRIMARY KEY(`disciplinary_case_id`)
) COMMENT 'Employee disciplinary and HR case management records capturing case type (performance improvement plan, code of conduct violation, harassment complaint, workplace safety incident, termination for cause), case status, open date, resolution date, case summary, involved parties, HR business partner, legal hold flag, and outcome. Supports HR compliance, EEOC reporting, and legal risk management. Restricted data classification with role-based access controls.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`project_allocation` (
    `project_allocation_id` BIGINT COMMENT 'Unique identifier for this project allocation record. Primary key for the association.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to the capital expenditure project to which the employee is allocated. References the capex project master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to this capital project. References the employee master record in workforce domain.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the employees time allocated to this capital project during the assignment period. Used to calculate capitalizable labor costs. Sum of all active allocations for an employee should not exceed 100%.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this project allocation: planned (forecasted but not yet started), active (employee currently working on project), completed (allocation period ended), cancelled (allocation removed before completion).',
    `billable_rate` DECIMAL(18,2) COMMENT 'Hourly or daily rate used to calculate the capitalizable labor cost for this employee on this project. May differ from base salary due to overhead allocation, benefits loading, or transfer pricing between studios. Used in asset_under_construction_balance calculations.',
    `capitalization_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this employees work on this project qualifies for capitalization under GAAP/IFRS. Determined by project phase, role type, and accounting rules. Only eligible allocations contribute to asset_under_construction_balance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was created in the system. Used for audit trail and allocation history tracking.',
    `end_date` DATE COMMENT 'Date on which the employees allocation to this capital project ends. Null indicates ongoing allocation. Used to calculate total capitalizable labor costs for the project.',
    `role` STRING COMMENT 'The specific role or function the employee performs on this capital project (e.g., lead_engineer, senior_artist, designer, producer). Used for project reporting, skill mix analysis, and determining capitalization eligibility by role type.',
    `start_date` DATE COMMENT 'Date on which the employees allocation to this capital project begins. Must fall within the projects capitalization_start_date and capitalization_end_date window to qualify for capitalization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was last modified. Used for audit trail and change tracking for capitalization compliance.',
    CONSTRAINT pk_project_allocation PRIMARY KEY(`project_allocation_id`)
) COMMENT 'This association product represents the assignment of employees to capital expenditure projects for game development, engine technology investments, and infrastructure build-outs. It captures the allocation percentage, time period, role, and billable rate for each employee-project assignment. Each record links one employee to one capex_project with attributes that exist only in the context of this assignment relationship. Critical for capitalization accounting under ASC 350-40 and IAS 38, as labor costs must be tracked by project and capitalization phase.. Existence Justification: In gaming studios, employees work on multiple capital projects simultaneously (e.g., a senior engine engineer may allocate 60% to Unreal Engine 5 migration and 40% to a new game title), and capital projects require multiple employees across disciplines (engineering, art, design, production). Studios actively manage these allocations with specific percentages, time periods, roles, and billable rates for GAAP/IFRS capitalization accounting (ASC 350-40, IAS 38). This is a core operational process tracked in project management and financial systems.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` (
    `job_policy_training_requirement_id` BIGINT COMMENT 'Unique identifier for this job profile policy training requirement record. Primary key.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to the job profile subject to this training requirement',
    `policy_id` BIGINT COMMENT 'Foreign key linking to the compliance policy that mandates this training',
    `assigned_by_role` STRING COMMENT 'Role or title of the compliance officer or policy owner who assigned this training requirement to this job profile. Provides accountability for requirement decisions.',
    `assignment_date` DATE COMMENT 'Date when this training requirement was formally assigned to this job profile by the compliance team. Used for audit trail and requirement history tracking.',
    `business_justification` STRING COMMENT 'Narrative explanation of why this specific policy training is required for this specific job profile. Examples: Engineers need data protection training due to access to player PII; Monetization designers need loot box disclosure training due to in-game economy design responsibilities.',
    `certification_required` BOOLEAN COMMENT 'Indicates whether employees in this job profile must obtain formal certification or pass an assessment to demonstrate compliance with this policy. Used for high-risk policies like data protection for engineers or age rating compliance for designers.',
    `last_training_date` DATE COMMENT 'Date when training on this policy was most recently completed by employees in this job profile. Used to calculate next training due date and identify overdue training obligations.',
    `next_training_due_date` DATE COMMENT 'Calculated date when the next training refresh is due for employees in this job profile for this policy. Derived from last_training_date plus training_frequency_months. Drives compliance dashboard alerts.',
    `requirement_effective_date` DATE COMMENT 'Date when this training requirement became active for this job profile and policy combination. Used to grandfather existing employees and apply requirements to new hires.',
    `requirement_status` STRING COMMENT 'Current lifecycle status of this training requirement. Active requirements are enforced in onboarding and recertification workflows. Suspended requirements are temporarily paused. Superseded requirements have been replaced by updated policy versions. Retired requirements are no longer applicable.',
    `training_frequency_months` STRING COMMENT 'Number of months between required training refreshers for this job profile and policy combination. Null if one-time training only. Common values: 12 (annual), 24 (biennial), 6 (semi-annual for high-risk roles).',
    `training_required` BOOLEAN COMMENT 'Indicates whether formal training on this compliance policy is mandatory for employees in this job profile. Drives onboarding checklists and annual recertification workflows.',
    CONSTRAINT pk_job_policy_training_requirement PRIMARY KEY(`job_policy_training_requirement_id`)
) COMMENT 'This association product represents the mandatory compliance training requirements between job profiles and compliance policies. It captures role-specific training obligations, certification requirements, and training schedules that exist only in the context of a specific job profile being subject to a specific compliance policy. Each record links one job profile to one compliance policy with training metadata that belongs to neither entity alone.. Existence Justification: Gaming studios operate under a matrix of compliance obligations where each job profile has role-specific training requirements across multiple policies, and each policy applies to multiple job profiles with varying training intensity. For example, engineers require data protection policy training due to PII access, monetization designers require loot box disclosure policy training due to in-game economy design, and QA testers require age rating compliance training due to content evaluation responsibilities. The compliance team actively manages these training requirements as a distinct operational entity, tracking certification status, training schedules, and recertification cycles for each job-policy combination.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Primary key for benefit_plan',
    `game_studio_id` BIGINT COMMENT 'Reference to the game development studio or business unit offering this benefit plan, supporting studio-specific benefit configurations.',
    `superseded_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (superseded_benefit_plan_id)',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of costs the employee pays after meeting the deductible under this benefit plan.',
    `compliance_framework` STRING COMMENT 'Regulatory or legal framework governing this benefit plan, such as ERISA, ACA, or COBRA.',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are deducted and paid for this benefit plan.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed amount the employee pays for covered services under this benefit plan, typically for medical visits.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Maximum benefit amount or coverage limit provided by this benefit plan, applicable to life insurance and disability plans.',
    `coverage_level` STRING COMMENT 'Scope of coverage indicating who is eligible under the benefit plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this benefit plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this benefit plan.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the employee must pay before the benefit plan coverage begins, applicable to insurance plans.',
    `effective_end_date` DATE COMMENT 'Date when the benefit plan expires or is no longer available for enrollment. Null for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the benefit plan becomes active and available for employee enrollment.',
    `eligibility_criteria` STRING COMMENT 'Textual description of the requirements employees must meet to enroll in this benefit plan.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Standard monetary amount the employee contributes per pay period for this benefit plan.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Standard monetary amount the employer contributes per pay period for this benefit plan.',
    `enrollment_type` STRING COMMENT 'Indicates whether enrollment in this benefit plan is automatic, voluntary, or mandatory for eligible employees.',
    `geographic_scope` STRING COMMENT 'Geographic regions or countries where this benefit plan is available, supporting multi-national workforce management.',
    `is_portable` BOOLEAN COMMENT 'Indicates whether the benefit plan can be continued by the employee after termination of employment.',
    `modified_by` STRING COMMENT 'Identifier of the HR administrator or system user who last modified this benefit plan record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this benefit plan record was last updated in the system.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount the employee will pay out-of-pocket in a plan year before the benefit plan covers 100% of costs.',
    `plan_category` STRING COMMENT 'High-level grouping of the benefit plan for organizational and reporting purposes.',
    `plan_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the benefit plan in HR systems and employee communications.',
    `plan_description` STRING COMMENT 'Detailed textual description of the benefit plan features, coverage, and terms for employee reference.',
    `plan_document_url` STRING COMMENT 'Web address linking to the official benefit plan document, summary plan description, or policy details.',
    `plan_name` STRING COMMENT 'Human-readable name of the benefit plan as displayed to employees and in HR documentation.',
    `plan_type` STRING COMMENT 'Classification of the benefit plan by coverage category.',
    `plan_year_end_date` DATE COMMENT 'End date of the annual benefit plan year for renewal and open enrollment purposes.',
    `plan_year_start_date` DATE COMMENT 'Start date of the annual benefit plan year for renewal and open enrollment purposes.',
    `provider_code` BIGINT COMMENT 'Reference to the external vendor or insurance carrier administering this benefit plan.',
    `provider_name` STRING COMMENT 'Name of the external vendor or insurance carrier administering this benefit plan.',
    `benefit_plan_status` STRING COMMENT 'Current lifecycle state of the benefit plan indicating availability for enrollment and administration.',
    `tax_treatment` STRING COMMENT 'Tax status of employee contributions to this benefit plan for payroll and tax reporting purposes.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Total cost per pay period for this benefit plan, combining employee and employer contributions.',
    `waiting_period_days` STRING COMMENT 'Number of days an employee must wait after hire date before becoming eligible for this benefit plan.',
    `created_by` STRING COMMENT 'Identifier of the HR administrator or system user who created this benefit plan record.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by benefit_plan_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`application` (
    `application_id` BIGINT COMMENT 'Primary key for application',
    `employee_id` BIGINT COMMENT 'Reference to the HR recruiter or talent acquisition specialist assigned to manage and process this application.',
    `hiring_manager_employee_id` BIGINT COMMENT 'Reference to the hiring manager or studio lead responsible for the final hiring decision for this position.',
    `recruitment_requisition_id` BIGINT COMMENT 'Reference to the job requisition or job posting that this application is responding to.',
    `referral_employee_id` BIGINT COMMENT 'Reference to the current employee who referred this candidate, if the application came through an employee referral program.',
    `game_studio_id` BIGINT COMMENT 'Reference to the game development studio or organizational unit where the position is located.',
    `referred_application_id` BIGINT COMMENT 'Self-referencing FK on application (referred_application_id)',
    `application_number` STRING COMMENT 'Human-readable unique application reference number assigned to each job application for tracking and communication purposes.',
    `application_status` STRING COMMENT 'Current lifecycle status of the job application in the recruitment workflow. [ENUM-REF-CANDIDATE: submitted|under_review|screening|interview_scheduled|interviewed|assessment|technical_test|offer_extended|offer_accepted|offer_declined|rejected|withdrawn|on_hold — promote to reference product]',
    `application_type` STRING COMMENT 'Classification of the application based on the source and nature of the candidate (external new hire, internal transfer, employee referral, returning employee, or contractor-to-employee conversion).',
    `assessment_completed` BOOLEAN COMMENT 'Indicates whether the candidate has completed required technical assessments, skill tests, or portfolio reviews for this application.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score from technical assessments, coding challenges, design exercises, or portfolio evaluations, typically on a 0-100 scale.',
    `background_check_date` DATE COMMENT 'Date when the background check process was completed.',
    `background_check_status` STRING COMMENT 'Status of the pre-employment background verification process (not initiated, in progress, completed with clear results, completed with concerns, or failed).',
    `candidate_id` BIGINT COMMENT 'Reference to the candidate who submitted this application.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this application record was first created in the system.',
    `disability_status` BOOLEAN COMMENT 'Indicates whether the candidate self-identified as having a disability, tracked for compliance and accommodation planning.',
    `discipline` STRING COMMENT 'The functional discipline or department category for the position (engineering, design, art, animation, audio, quality assurance, production, marketing, business operations, human resources, finance, legal). [ENUM-REF-CANDIDATE: engineering|design|art|animation|audio|qa|production|marketing|business|hr|finance|legal|it|operations — promote to reference product]',
    `diversity_hire_flag` BOOLEAN COMMENT 'Indicates whether this application is part of a diversity and inclusion hiring initiative or program.',
    `employment_type` STRING COMMENT 'The nature of the employment relationship for the position (full-time permanent, part-time, fixed-term contract, temporary, internship).',
    `interview_count` STRING COMMENT 'Total number of interview rounds or sessions conducted with the candidate for this application.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this application record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this application record was most recently updated or modified.',
    `notes` STRING COMMENT 'Free-text notes and comments from recruiters, hiring managers, or interviewers regarding the candidate and application progress.',
    `offer_accepted_date` DATE COMMENT 'Date when the candidate formally accepted the job offer.',
    `offer_extended_date` DATE COMMENT 'Date when a formal job offer was extended to the candidate.',
    `offer_response_deadline` DATE COMMENT 'Date by which the candidate must accept or decline the job offer.',
    `position_title` STRING COMMENT 'The job title or role name for the position being applied for (e.g., Senior Game Designer, Lead Programmer, 3D Artist, QA Tester).',
    `proposed_start_date` DATE COMMENT 'Anticipated or agreed-upon date when the candidate would begin employment if hired.',
    `referral_bonus_eligible` BOOLEAN COMMENT 'Indicates whether the referring employee is eligible for a referral bonus if this candidate is hired and meets retention criteria.',
    `rejection_reason` STRING COMMENT 'Explanation or category code for why the application was rejected (e.g., insufficient experience, skills mismatch, position filled, candidate withdrew, failed assessment).',
    `remote_work_eligibility` STRING COMMENT 'Indicates whether the position allows remote work arrangements (on-site only, hybrid with partial remote, or fully remote).',
    `screening_score` DECIMAL(18,2) COMMENT 'Numerical score assigned during initial resume screening or automated applicant tracking system (ATS) evaluation, typically on a 0-100 scale.',
    `seniority_level` STRING COMMENT 'The experience level or career stage for the position (intern, junior, mid-level, senior, lead, principal, director). [ENUM-REF-CANDIDATE: intern|junior|mid|senior|lead|principal|director|executive — promote to reference product]',
    `source_channel` STRING COMMENT 'The channel or platform through which the candidate discovered and applied for the position (company career site, external job board, LinkedIn, employee referral, university campus recruitment, staffing agency, or direct outreach). [ENUM-REF-CANDIDATE: career_site|job_board|linkedin|glassdoor|indeed|referral|campus_recruitment|agency|direct_application|social_media — promote to reference product]',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the candidate submitted the application through the recruitment system or portal.',
    `veteran_status` BOOLEAN COMMENT 'Indicates whether the candidate self-identified as a military veteran, tracked for compliance and diversity reporting.',
    `withdrawal_reason` STRING COMMENT 'Explanation provided by the candidate for withdrawing their application (e.g., accepted another offer, compensation expectations, relocation concerns, timing).',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Master reference table for application. Referenced by application_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`course` (
    `course_id` BIGINT COMMENT 'Primary key for course',
    `prerequisite_course_id` BIGINT COMMENT 'Self-referencing FK on course (prerequisite_course_id)',
    `assessment_type` STRING COMMENT 'The method used to evaluate learner comprehension and mastery of course material.',
    `certification_name` STRING COMMENT 'The official name of the certification or credential awarded upon course completion, if applicable.',
    `certification_offered` BOOLEAN COMMENT 'Indicates whether successful completion of the course results in a formal certification or credential.',
    `compliance_framework` STRING COMMENT 'Name of the regulatory framework, standard, or policy that the course addresses (e.g., GDPR, IGDA workforce standards, anti-harassment training).',
    `compliance_required` BOOLEAN COMMENT 'Indicates whether the course is mandatory for compliance with regulatory, legal, or organizational policy requirements.',
    `content_owner` STRING COMMENT 'Name or identifier of the individual or team responsible for maintaining and updating the course content.',
    `cost_per_learner` DECIMAL(18,2) COMMENT 'The monetary cost incurred per individual learner enrolled in the course, including materials and instructor fees.',
    `course_code` STRING COMMENT 'Externally-known unique alphanumeric code for the course, used in catalogs and registration systems.',
    `course_type` STRING COMMENT 'Categorical classification of the course based on its primary focus area (e.g., technical skills, leadership development, compliance training).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the course record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which course costs are denominated.',
    `delivery_mode` STRING COMMENT 'The method by which the course is delivered to learners (e.g., in-person classroom, virtual instructor-led, self-paced online).',
    `course_description` STRING COMMENT 'Detailed narrative describing the course content, objectives, and learning outcomes.',
    `difficulty_level` STRING COMMENT 'The skill level or complexity rating of the course content, used to match courses to learner proficiency.',
    `duration_hours` DECIMAL(18,2) COMMENT 'The total instructional time required to complete the course, measured in hours.',
    `effective_end_date` DATE COMMENT 'The date after which the course is no longer available for new enrollments, if applicable.',
    `effective_start_date` DATE COMMENT 'The date from which the course becomes available for enrollment and delivery.',
    `enrollment_open` BOOLEAN COMMENT 'Indicates whether the course is currently accepting new enrollments.',
    `instructor_email` STRING COMMENT 'Email address of the primary instructor for learner inquiries and course coordination.',
    `instructor_name` STRING COMMENT 'Name of the primary instructor or facilitator responsible for delivering the course, if applicable.',
    `language` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language in which the course is delivered.',
    `last_review_date` DATE COMMENT 'The date when the course content was last reviewed and validated for accuracy and relevance.',
    `learning_objectives` STRING COMMENT 'Specific, measurable outcomes that learners are expected to achieve upon successful completion of the course.',
    `materials_url` STRING COMMENT 'Web address or file path where course materials, resources, and supplementary content are stored and accessible.',
    `max_enrollment` STRING COMMENT 'The maximum number of participants that can be enrolled in a single offering of the course.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified the course record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the course record was last updated or modified.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next content review and update cycle.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'The minimum percentage score required on assessments for a learner to successfully complete the course.',
    `prerequisites` STRING COMMENT 'Description of required prior knowledge, skills, or completed courses that learners must have before enrolling.',
    `recertification_period_months` STRING COMMENT 'The number of months after which learners must retake or renew the course to maintain certification or compliance status.',
    `skill_tags` STRING COMMENT 'Comma-separated list of skills, competencies, or technologies covered by the course, used for skill matrix mapping and talent development planning.',
    `course_status` STRING COMMENT 'Current lifecycle status of the course indicating its availability and operational state.',
    `studio_applicable` STRING COMMENT 'Comma-separated list of studio names or identifiers for which this course is relevant, supporting studio-specific capacity planning.',
    `target_audience` STRING COMMENT 'Description of the intended learner population, including roles, departments, or skill levels for whom the course is designed.',
    `title` STRING COMMENT 'The official name or title of the course as displayed to employees and in training catalogs.',
    `vendor_name` STRING COMMENT 'Name of the external training provider or vendor supplying the course content, if not developed internally.',
    `version` STRING COMMENT 'Version number of the course content, incremented with each major or minor update.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the course record.',
    CONSTRAINT pk_course PRIMARY KEY(`course_id`)
) COMMENT 'Master reference table for course. Referenced by course_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`payroll_calendar` (
    `payroll_calendar_id` BIGINT COMMENT 'Primary key for payroll_calendar',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this payroll calendar record.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this payroll calendar record.',
    `game_studio_id` BIGINT COMMENT 'Reference to the game development studio or business unit that uses this payroll calendar for workforce management.',
    `previous_payroll_calendar_id` BIGINT COMMENT 'Self-referencing FK on payroll_calendar (previous_payroll_calendar_id)',
    `approval_deadline_days` STRING COMMENT 'Number of days before pay date that all time entries and payroll adjustments must be approved by managers.',
    `calendar_code` STRING COMMENT 'Business identifier code for the payroll calendar, used for external reference and integration with SAP S/4HANA HR module.',
    `calendar_name` STRING COMMENT 'Human-readable name of the payroll calendar (e.g., US Biweekly Salaried, UK Monthly Contractors).',
    `calendar_type` STRING COMMENT 'Classification of the payroll calendar frequency determining pay period intervals.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the jurisdiction for this payroll calendar.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll calendar record was first created in the system.',
    `crunch_period_override_allowed` BOOLEAN COMMENT 'Indicates whether this calendar permits temporary schedule overrides during game development crunch periods.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for payroll disbursements under this calendar.',
    `payroll_calendar_description` STRING COMMENT 'Detailed description of the payroll calendar purpose, coverage, and any special processing rules.',
    `effective_end_date` DATE COMMENT 'Date when this payroll calendar ceases to be active. Null for open-ended calendars.',
    `effective_start_date` DATE COMMENT 'Date when this payroll calendar becomes active and begins governing pay period calculations.',
    `employee_group` STRING COMMENT 'Classification of employee population covered by this calendar (e.g., Full-Time Developers, Contractors, QA Testers, Esports Athletes).',
    `first_pay_period_start_date` DATE COMMENT 'Start date of the first pay period in this calendar, used as the anchor for calculating all subsequent periods.',
    `holiday_calendar_code` BIGINT COMMENT 'Reference to the holiday calendar used to adjust pay dates when they fall on non-working days.',
    `igda_compliance_flag` BOOLEAN COMMENT 'Indicates whether this payroll calendar adheres to IGDA workforce standards for game development labor practices.',
    `is_default_calendar` BOOLEAN COMMENT 'Indicates whether this is the default payroll calendar for the associated studio or employee group.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll calendar record was last modified.',
    `notes` STRING COMMENT 'Additional notes or comments regarding calendar configuration, historical changes, or special considerations.',
    `pay_date_adjustment_rule` STRING COMMENT 'Rule for adjusting pay dates when they fall on holidays or weekends.',
    `pay_day_of_week` STRING COMMENT 'Standard day of the week on which payroll is disbursed (e.g., friday for weekly payrolls).',
    `pay_day_offset_days` STRING COMMENT 'Number of days after the pay period end date that payment is issued to employees.',
    `pay_frequency_per_year` STRING COMMENT 'Number of pay periods in a standard calendar year (e.g., 52 for weekly, 26 for biweekly, 24 for semi-monthly, 12 for monthly).',
    `payroll_area` STRING COMMENT 'SAP payroll area code grouping employees with the same payroll processing characteristics and schedule.',
    `region_code` STRING COMMENT 'Regional or state/province code for jurisdictions with sub-national payroll regulations (e.g., CA for California, ON for Ontario).',
    `sap_payroll_control_record` STRING COMMENT 'SAP-specific control record identifier linking this calendar to SAP S/4HANA HR payroll processing configuration.',
    `payroll_calendar_status` STRING COMMENT 'Current lifecycle status of the payroll calendar indicating whether it is in use for payroll processing.',
    `supports_off_cycle_payments` BOOLEAN COMMENT 'Indicates whether this calendar allows for off-cycle or ad-hoc payroll runs outside the standard schedule.',
    `tax_year_start_month` STRING COMMENT 'Month number (1-12) when the tax year begins for this jurisdiction, used for year-to-date calculations.',
    `time_entry_cutoff_days` STRING COMMENT 'Number of days before pay period end that time entry submissions must be completed for payroll processing.',
    `version_number` STRING COMMENT 'Version number of this payroll calendar configuration, incremented with each modification for audit trail.',
    CONSTRAINT pk_payroll_calendar PRIMARY KEY(`payroll_calendar_id`)
) COMMENT 'Master reference table for payroll_calendar. Referenced by payroll_calendar_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`workforce`.`review_cycle` (
    `review_cycle_id` BIGINT COMMENT 'Primary key for review_cycle',
    `approved_by_user_employee_id` BIGINT COMMENT 'Reference to the senior HR leader or executive who approved the launch of this review cycle.',
    `employee_id` BIGINT COMMENT 'Reference to the HR administrator or system user who created this review cycle configuration.',
    `previous_review_cycle_id` BIGINT COMMENT 'Self-referencing FK on review_cycle (previous_review_cycle_id)',
    `approval_date` DATE COMMENT 'The date when this review cycle was officially approved for launch by senior HR leadership.',
    `calibration_end_date` DATE COMMENT 'The date by which all calibration sessions must be completed and final ratings approved by senior leadership.',
    `calibration_start_date` DATE COMMENT 'The date when leadership calibration sessions begin to normalize performance ratings across teams and ensure fairness and consistency.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this review cycle was officially closed and all reviews finalized. Null if the cycle is still active or in progress.',
    `communication_plan` STRING COMMENT 'Summary of the communication strategy for this review cycle, including key messages, channels, and stakeholder engagement approach.',
    `compensation_review_linked` BOOLEAN COMMENT 'Indicates whether this review cycle is directly linked to compensation decisions (salary increases, bonuses, equity grants). True means performance ratings will influence compensation outcomes; false means this is a developmental review only.',
    `compliance_framework` STRING COMMENT 'Identifies the regulatory or industry compliance frameworks this review cycle must adhere to (e.g., IGDA Workforce Standards, GDPR, Local Labor Law). Used for audit trail and legal compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this review cycle record was first created in the system.',
    `cycle_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the review cycle for system integration and reporting (e.g., RC_2024_Q4, MYR_2024).',
    `cycle_name` STRING COMMENT 'Business-friendly name for the review cycle (e.g., Q4 2024 Annual Review, Mid-Year 2024 Check-In).',
    `cycle_status` STRING COMMENT 'Current lifecycle state of the review cycle. Draft indicates planning phase; scheduled means dates are set but cycle has not started; active means employees can submit self-assessments; in_progress means reviews are being conducted; review_phase means manager reviews are underway; calibration means leadership is normalizing ratings; closed means cycle is complete; cancelled means cycle was terminated before completion.',
    `cycle_type` STRING COMMENT 'Classification of the review cycle based on frequency and purpose. Annual reviews are comprehensive year-end evaluations; mid-year reviews are interim check-ins; quarterly reviews support agile development teams; probationary reviews assess new hires; project-based reviews evaluate performance on specific game titles; ad-hoc reviews address special circumstances.',
    `review_cycle_description` STRING COMMENT 'Detailed description of the review cycle purpose, scope, and any special instructions or focus areas for this cycle (e.g., Annual review focusing on leadership competencies and game development technical skills).',
    `eligible_employee_count` STRING COMMENT 'The total number of employees eligible to participate in this review cycle at the time of cycle creation. Excludes employees on leave, contractors, and ineligible employment types.',
    `employment_type_scope` STRING COMMENT 'Pipe-separated list of employment types included in this review cycle (e.g., full_time|part_time|contractor). Defines which employee categories are eligible for review. [ENUM-REF-CANDIDATE: full_time|part_time|contractor|temporary|intern|seasonal|freelance — promote to reference product]',
    `end_date` DATE COMMENT 'The date when the review cycle officially closes and all reviews must be finalized. After this date, no further submissions or edits are permitted.',
    `feedback_delivery_due_date` DATE COMMENT 'The deadline by which all managers must complete feedback delivery sessions with their direct reports. Required for cycle closure.',
    `feedback_delivery_start_date` DATE COMMENT 'The date when managers can begin scheduling and conducting one-on-one feedback sessions with employees to discuss review results.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter associated with this review cycle (Q1, Q2, Q3, Q4). Relevant for quarterly and mid-year review cycles.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this review cycle belongs (e.g., 2024, 2025). Used for multi-year trend analysis and compensation planning alignment.',
    `forced_distribution_enabled` BOOLEAN COMMENT 'Indicates whether forced ranking or distribution curves are applied during calibration. True means a percentage of employees must be rated in each performance tier; false means ratings are not constrained by distribution requirements.',
    `goal_setting_enabled` BOOLEAN COMMENT 'Indicates whether goal-setting functionality is enabled for this review cycle. True means employees and managers can set performance goals; false means this cycle focuses only on retrospective evaluation.',
    `job_level_scope` STRING COMMENT 'Defines which job levels or career bands are included in this review cycle (e.g., individual_contributor, manager, senior_leader). Used to segment review processes by organizational hierarchy.',
    `manager_review_due_date` DATE COMMENT 'The deadline by which managers must complete all performance reviews for their direct reports. Required for calibration session scheduling.',
    `manager_review_start_date` DATE COMMENT 'The date when managers can begin conducting performance reviews and providing ratings for their direct reports.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this review cycle record was last modified. Updated whenever any cycle configuration changes are made.',
    `peer_feedback_enabled` BOOLEAN COMMENT 'Indicates whether peer feedback collection is enabled for this review cycle. True means employees can nominate peers and receive 360-degree feedback; false means reviews are manager-only.',
    `promotion_eligible` BOOLEAN COMMENT 'Indicates whether employees can be nominated for promotion during this review cycle. True means promotion recommendations are accepted; false means this cycle does not include promotion decisions.',
    `rating_scale_type` STRING COMMENT 'The performance rating scale used for this review cycle. Five-point scales typically range from Does Not Meet to Exceptional; four-point scales eliminate the middle option; three-point scales use Below/Meets/Exceeds; narrative-only cycles do not use numeric ratings; meets-expectations scales use binary pass/fail assessment.',
    `review_template_code` BIGINT COMMENT 'Reference to the review form template used for this cycle, defining the questions, competencies, and rating criteria employees and managers will use.',
    `self_assessment_due_date` DATE COMMENT 'The deadline by which employees must complete and submit their self-assessment forms. Late submissions may require manager approval.',
    `self_assessment_start_date` DATE COMMENT 'The date when employees can begin submitting their self-assessment forms for this review cycle.',
    `start_date` DATE COMMENT 'The date when the review cycle officially begins and employees can start self-assessments and goal-setting activities.',
    `studio_scope` STRING COMMENT 'Defines the organizational scope of the review cycle. Global cycles apply to all studios and locations; regional cycles target specific geographic regions; studio-specific cycles apply to individual game development studios; project-team cycles focus on specific game title development teams.',
    `target_participation_rate` DECIMAL(18,2) COMMENT 'The target percentage of eligible employees who should complete the review cycle (e.g., 95.00 means 95% participation target). Used for compliance tracking and HR analytics.',
    `training_required` BOOLEAN COMMENT 'Indicates whether managers and employees must complete training before participating in this review cycle. True means training completion is tracked and enforced; false means training is optional or not required.',
    `upward_feedback_enabled` BOOLEAN COMMENT 'Indicates whether upward feedback (employee feedback on managers) is enabled for this review cycle. True means direct reports can provide anonymous feedback on their managers; false means no upward feedback is collected.',
    CONSTRAINT pk_review_cycle PRIMARY KEY(`review_cycle_id`)
) COMMENT 'Master reference table for review_cycle. Referenced by review_cycle_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `gaming_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `gaming_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ADD CONSTRAINT `fk_workforce_contractor_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `gaming_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ADD CONSTRAINT `fk_workforce_contractor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ADD CONSTRAINT `fk_workforce_contractor_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `gaming_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ADD CONSTRAINT `fk_workforce_contractor_position_id` FOREIGN KEY (`position_id`) REFERENCES `gaming_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `gaming_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `gaming_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `gaming_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `gaming_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_reports_to_job_profile_id` FOREIGN KEY (`reports_to_job_profile_id`) REFERENCES `gaming_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ADD CONSTRAINT `fk_workforce_skill_matrix_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `gaming_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ADD CONSTRAINT `fk_workforce_skill_matrix_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `gaming_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_compensation_employee_id` FOREIGN KEY (`compensation_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_previous_compensation_id` FOREIGN KEY (`previous_compensation_id`) REFERENCES `gaming_ecm`.`workforce`.`compensation`(`compensation_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `gaming_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `gaming_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_review_cycle_id` FOREIGN KEY (`review_cycle_id`) REFERENCES `gaming_ecm`.`workforce`.`review_cycle`(`review_cycle_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `gaming_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_course_id` FOREIGN KEY (`course_id`) REFERENCES `gaming_ecm`.`workforce`.`course`(`course_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_primary_absence_employee_id` FOREIGN KEY (`primary_absence_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `gaming_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `gaming_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `gaming_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_tertiary_recruitment_approved_by_employee_id` FOREIGN KEY (`tertiary_recruitment_approved_by_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_application_id` FOREIGN KEY (`application_id`) REFERENCES `gaming_ecm`.`workforce`.`application`(`application_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_candidate_recruiter_employee_id` FOREIGN KEY (`candidate_recruiter_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_candidate_referrer_employee_id` FOREIGN KEY (`candidate_referrer_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `gaming_ecm`.`workforce`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ADD CONSTRAINT `fk_workforce_studio_capacity_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `gaming_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ADD CONSTRAINT `fk_workforce_studio_capacity_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_payroll_calendar_id` FOREIGN KEY (`payroll_calendar_id`) REFERENCES `gaming_ecm`.`workforce`.`payroll_calendar`(`payroll_calendar_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_reversal_run_payroll_run_id` FOREIGN KEY (`reversal_run_payroll_run_id`) REFERENCES `gaming_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_compensation_id` FOREIGN KEY (`compensation_id`) REFERENCES `gaming_ecm`.`workforce`.`compensation`(`compensation_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `gaming_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ADD CONSTRAINT `fk_workforce_workforce_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ADD CONSTRAINT `fk_workforce_workforce_event_alt5_workforce_approval_level_2_employee_id` FOREIGN KEY (`alt5_workforce_approval_level_2_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ADD CONSTRAINT `fk_workforce_workforce_event_alt5_workforce_final_approver_employee_id` FOREIGN KEY (`alt5_workforce_final_approver_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ADD CONSTRAINT `fk_workforce_workforce_event_compensation_id` FOREIGN KEY (`compensation_id`) REFERENCES `gaming_ecm`.`workforce`.`compensation`(`compensation_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ADD CONSTRAINT `fk_workforce_workforce_event_primary_workforce_employee_id` FOREIGN KEY (`primary_workforce_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ADD CONSTRAINT `fk_workforce_workforce_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `gaming_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ADD CONSTRAINT `fk_workforce_workforce_event_position_id` FOREIGN KEY (`position_id`) REFERENCES `gaming_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ADD CONSTRAINT `fk_workforce_workforce_event_quaternary_workforce_initiating_manager_employee_id` FOREIGN KEY (`quaternary_workforce_initiating_manager_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ADD CONSTRAINT `fk_workforce_workforce_event_quinary_workforce_hr_business_partner_employee_id` FOREIGN KEY (`quinary_workforce_hr_business_partner_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ADD CONSTRAINT `fk_workforce_workforce_event_tertiary_workforce_new_manager_employee_id` FOREIGN KEY (`tertiary_workforce_new_manager_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_absence_record_id` FOREIGN KEY (`absence_record_id`) REFERENCES `gaming_ecm`.`workforce`.`absence_record`(`absence_record_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `gaming_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `gaming_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_primary_time_employee_id` FOREIGN KEY (`primary_time_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ADD CONSTRAINT `fk_workforce_disciplinary_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ADD CONSTRAINT `fk_workforce_disciplinary_case_quaternary_disciplinary_investigating_officer_employee_id` FOREIGN KEY (`quaternary_disciplinary_investigating_officer_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ADD CONSTRAINT `fk_workforce_disciplinary_case_quinary_disciplinary_manager_employee_id` FOREIGN KEY (`quinary_disciplinary_manager_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ADD CONSTRAINT `fk_workforce_disciplinary_case_tertiary_disciplinary_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_disciplinary_hr_business_partner_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ADD CONSTRAINT `fk_workforce_project_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ADD CONSTRAINT `fk_workforce_job_policy_training_requirement_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `gaming_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `gaming_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`application` ADD CONSTRAINT `fk_workforce_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`application` ADD CONSTRAINT `fk_workforce_application_hiring_manager_employee_id` FOREIGN KEY (`hiring_manager_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`application` ADD CONSTRAINT `fk_workforce_application_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `gaming_ecm`.`workforce`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`application` ADD CONSTRAINT `fk_workforce_application_referral_employee_id` FOREIGN KEY (`referral_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`application` ADD CONSTRAINT `fk_workforce_application_referred_application_id` FOREIGN KEY (`referred_application_id`) REFERENCES `gaming_ecm`.`workforce`.`application`(`application_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`course` ADD CONSTRAINT `fk_workforce_course_prerequisite_course_id` FOREIGN KEY (`prerequisite_course_id`) REFERENCES `gaming_ecm`.`workforce`.`course`(`course_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_calendar` ADD CONSTRAINT `fk_workforce_payroll_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_calendar` ADD CONSTRAINT `fk_workforce_payroll_calendar_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_calendar` ADD CONSTRAINT `fk_workforce_payroll_calendar_previous_payroll_calendar_id` FOREIGN KEY (`previous_payroll_calendar_id`) REFERENCES `gaming_ecm`.`workforce`.`payroll_calendar`(`payroll_calendar_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `gaming_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `gaming_ecm`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_previous_review_cycle_id` FOREIGN KEY (`previous_review_cycle_id`) REFERENCES `gaming_ecm`.`workforce`.`review_cycle`(`review_cycle_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `gaming_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Annual Salary Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `annual_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade Level');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|terminated|retired|deceased');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|intern|temporary');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Date');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Hire Date');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `igda_member` SET TAGS ('dbx_business_glossary_term' = 'International Game Developers Association (IGDA) Member Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `is_remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligibility Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location Name');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `primary_skill` SET TAGS ('dbx_business_glossary_term' = 'Primary Skill Area');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `skill_tags` SET TAGS ('dbx_business_glossary_term' = 'Employee Skill Tags');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Termination Date');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `work_location` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Expiration Date');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|work_visa|pending|not_required');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`employee` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Professional Experience');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|failed|expired');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `benefits_eligible` SET TAGS ('dbx_business_glossary_term' = 'Benefits Eligible');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|standard|elevated|full_access');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `contracting_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Contracting Agency Name');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `contractor_number` SET TAGS ('dbx_business_glossary_term' = 'Contractor Number');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `contractor_number` SET TAGS ('dbx_value_regex' = '^CTR-[0-9]{8}$');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `contractor_status` SET TAGS ('dbx_business_glossary_term' = 'Contractor Status');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `contractor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_onboarding|contract_expired|terminated');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Rate');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `daily_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contractor Email Address');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `engagement_type` SET TAGS ('dbx_value_regex' = 'freelance|agency_contractor|statement_of_work|independent_consultant|temporary_worker|project_based');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `equipment_issued` SET TAGS ('dbx_business_glossary_term' = 'Equipment Issued');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Full Name');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `nda_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Signed Date');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `onboarding_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completed Date');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'not_rated|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contractor Phone Number');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `remote_work_location` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Location');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `skill_specialization` SET TAGS ('dbx_business_glossary_term' = 'Skill Specialization');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `statement_of_work_reference` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Reference');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `system_access_provisioned` SET TAGS ('dbx_business_glossary_term' = 'System Access Provisioned');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `tax_classification` SET TAGS ('dbx_value_regex' = '1099_us|w2_us|ir35_inside_uk|ir35_outside_uk|international_exempt|vat_registered');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `time_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Time Tracking Required');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `work_country_code` SET TAGS ('dbx_business_glossary_term' = 'Work Country Code');
ALTER TABLE `gaming_ecm`.`workforce`.`contractor` ALTER COLUMN `work_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `current_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `development_methodology` SET TAGS ('dbx_business_glossary_term' = 'Development Methodology');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `development_methodology` SET TAGS ('dbx_value_regex' = 'agile|scrum|kanban|waterfall|hybrid');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_budget` SET TAGS ('dbx_business_glossary_term' = 'Headcount Budget');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_remote_first` SET TAGS ('dbx_business_glossary_term' = 'Is Remote First');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Location Country Code');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `primary_game_engine` SET TAGS ('dbx_business_glossary_term' = 'Primary Game Engine');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `primary_game_engine` SET TAGS ('dbx_value_regex' = 'unity|unreal|proprietary|other');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `sprint_length_weeks` SET TAGS ('dbx_business_glossary_term' = 'Sprint Length (Weeks)');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|dissolved|restructuring');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `gaming_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'studio|department|team|squad|pod|division');
ALTER TABLE `gaming_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position ID');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `education_requirement` SET TAGS ('dbx_business_glossary_term' = 'Education Requirement');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|intern');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `is_bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `is_contractor_eligible` SET TAGS ('dbx_business_glossary_term' = 'Contractor Eligible');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `is_equity_eligible` SET TAGS ('dbx_business_glossary_term' = 'Equity Eligible');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `is_remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `job_grade` SET TAGS ('dbx_business_glossary_term' = 'Job Grade');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `job_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `min_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|filled|frozen|eliminated|pending_approval');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `salary_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `skill_profile` SET TAGS ('dbx_business_glossary_term' = 'Skill Profile');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `gaming_ecm`.`workforce`.`position` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `reports_to_job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Job Profile Identifier (ID)');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `career_level` SET TAGS ('dbx_business_glossary_term' = 'Career Level');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `career_track` SET TAGS ('dbx_business_glossary_term' = 'Career Track');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `career_track` SET TAGS ('dbx_value_regex' = 'individual_contributor|management|executive');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `core_competencies` SET TAGS ('dbx_business_glossary_term' = 'Core Competencies');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `igda_discipline_classification` SET TAGS ('dbx_business_glossary_term' = 'International Game Developers Association (IGDA) Discipline Classification');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|deprecated');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_sub_family` SET TAGS ('dbx_business_glossary_term' = 'Job Sub-Family');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `key_responsibilities` SET TAGS ('dbx_business_glossary_term' = 'Key Responsibilities');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|phd|none');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `minimum_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_band` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Band');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_band` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `physical_requirements` SET TAGS ('dbx_business_glossary_term' = 'Physical Requirements');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `preferred_certifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Certifications');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `preferred_education_level` SET TAGS ('dbx_business_glossary_term' = 'Preferred Education Level');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `preferred_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|phd|none');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `preferred_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Preferred Years of Experience');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `remote_work_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligibility');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `remote_work_eligibility` SET TAGS ('dbx_value_regex' = 'on_site|hybrid|fully_remote|location_dependent');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `security_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `span_of_control_max` SET TAGS ('dbx_business_glossary_term' = 'Span of Control Maximum');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `span_of_control_min` SET TAGS ('dbx_business_glossary_term' = 'Span of Control Minimum');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `technical_skills` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `gaming_ecm`.`workforce`.`job_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `skill_matrix_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Matrix ID');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `certification_provider` SET TAGS ('dbx_business_glossary_term' = 'Certification Provider');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending_renewal|revoked');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `ceu_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Unit (CEU) Credits');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|not_started|failed|withdrawn');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `compliance_training_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `endorsement_count` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Count');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `learning_program_name` SET TAGS ('dbx_business_glossary_term' = 'Learning Program Name');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `learning_provider` SET TAGS ('dbx_business_glossary_term' = 'Learning Provider');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `learning_type` SET TAGS ('dbx_business_glossary_term' = 'Learning Type');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `learning_type` SET TAGS ('dbx_value_regex' = 'mandatory_compliance|voluntary_development|onboarding|upskilling|reskilling');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `manager_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Manager Assessment Score');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `next_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Date');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Status');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_value_regex' = 'beginner|intermediate|advanced|expert|master');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `self_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Self-Assessment Score');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `skill_category` SET TAGS ('dbx_business_glossary_term' = 'Skill Category');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `skill_category` SET TAGS ('dbx_value_regex' = 'game_engine|programming_language|art_discipline|qa_methodology|platform_sdk|design_discipline');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `skill_gap_flag` SET TAGS ('dbx_business_glossary_term' = 'Skill Gap Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `skill_name` SET TAGS ('dbx_business_glossary_term' = 'Skill Name');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `skill_priority` SET TAGS ('dbx_business_glossary_term' = 'Skill Priority');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `skill_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `skill_status` SET TAGS ('dbx_business_glossary_term' = 'Skill Status');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `skill_status` SET TAGS ('dbx_value_regex' = 'active|dormant|deprecated|target');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `target_proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Target Proficiency Level');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `target_proficiency_level` SET TAGS ('dbx_value_regex' = 'beginner|intermediate|advanced|expert|master');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `training_cost` SET TAGS ('dbx_business_glossary_term' = 'Training Cost');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `training_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`skill_matrix` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan ID');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Development Project ID');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte_art` SET TAGS ('dbx_business_glossary_term' = 'Approved Full-Time Equivalent (FTE) Art');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte_design` SET TAGS ('dbx_business_glossary_term' = 'Approved Full-Time Equivalent (FTE) Design');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte_engineering` SET TAGS ('dbx_business_glossary_term' = 'Approved Full-Time Equivalent (FTE) Engineering');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte_other` SET TAGS ('dbx_business_glossary_term' = 'Approved Full-Time Equivalent (FTE) Other Disciplines');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte_production` SET TAGS ('dbx_business_glossary_term' = 'Approved Full-Time Equivalent (FTE) Production');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte_qa` SET TAGS ('dbx_business_glossary_term' = 'Approved Full-Time Equivalent (FTE) Quality Assurance (QA)');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte_total` SET TAGS ('dbx_business_glossary_term' = 'Approved Full-Time Equivalent (FTE) Total');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `capacity_gap_fte` SET TAGS ('dbx_business_glossary_term' = 'Capacity Gap Full-Time Equivalent (FTE)');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `contractor_fte_actual` SET TAGS ('dbx_business_glossary_term' = 'Contractor Full-Time Equivalent (FTE) Actual');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `contractor_fte_budget` SET TAGS ('dbx_business_glossary_term' = 'Contractor Full-Time Equivalent (FTE) Budget');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `current_filled_fte_art` SET TAGS ('dbx_business_glossary_term' = 'Current Filled Full-Time Equivalent (FTE) Art');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `current_filled_fte_design` SET TAGS ('dbx_business_glossary_term' = 'Current Filled Full-Time Equivalent (FTE) Design');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `current_filled_fte_engineering` SET TAGS ('dbx_business_glossary_term' = 'Current Filled Full-Time Equivalent (FTE) Engineering');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `current_filled_fte_other` SET TAGS ('dbx_business_glossary_term' = 'Current Filled Full-Time Equivalent (FTE) Other Disciplines');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `current_filled_fte_production` SET TAGS ('dbx_business_glossary_term' = 'Current Filled Full-Time Equivalent (FTE) Production');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `current_filled_fte_qa` SET TAGS ('dbx_business_glossary_term' = 'Current Filled Full-Time Equivalent (FTE) Quality Assurance (QA)');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `current_filled_fte_total` SET TAGS ('dbx_business_glossary_term' = 'Current Filled Full-Time Equivalent (FTE) Total');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `open_requisition_count_art` SET TAGS ('dbx_business_glossary_term' = 'Open Requisition Count Art');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `open_requisition_count_design` SET TAGS ('dbx_business_glossary_term' = 'Open Requisition Count Design');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `open_requisition_count_engineering` SET TAGS ('dbx_business_glossary_term' = 'Open Requisition Count Engineering');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `open_requisition_count_other` SET TAGS ('dbx_business_glossary_term' = 'Open Requisition Count Other Disciplines');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `open_requisition_count_production` SET TAGS ('dbx_business_glossary_term' = 'Open Requisition Count Production');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `open_requisition_count_qa` SET TAGS ('dbx_business_glossary_term' = 'Open Requisition Count Quality Assurance (QA)');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `open_requisition_count_total` SET TAGS ('dbx_business_glossary_term' = 'Open Requisition Count Total');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Name');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Status');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|locked|archived');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Version');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Type');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_value_regex' = 'sprint|milestone|quarter|fiscal_year|annual');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `gaming_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `utilization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Percentage');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` SET TAGS ('dbx_subdomain' = 'payroll_operations');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation ID');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Manager ID');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `previous_compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Compensation ID');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `previous_compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `previous_compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowance Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Allowance Type');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'housing|transportation|relocation|remote_work|education|none');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|active|superseded');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `bonus_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `bonus_target_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Percentage');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'base_salary|bonus|equity_grant|commission|allowance|overtime');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_quantity` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Quantity');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_quantity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_type` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Type');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_type` SET TAGS ('dbx_value_regex' = 'stock_option|rsu|restricted_stock|performance_share|none');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_vesting_schedule` SET TAGS ('dbx_business_glossary_term' = 'Equity Vesting Schedule');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_vesting_schedule` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `market_benchmark_percentile` SET TAGS ('dbx_business_glossary_term' = 'Market Benchmark Percentile');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `market_benchmark_percentile` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_equity_band` SET TAGS ('dbx_business_glossary_term' = 'Pay Equity Band');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_equity_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi_weekly|weekly|semi_monthly|annual');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Compensation Review Cycle');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|ad_hoc|promotion|market_adjustment');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `total_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Compensation Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`compensation` ALTER COLUMN `total_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'payroll_operations');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Election Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|not_required');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_designation` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_designation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Relationship');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_eligible_indicator` SET TAGS ('dbx_business_glossary_term' = 'COBRA (Consolidated Omnibus Budget Reconciliation Act) Eligible Indicator');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_end_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA (Consolidated Omnibus Budget Reconciliation Act) End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_start_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA (Consolidated Omnibus Budget Reconciliation Act) Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_election_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contribution Election Percentage');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_match_percentage` SET TAGS ('dbx_business_glossary_term' = 'Employer Match Percentage');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^BEN-[0-9]{8}$');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_period_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period Type');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_period_type` SET TAGS ('dbx_value_regex' = 'open_enrollment|new_hire|qualifying_life_event|special_enrollment');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'employee_self_service|hr_admin|benefits_portal|paper_form|call_center|auto_enrollment');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|waived|terminated|suspended|cancelled');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Year End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Date');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Type');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `vesting_schedule` SET TAGS ('dbx_business_glossary_term' = 'Vesting Schedule');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_indicator` SET TAGS ('dbx_business_glossary_term' = 'Waiver Indicator');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'employee_development');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Development Project ID');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle ID');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_committee_notes` SET TAGS ('dbx_business_glossary_term' = 'Calibration Committee Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_committee_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_calibrated|pending_calibration|calibrated|calibration_adjusted');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `collaboration_rating` SET TAGS ('dbx_business_glossary_term' = 'Collaboration and Teamwork Rating');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `collaboration_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `collaboration_score` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Score');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recommended Compensation Increase Percentage');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_increase_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_increase_recommended` SET TAGS ('dbx_business_glossary_term' = 'Compensation Increase Recommended Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_increase_recommended` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_increase_recommended` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Required Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_signature` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Signature');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_signature` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Percentage');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `goals_met_count` SET TAGS ('dbx_business_glossary_term' = 'Goals Met Count');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `goals_total_count` SET TAGS ('dbx_business_glossary_term' = 'Total Goals Count');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `innovation_rating` SET TAGS ('dbx_business_glossary_term' = 'Innovation and Creativity Rating');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `innovation_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `innovation_score` SET TAGS ('dbx_business_glossary_term' = 'Innovation Score');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Rating');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding|not_applicable');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_score` SET TAGS ('dbx_business_glossary_term' = 'Leadership Score');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Promotion Readiness Level');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_readiness_level` SET TAGS ('dbx_value_regex' = 'ready_now|ready_1_year|ready_2_years|not_ready|not_applicable');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommended Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Review Approval Date');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Review Submission Date');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probation|project_end|promotion|pip');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `technical_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Competency Rating');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `technical_competency_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `gaming_ecm`.`workforce`.`performance_review` ALTER COLUMN `technical_competency_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Competency Score');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` SET TAGS ('dbx_subdomain' = 'employee_development');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `learning_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Enrollment ID');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course ID');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `attendance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attendance Percentage');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `certification_earned` SET TAGS ('dbx_business_glossary_term' = 'Certification Earned');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `ceu_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Unit (CEU) Credits');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'pass|fail|incomplete|in_progress|not_started');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Course Name');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'online|in_person|hybrid|self_paced|instructor_led|virtual_classroom');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Learning Discipline');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|in_progress|completed|withdrawn|failed|expired');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'self_enrolled|manager_assigned|hr_assigned|system_assigned');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `feedback_rating` SET TAGS ('dbx_business_glossary_term' = 'Feedback Rating');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'company_funded|employee_funded|shared|grant|scholarship');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `learning_provider` SET TAGS ('dbx_business_glossary_term' = 'Learning Provider');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `gaming_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` SET TAGS ('dbx_subdomain' = 'employee_development');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Record ID');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `primary_absence_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `primary_absence_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `primary_absence_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `sprint_id` SET TAGS ('dbx_business_glossary_term' = 'Sprint ID');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_reason` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_status` SET TAGS ('dbx_business_glossary_term' = 'Absence Status');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|completed');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_type_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Type Code');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_type_code` SET TAGS ('dbx_value_regex' = 'PTO|SICK|PARENTAL|FMLA|BEREAVEMENT|CRUNCH_RECOVERY');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `accrual_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Accrual Balance After Absence');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `accrual_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Accrual Balance Before Absence');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Approval Date');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `business_days_count` SET TAGS ('dbx_business_glossary_term' = 'Business Days Count');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Absence Duration in Days');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Absence End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `impact_on_sprint` SET TAGS ('dbx_business_glossary_term' = 'Impact on Sprint');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `impact_on_sprint` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `is_fmla_qualified` SET TAGS ('dbx_business_glossary_term' = 'Is FMLA (Family and Medical Leave Act) Qualified');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Is Paid Leave');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `is_statutory_leave` SET TAGS ('dbx_business_glossary_term' = 'Is Statutory Leave');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_received` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Received');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_received` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_received` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Required');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Absence Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Request Date');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `gaming_ecm`.`workforce`.`absence_record` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition ID');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `diversity_hiring_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversity Hiring Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `education_level_required` SET TAGS ('dbx_business_glossary_term' = 'Education Level Required');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern|seasonal');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `headcount_type` SET TAGS ('dbx_business_glossary_term' = 'Headcount Type');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `headcount_type` SET TAGS ('dbx_value_regex' = 'new_position|backfill|replacement|expansion');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `is_relocation_offered` SET TAGS ('dbx_business_glossary_term' = 'Is Relocation Offered');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `is_remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Remote Eligible');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `is_visa_sponsorship_available` SET TAGS ('dbx_business_glossary_term' = 'Is Visa Sponsorship Available');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Location Country Code');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `min_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years Experience');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `number_of_openings` SET TAGS ('dbx_business_glossary_term' = 'Number of Openings');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `position_level` SET TAGS ('dbx_business_glossary_term' = 'Position Level');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `position_title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `preferred_skills` SET TAGS ('dbx_business_glossary_term' = 'Preferred Skills');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `required_skills` SET TAGS ('dbx_business_glossary_term' = 'Required Skills');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `sourcing_channels` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channels');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `total_candidates_applied` SET TAGS ('dbx_business_glossary_term' = 'Total Candidates Applied');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `total_candidates_interviewed` SET TAGS ('dbx_business_glossary_term' = 'Total Candidates Interviewed');
ALTER TABLE `gaming_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `total_offers_extended` SET TAGS ('dbx_business_glossary_term' = 'Total Offers Extended');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `application_id` SET TAGS ('dbx_value_regex' = '^APP-[0-9]{8}$');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_referrer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referrer Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_referrer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_referrer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Target Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|cleared|flagged|failed');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `current_employer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `current_job_title` SET TAGS ('dbx_business_glossary_term' = 'Current Job Title');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Candidate Discipline');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `earliest_start_date` SET TAGS ('dbx_business_glossary_term' = 'Earliest Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Candidate Email Address');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Salary Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Expected Salary Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate First Name');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Date');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `interview_count` SET TAGS ('dbx_business_glossary_term' = 'Interview Count');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `is_remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Remote Eligible');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `last_interview_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interview Date');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Last Name');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Candidate Location City');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Candidate Location Country Code');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Candidate Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_extended_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Candidate Rating');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `overall_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Candidate Phone Number');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `portfolio_url` SET TAGS ('dbx_business_glossary_term' = 'Candidate Portfolio Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `portfolio_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `preferred_game_engine` SET TAGS ('dbx_business_glossary_term' = 'Preferred Game Engine');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `preferred_game_engine` SET TAGS ('dbx_value_regex' = 'unity|unreal|proprietary|godot|other');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `primary_skill` SET TAGS ('dbx_business_glossary_term' = 'Primary Skill');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `requires_visa_sponsorship` SET TAGS ('dbx_business_glossary_term' = 'Requires Visa Sponsorship');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `secondary_skills` SET TAGS ('dbx_business_glossary_term' = 'Secondary Skills');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Candidate Source Channel');
ALTER TABLE `gaming_ecm`.`workforce`.`candidate` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `studio_capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Capacity Plan ID');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Development Project ID');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Development Milestone ID');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `allocated_fte` SET TAGS ('dbx_business_glossary_term' = 'Allocated Full-Time Equivalent (FTE)');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_requested');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `available_fte` SET TAGS ('dbx_business_glossary_term' = 'Available Full-Time Equivalent (FTE)');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `capacity_gap_fte` SET TAGS ('dbx_business_glossary_term' = 'Capacity Gap Full-Time Equivalent (FTE)');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `contractor_count` SET TAGS ('dbx_business_glossary_term' = 'Contractor Supplement Count');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `contractor_fte` SET TAGS ('dbx_business_glossary_term' = 'Contractor Full-Time Equivalent (FTE)');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `demand_fte` SET TAGS ('dbx_business_glossary_term' = 'Demand Full-Time Equivalent (FTE)');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `development_methodology` SET TAGS ('dbx_business_glossary_term' = 'Development Methodology');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `development_methodology` SET TAGS ('dbx_value_regex' = 'agile|scrum|kanban|waterfall|hybrid');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Development Discipline');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `game_engine` SET TAGS ('dbx_business_glossary_term' = 'Game Engine Technology');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `game_engine` SET TAGS ('dbx_value_regex' = 'unity|unreal|proprietary|other');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `is_baseline` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Plan');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Studio Location City');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Studio Location Country Code');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `onsite_fte` SET TAGS ('dbx_business_glossary_term' = 'Onsite Full-Time Equivalent (FTE)');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Code');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Name');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Status');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|closed|cancelled');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Type');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_value_regex' = 'sprint|milestone|quarter|month|year|custom');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `remote_fte` SET TAGS ('dbx_business_glossary_term' = 'Remote Full-Time Equivalent (FTE)');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `seniority_band` SET TAGS ('dbx_business_glossary_term' = 'Seniority Band');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `seniority_band` SET TAGS ('dbx_value_regex' = 'junior|mid|senior|lead|principal|director');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `sprint_number` SET TAGS ('dbx_business_glossary_term' = 'Sprint Number');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `utilization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Percentage');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `gaming_ecm`.`workforce`.`studio_capacity_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'payroll_operations');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Calendar ID');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `reversal_run_payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Payroll Run ID');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `check_date` SET TAGS ('dbx_business_glossary_term' = 'Check Date');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `gl_document_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Document Number');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_group_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Group Code');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payment_method_summary` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Summary');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_area` SET TAGS ('dbx_business_glossary_term' = 'Payroll Area');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_name` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Name');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `posted_by` SET TAGS ('dbx_business_glossary_term' = 'Posted By');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `processing_notes` SET TAGS ('dbx_business_glossary_term' = 'Processing Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Execution Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Number');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'draft|in-progress|completed|posted|cancelled|failed');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Type');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regular|off-cycle|bonus|correction|final|advance');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employee_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Employee Deductions');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employees_processed` SET TAGS ('dbx_business_glossary_term' = 'Total Employees Processed');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_contributions` SET TAGS ('dbx_business_glossary_term' = 'Total Employer Contributions');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Pay');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Net Pay');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Withheld');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `warning_count` SET TAGS ('dbx_business_glossary_term' = 'Warning Count');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_run` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` SET TAGS ('dbx_subdomain' = 'payroll_operations');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_id` SET TAGS ('dbx_business_glossary_term' = 'Payslip ID');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `allowances_total` SET TAGS ('dbx_business_glossary_term' = 'Allowances Total');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `allowances_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last Four Digits');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `base_salary` SET TAGS ('dbx_business_glossary_term' = 'Base Salary');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `dental_insurance_deduction` SET TAGS ('dbx_business_glossary_term' = 'Dental Insurance Deduction');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `dental_insurance_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_401k_match` SET TAGS ('dbx_business_glossary_term' = 'Employer 401(k) Match');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_401k_match` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_health_insurance_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Health Insurance Contribution');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_health_insurance_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_medicare_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Medicare Contribution');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_medicare_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_social_security_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Social Security Contribution');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_social_security_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `federal_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Withheld');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `federal_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `garnishment_deduction` SET TAGS ('dbx_business_glossary_term' = 'Garnishment Deduction');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `garnishment_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Generated Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `health_insurance_deduction` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Deduction');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `health_insurance_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `local_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Local Tax Withheld');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `local_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `medicare_tax` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `medicare_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay` SET TAGS ('dbx_business_glossary_term' = 'Net Pay');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `other_deductions_total` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions Total');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `other_deductions_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `overtime_pay` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `overtime_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|cash|wire_transfer');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_number` SET TAGS ('dbx_business_glossary_term' = 'Payslip Number');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_status` SET TAGS ('dbx_business_glossary_term' = 'Payslip Status');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_status` SET TAGS ('dbx_value_regex' = 'draft|approved|paid|voided|corrected');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `retirement_401k_deduction` SET TAGS ('dbx_business_glossary_term' = 'Retirement 401(k) Deduction');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `retirement_401k_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `social_security_tax` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `social_security_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `state_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'State Tax Withheld');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `state_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `total_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `vision_insurance_deduction` SET TAGS ('dbx_business_glossary_term' = 'Vision Insurance Deduction');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `vision_insurance_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_401k_contribution` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) 401(k) Contribution');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_401k_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_federal_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Federal Tax');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_federal_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Pay');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Net Pay');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_net_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_state_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) State Tax');
ALTER TABLE `gaming_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_state_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` SET TAGS ('dbx_subdomain' = 'employee_development');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `workforce_event_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Event ID');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Level 1 Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `alt5_workforce_approval_level_2_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Level 2 Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `alt5_workforce_approval_level_2_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `alt5_workforce_approval_level_2_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `alt5_workforce_final_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Final Approver Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `alt5_workforce_final_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `alt5_workforce_final_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `compensation_id` SET TAGS ('dbx_business_glossary_term' = 'New Compensation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `primary_workforce_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `primary_workforce_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `primary_workforce_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Organizational Unit ID');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Position ID');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `quaternary_workforce_initiating_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Manager Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `quaternary_workforce_initiating_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `quaternary_workforce_initiating_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `quinary_workforce_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `quinary_workforce_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `quinary_workforce_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `tertiary_workforce_new_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'New Manager Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `tertiary_workforce_new_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `tertiary_workforce_new_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `approval_level_1_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Level 1 Date');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `approval_level_2_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Level 2 Date');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|executed|cancelled|rejected');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `leave_end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `leave_start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'medical|parental|sabbatical|military|personal|unpaid');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `new_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'New Compensation Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `new_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `new_employment_type` SET TAGS ('dbx_business_glossary_term' = 'New Employment Type');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `new_employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|intern|temporary');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `new_job_grade` SET TAGS ('dbx_business_glossary_term' = 'New Job Grade');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `new_job_title` SET TAGS ('dbx_business_glossary_term' = 'New Job Title');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `previous_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Compensation Amount');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `previous_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `previous_employment_type` SET TAGS ('dbx_business_glossary_term' = 'Previous Employment Type');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `previous_employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|intern|temporary');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `previous_job_grade` SET TAGS ('dbx_business_glossary_term' = 'Previous Job Grade');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `previous_job_title` SET TAGS ('dbx_business_glossary_term' = 'Previous Job Title');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Description');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `gaming_ecm`.`workforce`.`workforce_event` ALTER COLUMN `termination_type` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|retirement|end_of_contract|mutual_agreement');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'employee_development');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `absence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Record Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Development Project ID');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|submitted|auto_approved');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `billing_rate` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `billing_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Date');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_notes` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Type');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'worked_time|absence|leave|overtime|training|meeting');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_period` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `gaming_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_location` SET TAGS ('dbx_value_regex' = 'office|remote|hybrid|client_site');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` SET TAGS ('dbx_subdomain' = 'employee_development');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `disciplinary_case_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Case ID');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `quaternary_disciplinary_investigating_officer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigating Officer Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `quaternary_disciplinary_investigating_officer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `quaternary_disciplinary_investigating_officer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `quinary_disciplinary_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `quinary_disciplinary_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `quinary_disciplinary_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner Employee ID');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|pending');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^DC-[0-9]{6,10}$');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_review|resolved|closed|escalated');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `case_summary` SET TAGS ('dbx_business_glossary_term' = 'Case Summary');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `case_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'performance_improvement_plan|code_of_conduct_violation|harassment_complaint|workplace_safety_incident|termination_for_cause|attendance_violation');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Date');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|high|executive|legal');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `eeoc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity Commission (EEOC) Reportable Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `incident_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Assigned');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `legal_hold_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Date');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `legal_hold_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Case Open Date');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Case Outcome');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `outcome` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Outcome Description');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `outcome_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `policy_violated` SET TAGS ('dbx_business_glossary_term' = 'Policy Violated');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `prior_case_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Case Count');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `witness_employee_ids` SET TAGS ('dbx_business_glossary_term' = 'Witness Employee IDs');
ALTER TABLE `gaming_ecm`.`workforce`.`disciplinary_case` ALTER COLUMN `witness_employee_ids` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` SET TAGS ('dbx_association_edges' = 'workforce.employee,finance.capex_project');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `project_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Allocation ID');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Allocation - Capex Project Id');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Allocation - Employee Id');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `billable_rate` SET TAGS ('dbx_business_glossary_term' = 'Billable Rate');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `capitalization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligible Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Project Role');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `gaming_ecm`.`workforce`.`project_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` SET TAGS ('dbx_association_edges' = 'workforce.job_profile,compliance.compliance_policy');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `job_policy_training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Job Policy Training Requirement ID');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Policy Training Requirement - Job Profile Id');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Job Policy Training Requirement - Compliance Policy Id');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `assigned_by_role` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Role');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `next_training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Training Due Date');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `requirement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Effective Date');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `training_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency in Months');
ALTER TABLE `gaming_ecm`.`workforce`.`job_policy_training_requirement` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'payroll_operations');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `gaming_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`application` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`application` SET TAGS ('dbx_subdomain' = 'employee_development');
ALTER TABLE `gaming_ecm`.`workforce`.`application` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier');
ALTER TABLE `gaming_ecm`.`workforce`.`application` ALTER COLUMN `referred_application_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`application` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`course` SET TAGS ('dbx_subdomain' = 'employee_development');
ALTER TABLE `gaming_ecm`.`workforce`.`course` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier');
ALTER TABLE `gaming_ecm`.`workforce`.`course` ALTER COLUMN `prerequisite_course_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`course` ALTER COLUMN `cost_per_learner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`course` ALTER COLUMN `instructor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`course` ALTER COLUMN `instructor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_calendar` SET TAGS ('dbx_subdomain' = 'payroll_operations');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_calendar` ALTER COLUMN `payroll_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Calendar Identifier');
ALTER TABLE `gaming_ecm`.`workforce`.`payroll_calendar` ALTER COLUMN `previous_payroll_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`workforce`.`review_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`workforce`.`review_cycle` SET TAGS ('dbx_subdomain' = 'employee_development');
ALTER TABLE `gaming_ecm`.`workforce`.`review_cycle` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Identifier');
ALTER TABLE `gaming_ecm`.`workforce`.`review_cycle` ALTER COLUMN `previous_review_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
