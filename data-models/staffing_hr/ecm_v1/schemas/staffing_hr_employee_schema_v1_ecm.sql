-- Schema for Domain: employee | Business: Staffing Hr | Version: v1_ecm
-- Generated on: 2026-05-02 15:53:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `staffing_hr_ecm`.`employee` COMMENT 'Owns internal employee (recruiter, account manager, operations staff) identity, role, team structure, compensation, and performance data. Distinct from candidate (external talent supply) and placement (worker assignments)';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`staff_profile` (
    `staff_profile_id` BIGINT COMMENT 'Unique identifier for the internal employee staff profile record. Primary key for the staff_profile product.',
    `job_title_id` BIGINT COMMENT 'FK to employee.job_title',
    `manager_staff_profile_id` BIGINT COMMENT 'Self-referencing FK on staff_profile (manager_staff_profile_id)',
    `address_line1` STRING COMMENT 'Primary street address line of the employees home residence.',
    `address_line2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number of the employees home residence.',
    `city` STRING COMMENT 'City of the employees home residence.',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the employees home residence.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this staff profile record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Employees date of birth used for benefits eligibility, age verification, and compliance reporting.',
    `disability_status` STRING COMMENT 'Employees self-identified disability status for OFCCP Section 503 reporting and reasonable accommodation purposes.. Valid values are `Yes|No|Prefer Not to Disclose`',
    `eeo_job_category` STRING COMMENT 'EEO-1 job category classification for federal compliance reporting. [ENUM-REF-CANDIDATE: Executive/Senior Level Officials and Managers|First/Mid-Level Officials and Managers|Professionals|Technicians|Sales Workers|Administrative Support Workers|Craft Workers|Operatives|Laborers and Helpers|Service Workers — promote to reference product]',
    `emergency_contact_name` STRING COMMENT 'Full name of the person to contact in case of employee emergency.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact person.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee.. Valid values are `Spouse|Parent|Sibling|Child|Friend|Other`',
    `employee_number` STRING COMMENT 'Unique business identifier assigned to the employee by the organization. Used for payroll, HR systems, and operational identification.. Valid values are `^[A-Z0-9]{6,12}$`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee within the organization.. Valid values are `Active|On Leave|Terminated|Suspended`',
    `employment_type` STRING COMMENT 'Classification of the employees work arrangement based on hours and commitment level.. Valid values are `Full-Time|Part-Time|Contract|Temporary|Intern`',
    `flsa_classification` STRING COMMENT 'Classification determining whether the employee is exempt or non-exempt from overtime pay requirements under FLSA.. Valid values are `Exempt|Non-Exempt`',
    `gender` STRING COMMENT 'Employees self-identified gender for EEOC reporting and diversity analytics.. Valid values are `Male|Female|Non-Binary|Prefer Not to Disclose`',
    `hire_date` DATE COMMENT 'Date the employee was originally hired or most recently rehired by the organization.',
    `i9_verification_date` DATE COMMENT 'Date the employees I-9 employment eligibility verification was completed.',
    `i9_work_authorization_status` STRING COMMENT 'Employees work authorization status as verified through I-9 employment eligibility verification process.. Valid values are `US Citizen|Permanent Resident|Work Visa|Pending Verification`',
    `legal_first_name` STRING COMMENT 'Employees legal first name as it appears on government-issued identification and tax documents.',
    `legal_last_name` STRING COMMENT 'Employees legal last name (surname) as it appears on government-issued identification and tax documents.',
    `legal_middle_name` STRING COMMENT 'Employees legal middle name or initial as it appears on government-issued identification.',
    `mobile_phone` STRING COMMENT 'Employees mobile phone number for business and emergency contact purposes.',
    `original_hire_date` DATE COMMENT 'Date of the employees very first hire with the organization, used for seniority and tenure calculations when rehire_flag is true.',
    `pay_frequency` STRING COMMENT 'Frequency at which the employee is paid, indicating the pay period structure.. Valid values are `Hourly|Weekly|Bi-Weekly|Semi-Monthly|Monthly|Annual`',
    `pay_rate` DECIMAL(18,2) COMMENT 'Employees current compensation rate, expressed as hourly wage or annual salary depending on employment type.',
    `personal_email` STRING COMMENT 'Employees personal email address used for non-work communications and emergency contact purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the employees home residence.',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in day-to-day business interactions, which may differ from legal name.',
    `rehire_flag` BOOLEAN COMMENT 'Indicates whether the employee is a rehire (previously employed and returned) or a new hire.',
    `ssn_masked` STRING COMMENT 'Masked Social Security Number showing only the last four digits for identification purposes while protecting full SSN.. Valid values are `^XXX-XX-d{4}$`',
    `state_province` STRING COMMENT 'State or province of the employees home residence, used for tax withholding and compliance.',
    `termination_date` DATE COMMENT 'Date the employees employment ended or will end. Null for active employees.',
    `termination_reason` STRING COMMENT 'Primary reason for the employees termination or separation from the organization.. Valid values are `Voluntary Resignation|Involuntary Termination|Retirement|Layoff|End of Contract|Other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this staff profile record was last modified.',
    `veteran_status` STRING COMMENT 'Employees veteran status for OFCCP VETS-4212 reporting and affirmative action compliance.',
    `work_email` STRING COMMENT 'Corporate email address assigned to the employee for business communications and system access.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_phone` STRING COMMENT 'Business phone number assigned to the employee, including desk phone or direct line.',
    CONSTRAINT pk_staff_profile PRIMARY KEY(`staff_profile_id`)
) COMMENT 'SSOT master record for every internal employee at Staffing Hr — recruiters, account managers, sourcing specialists, operations staff, and corporate personnel. Captures core identity: legal name, preferred name, employee number, personal email, work email, work phone, mobile phone, date of birth, gender, SSN (masked), home address, emergency contact name, emergency contact phone, hire date, rehire flag, termination date, employment status (active, on leave, terminated), employment type (full-time, part-time, contract), FLSA classification, EEO job category, veteran status, disability status, and I-9 work authorization status. This is the authoritative identity record for all internal workforce — distinct from candidate.profile (external talent supply) and placement.assignment (worker deployments).';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`job_title` (
    `job_title_id` BIGINT COMMENT 'Unique identifier for the job title record. Primary key for the job title reference master.',
    `parent_job_title_id` BIGINT COMMENT 'Self-referencing FK on job_title (parent_job_title_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job title record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for salary amounts. Supports multi-currency compensation for international operations.. Valid values are `^[A-Z]{3}$`',
    `eeo1_category` STRING COMMENT 'Standard EEO-1 job category code used for federal compliance reporting to the Equal Employment Opportunity Commission. Required for annual EEO-1 Component 1 filings. [ENUM-REF-CANDIDATE: Executive/Senior Level Officials and Managers|First/Mid-Level Officials and Managers|Professionals|Technicians|Sales Workers|Administrative Support Workers|Craft Workers|Operatives|Laborers and Helpers|Service Workers — 10 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date when this job title became or will become active and available for use in the organization. Supports time-based job architecture changes and organizational restructuring.',
    `end_date` DATE COMMENT 'Date when this job title was or will be retired from active use. Null for currently active titles. Used for historical reporting and compliance with record retention requirements.',
    `flsa_status` STRING COMMENT 'Classification under the Fair Labor Standards Act determining eligibility for overtime pay. Exempt positions are salaried and not eligible for overtime; non-exempt positions are eligible for overtime compensation.. Valid values are `Exempt|Non-Exempt`',
    `is_billable_facing` BOOLEAN COMMENT 'Flag indicating whether this job title represents a billable-facing role that directly generates revenue through client interactions (e.g., recruiters, account managers) versus internal support roles (e.g., finance, IT, HR).',
    `is_executive` BOOLEAN COMMENT 'Flag indicating whether this job title is classified as an executive-level position (C-suite, VP, or equivalent) with strategic decision-making authority and enterprise-wide scope.',
    `is_management` BOOLEAN COMMENT 'Flag indicating whether this job title includes direct people management responsibilities and supervisory authority over other employees.',
    `job_family` STRING COMMENT 'Broad functional category grouping related job titles together. Used for workforce planning, career pathing, and compensation benchmarking. [ENUM-REF-CANDIDATE: Recruiting|Account Management|Operations|Finance|IT|Human Resources|Legal|Marketing|Sales|Executive — 10 candidates stripped; promote to reference product]',
    `job_level` STRING COMMENT 'Hierarchical level of the position within the organizational structure. Determines reporting relationships, span of control, and decision-making authority. [ENUM-REF-CANDIDATE: Individual Contributor|Team Lead|Manager|Senior Manager|Director|Senior Director|Vice President|Senior Vice President|C-Suite — 9 candidates stripped; promote to reference product]',
    `job_title_description` STRING COMMENT 'Detailed narrative description of the job title including key responsibilities, scope of authority, and primary objectives. Used for job postings, performance management, and organizational communication.',
    `job_title_status` STRING COMMENT 'Current lifecycle status of the job title. Active titles are available for use in hiring and assignments; inactive titles are retained for historical reporting but not available for new hires; deprecated titles are being phased out.. Valid values are `Active|Inactive|Deprecated|Pending Approval`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this job title record was most recently updated. Used for change tracking and data quality monitoring.',
    `max_salary` DECIMAL(18,2) COMMENT 'Maximum annual base salary for the job title within the assigned pay grade. Represents the top of the compensation range for this position.',
    `midpoint_salary` DECIMAL(18,2) COMMENT 'Target or midpoint annual base salary for the job title. Represents the competitive market rate for fully competent performance in the role.',
    `min_education_level` STRING COMMENT 'Minimum educational attainment required for the job title. Used for candidate screening, job posting requirements, and workforce planning.. Valid values are `High School|Associate Degree|Bachelor Degree|Master Degree|Doctoral Degree|Professional Degree`',
    `min_salary` DECIMAL(18,2) COMMENT 'Minimum annual base salary for the job title within the assigned pay grade. Used for offer generation, pay equity analysis, and compensation planning.',
    `min_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for the job title. Used for candidate qualification and career progression planning.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to the job title. Defines the salary range, bonus eligibility, and benefits tier for positions within this title.. Valid values are `^[A-Z0-9]{1,6}$`',
    `requires_license` BOOLEAN COMMENT 'Flag indicating whether this job title requires a professional license or certification to perform the role (e.g., CPA for accounting roles, PHR/SPHR for senior HR roles).',
    `short_name` STRING COMMENT 'Abbreviated or shortened version of the job title used in reports, dashboards, and system displays where space is limited.',
    `soc_code` STRING COMMENT 'Six-digit O*NET Standard Occupational Classification code mapping the job title to federal occupational taxonomy. Used for labor market analysis, benchmarking, and compliance with Office of Federal Contract Compliance Programs (OFCCP) requirements.. Valid values are `^[0-9]{2}-[0-9]{4}$`',
    `title_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the job title across all systems. Used as the business key for integration with HRIS, payroll, and performance management systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `title_name` STRING COMMENT 'Full official name of the job title as it appears in employment contracts, offer letters, and organizational charts.',
    CONSTRAINT pk_job_title PRIMARY KEY(`job_title_id`)
) COMMENT 'Reference master defining all internal job titles and position classifications used across Staffing Hr. Captures title name, title code, job family (e.g., Recruiting, Account Management, Operations, Finance, IT), job level (individual contributor, team lead, manager, director, VP, C-suite), FLSA exemption status, EEO-1 job category code, O*NET SOC code, pay grade band, and whether the title is billable-facing or internal. Used to standardize job title taxonomy across HRIS, payroll, and performance systems.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`department` (
    `department_id` BIGINT COMMENT 'Unique identifier for the department. Primary key.',
    `office_location_id` BIGINT COMMENT 'Reference to the primary physical office location where this department is based. Used for facilities management and workforce planning.',
    `parent_department_id` BIGINT COMMENT 'Reference to the parent department in the organizational hierarchy. Null for top-level departments. Enables org chart traversal and roll-up reporting.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal employee who serves as the department head or manager. Used for approval workflows and organizational accountability.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual operating budget allocated to this department in USD. Used for financial planning, variance analysis, and cost control.',
    `compliance_tier` STRING COMMENT 'Level of regulatory compliance oversight required for this department. Critical tier applies to Legal, Compliance, and Finance departments with heightened audit and control requirements.. Valid values are `Standard|Enhanced|Critical`',
    `cost_center_code` STRING COMMENT 'General Ledger cost center code used for financial accounting and expense allocation. Links department to finance.cost_center for budget tracking and P&L reporting.. Valid values are `^[0-9]{4,8}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this department record was first created in the system. Used for audit trails and data lineage.',
    `department_code` STRING COMMENT 'Short alphanumeric code used as the business identifier for the department in operational systems and reporting. Typically 2-10 characters.. Valid values are `^[A-Z0-9]{2,10}$`',
    `department_description` STRING COMMENT 'Detailed description of the departments mission, responsibilities, and scope of work. Used for organizational documentation and onboarding materials.',
    `department_name` STRING COMMENT 'Full official name of the department as recognized in organizational charts and HR systems.',
    `department_status` STRING COMMENT 'Current lifecycle status of the department. Active departments are operational and can have employees assigned. Inactive departments are closed but retained for historical reporting.. Valid values are `Active|Inactive|Pending Closure|Merged`',
    `department_type` STRING COMMENT 'Classification of the department by its primary business function. Used for cost allocation models and organizational analysis.. Valid values are `Revenue Generating|Support|Administrative|Compliance|Shared Services`',
    `division` STRING COMMENT 'High-level organizational division to which this department belongs. Used for executive-level reporting and strategic planning. [ENUM-REF-CANDIDATE: Operations|Business Development|Finance|Human Resources|Information Technology|Legal|Compliance|Marketing|Customer Success|Executive — 10 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this department was closed, merged, or otherwise ceased operations. Null for active departments. Used for historical reporting and compliance.',
    `effective_start_date` DATE COMMENT 'Date when this department was established or became operational. Used for historical org structure analysis and tenure calculations.',
    `email_address` STRING COMMENT 'Primary email address for department-level communications. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `headcount_capacity` STRING COMMENT 'Maximum number of Full-Time Equivalent (FTE) employees planned for this department. Used for workforce planning and budget allocation.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this department generates billable revenue through client placements or services. True for revenue-generating departments like Recruitment and Account Management; False for support departments.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the department. Organizational contact data classified as confidential.. Valid values are `^+?[1-9]d{1,14}$`',
    `requires_background_check` BOOLEAN COMMENT 'Indicates whether employees in this department require background checks due to access to sensitive data or compliance requirements. Used for onboarding workflows.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the departments primary operating location. Used for scheduling, reporting, and workforce coordination across distributed teams.. Valid values are `^[A-Za-z]+/[A-Za-z_]+$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this department record was last modified. Used for change tracking and audit compliance.',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Reference master for all internal organizational departments and cost center units within Staffing Hr. Captures department name, department code, division (Operations, Business Development, Finance, HR, IT, Legal, Compliance), parent department for hierarchy, department head employee reference, GL cost center code, physical office location, and active status. Enables org chart traversal, headcount reporting by department, and cost allocation to finance.cost_center.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`team` (
    `team_id` BIGINT COMMENT 'Unique identifier for the internal delivery team. Primary key.',
    `commission_plan_id` BIGINT COMMENT 'Reference to the commission or incentive compensation plan applicable to this teams members. Used for payroll and performance incentive tracking.',
    `office_location_id` BIGINT COMMENT 'Reference to the physical branch office location where this team is based. Null for virtual or corporate teams.',
    `department_id` BIGINT COMMENT 'Reference to the parent department or division to which this team belongs in the organizational hierarchy.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal employee who created this team record in the system.',
    `team_modified_by_employee_staff_profile_id` BIGINT COMMENT 'Reference to the internal employee who last modified this team record in the system.',
    `team_staff_profile_id` BIGINT COMMENT 'Reference to the internal employee who serves as the team lead or manager responsible for this teams performance and operations.',
    `vms_program_id` BIGINT COMMENT 'Reference to the Vendor Management System (VMS) program this team is assigned to, if applicable. Relevant for MSP and VMS-managed teams.',
    `parent_team_id` BIGINT COMMENT 'Self-referencing FK on team (parent_team_id)',
    `client_portfolio_size` STRING COMMENT 'The number of active client accounts assigned to this team for management and service delivery. Applicable primarily to account management and MSP teams.',
    `collaboration_model` STRING COMMENT 'The organizational collaboration model for this team: dedicated (team works exclusively on own portfolio), shared (team shares resources with other teams), matrix (team members report to multiple managers), or hybrid (combination of models).. Valid values are `dedicated|shared|matrix|hybrid`',
    `cost_center_code` STRING COMMENT 'The General Ledger (GL) cost center code used for financial tracking and allocation of this teams expenses.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this team record was first created in the system.',
    `current_headcount` STRING COMMENT 'The actual number of Full-Time Equivalent (FTE) employees currently assigned to this team.',
    `effective_end_date` DATE COMMENT 'The date when this team was disbanded or ceased operations. Null for active teams.',
    `effective_start_date` DATE COMMENT 'The date when this team was officially established and began operations.',
    `geographic_market` STRING COMMENT 'The geographic region or market this team serves (e.g., Southeast, Northeast, California, Texas, National). May be null for corporate or virtual teams.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this team record was last modified in the system.',
    `net_promoter_score_target` STRING COMMENT 'The target Net Promoter Score (NPS) for this team, measuring client or candidate satisfaction and loyalty. Ranges from -100 to +100.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context about this teams operations, history, or special considerations.',
    `placement_target_annual` STRING COMMENT 'The annual target number of placements (temporary or permanent) this team is expected to achieve. Applicable primarily to recruiting and RPO teams.',
    `primary_ats_instance` STRING COMMENT 'The primary Applicant Tracking System (ATS) instance or database this team uses for candidate and job order management (e.g., Bullhorn Production, Bullhorn MSP Instance).',
    `quality_of_submission_target_pct` DECIMAL(18,2) COMMENT 'The target Quality of Submission (QoS) percentage for this team, measuring the ratio of candidate submittals that result in interviews or placements. Expressed as a percentage (e.g., 75.00 for 75%).',
    `revenue_target_annual` DECIMAL(18,2) COMMENT 'The annual revenue target or quota assigned to this team for performance measurement, in USD. Applicable primarily to revenue-generating teams (recruiting, account management).',
    `service_level_agreement_tier` STRING COMMENT 'The Service Level Agreement (SLA) tier or service quality level this team is committed to delivering (e.g., platinum for premium clients, standard for general service).. Valid values are `platinum|gold|silver|bronze|standard`',
    `specialization_tags` STRING COMMENT 'Comma-separated list of specialization keywords or tags describing this teams unique capabilities or focus areas (e.g., travel nursing, PERM, executive search, bilingual).',
    `target_headcount` STRING COMMENT 'The planned or target number of Full-Time Equivalent (FTE) employees allocated to this team for capacity planning purposes.',
    `team_code` STRING COMMENT 'Short alphanumeric code used to identify the team in operational systems and reporting (e.g., HCIT-01, LIND-SE, MSP-ATL).. Valid values are `^[A-Z0-9]{3,10}$`',
    `team_name` STRING COMMENT 'The official name of the internal delivery team (e.g., Healthcare IT Recruiting Pod, Southeast Light Industrial Team, MSP Program Delivery Team).',
    `team_status` STRING COMMENT 'Current operational status of the team: active (currently operating), inactive (disbanded or closed), suspended (temporarily paused), or planned (not yet launched).. Valid values are `active|inactive|suspended|planned`',
    `team_type` STRING COMMENT 'The functional classification of the team indicating its primary business purpose: recruiting (talent sourcing and placement), account_management (client relationship management), msp (Managed Service Provider program delivery), rpo (Recruitment Process Outsourcing delivery), operations (back-office support), corporate (headquarters functions), or branch (local office team). [ENUM-REF-CANDIDATE: recruiting|account_management|msp|rpo|operations|corporate|branch — 7 candidates stripped; promote to reference product]',
    `time_to_fill_target_days` STRING COMMENT 'The target number of days for this team to fill a job requisition (Time to Fill - TTF), used as a Key Performance Indicator (KPI) for recruiting efficiency.',
    `vertical_focus` STRING COMMENT 'The industry vertical or skill specialization this team focuses on (e.g., Healthcare IT, Light Industrial, Finance & Accounting, Engineering, Administrative). May be null for generalist teams.',
    `work_arrangement` STRING COMMENT 'The primary work arrangement for team members: on_site (office-based), remote (fully remote), or hybrid (combination of office and remote).. Valid values are `on_site|remote|hybrid`',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'Master record for internal delivery teams within Staffing Hr — recruiting pods, account management teams, MSP program teams, RPO delivery teams, and branch office teams. Captures team name, team type (recruiting, account management, MSP, RPO, operations, corporate), team lead employee reference, parent department, geographic market or vertical focus (e.g., Healthcare IT, Light Industrial Southeast), target headcount, and active status. Supports team-level performance tracking, recruiter assignment routing, and capacity planning.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`team_membership` (
    `team_membership_id` BIGINT COMMENT 'Unique identifier for the team membership record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `office_location_id` BIGINT COMMENT 'Identifier of the primary office location associated with this team membership, if applicable.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee (recruiter, account manager, operations staff) who is a member of this team.',
    `team_id` BIGINT COMMENT 'Identifier of the team to which the employee is assigned.',
    `prior_team_membership_id` BIGINT COMMENT 'Self-referencing FK on team_membership (prior_team_membership_id)',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the employees time allocated to this team (0.00 to 100.00). Supports scenarios where employees serve on multiple teams (e.g., 80% primary pod, 20% surge team).',
    `assignment_type` STRING COMMENT 'Classification of the team assignment indicating whether this is the employees primary team, a secondary assignment, temporary assignment, project-based, or cross-functional role.. Valid values are `primary|secondary|temporary|project_based|cross_functional`',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the employees time on this team is billable to clients (relevant for Recruitment Process Outsourcing (RPO) or Managed Service Provider (MSP) engagements).',
    `client_segment` STRING COMMENT 'The client segment or industry vertical this employee focuses on within this team (e.g., Healthcare, Technology, Manufacturing).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this team membership record was first created in the system.',
    `end_date` DATE COMMENT 'The date when the employees membership in this team ended. Null for active memberships. Enables org change auditing and historical roster queries.',
    `geographic_coverage` STRING COMMENT 'The geographic region or territory this employee covers as part of this team assignment (e.g., Northeast Region, California, National).',
    `is_team_lead` BOOLEAN COMMENT 'Boolean flag indicating whether this employee serves as the team lead or manager for this team.',
    `membership_status` STRING COMMENT 'Current status of the team membership indicating whether the employee is actively participating in the team.. Valid values are `active|inactive|suspended|on_leave`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this team membership record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text notes or comments about this team membership, including special arrangements, transition details, or other relevant information.',
    `offboarding_date` DATE COMMENT 'The date when the employee completed offboarding procedures from this team (knowledge transfer, handover, exit activities).',
    `onboarding_date` DATE COMMENT 'The date when the employee completed onboarding and training specific to this team assignment.',
    `primary_responsibility` STRING COMMENT 'Brief description of the employees primary responsibility or focus area within this team (e.g., IT recruitment, healthcare client accounts, payroll operations).',
    `reporting_relationship` STRING COMMENT 'The nature of the reporting relationship within this team (direct report, dotted-line, matrix, functional, or administrative).. Valid values are `direct|dotted_line|matrix|functional|administrative`',
    `skill_level` STRING COMMENT 'The skill or experience level of the employee in their team role (junior, intermediate, senior, expert, lead).. Valid values are `junior|intermediate|senior|expert|lead`',
    `source_system` STRING COMMENT 'The name of the source system from which this team membership record originated (e.g., SAP SuccessFactors, Bullhorn, internal Human Resource Information System (HRIS)).',
    `source_system_code` STRING COMMENT 'The unique identifier for this team membership record in the source system.',
    `start_date` DATE COMMENT 'The date when the employee officially joined this team. Supports historical team composition tracking.',
    `target_headcount_contribution` DECIMAL(18,2) COMMENT 'The target number of placements or headcount this employee is expected to contribute to the teams goals during the membership period.',
    `target_revenue_contribution` DECIMAL(18,2) COMMENT 'The target revenue amount this employee is expected to contribute to the teams financial goals during the membership period.',
    `team_role` STRING COMMENT 'The functional role the employee performs within this team (e.g., recruiter, account manager, operations specialist, team lead, coordinator, analyst).. Valid values are `recruiter|account_manager|operations_specialist|team_lead|coordinator|analyst`',
    `termination_reason` STRING COMMENT 'The reason why the team membership ended (team restructure, promotion, transfer, resignation, performance, project completion, other). Null for active memberships. [ENUM-REF-CANDIDATE: team_restructure|promotion|transfer|resignation|performance|project_completion|other — 7 candidates stripped; promote to reference product]',
    `work_location` STRING COMMENT 'The work location arrangement for this team membership (on-site, remote, hybrid).. Valid values are `on_site|remote|hybrid`',
    CONSTRAINT pk_team_membership PRIMARY KEY(`team_membership_id`)
) COMMENT 'Association record linking an internal employee to a specific team, capturing the employees role on the team, start date, end date, membership status (active, inactive), and whether the employee is the team lead. Supports historical team composition tracking, team roster queries, and org change auditing. Enables many-to-many team assignments where employees may serve on multiple teams (e.g., a recruiter supporting both a primary pod and a surge team).';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`role_assignment` (
    `role_assignment_id` BIGINT COMMENT 'Unique identifier for the role assignment record. Primary key.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the user who last modified this role assignment record. Used for audit trail and change tracking.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `department_id` BIGINT COMMENT 'FK to employee.department',
    `primary_role_staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee (recruiter, account manager, operations staff) to whom the role is assigned.',
    `quaternary_role_revoked_by_user_staff_profile_id` BIGINT COMMENT 'Identifier of the user (manager, HR administrator, or IT security officer) who revoked the role assignment. Null if not revoked.',
    `quinary_role_created_by_user_staff_profile_id` BIGINT COMMENT 'Identifier of the user (HR administrator, manager, or system process) who created this role assignment record. Used for audit trail and accountability.',
    `tertiary_role_reporting_manager_staff_profile_id` BIGINT COMMENT 'Identifier of the manager to whom the employee reports while in this role. May differ from authorizing_manager_id in matrix or project-based organizations.',
    `superseded_role_assignment_id` BIGINT COMMENT 'Self-referencing FK on role_assignment (superseded_role_assignment_id)',
    `access_level` STRING COMMENT 'For system role assignments, the level of access or permission granted within the system (read_only, read_write, admin, super_admin, custom). Null for non-system role types.. Valid values are `read_only|read_write|admin|super_admin|custom`',
    `assigned_date` DATE COMMENT 'The date on which the role assignment was created or approved by the authorizing manager.',
    `assignment_notes` STRING COMMENT 'Free-text notes or comments about the role assignment, including special conditions, temporary arrangements, or additional context for auditors and HR administrators.',
    `assignment_priority` STRING COMMENT 'Numeric priority or ranking of this role assignment relative to other roles held by the same employee. Lower numbers indicate higher priority. Used for conflict resolution and workload allocation.',
    `assignment_reason` STRING COMMENT 'Business justification or reason for the role assignment (e.g., new hire onboarding, promotion, lateral move, project assignment, system access request, desk reassignment, territory expansion).',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the role assignment: active (currently in effect), inactive (ended), pending (approved but not yet effective), suspended (temporarily disabled), expired (past effective end date), revoked (terminated before planned end date).. Valid values are `active|inactive|pending|suspended|expired|revoked`',
    `authorization_date` DATE COMMENT 'The date on which the authorizing manager approved the role assignment.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this role assignment requires special compliance tracking or audit attention (true) due to regulatory requirements, elevated privileges, or sensitive data access. False for standard assignments.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this role assignment record was first created in the system. Used for audit trail and data lineage.',
    `desk_name` STRING COMMENT 'For recruiter desk assignments, the name of the recruiting desk or specialization (e.g., IT Desk, Healthcare Desk, Finance Desk). Null for non-desk role types.',
    `effective_end_date` DATE COMMENT 'The date on which the role assignment ends or is scheduled to end. Null indicates an open-ended assignment.',
    `effective_start_date` DATE COMMENT 'The date from which the role assignment becomes active and the employee begins exercising the roles responsibilities or access rights.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The percentage of the employees time allocated to this role, expressed as a decimal (e.g., 1.00 for full-time, 0.50 for half-time). Used for capacity planning and workload management. FTE = Full-Time Equivalent.',
    `is_primary_role` BOOLEAN COMMENT 'Boolean flag indicating whether this is the employees primary job role (true) or a secondary/additional role assignment (false). Used to distinguish main organizational position from supplementary responsibilities.',
    `last_access_review_date` DATE COMMENT 'For system role assignments, the date of the most recent access review or recertification conducted to verify that the employee still requires this access. Required for SOC 2 Type II compliance.',
    `location_code` STRING COMMENT 'Code identifying the primary work location or office associated with this role assignment. Used for workforce planning and compliance reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this role assignment record was last modified or updated. Used for audit trail and change tracking.',
    `next_access_review_date` DATE COMMENT 'For system role assignments, the scheduled date for the next access review or recertification. Used to trigger compliance workflows and audit alerts.',
    `revocation_date` DATE COMMENT 'The date on which the role assignment was revoked or terminated before its planned effective_end_date. Null if the assignment ended naturally or is still active.',
    `revocation_reason` STRING COMMENT 'Business reason for early revocation of the role assignment (e.g., employee termination, role change, security incident, policy violation, project completion). Null if not revoked.',
    `role_code` STRING COMMENT 'Standardized code or identifier for the role, used for system provisioning and reporting (e.g., REC-SR, AM-ENT, SYS-ADMIN).',
    `role_name` STRING COMMENT 'The name of the role being assigned (e.g., Senior Recruiter, Account Manager, System Administrator, Desk Lead).',
    `role_type` STRING COMMENT 'Classification of the role assignment: job_role (organizational position), system_role (application access role for RBAC), functional_responsibility (project or task-based responsibility), desk_assignment (recruiter desk or specialization), territory_assignment (account manager geographic or vertical territory).. Valid values are `job_role|system_role|functional_responsibility|desk_assignment|territory_assignment`',
    `system_name` STRING COMMENT 'For system role assignments, the name of the application or system to which access is being granted (e.g., Bullhorn ATS, SAP SuccessFactors, Oracle NetSuite, Beeline VMS). Null for non-system role types.',
    `territory_name` STRING COMMENT 'For account manager territory assignments, the name of the geographic or vertical territory (e.g., Northeast Region, Healthcare Vertical, Enterprise Accounts). Null for non-territory role types.',
    CONSTRAINT pk_role_assignment PRIMARY KEY(`role_assignment_id`)
) COMMENT 'Transactional record capturing the assignment of a specific job role, system access role, or functional responsibility to an internal employee. Tracks role name, role type (job role, system role, functional responsibility), assigned date, effective start date, effective end date, assignment status, and the authorizing manager. Supports RBAC (Role-Based Access Control) provisioning, recruiter desk assignments, account manager territory ownership, and compliance audit trails for system access reviews.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`compensation` (
    `compensation_id` BIGINT COMMENT 'Unique identifier for the compensation record. Primary key for the compensation data product.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal employee (typically manager, HR director, or executive) who approved this compensation record. Links to the employee master data product.',
    `compensation_staff_profile_id` BIGINT COMMENT 'Reference to the internal employee who is the subject of this compensation record. Links to the employee master data product.',
    `compensation_plan_id` BIGINT COMMENT 'Reference to the formal compensation plan or structure under which this compensation record is governed. Links to compensation plan master data defining rules, bands, and eligibility criteria.',
    `prior_compensation_id` BIGINT COMMENT 'Self-referencing FK on compensation (prior_compensation_id)',
    `annual_hours_expected` STRING COMMENT 'The expected number of work hours per year for this employee based on their FTE and schedule. Typically 2080 for full-time employees (40 hours/week * 52 weeks). Used for hourly rate calculations and capacity planning.',
    `approval_date` DATE COMMENT 'The date on which this compensation record was formally approved by the authorized approver. Used for audit trail and compliance verification.',
    `band` STRING COMMENT 'The compensation band or salary range classification assigned to this employee. Used for internal equity analysis and compensation planning. Examples: Band A, Band B, Executive, Senior, Mid-Level, Entry.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The annual base salary amount for salaried employees. Null for hourly or commission-only employees. Represents the fixed component of total compensation before bonuses, commissions, or other variable pay.',
    `change_reason` STRING COMMENT 'The business reason for creating this compensation record. Captures the driver for the compensation change or establishment. New hire indicates initial compensation upon hire, merit increase indicates performance-based raise, promotion indicates advancement to higher role, market adjustment indicates alignment with external market rates, equity correction indicates internal pay equity adjustment. [ENUM-REF-CANDIDATE: new_hire|merit_increase|promotion|market_adjustment|equity_correction|cost_of_living|title_change|demotion|transfer|annual_review — 10 candidates stripped; promote to reference product]',
    `change_reason_notes` STRING COMMENT 'Free-text notes providing additional context or justification for the compensation change. May include performance review scores, market data references, or approval details.',
    `commission_rate` DECIMAL(18,2) COMMENT 'The commission percentage or rate applied to revenue, placements, or other performance metrics for commission-eligible employees. Expressed as a decimal (e.g., 0.0500 for 5%).',
    `compa_ratio` DECIMAL(18,2) COMMENT 'The comparative ratio expressing the employees compensation relative to the midpoint of their compensation band or market rate. Calculated as (actual compensation / band midpoint) * 100. Values below 100 indicate below-midpoint pay, above 100 indicate above-midpoint pay. Used for pay equity analysis.',
    `compensation_type` STRING COMMENT 'The classification of compensation structure for the employee. Salary indicates fixed annual pay, hourly indicates pay per hour worked, draw_plus_commission indicates guaranteed draw with commission upside, commission_only indicates pure variable pay, contract indicates fixed-term contractor rate, stipend indicates allowance-based pay.. Valid values are `salary|hourly|draw_plus_commission|commission_only|contract|stipend`',
    `cost_center_code` STRING COMMENT 'The cost center code to which this employees compensation expense is allocated. Used for financial reporting and budgeting. May differ from current employee cost center if this is a historical record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compensation record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the compensation is denominated. Supports multi-currency operations for international employees.. Valid values are `USD|CAD|GBP|EUR|AUD`',
    `department_code` STRING COMMENT 'The department code associated with this compensation record at the time of its creation. Used for cost allocation and departmental compensation analysis. May differ from current employee department if this is a historical record.',
    `draw_amount` DECIMAL(18,2) COMMENT 'The guaranteed draw amount for draw-plus-commission employees. Represents the minimum compensation paid regardless of commission performance, typically recoverable against future commissions.',
    `effective_date` DATE COMMENT 'The date on which this compensation record becomes active and applicable to the employee. Marks the start of the compensation period.',
    `end_date` DATE COMMENT 'The date on which this compensation record ceases to be active. Null for current active compensation records. Populated when a new compensation record supersedes this one or when employment ends.',
    `equity_grant_value` DECIMAL(18,2) COMMENT 'The value of equity compensation (stock options, RSUs, or other equity instruments) granted to the employee as part of this compensation package. Null for employees without equity compensation.',
    `flsa_classification` STRING COMMENT 'The FLSA classification of the employee. Exempt employees are not entitled to overtime pay and typically hold executive, administrative, or professional roles. Non-exempt employees are entitled to overtime pay for hours worked over 40 per week.. Valid values are `exempt|non_exempt`',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The FTE percentage representing the employees work schedule relative to full-time. 100.00 indicates full-time, 50.00 indicates half-time. Used to prorate compensation for part-time employees.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'The hourly pay rate for hourly employees. Null for salaried employees. Used to calculate gross pay based on hours worked.',
    `is_current_record` BOOLEAN COMMENT 'Indicates whether this is the current active compensation record for the employee. True for the most recent record with null end_date, False for historical records. Used to simplify queries for current compensation.',
    `job_title` STRING COMMENT 'The job title associated with this compensation record. Captured here to provide historical context for compensation changes tied to role changes. May differ from current employee job title if this is a historical record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this compensation record was last modified in the data platform. Used for audit trail and change tracking.',
    `market_percentile` STRING COMMENT 'The market percentile at which this compensation is positioned relative to external market data for comparable roles. Values range from 1 to 100, where 50 represents median market pay. Used for competitive positioning analysis.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for overtime pay under FLSA regulations. True for non-exempt employees, False for exempt employees.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid. Weekly indicates 52 pay periods per year, bi-weekly indicates 26 pay periods, semi-monthly indicates 24 pay periods (typically 15th and last day of month), monthly indicates 12 pay periods.. Valid values are `weekly|bi_weekly|semi_monthly|monthly`',
    `pay_grade` STRING COMMENT 'The pay grade level assigned to the employee within the compensation structure. Used for career progression and compensation benchmarking. Examples: Grade 1, Grade 2, L1, L2, IC3, M4.',
    `source_system` STRING COMMENT 'The name of the source system from which this compensation record originated. Examples: SAP SuccessFactors, Workday, ADP, Oracle HCM. Used for data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'The unique identifier for this compensation record in the source system. Used for data lineage, reconciliation, and troubleshooting.',
    `target_bonus_amount` DECIMAL(18,2) COMMENT 'The target annual bonus amount for bonus-eligible employees. Represents the expected bonus at 100% performance achievement. Null for employees not eligible for annual bonuses.',
    `target_bonus_percentage` DECIMAL(18,2) COMMENT 'The target bonus expressed as a percentage of base salary. Used for bonus-eligible employees where bonus is calculated as a percentage of base. Null for fixed bonus amounts or non-bonus-eligible employees.',
    `work_location_code` STRING COMMENT 'The primary work location code for the employee at the time of this compensation record. Used for geographic pay differentials and compliance with local wage laws. May differ from current employee location if this is a historical record.',
    CONSTRAINT pk_compensation PRIMARY KEY(`compensation_id`)
) COMMENT 'Master record defining the current and historical compensation structure for each internal employee. Captures compensation type (salary, hourly, draw-plus-commission, commission-only), base salary or hourly rate, pay frequency (weekly, bi-weekly, semi-monthly, monthly), currency, effective date, end date, compensation band, pay grade, overtime eligibility, and the reason for the compensation record (new hire, merit increase, promotion, market adjustment, equity correction). SSOT for internal employee pay rates — distinct from payroll.pay_rate (contingent worker pay) and billing.bill_rate (client-facing rates).';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`commission_plan` (
    `commission_plan_id` BIGINT COMMENT 'Unique identifier for the commission plan record. Primary key.',
    `primary_commission_staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee (recruiter, account manager, business development rep) to whom this commission plan is assigned.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the user who last modified this commission plan record.',
    `superseded_commission_plan_id` BIGINT COMMENT 'Self-referencing FK on commission_plan (superseded_commission_plan_id)',
    `accelerator_rate` DECIMAL(18,2) COMMENT 'Enhanced commission rate as a decimal applied when accelerator threshold is met (e.g., 0.3500 for 35%). Null if plan does not include accelerators.',
    `accelerator_threshold` DECIMAL(18,2) COMMENT 'Revenue or gross margin threshold that triggers an accelerated commission rate (bonus multiplier). Null if plan does not include accelerators.',
    `approval_date` DATE COMMENT 'Date when the commission plan was formally approved by management.',
    `base_commission_rate` DECIMAL(18,2) COMMENT 'The baseline commission rate as a decimal (e.g., 0.2500 for 25%). Represents the starting tier or standard rate before accelerators or adjustments.',
    `calculation_basis` STRING COMMENT 'The financial metric on which commission is calculated. Gross margin: bill rate minus pay rate and burden. Bill rate: total amount billed to client. Placement fee: one-time fee for direct hire. Spread: bill rate minus pay rate. Revenue: total invoiced revenue. Net revenue: revenue after adjustments.. Valid values are `gross_margin|bill_rate|placement_fee|spread|revenue|net_revenue`',
    `cap_amount` DECIMAL(18,2) COMMENT 'Maximum commission amount that can be earned in a single period (monthly, quarterly, annually depending on plan). Null if no cap.',
    `cap_period` STRING COMMENT 'Time period over which the commission cap is applied. Null if no cap.. Valid values are `monthly|quarterly|annually`',
    `clawback_condition` STRING COMMENT 'Condition that triggers commission clawback. Candidate termination: candidate leaves before guarantee period. Invoice non-payment: client does not pay. Client cancellation: client cancels assignment. Any failure: any of the above. Null if no clawback provision.. Valid values are `candidate_termination|invoice_non_payment|client_cancellation|any_failure`',
    `clawback_period_days` STRING COMMENT 'Number of days after commission payment during which the commission can be clawed back if the placement fails or invoice is not collected. Null if no clawback provision.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this commission plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this commission plan (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `draw_amount` DECIMAL(18,2) COMMENT 'Fixed advance payment amount provided to the employee against future commissions (recoverable draw). Null if plan does not include a draw.',
    `draw_frequency` STRING COMMENT 'Frequency at which the draw amount is paid to the employee. Null if plan does not include a draw.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `draw_recovery_method` STRING COMMENT 'Method by which draw amounts are recovered from earned commissions. Full recovery: entire draw deducted from commissions. Partial recovery: percentage deducted. Non-recoverable: draw is guaranteed (not a true draw). Rolling recovery: recovery over multiple periods. Null if plan does not include a draw.. Valid values are `full_recovery|partial_recovery|non_recoverable|rolling_recovery`',
    `draw_recovery_percentage` DECIMAL(18,2) COMMENT 'Percentage of earned commissions withheld to recover draw advances (e.g., 0.5000 for 50%). Null if plan does not include a draw or uses full recovery.',
    `effective_date` DATE COMMENT 'Date when the commission plan becomes active and starts governing compensation calculations.',
    `end_date` DATE COMMENT 'Date when the commission plan expires or is scheduled to terminate. Null for open-ended plans.',
    `minimum_payout_amount` DECIMAL(18,2) COMMENT 'Minimum commission amount that must be earned before payout is issued. Amounts below this threshold are carried forward to the next period. Null if no minimum.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this commission plan record was last modified.',
    `payment_frequency` STRING COMMENT 'Frequency at which earned commissions are paid to the employee.. Valid values are `weekly|biweekly|semimonthly|monthly|quarterly`',
    `payment_timing` STRING COMMENT 'Trigger event that determines when commission is paid. Upon invoice: when client is invoiced. Upon payment: when client pays invoice. Upon placement: when candidate is placed. Upon start date: when candidate starts work. Deferred: paid after a waiting period.. Valid values are `upon_invoice|upon_payment|upon_placement|upon_start_date|deferred`',
    `plan_code` STRING COMMENT 'Unique business identifier code for the commission plan, used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `plan_description` STRING COMMENT 'Detailed textual description of the commission plan terms, conditions, and calculation methodology.',
    `plan_name` STRING COMMENT 'Descriptive name of the commission plan (e.g., Senior Recruiter Gross Margin Split Q1 2024, Account Manager Placement Fee Plan).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the commission plan. Draft: plan is being designed. Active: plan is in effect. Suspended: temporarily paused. Expired: plan end date has passed. Terminated: plan was cancelled before expiration.. Valid values are `draft|active|suspended|expired|terminated`',
    `plan_type` STRING COMMENT 'Classification of the commission plan structure. Gross margin split: percentage of gross margin (bill rate minus pay rate). Placement fee percentage: percentage of placement fee for direct hire. Spread-based: commission on the spread (markup). Hybrid: combination of multiple methods. Tiered revenue: commission rate changes based on revenue thresholds. Flat rate: fixed amount per placement or milestone.. Valid values are `gross_margin_split|placement_fee_percentage|spread_based|hybrid|tiered_revenue|flat_rate`',
    `split_default_percentage` DECIMAL(18,2) COMMENT 'Default percentage of commission allocated to this employee when commission is split (e.g., 0.6000 for 60%). Null if splits are not allowed or no default is defined.',
    `split_eligible` BOOLEAN COMMENT 'Indicates whether this commission plan allows commission splitting with other employees (e.g., recruiter and account manager split on a placement). True if splits are allowed, False otherwise.',
    `tier_1_rate` DECIMAL(18,2) COMMENT 'Commission rate as a decimal for the first performance tier (e.g., 0.2000 for 20%). Null if plan does not use tiered structure.',
    `tier_1_threshold` DECIMAL(18,2) COMMENT 'Revenue or gross margin threshold amount that triggers the first commission rate tier. Null if plan does not use tiered structure.',
    `tier_2_rate` DECIMAL(18,2) COMMENT 'Commission rate as a decimal for the second performance tier (e.g., 0.2500 for 25%). Null if plan does not use tiered structure or has fewer than 2 tiers.',
    `tier_2_threshold` DECIMAL(18,2) COMMENT 'Revenue or gross margin threshold amount that triggers the second commission rate tier. Null if plan does not use tiered structure or has fewer than 2 tiers.',
    `tier_3_rate` DECIMAL(18,2) COMMENT 'Commission rate as a decimal for the third performance tier (e.g., 0.3000 for 30%). Null if plan does not use tiered structure or has fewer than 3 tiers.',
    `tier_3_threshold` DECIMAL(18,2) COMMENT 'Revenue or gross margin threshold amount that triggers the third commission rate tier. Null if plan does not use tiered structure or has fewer than 3 tiers.',
    CONSTRAINT pk_commission_plan PRIMARY KEY(`commission_plan_id`)
) COMMENT 'Master record defining the commission and incentive compensation plan assigned to a revenue-generating internal employee (recruiter, account manager, business development rep). Captures plan name, plan type (gross margin split, placement fee percentage, spread-based, hybrid), commission rate tiers, accelerator thresholds, draw amount (if applicable), draw recovery terms, plan effective date, plan end date, and the approving manager. Critical for recruiter and account manager incentive management in staffing firms where variable compensation drives behavior.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`commission_earning` (
    `commission_earning_id` BIGINT COMMENT 'Unique identifier for the commission earning transaction record.',
    `assignment_id` BIGINT COMMENT 'Identifier of the placement that triggered this commission earning event. Nullable for non-placement-based commissions.',
    `commission_plan_id` BIGINT COMMENT 'Identifier of the commission plan or compensation structure under which this earning was calculated.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice associated with this commission earning, if applicable. Used for billing-based commission triggers.',
    `order_header_id` BIGINT COMMENT 'Identifier of the job order (requisition) associated with this commission earning event.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee (recruiter, account manager, operations staff) who earned this commission.',
    `adjustment_commission_earning_id` BIGINT COMMENT 'Self-referencing FK on commission_earning (adjustment_commission_earning_id)',
    `accelerator_applied` BOOLEAN COMMENT 'Indicates whether a commission accelerator (bonus multiplier for exceeding targets) was applied to this earning. True if accelerator was applied; false otherwise.',
    `accelerator_rate` DECIMAL(18,2) COMMENT 'Additional commission rate applied as an accelerator for exceeding performance targets, expressed as a decimal (e.g., 0.0200 for an additional 2%).',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustment applied to the commission amount due to fall-offs, reversals, clawbacks, or corrections. Negative values represent reductions; positive values represent additions.',
    `approval_date` DATE COMMENT 'Date on which this commission earning was approved by the manager. Null if not yet approved.',
    `approval_status` STRING COMMENT 'Current approval workflow status for this commission earning. Pending approval indicates awaiting manager review; approved indicates manager has approved; rejected indicates manager has rejected; under review indicates additional scrutiny is required.. Valid values are `pending_approval|approved|rejected|under_review`',
    `basis_amount` DECIMAL(18,2) COMMENT 'Gross margin, fee amount, or revenue amount used as the basis for calculating this commission. For direct hire, this is the placement fee; for temp placements, this is the spread (bill rate minus pay rate) or cumulative gross margin.',
    `basis_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the basis amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `clawback_date` DATE COMMENT 'Date on which the commission clawback was processed. Null if no clawback has occurred.',
    `clawback_reason` STRING COMMENT 'Reason for commission clawback or reversal, such as candidate fall-off before guarantee period, client non-payment, placement termination within guarantee period, or policy violation.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Total commission amount earned by the employee for this transaction, calculated as basis amount multiplied by commission rate, before any adjustments.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate applied to the basis amount to calculate the commission earned, expressed as a decimal (e.g., 0.1000 for 10%, 0.0500 for 5%).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this commission earning record was first created in the system.',
    `dispute_date` DATE COMMENT 'Date on which the employee raised the dispute. Null if no dispute has been raised.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the employee has raised a dispute regarding this commission earning. True if disputed; false otherwise.',
    `dispute_reason` STRING COMMENT 'Employee-provided reason for disputing this commission earning, such as incorrect rate applied, missing split credit, or incorrect basis amount.',
    `earning_date` DATE COMMENT 'Date on which the commission was earned based on the triggering business event (e.g., placement start date, fee collection date, conversion date).',
    `earning_event_type` STRING COMMENT 'Type of business event that triggered this commission earning. Placement start occurs when a candidate begins assignment; direct hire fee when permanent placement fee is collected; temp-to-perm conversion when temporary worker converts to permanent; spread milestone when cumulative gross margin threshold is reached; extension when assignment is extended; backfill when a replacement placement is made.. Valid values are `placement_start|direct_hire_fee|temp_to_perm_conversion|spread_milestone|extension|backfill`',
    `guarantee_end_date` DATE COMMENT 'Date on which the guarantee period expires and the commission becomes fully vested and no longer subject to clawback.',
    `guarantee_period_days` STRING COMMENT 'Number of days in the guarantee period for this placement. Commission may be subject to clawback if the placement ends within this period.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this commission earning record is currently active and valid. False if the record has been voided, superseded, or logically deleted.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this commission earning record was last modified or updated.',
    `net_commission_amount` DECIMAL(18,2) COMMENT 'Final net commission amount payable to the employee after applying all adjustments. Calculated as commission amount plus adjustment amount.',
    `notes` STRING COMMENT 'Additional notes or comments regarding this commission earning, including special circumstances, manual adjustments, or clarifications.',
    `pay_period_end_date` DATE COMMENT 'End date of the pay period in which this commission earning will be paid.',
    `pay_period_start_date` DATE COMMENT 'Start date of the pay period in which this commission earning will be paid.',
    `payment_date` DATE COMMENT 'Actual date on which the commission payment was issued to the employee. Null if not yet paid.',
    `payment_status` STRING COMMENT 'Current payment status of this commission earning. Pending indicates awaiting approval; approved indicates ready for payment; paid indicates payment has been issued; clawed back indicates commission was reversed due to fall-off or policy violation; disputed indicates employee has raised a dispute; cancelled indicates the earning was voided.. Valid values are `pending|approved|paid|clawed_back|disputed|cancelled`',
    `resolution_notes` STRING COMMENT 'Notes documenting the resolution of any dispute or adjustment, including actions taken and final decision.',
    `source_record_reference` STRING COMMENT 'Unique identifier of this commission earning record in the source system, used for traceability and reconciliation.',
    `source_system` STRING COMMENT 'Name of the source system from which this commission earning record originated (e.g., TempWorks Payroll, Oracle NetSuite ERP, Bullhorn ATS/CRM).',
    `split_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total commission allocated to this employee when commission is split among multiple employees (e.g., recruiter and account manager). Expressed as a percentage (e.g., 50.00 for 50%, 100.00 for 100%).',
    `split_reason` STRING COMMENT 'Business reason for commission split, such as shared responsibility between recruiter and account manager, team collaboration, or management override.',
    `tier_level` STRING COMMENT 'Commission tier or level applicable to this earning, if the commission plan uses tiered rates based on performance thresholds (e.g., Bronze, Silver, Gold, Platinum).',
    CONSTRAINT pk_commission_earning PRIMARY KEY(`commission_earning_id`)
) COMMENT 'Transactional record capturing each individual commission earning event for an internal employee. Tracks the triggering event type (placement start, direct hire fee collected, temp-to-perm conversion, spread milestone), associated placement or billing reference, gross margin or fee amount used as the basis, commission rate applied, commission amount earned, pay period, payment status (pending, approved, paid, clawed back), and any adjustments for fall-offs or reversals. Enables recruiter and account manager commission statement generation and dispute resolution.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal employee being reviewed (recruiter, account manager, operations staff).',
    `reviewer_employee_staff_profile_id` BIGINT COMMENT 'Reference to the employee conducting the performance review (typically manager or supervisor).',
    `prior_performance_review_id` BIGINT COMMENT 'Self-referencing FK on performance_review (prior_performance_review_id)',
    `acknowledged_date` DATE COMMENT 'The date the employee acknowledged receipt and review of their performance evaluation.',
    `compensation_change_triggered_flag` BOOLEAN COMMENT 'Indicates whether this performance review resulted in a compensation change (salary increase, bonus, commission adjustment). True if compensation change was triggered, False otherwise.',
    `competency_rating_communication` STRING COMMENT 'Rating for communication skills including written, verbal, and interpersonal communication effectiveness.. Valid values are `exceeds|meets|needs-improvement|unsatisfactory|not-applicable`',
    `competency_rating_leadership` STRING COMMENT 'Rating for leadership capabilities including team management, mentoring, and strategic thinking. May be not-applicable for individual contributor roles.. Valid values are `exceeds|meets|needs-improvement|unsatisfactory|not-applicable`',
    `competency_rating_teamwork` STRING COMMENT 'Rating for collaboration, teamwork, and ability to work effectively with colleagues and cross-functional teams.. Valid values are `exceeds|meets|needs-improvement|unsatisfactory|not-applicable`',
    `competency_rating_technical` STRING COMMENT 'Rating for technical skills and job-specific competencies (e.g., ATS proficiency for recruiters, CRM skills for account managers).. Valid values are `exceeds|meets|needs-improvement|unsatisfactory|not-applicable`',
    `completed_date` DATE COMMENT 'The date the performance review was finalized and completed by the reviewer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was first created in the system.',
    `development_areas_summary` STRING COMMENT 'Narrative summary of areas where the employee needs improvement, skill development, or additional support.',
    `employee_comments` STRING COMMENT 'Comments or feedback provided by the employee in response to the performance review, including self-assessment and acknowledgment notes.',
    `goals_met_count` STRING COMMENT 'Number of performance goals or objectives successfully met during the review period.',
    `goals_total_count` STRING COMMENT 'Total number of performance goals or objectives assigned for the review period.',
    `kpi_achievement_percentage` DECIMAL(18,2) COMMENT 'Percentage of assigned Key Performance Indicators (KPIs) achieved during the review period. For staffing roles, may include metrics like Time to Fill (TTF), Quality of Submission (QoS), placement conversion rates, or client Net Promoter Score (NPS).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was last modified or updated.',
    `next_review_due_date` DATE COMMENT 'The scheduled date for the next performance review cycle for this employee.',
    `overall_rating` STRING COMMENT 'The overall performance rating assigned to the employee for the review period (e.g., Exceeds Expectations, Meets Expectations, Needs Improvement, Unsatisfactory, Outstanding, Developing).. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding|developing`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall performance rating, typically on a scale (e.g., 1.0 to 5.0). Enables quantitative analysis and trending.',
    `pip_initiated_flag` BOOLEAN COMMENT 'Indicates whether a Performance Improvement Plan (PIP) was initiated as a result of this review due to unsatisfactory performance. True if PIP was initiated, False otherwise.',
    `promotion_triggered_flag` BOOLEAN COMMENT 'Indicates whether this performance review resulted in a promotion or role change. True if promotion was triggered, False otherwise.',
    `review_cycle_type` STRING COMMENT 'The frequency or type of review cycle (annual, semi-annual, quarterly, 90-day probationary, ad-hoc).. Valid values are `annual|semi-annual|quarterly|90-day|probationary|ad-hoc`',
    `review_document_url` STRING COMMENT 'URL or file path to the formal performance review document stored in the document management system (e.g., DocuSign CLM, SharePoint).',
    `review_period_end_date` DATE COMMENT 'The end date of the performance period being evaluated.',
    `review_period_start_date` DATE COMMENT 'The start date of the performance period being evaluated.',
    `review_status` STRING COMMENT 'Current workflow status of the performance review: scheduled (not yet started), in-progress (being conducted), completed (finalized by reviewer), acknowledged (employee has reviewed and acknowledged), cancelled, or overdue.. Valid values are `scheduled|in-progress|completed|acknowledged|cancelled|overdue`',
    `review_type` STRING COMMENT 'The specific type of performance review being conducted: standard performance review, probationary review, Performance Improvement Plan (PIP), promotion readiness assessment, exit review, or project-based review.. Valid values are `standard|probationary|pip|promotion-readiness|exit|project-based`',
    `reviewer_comments` STRING COMMENT 'Detailed comments and feedback provided by the reviewer regarding the employees performance, achievements, and areas for growth.',
    `scheduled_date` DATE COMMENT 'The date the performance review meeting is scheduled to occur.',
    `strengths_summary` STRING COMMENT 'Narrative summary of the employees key strengths, accomplishments, and positive contributions during the review period.',
    `succession_planning_flag` BOOLEAN COMMENT 'Indicates whether the employee was identified for succession planning or high-potential talent programs based on this review. True if identified for succession planning, False otherwise.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Master record for formal performance review cycles conducted for internal employees. Captures review period (annual, semi-annual, quarterly, 90-day), review type (standard, probationary, PIP, promotion readiness), overall rating (e.g., Exceeds Expectations, Meets Expectations, Needs Improvement), review status (scheduled, in progress, completed, acknowledged), review date, reviewer employee reference, and whether the review triggered a compensation change or promotion. Supports talent management, succession planning, and PIP tracking.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`performance_goal` (
    `performance_goal_id` BIGINT COMMENT 'Unique identifier for the performance goal record. Primary key.',
    `development_plan_id` BIGINT COMMENT 'Identifier of the employee development plan or training program linked to this goal (if the goal is development-focused). Null if not linked to a development plan.',
    `parent_goal_performance_goal_id` BIGINT COMMENT 'Identifier of the parent or cascaded goal (team, department, or company-level) to which this individual goal is aligned. Null if this is a top-level goal.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee (recruiter, account manager, operations staff) to whom this performance goal is assigned.',
    `review_period_id` BIGINT COMMENT 'Identifier of the performance review period (e.g., Q1 2024, Annual 2024) within which this goal is set and measured.',
    `tertiary_performance_approved_by_staff_profile_id` BIGINT COMMENT 'Identifier of the person (typically manager or HR) who formally approved this performance goal. Null if not yet approved.',
    `parent_performance_goal_id` BIGINT COMMENT 'Self-referencing FK on performance_goal (parent_performance_goal_id)',
    `achievement_percentage` DECIMAL(18,2) COMMENT 'The percentage of goal achievement calculated as (actual_value / target_value) * 100. Used to determine performance rating contribution. Null if not yet measured.',
    `actual_completion_date` DATE COMMENT 'The date when this performance goal was actually completed or measured. Null if goal is still in progress.',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual numeric value achieved by the employee for this goal at the time of measurement or review completion. Null if goal is not yet measured.',
    `alignment_level` STRING COMMENT 'The organizational level to which this goal is aligned: individual (personal development), team (team-level objective), department (divisional target), company (enterprise-wide strategic goal).. Valid values are `individual|team|department|company`',
    `approved_date` DATE COMMENT 'The date when this performance goal was formally approved. Null if not yet approved.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this performance goal record was first created in the system.',
    `employee_comments` STRING COMMENT 'Self-assessment comments or reflections provided by the employee regarding their performance on this goal.',
    `goal_category` STRING COMMENT 'Classification of the goal type: revenue (financial targets), activity (volume metrics), quality (performance ratios), development (skill building), compliance (regulatory adherence), or client_satisfaction (NPS, retention).. Valid values are `revenue|activity|quality|development|compliance|client_satisfaction`',
    `goal_description` STRING COMMENT 'Detailed narrative description of the performance goal, including context, expectations, and success criteria.',
    `goal_status` STRING COMMENT 'Current lifecycle status of the performance goal: draft (being defined), active (in progress), completed (measured and closed), cancelled (no longer applicable), on_hold (temporarily suspended).. Valid values are `draft|active|completed|cancelled|on_hold`',
    `goal_title` STRING COMMENT 'Short, descriptive title of the performance goal (e.g., Increase Placements, Improve Submittal Quality).',
    `goal_weight_percentage` DECIMAL(18,2) COMMENT 'The percentage weight of this goal in the employees overall performance rating (e.g., 25.00 means this goal contributes 25% to the total rating). Sum of all goal weights for an employee in a review period should equal 100.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this performance goal record is currently active in the system. True if active, False if archived or soft-deleted.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this goal is mandatory (required for all employees in a role or level) or optional. True if mandatory, False if optional.',
    `is_stretch_goal` BOOLEAN COMMENT 'Indicates whether this is a stretch goal (aspirational, beyond normal expectations). True if stretch goal, False if standard goal.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this performance goal record was last updated or modified.',
    `manager_comments` STRING COMMENT 'Comments or feedback provided by the manager regarding the employees performance on this goal.',
    `measurement_unit` STRING COMMENT 'The unit of measure for the target and actual values (e.g., placements, USD, percentage, days, ratio, count).',
    `progress_notes` STRING COMMENT 'Free-text notes documenting progress, challenges, or updates on this performance goal throughout the review period.',
    `rating_label` STRING COMMENT 'The qualitative performance rating label for this goal: exceeds_expectations, meets_expectations, needs_improvement, unsatisfactory, not_rated.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated`',
    `rating_score` DECIMAL(18,2) COMMENT 'The performance rating score assigned to this goal (e.g., on a scale of 1.00 to 5.00, where 5.00 is exceptional). Null if not yet rated.',
    `source_system` STRING COMMENT 'The name of the source system from which this performance goal record originated (e.g., SAP SuccessFactors, Bullhorn, Manual Entry).',
    `source_system_code` STRING COMMENT 'The unique identifier of this performance goal in the source system (e.g., SAP SuccessFactors Goal ID).',
    `start_date` DATE COMMENT 'The date when this performance goal becomes active and measurement begins.',
    `target_completion_date` DATE COMMENT 'The date by which this performance goal is expected to be achieved or measured.',
    `target_metric` STRING COMMENT 'The specific Key Performance Indicator (KPI) or metric being measured (e.g., Placements per Month, Gross Margin Target, Submittal-to-Hire Ratio, Time to Fill (TTF), Quality of Submission (QoS)).',
    `target_value` DECIMAL(18,2) COMMENT 'The numeric target value the employee is expected to achieve for this goal (e.g., 15 placements, 500000 revenue, 0.25 ratio).',
    CONSTRAINT pk_performance_goal PRIMARY KEY(`performance_goal_id`)
) COMMENT 'Transactional record capturing individual performance goals and OKRs set for an internal employee within a review period. Tracks goal title, goal description, goal category (revenue, activity, quality, development), target metric (e.g., placements per month, gross margin target, submittal-to-hire ratio), target value, actual value, measurement unit, goal weight (percentage of overall rating), goal status (draft, active, completed, cancelled), and alignment to team or company-level objectives. Enables MBO (Management by Objectives) tracking for recruiters and account managers.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`pip_record` (
    `pip_record_id` BIGINT COMMENT 'Unique identifier for the Performance Improvement Plan record. Primary key for the pip_record product.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee (recruiter, account manager, operations staff) who is subject to this Performance Improvement Plan.',
    `quaternary_pip_created_by_user_staff_profile_id` BIGINT COMMENT 'System user ID of the HR professional or manager who created this PIP record. Used for audit trail and accountability.',
    `quinary_pip_updated_by_user_staff_profile_id` BIGINT COMMENT 'System user ID of the person who last modified this PIP record. Used for audit trail and change tracking.',
    `tertiary_pip_hrbp_staff_profile_id` BIGINT COMMENT 'Identifier of the HR Business Partner assigned to oversee this PIP, ensure compliance with progressive discipline policies, and provide guidance to the manager.',
    `extended_pip_record_id` BIGINT COMMENT 'Self-referencing FK on pip_record (extended_pip_record_id)',
    `actual_end_date` DATE COMMENT 'The actual date when the PIP was concluded, which may differ from original_end_date if the plan was extended, terminated early, or the employee resigned.',
    `check_in_frequency` STRING COMMENT 'The cadence at which the manager and employee will meet to review progress against PIP targets. More frequent check-ins indicate higher severity or urgency.. Valid values are `daily|weekly|biweekly|monthly`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PIP record was first created in the HR system. Used for audit trail and compliance reporting.',
    `documentation_complete` BOOLEAN COMMENT 'Indicates whether all required PIP documentation is complete and stored in the employees personnel file, including signed acknowledgement, check-in notes, final evaluation, and legal review (if applicable). Critical for audit and litigation defense.',
    `employee_acknowledgement_date` DATE COMMENT 'The date when the employee signed or electronically acknowledged receipt and understanding of the PIP documentation. Critical for legal defensibility.',
    `employee_comments` STRING COMMENT 'Optional comments or rebuttal provided by the employee at the time of PIP acknowledgement. Captures employee perspective for documentation completeness.',
    `extension_count` STRING COMMENT 'Number of times this PIP has been extended beyond the original end date. Multiple extensions may indicate unclear expectations or insufficient support.',
    `final_evaluation_date` DATE COMMENT 'The date when the manager and HRBP conducted the final evaluation of the employees performance against PIP targets and determined the outcome.',
    `final_evaluation_summary` STRING COMMENT 'Detailed summary of the final evaluation, documenting whether each measurable target was met, partially met, or not met, and the rationale for the pip_outcome decision.',
    `improvement_areas` STRING COMMENT 'Detailed description of the specific performance deficiencies, behavioral issues, or skill gaps that triggered the PIP. May include metrics such as low placement rates, client complaints, missed KPIs, or policy violations.',
    `legal_review_conducted` BOOLEAN COMMENT 'Indicates whether the PIP documentation and process were reviewed by legal counsel to mitigate wrongful termination risk. Critical for high-risk terminations or employees in protected classes.',
    `legal_review_date` DATE COMMENT 'The date when legal counsel completed their review of the PIP documentation and termination risk assessment. Null if legal_review_conducted is false.',
    `measurable_targets` STRING COMMENT 'Specific, quantifiable goals the employee must achieve to successfully complete the PIP. Examples: achieve 5 placements per month, reduce client escalations to zero, maintain 95% attendance, complete compliance training by specified date.',
    `original_end_date` DATE COMMENT 'The initially scheduled end date for the PIP period, typically 30, 60, or 90 days from start. This date remains unchanged even if the PIP is extended.',
    `pip_number` STRING COMMENT 'Business identifier for the PIP record, typically formatted as PIP-YYYYNNNNNN for external reference and documentation.. Valid values are `^PIP-[0-9]{6,10}$`',
    `pip_outcome` STRING COMMENT 'Final result of the PIP process. Successfully_completed means employee met all targets and PIP closed favorably; extended means additional time granted; employment_terminated means termination occurred due to failure to meet targets; employee_resigned means voluntary separation during PIP; pip_withdrawn means plan was cancelled (e.g., due to error or changed circumstances).. Valid values are `successfully_completed|extended|employment_terminated|employee_resigned|pip_withdrawn`',
    `pip_status` STRING COMMENT 'Current lifecycle status of the PIP. Active indicates the plan is in progress; successfully_completed means the employee met all targets; extended means the PIP period was lengthened; terminated means employment ended during PIP; resigned means employee voluntarily left during PIP; withdrawn means PIP was cancelled before completion.. Valid values are `active|successfully_completed|extended|terminated|resigned|withdrawn`',
    `pip_type` STRING COMMENT 'The primary category of deficiency being addressed: performance (quality/productivity issues), conduct (behavioral issues), attendance (absenteeism/tardiness), or combination (multiple areas).. Valid values are `performance|conduct|attendance|combination`',
    `prior_action_date` DATE COMMENT 'The date of the most recent prior disciplinary action. Used to establish timeline of progressive discipline and ensure appropriate escalation intervals.',
    `prior_disciplinary_action` STRING COMMENT 'The most recent formal disciplinary action taken before this PIP was issued, demonstrating progressive discipline. None indicates this is the first formal action; prior_pip indicates a repeat PIP scenario.. Valid values are `none|verbal_warning|written_warning|suspension|prior_pip`',
    `protected_class_flag` BOOLEAN COMMENT 'Indicates whether the employee belongs to one or more protected classes under EEOC regulations (race, color, religion, sex, national origin, age 40+, disability, genetic information). Heightens documentation and legal review requirements.',
    `severance_offered` BOOLEAN COMMENT 'Indicates whether a severance package was offered to the employee upon termination. Typically offered in exchange for release of claims to mitigate litigation risk.',
    `start_date` DATE COMMENT 'The date when the Performance Improvement Plan officially begins and the employee is formally notified.',
    `support_resources_provided` STRING COMMENT 'Description of training, coaching, tools, or other resources provided to the employee to help them succeed during the PIP period. Examples: additional training courses, mentorship assignment, access to performance analytics tools.',
    `termination_date` DATE COMMENT 'The date employment was terminated if pip_outcome is employment_terminated. Null for other outcomes. Used for severance calculation and compliance reporting.',
    `termination_risk_level` STRING COMMENT 'HR and legal assessment of wrongful termination litigation risk if employment is terminated following this PIP. Factors include protected class status, prior complaints, documentation quality, and consistency with past practice.. Valid values are `low|medium|high|critical`',
    `unemployment_eligibility` STRING COMMENT 'Companys position on the employees eligibility for unemployment benefits. Ineligible typically applies when termination was for cause (failure to meet PIP targets); contested means the company will challenge any unemployment claim.. Valid values are `eligible|ineligible|contested`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this PIP record was last modified. Tracks changes to status, outcome, dates, or other fields throughout the PIP lifecycle.',
    CONSTRAINT pk_pip_record PRIMARY KEY(`pip_record_id`)
) COMMENT 'Master record for Performance Improvement Plans (PIPs) issued to internal employees who are not meeting performance expectations. Captures PIP start date, PIP end date, improvement areas identified, specific measurable targets required, check-in frequency, PIP outcome (successfully completed, extended, terminated, resigned), HR business partner assigned, and whether legal review was conducted. Critical for HR compliance, documentation of progressive discipline, and wrongful termination risk mitigation in staffing firms.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request record. Primary key.',
    `accrual_policy_id` BIGINT COMMENT 'Identifier of the leave accrual policy governing this leave type for the employee. Links to the accrual policy master record defining accrual rates, carryover rules, and caps.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee submitting the leave request. Links to the employee master record.',
    `amended_leave_request_id` BIGINT COMMENT 'Self-referencing FK on leave_request (amended_leave_request_id)',
    `actual_days_taken` DECIMAL(18,2) COMMENT 'Actual number of leave days taken by the employee, recorded after the leave concludes. May differ from total_days_requested if the employee returned early or extended the leave.',
    `actual_hours_taken` DECIMAL(18,2) COMMENT 'Actual number of leave hours taken by the employee, recorded after the leave concludes. Used for hourly tracking and intermittent leave reconciliation.',
    `approval_date` DATE COMMENT 'Date on which the leave request was approved or denied by the manager. Null if still pending or withdrawn.',
    `balance_after_leave` DECIMAL(18,2) COMMENT 'Employees remaining leave balance (in days or hours) after this leave is taken. Calculated as balance_before_leave minus actual leave taken.',
    `balance_before_leave` DECIMAL(18,2) COMMENT 'Employees available leave balance (in days or hours, depending on accrual policy) immediately before this leave request was approved. Used for tracking accrual consumption.',
    `benefits_continuation_flag` BOOLEAN COMMENT 'Indicates whether employee benefits (health insurance, retirement contributions) continue during this leave (True) or are suspended (False). Typically True for FMLA and paid leave, False for extended unpaid leave.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leave request record was first created in the system. Audit trail for record creation.',
    `denial_reason` STRING COMMENT 'Free-text explanation provided by the manager for denying the leave request. Null if approved or pending.',
    `documentation_received_date` DATE COMMENT 'Date on which required supporting documentation (e.g., medical certificate, FMLA certification) was received by HR. Null if documentation not yet received or not required.',
    `documentation_status` STRING COMMENT 'Status of required supporting documentation. Not_required if no documentation needed, pending if awaiting submission, received if submitted and under review, approved if documentation accepted, rejected if documentation insufficient.. Valid values are `not_required|pending|received|approved|rejected`',
    `employee_comments` STRING COMMENT 'Optional free-text comments or notes provided by the employee when submitting the leave request, such as reason for leave or special circumstances.',
    `fmla_case_number` STRING COMMENT 'Unique case number assigned to FMLA-eligible leave requests for tracking and compliance reporting. Null for non-FMLA leave.',
    `fmla_hours_used_ytd` DECIMAL(18,2) COMMENT 'Cumulative FMLA hours used by the employee in the current 12-month FMLA eligibility period, including this leave request. Used to track the 480-hour (12-week) FMLA entitlement cap.',
    `is_fmla_eligible` BOOLEAN COMMENT 'Flag indicating whether this leave request qualifies for FMLA protection based on employee tenure, hours worked, and reason for leave. True if FMLA-eligible.',
    `is_intermittent_leave` BOOLEAN COMMENT 'Indicates whether this is an intermittent leave request (True), allowing the employee to take leave in separate blocks of time or on a reduced schedule, versus a continuous block of leave (False).',
    `is_paid_leave` BOOLEAN COMMENT 'Indicates whether the leave request is for paid time off (True) or unpaid leave (False). Determines payroll impact and benefit accrual continuation.',
    `is_reduced_schedule` BOOLEAN COMMENT 'Indicates whether the leave involves a reduced work schedule (True), where the employee works fewer hours per day or week, versus full-day absences (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this leave request record was last updated in the system. Audit trail for record modification.',
    `leave_end_date` DATE COMMENT 'Last calendar date of the requested leave period. Employee is expected to return to work the following business day.',
    `leave_start_date` DATE COMMENT 'First calendar date of the requested leave period. Employee is expected to be absent starting this date.',
    `leave_subtype` STRING COMMENT 'Optional granular classification within the leave type (e.g., maternity, paternity, adoption under parental; personal illness vs family care under FMLA).',
    `leave_type` STRING COMMENT 'Category of leave being requested. PTO (Paid Time Off), sick leave, FMLA (Family and Medical Leave Act), parental leave, bereavement, jury duty, military leave, unpaid leave, or sabbatical. [ENUM-REF-CANDIDATE: PTO|sick|FMLA|parental|bereavement|jury_duty|military|unpaid|sabbatical — 9 candidates stripped; promote to reference product]',
    `manager_comments` STRING COMMENT 'Optional free-text comments or notes provided by the approving manager during the review process, such as approval conditions or denial rationale.',
    `payroll_impact_flag` BOOLEAN COMMENT 'Indicates whether this leave request impacts payroll processing (True), such as unpaid leave reducing gross pay or paid leave consuming accrued balance, versus no payroll impact (False).',
    `request_date` DATE COMMENT 'Date on which the employee submitted the leave request. Used for tracking request lead time and compliance with advance notice policies.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the leave request, typically auto-generated and used for tracking and reference in HR systems and communications.',
    `request_status` STRING COMMENT 'Current approval status of the leave request in the workflow. Pending indicates awaiting manager review, approved indicates manager approval granted, denied indicates request rejected, cancelled indicates system or admin cancellation, withdrawn indicates employee retracted the request.. Valid values are `pending|approved|denied|cancelled|withdrawn`',
    `requires_documentation` BOOLEAN COMMENT 'Indicates whether this leave request requires supporting documentation (True), such as a medical certificate for sick leave or FMLA certification, versus no documentation required (False).',
    `return_to_work_date` DATE COMMENT 'Actual date the employee returned to work following the leave. May differ from the planned leave end date if leave was extended or employee returned early. Null if leave has not yet concluded.',
    `source_system` STRING COMMENT 'Name of the operational system from which this leave request record originated, such as SAP SuccessFactors, Kronos, or internal HRIS.',
    `source_system_code` STRING COMMENT 'Unique identifier of this leave request record in the source system. Used for data lineage, reconciliation, and troubleshooting.',
    `total_days_requested` DECIMAL(18,2) COMMENT 'Total number of leave days requested, calculated as business days or calendar days depending on company policy. May include fractional days for partial-day leave.',
    `total_hours_requested` DECIMAL(18,2) COMMENT 'Total number of leave hours requested, used for hourly tracking and intermittent leave scenarios. Supports partial-day and hourly leave increments.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Transactional record for all internal employee leave requests and approved leave events. Captures leave type (PTO, sick, FMLA, parental, bereavement, jury duty, military, unpaid), request date, leave start date, leave end date, total days requested, approval status (pending, approved, denied, cancelled), approving manager, FMLA eligibility flag, intermittent leave flag, and return-to-work date. Distinct from timesheet.absence_record (which tracks contingent worker absences) — this entity owns internal staff leave management.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment record. Primary key for the benefit enrollment entity.',
    `benefit_plan_id` BIGINT COMMENT 'Identifier of the benefit plan in which the employee is enrolled. Links to the benefit plan master record.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee enrolling in the benefit plan. Links to the employee master record.',
    `prior_benefit_enrollment_id` BIGINT COMMENT 'Self-referencing FK on benefit_enrollment (prior_benefit_enrollment_id)',
    `approved_date` DATE COMMENT 'Date on which the enrollment was approved by HR or benefits administration. Null if pending or auto-approved.',
    `beneficiary_name` STRING COMMENT 'Name of the primary beneficiary designated by the employee for life insurance or retirement plans. Null if not applicable or not yet designated.',
    `beneficiary_percentage` DECIMAL(18,2) COMMENT 'Percentage of benefit proceeds allocated to the primary beneficiary (0.00 to 100.00). Null if not applicable.',
    `beneficiary_relationship` STRING COMMENT 'Relationship of the beneficiary to the employee (e.g., Spouse, Child, Parent, Other). Null if not applicable.',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or benefits provider administering the plan (e.g., Blue Cross Blue Shield, Fidelity, MetLife).',
    `cobra_election_deadline` DATE COMMENT 'Deadline by which the employee must elect COBRA continuation coverage. Null if not COBRA eligible or coverage is active.',
    `cobra_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for COBRA continuation coverage upon termination of this enrollment. True if eligible, False otherwise.',
    `confirmation_date` DATE COMMENT 'Date on which the enrollment was confirmed by the carrier or benefits administrator. Null if still pending.',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are deducted or paid. Values: weekly, biweekly, semimonthly, monthly, annual.. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Face value or coverage limit of the benefit (e.g., life insurance coverage amount, disability benefit maximum), in USD. Null for plans without a fixed coverage amount.',
    `coverage_tier` STRING COMMENT 'Level of coverage elected by the employee. Values: employee_only, employee_spouse, employee_children, family (employee + spouse + children), employee_domestic_partner.. Valid values are `employee_only|employee_spouse|employee_children|family|employee_domestic_partner`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the data platform.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the employee must pay before the plan begins to pay benefits, in USD. Applicable to medical, dental, vision plans. Null if not applicable.',
    `dependent_count` STRING COMMENT 'Number of dependents covered under this enrollment (spouse, children, domestic partner). Zero if employee_only coverage.',
    `election_date` DATE COMMENT 'Date on which the employee made the enrollment election or submitted the enrollment form.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Amount the employee contributes per pay period toward the benefit premium or plan cost, in USD. Pre-tax or post-tax depending on plan design.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Amount the employer contributes per pay period toward the benefit premium or plan cost, in USD.',
    `enrollment_effective_date` DATE COMMENT 'Date on which the benefit coverage becomes effective and the employee is covered under the plan.',
    `enrollment_method` STRING COMMENT 'Method or channel through which the employee completed the enrollment. Values: online_portal, paper_form, phone, benefits_fair, auto_enrollment, hr_system.. Valid values are `online_portal|paper_form|phone|benefits_fair|auto_enrollment|hr_system`',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment confirmation number or certificate number assigned by the benefits system or carrier.',
    `enrollment_source` STRING COMMENT 'Event or process that triggered the enrollment. Values: open_enrollment (annual election period), new_hire (initial eligibility), qualifying_life_event (QLE such as marriage, birth, loss of other coverage), annual_renewal (automatic continuation), rehire, status_change (e.g., part-time to full-time).. Valid values are `open_enrollment|new_hire|qualifying_life_event|annual_renewal|rehire|status_change`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment. Values: active (coverage in force), pending (awaiting carrier confirmation), terminated (coverage ended), suspended (temporarily paused), waived (employee declined coverage), cancelled (enrollment voided).. Valid values are `active|pending|terminated|suspended|waived|cancelled`',
    `enrollment_termination_date` DATE COMMENT 'Date on which the benefit coverage ends. Null if coverage is currently active or has no scheduled end date.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this enrollment record is currently active and valid. True if active, False if superseded or logically deleted.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last updated in the data platform.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the enrollment, such as special circumstances, documentation requirements, or follow-up actions.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount the employee will pay out-of-pocket in a plan year before the plan covers 100% of costs, in USD. Applicable to medical plans. Null if not applicable.',
    `plan_name` STRING COMMENT 'Full name of the benefit plan as presented to employees (e.g., PPO Gold Plan, Basic Life Insurance, Traditional 401k).',
    `plan_type` STRING COMMENT 'Category of benefit plan. Values: medical (health insurance), dental, vision, life_insurance, std (Short-Term Disability), ltd (Long-Term Disability), 401k (retirement savings), hsa (Health Savings Account), fsa (Flexible Spending Account), eap (Employee Assistance Program), other. [ENUM-REF-CANDIDATE: medical|dental|vision|life_insurance|std|ltd|401k|hsa|fsa|eap|other — 11 candidates stripped; promote to reference product]',
    `policy_number` STRING COMMENT 'Master policy or group policy number under which the employee is covered. Issued by the carrier.',
    `qualifying_event_date` DATE COMMENT 'Date on which the qualifying life event occurred. Used to validate enrollment timing and eligibility. Null if not applicable.',
    `qualifying_event_type` STRING COMMENT 'Specific type of qualifying life event if enrollment_source is qualifying_life_event (e.g., Marriage, Birth of Child, Loss of Other Coverage, Divorce). Null if not applicable.',
    `source_system` STRING COMMENT 'Name of the source system from which this enrollment record originated (e.g., SAP SuccessFactors, TempWorks Payroll, Benefits Portal).',
    `source_system_code` STRING COMMENT 'Unique identifier of this enrollment record in the source system. Used for traceability and reconciliation.',
    `termination_reason` STRING COMMENT 'Reason for termination of the enrollment (e.g., Employment termination, Employee request, Loss of eligibility, COBRA conversion, Retirement). Null if coverage is active.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Total premium cost per pay period for the benefit plan (employee contribution + employer contribution), in USD.',
    `waiver_reason` STRING COMMENT 'Reason provided by the employee for waiving or declining coverage (e.g., Covered under spouse plan, Cost, Not needed). Null if coverage was not waived.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Master record capturing an internal employees enrollment in company-sponsored benefit plans. Tracks benefit plan type (medical, dental, vision, life insurance, STD, LTD, 401k, HSA, FSA, EAP), plan name, carrier name, coverage tier (employee only, employee + spouse, employee + children, family), enrollment effective date, termination date, employee contribution amount, employer contribution amount, enrollment source (open enrollment, new hire, qualifying life event), and dependent count. SSOT for internal employee benefits — distinct from any contingent worker benefit arrangements.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`org_change_event` (
    `org_change_event_id` BIGINT COMMENT 'Unique identifier for the organizational change event. Primary key for this immutable transactional record.',
    `department_id` BIGINT COMMENT 'Identifier of the department the employee belonged to before this change event. Null if the change did not involve a department change.',
    `office_location_id` BIGINT COMMENT 'Identifier of the office location where the employee was based before this change event. Null if the change did not involve a location change.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee who experienced this organizational change event.',
    `quaternary_org_initiating_manager_staff_profile_id` BIGINT COMMENT 'Employee identifier of the manager who initiated or requested this organizational change event.',
    `quinary_org_hr_approver_staff_profile_id` BIGINT COMMENT 'Employee identifier of the HR representative who approved this organizational change event.',
    `tertiary_org_new_manager_staff_profile_id` BIGINT COMMENT 'Employee identifier of the manager who supervises this employee after this change event. Null if the change did not involve a manager change.',
    `reversal_org_change_event_id` BIGINT COMMENT 'Self-referencing FK on org_change_event (reversal_org_change_event_id)',
    `approval_date` DATE COMMENT 'Date on which the organizational change event was formally approved by HR or authorized personnel.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the organizational change. Examples include performance-based promotion, restructuring, backfill, voluntary transfer, or termination reason codes. [ENUM-REF-CANDIDATE: performance_promotion|restructuring|backfill|voluntary_transfer|involuntary_termination|retirement|resignation|position_elimination|merger_acquisition|skill_development|succession_planning — promote to reference product]',
    `change_reason_description` STRING COMMENT 'Free-text description providing additional context or details about the reason for the organizational change.',
    `changed_attribute_name` STRING COMMENT 'Name of the organizational attribute that was changed in this event. Examples: job_title, department_id, manager_id, employment_type, office_location_id, cost_center_code.',
    `comments` STRING COMMENT 'Free-text comments or notes recorded by HR or management regarding this organizational change event.',
    `compensation_change_triggered_flag` BOOLEAN COMMENT 'Indicates whether this organizational change event triggered a compensation adjustment. True if a compensation change was initiated as a result of this event, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational change event record was first created in the data lakehouse. Audit field for data lineage.',
    `event_effective_date` DATE COMMENT 'The date on which this organizational change became effective. This is the business event date, distinct from the record creation timestamp.',
    `event_status` STRING COMMENT 'Current status of the organizational change event in its lifecycle. Tracks whether the event is pending approval, approved, effective, cancelled, or reversed.. Valid values are `pending|approved|effective|cancelled|reversed`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the organizational change event was recorded in the system.',
    `event_type` STRING COMMENT 'Type of organizational change event. Categorizes the nature of the change in the employees organizational position or attributes.. Valid values are `promotion|demotion|lateral_transfer|department_change|manager_change|title_change`',
    `is_termination_event` BOOLEAN COMMENT 'Indicates whether this organizational change event represents an employee termination. True if this is a termination event, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational change event record was last modified in the data lakehouse. Audit field for data lineage.',
    `last_working_date` DATE COMMENT 'The final date the employee physically worked if this is a termination event. Null if not a termination event.',
    `new_cost_center_code` STRING COMMENT 'The cost center code assigned to the employee after this organizational change event. Null if the change did not involve a cost center change.',
    `new_employment_type` STRING COMMENT 'The employment type classification after this change event. Null if the change did not involve an employment type change.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `new_job_title` STRING COMMENT 'The job title assigned to the employee as a result of this organizational change event. Null if the change did not involve a title change.',
    `new_value` DECIMAL(18,2) COMMENT 'The value of the changed attribute after this event. For example, new job title, new department ID, new manager ID, or new employment type. Stored as string to accommodate various data types.',
    `prior_cost_center_code` STRING COMMENT 'The cost center code assigned to the employee before this organizational change event. Null if the change did not involve a cost center change.',
    `prior_employment_type` STRING COMMENT 'The employment type classification before this change event. Null if the change did not involve an employment type change.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `prior_job_title` STRING COMMENT 'The job title held by the employee before this organizational change event. Null if the change did not involve a title change.',
    `prior_value` DECIMAL(18,2) COMMENT 'The value of the changed attribute before this event. For example, prior job title, prior department ID, prior manager ID, or prior employment type. Stored as string to accommodate various data types.',
    `rehire_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire if this is a termination event. True if eligible, False if not eligible, Null if not a termination event.',
    `source_system` STRING COMMENT 'Name of the source system from which this organizational change event record originated. Typically SAP SuccessFactors or the primary HRIS.',
    `source_system_event_reference` STRING COMMENT 'Unique identifier of this organizational change event in the source system. Used for reconciliation and audit trail purposes.',
    `termination_type` STRING COMMENT 'Classification of the termination type if this event represents an employee termination. Null if not a termination event.. Valid values are `voluntary|involuntary|retirement|end_of_contract`',
    `workflow_instance_reference` STRING COMMENT 'Identifier of the workflow instance in the source HRIS system that processed this organizational change event.',
    CONSTRAINT pk_org_change_event PRIMARY KEY(`org_change_event_id`)
) COMMENT 'Immutable transactional record capturing every organizational change event in an internal employees lifecycle — promotions, demotions, lateral transfers, department changes, manager changes, title changes, location changes, employment type changes, and terminations. Captures event type, effective date, prior value, new value, change reason code, initiating manager, HR approver, and whether the change triggered a compensation adjustment. Serves as the authoritative audit trail for employee lifecycle changes, supporting HRIS reconciliation and compliance reporting.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` (
    `recruiter_desk_id` BIGINT COMMENT 'Unique identifier for the recruiter desk configuration. Primary key.',
    `commission_plan_id` BIGINT COMMENT 'Identifier of the commission or incentive plan applicable to recruiters on this desk.',
    `client_account_id` BIGINT COMMENT 'For client-dedicated desks, the identifier of the single client account this desk exclusively serves.',
    `office_location_id` BIGINT COMMENT 'Identifier of the branch office or location where this desk is physically or logically based.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the secondary/backup recruiter who can cover this desk during absences or overflow periods.',
    `quaternary_recruiter_modified_by_employee_staff_profile_id` BIGINT COMMENT 'Identifier of the employee who last modified this desk configuration record.',
    `team_id` BIGINT COMMENT 'Identifier of the recruiting team this desk belongs to, enabling team-level aggregation and management.',
    `tertiary_recruiter_created_by_employee_staff_profile_id` BIGINT COMMENT 'Identifier of the employee who created this desk configuration record.',
    `vms_program_id` BIGINT COMMENT 'Identifier of the VMS program this desk participates in, if applicable. Links to vendor management system configurations.',
    `parent_recruiter_desk_id` BIGINT COMMENT 'Self-referencing FK on recruiter_desk (parent_recruiter_desk_id)',
    `annual_placement_target` STRING COMMENT 'Target number of placements (hires) this desk is expected to achieve annually, used for performance measurement.',
    `annual_revenue_target` DECIMAL(18,2) COMMENT 'Target annual revenue in USD this desk is expected to generate through placements and billings.',
    `ats_instance` STRING COMMENT 'Name or identifier of the ATS instance this desk uses for candidate management and job order tracking (e.g., Bullhorn Production, Bullhorn Vertical A).',
    `client_portfolio_size` STRING COMMENT 'Number of active client accounts assigned to this desk for relationship management and job order fulfillment.',
    `collaboration_model` STRING COMMENT 'Organizational collaboration model for this desk: individual (solo recruiter), pod (small group), team-based (full team), or matrix (cross-functional).. Valid values are `individual|pod|team_based|matrix`',
    `cost_center_code` STRING COMMENT 'Financial cost center code for budgeting and expense allocation for this desk.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this desk record was first created in the system.',
    `current_headcount` STRING COMMENT 'Current number of recruiters or staff actively assigned to this desk.',
    `desk_close_date` DATE COMMENT 'Date when this desk was closed or discontinued, if applicable. Null for active desks.',
    `desk_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the desk for operational reference and reporting.',
    `desk_name` STRING COMMENT 'Business name of the recruiter desk (e.g., Healthcare IT - Northeast, Finance Vertical Desk, Client-Dedicated: Acme Corp).',
    `desk_open_date` DATE COMMENT 'Date when this desk configuration was established and became operational.',
    `desk_status` STRING COMMENT 'Current operational status of the desk: active (fully operational), inactive (temporarily paused), suspended (on hold), ramping (new desk in startup phase), closed (permanently discontinued).. Valid values are `active|inactive|suspended|ramping|closed`',
    `desk_type` STRING COMMENT 'Classification of the desk configuration: vertical-specific (industry focus), geography-specific (regional focus), client-dedicated (single client portfolio), generalist (broad coverage), or hybrid (combination).. Valid values are `vertical_specific|geography_specific|client_dedicated|generalist|hybrid`',
    `geographic_territory` STRING COMMENT 'Geographic region, state, metro area, or territory this desk covers (e.g., Northeast US, California, Greater Boston Area).',
    `job_categories_covered` STRING COMMENT 'Comma-separated list of job categories or skill families this desk is responsible for filling (e.g., Software Engineer, Data Analyst, DevOps Engineer).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this desk record was last modified.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special instructions, or operational details about this desk configuration.',
    `nps_target` STRING COMMENT 'Target Net Promoter Score for client satisfaction on this desk, typically ranging from -100 to +100.',
    `primary_vertical` STRING COMMENT 'Primary industry vertical or sector this desk specializes in (e.g., Healthcare, IT, Finance, Manufacturing, Engineering).',
    `qos_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage of candidate submittals that result in client interviews, measuring submission quality.',
    `req_routing_priority` STRING COMMENT 'Priority level for automatic job requisition routing to this desk (higher number = higher priority). Used in ATS routing logic.',
    `secondary_vertical` STRING COMMENT 'Secondary industry vertical this desk may cover, enabling cross-vertical flexibility.',
    `sla_tier` STRING COMMENT 'Service level tier this desk operates under, defining response times, quality standards, and client expectations.. Valid values are `standard|premium|enterprise|strategic`',
    `specialization_tags` STRING COMMENT 'Comma-separated tags describing desk specializations, skills, or focus areas for advanced routing and analytics (e.g., remote_work, executive_search, contract_to_hire).',
    `target_headcount` STRING COMMENT 'Target number of recruiters or staff assigned to this desk at full capacity.',
    `target_industries` STRING COMMENT 'Comma-separated list of target industries this desk focuses on for client acquisition and candidate sourcing.',
    `ttf_target_days` STRING COMMENT 'Target average number of days from job order receipt to candidate placement for this desk, a key SLA metric.',
    `work_arrangement` STRING COMMENT 'Primary work arrangement model for recruiters on this desk: on-site (office-based), remote (fully remote), or hybrid (combination).. Valid values are `on_site|remote|hybrid`',
    CONSTRAINT pk_recruiter_desk PRIMARY KEY(`recruiter_desk_id`)
) COMMENT 'Master record defining a recruiters operational desk configuration — the specific vertical, geography, job category, or client portfolio a recruiter is responsible for filling. Captures desk name, desk type (vertical-specific, geography-specific, client-dedicated, generalist), assigned recruiter, primary job categories covered, target industries, geographic territory, associated client accounts, desk open date, and active status. Enables recruiter workload management, req routing logic, and desk-level performance attribution in TempWorks and ATS systems.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` (
    `territory_assignment_id` BIGINT COMMENT 'Unique identifier for the territory assignment record. Primary key for the territory assignment entity.',
    `commission_plan_id` BIGINT COMMENT 'Identifier of the commission plan applicable to this territory assignment. Links to the commission plan master defining payout rates, accelerators, and thresholds.',
    `office_location_id` BIGINT COMMENT 'Identifier of the branch office or location to which this territory assignment is aligned. Links to the office location master record. Used for geographic reporting and operational coordination.',
    `primary_predecessor_assignment_territory_assignment_id` BIGINT COMMENT 'Identifier of the previous territory assignment record that this assignment replaces or succeeds. Used for tracking territory transition history and ensuring continuity in account ownership.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee (account manager, business development representative, or recruiter) assigned to this territory. Links to the employee master record.',
    `territory_id` BIGINT COMMENT 'Identifier of the territory being assigned. Links to the territory master record defining geographic boundaries, industry verticals, or named account portfolios.',
    `tertiary_territory_approved_by_employee_staff_profile_id` BIGINT COMMENT 'Identifier of the employee who approved this territory assignment. Links to the employee master record. Supports audit trail and governance requirements.',
    `vms_program_id` BIGINT COMMENT 'Identifier of the Vendor Management System (VMS) program associated with this territory, if applicable. Links to the VMS program master record. Relevant for territories serving Managed Service Provider (MSP) clients.',
    `prior_territory_assignment_id` BIGINT COMMENT 'Self-referencing FK on territory_assignment (prior_territory_assignment_id)',
    `account_segment` STRING COMMENT 'Client account segment targeted by this territory assignment (e.g., enterprise, mid-market, small business). Aligns territory assignments with account segmentation strategy.. Valid values are `enterprise|mid_market|smb|strategic|emerging`',
    `approved_date` DATE COMMENT 'Date when this territory assignment was formally approved. Used for audit trail and compliance tracking.',
    `assignment_reason` STRING COMMENT 'Business reason for creating this territory assignment. Supports workforce planning analysis and territory optimization initiatives. [ENUM-REF-CANDIDATE: new_hire|promotion|territory_realignment|performance|coverage|backfill|expansion|consolidation|other — 9 candidates stripped; promote to reference product]',
    `assignment_role` STRING COMMENT 'Role of the employee in this territory assignment. Primary indicates sole ownership; secondary indicates support role; backup indicates coverage during absence; split indicates shared ownership with commission split; overlay indicates specialized support (e.g., technical overlay).. Valid values are `primary|secondary|backup|split|overlay`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the territory assignment. Active assignments are operational; pending assignments are approved but not yet effective; suspended assignments are temporarily paused; expired assignments have passed their end date; transferred assignments have been reassigned to another employee.. Valid values are `active|inactive|pending|suspended|expired|transferred`',
    `cost_center_code` STRING COMMENT 'Cost center code for financial tracking and reporting of expenses related to this territory assignment. Used for budget allocation and profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date when the territory assignment ends or is scheduled to end. Null indicates an open-ended assignment. Used for territory transition planning and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when the territory assignment becomes active and the employee assumes responsibility for the territory. Used for temporal tracking and commission attribution.',
    `geographic_scope` STRING COMMENT 'Textual description of the geographic boundaries of the territory (e.g., New York, New Jersey, Connecticut, Western United States, EMEA Region). Provides human-readable context for geographic territory types.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether this territory assignment is exclusive to the assigned employee. True means the employee has sole rights to the territory; False means the territory may be shared with other employees or overlapping assignments exist.',
    `is_remote_territory` BOOLEAN COMMENT 'Indicates whether this territory is managed remotely without a physical office presence. True for remote territories; False for office-based territories. Supports remote work arrangements and distributed workforce models.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory assignment record was last modified. Used for audit trail, change tracking, and data synchronization.',
    `named_accounts_count` STRING COMMENT 'Number of named client accounts included in this territory assignment. Applicable for named account territory types. Used for workload balancing and capacity planning.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this territory assignment. Captures context, special instructions, or business rationale not covered by structured fields.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of territory ownership allocated to this employee, used for commission attribution and quota allocation in split or shared territory scenarios. Value ranges from 0.00 to 100.00. For exclusive assignments, this is typically 100.00.',
    `performance_tier` STRING COMMENT 'Performance classification of the territory based on historical revenue, placement volume, or strategic value. Used for territory prioritization and resource allocation decisions.. Valid values are `platinum|gold|silver|bronze|developing`',
    `priority_level` STRING COMMENT 'Strategic priority level of this territory assignment. High-priority territories typically have larger revenue potential or strategic client relationships requiring focused attention.. Valid values are `high|medium|low|strategic|tactical`',
    `quota_amount` DECIMAL(18,2) COMMENT 'Revenue or placement quota assigned to the employee for this territory during the assignment period. Used for performance measurement and commission calculation. Expressed in the companys reporting currency.',
    `quota_period` STRING COMMENT 'Time period over which the quota amount is measured (e.g., annual, quarterly). Aligns with the companys sales performance measurement cycles.. Valid values are `annual|quarterly|monthly|semi_annual`',
    `service_level_agreement_tier` STRING COMMENT 'Service Level Agreement (SLA) tier applicable to clients within this territory. Defines expected response times, Time to Fill (TTF), and service quality commitments.. Valid values are `premium|standard|basic`',
    `source_system` STRING COMMENT 'Name of the source system from which this territory assignment record originated (e.g., Salesforce, SAP SuccessFactors, Bullhorn). Used for data lineage and integration troubleshooting.',
    `source_system_code` STRING COMMENT 'Unique identifier of this territory assignment record in the source system. Used for data reconciliation and bidirectional synchronization.',
    `specialization_tags` STRING COMMENT 'Comma-separated list of specialization tags or skill requirements for this territory (e.g., IT Staffing, Executive Search, Healthcare Credentialing, RPO). Used for matching employee expertise to territory requirements.',
    `target_headcount` STRING COMMENT 'Target number of placements or Full-Time Equivalent (FTE) assignments expected from this territory during the assignment period. Used for workforce planning and performance measurement.',
    `transition_notes` STRING COMMENT 'Free-text notes documenting territory transition details, handoff instructions, client relationship context, or special considerations for the assigned employee. Supports knowledge transfer during territory reassignments.',
    `vertical_focus` STRING COMMENT 'Industry vertical or sector focus of the territory (e.g., Healthcare, Financial Services, Technology, Manufacturing). Applicable for vertical territory types. Supports industry specialization and targeted business development.',
    CONSTRAINT pk_territory_assignment PRIMARY KEY(`territory_assignment_id`)
) COMMENT 'Transactional record capturing the assignment of a geographic territory, industry vertical, or named account portfolio to an internal account manager or business development representative. Tracks territory name, territory type (geographic, vertical, named account), assigned employee, effective start date, effective end date, assignment status, and whether the territory is exclusive. Supports sales territory management, account ownership routing, and commission attribution for account managers in staffing firms.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`internal_training` (
    `internal_training_id` BIGINT COMMENT 'Unique identifier for the internal training program. Primary key for the internal training master record.',
    `credential_id` BIGINT COMMENT 'Foreign key linking to credentialing.credential. Business justification: Internal training courses often fulfill specific credential requirements (e.g., OSHA safety training, compliance certifications). Linking training to credentials enables automated compliance tracking,',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee who created this training record in the system. Typically an HR or Learning & Development team member.',
    `prerequisite_internal_training_id` BIGINT COMMENT 'Self-referencing FK on internal_training (prerequisite_internal_training_id)',
    `applicable_job_families` STRING COMMENT 'Comma-separated list of job families or roles for which this training is applicable or required. Examples: recruiter, account_manager, operations_staff, leadership, all_employees. Used to determine training assignment eligibility.',
    `assessment_required` BOOLEAN COMMENT 'Indicates whether employees must pass an assessment or exam to complete this training. True for compliance and certification training, False for informational or awareness training.',
    `certification_awarded` STRING COMMENT 'Name of the certification, credential, or certificate awarded upon successful completion of this training. Null if no formal certification is provided. Examples: EEOC Compliance Certificate, Leadership Development Certificate, ATS Power User Certification.',
    `competency_category` STRING COMMENT 'Primary competency area addressed by this training. Technical for ATS/VMS/CRM system skills, behavioral for soft skills and communication, leadership for management capabilities, compliance for regulatory knowledge, sales for business development and client relationship skills, operational for process and workflow proficiency.. Valid values are `technical|behavioral|leadership|compliance|sales|operational`',
    `compliance_framework` STRING COMMENT 'Regulatory framework or standard that this training addresses. Examples: EEOC, OFCCP, OSHA, FLSA, FCRA, GDPR, CCPA, SOC 2, I-9 Compliance. Null for non-compliance training. Used for audit trail and regulatory reporting.',
    `content_url` STRING COMMENT 'Web URL or LMS link to access the training content, course materials, or enrollment page. Used for employee self-service access and manager assignment workflows.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Cost in USD per employee to deliver this training. Includes vendor fees, materials, instructor time, and facility costs. Used for training budget planning and ROI analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this training record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per participant. Typically USD for US-based Staffing Hr operations.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Method by which the training is delivered to employees. In-person for classroom sessions, virtual for live online sessions, LMS for self-paced e-learning modules, on-the-job for hands-on mentoring, blended for combination of methods.. Valid values are `in_person|virtual|lms|on_the_job|blended`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training program measured in hours. Used for scheduling, capacity planning, and compliance reporting. Includes all instructional time and assessments.',
    `effective_end_date` DATE COMMENT 'Date when this training program is no longer available for new enrollments. Null for ongoing programs. Used for course lifecycle management and historical reporting.',
    `effective_start_date` DATE COMMENT 'Date when this training program becomes available for employee enrollment and assignment. Used for course catalog management and compliance tracking.',
    `instructor_name` STRING COMMENT 'Name of the primary instructor or facilitator for this training program. Null for self-paced LMS courses. May be internal employee or external vendor trainer.',
    `internal_training_status` STRING COMMENT 'Current lifecycle status of the training program. Active for available courses, inactive for temporarily unavailable, draft for courses under development, retired for discontinued courses, under review for courses being updated or audited.. Valid values are `active|inactive|draft|retired|under_review`',
    `is_required` BOOLEAN COMMENT 'Indicates whether the training is mandatory or elective for applicable employees. True for required training (compliance, onboarding, safety), False for optional professional development courses.',
    `language` STRING COMMENT 'Three-letter ISO 639-2 language code for the primary language of the training content. Examples: ENG for English, SPA for Spanish. Used for multilingual workforce support.. Valid values are `^[A-Z]{3}$`',
    `last_content_update_date` DATE COMMENT 'Date when the training content was last revised or updated. Used to track content freshness and trigger recertification requirements for employees who completed earlier versions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this training record was last updated in the system. Used for audit trail and change management.',
    `learning_objectives` STRING COMMENT 'Detailed description of the knowledge, skills, and competencies employees will gain upon completion of this training. Used for course catalog descriptions and learning path planning.',
    `materials_description` STRING COMMENT 'Description of training materials provided to participants, such as workbooks, handouts, videos, job aids, or reference guides. Used for logistics planning and participant preparation.',
    `max_participants` STRING COMMENT 'Maximum number of employees who can participate in a single session of this training. Used for scheduling and capacity planning. Null for self-paced LMS courses with unlimited capacity.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required to pass the training assessment. Null if no assessment is required. Typically 70-80% for compliance training, 85-90% for safety training.',
    `prerequisites` STRING COMMENT 'Description of any prerequisite training courses, certifications, or experience required before an employee can enroll in this training. Null if no prerequisites exist.',
    `provider_name` STRING COMMENT 'Name of the organization or vendor providing the training content. Examples include internal department name, external training company, or industry association name.',
    `provider_type` STRING COMMENT 'Source or provider of the training content. Internal for in-house developed training by HR or L&D team, external vendor for third-party training companies, LMS platform for content from SAP SuccessFactors or other learning systems, industry association for ASA or SIA provided training.. Valid values are `internal|external_vendor|lms_platform|industry_association`',
    `recertification_frequency_months` STRING COMMENT 'Number of months after which employees must retake or recertify this training. Null if no recertification is required. Common for compliance training (12 months for OSHA, EEOC) and safety training.',
    `short_name` STRING COMMENT 'Abbreviated or shortened name of the training program for display in dashboards, reports, and mobile interfaces.',
    `target_audience_description` STRING COMMENT 'Detailed description of the intended audience for this training, including job roles, experience levels, and business units. Used for targeted assignment and communication planning.',
    `training_code` STRING COMMENT 'Unique business identifier code for the training program used in LMS and HRIS systems. Typically alphanumeric code assigned by HR or Learning & Development team.. Valid values are `^[A-Z0-9]{4,12}$`',
    `training_name` STRING COMMENT 'Full name of the internal training program or course. Human-readable title used in course catalogs and employee learning portals.',
    `training_type` STRING COMMENT 'Category of training program. Onboarding for new hire orientation, compliance for regulatory requirements (EEOC, OFCCP, FLSA, OSHA), product knowledge for ATS/VMS/CRM systems, sales skills for recruiters and account managers, leadership development for management track, DEI for diversity equity and inclusion, safety for workplace safety protocols. [ENUM-REF-CANDIDATE: onboarding|compliance|product_knowledge|sales_skills|leadership_development|dei|safety — 7 candidates stripped; promote to reference product]',
    `version_number` STRING COMMENT 'Version identifier for the training content. Incremented when training materials are updated to reflect regulatory changes, process updates, or content improvements. Format: major.minor (e.g., 2.1).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_internal_training PRIMARY KEY(`internal_training_id`)
) COMMENT 'Master record for internal training programs, certifications, and professional development courses available to Staffing Hr employees. Captures training name, training type (onboarding, compliance, product knowledge, sales skills, leadership development, DEI, safety), delivery method (in-person, virtual, LMS, on-the-job), duration hours, provider (internal, external vendor, LMS platform), required vs. elective flag, applicable job families, and recertification frequency. Distinct from credentialing.training_record (which tracks contingent worker training completions).';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`training_completion` (
    `training_completion_id` BIGINT COMMENT 'Unique identifier for the training completion record. Primary key for this entity.',
    `internal_training_id` BIGINT COMMENT 'Identifier of the specific training program or course that the employee enrolled in or completed.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee (recruiter, account manager, operations staff) who enrolled in or completed the training program.',
    `retake_training_completion_id` BIGINT COMMENT 'Self-referencing FK on training_completion (retake_training_completion_id)',
    `actual_completion_date` DATE COMMENT 'The actual date on which the employee completed the training program. Null if not yet completed.',
    `assessment_result` STRING COMMENT 'The outcome of the training assessment (pass, fail, not assessed, pending).. Valid values are `pass|fail|not_assessed|pending`',
    `assessment_score` DECIMAL(18,2) COMMENT 'The numerical score or grade achieved by the employee on the training assessment or exam (e.g., 85.50 out of 100.00). Null if no assessment was required or taken.',
    `assignment_reason` STRING COMMENT 'The business reason or justification for assigning the employee to this training program (e.g., compliance requirement, skill gap identified in performance review, new hire onboarding, career development plan).',
    `attempts_count` STRING COMMENT 'The number of attempts the employee has made to complete or pass the training assessment.',
    `certificate_expiry_date` DATE COMMENT 'The date on which the training completion certificate expires and the employee must recertify or retake the training. Null if the certificate does not expire.',
    `certificate_issue_date` DATE COMMENT 'The date on which the training completion certificate was issued to the employee. Null if no certificate was issued.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a certificate of completion was issued to the employee upon successful completion of the training program (True/False).',
    `certificate_number` STRING COMMENT 'The unique certificate number or identifier issued to the employee upon successful completion of the training program. Null if no certificate was issued.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'The percentage of the training program that the employee has completed (0.00 to 100.00). Used to track progress for in-progress training.',
    `completion_status` STRING COMMENT 'The current status of the training completion record (enrolled, in progress, completed, failed, expired, withdrawn).. Valid values are `enrolled|in_progress|completed|failed|expired|withdrawn`',
    `compliance_framework` STRING COMMENT 'The specific regulatory or compliance framework that this training satisfies (e.g., EEOC Harassment Prevention, FCRA Background Check Compliance, OSHA Safety Standards, FLSA Wage and Hour, GDPR Data Privacy). Null if not a compliance training.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The cost incurred for the employee to complete this training program (e.g., registration fee, course materials, instructor fees). Null if the training was provided at no cost.',
    `cost_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the training cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this training completion record was first created in the system.',
    `employee_feedback` STRING COMMENT 'Free-text feedback or comments provided by the employee about the training program (e.g., quality, relevance, effectiveness). Null if no feedback was provided.',
    `employee_rating` DECIMAL(18,2) COMMENT 'The numerical rating provided by the employee for the training program (e.g., 4.50 out of 5.00). Null if no rating was provided.',
    `enrollment_date` DATE COMMENT 'The date on which the employee was enrolled in the training program.',
    `instructor_name` STRING COMMENT 'The name of the instructor or facilitator who delivered the training program. Null for self-paced or automated training.',
    `is_compliance_required` BOOLEAN COMMENT 'Indicates whether this training program is required for regulatory or organizational compliance purposes (True/False). Examples include annual harassment prevention training, FCRA training for recruiters, OSHA safety training.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this training completion record was last updated or modified in the system.',
    `manager_acknowledgment_date` DATE COMMENT 'The date on which the employees manager acknowledged or reviewed the training completion record. Null if not yet acknowledged.',
    `manager_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the employees manager has acknowledged or reviewed the training completion record (True/False).',
    `max_attempts_allowed` STRING COMMENT 'The maximum number of attempts allowed for the employee to complete or pass the training assessment. Null if unlimited attempts are allowed.',
    `next_recertification_due_date` DATE COMMENT 'The date by which the employee must complete recertification or retake the training program. Calculated based on completion date and recertification frequency. Null if recertification is not required.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'The minimum score required to pass the training assessment (e.g., 70.00). Used to determine pass/fail status.',
    `recertification_frequency_months` STRING COMMENT 'The number of months after which the employee must recertify or retake the training program (e.g., 12 for annual recertification, 24 for biennial). Null if recertification is not required.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether the employee must recertify or retake the training program after a specified period (True/False). Common for compliance training with annual or periodic renewal requirements.',
    `source_system` STRING COMMENT 'The name of the source system from which this training completion record originated (e.g., SAP SuccessFactors, internal LMS, external training platform).',
    `source_system_code` STRING COMMENT 'The unique identifier of this training completion record in the source system.',
    `start_date` DATE COMMENT 'The date on which the employee began the training program or course.',
    `target_completion_date` DATE COMMENT 'The expected or required date by which the employee should complete the training program.',
    `training_category` STRING COMMENT 'The category or type of training program (e.g., compliance, technical skills, leadership development, sales enablement, safety, onboarding, professional development). [ENUM-REF-CANDIDATE: compliance|technical|leadership|sales|operations|safety|onboarding|professional_development — 8 candidates stripped; promote to reference product]',
    `training_delivery_method` STRING COMMENT 'The method by which the training program was delivered to the employee (online, in-person, virtual instructor-led, blended, self-paced).. Valid values are `online|in_person|virtual_instructor_led|blended|self_paced`',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'The total duration of the training program in hours (e.g., 2.50 hours for a half-day workshop, 40.00 hours for a week-long course).',
    `training_program_name` STRING COMMENT 'The full name or title of the training program or course (e.g., Annual Harassment Prevention Training, FCRA Compliance for Recruiters, Advanced Sourcing Techniques).',
    `training_provider` STRING COMMENT 'The name of the organization or vendor that provided the training program (e.g., internal HR department, external training vendor, online learning platform).',
    CONSTRAINT pk_training_completion PRIMARY KEY(`training_completion_id`)
) COMMENT 'Transactional record capturing the completion or enrollment status of an internal employee in a specific training program. Tracks enrollment date, completion date, completion status (enrolled, in progress, completed, failed, expired), score or assessment result, certificate issued flag, certificate expiry date, and whether the completion satisfies a compliance requirement (e.g., annual harassment prevention training, FCRA training for recruiters). Enables compliance training tracking and L&D reporting for internal staff.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`headcount_position` (
    `headcount_position_id` BIGINT COMMENT 'Unique identifier for the approved internal headcount position within Staffing Hr organizational structure.',
    `department_id` BIGINT COMMENT 'Reference to the department that owns this headcount position for organizational hierarchy, cost allocation, and reporting purposes.',
    `internal_requisition_id` BIGINT COMMENT 'Reference to the active job requisition in the Applicant Tracking System (ATS) if this position is currently being recruited, linking headcount planning to talent acquisition activities.',
    `job_title_id` BIGINT COMMENT 'Reference to the standardized job title master that defines Fair Labor Standards Act (FLSA) status, Equal Employment Opportunity Commission (EEOC) category, Standard Occupational Classification (SOC) code, and pay grade for this position.',
    `office_location_id` BIGINT COMMENT 'Reference to the primary office or branch location where this position is based, used for geographic workforce distribution analysis and compliance with state-specific labor regulations.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the employee currently occupying this position if the position status is filled, establishing the link between headcount positions and actual workforce.',
    `reports_to_position_id` BIGINT COMMENT 'Reference to the supervisor or manager position that this position reports to in the organizational hierarchy, establishing the reporting chain for organizational structure and approval workflows.',
    `team_id` BIGINT COMMENT 'Reference to the specific team within the department where this position is allocated, used for workforce planning and team capacity management.',
    `reports_to_headcount_position_id` BIGINT COMMENT 'Self-referencing FK on headcount_position (reports_to_headcount_position_id)',
    `annual_burden_rate` DECIMAL(18,2) COMMENT 'Total annual burden cost for this position including benefits, payroll taxes, Federal Insurance Contributions Act (FICA), Federal Unemployment Tax Act (FUTA), State Unemployment Tax Act (SUTA), Workers Compensation (Workers Comp) insurance, and overhead allocation, used for full cost accounting.',
    `approved_headcount_date` DATE COMMENT 'Date when this headcount position was officially approved by executive leadership or the board, establishing the authorization to recruit and fill the position.',
    `budgeted_salary_max` DECIMAL(18,2) COMMENT 'Maximum approved annual salary for this position based on the pay grade and market compensation data, establishing the upper bound for compensation offers.',
    `budgeted_salary_midpoint` DECIMAL(18,2) COMMENT 'Target midpoint salary for this position representing the market-competitive compensation level for fully proficient performance in the role.',
    `budgeted_salary_min` DECIMAL(18,2) COMMENT 'Minimum approved annual salary for this position based on the pay grade and market compensation data, used for offer negotiation and budget planning.',
    `business_justification` STRING COMMENT 'Executive summary explaining the business rationale for creating or maintaining this headcount position, including expected return on investment, strategic alignment, and operational necessity.',
    `cost_center_code` STRING COMMENT 'General Ledger (GL) cost center code to which this positions salary, benefits, and overhead expenses are allocated for financial reporting and budget tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this headcount position record was first created in the Human Resource Information System (HRIS), used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter International Organization for Standardization (ISO) 4217 currency code for the budgeted salary amounts, supporting multi-currency operations for international offices.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this position is scheduled to end or was eliminated from the organizational structure, used for workforce planning and historical analysis. Null for ongoing positions.',
    `effective_start_date` DATE COMMENT 'Date when this position becomes active in the organizational structure and begins contributing to headcount capacity and budget allocation.',
    `flsa_status` STRING COMMENT 'Fair Labor Standards Act (FLSA) classification indicating whether the position is exempt or non-exempt from overtime pay requirements, critical for payroll processing and compliance.. Valid values are `exempt|non_exempt`',
    `fte_type` STRING COMMENT 'Classification of the position as full-time, part-time, job-share, or seasonal, determining the Full-Time Equivalent (FTE) contribution to headcount capacity and budget allocation.. Valid values are `full_time|part_time|job_share|seasonal`',
    `fte_value` DECIMAL(18,2) COMMENT 'Numeric Full-Time Equivalent (FTE) value for this position, typically 1.0000 for full-time, 0.5000 for half-time, used in workforce planning and budget calculations. Supports fractional allocations for job-share and part-time positions.',
    `is_billable_facing` BOOLEAN COMMENT 'Boolean flag indicating whether this position is client-facing and contributes directly to billable revenue generation, such as recruiters, account managers, and sales roles, versus back-office support functions.',
    `is_budgeted` BOOLEAN COMMENT 'Boolean flag indicating whether this position has approved budget allocation for the current fiscal year, used to control hiring authorization and financial planning.',
    `is_executive` BOOLEAN COMMENT 'Boolean flag indicating whether this position is at the executive level, such as C-suite or senior vice president, requiring board approval and special compensation governance.',
    `is_management` BOOLEAN COMMENT 'Boolean flag indicating whether this position has direct reports and management responsibilities, used for organizational structure analysis and leadership development planning.',
    `job_level` STRING COMMENT 'Organizational level or grade of the position within the company hierarchy, such as entry-level, mid-level, senior, manager, director, vice president, or executive, used for career progression and compensation planning.',
    `min_education_level` STRING COMMENT 'Minimum educational qualification required for this position, used in candidate screening and job posting requirements.. Valid values are `high_school|associate|bachelor|master|doctorate|professional`',
    `min_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for this position, used in candidate qualification and job posting requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this headcount position record was last updated, used for change tracking and data quality monitoring.',
    `position_code` STRING COMMENT 'Business identifier for the position, used in organizational charts, budgeting systems, and Human Resource Information System (HRIS) integration. Typically follows company-specific alphanumeric format.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_description` STRING COMMENT 'Detailed narrative description of the positions responsibilities, scope, and purpose within the organization, used for job postings and organizational documentation.',
    `position_filled_date` DATE COMMENT 'Date when this position was most recently filled by an employee, used to calculate Time to Fill (TTF) and Time to Start (TTS) Key Performance Indicators (KPIs) for recruitment effectiveness.',
    `position_status` STRING COMMENT 'Current lifecycle status of the headcount position indicating whether it is actively filled, open for recruitment, temporarily frozen due to budget constraints, or eliminated from the organizational structure.. Valid values are `filled|vacant|frozen|eliminated|pending_approval|on_hold`',
    `position_title` STRING COMMENT 'Official job title for this headcount position as it appears in organizational documentation, offer letters, and Human Resource Information System (HRIS) records.',
    `requires_background_check` BOOLEAN COMMENT 'Boolean flag indicating whether this position requires a Background Check (BGC) as part of the hiring process, driven by client requirements, regulatory compliance, or internal policy.',
    `requires_drug_screen` BOOLEAN COMMENT 'Boolean flag indicating whether this position requires a drug screening test as part of the pre-employment process, typically for safety-sensitive roles or client-mandated requirements.',
    `specialization_tags` STRING COMMENT 'Comma-separated list of skill specializations, industry verticals, or functional expertise areas relevant to this position, used for talent matching and workforce capability planning.',
    `succession_plan_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this position is part of formal succession planning, identifying critical roles that require proactive talent pipeline development.',
    `work_arrangement` STRING COMMENT 'Designated work arrangement for the position indicating whether the role is on-site, fully remote, or hybrid, impacting workspace planning and employee experience.. Valid values are `on_site|remote|hybrid`',
    CONSTRAINT pk_headcount_position PRIMARY KEY(`headcount_position_id`)
) COMMENT 'Master record for approved internal headcount positions within Staffing Hr — the authorized slots in the org chart that may be filled, vacant, or frozen. Captures position title, position code, department, team, job level, FTE type (full-time, part-time), position status (filled, vacant, frozen, eliminated), budgeted flag, approved headcount date, and the requisition reference if the position is actively being recruited. Distinct from workforce.headcount_plan (which tracks contingent workforce planning) — this entity owns internal staff position management.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` (
    `internal_requisition_id` BIGINT COMMENT 'Unique identifier for the internal requisition record. Primary key for this entity.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the employee who last modified this requisition record.',
    `department_id` BIGINT COMMENT 'Reference to the internal department that has the open position and is requesting the hire.',
    `job_title_id` BIGINT COMMENT 'Reference to the standardized job title master record that defines the role, level, and compensation band for this requisition.',
    `office_location_id` BIGINT COMMENT 'Reference to the primary office or branch location where the hired employee will be based or report to.',
    `primary_internal_staff_profile_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager responsible for this requisition and will supervise the hired candidate.',
    `quaternary_internal_filled_by_employee_staff_profile_id` BIGINT COMMENT 'Reference to the employee who was hired to fill this requisition. Populated when the requisition status is set to filled.',
    `quinary_internal_created_by_employee_staff_profile_id` BIGINT COMMENT 'Reference to the employee who created this requisition record in the system.',
    `tertiary_internal_approved_by_employee_staff_profile_id` BIGINT COMMENT 'Reference to the employee who approved this requisition, typically a senior manager or HR leader with hiring authority.',
    `replacement_internal_requisition_id` BIGINT COMMENT 'Self-referencing FK on internal_requisition (replacement_internal_requisition_id)',
    `actual_start_date` DATE COMMENT 'Actual date when the hired candidate started employment. Used to measure Time to Start (TTS) and onboarding effectiveness.',
    `approval_date` DATE COMMENT 'Date when the requisition was officially approved and authorized for recruitment activity.',
    `approval_status` STRING COMMENT 'Current approval status of the requisition in the approval workflow. Indicates whether the requisition has been authorized for recruitment.. Valid values are `pending|approved|rejected|withdrawn`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved annual budget or salary range allocated for this requisition. Used for compensation planning and budget compliance.',
    `closure_reason` STRING COMMENT 'Reason why the requisition was closed. Provides context for requisition lifecycle analytics and workforce planning.. Valid values are `filled|cancelled|on_hold|budget_cut|position_eliminated|merged_with_other_req`',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the salary and benefits for this position will be charged. Used for budget tracking and financial reporting.. Valid values are `^CC-[0-9]{4,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this requisition record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount. Supports multi-currency operations for international offices.. Valid values are `^[A-Z]{3}$`',
    `eeoc_job_category` STRING COMMENT 'EEOC job category classification for this position used in EEO-1 reporting and compliance tracking.',
    `employment_type` STRING COMMENT 'Classification of the employment arrangement for this requisition. Defines whether the position is full-time, part-time, contract, or other arrangement.. Valid values are `full_time|part_time|contract|temporary|seasonal|intern`',
    `flsa_status` STRING COMMENT 'Classification under the Fair Labor Standards Act indicating whether the position is exempt or non-exempt from overtime pay requirements.. Valid values are `exempt|non_exempt`',
    `job_description` STRING COMMENT 'Detailed description of the job responsibilities, qualifications, and requirements for the requisition. Used in job postings and candidate communications.',
    `max_salary` DECIMAL(18,2) COMMENT 'Maximum salary or compensation for the position as defined by the job title and pay grade. Upper bound of the compensation range.',
    `min_salary` DECIMAL(18,2) COMMENT 'Minimum salary or compensation for the position as defined by the job title and pay grade. Lower bound of the compensation range.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this requisition record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special instructions, or context related to this requisition.',
    `number_of_openings` STRING COMMENT 'Total number of positions to be filled under this requisition. Supports bulk hiring scenarios.',
    `preferred_qualifications` STRING COMMENT 'Desired but not mandatory qualifications, skills, or experience that would make a candidate more competitive for this position.',
    `priority_level` STRING COMMENT 'Business priority assigned to this requisition indicating urgency of fill. Influences sourcing resource allocation and Time to Fill (TTF) targets.. Valid values are `critical|high|medium|low`',
    `req_close_date` DATE COMMENT 'Date when the requisition was closed, either due to successful fill, cancellation, or other closure reason. End date for Time to Fill (TTF) calculation.',
    `req_number` STRING COMMENT 'Business identifier for the internal job requisition. Externally visible requisition number used across HR systems and communications.. Valid values are `^REQ-[0-9]{6,10}$`',
    `req_open_date` DATE COMMENT 'Date when the requisition was officially opened and approved for active recruitment. Start date for Time to Fill (TTF) calculation.',
    `req_status` STRING COMMENT 'Current lifecycle status of the internal requisition. Tracks progression from draft through fulfillment or cancellation.. Valid values are `draft|open|on_hold|filled|cancelled|closed`',
    `req_title` STRING COMMENT 'Job title or position name for the internal requisition. Describes the role being recruited for within Staffing Hr.',
    `req_type` STRING COMMENT 'Classification of the requisition indicating whether it is filling an existing vacant position (backfill) or creating new headcount (new_headcount).. Valid values are `backfill|new_headcount|expansion|replacement|temporary_coverage`',
    `required_qualifications` STRING COMMENT 'Mandatory qualifications, certifications, education, or experience required for candidates to be considered for this position.',
    `requires_background_check` BOOLEAN COMMENT 'Flag indicating whether a background check is required for this position as part of the hiring process. Compliance requirement for certain roles.',
    `requires_drug_screen` BOOLEAN COMMENT 'Flag indicating whether a drug screening test is required for this position as part of the hiring process. Common for safety-sensitive roles.',
    `sourcing_channel` STRING COMMENT 'Primary recruitment channel or strategy designated for filling this requisition. Indicates whether the role will be filled internally or externally.. Valid values are `internal_transfer|external_hire|employee_referral|agency|campus_recruitment|direct_sourcing`',
    `target_start_date` DATE COMMENT 'Desired or planned start date for the hired candidate to begin employment. Used for workforce planning and onboarding scheduling.',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from requisition open date to requisition close date. Key Performance Indicator (KPI) for recruitment efficiency.',
    `work_location_type` STRING COMMENT 'Designation of the work arrangement for this position indicating whether it is onsite, remote, or hybrid.. Valid values are `onsite|remote|hybrid`',
    CONSTRAINT pk_internal_requisition PRIMARY KEY(`internal_requisition_id`)
) COMMENT 'Transactional record for internal job requisitions opened to fill vacant headcount positions at Staffing Hr. Captures req number, req title, hiring department, hiring manager, target start date, req open date, req close date, req status (draft, open, on hold, filled, cancelled), number of openings, priority level, sourcing channel (internal transfer, external hire, referral), and whether the req is backfill or new headcount. Distinct from joborder.order_header (which tracks client-facing requisitions for contingent workers) — this entity owns internal talent acquisition demand.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` (
    `disciplinary_action_id` BIGINT COMMENT 'Unique identifier for the disciplinary action record. Primary key for the disciplinary action entity.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee who is the subject of this disciplinary action. Links to the staff profile of the employee receiving the disciplinary action.',
    `tertiary_disciplinary_hr_reviewer_staff_profile_id` BIGINT COMMENT 'Identifier of the HR professional who reviewed, approved, and documented the disciplinary action for policy compliance and legal defensibility. Required for all formal disciplinary actions.',
    `escalated_disciplinary_action_id` BIGINT COMMENT 'Self-referencing FK on disciplinary_action (escalated_disciplinary_action_id)',
    `action_date` DATE COMMENT 'Date when the disciplinary action was formally issued or communicated to the employee. Used for tracking progressive discipline timelines and appeal deadlines.',
    `action_number` STRING COMMENT 'Business identifier or case number assigned to this disciplinary action for tracking and reference purposes. Used in HR documentation and employee communications.',
    `action_type` STRING COMMENT 'Classification of the disciplinary action severity level within the progressive discipline framework. Determines the escalation stage and consequences for the employee.. Valid values are `verbal_warning|written_warning|final_written_warning|suspension|termination|performance_improvement_plan`',
    `appeal_decision_date` DATE COMMENT 'Date when the appeal review was completed and a final decision was rendered. Used for tracking resolution timelines and updating employee records.',
    `appeal_filed_date` DATE COMMENT 'Date when the employee formally submitted an appeal or grievance. Used for tracking appeal processing timelines and compliance with grievance procedure deadlines.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the employee has filed a formal appeal or grievance challenging the disciplinary action. Triggers appeal review process and legal risk assessment.',
    `appeal_notes` STRING COMMENT 'Summary of the appeal review process, findings, and rationale for the appeal decision. Provides documentation for legal defensibility and HR audit trails.',
    `appeal_outcome` STRING COMMENT 'Final decision on the employees appeal. Determines whether the original disciplinary action stands, is reversed, or is modified. Impacts employee record and potential reinstatement.. Valid values are `pending|upheld|overturned|modified|withdrawn`',
    `corrective_action_deadline` DATE COMMENT 'Target date by which the employee must demonstrate compliance with corrective action requirements. Used for follow-up review scheduling and PIP milestone tracking.',
    `corrective_action_required` STRING COMMENT 'Specific behavioral changes, performance improvements, or compliance steps the employee must demonstrate to avoid further disciplinary escalation. Used for Performance Improvement Plan (PIP) tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this disciplinary action record was first created in the system. Used for audit trails, data lineage, and compliance reporting.',
    `disciplinary_action_status` STRING COMMENT 'Current lifecycle status of the disciplinary action. Tracks whether the action is in effect, has been completed, is under appeal, was overturned, or has expired per retention policy.. Valid values are `active|completed|appealed|overturned|expired`',
    `document_url` STRING COMMENT 'URL or file path to the signed disciplinary action form, supporting documentation, investigation reports, and employee acknowledgment records stored in the document management system.',
    `eeoc_risk_level` STRING COMMENT 'Assessment of the potential risk that this disciplinary action could result in an EEOC discrimination claim or wrongful termination lawsuit. Drives documentation rigor and legal review requirements.. Valid values are `low|medium|high|critical`',
    `effective_date` DATE COMMENT 'Date when the disciplinary action takes effect. For suspensions or terminations, this is when the employment status change begins. May differ from action date for scheduled actions.',
    `employee_acknowledgment_date` DATE COMMENT 'Date when the employee formally acknowledged receipt of the disciplinary action. Establishes the start of appeal deadlines and corrective action timelines.',
    `employee_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the employee has signed or electronically acknowledged receipt of the disciplinary action documentation. Critical for legal defensibility and due process compliance.',
    `employee_comments` STRING COMMENT 'Free-text comments or rebuttal provided by the employee in response to the disciplinary action. Preserved for due process documentation and appeal record.',
    `expiration_date` DATE COMMENT 'Date when this disciplinary action is removed from the employees active record per the clean slate or records retention policy. Typically 12-24 months for warnings, permanent for terminations.',
    `hr_approval_date` DATE COMMENT 'Date when the HR reviewer formally approved the disciplinary action. Establishes the official record date for compliance and audit purposes.',
    `hr_notes` STRING COMMENT 'Internal HR notes documenting policy compliance checks, legal considerations, precedent review, and any special handling instructions. Not shared with the employee.',
    `incident_date` DATE COMMENT 'Date when the infraction or policy violation occurred. This is the business event date that triggered the disciplinary process, distinct from when the action was formally issued.',
    `infraction_category` STRING COMMENT 'Primary category of the employee behavior or performance issue that triggered the disciplinary action. Used for trend analysis and policy enforcement tracking.. Valid values are `attendance|performance|conduct|policy_violation|compliance_breach|safety_violation`',
    `infraction_description` STRING COMMENT 'Detailed narrative description of the specific behavior, performance issue, or policy violation that led to the disciplinary action. Includes facts, dates, witnesses, and context for legal defensibility.',
    `infraction_subcategory` STRING COMMENT 'Detailed subcategory or specific policy code violated within the primary infraction category. Provides granular classification for reporting and compliance documentation.',
    `legal_counsel_involved_flag` BOOLEAN COMMENT 'Indicates whether employment legal counsel was consulted or involved in reviewing this disciplinary action. Signals high-risk cases requiring attorney-client privilege protection.',
    `legal_review_date` DATE COMMENT 'Date when legal counsel completed their review of the disciplinary action. Used for tracking legal risk mitigation timelines and privileged communication records.',
    `manager_comments` STRING COMMENT 'Additional context, observations, or justification provided by the issuing manager. Supplements the infraction description with managerial perspective for HR review.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this disciplinary action record was last updated. Tracks changes to status, appeal outcomes, or administrative corrections for audit and compliance purposes.',
    `prior_action_count` STRING COMMENT 'Number of previous disciplinary actions on record for this employee at the time this action was issued. Used to validate progressive discipline escalation and consistency.',
    `protected_class_consideration_flag` BOOLEAN COMMENT 'Indicates whether the employee belongs to a protected class under EEOC regulations and whether disparate impact analysis was performed. Critical for discrimination defense documentation.',
    `source_system` STRING COMMENT 'Name of the operational system where this disciplinary action record originated. Typically the HRIS or case management system used for HR documentation and workflow.',
    `source_system_code` STRING COMMENT 'Unique identifier of this disciplinary action record in the source operational system. Used for data lineage, reconciliation, and bidirectional sync with HR systems.',
    `suspension_days` STRING COMMENT 'Number of days the employee is suspended without pay or with pay as specified. Used for payroll deduction calculations and attendance tracking.',
    `suspension_end_date` DATE COMMENT 'End date of suspension period when employee is expected to return to work. Null for non-suspension actions. Used for workforce planning and scheduling.',
    `suspension_paid_flag` BOOLEAN COMMENT 'Indicates whether the suspension period is paid or unpaid. True for paid administrative leave, false for unpaid disciplinary suspension. Impacts payroll processing.',
    `suspension_start_date` DATE COMMENT 'Start date of suspension period for suspension-type disciplinary actions. Null for non-suspension actions. Used for payroll and attendance system integration.',
    `witness_employee_ids` STRING COMMENT 'Comma-separated list of employee identifiers who witnessed the infraction or can corroborate the facts. Used for investigation documentation and legal defense preparation.',
    CONSTRAINT pk_disciplinary_action PRIMARY KEY(`disciplinary_action_id`)
) COMMENT 'Master record for formal disciplinary actions issued to internal employees as part of progressive discipline processes. Captures action type (verbal warning, written warning, final written warning, suspension, termination), infraction category (attendance, performance, conduct, policy violation, compliance breach), incident date, action date, description of infraction, corrective action required, appeal status, HR reviewer, and whether legal counsel was involved. Supports HR compliance documentation, EEOC defense records, and wrongful termination risk management.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`survey` (
    `survey_id` BIGINT COMMENT 'Unique identifier for the employee survey response record. Primary key for the employee survey transaction.',
    `department_id` BIGINT COMMENT 'Identifier of the department to which the employee belonged at the time of the survey. Used for departmental engagement analysis and benchmarking.',
    `job_title_id` BIGINT COMMENT 'Identifier of the employees job title at the time of the survey. Used for role-based engagement analysis and benchmarking.',
    `office_location_id` BIGINT COMMENT 'Identifier of the office location where the employee was based at the time of the survey. Used for location-based engagement analysis.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the employees direct manager at the time of the survey. Used for manager effectiveness analysis and team-level engagement insights.',
    `survey_staff_profile_id` BIGINT COMMENT 'Identifier of the internal employee (recruiter, account manager, operations staff) who completed the survey. Links to the staff member being surveyed.',
    `prior_survey_id` BIGINT COMMENT 'Self-referencing FK on survey (prior_survey_id)',
    `action_plan_required` BOOLEAN COMMENT 'Flag indicating whether the survey response triggered a requirement for management action planning due to low scores or critical feedback (True) or not (False).',
    `career_development_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees satisfaction with career development opportunities, growth potential, training, and advancement prospects. Typically on a scale of 0-100.',
    `collaboration_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees assessment of teamwork, cross-functional collaboration, and communication effectiveness within the organization. Typically on a scale of 0-100.',
    `compensation_satisfaction_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees satisfaction with their total compensation package including base pay, commissions, bonuses, and benefits. Typically on a scale of 0-100.',
    `consent_to_attribution` BOOLEAN COMMENT 'Flag indicating whether the employee consented to having their responses attributed to them for follow-up conversations, action planning, or manager review (True) or preferred to keep responses confidential (False).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this survey response record was first created in the data platform.',
    `culture_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees assessment of organizational culture, values alignment, inclusion, and workplace environment. Typically on a scale of 0-100.',
    `due_date` DATE COMMENT 'The deadline date by which the employee was requested to complete the survey.',
    `employment_type` STRING COMMENT 'The employees employment type at the time of the survey (full-time, part-time, contract, temporary). Used for employment-type-based engagement analysis.. Valid values are `full_time|part_time|contract|temporary`',
    `enps_category` STRING COMMENT 'Classification of the employee based on their likelihood-to-recommend response: promoter (9-10), passive (7-8), or detractor (0-6).. Valid values are `promoter|passive|detractor`',
    `enps_score` STRING COMMENT 'Employee Net Promoter Score (eNPS) based on the likelihood-to-recommend question. Scored from -100 to +100, calculated as percentage of promoters minus percentage of detractors.',
    `follow_up_requested` BOOLEAN COMMENT 'Flag indicating whether the employee requested a follow-up conversation with HR or management to discuss their survey responses (True) or not (False).',
    `invitation_date` DATE COMMENT 'The date on which the survey invitation was sent to the employee.',
    `is_anonymous` BOOLEAN COMMENT 'Flag indicating whether the survey response was submitted anonymously (True) or with employee attribution (False). Controls whether the response can be linked back to the individual employee for follow-up.',
    `manager_effectiveness_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees assessment of their direct managers effectiveness, leadership, communication, and support. Typically on a scale of 0-100.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this survey response record was last modified or updated in the data platform.',
    `open_ended_comments` STRING COMMENT 'Free-text comments provided by the employee in response to open-ended survey questions. Contains qualitative feedback, suggestions, concerns, and additional context.',
    `overall_engagement_score` DECIMAL(18,2) COMMENT 'Composite engagement score calculated from all survey responses, typically on a scale of 0-100. Represents the employees overall engagement level.',
    `period_end_date` DATE COMMENT 'The end date of the period covered by the survey (e.g., the end of the quarter or year being assessed).',
    `period_start_date` DATE COMMENT 'The start date of the period covered by the survey (e.g., the beginning of the quarter or year being assessed).',
    `recognition_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees satisfaction with recognition, appreciation, and acknowledgment of their contributions. Typically on a scale of 0-100.',
    `reminder_count` STRING COMMENT 'The number of reminder notifications sent to the employee to encourage survey completion.',
    `resources_tools_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees satisfaction with the resources, tools, technology, and support provided to perform their job effectively. Typically on a scale of 0-100.',
    `response_channel` STRING COMMENT 'The channel or platform through which the employee submitted their survey response (web portal, mobile app, email link, kiosk, or paper form).. Valid values are `web|mobile|email|kiosk|paper`',
    `response_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of survey questions answered by the employee, calculated as (answered questions / total questions) * 100. Used to assess response quality and completeness.',
    `response_date` DATE COMMENT 'The date on which the employee submitted their survey response. Principal business event timestamp for this transaction.',
    `response_status` STRING COMMENT 'Current status of the survey response indicating whether the employee completed the survey, partially completed it, has not started, or declined to participate.. Valid values are `completed|partial|not_started|declined`',
    `response_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the employee completed and submitted the survey response, including time zone information.',
    `source_system` STRING COMMENT 'The name of the source system from which this survey response record was extracted (e.g., SAP SuccessFactors, Qualtrics, Culture Amp).',
    `source_system_code` STRING COMMENT 'The unique identifier of this survey response record in the source system, used for data lineage and reconciliation.',
    `survey_name` STRING COMMENT 'The name or title of the survey instrument administered (e.g., Annual Engagement Survey 2024, Q2 Pulse Check, New Hire 90-Day Feedback).',
    `survey_type` STRING COMMENT 'Category of survey administered. Distinguishes between annual engagement surveys, pulse checks, onboarding satisfaction surveys, exit surveys, manager effectiveness assessments, culture surveys, and ad-hoc surveys. [ENUM-REF-CANDIDATE: annual_engagement|pulse|onboarding_satisfaction|exit|manager_effectiveness|culture|ad_hoc — 7 candidates stripped; promote to reference product]',
    `tenure_months` STRING COMMENT 'The employees tenure with the organization in months at the time of the survey response. Used for tenure-based engagement analysis.',
    `vendor` STRING COMMENT 'The name of the third-party survey platform or vendor used to administer the survey (e.g., Qualtrics, Culture Amp, Glint, SurveyMonkey).',
    `version` STRING COMMENT 'Version identifier of the survey instrument used, allowing tracking of changes to survey questions and methodology over time.',
    `work_life_balance_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees satisfaction with work-life balance, flexibility, workload, and ability to manage personal and professional responsibilities. Typically on a scale of 0-100.',
    CONSTRAINT pk_survey PRIMARY KEY(`survey_id`)
) COMMENT 'Transactional record capturing internal employee engagement survey responses and pulse check results. Tracks survey name, survey type (annual engagement, pulse, onboarding satisfaction, exit), survey period, response date, overall engagement score, eNPS (Employee Net Promoter Score), category scores (manager effectiveness, career development, compensation satisfaction, culture, work-life balance), response anonymization flag, and whether the employee consented to attribution. Supports internal retention analytics, manager effectiveness programs, and culture initiatives at Staffing Hr.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`office_location` (
    `office_location_id` BIGINT COMMENT 'Unique identifier for the office location. Primary key for the office location entity.',
    `parent_location_office_location_id` BIGINT COMMENT 'Reference to the parent office location in a hierarchical structure. For example, a satellite office may roll up to a regional hub, which rolls up to corporate HQ. Supports multi-level organizational reporting.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal employee who serves as the branch manager or location leader responsible for this office. Used for organizational hierarchy and accountability reporting.',
    `parent_office_location_id` BIGINT COMMENT 'Self-referencing FK on office_location (parent_office_location_id)',
    `address_line1` STRING COMMENT 'Primary street address line for the office location including street number and street name. Organizational contact data classified as confidential business information.',
    `address_line2` STRING COMMENT 'Secondary address line for suite, floor, building, or unit information. Organizational contact data classified as confidential business information.',
    `ats_instance_code` STRING COMMENT 'Identifier for the ATS instance or database partition that this office location uses in Bullhorn or other applicant tracking systems. Some large staffing firms run multiple ATS instances by region or division.',
    `city` STRING COMMENT 'City or municipality where the office location is situated.',
    `cost_center_code` STRING COMMENT 'General Ledger (GL) cost center code assigned to this office location for financial accounting and expense allocation. Used in payroll burden allocation and P&L reporting by location.. Valid values are `^[A-Z0-9]{4,12}$`',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the office is located (e.g., USA, CAN, MEX). Critical for international tax compliance and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this office location record was first created in the system. Part of standard audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for financial amounts associated with this location (e.g., USD, CAD, MXN). Required for multi-currency financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this office location ceased operations or was closed. Null for currently active locations. Supports historical reporting and location lifecycle tracking.',
    `effective_start_date` DATE COMMENT 'Date when this office location became operational and active in the system. Supports historical reporting and location lifecycle tracking.',
    `email_address` STRING COMMENT 'General business email address for the office location (e.g., chicago.branch@staffinghr.com). Organizational contact data classified as confidential business information.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the office location if applicable. Still used for certain compliance and legal document transmission. Organizational contact data classified as confidential business information.',
    `is_client_facing` BOOLEAN COMMENT 'Indicates whether this location regularly hosts client meetings and has client-facing facilities. True for branch offices with meeting rooms, false for back-office or remote locations.',
    `is_remote_work_hub` BOOLEAN COMMENT 'Indicates whether this location is designated as a remote work hub or virtual office with no physical branch presence. True for remote hubs, false for physical offices.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the office location in decimal degrees. Used for mapping, territory assignment, and proximity-based analytics.',
    `lease_end_date` DATE COMMENT 'Date when the current lease or occupancy agreement expires. Used for lease renewal planning and facility cost forecasting.',
    `lease_start_date` DATE COMMENT 'Date when the lease or occupancy agreement for this location began. Critical for lease accounting and renewal planning.',
    `lease_type` STRING COMMENT 'Type of occupancy arrangement for the office location. Owned properties are company-owned, leased properties are under long-term lease, subleased properties are rented from another tenant, coworking spaces are shared flexible workspaces, and virtual locations have no physical presence.. Valid values are `owned|leased|subleased|coworking|virtual`',
    `location_code` STRING COMMENT 'Unique business identifier code for the office location used in operational systems and reporting. Typically a short alphanumeric code assigned by corporate for branch identification.. Valid values are `^[A-Z0-9]{3,10}$`',
    `location_name` STRING COMMENT 'Full business name of the office location (e.g., Chicago Downtown Branch, Corporate Headquarters, Dallas Regional Hub).',
    `location_type` STRING COMMENT 'Classification of the office location by its operational function within the organization. Branch offices serve local markets, corporate HQ houses executive leadership, regional hubs coordinate multi-branch operations, remote hubs support distributed workforce, satellite offices provide limited local presence, and shared services centers handle back-office functions.. Valid values are `branch_office|corporate_hq|regional_hub|remote_hub|satellite_office|shared_services_center`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the office location in decimal degrees. Used for mapping, territory assignment, and proximity-based analytics.',
    `market_region` STRING COMMENT 'Geographic market or sales region that this office serves (e.g., Midwest, Northeast, Southwest). Used for regional performance reporting and market segmentation analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this office location record was last updated. Part of standard audit trail for data lineage and compliance.',
    `monthly_rent_amount` DECIMAL(18,2) COMMENT 'Monthly rent or lease payment amount for the office location in the local currency. Confidential business financial data used for cost center budgeting and P&L analysis.',
    `notes` STRING COMMENT 'Free-form text field for additional information about the office location such as special access instructions, facility features, or operational notes.',
    `office_location_status` STRING COMMENT 'Current operational status of the office location. Active locations are fully operational, inactive locations are not currently in use, pending opening locations are being set up, temporarily closed locations are expected to reopen, permanently closed locations will not reopen, and under renovation locations are being upgraded.. Valid values are `active|inactive|pending_opening|temporarily_closed|permanently_closed|under_renovation`',
    `parking_available` BOOLEAN COMMENT 'Indicates whether parking facilities are available at or near this office location. Relevant for employee commuting and client visit planning.',
    `phone_number` STRING COMMENT 'Primary business phone number for the office location. Organizational contact data classified as confidential business information.',
    `postal_code` STRING COMMENT 'ZIP code or postal code for the office location. Supports payroll tax jurisdiction determination and geographic reporting. Organizational contact data classified as confidential business information.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `public_transit_accessible` BOOLEAN COMMENT 'Indicates whether the office location is accessible via public transportation. Relevant for employee commuting and sustainability reporting.',
    `seating_capacity` STRING COMMENT 'Maximum number of employees that can be seated at this location. Supports headcount planning and space utilization analysis.',
    `square_footage` STRING COMMENT 'Total usable square footage of the office space. Used for facility cost allocation, capacity planning, and lease management.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the office is located (e.g., CA, TX, NY). Used for payroll tax jurisdiction determination and compliance reporting.. Valid values are `^[A-Z]{2}$`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the office location (e.g., America/Chicago, America/New_York). Critical for scheduling, timesheet management, and workforce dispatch across multiple locations.',
    CONSTRAINT pk_office_location PRIMARY KEY(`office_location_id`)
) COMMENT 'Reference master for all physical Staffing Hr branch offices, corporate offices, and remote work hubs where internal employees are based. Captures location name, location code, address (street, city, state, zip, country), location type (branch office, corporate HQ, regional hub, remote), phone number, fax number, time zone, market region, branch manager employee reference, and active status. Supports employee location assignment, payroll tax jurisdiction determination, and branch-level performance reporting.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Primary key for benefit_plan',
    `superseded_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (superseded_benefit_plan_id)',
    `benefit_percentage` DECIMAL(18,2) COMMENT 'Percentage of salary or wages replaced by the benefit. Applicable to disability and retirement plans. Expressed as a percentage (e.g., 60.00 for 60%).',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or provider administering the benefit plan.',
    `carrier_policy_number` STRING COMMENT 'Policy or contract number assigned by the insurance carrier for this benefit plan.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether this benefit plan is eligible for COBRA continuation coverage after employment termination.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of costs the employee pays after meeting the deductible. Expressed as a percentage (e.g., 20.00 for 20%).',
    `compliance_status` STRING COMMENT 'Current compliance status of the benefit plan with applicable regulations such as ERISA, ACA, and HIPAA.',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are made for this benefit plan.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed amount the employee pays for specific services such as doctor visits or prescriptions.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Maximum benefit amount or coverage limit provided by the plan. Applicable to life insurance and disability plans.',
    `coverage_level` STRING COMMENT 'Scope of coverage provided by the benefit plan indicating who is eligible for benefits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this benefit plan.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount that must be met before the benefit plan begins paying claims. Applicable to health, dental, and vision plans.',
    `benefit_plan_description` STRING COMMENT 'Detailed description of the benefit plan including coverage details, terms, and conditions.',
    `effective_end_date` DATE COMMENT 'Date when the benefit plan is no longer available for new enrollments. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the benefit plan becomes active and available for employee enrollment.',
    `eligibility_waiting_period_days` STRING COMMENT 'Number of days an employee must wait after hire date before becoming eligible to enroll in this benefit plan.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Amount the employee contributes per pay period for this benefit plan.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Amount the employer contributes per pay period for this benefit plan.',
    `employer_match_limit_percentage` DECIMAL(18,2) COMMENT 'Maximum percentage of salary up to which the employer will match contributions in retirement plans. Expressed as a percentage (e.g., 6.00 for 6%).',
    `employer_match_percentage` DECIMAL(18,2) COMMENT 'Percentage of employee contributions that the employer will match in retirement plans. Expressed as a percentage (e.g., 50.00 for 50%).',
    `enrollment_type` STRING COMMENT 'Indicates whether enrollment in this benefit plan is voluntary, mandatory, or automatic for eligible employees.',
    `fsa_eligible_flag` BOOLEAN COMMENT 'Indicates whether this benefit plan allows employees to contribute to a Flexible Spending Account for eligible expenses.',
    `hsa_eligible_flag` BOOLEAN COMMENT 'Indicates whether this benefit plan qualifies as a high-deductible health plan eligible for HSA contributions.',
    `last_compliance_review_date` DATE COMMENT 'Date when the benefit plan was last reviewed for regulatory compliance.',
    `modified_by` STRING COMMENT 'User or system identifier that last modified this benefit plan record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was last modified in the system.',
    `network_type` STRING COMMENT 'Type of provider network associated with the benefit plan. Applicable to health, dental, and vision plans.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount an employee will pay out-of-pocket in a plan year before the plan covers 100% of costs. Applicable to health plans.',
    `plan_administrator_contact` STRING COMMENT 'Contact information (phone or email) for the benefit plan administrator.',
    `plan_administrator_name` STRING COMMENT 'Name of the individual or organization responsible for administering the benefit plan.',
    `plan_code` STRING COMMENT 'Externally-known unique code for the benefit plan used in HR systems and employee communications.',
    `plan_name` STRING COMMENT 'Human-readable name of the benefit plan as displayed to employees and in HR documentation.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the benefit plan indicating availability for enrollment and administration.',
    `plan_type` STRING COMMENT 'Category of benefit plan that segments the population of available benefits.',
    `plan_year_end_date` DATE COMMENT 'End date of the benefit plan year used for tracking deductibles, out-of-pocket maximums, and annual limits.',
    `plan_year_start_date` DATE COMMENT 'Start date of the benefit plan year used for tracking deductibles, out-of-pocket maximums, and annual limits.',
    `summary_plan_description_url` STRING COMMENT 'URL or file path to the Summary Plan Description document required by ERISA.',
    `vesting_period_months` STRING COMMENT 'Number of months an employee must participate in the plan before employer contributions become fully owned. Applicable to retirement plans.',
    `created_by` STRING COMMENT 'User or system identifier that created this benefit plan record.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by benefit_plan_id.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Primary key for compensation_plan',
    `created_by_employee_staff_profile_id` BIGINT COMMENT 'Identifier of the employee who created this compensation plan record.',
    `last_modified_by_employee_staff_profile_id` BIGINT COMMENT 'Identifier of the employee who last modified this compensation plan record.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the manager or executive who approved this compensation plan. Null if not yet approved or approval not required.',
    `superseded_compensation_plan_id` BIGINT COMMENT 'Self-referencing FK on compensation_plan (superseded_compensation_plan_id)',
    `approval_date` DATE COMMENT 'Date when this compensation plan was approved for use. Null if not yet approved or approval not required.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether management approval is required before assigning this plan to an employee.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Fixed annual base salary amount for this compensation plan. Null if plan does not include base salary component.',
    `bonus_eligibility_flag` BOOLEAN COMMENT 'Indicates whether employees on this plan are eligible for discretionary or performance bonuses.',
    `clawback_period_days` STRING COMMENT 'Number of days after placement during which commission can be clawed back if placement fails. Null if no clawback provision.',
    `clawback_provision_flag` BOOLEAN COMMENT 'Indicates whether commissions or bonuses can be reclaimed if placement fails or client cancels within a specified period.',
    `commission_basis` STRING COMMENT 'The revenue metric upon which commission is calculated (gross revenue, net revenue, placement fee, margin, billable hours).',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'Standard commission rate as a percentage of revenue or placement fees. Null if plan does not include commission component.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compensation plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this plan (e.g., USD, GBP, EUR).',
    `compensation_plan_description` STRING COMMENT 'Detailed description of the compensation plan structure, eligibility criteria, and calculation methodology.',
    `draw_amount` DECIMAL(18,2) COMMENT 'Guaranteed advance payment amount against future commissions. Null if plan does not include draw component.',
    `draw_type` STRING COMMENT 'Whether the draw must be repaid from future commissions (recoverable) or is guaranteed (non-recoverable). Null if no draw.',
    `effective_end_date` DATE COMMENT 'Date when the compensation plan expires or is no longer available for new assignments. Null indicates open-ended plan.',
    `effective_start_date` DATE COMMENT 'Date when the compensation plan becomes active and can be assigned to employees.',
    `geographic_scope` STRING COMMENT 'Geographic market scope this plan is designed for (local, regional, national, international, global).',
    `job_role_category` STRING COMMENT 'Primary job role category this compensation plan is designed for (recruiter, account manager, sales, operations, management, administrative, executive).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compensation plan record was last updated.',
    `notes` STRING COMMENT 'Additional notes, special conditions, or exceptions related to this compensation plan.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether employees on this plan are eligible for overtime pay under labor regulations.',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base hourly rate for overtime hours (e.g., 1.5 for time-and-a-half). Null if not overtime eligible.',
    `payment_frequency` STRING COMMENT 'How often compensation is paid to employees under this plan (weekly, biweekly, semimonthly, monthly, quarterly, annual).',
    `plan_code` STRING COMMENT 'Unique business identifier code for the compensation plan used in external communications and reporting.',
    `plan_name` STRING COMMENT 'Human-readable name of the compensation plan (e.g., Base Salary + Commission, Recruiter Tiered Bonus).',
    `plan_type` STRING COMMENT 'Classification of the compensation structure (salary only, commission only, salary plus commission, tiered bonus, draw against commission, profit sharing).',
    `seniority_level` STRING COMMENT 'Target seniority level for employees assigned to this plan (entry, junior, mid, senior, principal, executive).',
    `split_commission_allowed_flag` BOOLEAN COMMENT 'Indicates whether commissions under this plan can be split among multiple employees (e.g., recruiter and account manager).',
    `compensation_plan_status` STRING COMMENT 'Current lifecycle status of the compensation plan indicating whether it is available for assignment to employees.',
    `target_bonus_amount` DECIMAL(18,2) COMMENT 'Target annual bonus amount at 100% performance achievement. Null if no bonus component or bonus is discretionary.',
    `tier_count` STRING COMMENT 'Number of performance tiers in the compensation structure. Null if tier_structure_flag is false.',
    `tier_structure_flag` BOOLEAN COMMENT 'Indicates whether this plan uses tiered commission or bonus rates based on performance thresholds.',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Master reference table for compensation_plan. Referenced by plan_id.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`accrual_policy` (
    `accrual_policy_id` BIGINT COMMENT 'Primary key for accrual_policy',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity to which this accrual policy applies.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the HR employee responsible for maintaining and administering this accrual policy.',
    `superseded_by_policy_id` BIGINT COMMENT 'Reference to the accrual policy that replaces this policy if it has been superseded. Null if current.',
    `superseded_accrual_policy_id` BIGINT COMMENT 'Self-referencing FK on accrual_policy (superseded_accrual_policy_id)',
    `accrual_calculation_basis` STRING COMMENT 'Basis on which accrual is calculated (e.g., hours worked, days employed, calendar time).',
    `accrual_frequency` STRING COMMENT 'Frequency at which time off accrues to employees under this policy (e.g., monthly, per pay period).',
    `accrual_rate` DECIMAL(18,2) COMMENT 'Numeric rate at which time accrues per accrual period (e.g., 1.67 hours per pay period, 10 days per year).',
    `accrual_start_event` STRING COMMENT 'Event that triggers the start of accrual for an employee under this policy.',
    `accrual_unit` STRING COMMENT 'Unit of measurement for accrued time (hours or days).',
    `advance_notice_days` STRING COMMENT 'Number of days advance notice required for employees to request time off under this policy.',
    `approval_date` DATE COMMENT 'Date when the accrual policy was officially approved for use by HR leadership or management.',
    `carryover_allowed` BOOLEAN COMMENT 'Indicates whether unused accrued time can be carried over to the next accrual period or calendar year.',
    `carryover_maximum` DECIMAL(18,2) COMMENT 'Maximum amount of accrued time that can be carried over if carryover is allowed. Null if unlimited or carryover not allowed.',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the jurisdiction where this policy applies (e.g., USA, CAN, GBR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the accrual policy record was first created in the system.',
    `accrual_policy_description` STRING COMMENT 'Detailed description of the accrual policy including purpose, rules, and any special conditions.',
    `effective_end_date` DATE COMMENT 'Date when the accrual policy ceases to be active. Null for open-ended policies.',
    `effective_start_date` DATE COMMENT 'Date when the accrual policy becomes active and begins applying to assigned employees.',
    `eligibility_criteria` STRING COMMENT 'Description of employee eligibility requirements for this accrual policy (e.g., full-time only, specific job levels, tenure requirements).',
    `last_review_date` DATE COMMENT 'Date when the accrual policy was last reviewed for compliance and accuracy.',
    `maximum_accrual_balance` DECIMAL(18,2) COMMENT 'Maximum amount of time that can be accrued under this policy. Null if no cap applies.',
    `minimum_usage_increment` DECIMAL(18,2) COMMENT 'Minimum increment in which accrued time can be used (e.g., 0.25 hours, 0.5 days).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the accrual policy record was last modified or updated.',
    `negative_balance_allowed` BOOLEAN COMMENT 'Indicates whether employees can use time off before it has fully accrued, resulting in a negative balance.',
    `negative_balance_limit` DECIMAL(18,2) COMMENT 'Maximum negative balance allowed if negative balances are permitted. Null if not applicable.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next policy review to ensure ongoing compliance and relevance.',
    `payout_on_termination` BOOLEAN COMMENT 'Indicates whether unused accrued time is paid out to the employee upon termination of employment.',
    `policy_code` STRING COMMENT 'Unique business identifier code for the accrual policy, used for external reference and system integration.',
    `policy_name` STRING COMMENT 'Human-readable name of the accrual policy (e.g., Standard PTO, Executive Leave, Contractor Time Off).',
    `policy_type` STRING COMMENT 'Classification of the accrual policy indicating the type of leave or time off it governs.',
    `proration_method` STRING COMMENT 'Method used to prorate accruals for employees who start mid-period or have partial eligibility.',
    `requires_approval` BOOLEAN COMMENT 'Indicates whether time off requests under this policy require manager or HR approval before use.',
    `state_province_code` STRING COMMENT 'State or province code for jurisdiction-specific policies (e.g., CA for California, ON for Ontario).',
    `accrual_policy_status` STRING COMMENT 'Current lifecycle status of the accrual policy indicating whether it is currently in use or available for assignment.',
    `tier_based` BOOLEAN COMMENT 'Indicates whether this policy uses tiered accrual rates based on tenure or other factors.',
    `version_number` STRING COMMENT 'Version number of the policy to track changes and revisions over time.',
    `waiting_period_days` STRING COMMENT 'Number of days an employee must wait after hire or assignment before accrual begins under this policy.',
    CONSTRAINT pk_accrual_policy PRIMARY KEY(`accrual_policy_id`)
) COMMENT 'Master reference table for accrual_policy. Referenced by accrual_policy_id.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`review_period` (
    `review_period_id` BIGINT COMMENT 'Primary key for review_period',
    `modified_by_employee_staff_profile_id` BIGINT COMMENT 'Identifier of the employee who last modified this review period record.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the employee who created this review period record.',
    `prior_review_period_id` BIGINT COMMENT 'Self-referencing FK on review_period (prior_review_period_id)',
    `applies_to_all_employees` BOOLEAN COMMENT 'Indicates whether this review period applies to all employees (True) or only specific groups/departments (False).',
    `calendar_year` STRING COMMENT 'The calendar year in which the review period primarily falls (e.g., 2024).',
    `closure_date` DATE COMMENT 'The date when the review period was officially closed and all reviews finalized.',
    `compensation_review_linked` BOOLEAN COMMENT 'Indicates whether this review period is directly linked to compensation decisions such as salary increases or bonuses (True/False).',
    `completed_review_count` STRING COMMENT 'The number of performance reviews that have been completed for this review period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this review period record was first created in the system.',
    `review_period_description` STRING COMMENT 'Detailed description of the review period including its purpose, scope, and any special instructions or focus areas.',
    `eligible_employee_count` STRING COMMENT 'The total number of employees eligible for review during this period.',
    `end_date` DATE COMMENT 'The date when the review period officially ends. Performance and activities up to this date are included in the evaluation.',
    `evaluation_criteria` STRING COMMENT 'Description of the key performance criteria and competencies being evaluated during this review period.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the fiscal year (1, 2, 3, or 4). Null for non-quarterly review periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this review period belongs (e.g., 2024).',
    `goal_setting_required` BOOLEAN COMMENT 'Indicates whether employees and managers are required to set performance goals for the next period as part of this review cycle (True/False).',
    `includes_360_feedback` BOOLEAN COMMENT 'Indicates whether 360-degree feedback (manager, peer, subordinate, self) is collected during this review period (True/False).',
    `includes_peer_review` BOOLEAN COMMENT 'Indicates whether peer reviews are included as part of the evaluation process for this review period (True/False).',
    `includes_self_assessment` BOOLEAN COMMENT 'Indicates whether employees are required to complete a self-assessment as part of this review period (True/False).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this review period record is currently active (True) or has been archived/deactivated (False).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether participation in this review period is mandatory for all eligible employees (True) or optional (False).',
    `launch_date` DATE COMMENT 'The date when the review period was officially launched and review activities began.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this review period record was last modified.',
    `notes` STRING COMMENT 'Additional notes or comments about the review period for internal reference.',
    `notification_sent_date` DATE COMMENT 'The date when employees and managers were notified about the upcoming review period.',
    `period_code` STRING COMMENT 'Short code or identifier used to reference the review period in business operations and reporting (e.g., Q1-2024, ANN-2023).',
    `period_name` STRING COMMENT 'Human-readable name or label for the review period (e.g., Q1 2024 Performance Review, Annual Review 2023, Mid-Year Check-In).',
    `period_type` STRING COMMENT 'Classification of the review period based on frequency and purpose (annual, semi-annual, quarterly, monthly, probationary, project-based).',
    `promotion_eligibility_linked` BOOLEAN COMMENT 'Indicates whether performance in this review period affects promotion eligibility decisions (True/False).',
    `rating_scale_type` STRING COMMENT 'The type of rating scale used for performance evaluations in this review period.',
    `review_due_date` DATE COMMENT 'The deadline by which all performance reviews for this period must be completed and submitted.',
    `review_template_version` STRING COMMENT 'Version identifier of the performance review template or form used for this review period.',
    `start_date` DATE COMMENT 'The date when the review period officially begins. Performance and activities from this date onward are evaluated.',
    `review_period_status` STRING COMMENT 'Current lifecycle status of the review period indicating its operational state.',
    CONSTRAINT pk_review_period PRIMARY KEY(`review_period_id`)
) COMMENT 'Master reference table for review_period. Referenced by review_period_id.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`development_plan` (
    `development_plan_id` BIGINT COMMENT 'Primary key for development_plan',
    `approved_by_staff_profile_id` BIGINT COMMENT 'Reference to the employee or manager who approved this development plan.',
    `department_id` BIGINT COMMENT 'Reference to the department or business unit to which this development plan is aligned.',
    `job_role_id` BIGINT COMMENT 'Reference to the target job role or position that this development plan is preparing the employee for.',
    `performance_review_id` BIGINT COMMENT 'Reference to the performance review that triggered or is associated with this development plan.',
    `manager_staff_profile_id` BIGINT COMMENT 'Reference to the manager or supervisor responsible for overseeing and approving this development plan.',
    `mentor_staff_profile_id` BIGINT COMMENT 'Reference to the mentor or coach assigned to guide the employee through this development plan.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal employee (recruiter, account manager, operations staff) for whom this development plan is created.',
    `linked_development_plan_id` BIGINT COMMENT 'Self-referencing FK on development_plan (linked_development_plan_id)',
    `actual_completion_date` DATE COMMENT 'The actual date when the development plan was completed. Null if not yet completed.',
    `approval_date` DATE COMMENT 'The date when the development plan was formally approved.',
    `approval_status` STRING COMMENT 'Current approval status of the development plan indicating whether it has been reviewed and approved by management.',
    `budget_allocated` DECIMAL(18,2) COMMENT 'The financial budget allocated for executing this development plan, including training, certifications, and resources.',
    `budget_spent` DECIMAL(18,2) COMMENT 'The actual amount of budget spent to date on this development plan.',
    `competencies_targeted` STRING COMMENT 'List or description of the specific competencies, skills, or knowledge areas that this development plan targets for improvement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this development plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget amounts (e.g., USD, EUR, GBP).',
    `development_plan_description` STRING COMMENT 'Detailed narrative description of the development plan objectives, scope, and expected outcomes.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean flag indicating whether this development plan is mandatory (e.g., compliance training, onboarding requirements) or voluntary.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this development plan record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the development plan execution and progress.',
    `objectives` STRING COMMENT 'Specific, measurable objectives or goals that the development plan aims to achieve.',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier or code for the development plan, used for reporting and cross-system reference.',
    `plan_name` STRING COMMENT 'Human-readable name or title of the development plan (e.g., Senior Recruiter Career Path, Leadership Development Track).',
    `plan_type` STRING COMMENT 'Classification of the development plan by its primary purpose (career progression, skill development, leadership, performance improvement, onboarding, succession planning).',
    `priority_level` STRING COMMENT 'Business priority level assigned to this development plan indicating its urgency and importance.',
    `progress_percentage` DECIMAL(18,2) COMMENT 'Percentage of completion for the development plan, calculated based on milestones or activities completed (0.00 to 100.00).',
    `review_date` DATE COMMENT 'The date when the development plan is scheduled for review or progress assessment.',
    `review_frequency` STRING COMMENT 'The scheduled frequency at which progress on this development plan is reviewed.',
    `start_date` DATE COMMENT 'The date when the development plan becomes effective and execution begins.',
    `development_plan_status` STRING COMMENT 'Current lifecycle status of the development plan indicating its operational state.',
    `success_criteria` STRING COMMENT 'Defined criteria or metrics that will be used to determine successful completion of the development plan.',
    `target_completion_date` DATE COMMENT 'The planned or target date by which the development plan should be completed.',
    `version_number` STRING COMMENT 'Version number of the development plan, incremented with each revision or update to track plan evolution.',
    CONSTRAINT pk_development_plan PRIMARY KEY(`development_plan_id`)
) COMMENT 'Master reference table for development_plan. Referenced by linked_development_plan_id.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`territory` (
    `territory_id` BIGINT COMMENT 'Primary key for territory',
    `commission_plan_id` BIGINT COMMENT 'Reference to the commission or compensation plan applicable to this territory.',
    `created_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who created this territory record.',
    `parent_territory_id` BIGINT COMMENT 'Reference to the parent territory in a hierarchical territory structure, enabling multi-level territory organization (e.g., sub-region rolling up to region).',
    `team_id` BIGINT COMMENT 'Reference to the sales or recruiting team assigned to this territory.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the employee (recruiter, account manager, or sales leader) who owns or manages this territory.',
    `updated_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who last updated this territory record.',
    `account_segment` STRING COMMENT 'Target account segment for this territory: enterprise (large corporations), mid_market (medium-sized businesses), small_business (SMB), strategic (key accounts), government (public sector), or non_profit (charitable organizations).',
    `client_target_count` STRING COMMENT 'Target number of active clients to be managed or acquired within this territory.',
    `country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes covered by this territory (e.g., USA,CAN,MEX).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory record was first created in the system.',
    `territory_description` STRING COMMENT 'Detailed textual description of the territory, including coverage notes, strategic focus, and any special considerations.',
    `effective_end_date` DATE COMMENT 'Date when this territory definition expires or is superseded, nullable for open-ended territories.',
    `effective_start_date` DATE COMMENT 'Date when this territory definition becomes active and operational.',
    `geographic_scope` STRING COMMENT 'Textual description of the geographic coverage (e.g., California, Nevada, Arizona or EMEA excluding UK).',
    `hierarchy_level` STRING COMMENT 'Numeric level in the territory hierarchy (e.g., 1 for national, 2 for regional, 3 for local), enabling depth-based queries and reporting.',
    `industry_verticals` STRING COMMENT 'Comma-separated list of industry verticals or sectors assigned to this territory (e.g., Healthcare,Finance,Technology), applicable for industry-based territory models.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether this territory is exclusive (true) or shared among multiple employees (false).',
    `notes` STRING COMMENT 'Free-form notes for internal use, capturing operational details, historical context, or special instructions.',
    `overlap_allowed` BOOLEAN COMMENT 'Indicates whether this territory can overlap with other territories (true) or must be mutually exclusive (false).',
    `placement_target_count` STRING COMMENT 'Target number of candidate placements expected from this territory within the performance period.',
    `postal_code_ranges` STRING COMMENT 'Comma-separated list of postal code ranges or prefixes defining the territory (e.g., 90000-92999,93000-93599).',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the strategic priority of this territory relative to others (lower number = higher priority).',
    `revenue_target_amount` DECIMAL(18,2) COMMENT 'Annual revenue target or quota assigned to this territory, used for performance measurement and planning.',
    `state_province_codes` STRING COMMENT 'Comma-separated list of state or province codes within the territory (e.g., CA,NV,AZ for US states).',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory: active (operational), inactive (not in use), pending (awaiting activation), suspended (temporarily halted), archived (historical), or planned (future territory).',
    `territory_code` STRING COMMENT 'Business identifier code for the territory, used in external communications and reporting.',
    `territory_name` STRING COMMENT 'Human-readable name of the territory (e.g., Northeast Region, California Bay Area, EMEA Central).',
    `territory_type` STRING COMMENT 'Classification of the territory structure: geographic (location-based), industry (vertical-based), account_based (specific client portfolios), hybrid (combination), strategic (key accounts), or named_account (individual major clients).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory record was last modified.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Master reference table for territory. Referenced by territory_id.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`employee`.`job_role` (
    `job_role_id` BIGINT COMMENT 'Primary key for job_role',
    `parent_job_role_id` BIGINT COMMENT 'Self-referencing FK on job_role (parent_job_role_id)',
    `approval_status` STRING COMMENT 'Current approval workflow status for this job role definition, indicating whether it has been reviewed and approved by HR leadership.',
    `approved_by` STRING COMMENT 'Identifier of the user who approved this job role definition for active use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this job role definition was approved.',
    `compensation_grade` STRING COMMENT 'Compensation band or grade assigned to this role within the organizations pay structure.',
    `competencies` STRING COMMENT 'Key skills, behaviors, and competencies required for successful performance in this role, often mapped to a competency framework.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this job role record was first created in the system.',
    `department_id` BIGINT COMMENT 'Reference to the primary department or organizational unit where this role typically resides.',
    `job_role_description` STRING COMMENT 'Detailed narrative description of the roles purpose, scope, and key responsibilities.',
    `effective_end_date` DATE COMMENT 'Date when this job role definition ceased or will cease to be effective. Null for currently active roles.',
    `effective_start_date` DATE COMMENT 'Date when this job role definition became or will become effective and available for use.',
    `employment_type` STRING COMMENT 'Standard employment classification for this role indicating full-time, part-time, contract, or other arrangement.',
    `exempt_status` STRING COMMENT 'Classification under FLSA indicating whether the role is exempt from overtime pay requirements.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether time worked by employees in this role is typically billable to clients or customers.',
    `is_client_facing` BOOLEAN COMMENT 'Indicates whether this role regularly interacts directly with external clients or customers.',
    `job_posting_template` STRING COMMENT 'Standard template or boilerplate text used when creating external job postings for this role.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that most recently modified this job role record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this job role record was most recently updated.',
    `notes` STRING COMMENT 'Additional free-form notes or comments about this job role for internal reference.',
    `performance_metrics` STRING COMMENT 'Key performance indicators or metrics used to evaluate success and performance in this role.',
    `physical_requirements` STRING COMMENT 'Description of any physical demands or requirements necessary to perform this role, relevant for ADA compliance.',
    `preferred_qualifications` STRING COMMENT 'Desirable but not mandatory qualifications, skills, or experience that would enhance performance in this role.',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether this role is eligible for remote or work-from-home arrangements.',
    `reports_to_role_id` BIGINT COMMENT 'Reference to the job role to which this role typically reports in the organizational hierarchy.',
    `required_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for this role.',
    `required_qualifications` STRING COMMENT 'Mandatory educational credentials, certifications, or licenses required to perform this role.',
    `responsibilities` STRING COMMENT 'Comprehensive list of primary duties and responsibilities expected of individuals in this role.',
    `role_code` STRING COMMENT 'Unique business identifier code for the job role used across systems and reporting. Typically a short alphanumeric code assigned by HR.',
    `role_family` STRING COMMENT 'Broad functional family or category to which this role belongs, used for workforce planning and career pathing.',
    `role_level` STRING COMMENT 'Hierarchical level or seniority tier of the role within the organization, used for compensation banding and career progression.',
    `role_title` STRING COMMENT 'Official title of the job role as used in job postings, employment contracts, and organizational charts.',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for salary ranges associated with this role.',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'Maximum annual salary for this role in the organizations base currency.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'Minimum annual salary for this role in the organizations base currency.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Expected number of working hours per week for this role under normal circumstances.',
    `job_role_status` STRING COMMENT 'Current lifecycle status of the job role indicating whether it is actively used for hiring and assignments.',
    `succession_planning_critical` BOOLEAN COMMENT 'Indicates whether this role is designated as critical for succession planning due to business impact or difficulty to fill.',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of work time requiring business travel, expressed as an integer from 0 to 100.',
    `version_number` STRING COMMENT 'Version number of this job role definition, incremented with each significant revision to track changes over time.',
    `work_environment` STRING COMMENT 'Description of the typical work environment and conditions for this role, such as office, field, or hybrid.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this job role record.',
    CONSTRAINT pk_job_role PRIMARY KEY(`job_role_id`)
) COMMENT 'Master reference table for job_role. Referenced by job_role_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ADD CONSTRAINT `fk_employee_staff_profile_job_title_id` FOREIGN KEY (`job_title_id`) REFERENCES `staffing_hr_ecm`.`employee`.`job_title`(`job_title_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ADD CONSTRAINT `fk_employee_staff_profile_manager_staff_profile_id` FOREIGN KEY (`manager_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ADD CONSTRAINT `fk_employee_job_title_parent_job_title_id` FOREIGN KEY (`parent_job_title_id`) REFERENCES `staffing_hr_ecm`.`employee`.`job_title`(`job_title_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ADD CONSTRAINT `fk_employee_department_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ADD CONSTRAINT `fk_employee_department_parent_department_id` FOREIGN KEY (`parent_department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ADD CONSTRAINT `fk_employee_department_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ADD CONSTRAINT `fk_employee_team_commission_plan_id` FOREIGN KEY (`commission_plan_id`) REFERENCES `staffing_hr_ecm`.`employee`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ADD CONSTRAINT `fk_employee_team_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ADD CONSTRAINT `fk_employee_team_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ADD CONSTRAINT `fk_employee_team_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ADD CONSTRAINT `fk_employee_team_team_modified_by_employee_staff_profile_id` FOREIGN KEY (`team_modified_by_employee_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ADD CONSTRAINT `fk_employee_team_team_staff_profile_id` FOREIGN KEY (`team_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ADD CONSTRAINT `fk_employee_team_parent_team_id` FOREIGN KEY (`parent_team_id`) REFERENCES `staffing_hr_ecm`.`employee`.`team`(`team_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ADD CONSTRAINT `fk_employee_team_membership_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ADD CONSTRAINT `fk_employee_team_membership_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ADD CONSTRAINT `fk_employee_team_membership_team_id` FOREIGN KEY (`team_id`) REFERENCES `staffing_hr_ecm`.`employee`.`team`(`team_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ADD CONSTRAINT `fk_employee_team_membership_prior_team_membership_id` FOREIGN KEY (`prior_team_membership_id`) REFERENCES `staffing_hr_ecm`.`employee`.`team_membership`(`team_membership_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ADD CONSTRAINT `fk_employee_role_assignment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ADD CONSTRAINT `fk_employee_role_assignment_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ADD CONSTRAINT `fk_employee_role_assignment_primary_role_staff_profile_id` FOREIGN KEY (`primary_role_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ADD CONSTRAINT `fk_employee_role_assignment_quaternary_role_revoked_by_user_staff_profile_id` FOREIGN KEY (`quaternary_role_revoked_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ADD CONSTRAINT `fk_employee_role_assignment_quinary_role_created_by_user_staff_profile_id` FOREIGN KEY (`quinary_role_created_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ADD CONSTRAINT `fk_employee_role_assignment_tertiary_role_reporting_manager_staff_profile_id` FOREIGN KEY (`tertiary_role_reporting_manager_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ADD CONSTRAINT `fk_employee_role_assignment_superseded_role_assignment_id` FOREIGN KEY (`superseded_role_assignment_id`) REFERENCES `staffing_hr_ecm`.`employee`.`role_assignment`(`role_assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ADD CONSTRAINT `fk_employee_compensation_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ADD CONSTRAINT `fk_employee_compensation_compensation_staff_profile_id` FOREIGN KEY (`compensation_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ADD CONSTRAINT `fk_employee_compensation_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `staffing_hr_ecm`.`employee`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ADD CONSTRAINT `fk_employee_compensation_prior_compensation_id` FOREIGN KEY (`prior_compensation_id`) REFERENCES `staffing_hr_ecm`.`employee`.`compensation`(`compensation_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ADD CONSTRAINT `fk_employee_commission_plan_primary_commission_staff_profile_id` FOREIGN KEY (`primary_commission_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ADD CONSTRAINT `fk_employee_commission_plan_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ADD CONSTRAINT `fk_employee_commission_plan_superseded_commission_plan_id` FOREIGN KEY (`superseded_commission_plan_id`) REFERENCES `staffing_hr_ecm`.`employee`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ADD CONSTRAINT `fk_employee_commission_earning_commission_plan_id` FOREIGN KEY (`commission_plan_id`) REFERENCES `staffing_hr_ecm`.`employee`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ADD CONSTRAINT `fk_employee_commission_earning_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ADD CONSTRAINT `fk_employee_commission_earning_adjustment_commission_earning_id` FOREIGN KEY (`adjustment_commission_earning_id`) REFERENCES `staffing_hr_ecm`.`employee`.`commission_earning`(`commission_earning_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ADD CONSTRAINT `fk_employee_performance_review_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ADD CONSTRAINT `fk_employee_performance_review_reviewer_employee_staff_profile_id` FOREIGN KEY (`reviewer_employee_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ADD CONSTRAINT `fk_employee_performance_review_prior_performance_review_id` FOREIGN KEY (`prior_performance_review_id`) REFERENCES `staffing_hr_ecm`.`employee`.`performance_review`(`performance_review_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ADD CONSTRAINT `fk_employee_performance_goal_development_plan_id` FOREIGN KEY (`development_plan_id`) REFERENCES `staffing_hr_ecm`.`employee`.`development_plan`(`development_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ADD CONSTRAINT `fk_employee_performance_goal_parent_goal_performance_goal_id` FOREIGN KEY (`parent_goal_performance_goal_id`) REFERENCES `staffing_hr_ecm`.`employee`.`performance_goal`(`performance_goal_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ADD CONSTRAINT `fk_employee_performance_goal_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ADD CONSTRAINT `fk_employee_performance_goal_review_period_id` FOREIGN KEY (`review_period_id`) REFERENCES `staffing_hr_ecm`.`employee`.`review_period`(`review_period_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ADD CONSTRAINT `fk_employee_performance_goal_tertiary_performance_approved_by_staff_profile_id` FOREIGN KEY (`tertiary_performance_approved_by_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ADD CONSTRAINT `fk_employee_performance_goal_parent_performance_goal_id` FOREIGN KEY (`parent_performance_goal_id`) REFERENCES `staffing_hr_ecm`.`employee`.`performance_goal`(`performance_goal_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ADD CONSTRAINT `fk_employee_pip_record_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ADD CONSTRAINT `fk_employee_pip_record_quaternary_pip_created_by_user_staff_profile_id` FOREIGN KEY (`quaternary_pip_created_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ADD CONSTRAINT `fk_employee_pip_record_quinary_pip_updated_by_user_staff_profile_id` FOREIGN KEY (`quinary_pip_updated_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ADD CONSTRAINT `fk_employee_pip_record_tertiary_pip_hrbp_staff_profile_id` FOREIGN KEY (`tertiary_pip_hrbp_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ADD CONSTRAINT `fk_employee_pip_record_extended_pip_record_id` FOREIGN KEY (`extended_pip_record_id`) REFERENCES `staffing_hr_ecm`.`employee`.`pip_record`(`pip_record_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ADD CONSTRAINT `fk_employee_leave_request_accrual_policy_id` FOREIGN KEY (`accrual_policy_id`) REFERENCES `staffing_hr_ecm`.`employee`.`accrual_policy`(`accrual_policy_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ADD CONSTRAINT `fk_employee_leave_request_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ADD CONSTRAINT `fk_employee_leave_request_amended_leave_request_id` FOREIGN KEY (`amended_leave_request_id`) REFERENCES `staffing_hr_ecm`.`employee`.`leave_request`(`leave_request_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ADD CONSTRAINT `fk_employee_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `staffing_hr_ecm`.`employee`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ADD CONSTRAINT `fk_employee_benefit_enrollment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ADD CONSTRAINT `fk_employee_benefit_enrollment_prior_benefit_enrollment_id` FOREIGN KEY (`prior_benefit_enrollment_id`) REFERENCES `staffing_hr_ecm`.`employee`.`benefit_enrollment`(`benefit_enrollment_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ADD CONSTRAINT `fk_employee_org_change_event_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ADD CONSTRAINT `fk_employee_org_change_event_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ADD CONSTRAINT `fk_employee_org_change_event_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ADD CONSTRAINT `fk_employee_org_change_event_quaternary_org_initiating_manager_staff_profile_id` FOREIGN KEY (`quaternary_org_initiating_manager_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ADD CONSTRAINT `fk_employee_org_change_event_quinary_org_hr_approver_staff_profile_id` FOREIGN KEY (`quinary_org_hr_approver_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ADD CONSTRAINT `fk_employee_org_change_event_tertiary_org_new_manager_staff_profile_id` FOREIGN KEY (`tertiary_org_new_manager_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ADD CONSTRAINT `fk_employee_org_change_event_reversal_org_change_event_id` FOREIGN KEY (`reversal_org_change_event_id`) REFERENCES `staffing_hr_ecm`.`employee`.`org_change_event`(`org_change_event_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ADD CONSTRAINT `fk_employee_recruiter_desk_commission_plan_id` FOREIGN KEY (`commission_plan_id`) REFERENCES `staffing_hr_ecm`.`employee`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ADD CONSTRAINT `fk_employee_recruiter_desk_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ADD CONSTRAINT `fk_employee_recruiter_desk_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ADD CONSTRAINT `fk_employee_recruiter_desk_quaternary_recruiter_modified_by_employee_staff_profile_id` FOREIGN KEY (`quaternary_recruiter_modified_by_employee_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ADD CONSTRAINT `fk_employee_recruiter_desk_team_id` FOREIGN KEY (`team_id`) REFERENCES `staffing_hr_ecm`.`employee`.`team`(`team_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ADD CONSTRAINT `fk_employee_recruiter_desk_tertiary_recruiter_created_by_employee_staff_profile_id` FOREIGN KEY (`tertiary_recruiter_created_by_employee_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ADD CONSTRAINT `fk_employee_recruiter_desk_parent_recruiter_desk_id` FOREIGN KEY (`parent_recruiter_desk_id`) REFERENCES `staffing_hr_ecm`.`employee`.`recruiter_desk`(`recruiter_desk_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ADD CONSTRAINT `fk_employee_territory_assignment_commission_plan_id` FOREIGN KEY (`commission_plan_id`) REFERENCES `staffing_hr_ecm`.`employee`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ADD CONSTRAINT `fk_employee_territory_assignment_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ADD CONSTRAINT `fk_employee_territory_assignment_primary_predecessor_assignment_territory_assignment_id` FOREIGN KEY (`primary_predecessor_assignment_territory_assignment_id`) REFERENCES `staffing_hr_ecm`.`employee`.`territory_assignment`(`territory_assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ADD CONSTRAINT `fk_employee_territory_assignment_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ADD CONSTRAINT `fk_employee_territory_assignment_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `staffing_hr_ecm`.`employee`.`territory`(`territory_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ADD CONSTRAINT `fk_employee_territory_assignment_tertiary_territory_approved_by_employee_staff_profile_id` FOREIGN KEY (`tertiary_territory_approved_by_employee_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ADD CONSTRAINT `fk_employee_territory_assignment_prior_territory_assignment_id` FOREIGN KEY (`prior_territory_assignment_id`) REFERENCES `staffing_hr_ecm`.`employee`.`territory_assignment`(`territory_assignment_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ADD CONSTRAINT `fk_employee_internal_training_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ADD CONSTRAINT `fk_employee_internal_training_prerequisite_internal_training_id` FOREIGN KEY (`prerequisite_internal_training_id`) REFERENCES `staffing_hr_ecm`.`employee`.`internal_training`(`internal_training_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ADD CONSTRAINT `fk_employee_training_completion_internal_training_id` FOREIGN KEY (`internal_training_id`) REFERENCES `staffing_hr_ecm`.`employee`.`internal_training`(`internal_training_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ADD CONSTRAINT `fk_employee_training_completion_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ADD CONSTRAINT `fk_employee_training_completion_retake_training_completion_id` FOREIGN KEY (`retake_training_completion_id`) REFERENCES `staffing_hr_ecm`.`employee`.`training_completion`(`training_completion_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ADD CONSTRAINT `fk_employee_headcount_position_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ADD CONSTRAINT `fk_employee_headcount_position_internal_requisition_id` FOREIGN KEY (`internal_requisition_id`) REFERENCES `staffing_hr_ecm`.`employee`.`internal_requisition`(`internal_requisition_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ADD CONSTRAINT `fk_employee_headcount_position_job_title_id` FOREIGN KEY (`job_title_id`) REFERENCES `staffing_hr_ecm`.`employee`.`job_title`(`job_title_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ADD CONSTRAINT `fk_employee_headcount_position_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ADD CONSTRAINT `fk_employee_headcount_position_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ADD CONSTRAINT `fk_employee_headcount_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `staffing_hr_ecm`.`employee`.`headcount_position`(`headcount_position_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ADD CONSTRAINT `fk_employee_headcount_position_team_id` FOREIGN KEY (`team_id`) REFERENCES `staffing_hr_ecm`.`employee`.`team`(`team_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ADD CONSTRAINT `fk_employee_headcount_position_reports_to_headcount_position_id` FOREIGN KEY (`reports_to_headcount_position_id`) REFERENCES `staffing_hr_ecm`.`employee`.`headcount_position`(`headcount_position_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ADD CONSTRAINT `fk_employee_internal_requisition_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ADD CONSTRAINT `fk_employee_internal_requisition_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ADD CONSTRAINT `fk_employee_internal_requisition_job_title_id` FOREIGN KEY (`job_title_id`) REFERENCES `staffing_hr_ecm`.`employee`.`job_title`(`job_title_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ADD CONSTRAINT `fk_employee_internal_requisition_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ADD CONSTRAINT `fk_employee_internal_requisition_primary_internal_staff_profile_id` FOREIGN KEY (`primary_internal_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ADD CONSTRAINT `fk_employee_internal_requisition_quaternary_internal_filled_by_employee_staff_profile_id` FOREIGN KEY (`quaternary_internal_filled_by_employee_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ADD CONSTRAINT `fk_employee_internal_requisition_quinary_internal_created_by_employee_staff_profile_id` FOREIGN KEY (`quinary_internal_created_by_employee_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ADD CONSTRAINT `fk_employee_internal_requisition_tertiary_internal_approved_by_employee_staff_profile_id` FOREIGN KEY (`tertiary_internal_approved_by_employee_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ADD CONSTRAINT `fk_employee_internal_requisition_replacement_internal_requisition_id` FOREIGN KEY (`replacement_internal_requisition_id`) REFERENCES `staffing_hr_ecm`.`employee`.`internal_requisition`(`internal_requisition_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ADD CONSTRAINT `fk_employee_disciplinary_action_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ADD CONSTRAINT `fk_employee_disciplinary_action_tertiary_disciplinary_hr_reviewer_staff_profile_id` FOREIGN KEY (`tertiary_disciplinary_hr_reviewer_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ADD CONSTRAINT `fk_employee_disciplinary_action_escalated_disciplinary_action_id` FOREIGN KEY (`escalated_disciplinary_action_id`) REFERENCES `staffing_hr_ecm`.`employee`.`disciplinary_action`(`disciplinary_action_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ADD CONSTRAINT `fk_employee_survey_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ADD CONSTRAINT `fk_employee_survey_job_title_id` FOREIGN KEY (`job_title_id`) REFERENCES `staffing_hr_ecm`.`employee`.`job_title`(`job_title_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ADD CONSTRAINT `fk_employee_survey_office_location_id` FOREIGN KEY (`office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ADD CONSTRAINT `fk_employee_survey_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ADD CONSTRAINT `fk_employee_survey_survey_staff_profile_id` FOREIGN KEY (`survey_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ADD CONSTRAINT `fk_employee_survey_prior_survey_id` FOREIGN KEY (`prior_survey_id`) REFERENCES `staffing_hr_ecm`.`employee`.`survey`(`survey_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ADD CONSTRAINT `fk_employee_office_location_parent_location_office_location_id` FOREIGN KEY (`parent_location_office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ADD CONSTRAINT `fk_employee_office_location_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ADD CONSTRAINT `fk_employee_office_location_parent_office_location_id` FOREIGN KEY (`parent_office_location_id`) REFERENCES `staffing_hr_ecm`.`employee`.`office_location`(`office_location_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_plan` ADD CONSTRAINT `fk_employee_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `staffing_hr_ecm`.`employee`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation_plan` ADD CONSTRAINT `fk_employee_compensation_plan_created_by_employee_staff_profile_id` FOREIGN KEY (`created_by_employee_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation_plan` ADD CONSTRAINT `fk_employee_compensation_plan_last_modified_by_employee_staff_profile_id` FOREIGN KEY (`last_modified_by_employee_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation_plan` ADD CONSTRAINT `fk_employee_compensation_plan_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation_plan` ADD CONSTRAINT `fk_employee_compensation_plan_superseded_compensation_plan_id` FOREIGN KEY (`superseded_compensation_plan_id`) REFERENCES `staffing_hr_ecm`.`employee`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`accrual_policy` ADD CONSTRAINT `fk_employee_accrual_policy_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`accrual_policy` ADD CONSTRAINT `fk_employee_accrual_policy_superseded_by_policy_id` FOREIGN KEY (`superseded_by_policy_id`) REFERENCES `staffing_hr_ecm`.`employee`.`accrual_policy`(`accrual_policy_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`accrual_policy` ADD CONSTRAINT `fk_employee_accrual_policy_superseded_accrual_policy_id` FOREIGN KEY (`superseded_accrual_policy_id`) REFERENCES `staffing_hr_ecm`.`employee`.`accrual_policy`(`accrual_policy_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`review_period` ADD CONSTRAINT `fk_employee_review_period_modified_by_employee_staff_profile_id` FOREIGN KEY (`modified_by_employee_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`review_period` ADD CONSTRAINT `fk_employee_review_period_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`review_period` ADD CONSTRAINT `fk_employee_review_period_prior_review_period_id` FOREIGN KEY (`prior_review_period_id`) REFERENCES `staffing_hr_ecm`.`employee`.`review_period`(`review_period_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` ADD CONSTRAINT `fk_employee_development_plan_approved_by_staff_profile_id` FOREIGN KEY (`approved_by_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` ADD CONSTRAINT `fk_employee_development_plan_department_id` FOREIGN KEY (`department_id`) REFERENCES `staffing_hr_ecm`.`employee`.`department`(`department_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` ADD CONSTRAINT `fk_employee_development_plan_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `staffing_hr_ecm`.`employee`.`job_role`(`job_role_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` ADD CONSTRAINT `fk_employee_development_plan_performance_review_id` FOREIGN KEY (`performance_review_id`) REFERENCES `staffing_hr_ecm`.`employee`.`performance_review`(`performance_review_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` ADD CONSTRAINT `fk_employee_development_plan_manager_staff_profile_id` FOREIGN KEY (`manager_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` ADD CONSTRAINT `fk_employee_development_plan_mentor_staff_profile_id` FOREIGN KEY (`mentor_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` ADD CONSTRAINT `fk_employee_development_plan_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` ADD CONSTRAINT `fk_employee_development_plan_linked_development_plan_id` FOREIGN KEY (`linked_development_plan_id`) REFERENCES `staffing_hr_ecm`.`employee`.`development_plan`(`development_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory` ADD CONSTRAINT `fk_employee_territory_commission_plan_id` FOREIGN KEY (`commission_plan_id`) REFERENCES `staffing_hr_ecm`.`employee`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory` ADD CONSTRAINT `fk_employee_territory_created_by_user_staff_profile_id` FOREIGN KEY (`created_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory` ADD CONSTRAINT `fk_employee_territory_parent_territory_id` FOREIGN KEY (`parent_territory_id`) REFERENCES `staffing_hr_ecm`.`employee`.`territory`(`territory_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory` ADD CONSTRAINT `fk_employee_territory_team_id` FOREIGN KEY (`team_id`) REFERENCES `staffing_hr_ecm`.`employee`.`team`(`team_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory` ADD CONSTRAINT `fk_employee_territory_staff_profile_id` FOREIGN KEY (`staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory` ADD CONSTRAINT `fk_employee_territory_updated_by_user_staff_profile_id` FOREIGN KEY (`updated_by_user_staff_profile_id`) REFERENCES `staffing_hr_ecm`.`employee`.`staff_profile`(`staff_profile_id`);
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_role` ADD CONSTRAINT `fk_employee_job_role_parent_job_role_id` FOREIGN KEY (`parent_job_role_id`) REFERENCES `staffing_hr_ecm`.`employee`.`job_role`(`job_role_id`);

-- ========= TAGS =========
ALTER SCHEMA `staffing_hr_ecm`.`employee` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `staffing_hr_ecm`.`employee` SET TAGS ('dbx_domain' = 'employee');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Profile ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `job_title_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `manager_staff_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Home Address Line 1');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Home Address Line 2');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Home City');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Home Country Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'Yes|No|Prefer Not to Disclose');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `eeo_job_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Job Category');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_value_regex' = 'Spouse|Parent|Sibling|Child|Friend|Other');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `employee_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'Active|On Leave|Terminated|Suspended');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'Full-Time|Part-Time|Contract|Temporary|Intern');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'Exempt|Non-Exempt');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'Male|Female|Non-Binary|Prefer Not to Disclose');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `i9_verification_date` SET TAGS ('dbx_business_glossary_term' = 'I-9 Verification Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `i9_work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'I-9 Work Authorization Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `i9_work_authorization_status` SET TAGS ('dbx_value_regex' = 'US Citizen|Permanent Resident|Work Visa|Pending Verification');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `i9_work_authorization_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `i9_work_authorization_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `original_hire_date` SET TAGS ('dbx_business_glossary_term' = 'Original Hire Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'Hourly|Weekly|Bi-Weekly|Semi-Monthly|Monthly|Annual');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `pay_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `personal_email` SET TAGS ('dbx_business_glossary_term' = 'Personal Email Address');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `personal_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `personal_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `personal_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Home Postal Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `rehire_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehire Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN) Masked');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_value_regex' = '^XXX-XX-d{4}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `ssn_masked` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Home State or Province');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'Voluntary Resignation|Involuntary Termination|Retirement|Layoff|End of Contract|Other');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `veteran_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `veteran_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `work_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `work_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`staff_profile` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `job_title_id` SET TAGS ('dbx_business_glossary_term' = 'Job Title ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `parent_job_title_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `eeo1_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO-1) Job Category');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exemption Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'Exempt|Non-Exempt');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `is_billable_facing` SET TAGS ('dbx_business_glossary_term' = 'Billable-Facing Role Indicator');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `is_executive` SET TAGS ('dbx_business_glossary_term' = 'Executive Position Indicator');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `is_management` SET TAGS ('dbx_business_glossary_term' = 'Management Position Indicator');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `job_title_description` SET TAGS ('dbx_business_glossary_term' = 'Job Title Description');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `job_title_status` SET TAGS ('dbx_business_glossary_term' = 'Job Title Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `job_title_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Deprecated|Pending Approval');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `max_salary` SET TAGS ('dbx_business_glossary_term' = 'Maximum Salary');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `max_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `midpoint_salary` SET TAGS ('dbx_business_glossary_term' = 'Midpoint Salary');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `midpoint_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `min_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `min_education_level` SET TAGS ('dbx_value_regex' = 'High School|Associate Degree|Bachelor Degree|Master Degree|Doctoral Degree|Professional Degree');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `min_salary` SET TAGS ('dbx_business_glossary_term' = 'Minimum Salary');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `min_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `min_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `requires_license` SET TAGS ('dbx_business_glossary_term' = 'Professional License Required Indicator');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Job Title Short Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `soc_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Occupational Classification (SOC) Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `soc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{4}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `title_code` SET TAGS ('dbx_business_glossary_term' = 'Job Title Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `title_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_title` ALTER COLUMN `title_name` SET TAGS ('dbx_business_glossary_term' = 'Job Title Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Office Location ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `parent_department_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Department ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Department Head Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `compliance_tier` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `compliance_tier` SET TAGS ('dbx_value_regex' = 'Standard|Enhanced|Critical');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `department_description` SET TAGS ('dbx_business_glossary_term' = 'Department Description');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_business_glossary_term' = 'Department Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending Closure|Merged');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `department_type` SET TAGS ('dbx_business_glossary_term' = 'Department Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `department_type` SET TAGS ('dbx_value_regex' = 'Revenue Generating|Support|Administrative|Compliance|Shared Services');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Department Email Address');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `headcount_capacity` SET TAGS ('dbx_business_glossary_term' = 'Headcount Capacity');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Department');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Department Phone Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `requires_background_check` SET TAGS ('dbx_business_glossary_term' = 'Requires Background Check (BGC)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = '^[A-Za-z]+/[A-Za-z_]+$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`department` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Office ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Department ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `team_modified_by_employee_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `team_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Team Lead Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `parent_team_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `client_portfolio_size` SET TAGS ('dbx_business_glossary_term' = 'Client Portfolio Size');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `collaboration_model` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Model');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `collaboration_model` SET TAGS ('dbx_value_regex' = 'dedicated|shared|matrix|hybrid');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `current_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `net_promoter_score_target` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Target');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Team Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `placement_target_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Placement Target');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `primary_ats_instance` SET TAGS ('dbx_business_glossary_term' = 'Primary Applicant Tracking System (ATS) Instance');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `quality_of_submission_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Quality of Submission (QoS) Target Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `revenue_target_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `revenue_target_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `service_level_agreement_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `service_level_agreement_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `specialization_tags` SET TAGS ('dbx_business_glossary_term' = 'Specialization Tags');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `target_headcount` SET TAGS ('dbx_business_glossary_term' = 'Target Headcount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `team_code` SET TAGS ('dbx_business_glossary_term' = 'Team Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `team_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Team Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_business_glossary_term' = 'Team Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Team Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `time_to_fill_target_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (TTF) Target Days');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `vertical_focus` SET TAGS ('dbx_business_glossary_term' = 'Vertical Focus');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Work Arrangement');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `team_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Team Membership ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Office Location ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `prior_team_membership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|temporary|project_based|cross_functional');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `client_segment` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Focus');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Area');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `is_team_lead` SET TAGS ('dbx_business_glossary_term' = 'Is Team Lead Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|on_leave');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Membership Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `offboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Team Offboarding Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Team Onboarding Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `primary_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Primary Responsibility');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `reporting_relationship` SET TAGS ('dbx_business_glossary_term' = 'Reporting Relationship Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `reporting_relationship` SET TAGS ('dbx_value_regex' = 'direct|dotted_line|matrix|functional|administrative');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'junior|intermediate|senior|expert|lead');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `target_headcount_contribution` SET TAGS ('dbx_business_glossary_term' = 'Target Headcount Contribution');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `target_revenue_contribution` SET TAGS ('dbx_business_glossary_term' = 'Target Revenue Contribution');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `team_role` SET TAGS ('dbx_business_glossary_term' = 'Team Role');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `team_role` SET TAGS ('dbx_value_regex' = 'recruiter|account_manager|operations_specialist|team_lead|coordinator|analyst');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Membership Termination Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`team_membership` ALTER COLUMN `work_location` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `role_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Role Assignment ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `department_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `primary_role_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `quaternary_role_revoked_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Revoked By User ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `quinary_role_created_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `tertiary_role_reporting_manager_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Manager ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `superseded_role_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'read_only|read_write|admin|super_admin|custom');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired|revoked');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `desk_name` SET TAGS ('dbx_business_glossary_term' = 'Desk Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `is_primary_role` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Role');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `last_access_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Access Review Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `next_access_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Access Review Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Role Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Role Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Role Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'job_role|system_role|functional_responsibility|desk_assignment|territory_assignment');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'System Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`role_assignment` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` SET TAGS ('dbx_subdomain' = 'compensation_incentives');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `compensation_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `prior_compensation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `annual_hours_expected` SET TAGS ('dbx_business_glossary_term' = 'Annual Hours Expected');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `band` SET TAGS ('dbx_business_glossary_term' = 'Compensation Band');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `change_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `compa_ratio` SET TAGS ('dbx_business_glossary_term' = 'Comparative Ratio (Compa-Ratio)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `compa_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|draw_plus_commission|commission_only|contract|stipend');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR|AUD');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `draw_amount` SET TAGS ('dbx_business_glossary_term' = 'Draw Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `draw_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `equity_grant_value` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Value');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `equity_grant_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `is_current_record` SET TAGS ('dbx_business_glossary_term' = 'Is Current Record Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `market_percentile` SET TAGS ('dbx_business_glossary_term' = 'Market Percentile');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `market_percentile` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|semi_monthly|monthly');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `target_bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Bonus Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `target_bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Bonus Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` SET TAGS ('dbx_subdomain' = 'compensation_incentives');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `primary_commission_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `superseded_commission_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `accelerator_rate` SET TAGS ('dbx_business_glossary_term' = 'Accelerator Commission Rate');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `accelerator_threshold` SET TAGS ('dbx_business_glossary_term' = 'Accelerator Threshold Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Approval Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `base_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Commission Rate');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Commission Calculation Basis');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'gross_margin|bill_rate|placement_fee|spread|revenue|net_revenue');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Cap Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `cap_period` SET TAGS ('dbx_business_glossary_term' = 'Commission Cap Period');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `cap_period` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `clawback_condition` SET TAGS ('dbx_business_glossary_term' = 'Clawback Condition');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `clawback_condition` SET TAGS ('dbx_value_regex' = 'candidate_termination|invoice_non_payment|client_cancellation|any_failure');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `clawback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Clawback Period Days');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `draw_amount` SET TAGS ('dbx_business_glossary_term' = 'Draw Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `draw_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `draw_frequency` SET TAGS ('dbx_business_glossary_term' = 'Draw Payment Frequency');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `draw_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `draw_recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Draw Recovery Method');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `draw_recovery_method` SET TAGS ('dbx_value_regex' = 'full_recovery|partial_recovery|non_recoverable|rolling_recovery');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `draw_recovery_percentage` SET TAGS ('dbx_business_glossary_term' = 'Draw Recovery Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Effective Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `minimum_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commission Payout Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Commission Payment Frequency');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|quarterly');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `payment_timing` SET TAGS ('dbx_business_glossary_term' = 'Commission Payment Timing');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `payment_timing` SET TAGS ('dbx_value_regex' = 'upon_invoice|upon_payment|upon_placement|upon_start_date|deferred');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Description');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'gross_margin_split|placement_fee_percentage|spread_based|hybrid|tiered_revenue|flat_rate');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `split_default_percentage` SET TAGS ('dbx_business_glossary_term' = 'Default Commission Split Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `split_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Eligible Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `tier_1_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Commission Rate');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `tier_1_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Threshold Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `tier_2_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Commission Rate');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `tier_2_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Threshold Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `tier_3_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Commission Rate');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_plan` ALTER COLUMN `tier_3_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Threshold Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` SET TAGS ('dbx_subdomain' = 'compensation_incentives');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `commission_earning_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Earning ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `adjustment_commission_earning_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `accelerator_applied` SET TAGS ('dbx_business_glossary_term' = 'Accelerator Applied');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `accelerator_rate` SET TAGS ('dbx_business_glossary_term' = 'Accelerator Rate');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|under_review');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Basis Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `basis_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Basis Currency Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `basis_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `clawback_date` SET TAGS ('dbx_business_glossary_term' = 'Clawback Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `clawback_reason` SET TAGS ('dbx_business_glossary_term' = 'Clawback Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `earning_date` SET TAGS ('dbx_business_glossary_term' = 'Earning Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `earning_event_type` SET TAGS ('dbx_business_glossary_term' = 'Earning Event Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `earning_event_type` SET TAGS ('dbx_value_regex' = 'placement_start|direct_hire_fee|temp_to_perm_conversion|spread_milestone|extension|backfill');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `guarantee_end_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `guarantee_period_days` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Period Days');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `net_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Commission Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|clawed_back|disputed|cancelled');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Split Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `split_reason` SET TAGS ('dbx_business_glossary_term' = 'Split Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`commission_earning` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` SET TAGS ('dbx_subdomain' = 'performance_development');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `reviewer_employee_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `prior_performance_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `acknowledged_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `compensation_change_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Triggered Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `compensation_change_triggered_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `compensation_change_triggered_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `competency_rating_communication` SET TAGS ('dbx_business_glossary_term' = 'Communication Competency Rating');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `competency_rating_communication` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs-improvement|unsatisfactory|not-applicable');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `competency_rating_leadership` SET TAGS ('dbx_business_glossary_term' = 'Leadership Competency Rating');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `competency_rating_leadership` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs-improvement|unsatisfactory|not-applicable');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `competency_rating_teamwork` SET TAGS ('dbx_business_glossary_term' = 'Teamwork Competency Rating');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `competency_rating_teamwork` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs-improvement|unsatisfactory|not-applicable');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `competency_rating_technical` SET TAGS ('dbx_business_glossary_term' = 'Technical Competency Rating');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `competency_rating_technical` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs-improvement|unsatisfactory|not-applicable');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `development_areas_summary` SET TAGS ('dbx_business_glossary_term' = 'Development Areas Summary');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `goals_met_count` SET TAGS ('dbx_business_glossary_term' = 'Goals Met Count');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `goals_total_count` SET TAGS ('dbx_business_glossary_term' = 'Total Goals Count');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `kpi_achievement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Achievement Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding|developing');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `pip_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Initiated Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `promotion_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Triggered Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|90-day|probationary|ad-hoc');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `review_document_url` SET TAGS ('dbx_business_glossary_term' = 'Review Document URL');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'scheduled|in-progress|completed|acknowledged|cancelled|overdue');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'standard|probationary|pip|promotion-readiness|exit|project-based');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Review Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Strengths Summary');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_review` ALTER COLUMN `succession_planning_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` SET TAGS ('dbx_subdomain' = 'performance_development');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `performance_goal_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Goal ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `development_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Development Plan ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `parent_goal_performance_goal_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Goal ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `review_period_id` SET TAGS ('dbx_business_glossary_term' = 'Review Period ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `tertiary_performance_approved_by_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `parent_performance_goal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `achievement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Achievement Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `alignment_level` SET TAGS ('dbx_business_glossary_term' = 'Alignment Level');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `alignment_level` SET TAGS ('dbx_value_regex' = 'individual|team|department|company');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_business_glossary_term' = 'Goal Category');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_value_regex' = 'revenue|activity|quality|development|compliance|client_satisfaction');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `goal_description` SET TAGS ('dbx_business_glossary_term' = 'Goal Description');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `goal_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `goal_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|cancelled|on_hold');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `goal_title` SET TAGS ('dbx_business_glossary_term' = 'Goal Title');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `goal_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Goal Weight Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `is_stretch_goal` SET TAGS ('dbx_business_glossary_term' = 'Is Stretch Goal');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Comments');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `progress_notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `rating_label` SET TAGS ('dbx_business_glossary_term' = 'Rating Label');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `rating_label` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `rating_score` SET TAGS ('dbx_business_glossary_term' = 'Rating Score');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `target_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Metric');
ALTER TABLE `staffing_hr_ecm`.`employee`.`performance_goal` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` SET TAGS ('dbx_subdomain' = 'performance_development');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `pip_record_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Record ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `quaternary_pip_created_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `quinary_pip_updated_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `tertiary_pip_hrbp_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources Business Partner (HRBP) Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `extended_pip_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Performance Improvement Plan (PIP) End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `check_in_frequency` SET TAGS ('dbx_business_glossary_term' = 'Check-In Frequency');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `check_in_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `documentation_complete` SET TAGS ('dbx_business_glossary_term' = 'Documentation Complete Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Extension Count');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `final_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Final Evaluation Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `final_evaluation_summary` SET TAGS ('dbx_business_glossary_term' = 'Final Evaluation Summary');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `improvement_areas` SET TAGS ('dbx_business_glossary_term' = 'Improvement Areas Identified');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `legal_review_conducted` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Conducted Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `measurable_targets` SET TAGS ('dbx_business_glossary_term' = 'Measurable Targets Required');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `original_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original Performance Improvement Plan (PIP) End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `pip_number` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `pip_number` SET TAGS ('dbx_value_regex' = '^PIP-[0-9]{6,10}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `pip_outcome` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Outcome');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `pip_outcome` SET TAGS ('dbx_value_regex' = 'successfully_completed|extended|employment_terminated|employee_resigned|pip_withdrawn');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `pip_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `pip_status` SET TAGS ('dbx_value_regex' = 'active|successfully_completed|extended|terminated|resigned|withdrawn');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `pip_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `pip_type` SET TAGS ('dbx_value_regex' = 'performance|conduct|attendance|combination');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `prior_action_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Disciplinary Action Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `prior_disciplinary_action` SET TAGS ('dbx_business_glossary_term' = 'Prior Disciplinary Action');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `prior_disciplinary_action` SET TAGS ('dbx_value_regex' = 'none|verbal_warning|written_warning|suspension|prior_pip');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `protected_class_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Class Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `severance_offered` SET TAGS ('dbx_business_glossary_term' = 'Severance Offered Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `support_resources_provided` SET TAGS ('dbx_business_glossary_term' = 'Support Resources Provided');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Employment Termination Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `termination_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Termination Risk Level');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `termination_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `unemployment_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Unemployment Compensation Eligibility');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `unemployment_eligibility` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|contested');
ALTER TABLE `staffing_hr_ecm`.`employee`.`pip_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` SET TAGS ('dbx_subdomain' = 'compensation_incentives');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `accrual_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Policy ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `amended_leave_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `actual_days_taken` SET TAGS ('dbx_business_glossary_term' = 'Actual Days Taken');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `actual_hours_taken` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Taken');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `balance_after_leave` SET TAGS ('dbx_business_glossary_term' = 'Balance After Leave');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `balance_before_leave` SET TAGS ('dbx_business_glossary_term' = 'Balance Before Leave');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `benefits_continuation_flag` SET TAGS ('dbx_business_glossary_term' = 'Benefits Continuation Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `documentation_received_date` SET TAGS ('dbx_business_glossary_term' = 'Documentation Received Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Documentation Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `documentation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|received|approved|rejected');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Case Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `fmla_hours_used_ytd` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Hours Used Year-to-Date (YTD)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `is_fmla_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is FMLA (Family and Medical Leave Act) Eligible');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `is_intermittent_leave` SET TAGS ('dbx_business_glossary_term' = 'Is Intermittent Leave');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `is_paid_leave` SET TAGS ('dbx_business_glossary_term' = 'Is Paid Leave');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `is_reduced_schedule` SET TAGS ('dbx_business_glossary_term' = 'Is Reduced Schedule');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `leave_end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `leave_start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `leave_subtype` SET TAGS ('dbx_business_glossary_term' = 'Leave Subtype');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Comments');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `payroll_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Impact Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|cancelled|withdrawn');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `requires_documentation` SET TAGS ('dbx_business_glossary_term' = 'Requires Documentation');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `total_days_requested` SET TAGS ('dbx_business_glossary_term' = 'Total Days Requested');
ALTER TABLE `staffing_hr_ecm`.`employee`.`leave_request` ALTER COLUMN `total_hours_requested` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Requested');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'compensation_incentives');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `prior_benefit_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `beneficiary_percentage` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Relationship');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `cobra_election_deadline` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Election Deadline');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|family|employee_domestic_partner');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `election_date` SET TAGS ('dbx_business_glossary_term' = 'Election Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online_portal|paper_form|phone|benefits_fair|auto_enrollment|hr_system');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'open_enrollment|new_hire|qualifying_life_event|annual_renewal|rehire|status_change');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|suspended|waived|cancelled');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `enrollment_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Event Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `org_change_event_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Change Event ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Department ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Office Location ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `quaternary_org_initiating_manager_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Manager Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `quinary_org_hr_approver_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Approver Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `tertiary_org_new_manager_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'New Manager Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `reversal_org_change_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `changed_attribute_name` SET TAGS ('dbx_business_glossary_term' = 'Changed Attribute Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `compensation_change_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Triggered Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `compensation_change_triggered_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `compensation_change_triggered_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `event_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Event Effective Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|approved|effective|cancelled|reversed');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'promotion|demotion|lateral_transfer|department_change|manager_change|title_change');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `is_termination_event` SET TAGS ('dbx_business_glossary_term' = 'Is Termination Event Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `last_working_date` SET TAGS ('dbx_business_glossary_term' = 'Last Working Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `new_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'New Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `new_employment_type` SET TAGS ('dbx_business_glossary_term' = 'New Employment Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `new_employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `new_job_title` SET TAGS ('dbx_business_glossary_term' = 'New Job Title');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `prior_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `prior_employment_type` SET TAGS ('dbx_business_glossary_term' = 'Prior Employment Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `prior_employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `prior_job_title` SET TAGS ('dbx_business_glossary_term' = 'Prior Job Title');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `prior_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Value');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `rehire_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `source_system_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `termination_type` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|retirement|end_of_contract');
ALTER TABLE `staffing_hr_ecm`.`employee`.`org_change_event` ALTER COLUMN `workflow_instance_reference` SET TAGS ('dbx_business_glossary_term' = 'Workflow Instance ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` SET TAGS ('dbx_subdomain' = 'territory_training');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `recruiter_desk_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Desk ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Office ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Recruiter ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `quaternary_recruiter_modified_by_employee_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `tertiary_recruiter_created_by_employee_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `parent_recruiter_desk_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `annual_placement_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Placement Target');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `ats_instance` SET TAGS ('dbx_business_glossary_term' = 'Applicant Tracking System (ATS) Instance');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `client_portfolio_size` SET TAGS ('dbx_business_glossary_term' = 'Client Portfolio Size');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `collaboration_model` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Model');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `collaboration_model` SET TAGS ('dbx_value_regex' = 'individual|pod|team_based|matrix');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `current_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `desk_close_date` SET TAGS ('dbx_business_glossary_term' = 'Desk Close Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `desk_code` SET TAGS ('dbx_business_glossary_term' = 'Desk Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `desk_name` SET TAGS ('dbx_business_glossary_term' = 'Desk Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `desk_open_date` SET TAGS ('dbx_business_glossary_term' = 'Desk Open Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `desk_status` SET TAGS ('dbx_business_glossary_term' = 'Desk Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `desk_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|ramping|closed');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `desk_type` SET TAGS ('dbx_business_glossary_term' = 'Desk Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `desk_type` SET TAGS ('dbx_value_regex' = 'vertical_specific|geography_specific|client_dedicated|generalist|hybrid');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `geographic_territory` SET TAGS ('dbx_business_glossary_term' = 'Geographic Territory');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `job_categories_covered` SET TAGS ('dbx_business_glossary_term' = 'Job Categories Covered');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `nps_target` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Target');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `primary_vertical` SET TAGS ('dbx_business_glossary_term' = 'Primary Vertical');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `qos_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality of Submission (QoS) Target Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `req_routing_priority` SET TAGS ('dbx_business_glossary_term' = 'Requisition (Req) Routing Priority');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `secondary_vertical` SET TAGS ('dbx_business_glossary_term' = 'Secondary Vertical');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise|strategic');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `specialization_tags` SET TAGS ('dbx_business_glossary_term' = 'Specialization Tags');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `target_headcount` SET TAGS ('dbx_business_glossary_term' = 'Target Headcount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `target_industries` SET TAGS ('dbx_business_glossary_term' = 'Target Industries');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `ttf_target_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (TTF) Target Days');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Work Arrangement');
ALTER TABLE `staffing_hr_ecm`.`employee`.`recruiter_desk` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` SET TAGS ('dbx_subdomain' = 'territory_training');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `territory_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Office Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `primary_predecessor_assignment_territory_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Assignment Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `tertiary_territory_approved_by_employee_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `prior_territory_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `account_segment` SET TAGS ('dbx_business_glossary_term' = 'Account Segment');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `account_segment` SET TAGS ('dbx_value_regex' = 'enterprise|mid_market|smb|strategic|emerging');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_value_regex' = 'primary|secondary|backup|split|overlay');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired|transferred');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Assignment Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `is_remote_territory` SET TAGS ('dbx_business_glossary_term' = 'Remote Territory Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `named_accounts_count` SET TAGS ('dbx_business_glossary_term' = 'Named Accounts Count');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|developing');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|strategic|tactical');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Quota Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `quota_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `quota_period` SET TAGS ('dbx_business_glossary_term' = 'Quota Period');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `quota_period` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|semi_annual');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `service_level_agreement_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `service_level_agreement_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `specialization_tags` SET TAGS ('dbx_business_glossary_term' = 'Specialization Tags');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `target_headcount` SET TAGS ('dbx_business_glossary_term' = 'Target Headcount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `transition_notes` SET TAGS ('dbx_business_glossary_term' = 'Transition Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory_assignment` ALTER COLUMN `vertical_focus` SET TAGS ('dbx_business_glossary_term' = 'Vertical Focus');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` SET TAGS ('dbx_subdomain' = 'territory_training');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `internal_training_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Training ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `prerequisite_internal_training_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `applicable_job_families` SET TAGS ('dbx_business_glossary_term' = 'Applicable Job Families');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `assessment_required` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `certification_awarded` SET TAGS ('dbx_business_glossary_term' = 'Certification Awarded');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `competency_category` SET TAGS ('dbx_business_glossary_term' = 'Competency Category');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `competency_category` SET TAGS ('dbx_value_regex' = 'technical|behavioral|leadership|compliance|sales|operational');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `content_url` SET TAGS ('dbx_business_glossary_term' = 'Content URL (Uniform Resource Locator)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Participant');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'in_person|virtual|lms|on_the_job|blended');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `internal_training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `internal_training_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired|under_review');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Is Required Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `last_content_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Content Update Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `learning_objectives` SET TAGS ('dbx_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `materials_description` SET TAGS ('dbx_business_glossary_term' = 'Materials Description');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `max_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `prerequisites` SET TAGS ('dbx_business_glossary_term' = 'Prerequisites');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = 'internal|external_vendor|lms_platform|industry_association');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `recertification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency Months');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Training Short Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `target_audience_description` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `training_code` SET TAGS ('dbx_business_glossary_term' = 'Training Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `training_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `training_name` SET TAGS ('dbx_business_glossary_term' = 'Training Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_training` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` SET TAGS ('dbx_subdomain' = 'territory_training');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `internal_training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `retake_training_completion_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Assessment Result');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `assessment_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_assessed|pending');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `attempts_count` SET TAGS ('dbx_business_glossary_term' = 'Attempts Count');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'enrolled|in_progress|completed|failed|expired|withdrawn');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `employee_feedback` SET TAGS ('dbx_business_glossary_term' = 'Employee Feedback');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `employee_rating` SET TAGS ('dbx_business_glossary_term' = 'Employee Rating');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `is_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Is Compliance Required Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `manager_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Manager Acknowledgment Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `manager_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Manager Acknowledgment Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `max_attempts_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Attempts Allowed');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `next_recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recertification Due Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `recertification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency in Months');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Training Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_value_regex' = 'online|in_person|virtual_instructor_led|blended|self_paced');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Hours');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `training_program_name` SET TAGS ('dbx_business_glossary_term' = 'Training Program Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`training_completion` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `headcount_position_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Position ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `internal_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition (Req) ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `job_title_id` SET TAGS ('dbx_business_glossary_term' = 'Job Title ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Office Location ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Filled By Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `reports_to_headcount_position_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `annual_burden_rate` SET TAGS ('dbx_business_glossary_term' = 'Annual Burden Rate');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `annual_burden_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `approved_headcount_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `budgeted_salary_max` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Salary Maximum');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `budgeted_salary_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `budgeted_salary_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Salary Midpoint');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `budgeted_salary_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `budgeted_salary_min` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Salary Minimum');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `budgeted_salary_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `fte_type` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `fte_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|job_share|seasonal');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `fte_value` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Value');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `is_billable_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Facing Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `is_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Is Budgeted Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `is_executive` SET TAGS ('dbx_business_glossary_term' = 'Is Executive Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `is_management` SET TAGS ('dbx_business_glossary_term' = 'Is Management Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `min_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `min_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `min_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years Experience');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `position_filled_date` SET TAGS ('dbx_business_glossary_term' = 'Position Filled Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'filled|vacant|frozen|eliminated|pending_approval|on_hold');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `position_title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `requires_background_check` SET TAGS ('dbx_business_glossary_term' = 'Requires Background Check (BGC) Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `requires_drug_screen` SET TAGS ('dbx_business_glossary_term' = 'Requires Drug Screen Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `specialization_tags` SET TAGS ('dbx_business_glossary_term' = 'Specialization Tags');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `succession_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Work Arrangement');
ALTER TABLE `staffing_hr_ecm`.`employee`.`headcount_position` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `internal_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Requisition ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Department ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `job_title_id` SET TAGS ('dbx_business_glossary_term' = 'Job Title ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Office Location ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `primary_internal_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `quaternary_internal_filled_by_employee_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Filled By Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `quinary_internal_created_by_employee_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `tertiary_internal_approved_by_employee_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `replacement_internal_requisition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|withdrawn');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `closure_reason` SET TAGS ('dbx_value_regex' = 'filled|cancelled|on_hold|budget_cut|position_eliminated|merged_with_other_req');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{4,6}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `eeoc_job_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity Commission (EEOC) Job Category');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|seasonal|intern');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `max_salary` SET TAGS ('dbx_business_glossary_term' = 'Maximum Salary');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `max_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `min_salary` SET TAGS ('dbx_business_glossary_term' = 'Minimum Salary');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `min_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `number_of_openings` SET TAGS ('dbx_business_glossary_term' = 'Number of Openings');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `preferred_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Qualifications');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `req_close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `req_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition (Req) Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `req_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `req_open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `req_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `req_status` SET TAGS ('dbx_value_regex' = 'draft|open|on_hold|filled|cancelled|closed');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `req_title` SET TAGS ('dbx_business_glossary_term' = 'Requisition Title');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `req_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `req_type` SET TAGS ('dbx_value_regex' = 'backfill|new_headcount|expansion|replacement|temporary_coverage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `required_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Required Qualifications');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `requires_background_check` SET TAGS ('dbx_business_glossary_term' = 'Requires Background Check (BGC)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `requires_drug_screen` SET TAGS ('dbx_business_glossary_term' = 'Requires Drug Screen');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `sourcing_channel` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channel');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `sourcing_channel` SET TAGS ('dbx_value_regex' = 'internal_transfer|external_hire|employee_referral|agency|campus_recruitment|direct_sourcing');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (TTF) Days');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`internal_requisition` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'onsite|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` SET TAGS ('dbx_subdomain' = 'performance_development');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `disciplinary_action_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_hr_reviewer_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Reviewer Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `escalated_disciplinary_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Action Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'verbal_warning|written_warning|final_written_warning|suspension|termination|performance_improvement_plan');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `appeal_notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'pending|upheld|overturned|modified|withdrawn');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `disciplinary_action_status` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `disciplinary_action_status` SET TAGS ('dbx_value_regex' = 'active|completed|appealed|overturned|expired');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Document URL');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `eeoc_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity Commission (EEOC) Risk Level');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `eeoc_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `hr_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Approval Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `hr_notes` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `infraction_category` SET TAGS ('dbx_business_glossary_term' = 'Infraction Category');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `infraction_category` SET TAGS ('dbx_value_regex' = 'attendance|performance|conduct|policy_violation|compliance_breach|safety_violation');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `infraction_description` SET TAGS ('dbx_business_glossary_term' = 'Infraction Description');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `infraction_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Infraction Subcategory');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `legal_counsel_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Involved Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Comments');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `prior_action_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Disciplinary Action Count');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `protected_class_consideration_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Class Consideration Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `suspension_days` SET TAGS ('dbx_business_glossary_term' = 'Suspension Days');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `suspension_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspension Paid Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`disciplinary_action` ALTER COLUMN `witness_employee_ids` SET TAGS ('dbx_business_glossary_term' = 'Witness Employee IDs');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` SET TAGS ('dbx_subdomain' = 'performance_development');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Survey ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `job_title_id` SET TAGS ('dbx_business_glossary_term' = 'Job Title ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Office Location ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `survey_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `survey_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `survey_staff_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `prior_survey_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `action_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Required Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `career_development_score` SET TAGS ('dbx_business_glossary_term' = 'Career Development Score');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `collaboration_score` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Score');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `compensation_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Compensation Satisfaction Score');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `compensation_satisfaction_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `compensation_satisfaction_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `consent_to_attribution` SET TAGS ('dbx_business_glossary_term' = 'Consent to Attribution Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `culture_score` SET TAGS ('dbx_business_glossary_term' = 'Culture Score');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Due Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `enps_category` SET TAGS ('dbx_business_glossary_term' = 'Employee Net Promoter Score (eNPS) Category');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `enps_category` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `enps_score` SET TAGS ('dbx_business_glossary_term' = 'Employee Net Promoter Score (eNPS)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `follow_up_requested` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Requested Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `invitation_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Invitation Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Is Anonymous Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `manager_effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Manager Effectiveness Score');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `open_ended_comments` SET TAGS ('dbx_business_glossary_term' = 'Open-Ended Comments');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `open_ended_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `overall_engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Engagement Score');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Period End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `recognition_score` SET TAGS ('dbx_business_glossary_term' = 'Recognition Score');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `resources_tools_score` SET TAGS ('dbx_business_glossary_term' = 'Resources and Tools Score');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `response_channel` SET TAGS ('dbx_business_glossary_term' = 'Response Channel');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `response_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|email|kiosk|paper');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `response_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Response Completion Percentage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'completed|partial|not_started|declined');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `tenure_months` SET TAGS ('dbx_business_glossary_term' = 'Tenure in Months');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `vendor` SET TAGS ('dbx_business_glossary_term' = 'Survey Vendor');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `staffing_hr_ecm`.`employee`.`survey` ALTER COLUMN `work_life_balance_score` SET TAGS ('dbx_business_glossary_term' = 'Work-Life Balance Score');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Office Location Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `parent_location_office_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Location Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Manager Employee Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `parent_office_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `ats_instance_code` SET TAGS ('dbx_business_glossary_term' = 'Applicant Tracking System (ATS) Instance Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `is_client_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Client Facing Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `is_remote_work_hub` SET TAGS ('dbx_business_glossary_term' = 'Is Remote Work Hub Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Start Date');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'owned|leased|subleased|coworking|virtual');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'branch_office|corporate_hq|regional_hub|remote_hub|satellite_office|shared_services_center');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `monthly_rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Rent Amount');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `monthly_rent_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `office_location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `office_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_opening|temporarily_closed|permanently_closed|under_renovation');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `parking_available` SET TAGS ('dbx_business_glossary_term' = 'Parking Available Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `public_transit_accessible` SET TAGS ('dbx_business_glossary_term' = 'Public Transit Accessible Flag');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `staffing_hr_ecm`.`employee`.`office_location` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'compensation_incentives');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_plan` ALTER COLUMN `plan_administrator_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`benefit_plan` ALTER COLUMN `plan_administrator_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'compensation_incentives');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Identifier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`accrual_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`accrual_policy` SET TAGS ('dbx_subdomain' = 'compensation_incentives');
ALTER TABLE `staffing_hr_ecm`.`employee`.`accrual_policy` ALTER COLUMN `accrual_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Policy Identifier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`accrual_policy` ALTER COLUMN `superseded_accrual_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`review_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`review_period` SET TAGS ('dbx_subdomain' = 'performance_development');
ALTER TABLE `staffing_hr_ecm`.`employee`.`review_period` ALTER COLUMN `review_period_id` SET TAGS ('dbx_business_glossary_term' = 'Review Period Identifier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`review_period` ALTER COLUMN `prior_review_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` SET TAGS ('dbx_subdomain' = 'performance_development');
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` ALTER COLUMN `development_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Identifier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` ALTER COLUMN `linked_development_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`development_plan` ALTER COLUMN `budget_spent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory` SET TAGS ('dbx_subdomain' = 'territory_training');
ALTER TABLE `staffing_hr_ecm`.`employee`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_role` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_role` SET TAGS ('dbx_subdomain' = 'territory_training');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_role` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Identifier');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_role` ALTER COLUMN `parent_job_role_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_role` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_role` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`employee`.`job_role` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
