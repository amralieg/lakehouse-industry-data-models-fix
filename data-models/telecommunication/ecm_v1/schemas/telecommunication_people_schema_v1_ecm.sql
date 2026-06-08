-- Schema for Domain: people | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:49

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`people` COMMENT 'SSOT for all internal workforce identities, organizational structure, HR master data, employee records, roles, departments, and reporting hierarchies across the telecommunications enterprise';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key for the employee entity. System-generated surrogate key used across all internal systems.',
    `location_site_id` BIGINT COMMENT 'Reference to the primary physical work location or office where the employee is based. Used for space planning, emergency response, and regional compliance.',
    `manager_employee_id` BIGINT COMMENT 'Reference to the employee record of this employees direct manager. Used for reporting hierarchy, approval workflows, and organizational structure visualization.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department to which the employee is assigned. Used for cost allocation, reporting hierarchies, and organizational analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the system. Used for data lineage, audit trails, and record lifecycle tracking.',
    `date_of_birth` DATE COMMENT 'Employees date of birth. Used for age verification, benefits eligibility, retirement planning, and compliance with labor laws.',
    `emergency_contact_name` STRING COMMENT 'Full name of the person to contact in case of employee emergency. Used for workplace incidents, medical emergencies, and critical notifications.',
    `emergency_contact_phone` STRING COMMENT 'Primary phone number for the designated emergency contact. Used for urgent notifications and workplace incident response.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee (e.g., spouse, parent, sibling, friend). Used to validate contact authority and prioritize notifications.',
    `employee_number` STRING COMMENT 'Business-facing unique employee identifier assigned by Human Resources. Used on badges, timesheets, and payroll systems. Externally-known identifier for the employee.. Valid values are `^[A-Z0-9]{6,12}$`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee within the organization. Determines access rights, payroll processing, and system permissions.. Valid values are `active|on-leave|suspended|terminated|retired|deceased`',
    `employment_type` STRING COMMENT 'Classification of the employees employment arrangement. Determines benefits eligibility, work schedule expectations, and contract terms.. Valid values are `full-time|part-time|fixed-term|seasonal|intern|contractor`',
    `fte_percentage` DECIMAL(18,2) COMMENT 'Percentage of full-time hours the employee is contracted to work. 100.00 represents full-time; part-time employees have values less than 100. Used for headcount reporting and capacity planning.',
    `gender` STRING COMMENT 'Employees self-identified gender. Used for diversity reporting, benefits administration, and compliance with equal employment opportunity regulations.. Valid values are `male|female|non-binary|prefer not to say|other|unknown`',
    `hire_date` DATE COMMENT 'Date the employee most recently joined the organization. For rehires, this is the date of the most recent hire event. Used for seniority calculations, benefits vesting, and anniversary recognition.',
    `hr_system_source_code` STRING COMMENT 'Original identifier from the source HR system of record. Used for data lineage, system integration, and reconciliation with upstream HR platforms.',
    `job_title` STRING COMMENT 'Employees current job title or position name. Used for organizational charts, business cards, email signatures, and role-based access control.',
    `legal_first_name` STRING COMMENT 'Employees legal first name as it appears on government-issued identification documents. Used for payroll, tax forms, and official HR records.',
    `legal_last_name` STRING COMMENT 'Employees legal last name (surname/family name) as it appears on government-issued identification documents. Used for payroll, tax forms, and official HR records.',
    `legal_middle_name` STRING COMMENT 'Employees legal middle name or initial as it appears on government-issued identification documents. Optional field; may be null if not applicable.',
    `marital_status` STRING COMMENT 'Employees current marital status. Used for tax withholding calculations, benefits enrollment, and emergency contact validation.. Valid values are `single|married|divorced|widowed|separated|domestic partnership`',
    `national_id_number` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number in USA, National Insurance Number in UK). Used for tax reporting, benefits administration, and legal compliance.',
    `nationality` STRING COMMENT 'Employees country of citizenship using ISO 3166-1 alpha-3 country code. Used for work authorization verification, international assignment eligibility, and compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `notice_period_days` STRING COMMENT 'Number of days of advance notice required for voluntary resignation or termination, as specified in the employment contract. Used for workforce planning and transition management.',
    `original_hire_date` DATE COMMENT 'Date the employee first joined the organization, even if they left and were rehired. Used for calculating total service time and long-term benefits eligibility.',
    `pay_grade` STRING COMMENT 'Employees compensation grade or band within the organizations salary structure. Used for compensation planning, equity analysis, and career progression tracking.',
    `personal_email` STRING COMMENT 'Employees personal email address. Used for emergency communications, benefits notifications, and post-employment correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `personal_mobile` STRING COMMENT 'Employees personal mobile phone number. Used for emergency contact, two-factor authentication, and urgent business communications.',
    `preferred_language` STRING COMMENT 'Employees preferred language for business communications and system interfaces, using ISO 639-1 two-letter language code. Used for localization, training materials, and HR communications.. Valid values are `^[a-z]{2}$`',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in day-to-day business interactions. May differ from legal name. Used in email signatures, directory listings, and internal communications.',
    `probation_end_date` DATE COMMENT 'Date the employees probationary period ends. Used to trigger performance reviews, benefits eligibility changes, and employment status updates.',
    `rehire_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire based on their employment history and termination circumstances. Used for recruitment screening and applicant tracking.',
    `security_clearance_level` STRING COMMENT 'Employees security clearance or access authorization level. Used for physical access control, data access permissions, and project assignment eligibility. Null if no clearance required.',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Null for active employees. Used for final payroll processing, benefits termination, and access revocation.',
    `termination_reason` STRING COMMENT 'Primary reason for employment termination. Used for turnover analysis, exit interview tracking, and rehire eligibility determination. Null for active employees.. Valid values are `voluntary resignation|involuntary termination|retirement|end of contract|layoff|mutual agreement`',
    `union_membership_flag` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union. Used for collective bargaining agreement compliance, dues deduction, and labor relations reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last modified. Used for change tracking, data synchronization, and audit compliance.',
    `work_email` STRING COMMENT 'Employees primary corporate email address. Used for business communications, system notifications, and authentication. Typically follows company email naming convention.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_phone` STRING COMMENT 'Employees primary work phone number (desk phone or assigned mobile). Used for business contact and directory listings.',
    `work_schedule_type` STRING COMMENT 'Classification of the employees work schedule pattern. Used for time tracking, shift planning, and workforce management.. Valid values are `standard|shift|flexible|remote|hybrid|on-call`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for every internal workforce identity across the telecommunications enterprise — full-time, part-time, and fixed-term employees. Captures legal name, employee number, national ID, date of birth, gender, marital status, nationality, employment type, employment status (active, on-leave, terminated, retired), hire date, original hire date (for rehires), termination date, termination reason, probation end date, notice period, work location, primary work email, work phone, personal email, personal mobile, emergency contact name and relationship, emergency contact phone, preferred language, and HR system source identifier. This is the SSOT for all internal person identities and is the anchor entity for the entire people domain. Distinct from workforce.technician (field operations personnel) and customer.subscriber (external subscribers).';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit within the telecommunications enterprise hierarchy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Organizational units map to cost centers for hierarchy-based budget rollups and management reporting. Telecommunications requires alignment between HR org structure and financial reporting structure. ',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity to which this organizational unit belongs, used for financial consolidation, regulatory reporting, and compliance purposes.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy, enabling multi-level organizational structure traversal and roll-up reporting. Null for top-level units.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Organizational units in telecommunications align to profit centers for P&L reporting by business segment (consumer mobile, enterprise, wholesale). Enables revenue/cost center alignment and segment pro',
    `actual_headcount` STRING COMMENT 'Current actual headcount or number of employees assigned to this organizational unit, used for variance analysis against budget.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total annual operating budget allocated to this organizational unit for OPEX (Operational Expenditure) planning and financial control.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual budget amount, supporting multi-currency enterprise operations.. Valid values are `^[A-Z]{3}$`',
    `business_unit_code` STRING COMMENT 'Higher-level business unit code to which this organizational unit belongs, used for strategic reporting and business segment analysis.. Valid values are `^[A-Z0-9]{2,10}$`',
    `city` STRING COMMENT 'City or municipality where the organizational unit is primarily located or headquartered.',
    `contact_email` STRING COMMENT 'Primary email address for contacting this organizational unit, used for internal communication and directory services.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for contacting this organizational unit, used for internal communication and directory services.',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the primary country of operation for this organizational unit.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system, supporting audit trail and data lineage requirements.',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit ceased operations or was dissolved. Null for currently active units. Supports historical organizational structure analysis.',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit became active and operational within the enterprise structure, supporting temporal hierarchy modeling.',
    `functional_area` STRING COMMENT 'Primary functional area or business domain classification of the organizational unit (e.g., network operations, commercial, finance, IT, HR, legal, regulatory, customer service). [ENUM-REF-CANDIDATE: network_operations|commercial|finance|information_technology|human_resources|legal|regulatory|customer_service|engineering|marketing|sales|procurement|supply_chain — 13 candidates stripped; promote to reference product]',
    `geographic_region` STRING COMMENT 'Geographic region or territory served or managed by this organizational unit, used for regional reporting and market segmentation.',
    `head_employee_id` BIGINT COMMENT 'Reference to the employee who serves as the head, manager, or leader of this organizational unit, responsible for its operations and performance.',
    `headcount_budget` STRING COMMENT 'Approved headcount budget or authorized number of full-time equivalent (FTE) positions allocated to this organizational unit for workforce planning.',
    `hierarchy_level` STRING COMMENT 'Numeric level of this organizational unit within the enterprise hierarchy, with 1 being the top level (e.g., CEO office) and increasing numbers representing deeper levels.',
    `hierarchy_path` STRING COMMENT 'Full hierarchical path from root to this organizational unit, typically represented as a delimited string of org unit codes or IDs for efficient hierarchy queries.',
    `is_customer_facing` BOOLEAN COMMENT 'Flag indicating whether this organizational unit has direct customer interaction responsibilities (e.g., customer service, sales, field operations).',
    `is_revenue_generating` BOOLEAN COMMENT 'Flag indicating whether this organizational unit directly generates revenue (e.g., sales, commercial units) or is a support/cost center.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last updated, supporting change tracking and audit compliance.',
    `manager_title` STRING COMMENT 'Official job title of the organizational unit head or manager (e.g., Vice President, Director, Manager, Team Lead).',
    `office_location` STRING COMMENT 'Specific office location, building name, or site identifier where the organizational unit is physically located.',
    `org_unit_code` STRING COMMENT 'Business identifier code for the organizational unit, used in financial systems, reporting hierarchies, and access control. Typically alphanumeric and unique across the enterprise.. Valid values are `^[A-Z0-9]{3,20}$`',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units purpose, responsibilities, scope of work, and role within the broader enterprise structure.',
    `org_unit_name` STRING COMMENT 'Official name of the organizational unit as recognized in corporate documentation, organizational charts, and HR systems.',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit indicating whether it is active, inactive, pending activation, suspended, dissolved, or merged into another unit.. Valid values are `active|inactive|pending|suspended|dissolved|merged`',
    `org_unit_type` STRING COMMENT 'Classification of the organizational unit indicating its hierarchical level and structural role within the enterprise (e.g., division, department, team, cost center group, business unit). [ENUM-REF-CANDIDATE: division|department|team|cost_center_group|business_unit|function|region|subsidiary — 8 candidates stripped; promote to reference product]',
    `short_name` STRING COMMENT 'Abbreviated or short form name of the organizational unit used in reports, dashboards, and user interfaces where space is limited.',
    `sla_tier` STRING COMMENT 'SLA tier classification for this organizational unit indicating priority level for internal service delivery and support escalation.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the primary operating location of this organizational unit, used for scheduling and workforce management.',
    `workforce_type` STRING COMMENT 'Primary workforce composition type for this organizational unit (e.g., permanent employees, contractors, hybrid, outsourced, offshore).. Valid values are `permanent|contract|hybrid|outsourced|offshore`',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Master record for every organizational unit (department, division, business unit, cost center group, team) within the telecommunications enterprise hierarchy. Captures org unit code, name, description, org unit type (division, department, team, cost center group), parent org unit reference for hierarchy traversal, effective start and end dates, org unit head employee reference, legal entity association, geographic region, functional area classification (network operations, commercial, finance, IT, HR, legal, regulatory), headcount budget, and active status. Supports multi-level organizational hierarchy modeling for reporting, access control, and workforce planning.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the position record. Primary key for the position entity.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to people.job_profile. Business justification: Link each Position to its standardized Job_Profile, consolidating duplicate descriptive fields and enabling consistent reporting.',
    `location_site_id` BIGINT COMMENT 'Reference to the primary work location or site where the position is based. Links to facility or office location master data.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, cost center) to which this position is assigned. Links position to the organizational hierarchy.',
    `reporting_position_id` BIGINT COMMENT 'Reference to the manager position to which this position reports. Establishes the reporting hierarchy independent of individual employees. Null for top-level executive positions.',
    `reports_to_position_id` BIGINT COMMENT 'Self-referencing FK on position (reports_to_position_id)',
    `approval_date` DATE COMMENT 'Date when the position was officially approved by management or HR governance. Marks formal authorization to create and fund the position.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or manager who approved the position creation. Used for governance and audit trail purposes.',
    `budgeted_flag` BOOLEAN COMMENT 'Indicates whether the position is included in the approved headcount budget. True if budgeted and approved for funding, False if not budgeted or pending budget approval.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the positions compensation and benefits expenses are charged. Used for financial planning and expense allocation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was first created in the system. Used for audit trail and data lineage tracking.',
    `creation_reason` STRING COMMENT 'Business justification or reason for creating the position. Captures whether the position was created for new business needs, as a replacement, due to restructuring, expansion, regulatory requirements, or project needs.. Valid values are `new_business_need|replacement|organizational_restructure|expansion|regulatory_requirement|project_based`',
    `critical_position_flag` BOOLEAN COMMENT 'Indicates whether the position is designated as business-critical or key to operations. True for positions where vacancy would significantly impact business continuity or service delivery.',
    `effective_end_date` DATE COMMENT 'Date when the position is scheduled to end or was eliminated from the organizational structure. Null for ongoing permanent positions. Used for fixed-term positions and position elimination tracking.',
    `effective_start_date` DATE COMMENT 'Date when the position becomes active and available in the organizational structure. Marks the beginning of the positions lifecycle.',
    `employment_type` STRING COMMENT 'Standard employment classification indicating whether the position is full-time, part-time, job-share, or on-call. Complements FTE allocation with categorical classification.. Valid values are `full_time|part_time|job_share|on_call`',
    `exempt_status` STRING COMMENT 'Classification of the position under Fair Labor Standards Act for overtime eligibility. Exempt positions are not eligible for overtime pay, non-exempt positions are eligible.. Valid values are `exempt|non_exempt|not_applicable`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation for the position. 1.00 represents a full-time position, 0.50 represents half-time, etc. Used for headcount planning and budgeting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was last updated. Used for change tracking and audit purposes.',
    `last_review_date` DATE COMMENT 'Date when the position was last reviewed for relevance, classification accuracy, and organizational fit. Used for periodic position management and organizational design reviews.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next position review. Used to ensure regular evaluation of position relevance and classification accuracy.',
    `position_code` STRING COMMENT 'Business identifier for the position, typically used in HR systems and organizational charts. Unique alphanumeric code assigned to each approved headcount slot.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_description` STRING COMMENT 'Detailed description of the positions responsibilities, duties, and scope. Provides comprehensive overview of what the role entails independent of the incumbent.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position. Indicates whether the position is active and available, currently filled, vacant and open for recruitment, frozen (temporarily unavailable), eliminated, or pending approval.. Valid values are `active|filled|vacant|frozen|eliminated|pending_approval`',
    `position_type` STRING COMMENT 'Classification of the position based on employment duration and nature. Distinguishes between permanent headcount, fixed-term roles, contractor slots, and temporary positions.. Valid values are `permanent|fixed_term|contractor_slot|temporary|seasonal|project_based`',
    `required_clearance_level` STRING COMMENT 'Minimum security clearance or background check level required for the position. Relevant for positions with access to sensitive network infrastructure, customer data, or classified information.. Valid values are `none|basic|standard|enhanced|top_secret`',
    `required_qualifications_summary` STRING COMMENT 'Summary of minimum required qualifications, certifications, education, and experience for the position. Used for recruitment and succession planning.',
    `span_of_control` STRING COMMENT 'Number of direct report positions that report to this position. Used for organizational design and management capacity planning. Zero for non-supervisory positions.',
    `succession_plan_flag` BOOLEAN COMMENT 'Indicates whether a formal succession plan exists for this position. True if succession planning is active, False otherwise. Typically True for critical and leadership positions.',
    `supervisory_flag` BOOLEAN COMMENT 'Indicates whether the position has supervisory or management responsibilities. True if the position manages direct reports, False otherwise.',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of time the position requires business travel. Expressed as integer percentage (0-100). Used for role expectations and expense planning.',
    `union_eligible_flag` BOOLEAN COMMENT 'Indicates whether the position is eligible for union membership or covered by collective bargaining agreements. Relevant for labor relations and compliance.',
    `work_arrangement` STRING COMMENT 'Standard work arrangement or location flexibility for the position. Indicates whether the role is on-site, fully remote, hybrid, field-based, or mobile.. Valid values are `on_site|remote|hybrid|field_based|mobile`',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Master record for every approved headcount position within the organizational structure — the slot that an employee fills, independent of the person occupying it. Captures position code, position title, position grade/band, job family, job function, org unit assignment, reporting position (manager position), FTE allocation, position type (permanent, fixed-term, contractor slot), required qualifications summary, required clearance level, budgeted flag, filled/vacant status, effective start and end dates, and position creation reason. Enables workforce planning, vacancy tracking, and succession management independent of individual employee records.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile. Primary key for the job profile reference master.',
    `parent_job_profile_id` BIGINT COMMENT 'Self-referencing FK on job_profile (parent_job_profile_id)',
    `bonus_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the job profile is eligible for performance-based bonus or incentive compensation. True if eligible, False otherwise.',
    `business_unit` STRING COMMENT 'Primary business unit or division to which the job profile is aligned. May be null for enterprise-wide job profiles applicable across multiple business units.',
    `commission_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the job profile is eligible for sales commission or variable compensation tied to revenue generation. True if eligible, False otherwise. Typically applies to sales and business development roles.',
    `core_competencies` STRING COMMENT 'List of essential skills, knowledge areas, and behavioral competencies required for successful performance in the role. May include technical skills (e.g., Long-Term Evolution (LTE), 5G New Radio (5G NR), Software-Defined Networking (SDN)), leadership competencies, and domain expertise.',
    `cost_center` STRING COMMENT 'Default cost center code for budgeting and financial planning purposes associated with the job profile. Used in headcount planning and Capital Expenditure (CAPEX) / Operational Expenditure (OPEX) allocation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the job profile record was first created in the system. Record audit field for data lineage and compliance.',
    `effective_end_date` DATE COMMENT 'Date when the job profile was or will be retired or deprecated. Null for currently active profiles with no planned end date. Used for temporal validity and historical tracking.',
    `effective_start_date` DATE COMMENT 'Date when the job profile became or will become active and available for use in the organization. Used for temporal validity and historical tracking.',
    `flsa_classification` STRING COMMENT 'Classification under the Fair Labor Standards Act (FLSA) indicating whether the role is exempt or non-exempt from overtime pay requirements. Critical for payroll compliance and labor law adherence.. Valid values are `Exempt|Non-Exempt`',
    `grade_band` STRING COMMENT 'Compensation grade or pay band assigned to the job profile. Determines salary range, bonus eligibility, and benefits tier. Confidential business-sensitive data used in compensation planning.. Valid values are `^[A-Z0-9]{1,5}$`',
    `is_customer_facing` BOOLEAN COMMENT 'Boolean flag indicating whether the job profile involves direct interaction with external customers. True if the role regularly engages with customers, False otherwise. Used for Customer Relationship Management (CRM) and training planning.',
    `is_people_manager` BOOLEAN COMMENT 'Boolean flag indicating whether the job profile includes direct people management responsibilities (supervising, coaching, performance evaluation of subordinates). True if the role manages people, False otherwise.',
    `is_safety_sensitive` BOOLEAN COMMENT 'Boolean flag indicating whether the job profile is classified as safety-sensitive, requiring adherence to occupational health and safety regulations, drug testing, and specialized training. True for roles such as field technicians, network engineers working on infrastructure, False otherwise.',
    `job_description` STRING COMMENT 'Comprehensive narrative describing the purpose, responsibilities, duties, and scope of the job profile. Used in recruitment, performance management, and role clarification.',
    `job_family` STRING COMMENT 'High-level categorization of the job profile into a major functional area or discipline. Primary classification for workforce segmentation and career pathing. [ENUM-REF-CANDIDATE: Network Engineering|Sales|Finance|Information Technology|Human Resources|Legal|Customer Service|Marketing|Operations|Product Management|Supply Chain|Security|Compliance|Data Analytics|Corporate Strategy — 15 candidates stripped; promote to reference product]',
    `job_level` STRING COMMENT 'Hierarchical level or seniority tier of the job profile within the organizational structure. Used for compensation banding, reporting hierarchy definition, and career progression planning. [ENUM-REF-CANDIDATE: Individual Contributor|Team Lead|Manager|Senior Manager|Director|Senior Director|Vice President|Senior Vice President|Executive Vice President|C-Level — 10 candidates stripped; promote to reference product]',
    `job_profile_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the job profile across the enterprise. Used in Human Resources (HR) systems, payroll, and workforce planning. Business identifier for external reference.. Valid values are `^[A-Z0-9]{4,12}$`',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of the job profile. Active profiles are available for use in hiring and workforce planning. Inactive or deprecated profiles are retained for historical reference but not used for new hires.. Valid values are `Active|Inactive|Deprecated|Under Review|Proposed`',
    `job_subfamily` STRING COMMENT 'Secondary classification within the job family providing finer granularity. For example, within Network Engineering: Radio Access Network (RAN), Core Network, Transport, Operations Support Systems (OSS).',
    `job_title` STRING COMMENT 'Official job title as it appears in organizational charts, offer letters, and employee records. Human-readable identity label for the role.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the job profile record was most recently updated. Record audit field for change tracking and data governance.',
    `last_reviewed_date` DATE COMMENT 'Date when the job profile was last reviewed and validated by Human Resources (HR) or the business owner. Used to ensure job profiles remain current and aligned with organizational needs.',
    `minimum_education_requirement` STRING COMMENT 'Minimum level of formal education required for the job profile. Used in candidate screening and workforce planning. [ENUM-REF-CANDIDATE: High School Diploma|Associate Degree|Bachelor Degree|Master Degree|Doctoral Degree|Professional Certification|No Formal Requirement — 7 candidates stripped; promote to reference product]',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for the job profile. Used in recruitment and succession planning.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the job profile. Used for governance and ensuring job architecture remains aligned with business strategy.',
    `overtime_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the job profile is eligible for overtime compensation. Typically aligns with Fair Labor Standards Act (FLSA) non-exempt classification. True if eligible, False otherwise.',
    `owner` STRING COMMENT 'Name or identifier of the Human Resources (HR) business partner or functional leader responsible for maintaining and governing the job profile. Accountability field for data stewardship.',
    `predecessor_job_profile_code` STRING COMMENT 'Job profile code of the typical prior role in the career path leading to this job profile. Used for career progression planning and internal mobility analysis. May be null for entry-level roles.',
    `remote_work_eligibility` STRING COMMENT 'Classification of the job profiles eligibility for remote or hybrid work arrangements. Reflects organizational policy and role requirements.. Valid values are `Fully Remote|Hybrid|On-Site Only|Flexible`',
    `security_clearance_required` STRING COMMENT 'Level of government or organizational security clearance required for the job profile. Applicable for roles handling sensitive national security, lawful intercept, or critical infrastructure data.. Valid values are `None|Confidential|Secret|Top Secret|Public Trust`',
    `stock_option_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the job profile is eligible for equity compensation such as stock options, restricted stock units, or employee stock purchase plans. True if eligible, False otherwise.',
    `successor_job_profile_code` STRING COMMENT 'Job profile code of the typical next role in the career path following this job profile. Used for career progression planning and succession management. May be null for terminal roles.',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of work time requiring business travel. Expressed as an integer percentage (0-100). Used in recruitment, expense planning, and work-life balance considerations.',
    `union_eligibility` STRING COMMENT 'Indicates whether the job profile is eligible for union membership or collective bargaining representation. Used for labor relations and compliance with collective bargaining agreements.. Valid values are `Eligible|Not Eligible|Management Excluded`',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Reference master defining standardized job profiles and role definitions used across the telecommunications enterprise. Captures job profile code, job title, job family (e.g., Network Engineering, Sales, Finance, IT, HR, Legal), job subfamily, job level/grade band, FLSA classification (exempt/non-exempt), standard job description, core competencies required, minimum education requirement, minimum years of experience, typical career path predecessor and successor roles, and active status. Serves as the canonical reference for job architecture and compensation banding. Distinct from position (which is an org-specific headcount slot) and from workforce.skill (which tracks individual proficiency).';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`assignment` (
    `assignment_id` BIGINT COMMENT 'Unique identifier for the employee assignment record. Primary key for the assignment entity.',
    `employee_id` BIGINT COMMENT 'The user ID of the manager or HR administrator who approved this assignment. Null if assignment_approval_status is not approved.',
    `assignment_created_by_user_employee_id` BIGINT COMMENT 'The user ID of the HR administrator or system user who created this assignment record. Used for audit trails and accountability.',
    `assignment_employee_id` BIGINT COMMENT 'Reference to the employee who holds this assignment. Links to the employee master record in the people domain.',
    `assignment_manager_employee_id` BIGINT COMMENT 'Reference to the employee who is the direct manager or supervisor for this assignment. Enables reporting hierarchy reconstruction.',
    `assignment_modified_by_user_employee_id` BIGINT COMMENT 'The user ID of the HR administrator or system user who last modified this assignment record. Used for audit trails and change management.',
    `location_site_id` BIGINT COMMENT 'Reference to the physical or virtual work location where the employee performs their duties under this assignment. Links to location master record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit where the employee is assigned. Links to the org_unit master record representing department, division, or business unit.',
    `position_id` BIGINT COMMENT 'Reference to the position that the employee is assigned to. Links to the position master record defining the role, grade, and job responsibilities.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Assignments in telecommunications require P&L attribution of labor costs to business segments (network operations, customer service, sales). Enables revenue-generating vs support cost segregation and ',
    `superseded_assignment_id` BIGINT COMMENT 'Self-referencing FK on assignment (superseded_assignment_id)',
    `approval_status` STRING COMMENT 'The approval workflow status for this assignment. Indicates whether the assignment has been approved by appropriate authorities such as HR, finance, or management.. Valid values are `draft|pending_approval|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this assignment was approved. Null if assignment_approval_status is not approved. Used for compliance and audit purposes.',
    `assignment_number` STRING COMMENT 'Human-readable business identifier for the assignment record. Follows format ASG-########. Used for operational reference and audit trails.. Valid values are `^ASG-[0-9]{8}$`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment. Indicates whether the assignment is currently active, suspended, terminated, pending activation, or on leave.. Valid values are `active|suspended|terminated|pending|on_leave`',
    `assignment_type` STRING COMMENT 'Classification of the assignment indicating whether it is the employees primary role, a secondary/concurrent assignment, or a temporary acting/interim position.. Valid values are `primary|secondary|concurrent|acting|interim`',
    `cost_center_code` STRING COMMENT 'The cost center to which this assignments labor costs are charged. Used for financial accounting, budgeting, and OPEX (Operational Expenditure) tracking. Follows format CC-######.. Valid values are `^CC-[0-9]{6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this assignment record was first created in the system. Used for audit trails and data lineage tracking.',
    `data_classification` STRING COMMENT 'The data classification level for this assignment record. Indicates the sensitivity and access control requirements for the assignment information.. Valid values are `restricted|confidential|internal|public`',
    `effective_timestamp` TIMESTAMP COMMENT 'The precise date and time when this assignment became or will become effective. Used for time-based queries and historical reporting hierarchy reconstruction.',
    `employment_category` STRING COMMENT 'Classification of the employment relationship for this assignment. Distinguishes between regular employees, temporary workers, interns, contractors, and consultants.. Valid values are `regular_full_time|regular_part_time|temporary|intern|contractor|consultant`',
    `end_date` DATE COMMENT 'The date when the assignment ended or is scheduled to end. Null for open-ended assignments. Used for historical tracking and workforce planning.',
    `expiry_timestamp` TIMESTAMP COMMENT 'The precise date and time when this assignment expired or will expire. Null for open-ended assignments. Used for temporal queries and workforce planning.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The percentage of full-time work that this assignment represents. 100.00 indicates full-time, values below 100 indicate part-time. Used for workforce capacity planning and OPEX (Operational Expenditure) calculations.',
    `is_critical_role` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment is designated as a critical role for business continuity and succession planning purposes. Used for workforce risk management.',
    `is_primary_assignment` BOOLEAN COMMENT 'Boolean flag indicating whether this is the employees primary assignment. An employee may have multiple concurrent assignments, but only one can be primary for reporting and benefits purposes.',
    `job_family` STRING COMMENT 'The broad occupational category or job family that this assignment belongs to, such as Engineering, Network Operations, Customer Service, Finance, or Sales. Used for workforce analytics and career pathing.',
    `job_level` STRING COMMENT 'The hierarchical level or grade of the position within the organizations job architecture. Examples include Individual Contributor, Team Lead, Manager, Senior Manager, Director, Vice President.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this assignment record was last modified. Used for audit trails, change tracking, and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text field for capturing additional notes, comments, or special circumstances related to this assignment. Used by HR administrators for context and documentation.',
    `notice_period_days` STRING COMMENT 'The number of days of advance notice required for termination of this assignment, as defined by employment contract or policy. Used for workforce planning and compliance.',
    `overtime_eligibility` STRING COMMENT 'Indicates whether the employee in this assignment is eligible for overtime compensation. Exempt employees are not eligible for overtime pay under labor regulations.. Valid values are `eligible|exempt|not_applicable`',
    `probation_end_date` DATE COMMENT 'The date when the probationary period for this assignment ends. Applicable for new hires or employees in new roles. Null if no probation period applies.',
    `reason_code` STRING COMMENT 'Code indicating the business reason for creating or modifying this assignment. Supports HR analytics on workforce movements and organizational changes. [ENUM-REF-CANDIDATE: new_hire|transfer|promotion|demotion|reorganization|secondment|return_from_leave|contract_renewal|role_change — 9 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Detailed textual description providing additional context for the assignment reason. Captures business justification and circumstances of the assignment action.',
    `remote_work_eligibility` STRING COMMENT 'Indicates whether the employee in this assignment is eligible for remote work arrangements based on role requirements, policy, and business needs.. Valid values are `eligible|not_eligible|conditional`',
    `sequence_number` STRING COMMENT 'Sequential number indicating the order of this assignment in the employees assignment history. Starts at 1 for first assignment and increments with each new assignment.',
    `source_system_assignment_code` STRING COMMENT 'The unique identifier for this assignment in the source system of record. Used for data reconciliation and integration traceability.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this assignment record originated. Supports data lineage tracking in multi-system HR landscapes.. Valid values are `SAP_HCM|WORKDAY|ORACLE_HCM|MANUAL|INTEGRATION`',
    `start_date` DATE COMMENT 'The date when the employee formally began this assignment. Represents the effective start of the employment relationship in this position and org unit.',
    `union_code` STRING COMMENT 'Code identifying the specific labor union or collective bargaining unit that represents the employee in this assignment. Null if union_membership_flag is false.',
    `union_membership_flag` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union under this assignment. Used for compliance with collective bargaining agreements and labor relations management.',
    `work_location_type` STRING COMMENT 'Classification of where the employee performs work under this assignment. Distinguishes between on-site office work, remote work, hybrid arrangements, field-based roles, and mobile workforce.. Valid values are `on_site|remote|hybrid|field_based|mobile`',
    `work_schedule_pattern` STRING COMMENT 'The standard work schedule pattern for this assignment. Defines the expected working hours arrangement such as standard 40-hour week, compressed workweek, shift rotation, or flexible schedule.. Valid values are `standard_40hr|compressed_week|shift_rotation|flexible|on_call|custom`',
    CONSTRAINT pk_assignment PRIMARY KEY(`assignment_id`)
) COMMENT 'Transactional record capturing each formal employment assignment of an employee to a position within an org unit — the core HR action record that tracks WHERE an employee works, in WHAT role, and under WHOM. Captures assignment sequence number, employee reference, position reference, org unit reference, manager employee reference, assignment type (primary, secondary/concurrent), employment category (regular, temporary, intern, contractor), FTE percentage, work schedule pattern, work location type (on-site, remote, hybrid), assignment start date, assignment end date, assignment reason (new hire, transfer, promotion, demotion, reorganization, secondment), and assignment status. Supports full organizational history and reporting hierarchy reconstruction at any point in time.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`compensation` (
    `compensation_id` BIGINT COMMENT 'Unique identifier for the compensation record. Primary key for the compensation entity.',
    `employee_id` BIGINT COMMENT 'The employee ID of the manager or HR representative who approved this compensation plan or change.',
    `compensation_employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom this compensation record applies. Links to the employee master record.',
    `superseded_compensation_id` BIGINT COMMENT 'Self-referencing FK on compensation (superseded_compensation_id)',
    `annual_leave_days` STRING COMMENT 'The number of annual leave (vacation) days allocated to the employee per year under this compensation plan.',
    `approval_date` DATE COMMENT 'The date on which this compensation plan or change was formally approved.',
    `approval_reference` STRING COMMENT 'Reference identifier or document number for the approval authority that authorized this compensation plan or change.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The base salary or wage amount for the employee under this compensation plan, excluding allowances and bonuses.',
    `change_reason` STRING COMMENT 'The business reason for creating or modifying this compensation record (merit increase, promotion, market adjustment, equity correction, new hire, or annual review).. Valid values are `merit_increase|promotion|market_adjustment|equity_correction|new_hire|annual_review`',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'The commission rate percentage applied to sales or revenue for commission-based compensation plans. Applicable when plan_type is commission or hybrid.',
    `compensation_status` STRING COMMENT 'The current lifecycle status of this compensation record (active, pending approval, approved, superseded by newer record, or terminated).. Valid values are `active|pending|approved|superseded|terminated`',
    `cost_center_code` STRING COMMENT 'The cost center code to which this employees compensation expense is allocated for financial reporting and budgeting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compensation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the compensation amounts are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which this compensation plan becomes active and applicable to the employee.',
    `end_date` DATE COMMENT 'The date on which this compensation plan ceases to be active. Null indicates the plan is currently active with no defined end date.',
    `equity_grant_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for equity grants (stock options, RSUs, etc.) under this compensation plan (True = eligible, False = not eligible).',
    `flsa_classification` STRING COMMENT 'The FLSA classification of the employee determining overtime eligibility (exempt = not eligible for overtime, non-exempt = eligible for overtime).. Valid values are `exempt|non-exempt`',
    `general_ledger_account_code` STRING COMMENT 'The general ledger account code used to record compensation expenses in the financial system.',
    `grade_maximum_amount` DECIMAL(18,2) COMMENT 'The maximum salary amount defined for the employees assigned pay grade.',
    `grade_minimum_amount` DECIMAL(18,2) COMMENT 'The minimum salary amount defined for the employees assigned pay grade.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'The hourly wage rate for employees compensated on an hourly basis. Applicable only when plan_type is hourly or hybrid.',
    `housing_allowance_amount` DECIMAL(18,2) COMMENT 'The monthly or periodic housing allowance provided to the employee as part of the total compensation package.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this compensation record was last updated or modified in the system.',
    `meal_allowance_amount` DECIMAL(18,2) COMMENT 'The monthly or periodic meal or food allowance provided to the employee.',
    `mobile_allowance_amount` DECIMAL(18,2) COMMENT 'The monthly or periodic mobile phone or communication allowance provided to the employee.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context or details about this compensation record.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible to receive overtime compensation under this plan (True = eligible, False = not eligible).',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid (monthly, bi-weekly, weekly, semi-monthly, quarterly, or annual).. Valid values are `monthly|bi-weekly|weekly|semi-monthly|quarterly|annual`',
    `pay_grade` STRING COMMENT 'The pay grade or band assigned to the employee, representing a hierarchical level within the organizations compensation structure.',
    `pay_step` STRING COMMENT 'The step or increment within the assigned pay grade, typically reflecting tenure or performance progression.',
    `plan_type` STRING COMMENT 'The type of compensation structure applied to the employee (salary-based, hourly wage, commission-based, hybrid, contract, or stipend).. Valid values are `salary|hourly|commission|hybrid|contract|stipend`',
    `shift_differential_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for shift differential pay for non-standard working hours (True = eligible, False = not eligible).',
    `sick_leave_days` STRING COMMENT 'The number of sick leave days allocated to the employee per year under this compensation plan.',
    `target_bonus_percentage` DECIMAL(18,2) COMMENT 'The target annual bonus as a percentage of base salary that the employee is eligible to receive based on performance.',
    `total_fixed_compensation_amount` DECIMAL(18,2) COMMENT 'The total fixed compensation amount including base salary and all fixed allowances (housing, transport, mobile, meal).',
    `transport_allowance_amount` DECIMAL(18,2) COMMENT 'The monthly or periodic transport or commuting allowance provided to the employee.',
    `union_code` STRING COMMENT 'The code or identifier of the labor union to which the employee belongs, if applicable.',
    `union_member_flag` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union, which may affect compensation terms and conditions (True = union member, False = not a union member).',
    CONSTRAINT pk_compensation PRIMARY KEY(`compensation_id`)
) COMMENT 'Master record for an employees current and historical compensation package — the SSOT for all salary, wage, and allowance data. Captures compensation plan type (salary, hourly, commission-based), base salary amount, currency, pay frequency (monthly, bi-weekly, weekly), effective date, end date, pay grade, pay step within grade, salary range minimum and maximum for the grade, overtime eligibility flag, shift differential eligibility, housing allowance, transport allowance, mobile allowance, meal allowance, total fixed compensation, change reason (merit increase, promotion, market adjustment, equity correction, new hire), and approval reference. Restricted classification — access controlled.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique identifier for the payroll processing cycle. Primary key for the payroll run entity.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity or company code for which this payroll run is executed. Links to the legal entity master data.',
    `employee_id` BIGINT COMMENT 'Reference to the user or employee who executed or processed this payroll run. Links to the employee or user master data.',
    `tertiary_payroll_reversed_by_user_employee_id` BIGINT COMMENT 'Reference to the user or employee who reversed or cancelled this payroll run, if applicable. Links to the employee or user master data.',
    `reversal_payroll_run_id` BIGINT COMMENT 'Self-referencing FK on payroll_run (reversal_payroll_run_id)',
    `accounting_period` STRING COMMENT 'The accounting period (e.g., 2024-01, Q1-2024) to which this payroll run is assigned for financial reporting purposes.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the payroll run was approved for posting and payment.',
    `check_date` DATE COMMENT 'The date printed on physical checks or used as the effective date for electronic payments for this payroll run.',
    `company_code` STRING COMMENT 'The company code representing the legal entity in the financial and HR systems (e.g., SAP company code).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts in this payroll run (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `employee_count` STRING COMMENT 'The total number of employees included in this payroll run.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this payroll run belongs for financial reporting and budgeting purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll run record was last updated or modified in the system.',
    `notes` STRING COMMENT 'Free-text notes or comments about this payroll run, including special circumstances, processing issues, or other relevant information.',
    `off_cycle_reason` STRING COMMENT 'The business reason for executing an off-cycle payroll run, if applicable (e.g., termination payment, bonus payment, correction).',
    `payment_date` DATE COMMENT 'The date on which employees will receive payment for this payroll run.',
    `payroll_area` STRING COMMENT 'The payroll area or grouping that defines the payroll processing schedule and rules for this run (e.g., US-Salaried, US-Hourly, UK-Monthly).',
    `payroll_control_record` STRING COMMENT 'The payroll control record identifier that governs the processing rules and parameters for this payroll run in the source system.',
    `payroll_frequency` STRING COMMENT 'The frequency at which payroll is processed for this run (e.g., monthly, bi-weekly, weekly, semi-monthly).. Valid values are `monthly|bi-weekly|weekly|semi-monthly|quarterly|annual`',
    `payroll_period_end_date` DATE COMMENT 'The last date of the payroll period covered by this payroll run.',
    `payroll_period_start_date` DATE COMMENT 'The first date of the payroll period covered by this payroll run.',
    `payroll_run_number` STRING COMMENT 'Business-facing unique identifier or reference number for the payroll run, typically used in communications and reporting (e.g., PR-2024-001).',
    `payroll_run_type` STRING COMMENT 'The type or category of payroll run being executed (e.g., regular, off-cycle, bonus, final settlement, correction, advance).. Valid values are `regular|off-cycle|bonus|final-settlement|correction|advance`',
    `payroll_system_reference` STRING COMMENT 'The unique identifier or reference number for this payroll run in the source payroll system (e.g., SAP HCM payroll run ID, SuccessFactors payroll run ID).',
    `posting_date_to_gl` DATE COMMENT 'The date on which payroll transactions from this run were posted to the general ledger in the financial system.',
    `processed_timestamp` TIMESTAMP COMMENT 'The date and time when the payroll run processing was completed or finalized.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this payroll run has been reversed or cancelled (True if reversed, False if not).',
    `reversal_reason` STRING COMMENT 'The business reason or explanation for why this payroll run was reversed or cancelled, if applicable.',
    `reversal_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll run was reversed or cancelled, if applicable.',
    `run_status` STRING COMMENT 'Current lifecycle status of the payroll run (e.g., draft, processing, calculated, approved, posted, reversed, failed). [ENUM-REF-CANDIDATE: draft|processing|calculated|approved|posted|reversed|failed — 7 candidates stripped; promote to reference product]',
    `total_employee_deductions` DECIMAL(18,2) COMMENT 'The total amount of employee deductions (e.g., pension contributions, health insurance premiums, union dues) for this payroll run.',
    `total_employer_contributions` DECIMAL(18,2) COMMENT 'The total amount of employer contributions (e.g., pension, health insurance, social security) for this payroll run.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'The total gross pay amount for all employees included in this payroll run before any deductions or taxes.',
    `total_net_pay` DECIMAL(18,2) COMMENT 'The total net pay amount for all employees included in this payroll run after all deductions, taxes, and contributions.',
    `total_tax_withheld` DECIMAL(18,2) COMMENT 'The total amount of taxes withheld from employee pay for this payroll run (e.g., federal, state, local income tax, social security, medicare).',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master record for each payroll processing cycle executed for the telecommunications enterprise workforce. Captures payroll run identifier, payroll period (start and end dates), payroll frequency (monthly, bi-weekly), legal entity / company code, payroll run type (regular, off-cycle, bonus, final settlement), run status (draft, processing, approved, posted, reversed), total gross pay, total net pay, total employer contributions, total employee deductions, total tax withheld, currency, payroll system reference (SAP HCM/SuccessFactors payroll run ID), processed by user, approved by user, approval timestamp, posting date to GL, and reversal reason if applicable.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`payslip` (
    `payslip_id` BIGINT COMMENT 'Unique identifier for the payslip record. Primary key for the payslip transaction.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who received this payslip. Links to the workforce master data.',
    `payroll_run_id` BIGINT COMMENT 'Reference to the payroll run batch that generated this payslip. Links to the parent payroll processing cycle.',
    `correction_of_payslip_id` BIGINT COMMENT 'Self-referencing FK on payslip (correction_of_payslip_id)',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the employee acknowledged receipt and review of the payslip.',
    `allowances_total` DECIMAL(18,2) COMMENT 'Sum of all allowances paid in this period, including housing, transport, meal, mobile, and other allowances.',
    `bank_account_last_four` STRING COMMENT 'Last four digits of the bank account number to which net pay was disbursed. Masked for security and privacy.. Valid values are `^[0-9]{4}$`',
    `basic_salary` DECIMAL(18,2) COMMENT 'The base salary component for the pay period, excluding any variable pay or allowances.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Discretionary or performance-based bonus paid in this pay period.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Sales commission or incentive earnings for the pay period.',
    `cost_center_code` STRING COMMENT 'Cost center to which this payslip expense is allocated for financial reporting and budgeting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this payslip.. Valid values are `^[A-Z]{3}$`',
    `delivered_timestamp` TIMESTAMP COMMENT 'Date and time when the payslip was delivered to the employee (via email, portal, or print).',
    `department_code` STRING COMMENT 'Code of the department to which the employee belonged during this pay period. Used for cost allocation and reporting.',
    `employer_health_contribution` DECIMAL(18,2) COMMENT 'Employer contribution toward employee health insurance premium. Not deducted from employee pay but shown for transparency.',
    `employer_pension_contribution` DECIMAL(18,2) COMMENT 'Employer matching or contribution to employee pension plan. Not deducted from employee pay but shown for transparency.',
    `employer_social_security` DECIMAL(18,2) COMMENT 'Employer portion of social security tax. Not deducted from employee pay but shown for transparency.',
    `generated_timestamp` TIMESTAMP COMMENT 'Date and time when the payslip was generated by the payroll system.',
    `gross_pay` DECIMAL(18,2) COMMENT 'Total earnings before any deductions. Sum of basic salary, overtime, bonuses, allowances, and other earnings.',
    `health_insurance_premium` DECIMAL(18,2) COMMENT 'Employee share of health insurance premium deducted from gross pay.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total number of regular hours worked during the pay period.',
    `income_tax` DECIMAL(18,2) COMMENT 'Federal, state, and local income tax withheld from gross pay for this period.',
    `leave_days_taken` DECIMAL(18,2) COMMENT 'Number of paid leave days (vacation, sick, personal) taken during this pay period.',
    `loan_repayment` DECIMAL(18,2) COMMENT 'Installment amount deducted for employee loans (salary advance, emergency loan, etc.).',
    `net_pay` DECIMAL(18,2) COMMENT 'Take-home pay after all deductions. Amount actually disbursed to the employee (gross pay minus total deductions).',
    `other_deductions` DECIMAL(18,2) COMMENT 'Sum of all other miscellaneous deductions not categorized above (garnishments, charitable contributions, etc.).',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total number of overtime hours worked during the pay period.',
    `overtime_pay` DECIMAL(18,2) COMMENT 'Total overtime earnings for the pay period, including regular and premium overtime rates.',
    `pay_period_end_date` DATE COMMENT 'The last day of the pay period covered by this payslip.',
    `pay_period_start_date` DATE COMMENT 'The first day of the pay period covered by this payslip.',
    `payment_date` DATE COMMENT 'The date on which the net pay was or will be disbursed to the employee.',
    `payment_method` STRING COMMENT 'Method by which net pay was disbursed to the employee.. Valid values are `bank_transfer|cheque|cash|payroll_card`',
    `payslip_number` STRING COMMENT 'Externally visible unique payslip reference number used for employee inquiries and audit trails.',
    `payslip_status` STRING COMMENT 'Current lifecycle status of the payslip document.. Valid values are `generated|delivered|acknowledged|disputed|reissued|voided`',
    `pension_employee_contribution` DECIMAL(18,2) COMMENT 'Employee contribution to retirement pension plan deducted from gross pay.',
    `remarks` STRING COMMENT 'Free-text notes or comments related to this payslip, such as adjustments, corrections, or special circumstances.',
    `shift_differential` DECIMAL(18,2) COMMENT 'Additional compensation for working non-standard shifts (night, weekend, holiday).',
    `social_security_employee` DECIMAL(18,2) COMMENT 'Employee portion of social security tax deducted from gross pay.',
    `total_deductions` DECIMAL(18,2) COMMENT 'Sum of all deductions from gross pay including taxes, insurance, pension, loans, and other withholdings.',
    `union_dues` DECIMAL(18,2) COMMENT 'Union membership dues deducted from gross pay as per collective bargaining agreement.',
    `work_location_code` STRING COMMENT 'Code of the physical work location or site where the employee was assigned during this pay period.',
    `ytd_gross_pay` DECIMAL(18,2) COMMENT 'Cumulative gross earnings from the start of the calendar or fiscal year through this pay period.',
    `ytd_income_tax` DECIMAL(18,2) COMMENT 'Cumulative income tax withheld from the start of the calendar or fiscal year through this pay period.',
    `ytd_net_pay` DECIMAL(18,2) COMMENT 'Cumulative net pay from the start of the calendar or fiscal year through this pay period.',
    CONSTRAINT pk_payslip PRIMARY KEY(`payslip_id`)
) COMMENT 'Transactional record of an individual employees payslip generated for a specific payroll run — the authoritative per-employee pay statement. Captures payroll run reference, employee reference, pay period start and end dates, gross pay, net pay, basic salary, all earnings components (overtime, bonus, shift differential, allowances), all deduction components (income tax, social security, pension employee contribution, health insurance premium, loan repayment, union dues), employer contribution amounts (pension, social security, health), year-to-date gross and net, bank account last four digits, payment date, payment method (bank transfer, cheque), and payslip status (generated, delivered, acknowledged).';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier for the employee benefit plan. Primary key for the benefit plan entity.',
    `superseded_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (superseded_benefit_plan_id)',
    `allows_dependent_coverage` BOOLEAN COMMENT 'Indicates whether the plan allows employees to enroll eligible dependents (spouse, children, domestic partner) for coverage. True if dependent coverage is available; false if employee-only.',
    `annual_coverage_limit` DECIMAL(18,2) COMMENT 'Maximum dollar amount the plan will pay in benefits per covered individual per year. Nullable for plans with unlimited coverage. Applicable primarily to health, dental, and vision plans.',
    `benefit_category` STRING COMMENT 'Classification of the benefit plan by type of coverage or program. Segments benefit offerings into major categories for reporting, compliance, and employee decision-making. [ENUM-REF-CANDIDATE: medical|dental|vision|life_insurance|disability|pension|retirement|stock_purchase|wellness|telecom_discount|employee_assistance — 11 candidates stripped; promote to reference product]',
    `carrier_policy_number` STRING COMMENT 'Policy or contract number assigned by the insurance carrier or benefit provider. Used for claims processing, provider verification, and carrier communications.',
    `cobra_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan is subject to COBRA continuation coverage requirements. True for group health plans; false for plans exempt from COBRA (e.g., certain retirement plans).',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'Percentage of covered expenses the employee pays after meeting the deductible, expressed as a decimal (e.g., 0.2000 represents 20% coinsurance). The plan pays the remaining percentage.',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are made to the benefit plan. Determines payroll deduction schedule and plan funding cadence.. Valid values are `per_pay_period|monthly|quarterly|annually`',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee pays for specific covered services (e.g., doctor visit, prescription). Applicable to health, dental, and vision plans. May vary by service type.',
    `coverage_tier` STRING COMMENT 'Level of coverage provided by the plan, indicating who is covered under the benefit (employee only, employee plus spouse, employee plus children, full family, or domestic partner). Affects premium calculations.. Valid values are `employee_only|employee_spouse|employee_children|family|domestic_partner`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was first created in the system. Used for audit trail and data lineage tracking.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Amount the employee must pay out-of-pocket before the plan begins to pay benefits. Applicable to health, dental, and vision insurance plans. Varies by coverage tier.',
    `effective_end_date` DATE COMMENT 'Date when the benefit plan ceases to be active and is no longer available for new enrollments. Nullable for open-ended plans with no predetermined termination date.',
    `effective_start_date` DATE COMMENT 'Date when the benefit plan becomes active and available for employee enrollment. Represents the beginning of the plans coverage period.',
    `eligibility_criteria` STRING COMMENT 'Textual description of requirements employees must meet to enroll in the plan, including employment type (full-time, part-time, contractor), minimum tenure, grade band, location, or other qualifying conditions.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount contributed by the employee per pay period or per month, if the plan uses flat-rate contributions instead of percentage-based. Nullable if percentage-based contribution is used.',
    `employee_contribution_rate` DECIMAL(18,2) COMMENT 'Percentage of plan cost paid by the employee, expressed as a decimal (e.g., 0.2500 represents 25%). Used to calculate payroll deductions for benefit premiums.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount contributed by the employer per pay period or per month, if the plan uses flat-rate contributions instead of percentage-based. Nullable if percentage-based contribution is used.',
    `employer_contribution_rate` DECIMAL(18,2) COMMENT 'Percentage of plan cost paid by the employer, expressed as a decimal (e.g., 0.7500 represents 75%). Represents the companys subsidy of the benefit plan.',
    `employer_match_limit` DECIMAL(18,2) COMMENT 'Maximum dollar amount or percentage of salary the employer will match per year in retirement plans. Represents the cap on employer matching contributions.',
    `employer_match_rate` DECIMAL(18,2) COMMENT 'Percentage of employee contributions that the employer will match in retirement or savings plans, expressed as a decimal (e.g., 0.5000 represents 50% match). Applicable to 401(k), 403(b), and similar plans.',
    `employment_type_eligibility` STRING COMMENT 'Employment classification required for plan eligibility. Specifies which employment types are eligible to enroll in this benefit plan.. Valid values are `full_time|part_time|contractor|temporary|all`',
    `enrollment_end_date` DATE COMMENT 'Date when the enrollment window closes for this benefit plan. Employees must complete enrollment actions before this date to participate in the plan for the coverage period.',
    `enrollment_start_date` DATE COMMENT 'Date when the enrollment window opens for employees to enroll in or make changes to this benefit plan. Applicable for open enrollment and special enrollment periods.',
    `enrollment_window_type` STRING COMMENT 'Type of enrollment period during which employees can enroll in or modify this benefit plan. Open enrollment is annual; life event is triggered by qualifying events; new hire is during onboarding; special enrollment is for exceptional circumstances.. Valid values are `open_enrollment|life_event|new_hire|special_enrollment`',
    `erisa_plan_number` STRING COMMENT 'Three-digit plan number assigned for ERISA reporting purposes. Required for Form 5500 annual reporting. Each benefit plan under the same plan sponsor must have a unique ERISA plan number.. Valid values are `^[0-9]{3}$`',
    `grade_band_eligibility` STRING COMMENT 'Organizational grade bands or job levels eligible for this plan (e.g., Executive, Management, Individual Contributor, All Grades). Used for tiered benefit offerings.',
    `hipaa_compliant` BOOLEAN COMMENT 'Indicates whether this benefit plan is subject to HIPAA privacy and security requirements. True for health plans that handle protected health information (PHI); false for non-health benefits.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether enrollment in this benefit plan is mandatory for eligible employees (true) or voluntary (false). Certain benefits like basic life insurance may be mandatory.',
    `lifetime_coverage_limit` DECIMAL(18,2) COMMENT 'Maximum dollar amount the plan will pay in benefits per covered individual over their lifetime. Nullable for plans with unlimited coverage. Prohibited for essential health benefits under ACA but may apply to supplemental benefits.',
    `minimum_tenure_months` STRING COMMENT 'Minimum number of months an employee must be employed before becoming eligible for this benefit plan. Zero indicates immediate eligibility upon hire.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this benefit plan record. Used for audit trail and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was last updated. Used for audit trail, change tracking, and data synchronization.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount an employee will pay in a plan year for covered services. After reaching this limit, the plan pays 100% of covered expenses. Applicable to health insurance plans.',
    `plan_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the benefit plan in HR systems and employee communications. Used for enrollment, payroll deduction, and benefits administration.. Valid values are `^[A-Z0-9]{4,12}$`',
    `plan_description` STRING COMMENT 'Detailed narrative description of the benefit plan including coverage details, key features, exclusions, and value proposition for employees. Used in benefits guides and enrollment materials.',
    `plan_document_url` STRING COMMENT 'Web address or document management system link to the official plan document, summary plan description, or benefits guide. Provides employees access to detailed plan terms and conditions.. Valid values are `^https?://.*$`',
    `plan_name` STRING COMMENT 'Human-readable name of the benefit plan as displayed to employees during enrollment and on benefits statements (e.g., Comprehensive Health Plus, Basic Dental Coverage, Employee Stock Purchase Plan 2024).',
    `plan_sponsor_ein` STRING COMMENT 'Federal Employer Identification Number of the organization sponsoring the benefit plan. Used for tax reporting and regulatory filings. Format: XX-XXXXXXX.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan. Active plans are available for enrollment; inactive plans are no longer offered; pending plans are awaiting approval; suspended plans are temporarily unavailable; terminated plans have been permanently closed.. Valid values are `active|inactive|pending|suspended|terminated`',
    `plan_type_code` STRING COMMENT 'Standardized code representing the specific type or structure of the benefit plan (e.g., HMO, PPO for health; 401K, 403B for retirement; ESPP for stock purchase). Used for regulatory reporting and plan categorization. [ENUM-REF-CANDIDATE: HMO|PPO|EPO|POS|HDHP|FSA|HSA|401K|403B|457|ESPP|RSU|PENSION — 13 candidates stripped; promote to reference product]',
    `plan_year` STRING COMMENT 'Calendar year or fiscal year for which this benefit plan is offered (e.g., 2024). Used for annual benefits planning, compliance reporting, and historical tracking.',
    `provider_name` STRING COMMENT 'Name of the insurance carrier, financial institution, or third-party administrator providing the benefit plan (e.g., Blue Cross Blue Shield, Fidelity Investments, MetLife).',
    `tax_treatment` STRING COMMENT 'Tax status of employee contributions to the plan. Pre-tax contributions reduce taxable income; post-tax contributions are made with after-tax dollars; Roth contributions are post-tax but grow tax-free; tax-exempt applies to certain benefits.. Valid values are `pre_tax|post_tax|roth|tax_exempt|taxable`',
    `vesting_period_months` STRING COMMENT 'Number of months an employee must participate in the plan before employer contributions become fully owned by the employee. Applicable to retirement plans, stock purchase plans, and pension plans. Zero indicates immediate vesting.',
    `created_by` STRING COMMENT 'User identifier or system account that created this benefit plan record. Used for audit trail and accountability.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Reference master defining all employee benefit plans offered by the telecommunications enterprise — health insurance, dental, vision, life insurance, pension/retirement, employee stock purchase, wellness programs, and telecom service discounts. Captures plan code, plan name, benefit category (medical, dental, vision, life, disability, pension, EAP, telecom_discount, wellness), plan provider name, plan description, eligibility criteria (employment type, minimum tenure, grade band), employee contribution rate, employer contribution rate, coverage tiers (employee only, employee+spouse, family), enrollment window type (open enrollment, life event, new hire), effective start and end dates, and active status.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment record. Primary key for the benefit enrollment transaction.',
    `benefit_plan_id` BIGINT COMMENT 'Reference to the specific benefit plan in which the employee is enrolling. Links to the benefit plan master record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee enrolling in the benefit plan. Links to the employee master record in the people domain.',
    `prior_benefit_enrollment_id` BIGINT COMMENT 'Self-referencing FK on benefit_enrollment (prior_benefit_enrollment_id)',
    `beneficiary_designation_on_file` BOOLEAN COMMENT 'Indicates whether the employee has designated beneficiaries for this benefit plan. Applicable primarily to life insurance and retirement benefits. True indicates beneficiary forms are complete, false indicates missing or incomplete.',
    `carrier_acknowledgement_received` BOOLEAN COMMENT 'Indicates whether the benefit carrier has acknowledged receipt and acceptance of the enrollment. True indicates carrier confirmed enrollment, false indicates no acknowledgement or rejection.',
    `carrier_acknowledgement_timestamp` TIMESTAMP COMMENT 'Date and time when the benefit carrier acknowledged the enrollment. Used for reconciliation and SLA (Service Level Agreement) tracking with external providers.',
    `cobra_election_deadline_date` DATE COMMENT 'Date by which the employee must elect COBRA continuation coverage. Typically 60 days from the qualifying event or notice date, whichever is later. Populated only when COBRA eligible is true.',
    `cobra_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for COBRA continuation coverage upon termination of this enrollment. True indicates COBRA rights apply, false indicates not eligible. Applicable primarily to health insurance enrollments.',
    `contribution_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contribution amounts. Typically USD for US-based telecommunications operations but supports multi-currency for global workforce.. Valid values are `^[A-Z]{3}$`',
    `coverage_end_date` DATE COMMENT 'Date when benefit coverage terminates. Nullable for active ongoing enrollments. Populated upon termination, plan change, or employment separation.',
    `coverage_start_date` DATE COMMENT 'Effective date when benefit coverage begins. May differ from enrollment date due to waiting periods or plan year alignment.',
    `coverage_tier` STRING COMMENT 'Level of coverage selected by the employee indicating who is covered under the benefit plan. Determines premium amounts and coverage scope.. Valid values are `employee_only|employee_spouse|employee_children|employee_family|employee_domestic_partner`',
    `dependent_count` STRING COMMENT 'Number of dependents covered under this enrollment. Used for coverage verification and premium calculation validation.',
    `employee_monthly_contribution_amount` DECIMAL(18,2) COMMENT 'Monthly premium amount deducted from employee paycheck for this benefit enrollment. Represents the employee share of the benefit cost.',
    `employer_monthly_contribution_amount` DECIMAL(18,2) COMMENT 'Monthly premium amount paid by the employer for this benefit enrollment. Represents the employer subsidy or contribution toward the benefit cost.',
    `enrollment_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the enrollment was approved by HR or benefits administrator. Null if approval is not required or still pending.',
    `enrollment_confirmation_number` STRING COMMENT 'Unique confirmation number provided by the benefit provider upon successful enrollment. Used for tracking and verification with external benefit administrators.',
    `enrollment_date` DATE COMMENT 'Date when the employee submitted the enrollment election. Represents the business event timestamp when the enrollment decision was made.',
    `enrollment_event_type` STRING COMMENT 'Classification of the event that triggered this enrollment. New hire indicates initial employment enrollment, open enrollment indicates annual election period, qualifying life event indicates mid-year change due to marriage/birth/etc, voluntary change indicates employee-initiated modification, annual renewal indicates automatic continuation, rehire indicates return to employment.. Valid values are `new_hire|open_enrollment|qualifying_life_event|voluntary_change|annual_renewal|rehire`',
    `enrollment_method` STRING COMMENT 'Channel or method through which the employee completed the enrollment. Online portal indicates self-service web enrollment, paper form indicates manual submission, phone indicates call center enrollment, benefits fair indicates in-person event, HR representative indicates assisted enrollment, mobile app indicates mobile self-service.. Valid values are `online_portal|paper_form|phone|benefits_fair|hr_representative|mobile_app`',
    `enrollment_source_record_code` STRING COMMENT 'Unique identifier of this enrollment record in the source system. Used for data lineage, reconciliation, and troubleshooting integration issues.',
    `enrollment_source_system` STRING COMMENT 'Name of the source system or benefits administration platform from which this enrollment record originated. Examples include SAP S/4HANA HCM, Workday, ADP, or third-party benefits administration systems.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the benefit enrollment. Active indicates coverage is in effect, pending indicates awaiting approval or effective date, terminated indicates coverage has ended, waived indicates employee declined coverage, suspended indicates temporary hold, cancelled indicates enrollment was reversed before taking effect.. Valid values are `active|pending|terminated|waived|suspended|cancelled`',
    `enrollment_submitted_timestamp` TIMESTAMP COMMENT 'Precise date and time when the enrollment was submitted by the employee. Provides audit trail for compliance with election deadlines and regulatory windows.',
    `enrollment_transmitted_to_carrier_timestamp` TIMESTAMP COMMENT 'Date and time when the enrollment was transmitted to the benefit provider or insurance carrier. Used for tracking integration SLA (Service Level Agreement) and troubleshooting transmission failures.',
    `evidence_of_insurability_required` BOOLEAN COMMENT 'Indicates whether the employee must provide medical evidence of insurability for this enrollment. Typically required for late enrollments or coverage amounts exceeding guaranteed issue limits. True indicates EOI is required, false indicates no medical underwriting needed.',
    `evidence_of_insurability_status` STRING COMMENT 'Current status of the evidence of insurability review process. Not required indicates no medical underwriting needed, pending indicates awaiting carrier decision, approved indicates coverage granted, denied indicates coverage declined, incomplete indicates additional information needed.. Valid values are `not_required|pending|approved|denied|incomplete`',
    `notes` STRING COMMENT 'Free-text field for additional comments, special circumstances, or administrative notes related to this enrollment. Used by HR and benefits administrators for case management and documentation.',
    `plan_year` STRING COMMENT 'Calendar year for which this enrollment is effective. Benefit plans typically operate on annual cycles aligned with plan years.',
    `provider_enrollment_code` STRING COMMENT 'Unique identifier assigned by the external benefit provider or insurance carrier for this enrollment. Used for coordination with carrier systems and claims processing.',
    `qualifying_life_event_date` DATE COMMENT 'Date when the qualifying life event occurred. Used to validate enrollment timing and compliance with 30-day or 60-day election windows mandated by regulations.',
    `qualifying_life_event_type` STRING COMMENT 'Specific type of qualifying life event that permitted mid-year enrollment change. Examples include marriage, divorce, birth, adoption, loss of other coverage, change in employment status. Populated only when enrollment event type is qualifying life event. [ENUM-REF-CANDIDATE: marriage|divorce|birth|adoption|death_of_dependent|loss_of_coverage|employment_status_change|dependent_age_out|court_order|other — promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was first created in the data warehouse. Used for data lineage and audit trail purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was last modified in the data warehouse. Used for change tracking and data quality monitoring.',
    `termination_reason` STRING COMMENT 'Explanation for why the benefit enrollment was terminated. Examples include employment termination, plan change, employee request, loss of eligibility, retirement, death. Populated only when coverage end date is set and enrollment status is terminated.',
    `termination_reason_code` STRING COMMENT 'Standardized code categorizing the reason for enrollment termination. Employment termination indicates separation from company, plan change indicates switch to different benefit plan, employee request indicates voluntary cancellation, loss of eligibility indicates no longer qualified, retirement indicates employee retired, death indicates employee deceased.. Valid values are `employment_termination|plan_change|employee_request|loss_eligibility|retirement|death`',
    `tobacco_user_status` STRING COMMENT 'Employee self-reported tobacco use status. Used for premium rating in health and life insurance plans. User indicates tobacco use within specified lookback period, non-user indicates no tobacco use, declined to answer indicates employee chose not to disclose.. Valid values are `user|non_user|declined_to_answer`',
    `waiver_reason` STRING COMMENT 'Free-text explanation provided by employee when declining benefit coverage. Populated only when enrollment status is waived. Used for compliance documentation and trend analysis.',
    `waiver_reason_code` STRING COMMENT 'Standardized code categorizing why the employee waived coverage. Spouse coverage indicates covered under spouses plan, other employer indicates coverage through another job, government program indicates Medicare/Medicaid/VA, cost indicates unaffordable, not needed indicates no perceived need, other for miscellaneous reasons.. Valid values are `spouse_coverage|other_employer|government_program|cost|not_needed|other`',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Transactional record of an employees enrollment in a specific benefit plan for a coverage period. Captures employee reference, benefit plan reference, coverage tier selected (employee only, employee+spouse, employee+children, family), enrollment date, coverage start date, coverage end date, enrollment event type (new hire, open enrollment, qualifying life event, voluntary change), employee monthly contribution amount, employer monthly contribution amount, dependent count, enrollment status (active, pending, terminated, waived), waiver reason if applicable, and benefit provider enrollment confirmation number.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`leave_entitlement` (
    `leave_entitlement_id` BIGINT COMMENT 'Unique identifier for the leave entitlement record. Primary key for this entity.',
    `created_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user or process that created this leave entitlement record. Used for audit trail.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who holds this leave entitlement. Links to the employee master record in the people domain.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user or process that last modified this leave entitlement record. Used for audit trail.',
    `carried_from_leave_entitlement_id` BIGINT COMMENT 'Self-referencing FK on leave_entitlement (carried_from_leave_entitlement_id)',
    `accrual_end_date` DATE COMMENT 'Date on which leave accrual ends for this entitlement record. Typically the end of the leave year or the employees termination date.',
    `accrual_frequency` STRING COMMENT 'Frequency at which leave days are accrued for this entitlement. Monthly indicates leave accrues each month; annual indicates full entitlement granted at start of year; per_pay_period indicates accrual aligned with payroll cycles; daily indicates daily accrual; quarterly indicates accrual every quarter.. Valid values are `monthly|annual|per_pay_period|daily|quarterly`',
    `accrual_start_date` DATE COMMENT 'Date from which leave accrual begins for this entitlement record. Typically the start of the leave year or the employees hire date.',
    `accrued_days` DECIMAL(18,2) COMMENT 'Number of leave days accrued to date within the current leave year, based on the accrual frequency and the employees tenure. Measured in days and may include fractional days.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether manager or HR approval is required before leave can be taken for this entitlement (True) or if leave can be taken without prior approval (False).',
    `balance_as_of_date` DATE COMMENT 'The date as of which the leave balance figures (accrued, taken, pending, remaining) are accurate. Used for point-in-time reporting and reconciliation.',
    `carried_forward_days` DECIMAL(18,2) COMMENT 'Number of unused leave days carried forward from the previous leave year, subject to company policy and regulatory limits. Measured in days and may include fractional days.',
    `carryover_expiry_date` DATE COMMENT 'Date by which carried-forward leave days must be used, after which they will be forfeited. Null indicates no expiry.',
    `carryover_limit_days` DECIMAL(18,2) COMMENT 'Maximum number of leave days that can be carried forward to the next leave year, as per company policy or regulatory requirements. Null indicates no limit. Measured in days and may include fractional days.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leave entitlement record was first created in the system. Used for audit trail and data lineage.',
    `entitlement_days` DECIMAL(18,2) COMMENT 'Total number of leave days the employee is entitled to for this leave type in the specified leave year, as per company policy, employment contract, or statutory requirements. Measured in days and may include fractional days.',
    `entitlement_status` STRING COMMENT 'Current lifecycle status of the leave entitlement record. Active indicates the entitlement is currently valid and available for use; inactive indicates it is not currently in effect; expired indicates the leave year has ended; suspended indicates temporary hold; pending indicates awaiting approval or activation.. Valid values are `active|inactive|expired|suspended|pending`',
    `forfeited_days` DECIMAL(18,2) COMMENT 'Number of leave days forfeited due to expiration, policy limits, or failure to use within the allowed timeframe. Measured in days and may include fractional days.',
    `is_paid` BOOLEAN COMMENT 'Indicates whether this leave type is paid (True) or unpaid (False).',
    `is_statutory` BOOLEAN COMMENT 'Indicates whether this leave entitlement is mandated by statutory or regulatory requirements (True) or is a company-provided benefit (False).',
    `jurisdiction_code` STRING COMMENT 'Two or three-letter code identifying the legal jurisdiction (country or state/province) whose labor laws govern this leave entitlement (e.g., US, UK, CA, DE).. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this leave entitlement record was last updated. Used for audit trail and change tracking.',
    `leave_type_code` STRING COMMENT 'Standardized code identifying the type of leave (e.g., AL for annual leave, SL for sick leave, ML for maternity leave, PL for paternity leave, PRNT for parental leave, BRV for bereavement leave, STD for study leave, UNP for unpaid leave, COMP for compensatory leave).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `leave_type_name` STRING COMMENT 'Human-readable name of the leave type (e.g., Annual Leave, Sick Leave, Maternity Leave, Paternity Leave, Parental Leave, Bereavement Leave, Study Leave, Unpaid Leave, Compensatory Leave).',
    `leave_year` STRING COMMENT 'The calendar or fiscal year for which this leave entitlement applies. Typically a four-digit year (e.g., 2024).',
    `liability_amount` DECIMAL(18,2) COMMENT 'Estimated financial liability for unused leave days, calculated based on the employees current salary and remaining leave balance. Used for financial reporting and accrual accounting. Measured in the companys reporting currency.',
    `liability_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the leave liability amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to this leave entitlement (e.g., special approvals, adjustments, policy exceptions).',
    `pending_days` DECIMAL(18,2) COMMENT 'Number of leave days that have been approved but not yet taken (future-dated leave requests). Measured in days and may include fractional days.',
    `policy_reference` STRING COMMENT 'Reference to the company policy document or section that governs this leave entitlement (e.g., policy number, handbook section, collective bargaining agreement clause).',
    `proration_factor` DECIMAL(18,2) COMMENT 'Factor used to prorate leave entitlement for employees who join or leave mid-year, or who work part-time. A value of 1.0000 indicates full entitlement; values less than 1.0000 indicate prorated entitlement.',
    `remaining_balance_days` DECIMAL(18,2) COMMENT 'Current remaining leave balance available for the employee to use, calculated as (entitlement_days + carried_forward_days + accrued_days - taken_days - pending_days - forfeited_days). Measured in days and may include fractional days.',
    `source_record_code` STRING COMMENT 'Unique identifier of this leave entitlement record in the source operational system. Used for data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this leave entitlement data originated (e.g., SAP_HCM, WORKDAY, ORACLE_HCM).',
    `taken_days` DECIMAL(18,2) COMMENT 'Number of leave days already taken by the employee for this leave type in the specified leave year. Measured in days and may include fractional days.',
    CONSTRAINT pk_leave_entitlement PRIMARY KEY(`leave_entitlement_id`)
) COMMENT 'Master record tracking an employees leave balance and entitlement for each leave type within a leave year. Captures employee reference, leave year, leave type (annual leave, sick leave, maternity leave, paternity leave, parental leave, bereavement leave, study leave, unpaid leave, compensatory leave), entitlement days, carried-forward days from prior year, accrued days to date, taken days, pending days (approved but not yet taken), forfeited days, remaining balance, accrual frequency (monthly, annual, per-pay-period), and balance as-of date. Supports leave liability reporting and workforce availability planning.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request transaction. Primary key for the leave request record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee submitting the leave request. Links to the employee master record in the people domain.',
    `tertiary_leave_substitute_employee_id` BIGINT COMMENT 'Reference to the employee designated to cover responsibilities during the leave period. Optional field used for workforce continuity planning.',
    `original_leave_request_id` BIGINT COMMENT 'Self-referencing FK on leave_request (original_leave_request_id)',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the leave request (e.g., medical certificates, travel documents). Used to enforce documentation requirements for certain leave types.',
    `comments` STRING COMMENT 'Additional free-text comments or notes added by the employee, manager, or HR during the leave request lifecycle. Used for communication and audit trail.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the employees leave time is charged. Used for labor cost allocation and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the leave request record was first created in the database. Used for audit trail and data lineage tracking.',
    `days_requested` DECIMAL(18,2) COMMENT 'Total number of leave days requested, including partial days. Calculated based on working days between start and end dates, accounting for half-day flags and organizational calendar.',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time when the manager approved or rejected the leave request. Null for pending requests. Used for SLA (Service Level Agreement) tracking and approval turnaround metrics.',
    `department_code` STRING COMMENT 'Code identifying the organizational department of the requesting employee at the time of submission. Used for workforce availability reporting and departmental leave analytics.',
    `emergency_contact_phone` STRING COMMENT 'Optional phone number where the employee can be reached during the leave period in case of urgent business matters. Confidential contact information.',
    `end_date` DATE COMMENT 'Last calendar date of the requested leave period. Inclusive end date for leave duration calculation.',
    `entitlement_balance_after` DECIMAL(18,2) COMMENT 'Calculated leave entitlement balance after deducting the approved leave days. Updated when request_status changes to APPROVED and used to prevent over-allocation.',
    `entitlement_balance_before` DECIMAL(18,2) COMMENT 'Snapshot of the employees leave entitlement balance for the applicable leave type at the time of request submission. Used for audit trail and balance reconciliation.',
    `half_day_period` STRING COMMENT 'Specifies which half of the day is requested when is_half_day is true. Used for workforce scheduling and shift coverage planning.. Valid values are `MORNING|AFTERNOON`',
    `hr_override_flag` BOOLEAN COMMENT 'Indicates whether HR manually overrode the standard approval workflow or entitlement rules for this request. Used for audit and exception reporting.',
    `hr_override_reason` STRING COMMENT 'Explanation for why HR overrode standard rules. Required when hr_override_flag is true to maintain audit trail and compliance documentation.',
    `is_half_day` BOOLEAN COMMENT 'Flag indicating whether the leave request is for a half-day (morning or afternoon) rather than a full day. Affects leave balance deduction and workforce availability calculation.',
    `leave_type_code` STRING COMMENT 'Classification of the leave request type. Determines entitlement rules, approval workflow, and balance deduction logic. [ENUM-REF-CANDIDATE: ANNUAL|SICK|PERSONAL|PARENTAL|BEREAVEMENT|UNPAID|COMPENSATORY — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the leave request record was last updated. Used for audit trail, change tracking, and data synchronization.',
    `reason` STRING COMMENT 'Optional free-text explanation provided by the employee for the leave request. May be required for certain leave types per organizational policy.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the manager when rejecting a leave request. Required when request_status is REJECTED to ensure transparency and compliance.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the leave request, formatted as LR-YYYYNNNN for external reference and tracking.. Valid values are `^LR-[0-9]{8}$`',
    `request_status` STRING COMMENT 'Current lifecycle state of the leave request in the approval workflow. Drives downstream workforce availability and entitlement balance updates.. Valid values are `PENDING|APPROVED|REJECTED|CANCELLED|RECALLED`',
    `requires_documentation_flag` BOOLEAN COMMENT 'Indicates whether the leave type or duration requires supporting documentation per organizational policy. Used to validate request completeness before approval.',
    `return_confirmed_flag` BOOLEAN COMMENT 'Indicates whether the employees return to work has been confirmed by the manager or HR. Used to close the leave transaction and trigger final balance updates.',
    `return_to_work_date` DATE COMMENT 'Actual date the employee returned to work after the leave period. Used to confirm leave completion and reconcile any discrepancies between planned and actual leave duration.',
    `start_date` DATE COMMENT 'First calendar date of the requested leave period. Used to calculate leave duration and check entitlement balance availability.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the employee submitted the leave request. Used for audit trail and to enforce advance notice policy rules.',
    `work_location_code` STRING COMMENT 'Code identifying the employees primary work location at the time of the leave request. Used for site-level workforce availability planning and compliance with location-specific leave policies.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Transactional record of an employees leave application and approval workflow. Captures employee reference, leave type, requested start date, requested end date, number of days requested, half-day flag, leave reason (optional), manager approver reference, submission timestamp, approval/rejection timestamp, approval status (pending, approved, rejected, cancelled, recalled), rejection reason, HR override flag, substitute employee reference, and return-to-work confirmation date. Feeds leave entitlement balance updates and workforce availability calendars.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`performance_cycle` (
    `performance_cycle_id` BIGINT COMMENT 'Unique identifier for the performance management cycle. Primary key.',
    `cycle_owner_employee_id` BIGINT COMMENT 'Identifier of the Human Resources (HR) business partner or administrator responsible for managing and overseeing this performance cycle.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or administrator who created this performance cycle configuration. Audit trail field.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user or administrator who last modified this performance cycle configuration. Audit trail field.',
    `prior_performance_cycle_id` BIGINT COMMENT 'Self-referencing FK on performance_cycle (prior_performance_cycle_id)',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether performance reviews in this cycle require formal approval by Human Resources (HR) or senior leadership before finalization (True) or can be finalized by managers directly (False).',
    `calibration_end_date` DATE COMMENT 'The deadline by which all calibration sessions must be completed and final ratings approved.',
    `calibration_start_date` DATE COMMENT 'The date when calibration sessions begin, where leadership reviews and normalizes performance ratings across teams to ensure fairness and consistency.',
    `compensation_impact_flag` BOOLEAN COMMENT 'Indicates whether performance ratings from this cycle directly impact compensation decisions such as merit increases, bonuses, or incentive payouts (True) or are for development purposes only (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance cycle record was first created in the system. Audit trail field.',
    `cycle_code` STRING COMMENT 'Business identifier code for the performance cycle (e.g., FY2024-ANNUAL, Q2-2024-CHECKIN). Used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `cycle_description` STRING COMMENT 'Detailed description of the performance cycle, including its purpose, scope, key objectives, and any special instructions or considerations for participants.',
    `cycle_end_date` DATE COMMENT 'The date when the performance cycle officially ends. Marks the conclusion of the performance period and all review activities.',
    `cycle_name` STRING COMMENT 'Human-readable name of the performance cycle (e.g., 2024 Annual Performance Review, Q2 2024 Quarterly Check-In).',
    `cycle_start_date` DATE COMMENT 'The date when the performance cycle officially begins. Marks the start of the performance period being evaluated.',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the performance cycle: planned (configured but not started), active (currently running), in_progress (reviews underway), calibration (manager calibration phase), closed (completed and finalized), cancelled (terminated before completion).. Valid values are `planned|active|in_progress|calibration|closed|cancelled`',
    `cycle_type` STRING COMMENT 'Type of performance management cycle: annual appraisal (comprehensive year-end review), mid-year review (mid-cycle checkpoint), quarterly check-in (frequent touchpoint), probation review (new hire evaluation), PIP review (Performance Improvement Plan assessment), or 360-degree feedback (multi-rater assessment).. Valid values are `annual_appraisal|mid_year_review|quarterly_check_in|probation_review|pip_review|360_feedback`',
    `distribution_guideline` STRING COMMENT 'Textual description of the rating distribution guideline or target percentages for each rating level (e.g., Exceeds: 15-20%, Meets: 70-75%, Below: 5-10%). Applies when forced_distribution_flag is True.',
    `eligible_population_criteria` STRING COMMENT 'Business rules defining which employees are included in this performance cycle (e.g., all full-time employees with 90+ days tenure, all managers and above, specific departments or business units). May reference employee attributes such as employment type, tenure, job level, or organizational unit.',
    `enable_360_feedback_flag` BOOLEAN COMMENT 'Indicates whether 360-degree feedback (multi-rater feedback from peers, direct reports, and other stakeholders) is enabled for this performance cycle (True) or disabled (False).',
    `enable_calibration_flag` BOOLEAN COMMENT 'Indicates whether calibration sessions are enabled for this performance cycle (True) or disabled (False). When enabled, leadership reviews and normalizes ratings across teams.',
    `enable_goal_setting_flag` BOOLEAN COMMENT 'Indicates whether goal setting is enabled for this performance cycle (True) or disabled (False). When enabled, employees and managers must define performance objectives.',
    `enable_self_assessment_flag` BOOLEAN COMMENT 'Indicates whether employee self-assessment is enabled for this performance cycle (True) or disabled (False). When enabled, employees complete self-evaluations before manager reviews.',
    `forced_distribution_flag` BOOLEAN COMMENT 'Indicates whether forced (or guided) distribution of performance ratings is required for this cycle (True) or not (False). When enabled, managers must distribute ratings according to predefined percentages (e.g., 20% top performers, 70% meets expectations, 10% below expectations).',
    `goal_setting_end_date` DATE COMMENT 'The deadline by which all performance goals and objectives must be finalized and approved.',
    `goal_setting_start_date` DATE COMMENT 'The date when employees and managers can begin setting performance goals and objectives for the cycle.',
    `manager_review_end_date` DATE COMMENT 'The deadline by which managers must complete all performance reviews and submit ratings for their direct reports.',
    `manager_review_start_date` DATE COMMENT 'The date when managers can begin conducting performance reviews and providing ratings for their direct reports.',
    `mandatory_participation_flag` BOOLEAN COMMENT 'Indicates whether participation in this performance cycle is mandatory for eligible employees (True) or optional (False). Mandatory cycles require completion for all eligible employees.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance cycle record was last modified. Audit trail field.',
    `notification_enabled_flag` BOOLEAN COMMENT 'Indicates whether automated email or system notifications are enabled for this performance cycle (True) to remind employees and managers of upcoming deadlines, or disabled (False).',
    `performance_year` STRING COMMENT 'The fiscal or calendar year this performance cycle applies to (e.g., 2024).',
    `promotion_eligibility_flag` BOOLEAN COMMENT 'Indicates whether performance ratings from this cycle are used to determine promotion eligibility (True) or not (False).',
    `rating_scale_code` STRING COMMENT 'Reference code identifying the performance rating scale used for this cycle (e.g., SCALE_5PT, SCALE_4PT_FORCED). Links to the rating scale configuration defining rating levels and distribution guidelines.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `self_assessment_end_date` DATE COMMENT 'The deadline by which employees must complete and submit their self-assessment evaluations.',
    `self_assessment_start_date` DATE COMMENT 'The date when employees can begin completing their self-assessment evaluations.',
    CONSTRAINT pk_performance_cycle PRIMARY KEY(`performance_cycle_id`)
) COMMENT 'Reference master defining the performance management cycles (annual, mid-year, quarterly check-in) configured for the telecommunications enterprise. Captures cycle code, cycle name, performance year, cycle type (annual appraisal, mid-year review, probation review, pip review, 360-degree feedback), cycle start date, cycle end date, goal-setting window start and end, self-assessment window start and end, manager review window start and end, calibration window start and end, rating scale reference, eligible employee population criteria, and cycle status (planned, active, closed).';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key for the performance review entity.',
    `calibration_session_id` BIGINT COMMENT 'Reference to the calibration session during which this performance review was discussed and potentially adjusted. Links to the calibration session master record.',
    `performance_cycle_id` BIGINT COMMENT 'Reference to the performance cycle or appraisal period during which this review was conducted. Links to the performance cycle master record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee being reviewed. Links to the employee master record in the people domain.',
    `prior_performance_review_id` BIGINT COMMENT 'Self-referencing FK on performance_review (prior_performance_review_id)',
    `calibration_adjusted_rating` STRING COMMENT 'Performance rating after calibration session adjustments. May differ from the initial overall_rating_numeric if the calibration committee adjusted the rating for consistency across the organization.',
    `competency_assessment_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the employees demonstration of core competencies and behavioral attributes during the performance cycle. Typically expressed as a percentage or decimal.',
    `cost_center_code` STRING COMMENT 'Cost center to which the employee was assigned during the review period. Used for financial reporting and workforce cost allocation.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was first created in the system. Used for audit trail and data lineage tracking.',
    `department_code` STRING COMMENT 'Code identifying the department to which the employee belonged during the review period. Used for organizational reporting and analysis.. Valid values are `^[A-Z0-9]{3,10}$`',
    `development_plan_created_flag` BOOLEAN COMMENT 'Boolean indicator of whether an individual development plan was created as part of this performance review. True indicates a development plan exists.',
    `employee_acknowledgment_date` DATE COMMENT 'Date on which the employee acknowledged receipt and review of their performance appraisal. Indicates the employee has been informed of their rating.',
    `employee_self_assessment` STRING COMMENT 'Free-text narrative provided by the employee reflecting on their own performance, accomplishments, challenges, and development needs during the performance cycle.',
    `final_rating_confirmed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the final performance rating has been confirmed and locked. True indicates the rating is final and cannot be changed without formal override.',
    `goal_achievement_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the percentage or degree to which the employee achieved their assigned goals during the performance cycle. Typically expressed as a percentage (0-100) or decimal (0.00-1.00).',
    `job_level` STRING COMMENT 'Organizational job level or grade of the employee during the review period. Used for calibration and compensation planning.',
    `job_title` STRING COMMENT 'Job title or position held by the employee during the review period. Provides context for performance expectations and competency assessment.',
    `manager_comments` STRING COMMENT 'Free-text narrative comments provided by the manager summarizing the employees performance, strengths, areas for improvement, and development recommendations.',
    `merit_increase_recommended_pct` DECIMAL(18,2) COMMENT 'Recommended merit increase percentage based on the performance rating. Used as input to compensation planning and salary adjustment processes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was last modified. Used for audit trail and change tracking.',
    `overall_rating_label` STRING COMMENT 'Textual label corresponding to the numeric performance rating. Provides human-readable interpretation of the overall rating.. Valid values are `below_expectations|meets_expectations|exceeds_expectations|outstanding|exceptional`',
    `overall_rating_numeric` STRING COMMENT 'Numeric performance rating assigned to the employee. Typically on a scale such as 1-5 where 1=Below Expectations, 2=Meets Expectations, 3=Exceeds Expectations, 4=Outstanding, 5=Exceptional.',
    `pip_end_date` DATE COMMENT 'Scheduled end date for the Performance Improvement Plan. Represents the target date by which performance improvement is expected. Null if no PIP was triggered.',
    `pip_flag` BOOLEAN COMMENT 'Boolean indicator of whether a Performance Improvement Plan was triggered as a result of this review. True indicates the employee has been placed on a PIP.',
    `pip_start_date` DATE COMMENT 'Date on which the Performance Improvement Plan commenced. Null if no PIP was triggered.',
    `promotion_recommended_flag` BOOLEAN COMMENT 'Boolean indicator of whether the manager recommended the employee for promotion based on this performance review. True indicates a promotion recommendation.',
    `rating_confirmation_date` DATE COMMENT 'Date on which the final performance rating was confirmed and locked. Represents the official date the rating became final.',
    `review_completion_date` DATE COMMENT 'Actual date on which the performance review was completed and submitted by the manager. Used to measure adherence to review timelines.',
    `review_due_date` DATE COMMENT 'Target date by which the performance review should be completed and submitted. Used for tracking review completion timeliness.',
    `review_number` STRING COMMENT 'Human-readable business identifier for the performance review. Typically follows a pattern such as PR-YYYY-NNNNNN where YYYY is the year and NNNNNN is a sequential number.. Valid values are `^PR-[0-9]{4}-[0-9]{6}$`',
    `review_period_end_date` DATE COMMENT 'End date of the performance period being evaluated in this review. Defines the conclusion of the timeframe for which performance is assessed.',
    `review_period_start_date` DATE COMMENT 'Start date of the performance period being evaluated in this review. Defines the beginning of the timeframe for which performance is assessed.',
    `review_status` STRING COMMENT 'Current lifecycle status of the performance review. Tracks the review through its workflow from initiation to completion and acknowledgment.. Valid values are `not_started|in_progress|submitted|calibrated|acknowledged|closed`',
    `reviewer_comments` STRING COMMENT 'Additional comments provided by secondary reviewers or HR business partners during the review process. Supplements manager comments with broader organizational perspective.',
    `succession_readiness_level` STRING COMMENT 'Assessment of the employees readiness for succession into higher-level roles. Used for talent management and succession planning.. Valid values are `not_ready|ready_1_2_years|ready_now|high_potential`',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Transactional record of an individual employees performance appraisal within a performance cycle. Captures employee reference, performance cycle reference, manager reviewer reference, overall performance rating (numeric and label — e.g., 1=Below Expectations, 2=Meets Expectations, 3=Exceeds Expectations, 4=Outstanding), goal achievement score, competency assessment score, manager narrative comments, employee self-assessment narrative, calibration adjusted rating, calibration session reference, final rating confirmed flag, rating confirmation date, performance improvement plan flag, PIP start date, PIP end date, and review status (not started, in progress, submitted, calibrated, acknowledged, closed).';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`goal` (
    `goal_id` BIGINT COMMENT 'Unique identifier for the employee performance goal record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee to whom this goal is assigned. Links to the employee master record in the people domain.',
    `goal_manager_employee_id` BIGINT COMMENT 'Reference to the employees direct manager who is responsible for reviewing, approving, and evaluating this goal. Links to the employee master record.',
    `parent_goal_id` BIGINT COMMENT 'Reference to the parent goal from which this goal was cascaded (typically a managers or organizational goal). Null if this is a top-level or self-created goal. Enables goal hierarchy and alignment tracking.',
    `performance_cycle_id` BIGINT COMMENT 'Reference to the performance management cycle (annual, semi-annual, quarterly) within which this goal is set and evaluated.',
    `achievement_percentage` DECIMAL(18,2) COMMENT 'The percentage of goal achievement calculated as (actual_value / target_value) * 100. Values over 100% indicate over-achievement. Used to compute weighted contribution to overall performance rating.',
    `actual_completion_date` DATE COMMENT 'The actual date when the goal was completed or the performance cycle ended and final achievement was recorded. Null if the goal is still in progress.',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual quantitative value achieved by the employee at the end of the performance cycle (e.g., 99.97 for 99.97% uptime achieved, 45 for 45 training hours completed). Populated during year-end evaluation.',
    `comments` STRING COMMENT 'General comments, notes, or additional context about the goal. May include employee self-assessment notes, manager feedback, or collaborative discussion points.',
    `competency_code` STRING COMMENT 'Reference code to the competency framework or skill taxonomy that this goal develops or demonstrates (e.g., LEAD-001 for leadership, TECH-5G for 5G technical skills). Applicable primarily to development and behavioral goals.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this goal record was first created in the system. Audit trail for goal lifecycle tracking.',
    `employee_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the employee has formally acknowledged and accepted this goal. True means the employee has reviewed and committed to the goal; False means it is still pending employee acceptance.',
    `employee_acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the employee formally acknowledged and committed to this goal. Null if not yet acknowledged.',
    `goal_category` STRING COMMENT 'Classification of the goal type: business_objective (tied to KPIs and business outcomes), development_goal (skill building, training, career growth), behavioral_competency (leadership, collaboration, communication), operational_excellence (process improvement, efficiency), customer_satisfaction (NPS, CSAT improvement), or innovation (new initiatives, R&D).. Valid values are `business_objective|development_goal|behavioral_competency|operational_excellence|customer_satisfaction|innovation`',
    `goal_description` STRING COMMENT 'Detailed narrative description of the goal, including context, expected outcomes, success criteria, and any relevant background information.',
    `goal_number` STRING COMMENT 'Human-readable business identifier for the goal, typically formatted as cycle-employee-sequence (e.g., 2024-EMP12345-G01).',
    `goal_source` STRING COMMENT 'Origin of the goal: cascaded_from_manager (manager assigned from their own goals), self_created (employee proposed), hr_assigned (HR or talent management assigned), org_objective_aligned (derived from organizational unit objectives), peer_suggested (recommended by peer or cross-functional partner).. Valid values are `cascaded_from_manager|self_created|hr_assigned|org_objective_aligned|peer_suggested`',
    `goal_status` STRING COMMENT 'Current lifecycle status of the goal: draft (being defined), committed (approved and active), in_progress (employee working on it), completed (cycle ended, achievement recorded), cancelled (goal no longer applicable), deferred (postponed to next cycle).. Valid values are `draft|committed|in_progress|completed|cancelled|deferred`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this goal is mandatory for the employees role or performance evaluation. True means the goal must be included and achieved; False means it is optional or supplementary.',
    `is_stretch_goal` BOOLEAN COMMENT 'Indicates whether this is a stretch goal (aspirational, beyond normal expectations). True means this is a stretch goal; False means it is a standard performance goal. Stretch goals may have different evaluation criteria.',
    `last_review_date` DATE COMMENT 'The date of the most recent formal review or check-in for this goal. Used to track review cadence and ensure timely progress assessments.',
    `linked_training_plan_reference` BIGINT COMMENT 'Reference to a training or development plan that supports achievement of this goal. Enables tracking of learning activities tied to performance goals.',
    `manager_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the manager has formally acknowledged and approved this goal. True means the goal has been reviewed and accepted by the manager; False means it is still pending manager review.',
    `manager_acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the manager formally acknowledged and approved this goal. Null if not yet acknowledged.',
    `mid_year_progress_note` STRING COMMENT 'Narrative assessment of progress toward the goal at the mid-year review checkpoint. Captures manager and employee observations, challenges encountered, and any adjustments to approach or target.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this goal record was last modified. Tracks updates to goal details, progress, or status throughout the performance cycle.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review or check-in for this goal. Helps managers and employees plan progress discussions.',
    `org_unit_objective_reference` BIGINT COMMENT 'Reference to the organizational units strategic objective to which this goal is aligned. Enables tracking of individual goal contribution to departmental and enterprise objectives.',
    `priority_level` STRING COMMENT 'The relative priority or urgency of this goal compared to the employees other goals: critical (must achieve, business-critical), high (important, significant impact), medium (standard priority), low (nice-to-have, stretch goal).. Valid values are `critical|high|medium|low`',
    `review_frequency` STRING COMMENT 'The cadence at which this goal is reviewed and progress is assessed: weekly, bi_weekly, monthly, quarterly, semi_annual, annual, or ad_hoc (as needed). [ENUM-REF-CANDIDATE: weekly|bi_weekly|monthly|quarterly|semi_annual|annual|ad_hoc — 7 candidates stripped; promote to reference product]',
    `start_date` DATE COMMENT 'The date when work on this goal officially begins. Typically aligns with the start of the performance cycle or the date the goal was committed.',
    `target_completion_date` DATE COMMENT 'The date by which the goal is expected to be achieved. Typically aligns with the end of the performance cycle or a specific milestone date.',
    `target_metric_name` STRING COMMENT 'The name of the Key Performance Indicator (KPI) or metric used to measure goal achievement (e.g., Network Uptime Percentage, Customer Churn Rate, Mean Time to Repair (MTTR), Revenue Growth, Training Hours Completed).',
    `target_metric_unit` STRING COMMENT 'The unit of measure for the target metric (e.g., percentage, hours, count, USD, days, incidents). Provides context for interpreting target and actual values.',
    `target_value` DECIMAL(18,2) COMMENT 'The quantitative target value the employee is expected to achieve for this goal (e.g., 99.95 for 99.95% uptime, 40 for 40 training hours, 5000000 for $5M revenue).',
    `title` STRING COMMENT 'Short, descriptive title of the performance goal (e.g., Increase Network Uptime to 99.95%, Complete 5G RAN Deployment in Metro Region).',
    `visibility_scope` STRING COMMENT 'Defines who can view this goal: private (employee and manager only), manager_only (manager and HR), team (employees immediate team), department (entire department), public (all employees in the organization).. Valid values are `private|manager_only|team|department|public`',
    `weight_percentage` DECIMAL(18,2) COMMENT 'The relative weight or importance of this goal within the employees overall performance evaluation, expressed as a percentage (e.g., 25.00 means this goal accounts for 25% of the total performance score). All goals for an employee within a cycle should sum to 100%.',
    `year_end_achievement_note` STRING COMMENT 'Final narrative assessment of goal achievement at year-end evaluation. Documents actual results, impact on business outcomes, lessons learned, and managers evaluation comments.',
    CONSTRAINT pk_goal PRIMARY KEY(`goal_id`)
) COMMENT 'Master record for individual employee performance goals set within a performance cycle. Captures employee reference, performance cycle reference, goal title, goal description, goal category (business objective, development goal, behavioral competency), goal weight percentage, target metric and unit, target value, actual achievement value, achievement percentage, goal status (draft, committed, in-progress, completed, cancelled), goal source (cascaded from manager, self-created, HR-assigned), alignment to org unit objective, mid-year progress note, year-end achievement note, and manager acknowledgment flag.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`learning_course` (
    `learning_course_id` BIGINT COMMENT 'Unique identifier for the learning and development course. Primary key for the learning course entity.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the Learning and Development (L&D) professional or subject matter expert responsible for course content, updates, and quality. Accountable for course relevance and effectiveness.',
    `primary_learning_approved_by_employee_id` BIGINT COMMENT 'Employee identifier of the L&D manager, compliance officer, or authorized approver who approved this course for delivery. Null for courses not yet approved.',
    `prerequisite_learning_course_id` BIGINT COMMENT 'Self-referencing FK on learning_course (prerequisite_learning_course_id)',
    `active_status` BOOLEAN COMMENT 'Indicates whether the course is currently active and available for enrollment. True for courses in the active catalog; false for retired, suspended, or archived courses. Used to filter available courses in learning portals.',
    `approval_date` DATE COMMENT 'Date when the course was formally approved for delivery and made available in the learning catalog. Null for courses not yet approved.',
    `approval_status` STRING COMMENT 'Current approval state of the course in the learning management system lifecycle. Draft courses are under development; pending review awaits L&D or compliance approval; approved courses are available for enrollment; retired courses are no longer offered; suspended courses are temporarily unavailable.. Valid values are `draft|pending_review|approved|retired|suspended`',
    `certification_body` STRING COMMENT 'Name of the organization or authority that issues the certification upon course completion. Examples include vendor certifications (Ericsson Certified, Nokia Certified), industry bodies (TM Forum, GSMA), or internal enterprise certifications. Null for non-certification courses.',
    `certification_flag` BOOLEAN COMMENT 'Indicates whether successful completion of this course results in a formal certification or credential. True for certification programs (e.g., 5G Network Specialist, OSS/BSS Administrator); false for general training.',
    `competency_framework` STRING COMMENT 'Reference to the enterprise competency model or skills framework this course supports. Maps course outcomes to organizational capability requirements (e.g., Network Operations Competency Model, Customer Experience Framework).',
    `course_category` STRING COMMENT 'Primary classification of the course content area. Categories align with telecommunications workforce development needs including technical skills (RAN, Core, OSS/BSS), leadership development, regulatory compliance (FCC, GDPR), safety training, product knowledge, and soft skills. [ENUM-REF-CANDIDATE: technical|leadership|compliance|safety|product_knowledge|soft_skills|regulatory|sales|customer_service|network_operations — 10 candidates stripped; promote to reference product]',
    `course_code` STRING COMMENT 'Unique business identifier for the course, used for catalog reference and enrollment systems. Typically alphanumeric code assigned by Learning and Development (L&D) or external training provider.. Valid values are `^[A-Z0-9]{4,12}$`',
    `course_description` STRING COMMENT 'Detailed description of the course content, learning objectives, prerequisites, and expected outcomes. Used for course selection and enrollment decisions.',
    `course_fee_amount` DECIMAL(18,2) COMMENT 'Cost per learner to deliver or purchase this course. Includes external vendor fees, licensing costs, or internal cost allocation. Zero for internally developed courses with no direct cost. Used for training budget management and Return on Investment (ROI) analysis.',
    `course_language` STRING COMMENT 'Primary language in which the course content is delivered, using ISO 639-2 three-letter language codes (e.g., ENG for English, SPA for Spanish, FRA for French). Critical for multinational telecommunications workforce.. Valid values are `^[A-Z]{3}$`',
    `course_title` STRING COMMENT 'Full official title of the learning course as displayed in the learning management system and course catalog.',
    `course_version` STRING COMMENT 'Version number of the course content, following semantic versioning (e.g., 1.0, 2.1). Incremented when course content, assessments, or learning objectives are updated. Supports version control and learner transcript accuracy.. Valid values are `^[0-9]+.[0-9]+$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this course record was first created in the learning catalog system. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Continuing education or professional development credits awarded upon successful course completion. Used for certification maintenance and professional licensing requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the course fee amount (e.g., USD, EUR, GBP). Required when course_fee_amount is non-zero.. Valid values are `^[A-Z]{3}$`',
    `delivery_mode` STRING COMMENT 'Method by which the course content is delivered to learners. Instructor-Led Training (ILT) can be classroom or virtual, e-learning is self-paced online, blended combines multiple modes, and on-the-job is experiential learning. [ENUM-REF-CANDIDATE: instructor_led_classroom|virtual_ilt|e_learning|blended|on_the_job|self_paced|webinar — 7 candidates stripped; promote to reference product]',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total instructional time required to complete the course, measured in hours. Includes classroom time, virtual sessions, and estimated self-study time for e-learning modules.',
    `effective_end_date` DATE COMMENT 'Date when this course is retired from the active catalog and no longer available for new enrollments. Null for courses with no planned retirement date. Supports course lifecycle management and catalog cleanup.',
    `effective_start_date` DATE COMMENT 'Date when this course becomes available for enrollment and delivery. Supports planned course launches and curriculum updates.',
    `last_content_update_date` DATE COMMENT 'Date when the course content, materials, or assessments were last revised. Critical for ensuring training materials reflect current technology, regulations, and business processes in the rapidly evolving telecommunications industry.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this course record was last updated in the learning catalog system. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking and audit trail.',
    `learning_management_system_code` STRING COMMENT 'External identifier for this course in the source Learning Management System (LMS) or Human Capital Management (HCM) platform. Used for system integration and data reconciliation with SAP SuccessFactors, Cornerstone, or other LMS platforms.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the course is required for specific roles, job families, or all employees. True for mandatory compliance, safety, or onboarding courses; false for optional professional development.',
    `max_enrollment_capacity` STRING COMMENT 'Maximum number of learners that can be enrolled in a single course session or offering. Relevant for instructor-led and virtual courses with limited seats. Null for unlimited capacity e-learning courses.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next content review and update cycle. Ensures courses remain current with technology evolution (5G, NFV, SDN), regulatory changes (FCC, GDPR), and business strategy shifts.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score or percentage required to successfully complete the course and receive credit or certification. Typically expressed as percentage (e.g., 80.00 for 80%). Null for courses without formal assessment.',
    `prerequisite_courses` STRING COMMENT 'Comma-separated list of course codes that must be completed before enrolling in this course. Defines learning path dependencies and ensures learners have foundational knowledge. Null if no prerequisites required.',
    `provider_name` STRING COMMENT 'Name of the organization or entity delivering the course. May be internal Learning and Development (L&D) department, external training vendor, industry association (GSMA, TM Forum), or technology partner (Ericsson, Nokia, Cisco).',
    `provider_type` STRING COMMENT 'Classification of the course provider. Internal courses are developed and delivered by enterprise L&D; external vendors are third-party training companies; industry associations include GSMA, TM Forum; technology partners are equipment manufacturers offering product training.. Valid values are `internal|external_vendor|industry_association|technology_partner|academic_institution`',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority or governing body that mandates this training (e.g., FCC for spectrum management, OSHA for safety, GDPR for data privacy). Null for non-regulatory courses.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this course fulfills a regulatory or compliance obligation imposed by governing bodies (FCC, GDPR, OSHA, industry standards). True for courses required by law or regulation; false for voluntary professional development.',
    `skill_level` STRING COMMENT 'Target proficiency level for learners completing this course. Foundation courses introduce new concepts; intermediate builds on existing knowledge; advanced courses develop deep expertise; expert level is for subject matter specialists.. Valid values are `foundation|intermediate|advanced|expert`',
    `tags` STRING COMMENT 'Comma-separated list of keywords or tags for course discovery and search. Examples include technology domains (5G, FTTH, OSS, BSS), business functions (billing, provisioning, customer care), or strategic initiatives (digital transformation, AI/ML).',
    `target_audience` STRING COMMENT 'Description of the intended learner population for this course. May specify job families (network engineers, customer service representatives), grade bands (individual contributor, manager, executive), departments, or all employees.',
    `validity_period_months` STRING COMMENT 'Number of months the course completion or certification remains valid before recertification or refresher training is required. Common for compliance, safety, and technical certification courses. Null for courses with no expiration.',
    CONSTRAINT pk_learning_course PRIMARY KEY(`learning_course_id`)
) COMMENT 'Reference master for all learning and development courses, training programs, and certifications available to the telecommunications enterprise workforce. Captures course code, course title, course description, course category (technical, leadership, compliance, safety, product knowledge, soft skills, regulatory), delivery mode (instructor-led classroom, virtual ILT, e-learning, blended, on-the-job), duration hours, credit hours, mandatory flag, target audience (all employees, specific job family, specific grade band), provider name (internal L&D, external vendor), course language, passing score threshold, validity period in months (for certifications), and active status.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`learning_enrollment` (
    `learning_enrollment_id` BIGINT COMMENT 'Unique identifier for the learning enrollment record. Primary key for the learning enrollment entity.',
    `learning_course_id` BIGINT COMMENT 'Reference to the learning course or training program in which the employee is enrolled. Links to the learning course catalog.',
    `employee_id` BIGINT COMMENT 'Reference to the employee enrolled in the learning course. Links to the employee master record.',
    `retake_of_learning_enrollment_id` BIGINT COMMENT 'Self-referencing FK on learning_enrollment (retake_of_learning_enrollment_id)',
    `actual_completion_date` DATE COMMENT 'Actual date when the employee completed the learning course or training program. Null if not yet completed.',
    `actual_start_date` DATE COMMENT 'Actual date when the employee began the learning course. May differ from scheduled start date due to delays or early commencement.',
    `approval_date` DATE COMMENT 'Date when the enrollment was approved by the manager or HR. Null for self-enrolled courses that do not require approval.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the employee on the course assessment or examination. Typically expressed as a percentage or points out of maximum.',
    `attendance_percentage` DECIMAL(18,2) COMMENT 'Percentage of scheduled sessions or modules that the employee attended or completed. Used to track engagement and compliance with attendance requirements.',
    `certificate_expiry_date` DATE COMMENT 'Date when the certificate expires and recertification or renewal is required. Null for certificates with no expiration.',
    `certificate_issue_date` DATE COMMENT 'Date when the completion certificate was issued to the employee.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a completion certificate was issued to the employee upon successful completion of the course.',
    `certificate_number` STRING COMMENT 'Unique identifier or reference number of the certificate issued to the employee. Used for verification and audit purposes.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of course content or modules completed by the employee. Tracks progress toward full course completion.',
    `compliance_category` STRING COMMENT 'Category of compliance or regulatory requirement that the learning course fulfills. Examples include safety training, data privacy, anti-corruption, or industry-specific certifications.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for the employees enrollment in the learning course, including tuition, materials, and delivery fees.',
    `cost_center_code` STRING COMMENT 'Cost center to which the learning course cost is allocated. Used for financial tracking and budget management.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount. Indicates the currency in which the course cost is denominated.. Valid values are `^[A-Z]{3}$`',
    `cpd_hours_credited` DECIMAL(18,2) COMMENT 'Number of Continuing Professional Development hours credited to the employee upon completion of the course. Used for professional certification and compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system. Used for audit trail and data lineage tracking.',
    `delivery_method` STRING COMMENT 'Method by which the learning course is delivered to the employee. Distinguishes between in-person, virtual, self-paced, and hybrid delivery formats.. Valid values are `classroom|virtual-instructor-led|e-learning|blended|on-the-job|webinar`',
    `delivery_session_reference` BIGINT COMMENT 'Reference to the specific delivery session or class instance in which the employee is enrolled. Links to the learning delivery schedule.',
    `enrollment_date` DATE COMMENT 'Date when the employee was enrolled in the learning course. Represents the business event timestamp for enrollment initiation.',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment reference number used for tracking and reporting purposes.',
    `enrollment_source` STRING COMMENT 'Origin or trigger for the enrollment. Indicates whether the enrollment was initiated by the employee, assigned by management, required for compliance, or triggered by system rules.. Valid values are `self-enrolled|manager-assigned|hr-mandated|compliance-required|system-triggered|career-development`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment. Tracks progression from initial enrollment through completion or withdrawal. [ENUM-REF-CANDIDATE: enrolled|in-progress|completed|failed|withdrawn|expired|cancelled — 7 candidates stripped; promote to reference product]',
    `feedback_comments` STRING COMMENT 'Free-text comments provided by the employee regarding their experience with the learning course. Used for qualitative analysis and course improvement.',
    `feedback_rating` DECIMAL(18,2) COMMENT 'Employee satisfaction rating for the learning course, typically on a scale of 1 to 5. Used to assess course quality and effectiveness.',
    `instructor_name` STRING COMMENT 'Name of the instructor or facilitator who delivered the learning course. Applicable for instructor-led training sessions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was last updated. Used for audit trail and change tracking.',
    `learning_hours_logged` DECIMAL(18,2) COMMENT 'Total number of hours the employee spent on the learning course, including instruction time, self-study, and assessments.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the learning course is mandatory for the employee based on role, compliance requirements, or organizational policy.',
    `next_recertification_date` DATE COMMENT 'Date by which the employee must complete recertification or renewal of the course. Null if recertification is not required.',
    `notes` STRING COMMENT 'Additional notes or remarks related to the enrollment, such as special accommodations, exceptions, or administrative comments.',
    `pass_fail_result` STRING COMMENT 'Outcome of the course assessment indicating whether the employee passed or failed. Not applicable for courses without formal assessments.. Valid values are `pass|fail|pending|not-applicable|waived`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the course assessment. Used to determine pass/fail result.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether the employee must retake or renew the course after a specified period to maintain certification or compliance.',
    `scheduled_end_date` DATE COMMENT 'Planned date by which the employee is expected to complete the learning course or training program.',
    `scheduled_start_date` DATE COMMENT 'Planned date when the employee is scheduled to begin the learning course or training program.',
    `training_provider` STRING COMMENT 'Name of the external training provider or vendor that delivered the course. Null for internally-delivered training.',
    `withdrawal_date` DATE COMMENT 'Date when the employee withdrew from the learning course before completion. Null if the employee did not withdraw.',
    `withdrawal_reason` STRING COMMENT 'Reason provided by the employee or manager for withdrawing from the course. Used for analysis of dropout patterns and course effectiveness.',
    CONSTRAINT pk_learning_enrollment PRIMARY KEY(`learning_enrollment_id`)
) COMMENT 'Transactional record of an employees enrollment in and completion of a learning course or training program. Captures employee reference, learning course reference, enrollment date, scheduled start date, scheduled end date, actual completion date, enrollment source (self-enrolled, manager-assigned, HR-mandated, compliance-required), delivery session reference, completion status (enrolled, in-progress, completed, failed, withdrawn, expired), assessment score, pass/fail result, certificate issued flag, certificate expiry date, CPD hours credited, and learning hours logged.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`disciplinary_case` (
    `disciplinary_case_id` BIGINT COMMENT 'Unique identifier for the disciplinary case record. Primary key for the disciplinary case entity.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_order. Business justification: Telecom disciplinary cases (fraud, unauthorized discounts, SLA negligence) often stem from specific order handling violations. Linking case to the order involved provides audit trail for compliance in',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the subject of the disciplinary action or grievance case.',
    `tertiary_disciplinary_hr_business_partner_employee_id` BIGINT COMMENT 'Reference to the HR business partner assigned to oversee and advise on the disciplinary case, ensuring policy compliance and fair process.',
    `escalated_from_disciplinary_case_id` BIGINT COMMENT 'Self-referencing FK on disciplinary_case (escalated_from_disciplinary_case_id)',
    `appeal_date` DATE COMMENT 'The date when the employee formally submitted an appeal against the disciplinary case outcome.',
    `appeal_flag` BOOLEAN COMMENT 'Indicates whether the employee has filed an appeal against the disciplinary case outcome. True if appeal was lodged, false otherwise.',
    `appeal_outcome` STRING COMMENT 'The result of the appeal process. Indicates whether the original decision was upheld, overturned, or modified.. Valid values are `appeal_upheld|appeal_rejected|outcome_modified|pending`',
    `appeal_outcome_date` DATE COMMENT 'The date when the appeal outcome was formally communicated to the employee.',
    `case_closure_date` DATE COMMENT 'The date when the disciplinary case was formally closed, including all appeals and follow-up actions completed.',
    `case_open_date` DATE COMMENT 'The date when the disciplinary case was formally opened and investigation commenced.',
    `case_reference_number` STRING COMMENT 'Externally-known unique business identifier for the disciplinary case, used for tracking and communication purposes.. Valid values are `^DC-[0-9]{6,10}$`',
    `case_severity` STRING COMMENT 'Severity classification of the disciplinary action. Indicates the level of corrective action taken or recommended.. Valid values are `verbal_warning|written_warning|final_written_warning|suspension|dismissal|no_action`',
    `case_status` STRING COMMENT 'Current lifecycle status of the disciplinary case. Tracks the case progression through investigation, hearing, outcome, and closure stages.. Valid values are `open|under_investigation|hearing_scheduled|outcome_issued|appealed|closed`',
    `case_type` STRING COMMENT 'Classification of the disciplinary case type. Defines the nature of the issue being addressed.. Valid values are `misconduct|performance|attendance|policy_violation|harassment|grievance`',
    `confidentiality_level` STRING COMMENT 'The confidentiality classification level for the disciplinary case. Determines access restrictions and handling procedures.. Valid values are `standard|high|executive`',
    `cost_center_code` STRING COMMENT 'The cost center code of the employee at the time the disciplinary case was opened. Used for financial and organizational reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this disciplinary case record was first created in the system. Used for audit trail and data lineage.',
    `department_code` STRING COMMENT 'The department code of the employee at the time the disciplinary case was opened. Used for reporting and trend analysis.',
    `employee_representative_present_flag` BOOLEAN COMMENT 'Indicates whether the employee was accompanied by a representative, union delegate, or legal counsel during the hearing. True if representative was present, false otherwise.',
    `evidence_attachment_count` STRING COMMENT 'The number of supporting documents, files, or evidence attachments associated with the disciplinary case.',
    `hearing_date` DATE COMMENT 'The date when the formal disciplinary hearing was conducted with the employee to review evidence and provide opportunity for response.',
    `hearing_location` STRING COMMENT 'The physical or virtual location where the disciplinary hearing was conducted.',
    `improvement_plan_end_date` DATE COMMENT 'The target completion date for the performance improvement plan or corrective action plan, if one was required.',
    `improvement_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a performance improvement plan or corrective action plan is required as part of the case outcome. True if plan is required, false otherwise.',
    `incident_date` DATE COMMENT 'The date when the incident or behavior that triggered the disciplinary case occurred. Principal business event timestamp for the case.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the incident or behavior that triggered the disciplinary case. Contains facts, circumstances, and context of the event.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this disciplinary case record was last updated in the system. Used for audit trail and change tracking.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether the case required review by legal counsel due to severity, complexity, or potential litigation risk. True if legal review was required, false otherwise.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or observations related to the disciplinary case. Used for context, follow-up actions, or special circumstances.',
    `outcome_date` DATE COMMENT 'The date when the disciplinary case outcome was formally communicated to the employee.',
    `outcome_description` STRING COMMENT 'Detailed explanation of the disciplinary case outcome, including rationale, corrective actions, expectations, and any conditions or follow-up requirements.',
    `outcome_type` STRING COMMENT 'The final decision or outcome of the disciplinary case after investigation and hearing. Defines the corrective action taken or resolution reached. [ENUM-REF-CANDIDATE: warning_issued|suspension_applied|dismissal|no_action|case_dismissed|grievance_upheld|grievance_rejected — 7 candidates stripped; promote to reference product]',
    `policy_reference` STRING COMMENT 'Reference to the specific company policy, code of conduct section, or regulatory requirement that was violated or is relevant to the case.',
    `previous_case_count` STRING COMMENT 'The number of prior disciplinary cases on record for this employee at the time this case was opened. Used to assess pattern of behavior and determine appropriate severity.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the case must be reported to external regulatory bodies or government agencies due to the nature of the violation. True if reporting is required, false otherwise.',
    `suspension_end_date` DATE COMMENT 'The date when employee suspension ended and the employee was eligible to return to work, if suspension was part of the disciplinary action.',
    `suspension_paid_flag` BOOLEAN COMMENT 'Indicates whether the suspension period was paid or unpaid. True if paid suspension, false if unpaid.',
    `suspension_start_date` DATE COMMENT 'The date when employee suspension commenced, if suspension was part of the disciplinary action.',
    `union_notified_flag` BOOLEAN COMMENT 'Indicates whether the employees union or collective bargaining representative was notified of the disciplinary case, as required by labor agreements. True if union was notified, false otherwise.',
    `warning_expiry_date` DATE COMMENT 'The date when the issued warning expires and is removed from the employees active disciplinary record, if applicable.',
    `witness_count` STRING COMMENT 'The number of witnesses interviewed or statements collected as part of the disciplinary case investigation.',
    `work_location_code` STRING COMMENT 'The work location code of the employee at the time the disciplinary case was opened. Used for geographic and site-level analysis.',
    CONSTRAINT pk_disciplinary_case PRIMARY KEY(`disciplinary_case_id`)
) COMMENT 'Transactional record of a formal employee disciplinary action or grievance case managed by HR. Captures case reference number, employee subject reference, case type (misconduct, performance, attendance, policy violation, harassment, grievance, whistleblower), case severity (verbal warning, written warning, final written warning, suspension, dismissal), incident description, incident date, case open date, investigating manager reference, HR business partner reference, case status (open, under investigation, hearing scheduled, outcome issued, appealed, closed), outcome type, outcome date, appeal flag, appeal outcome, and case closure date. Restricted classification.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'Unique identifier for the headcount planning entry. Primary key for the headcount plan record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved or rejected this headcount plan entry. Links to the employee master data.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Headcount planning drives workforce budget by GL account for OpEx/CapEx labor allocation and financial forecasting. Telecommunications requires detailed labor cost planning by account type (salaries, ',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile or job family for which headcount is being planned. Links to job profile master data.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit for which this headcount is planned. Links to the org_unit master data.',
    `primary_headcount_submitted_by_employee_id` BIGINT COMMENT 'Reference to the employee who submitted this headcount plan entry for approval. Links to the employee master data.',
    `revised_headcount_plan_id` BIGINT COMMENT 'Self-referencing FK on headcount_plan (revised_headcount_plan_id)',
    `approval_date` DATE COMMENT 'The date on which this headcount plan entry was formally approved or rejected by the designated approver.',
    `approved_headcount` DECIMAL(18,2) COMMENT 'The number of headcount positions that have been formally approved by management and budget authorities. May differ from planned headcount if approval is partial.',
    `attrition_assumption_percentage` DECIMAL(18,2) COMMENT 'The assumed attrition rate (as a percentage) used in planning calculations for this org unit and job profile. Used to forecast turnover and replacement needs.',
    `budget_approval_status` STRING COMMENT 'The current approval workflow status of this headcount plan entry. Tracks the plan through the budget approval lifecycle from draft to final approval or rejection.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `business_justification` STRING COMMENT 'Detailed business case and justification for the headcount request. Explains the strategic or operational need driving the headcount plan.',
    `cost_center_code` STRING COMMENT 'The cost center to which the headcount costs will be allocated. Used for financial planning and budget tracking. Format: CC followed by 6 digits.. Valid values are `^CC[0-9]{6}$`',
    `country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code for the location where this headcount will be based (e.g., USA, GBR, IND).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this headcount plan record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts in this headcount plan entry (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `current_filled_headcount` DECIMAL(18,2) COMMENT 'The actual number of filled positions as of the plan snapshot date. Represents current state for comparison against planned and approved levels.',
    `current_vacant_headcount` DECIMAL(18,2) COMMENT 'The number of approved but unfilled positions as of the plan snapshot date. Calculated as approved headcount minus current filled headcount.',
    `estimated_annual_cost_per_head` DECIMAL(18,2) COMMENT 'The estimated fully-loaded annual cost per headcount position, including base salary, benefits, taxes, and overhead. Used for budget planning calculations.',
    `functional_area` STRING COMMENT 'The functional area or business domain to which this headcount plan applies (e.g., Network Operations, Customer Service, Finance, Engineering).',
    `geographic_region` STRING COMMENT 'The geographic region or market area for which this headcount is planned. Used for regional workforce planning and allocation.',
    `headcount_type` STRING COMMENT 'The employment type category for this headcount plan entry. Distinguishes between permanent employees, fixed-term contracts, contractors, interns, and temporary workers.. Valid values are `permanent|fixed_term|contractor|intern|temporary`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this headcount plan entry is currently active and in effect. False if the plan has been superseded or withdrawn.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this headcount plan record was most recently updated. Audit trail for record modifications.',
    `net_new_headcount_requested` DECIMAL(18,2) COMMENT 'The incremental headcount increase requested beyond current approved levels. Represents growth or expansion requests for the planning period.',
    `plan_effective_date` DATE COMMENT 'The date from which this headcount plan becomes effective. Marks the start of the planning period for this entry.',
    `plan_expiry_date` DATE COMMENT 'The date on which this headcount plan expires or is superseded. Marks the end of the planning period for this entry.',
    `plan_number` STRING COMMENT 'Business identifier for the headcount plan entry. Format: HCP-YYYY-NNNNNN where YYYY is the planning year and NNNNNN is a sequential number.. Valid values are `^HCP-[0-9]{4}-[0-9]{6}$`',
    `planned_headcount` DECIMAL(18,2) COMMENT 'The total number of headcount positions planned for this org unit, job profile, and period. May include fractional FTE (Full-Time Equivalent) values for part-time positions.',
    `planning_cycle_reference` BIGINT COMMENT 'Reference to the planning cycle during which this headcount plan was created. Links to the planning cycle master data.',
    `planning_notes` STRING COMMENT 'Free-text notes and comments related to this headcount plan entry. May include justification for headcount requests, business rationale, or special considerations.',
    `planning_quarter` STRING COMMENT 'The fiscal quarter within the planning year for which this headcount plan applies. Values: Q1, Q2, Q3, Q4.. Valid values are `Q1|Q2|Q3|Q4`',
    `planning_year` STRING COMMENT 'The fiscal year for which this headcount plan applies. Four-digit year format (e.g., 2024).',
    `priority_level` STRING COMMENT 'The business priority assigned to this headcount plan entry. Used to rank and sequence headcount approvals when budget constraints exist.. Valid values are `critical|high|medium|low`',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver when a headcount plan entry is rejected. Captures the business rationale for denial.',
    `snapshot_date` DATE COMMENT 'The date on which the current filled and vacant headcount figures were captured. Used to timestamp the actual headcount data for comparison against plan.',
    `submitted_timestamp` TIMESTAMP COMMENT 'The date and time when this headcount plan entry was submitted for approval. Tracks the submission event in the approval workflow.',
    `total_estimated_annual_cost` DECIMAL(18,2) COMMENT 'The total estimated annual cost for all planned headcount in this entry. Calculated as planned headcount multiplied by estimated annual cost per head.',
    `version_number` STRING COMMENT 'The version number of this headcount plan entry. Incremented when the plan is revised or updated during the planning cycle.',
    `work_location_code` STRING COMMENT 'The specific work location or site code where the planned headcount will be based. Links to location master data.',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'Transactional record of approved headcount planning entries for a given org unit, job family, and planning period — the SSOT for workforce demand planning in the people domain. Captures planning cycle reference, org unit reference, job profile reference, planning period (year, quarter), headcount type (permanent, fixed-term, contractor), planned headcount count, approved headcount count, current filled headcount, current vacant headcount, attrition assumption percentage, net new headcount requested, budget approval status (draft, submitted, approved, rejected), approver reference, and planning notes. Distinct from workforce.capacity_plan which covers field technician operational scheduling.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` (
    `recruitment_requisition_id` BIGINT COMMENT 'Unique system identifier for the recruitment requisition record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'System user identifier of the person who created this requisition record, typically the hiring manager or HR business partner.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile master record that defines role responsibilities, required competencies, and job family classification.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who most recently updated this requisition record. Used for accountability and audit trail.',
    `location_site_id` BIGINT COMMENT 'Reference to the primary work location (office, site, or facility) where the employee will be based. Links to location master data.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, or team) where the position will be located. Links to org_unit master data.',
    `position_id` BIGINT COMMENT 'Reference to the position master record that defines the job profile, grade, and organizational placement for this requisition.',
    `primary_recruitment_hiring_manager_employee_id` BIGINT COMMENT 'Reference to the employee record of the hiring manager who will supervise the new hire and is responsible for candidate selection decisions.',
    `quaternary_recruitment_replacement_employee_id` BIGINT COMMENT 'Reference to the employee record being replaced, if this is a backfill or replacement requisition. Null for new headcount positions.',
    `tertiary_recruitment_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee record of the manager or executive who provided final approval for this requisition. Null if not yet approved.',
    `reposted_from_recruitment_requisition_id` BIGINT COMMENT 'Self-referencing FK on recruitment_requisition (reposted_from_recruitment_requisition_id)',
    `approval_date` DATE COMMENT 'Date when the requisition received final management approval to proceed with recruitment activities. Null if not yet approved.',
    `budget_approval_reference` STRING COMMENT 'Reference number or identifier for the budget approval document or Capital Expenditure (CAPEX)/Operational Expenditure (OPEX) authorization that funds this position.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the new hire salary and benefits will be charged. Used for budget tracking and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this requisition record was first created in the Human Resources (HR) system. Used for audit trail and process analytics.',
    `diversity_hiring_initiative_flag` BOOLEAN COMMENT 'Indicates whether this requisition is part of a diversity, equity, and inclusion (DEI) hiring initiative. True if special diversity sourcing applies.',
    `employment_type` STRING COMMENT 'Type of employment arrangement being requested: full_time (permanent full-time employee), part_time (permanent part-time), contract (fixed-term contractor), temporary (short-term assignment), intern (student internship), or seasonal (recurring seasonal role).. Valid values are `full_time|part_time|contract|temporary|intern|seasonal`',
    `internal_posting_only_flag` BOOLEAN COMMENT 'Indicates whether the requisition is restricted to internal candidates only. True if external candidates are not eligible, false if open to all applicants.',
    `job_description` STRING COMMENT 'Detailed narrative description of the role responsibilities, required qualifications, and key accountabilities. Used for job postings and candidate communication.',
    `job_title` STRING COMMENT 'Official job title for the position being recruited. Used in job postings and offer letters. May differ slightly from the job profile name for external branding.',
    `justification` STRING COMMENT 'Business justification narrative explaining why this position is needed, including impact on operations, strategic alignment, and expected Return on Investment (ROI).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent update to this requisition record. Used for change tracking and audit compliance.',
    `number_of_openings` STRING COMMENT 'Quantity of positions to be filled under this single requisition. Typically 1, but may be higher for bulk hiring initiatives or multiple identical roles.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to this position, defining the salary range and benefits tier. Used for budget approval and offer preparation.',
    `posting_end_date` DATE COMMENT 'Date when the job posting will be or was removed from recruitment channels. Null if posting remains open indefinitely.',
    `posting_start_date` DATE COMMENT 'Date when the job posting was or will be published to internal and external recruitment channels. Marks the beginning of active candidate sourcing.',
    `priority_level` STRING COMMENT 'Business priority classification for this requisition, indicating urgency and resource allocation: critical (immediate business impact), high (important for operations), medium (standard priority), or low (can be deferred).. Valid values are `critical|high|medium|low`',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Indicates whether the position is eligible for remote or hybrid work arrangements. True if remote work is permitted, false if on-site presence is required.',
    `requisition_close_date` DATE COMMENT 'Date when the requisition was formally closed, either due to successful fill, cancellation, or other resolution. Null if still open.',
    `requisition_notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or context relevant to the recruitment process. Used for internal coordination.',
    `requisition_number` STRING COMMENT 'Human-readable business identifier for the job requisition, typically formatted as REQ-YYYYNNNN where YYYY is year and NNNN is sequence number. Used for external communication and tracking.. Valid values are `^REQ-[0-9]{8}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the requisition: draft (being prepared), pending_approval (awaiting management approval), approved (ready for sourcing), sourcing (actively recruiting), interviewing (candidates in interview process), offer_stage (offer extended), filled (position filled), cancelled (requisition withdrawn), on_hold (temporarily paused), or closed (process completed). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|sourcing|interviewing|offer_stage|filled|cancelled|on_hold|closed — 10 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the requisition purpose: backfill (replacing a departing employee), new_headcount (net new position), replacement (role restructure), internal_transfer (existing employee moving), contractor_conversion (converting contractor to FTE), or reorg (organizational restructuring).. Valid values are `backfill|new_headcount|replacement|internal_transfer|contractor_conversion|reorg`',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary range (e.g., USD, EUR, GBP). Ensures consistent financial reporting across global operations.. Valid values are `^[A-Z]{3}$`',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'Maximum annual base salary for the position in the specified currency. Defines the upper bound for offer negotiations.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'Minimum annual base salary for the position in the specified currency. Used for budget planning and candidate expectation management.',
    `security_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether the position requires government or corporate security clearance. True if clearance is mandatory, false otherwise.',
    `sourcing_channels` STRING COMMENT 'Comma-separated list of recruitment channels activated for this requisition (e.g., internal_job_board, linkedin, agency, campus, employee_referral, job_fair, social_media). Tracks where candidates are being sourced from.',
    `target_start_date` DATE COMMENT 'Desired date for the new hire to begin employment. Used for workforce planning and recruitment timeline management.',
    `time_to_fill_target_days` STRING COMMENT 'Target number of calendar days from requisition approval to offer acceptance. Used as a Key Performance Indicator (KPI) for recruitment efficiency and workforce planning.',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of work time requiring business travel (0-100). Used to set candidate expectations and assess role suitability.',
    CONSTRAINT pk_recruitment_requisition PRIMARY KEY(`recruitment_requisition_id`)
) COMMENT 'Master record for an approved job requisition opened to fill a vacant or new position within the telecommunications enterprise. Captures requisition number, position reference, org unit reference, job profile reference, hiring manager reference, HR recruiter reference, requisition type (backfill, new headcount, replacement, internal transfer), employment type requested, target start date, number of openings, requisition status (draft, pending approval, approved, sourcing, interviewing, offer stage, filled, cancelled, on-hold), approval date, sourcing channels activated (internal job board, LinkedIn, agency, campus), time-to-fill target days, and requisition close date.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`applicant` (
    `applicant_id` BIGINT COMMENT 'Unique identifier for the job applicant record. Primary key for the applicant entity.',
    `employee_id` BIGINT COMMENT 'Reference to the hiring manager (the manager of the position being filled) who has decision authority for this applicant.',
    `applicant_interviewer_employee_id` BIGINT COMMENT 'Reference to the employee who conducted the primary interview or served as the lead interviewer for this applicant.',
    `applicant_recruiter_employee_id` BIGINT COMMENT 'Reference to the internal recruiter or HR business partner responsible for managing this applicants recruitment process.',
    `applicant_referral_employee_id` BIGINT COMMENT 'Reference to the employee who referred this applicant, if the source channel is employee referral. Used for referral bonus tracking.',
    `position_id` BIGINT COMMENT 'Reference to the specific position record in the position master data that this application is for.',
    `referral_applicant_id` BIGINT COMMENT 'Self-referencing FK on applicant (referral_applicant_id)',
    `applicant_type` STRING COMMENT 'Classification of the applicant based on their relationship to the organization: internal employee applying for a different role, external candidate, contractor seeking conversion, former employee seeking rehire, employee referral, or campus recruit.. Valid values are `internal|external|contractor_conversion|rehire|referral|campus`',
    `application_date` DATE COMMENT 'The date on which the applicant submitted their application for the position.',
    `application_number` STRING COMMENT 'Business-facing unique application reference number assigned when the candidate submits their application. Format: APP-YYYYMMDD-sequence.. Valid values are `^APP-[0-9]{8}$`',
    `application_status` STRING COMMENT 'Current status of the application in the recruitment workflow: applied (initial submission), screening (under review), phone screen (scheduled or completed), interview (in-person or virtual), assessment (skills or psychometric testing), offer (offer extended), hired (offer accepted and onboarded), rejected (application declined), or withdrawn (applicant withdrew). [ENUM-REF-CANDIDATE: applied|screening|phone_screen|interview|assessment|offer|hired|rejected|withdrawn — 9 candidates stripped; promote to reference product]',
    `background_check_date` DATE COMMENT 'The date on which the background check process was completed.',
    `background_check_status` STRING COMMENT 'Current status of the background verification process for the applicant: not started, in progress, completed, cleared (passed all checks), or flagged (issues identified requiring review).. Valid values are `not_started|in_progress|completed|cleared|flagged`',
    `consent_date` DATE COMMENT 'The date on which the applicant provided their GDPR/privacy consent for data processing.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the applicants country of residence or primary location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this applicant record was first created in the system, typically at the moment of application submission.',
    `current_employer` STRING COMMENT 'Name of the organization where the applicant is currently employed. Null if the applicant is unemployed or an internal candidate.',
    `current_job_title` STRING COMMENT 'The job title or role the applicant currently holds at their present employer.',
    `data_retention_expiry_date` DATE COMMENT 'The date on which the applicants personal data must be purged or anonymized in accordance with GDPR data retention policies and local employment law. Typically calculated based on application date plus retention period.',
    `email_address` STRING COMMENT 'Primary email address of the applicant used for all recruitment communication and correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expected_start_date` DATE COMMENT 'The anticipated date on which the applicant is expected to commence employment if the offer is accepted.',
    `first_name` STRING COMMENT 'Legal first name of the applicant as provided in the application.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Boolean indicator of whether the applicant has provided explicit consent for the organization to process their personal data in accordance with GDPR and privacy regulations.',
    `highest_education_level` STRING COMMENT 'The highest level of formal education attained by the applicant: high school diploma, associate degree, bachelor degree, master degree, doctorate, professional certification, or other. [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctorate|professional_certification|other — 7 candidates stripped; promote to reference product]',
    `interview_date` DATE COMMENT 'The date on which the applicants primary or most recent interview was conducted.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this applicant record was most recently updated, reflecting any status changes, data corrections, or workflow progression.',
    `last_name` STRING COMMENT 'Legal last name (surname/family name) of the applicant as provided in the application.',
    `linkedin_profile_url` STRING COMMENT 'The URL to the applicants LinkedIn professional profile, if provided.',
    `middle_name` STRING COMMENT 'Middle name or initial of the applicant if provided.',
    `notes` STRING COMMENT 'Free-text field for recruiters and hiring managers to record additional observations, interview feedback, or relevant information about the applicant that does not fit structured fields.',
    `offer_amount` DECIMAL(18,2) COMMENT 'The total annual compensation amount offered to the applicant, including base salary and guaranteed allowances.',
    `offer_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the offer amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `offer_date` DATE COMMENT 'The date on which a formal job offer was extended to the applicant.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the applicant, including country code where applicable.',
    `position_applied_for` STRING COMMENT 'The job title or position name that the applicant is applying for within the telecommunications enterprise.',
    `preferred_work_location` STRING COMMENT 'The geographic location or office site the applicant prefers to work from, if applicable. May reference a city, office name, or remote work preference.',
    `rejection_reason` STRING COMMENT 'Free-text explanation or standardized reason code for why the application was rejected, if applicable. Used for internal tracking and process improvement.',
    `resume_document_reference` STRING COMMENT 'File path, URI, or document management system reference to the applicants resume or curriculum vitae (CV) document.',
    `screening_score` DECIMAL(18,2) COMMENT 'Numeric score assigned during the initial screening phase based on resume review, qualifications match, and initial assessment criteria. Scale typically 0-100.',
    `security_clearance_level` STRING COMMENT 'The level of security clearance the applicant currently holds or has held, if applicable to the position (e.g., confidential, secret, top secret). Relevant for positions requiring access to sensitive telecommunications infrastructure or government contracts.',
    `source_channel` STRING COMMENT 'The channel or source through which the applicant discovered and applied for the position: employee referral, LinkedIn, external job board, recruitment agency, campus recruitment, direct application to career site, social media, walk-in, or internal job posting. [ENUM-REF-CANDIDATE: employee_referral|linkedin|job_board|agency|campus|direct_application|career_site|social_media|walk_in|internal_posting — 10 candidates stripped; promote to reference product]',
    `withdrawal_reason` STRING COMMENT 'Free-text explanation or standardized reason code for why the applicant withdrew their application, if applicable.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total number of years of relevant professional work experience the applicant has accumulated in their career, as declared in the application.',
    CONSTRAINT pk_applicant PRIMARY KEY(`applicant_id`)
) COMMENT 'Master record for every job applicant who has applied for a position at the telecommunications enterprise — internal and external candidates. Captures applicant name, applicant type (internal employee, external candidate), source channel (employee referral, LinkedIn, job board, agency, campus, direct application), application date, current employer, current job title, highest education level, years of experience, resume/CV reference, LinkedIn profile URL, applicant status (applied, screening, phone screen, interview, assessment, offer, hired, rejected, withdrawn), GDPR/privacy consent flag, consent date, and data retention expiry date.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`interview_event` (
    `interview_event_id` BIGINT COMMENT 'Unique identifier for the interview event record. Primary key for the interview event entity.',
    `applicant_id` BIGINT COMMENT 'Reference to the candidate being interviewed. Links the interview event to the applicant record.',
    `employee_id` BIGINT COMMENT 'Reference to the lead interviewer conducting the interview. This is the main point of contact and decision maker for the interview.',
    `quaternary_interview_coordinator_employee_id` BIGINT COMMENT 'Reference to the HR or recruitment coordinator responsible for scheduling and logistics of this interview.',
    `recruitment_requisition_id` BIGINT COMMENT 'Reference to the job requisition for which this interview is being conducted. Links the interview to the open position being filled.',
    `rescheduled_from_interview_event_id` BIGINT COMMENT 'Reference to the original interview event that was rescheduled, creating this new interview event record.',
    `tertiary_interviewer_3_employee_id` BIGINT COMMENT 'Reference to the third interviewer participating in the interview session, if applicable.',
    `tertiary_quinary_interviewer_5_employee_id` BIGINT COMMENT 'Reference to the fifth interviewer participating in the interview session, if applicable.',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the interview concluded. Used to track actual interview duration.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the interview began. May differ from scheduled start time.',
    `average_interviewer_score` DECIMAL(18,2) COMMENT 'Calculated average of all interviewer scores for this interview event. Provides a consolidated quantitative assessment.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the interview was cancelled, if applicable. Includes both candidate-initiated and company-initiated cancellations.',
    `communication_skills_rating` STRING COMMENT 'Assessment of the candidates verbal and written communication abilities, presentation skills, and clarity of expression.. Valid values are `excellent|good|satisfactory|needs_improvement|poor`',
    `concerns_summary` STRING COMMENT 'Summary of any concerns, weaknesses, or red flags identified during the interview that may impact hiring decision.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interview event record was first created in the system. Used for audit trail and data lineage.',
    `cultural_fit_rating` STRING COMMENT 'Assessment of how well the candidates values, work style, and personality align with the organizations culture and team dynamics.. Valid values are `excellent|good|satisfactory|needs_improvement|poor`',
    `duration_minutes` STRING COMMENT 'Planned duration of the interview in minutes. Used for scheduling and resource allocation.',
    `feedback_submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the interview feedback and scores were submitted by the interview panel. Tracks timeliness of feedback completion.',
    `interview_location` STRING COMMENT 'Physical location or address where the interview is conducted for on-site or off-site interviews. May include building name, floor, and room number.',
    `interview_location_type` STRING COMMENT 'Classification of where the interview takes place. Determines logistics and technology requirements.. Valid values are `on_site|video_conference|phone|off_site`',
    `interview_reference_number` STRING COMMENT 'Business-facing unique reference number for the interview event, used for tracking and communication purposes.',
    `interview_round_number` STRING COMMENT 'Sequential number indicating which round of interviews this represents in the recruitment process (e.g., 1 for first round, 2 for second round).',
    `interview_status` STRING COMMENT 'Current lifecycle status of the interview event. Tracks the interview from scheduling through completion or cancellation. [ENUM-REF-CANDIDATE: scheduled|confirmed|in_progress|completed|cancelled|no_show|rescheduled — 7 candidates stripped; promote to reference product]',
    `interview_type` STRING COMMENT 'Classification of the interview format and purpose. Determines the structure and focus of the interview session. [ENUM-REF-CANDIDATE: phone_screen|video_interview|panel_interview|technical_assessment|case_study|hr_interview|executive_interview — 7 candidates stripped; promote to reference product]',
    `interviewer_2_score` DECIMAL(18,2) COMMENT 'Numerical score assigned by the second interviewer, if applicable.',
    `interviewer_3_score` DECIMAL(18,2) COMMENT 'Numerical score assigned by the third interviewer, if applicable.',
    `interviewer_4_score` DECIMAL(18,2) COMMENT 'Numerical score assigned by the fourth interviewer, if applicable.',
    `interviewer_5_score` DECIMAL(18,2) COMMENT 'Numerical score assigned by the fifth interviewer, if applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interview event record was most recently updated. Used for audit trail and change tracking.',
    `next_step_action` STRING COMMENT 'Description of the next action to be taken following this interview (e.g., schedule next round, extend offer, send rejection, request additional assessment).',
    `no_show_party` STRING COMMENT 'Indicates which party failed to attend the scheduled interview, if applicable.. Valid values are `candidate|interviewer|both|none`',
    `outcome_decision_date` DATE COMMENT 'Date when the final decision on the interview outcome was made and recorded. May differ from the interview date.',
    `overall_recommendation` STRING COMMENT 'Consolidated recommendation from the interview panel on whether to advance the candidate to the next stage. Primary decision outcome of the interview.. Valid values are `proceed|strong_proceed|hold|reject|strong_reject`',
    `primary_interviewer_score` DECIMAL(18,2) COMMENT 'Numerical score assigned by the primary interviewer, typically on a standardized scale. Used for quantitative candidate comparison.',
    `scheduled_date` DATE COMMENT 'The date on which the interview is scheduled to take place.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time when the interview is scheduled to end, including time zone information.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the interview is scheduled to begin, including time zone information.',
    `strengths_summary` STRING COMMENT 'Summary of the candidates key strengths and positive attributes identified during the interview.',
    `structured_feedback_notes` STRING COMMENT 'Detailed qualitative feedback and observations from the interview panel. Contains specific examples, strengths, weaknesses, and areas of concern.',
    `technical_competency_rating` STRING COMMENT 'Assessment of the candidates technical skills and domain expertise relevant to the position requirements.. Valid values are `excellent|good|satisfactory|needs_improvement|poor`',
    `video_meeting_link` STRING COMMENT 'URL or meeting link for the video conference session. Contains access credentials for the virtual interview room.',
    `video_platform` STRING COMMENT 'Name of the video conferencing platform used for remote interviews (e.g., Zoom, Microsoft Teams, Webex).',
    CONSTRAINT pk_interview_event PRIMARY KEY(`interview_event_id`)
) COMMENT 'Transactional record of each interview conducted as part of a recruitment process for a specific applicant and requisition. Captures requisition reference, applicant reference, interview round number, interview type (phone screen, video interview, panel interview, technical assessment, case study, HR interview, executive interview), scheduled date and time, interview duration minutes, interviewer employee references (up to 5), interview location or video platform, interview status (scheduled, completed, cancelled, no-show), overall interviewer recommendation (proceed, hold, reject), individual interviewer scores, structured feedback notes, and interview outcome date.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`offer_letter` (
    `offer_letter_id` BIGINT COMMENT 'Unique identifier for the employment offer letter record. Primary key for the offer_letter product.',
    `applicant_id` BIGINT COMMENT 'Reference to the candidate applicant who is receiving this employment offer. Links to the candidate master record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit where the candidate will be placed upon acceptance. Defines the department, division, or business unit assignment.',
    `position_id` BIGINT COMMENT 'Reference to the position being offered to the candidate. Links to the position master record defining the role, grade, and organizational placement.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who will be the direct manager of the candidate upon hire. Used for approval workflow and organizational placement.',
    `recruitment_requisition_id` BIGINT COMMENT 'Reference to the recruitment requisition for which this offer is being extended. Links the offer to the approved hiring request.',
    `tertiary_offer_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who provided final approval for this offer letter (typically HR director or senior management). Required for governance and audit compliance.',
    `superseded_offer_letter_id` BIGINT COMMENT 'Self-referencing FK on offer_letter (superseded_offer_letter_id)',
    `acceptance_date` DATE COMMENT 'The date on which the candidate formally accepted the employment offer. Nullable if the offer has not been accepted.',
    `annual_leave_days` STRING COMMENT 'Number of annual paid leave days offered to the candidate per year, subject to company policy and local labor regulations.',
    `approval_date` DATE COMMENT 'The date on which the offer letter received final approval and was authorized for extension to the candidate.',
    `background_check_cleared_flag` BOOLEAN COMMENT 'Indicates whether the candidate has successfully cleared the required background check. Nullable until background check is completed.',
    `background_check_completion_date` DATE COMMENT 'The date on which the background check process was completed. Nullable if background check is not required or not yet completed.',
    `background_check_required_flag` BOOLEAN COMMENT 'Indicates whether a background check is required as a condition of employment for this offer. Typically true for positions requiring security clearance or regulatory compliance.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The base salary amount being offered to the candidate, excluding bonuses, allowances, and other variable compensation components.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the employees compensation and benefits costs will be allocated. Used for budgeting and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this offer letter record was first created in the system. Used for audit trail and data lineage tracking.',
    `decline_date` DATE COMMENT 'The date on which the candidate formally declined the employment offer. Nullable if the offer has not been declined.',
    `decline_reason` STRING COMMENT 'Free-text explanation provided by the candidate or recruiter for why the employment offer was declined. Used for talent acquisition analytics and process improvement.',
    `document_reference` STRING COMMENT 'Reference identifier or URI to the formal offer letter document stored in the document management system. Used for audit trail and legal compliance.',
    `employment_type` STRING COMMENT 'The type of employment relationship being offered, defining the nature of the working arrangement and associated benefits eligibility.. Valid values are `full_time|part_time|contract|temporary|intern`',
    `equity_grant_eligible_flag` BOOLEAN COMMENT 'Indicates whether the offered position is eligible for equity grants (stock options, restricted stock units) as part of the compensation package.',
    `job_grade` STRING COMMENT 'The job grade or level being offered, which determines compensation band, benefits tier, and career progression path within the organization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this offer letter record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or internal comments related to the offer letter. Used for context and decision documentation.',
    `notice_period_days` STRING COMMENT 'Number of days of advance notice required for resignation or termination after the probation period. Defined by employment contract and local labor law.',
    `offer_date` DATE COMMENT 'The date on which the formal employment offer was extended to the candidate. Represents the principal business event timestamp for this transaction.',
    `offer_expiry_date` DATE COMMENT 'The date by which the candidate must accept or decline the offer. After this date, the offer is automatically expired and no longer valid.',
    `offer_number` STRING COMMENT 'Externally visible unique business identifier for the offer letter, typically formatted as OFR-YYYYNNNN for tracking and reference purposes.. Valid values are `^OFR-[0-9]{8}$`',
    `offer_status` STRING COMMENT 'Current lifecycle status of the employment offer. Tracks the offer through its workflow from draft preparation to final disposition.. Valid values are `draft|extended|accepted|declined|rescinded|expired`',
    `pay_frequency` STRING COMMENT 'The frequency at which the base salary will be paid to the employee (e.g., monthly, bi-weekly).. Valid values are `monthly|bi_weekly|weekly|annual`',
    `probation_period_days` STRING COMMENT 'Number of days for the probationary period during which employment may be terminated with reduced notice. Typically 90 or 180 days depending on role and jurisdiction.',
    `proposed_start_date` DATE COMMENT 'The proposed date on which the candidate is expected to commence employment if the offer is accepted. Subject to negotiation and background check clearance.',
    `relocation_allowance_amount` DECIMAL(18,2) COMMENT 'Relocation assistance amount offered to the candidate to cover moving expenses if the position requires geographic relocation. Nullable if not applicable.',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Indicates whether the offered position is eligible for remote or hybrid work arrangements as part of the employment terms.',
    `rescind_date` DATE COMMENT 'The date on which the employer rescinded or withdrew the employment offer. Nullable if the offer has not been rescinded.',
    `rescind_reason` STRING COMMENT 'Explanation for why the employer rescinded the employment offer (e.g., failed background check, budget freeze, position eliminated).',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the offered base salary amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `sign_on_bonus_amount` DECIMAL(18,2) COMMENT 'One-time sign-on bonus amount offered to the candidate as an incentive to accept the employment offer. Nullable if no sign-on bonus is included.',
    `target_bonus_percentage` DECIMAL(18,2) COMMENT 'The target annual performance bonus expressed as a percentage of base salary. Represents the expected bonus at target performance level.',
    `work_location_code` STRING COMMENT 'Code identifying the primary work location or office where the candidate will be based. Links to the location master for address and facility details.',
    CONSTRAINT pk_offer_letter PRIMARY KEY(`offer_letter_id`)
) COMMENT 'Transactional record of a formal employment offer extended to a selected candidate for a recruitment requisition. Captures requisition reference, applicant reference, offer date, proposed position reference, proposed org unit reference, proposed start date, proposed employment type, proposed job grade, offered base salary, offered currency, offered pay frequency, sign-on bonus amount, relocation allowance, offer expiry date, offer status (draft, extended, accepted, declined, rescinded, expired), acceptance date, decline reason, background check clearance flag, background check completion date, and offer letter document reference.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`onboarding_task` (
    `onboarding_task_id` BIGINT COMMENT 'Unique identifier for the onboarding task record. Primary key for the onboarding task entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or automated process that last modified this onboarding task record.',
    `onboarding_program_id` BIGINT COMMENT 'Reference to the parent onboarding program or journey that this task belongs to.',
    `primary_onboarding_employee_id` BIGINT COMMENT 'Reference to the employee (new hire or rehire) to whom this onboarding task is assigned.',
    `quaternary_onboarding_escalated_to_employee_id` BIGINT COMMENT 'Reference to the employee (manager or senior leader) to whom this onboarding task has been escalated for resolution.',
    `quinary_onboarding_created_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user or automated process that created this onboarding task record.',
    `tertiary_onboarding_waived_by_employee_id` BIGINT COMMENT 'Reference to the employee (typically HR manager or department head) who authorized the waiver of this onboarding task.',
    `prerequisite_onboarding_task_id` BIGINT COMMENT 'Self-referencing FK on onboarding_task (prerequisite_onboarding_task_id)',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Actual time in hours spent completing this onboarding task, calculated from start to completion timestamps.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Date and time when work on this onboarding task actually began, marking the transition from not_started to in_progress status.',
    `blocked_reason` STRING COMMENT 'Explanation for why this onboarding task is currently blocked and cannot proceed, applicable when task_status is blocked.',
    `completion_evidence_reference` STRING COMMENT 'Reference identifier or URI to documentation, system record, or artifact that serves as proof of task completion (e.g., training certificate ID, equipment serial number, signed acknowledgment document ID).',
    `completion_notes` STRING COMMENT 'Free-text notes or comments recorded by the task owner upon completion, capturing any relevant details, exceptions, or observations.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when this onboarding task was marked as completed, representing the principal business event for this transaction.',
    `compliance_framework` STRING COMMENT 'Name of the regulatory framework, standard, or legal requirement that mandates this onboarding task (e.g., FCC CPNI Training, GDPR Data Protection, OSHA Safety).',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which any expenses related to this onboarding task should be allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this onboarding task record was first created in the system.',
    `department_code` STRING COMMENT 'Code identifying the department or organizational unit for which this onboarding task is relevant or customized.',
    `due_date` DATE COMMENT 'Target date by which this onboarding task must be completed to maintain compliance and operational readiness.',
    `escalation_level` STRING COMMENT 'Current escalation tier for this onboarding task if it is overdue or blocked (0 = no escalation, 1 = first level, 2 = second level, etc.).',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Expected time in hours required to complete this onboarding task, used for planning and resource allocation.',
    `is_compliance_required` BOOLEAN COMMENT 'Indicates whether this onboarding task is required for regulatory compliance, legal obligations, or industry standards (e.g., safety training, data privacy acknowledgment).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this onboarding task is mandatory for all new hires or optional based on role, location, or other criteria.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this onboarding task record was most recently updated.',
    `last_reminder_timestamp` TIMESTAMP COMMENT 'Date and time when the most recent reminder notification was sent for this onboarding task.',
    `priority_level` STRING COMMENT 'Business priority assigned to this onboarding task, determining the urgency and sequence of completion.. Valid values are `critical|high|medium|low`',
    `reminder_sent_count` STRING COMMENT 'Number of automated reminder notifications sent to the assigned employee regarding this pending onboarding task.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work on this onboarding task should begin, based on program timeline and dependencies.',
    `sequence_number` STRING COMMENT 'Ordering position of this task within the onboarding program, indicating the recommended or required completion order.',
    `system_reference_code` STRING COMMENT 'External system identifier or ticket number in the source system where this task is tracked (e.g., ServiceNow task ID, SAP SuccessFactors workflow ID).',
    `task_category` STRING COMMENT 'Classification of the onboarding task by functional area. [ENUM-REF-CANDIDATE: it_setup|access_provisioning|equipment_issuance|policy_acknowledgment|compliance_training|benefits_enrollment|payroll_setup|buddy_assignment|orientation_session|department_induction — promote to reference product]. Valid values are `it_setup|access_provisioning|equipment_issuance|policy_acknowledgment|compliance_training|benefits_enrollment`',
    `task_description` STRING COMMENT 'Detailed description of the onboarding task, including instructions, requirements, and expected outcomes.',
    `task_name` STRING COMMENT 'Short descriptive name of the onboarding task (e.g., Create Active Directory Account, Issue Laptop, Complete Safety Training).',
    `task_number` STRING COMMENT 'Human-readable business identifier for the onboarding task, often used for tracking and reference purposes.',
    `task_owner_type` STRING COMMENT 'The functional area or role responsible for completing or facilitating this onboarding task.. Valid values are `hr|it|manager|employee_self_service|facilities|security`',
    `task_status` STRING COMMENT 'Current lifecycle status of the onboarding task indicating its progress and completion state.. Valid values are `not_started|in_progress|completed|overdue|waived|blocked`',
    `waiver_reason` STRING COMMENT 'Explanation for why this onboarding task was waived or skipped, applicable when task_status is waived.',
    `waiver_timestamp` TIMESTAMP COMMENT 'Date and time when the task waiver was approved and recorded.',
    `work_location_code` STRING COMMENT 'Code identifying the physical work location or site where this onboarding task is performed or relevant.',
    CONSTRAINT pk_onboarding_task PRIMARY KEY(`onboarding_task_id`)
) COMMENT 'Transactional record tracking the completion of individual onboarding tasks assigned to a new hire or rehire during their onboarding program. Captures employee reference, task category (IT setup, access provisioning, equipment issuance, policy acknowledgment, compliance training, benefits enrollment, payroll setup, buddy assignment, orientation session, department induction), task name, task description, task owner type (HR, IT, manager, employee self-service), assigned to employee reference, due date, completion date, completion status (not started, in progress, completed, overdue, waived), completion evidence reference, and onboarding program reference.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`separation_event` (
    `separation_event_id` BIGINT COMMENT 'Unique identifier for the employee separation event record. Primary key for the separation event entity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager who initiated the separation process.',
    `tertiary_separation_approved_by_employee_id` BIGINT COMMENT 'Reference to the manager or HR leader who approved the separation.',
    `rehire_of_separation_event_id` BIGINT COMMENT 'Self-referencing FK on separation_event (rehire_of_separation_event_id)',
    `access_revocation_date` DATE COMMENT 'The date on which all system access, credentials, and physical access rights were revoked for the separating employee.',
    `comments` STRING COMMENT 'Additional notes, comments, or context regarding the separation event, used for documentation and future reference.',
    `cost_center_code` STRING COMMENT 'Cost center code associated with the separating employees position, used for financial impact analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the separation event record was first created in the system.',
    `department_code` STRING COMMENT 'Code identifying the department from which the employee is separating, used for turnover analytics by organizational unit.',
    `equipment_return_date` DATE COMMENT 'The date on which all company equipment and assets were returned by the employee.',
    `equipment_return_status` STRING COMMENT 'Status of the return of company-issued equipment and assets by the separating employee.. Valid values are `not_applicable|pending|partial|complete|overdue`',
    `exit_interview_conducted_flag` BOOLEAN COMMENT 'Indicates whether an exit interview was conducted with the departing employee.',
    `exit_interview_date` DATE COMMENT 'The date on which the exit interview was conducted with the separating employee.',
    `exit_interview_key_themes` STRING COMMENT 'Summary of the primary themes and feedback points raised during the exit interview, used for organizational improvement.',
    `exit_interview_sentiment` STRING COMMENT 'Overall sentiment classification derived from the exit interview feedback, used for retention analytics.. Valid values are `positive|neutral|negative|not_applicable`',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'Total monetary amount paid to the employee as part of the final settlement, including unused leave, severance, and other entitlements.',
    `final_settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the final settlement amount.. Valid values are `^[A-Z]{3}$`',
    `final_settlement_payment_date` DATE COMMENT 'The date on which the final settlement payment was processed and paid to the employee.',
    `job_title` STRING COMMENT 'The job title held by the employee at the time of separation, captured for turnover analysis by role.',
    `knowledge_transfer_completed_flag` BOOLEAN COMMENT 'Indicates whether the employee completed required knowledge transfer activities before separation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the separation event record was last updated or modified.',
    `last_working_day` DATE COMMENT 'The final date the employee is expected to perform work duties before separation becomes effective.',
    `notice_period_days` STRING COMMENT 'The number of days of notice required or provided according to employment contract or policy.',
    `notice_period_served_days` STRING COMMENT 'The actual number of days the employee worked during the notice period before separation.',
    `notice_period_waived_flag` BOOLEAN COMMENT 'Indicates whether the organization waived the requirement for the employee to serve the full notice period.',
    `notice_waiver_reason` STRING COMMENT 'Explanation for why the notice period was waived, if applicable.',
    `offboarding_checklist_completed_flag` BOOLEAN COMMENT 'Indicates whether all required offboarding tasks and checklist items have been completed.',
    `offboarding_completion_date` DATE COMMENT 'The date on which all offboarding activities were completed and the separation case was closed.',
    `regrettable_loss_flag` BOOLEAN COMMENT 'Indicates whether the organization considers this separation a regrettable loss of talent, used for retention strategy analysis.',
    `rehire_eligibility_reason` STRING COMMENT 'Explanation for the rehire eligibility determination, particularly important when employee is marked as not eligible for rehire.',
    `rehire_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire by the organization in the future.',
    `resignation_letter_received_date` DATE COMMENT 'The date on which the employees resignation letter or notice was officially received by the organization, applicable for voluntary separations.',
    `separation_effective_date` DATE COMMENT 'The official date when the employment relationship is terminated and the employee is no longer on the organizations payroll.',
    `separation_initiation_date` DATE COMMENT 'The date when the separation process was formally initiated, either by employee resignation submission or management termination decision.',
    `separation_number` STRING COMMENT 'Business-facing unique reference number for the separation event, used for tracking and communication purposes.. Valid values are `^SEP-[0-9]{8}$`',
    `separation_reason_code` STRING COMMENT 'Standardized code representing the specific reason for separation, aligned with HR policy and regulatory reporting requirements. [ENUM-REF-CANDIDATE: voluntary_resignation|involuntary_performance|involuntary_misconduct|mutual_agreement|position_elimination|retirement_age|retirement_early|contract_expiration|relocation|health_reasons|career_change|better_opportunity|family_reasons|return_to_education|death|abandonment|other — promote to reference product]',
    `separation_status` STRING COMMENT 'Current workflow status of the separation event, tracking progress through the offboarding process.. Valid values are `initiated|pending_approval|approved|in_progress|completed|cancelled`',
    `separation_type` STRING COMMENT 'Classification of the separation event indicating the nature of the employees departure from the organization.. Valid values are `resignation|termination|retirement|redundancy|end_of_contract|death_in_service`',
    `severance_amount` DECIMAL(18,2) COMMENT 'Monetary amount paid as severance compensation, separate from other final settlement components.',
    `tenure_years` DECIMAL(18,2) COMMENT 'Total years of service with the organization at the time of separation, used for retention and turnover analytics.',
    `unused_leave_days` DECIMAL(18,2) COMMENT 'Number of accrued leave days that were unused at the time of separation and included in final settlement.',
    `unused_leave_payout_amount` DECIMAL(18,2) COMMENT 'Monetary value of accrued but unused leave entitlements paid out at separation.',
    `voluntary_flag` BOOLEAN COMMENT 'Indicates whether the separation was initiated by the employee (voluntary) or by the organization (involuntary).',
    `work_location_code` STRING COMMENT 'Code identifying the primary work location of the employee at the time of separation.',
    CONSTRAINT pk_separation_event PRIMARY KEY(`separation_event_id`)
) COMMENT 'Transactional record capturing the full lifecycle of an employees separation from the telecommunications enterprise — voluntary resignation, involuntary termination, retirement, redundancy, or end of contract. Captures employee reference, separation type (resignation, termination, retirement, redundancy, end-of-contract, death-in-service, abandonment), separation reason code, last working day, notice period served days, notice period waived flag, exit interview conducted flag, exit interview sentiment (positive, neutral, negative), exit interview key themes, final settlement amount, final settlement payment date, equipment return status, access revocation date, rehire eligibility flag, and separation processed by HR reference.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`workforce_policy` (
    `workforce_policy_id` BIGINT COMMENT 'Unique identifier for the workforce policy record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Identifier of the legal entity to which this policy applies. Null indicates policy applies to all entities.',
    `employee_id` BIGINT COMMENT 'User identifier of the individual who created this policy record in the system.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the individual who last modified this policy record in the system.',
    `owner_employee_id` BIGINT COMMENT 'Employee identifier of the individual designated as the policy owner and primary point of contact for policy interpretation.',
    `primary_workforce_approved_by_employee_id` BIGINT COMMENT 'Employee identifier of the individual who formally approved this policy version for publication and enforcement.',
    `superseded_policy_workforce_policy_id` BIGINT COMMENT 'Identifier of the previous policy version that this policy replaces, enabling policy version lineage tracking.',
    `superseded_workforce_policy_id` BIGINT COMMENT 'Self-referencing FK on workforce_policy (superseded_workforce_policy_id)',
    `acknowledgment_frequency` STRING COMMENT 'Frequency at which employees must re-acknowledge the policy to maintain compliance and awareness.. Valid values are `once|annual|on_change|quarterly|biannual`',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the policy is currently active and enforceable. Inactive policies are retained for historical reference only.',
    `applicable_business_unit` STRING COMMENT 'Business unit or division to which this policy applies. Null indicates policy applies enterprise-wide.',
    `applicable_employee_type` STRING COMMENT 'Employment category to which this policy applies, enabling targeted policy enforcement by workforce segment.. Valid values are `all|full_time|part_time|contractor|temporary|intern`',
    `applicable_geography` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the geographic jurisdiction where this policy applies. Null indicates global applicability.. Valid values are `^[A-Z]{3}$`',
    `approval_authority` STRING COMMENT 'Title or role of the authority who approved this policy (e.g., Chief Human Resources Officer (CHRO), Board of Directors, Chief Executive Officer (CEO)).',
    `approval_date` DATE COMMENT 'Date when the policy was formally approved by the designated approval authority.',
    `communication_method` STRING COMMENT 'Primary method used to communicate this policy to employees, ensuring awareness and accessibility.. Valid values are `email|intranet|town_hall|manager_cascade|training_session|all_hands`',
    `compliance_framework` STRING COMMENT 'Name of the compliance framework or standard this policy supports (e.g., Sarbanes-Oxley Act (SOX), ISO 27001, Health Insurance Portability and Accountability Act (HIPAA)).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy record was first created in the system, supporting audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date when the policy becomes enforceable and binding on employees and the organization.',
    `exception_process_description` STRING COMMENT 'Description of the process for requesting and approving exceptions to this policy when special circumstances warrant deviation.',
    `expiry_date` DATE COMMENT 'Date when the policy ceases to be effective. Null for policies with indefinite duration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy record was last updated, enabling change tracking and audit compliance.',
    `last_review_date` DATE COMMENT 'Date when the policy was last reviewed for accuracy, relevance, and compliance with current regulations.',
    `mandatory_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether employees are required to formally acknowledge receipt and understanding of this policy.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory policy review to ensure ongoing relevance and regulatory compliance.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the policy for internal reference and policy administration.',
    `policy_category` STRING COMMENT 'Classification of the policy type. [ENUM-REF-CANDIDATE: leave_policy|code_of_conduct|anti_harassment|data_privacy|byod|remote_work|expense_reimbursement|travel|health_and_safety|equal_opportunity|whistleblower|security|conflict_of_interest|social_media|substance_abuse — promote to reference product]. Valid values are `leave_policy|code_of_conduct|anti_harassment|data_privacy|byod|remote_work`',
    `policy_code` STRING COMMENT 'Unique business identifier code for the policy, used for external reference and system integration.. Valid values are `^[A-Z0-9]{3,20}$`',
    `policy_description` STRING COMMENT 'Comprehensive summary of the policy purpose, scope, and key provisions for quick reference and search.',
    `policy_document_url` STRING COMMENT 'Web address or document management system link to the full policy document for employee access and reference.. Valid values are `^https?://.*$`',
    `policy_language` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which this policy version is published.. Valid values are `^[a-z]{2}$`',
    `policy_owner_department` STRING COMMENT 'Department responsible for authoring, maintaining, and enforcing this policy. [ENUM-REF-CANDIDATE: hr|legal|compliance|it|finance|operations|security — 7 candidates stripped; promote to reference product]',
    `policy_priority` STRING COMMENT 'Priority level of the policy indicating its importance and urgency for employee compliance and organizational risk management.. Valid values are `critical|high|medium|low`',
    `policy_status` STRING COMMENT 'Current lifecycle status of the policy indicating its operational state and enforceability.. Valid values are `draft|pending_approval|active|superseded|retired|suspended`',
    `policy_title` STRING COMMENT 'Official title of the workforce policy as published in the employee handbook or policy repository.',
    `policy_version` STRING COMMENT 'Version number of the policy document following semantic versioning convention (e.g., 1.0, 2.1, 3.0.1).. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `publication_date` DATE COMMENT 'Date when the policy was officially published and made available to employees through internal communication channels.',
    `regulatory_reference` STRING COMMENT 'Citation of applicable laws, regulations, or industry standards that this policy addresses (e.g., Federal Communications Commission (FCC) rules, General Data Protection Regulation (GDPR), Occupational Safety and Health Administration (OSHA) standards).',
    `related_policy_ids` STRING COMMENT 'Comma-separated list of workforce policy IDs that are related or cross-referenced by this policy for comprehensive policy navigation.',
    `review_frequency_months` STRING COMMENT 'Number of months between mandatory policy reviews, establishing the review cadence for policy maintenance.',
    `source_record_code` STRING COMMENT 'Unique identifier of this policy record in the source system, enabling cross-system reconciliation and data lineage.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this policy record originated, supporting data lineage and integration traceability.',
    `training_course_code` STRING COMMENT 'Code of the training course associated with this policy, enabling linkage to learning management systems.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether formal training is required for employees to understand and comply with this policy.',
    `violation_consequence` STRING COMMENT 'Summary of potential consequences for policy violations, ranging from verbal warning to termination, providing clarity on enforcement.',
    CONSTRAINT pk_workforce_policy PRIMARY KEY(`workforce_policy_id`)
) COMMENT 'Reference master for all HR and workforce policies governing employment terms, conduct, and entitlements across the telecommunications enterprise. Captures policy code, policy title, policy category (leave policy, code of conduct, anti-harassment, data privacy, BYOD, remote work, expense reimbursement, travel, health and safety, equal opportunity, whistleblower), policy version, effective date, expiry date, applicable legal entity or geography, mandatory acknowledgment flag, acknowledgment frequency (once, annual, on-change), policy document reference URL, policy owner (HR, Legal, Compliance), approval authority, and active status.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` (
    `policy_acknowledgment_id` BIGINT COMMENT 'Unique identifier for the policy acknowledgment record. Primary key for the policy acknowledgment transaction.',
    `employee_id` BIGINT COMMENT 'System user identifier of the person or process that created this policy acknowledgment record. Used for audit trail and accountability.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person or process that last modified this policy acknowledgment record. Used for audit trail and accountability.',
    `primary_policy_employee_id` BIGINT COMMENT 'Reference to the employee who is acknowledging the policy. Links to the employee master record.',
    `quaternary_policy_revoked_by_employee_id` BIGINT COMMENT 'Reference to the employee (typically HR administrator or compliance officer) who revoked the policy acknowledgment.',
    `tertiary_policy_witness_employee_id` BIGINT COMMENT 'Reference to an employee who witnessed the policy acknowledgment. Applicable for certain high-compliance policies requiring witnessed signatures.',
    `workforce_policy_id` BIGINT COMMENT 'Reference to the workforce policy being acknowledged. Links to the policy master record.',
    `superseded_policy_acknowledgment_id` BIGINT COMMENT 'Self-referencing FK on policy_acknowledgment (superseded_policy_acknowledgment_id)',
    `acknowledgment_channel` STRING COMMENT 'The channel or method through which the employee acknowledged the policy. Examples include HR self-service portal, email confirmation, paper signature, Learning Management System (LMS) completion, mobile application, or physical kiosk.. Valid values are `hr_portal|email|paper|lms|mobile_app|kiosk`',
    `acknowledgment_device_type` STRING COMMENT 'The type of device used by the employee to submit the acknowledgment. Useful for understanding user experience and access patterns.. Valid values are `desktop|laptop|mobile|tablet|kiosk|unknown`',
    `acknowledgment_ip_address` STRING COMMENT 'The Internet Protocol (IP) address from which the employee submitted the policy acknowledgment. Captured for audit trail and security purposes.',
    `acknowledgment_location` STRING COMMENT 'The physical or logical location where the acknowledgment was captured. May be office location code, remote work indicator, or geographic region.',
    `acknowledgment_method` STRING COMMENT 'The specific mechanism used to capture the acknowledgment. Distinguishes between electronic signature, checkbox acceptance, biometric verification, wet signature on paper, verbal confirmation, or system-automated acknowledgment.. Valid values are `electronic_signature|checkbox|biometric|wet_signature|verbal|system_auto`',
    `acknowledgment_number` STRING COMMENT 'Human-readable unique reference number for this policy acknowledgment transaction, used for tracking and audit purposes.',
    `acknowledgment_status` STRING COMMENT 'Current status of the policy acknowledgment in its lifecycle. Tracks whether the employee has completed, is pending, or is overdue on the acknowledgment requirement.. Valid values are `pending|acknowledged|overdue|exempted|expired|revoked`',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the employee formally acknowledged the policy. This is the primary business event timestamp for compliance and audit purposes.',
    `attestation_text` STRING COMMENT 'The specific attestation statement or declaration text that the employee agreed to when acknowledging the policy. Captured for legal and audit purposes.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this acknowledgment record to detailed audit trail logs in the compliance audit system. Used for regulatory audit and investigation purposes.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a completion certificate was issued to the employee upon successful policy acknowledgment and training completion. True if certificate issued, False otherwise.',
    `certificate_number` STRING COMMENT 'Unique identifier of the completion certificate issued to the employee for this policy acknowledgment.',
    `comments` STRING COMMENT 'Free-text field for additional notes, comments, or context related to this policy acknowledgment. May include employee questions, HR clarifications, or special circumstances.',
    `compliance_requirement_code` STRING COMMENT 'Code identifying the regulatory or compliance requirement that mandates this policy acknowledgment. Examples include SOX, GDPR, HIPAA, FCC regulations, or internal audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this policy acknowledgment record was first created in the system. Used for audit trail and data lineage tracking.',
    `digital_signature_hash` STRING COMMENT 'Cryptographic hash of the digital signature applied to the policy acknowledgment. Used to verify authenticity and integrity of the acknowledgment.',
    `document_attachment_count` STRING COMMENT 'The number of supporting documents or attachments associated with this policy acknowledgment record. May include signed forms, certificates, or evidence files.',
    `due_date` DATE COMMENT 'The date by which the employee is required to acknowledge the policy. Used to identify overdue acknowledgments and trigger escalation workflows.',
    `exemption_approval_timestamp` TIMESTAMP COMMENT 'The date and time when the exemption was formally approved by the authorized approver.',
    `exemption_flag` BOOLEAN COMMENT 'Indicates whether the employee has been granted an exemption from acknowledging this policy. True if exempted, False otherwise.',
    `exemption_reason` STRING COMMENT 'Detailed explanation of why the employee was exempted from the policy acknowledgment requirement. Examples include role-based exemption, geographic jurisdiction exclusion, or temporary leave status.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this policy acknowledgment record was most recently updated. Used for audit trail and change tracking.',
    `last_reminder_sent_timestamp` TIMESTAMP COMMENT 'The date and time when the most recent reminder notification was sent to the employee.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether acknowledgment of this policy is mandatory for the employee. True for required policies, False for optional or informational policies.',
    `next_acknowledgment_due_date` DATE COMMENT 'The date when the employee will be required to re-acknowledge this policy. Applicable for policies requiring periodic re-acknowledgment such as annual compliance training or updated code of conduct.',
    `policy_category` STRING COMMENT 'The business category or classification of the policy being acknowledged. Examples include code of conduct, information security, health and safety, data privacy, anti-harassment, or regulatory compliance.',
    `policy_version` STRING COMMENT 'Version identifier of the policy document that was acknowledged by the employee. Critical for compliance tracking when policies are updated.',
    `reminder_count` STRING COMMENT 'The number of reminder notifications sent to the employee regarding this pending policy acknowledgment. Used to track escalation and follow-up activities.',
    `revocation_reason` STRING COMMENT 'Explanation of why a previously completed acknowledgment was revoked or invalidated. Examples include policy version superseded, employee role change, or data correction.',
    `revocation_timestamp` TIMESTAMP COMMENT 'The date and time when the policy acknowledgment was revoked or invalidated.',
    `source_record_code` STRING COMMENT 'The unique identifier of this policy acknowledgment record in the source system. Used for data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this policy acknowledgment record originated. Examples include SAP S/4HANA HCM, Workday, or custom HR portal.',
    `training_completion_flag` BOOLEAN COMMENT 'Indicates whether the employee completed associated training before acknowledging the policy. True if training was completed, False otherwise.',
    `training_duration_minutes` STRING COMMENT 'The total time in minutes that the employee spent completing the policy training module before acknowledgment.',
    `training_score` DECIMAL(18,2) COMMENT 'The score achieved by the employee on any assessment or quiz associated with the policy training. Expressed as a percentage (0.00 to 100.00).',
    `witness_timestamp` TIMESTAMP COMMENT 'The date and time when the witness confirmed the policy acknowledgment.',
    CONSTRAINT pk_policy_acknowledgment PRIMARY KEY(`policy_acknowledgment_id`)
) COMMENT 'Transactional record capturing each instance of an employee formally acknowledging a workforce policy — the SSOT for policy compliance tracking across the enterprise. Captures employee reference, workforce policy reference, policy version acknowledged, acknowledgment channel (HR portal self-service, email confirmation, paper signature, LMS completion), acknowledgment timestamp, acknowledgment status (pending, acknowledged, overdue, exempted), exemption reason if applicable, reminder count sent, and next acknowledgment due date. Supports compliance audits and regulatory requirements for documented policy acceptance.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`onboarding_program` (
    `onboarding_program_id` BIGINT COMMENT 'Primary key for onboarding_program',
    `superseded_onboarding_program_id` BIGINT COMMENT 'Self-referencing FK on onboarding_program (superseded_onboarding_program_id)',
    `assessment_method` STRING COMMENT 'Primary method used to assess participant competency.',
    `assessment_pass_threshold` DECIMAL(18,2) COMMENT 'Minimum percentage score required to pass the assessment.',
    `certification_awarded` BOOLEAN COMMENT 'Indicates whether the program awards a certification upon successful completion.',
    `certification_name` STRING COMMENT 'Name of the certification granted by the program, if any.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance obligations that the program satisfies.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Monetary cost to the organization for delivering the program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the onboarding program record was first created.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Accredited credit hours associated with the program.',
    `current_enrollment` STRING COMMENT 'Current number of participants enrolled in the program.',
    `delivery_method` STRING COMMENT 'Primary method used to deliver the program content.',
    `department` STRING COMMENT 'Organizational department that sponsors the program.',
    `onboarding_program_description` STRING COMMENT 'Detailed narrative describing the purpose, content, and outcomes of the program.',
    `duration_days` STRING COMMENT 'Planned length of the program measured in calendar days.',
    `effective_from` TIMESTAMP COMMENT 'Date‑time from which the program definition becomes effective.',
    `effective_until` TIMESTAMP COMMENT 'Date‑time after which the program definition is no longer effective (nullable).',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine who may enroll in the program.',
    `enrollment_end_date` DATE COMMENT 'Date when enrollment for the program closes.',
    `enrollment_start_date` DATE COMMENT 'Date when enrollment for the program opens.',
    `external_reference_code` STRING COMMENT 'Identifier linking the program to an external system of record.',
    `feedback_score_avg` DECIMAL(18,2) COMMENT 'Average rating (0‑5) collected from participants after program completion.',
    `format` STRING COMMENT 'Structural format of the program sessions.',
    `language` STRING COMMENT 'Primary language used for program materials and instruction.',
    `last_review_date` DATE COMMENT 'Date when the program content was last reviewed for relevance and compliance.',
    `location` STRING COMMENT 'Physical or virtual location where the program is delivered.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether participation in the program is mandatory for the target audience.',
    `max_participants` STRING COMMENT 'Maximum number of participants allowed to enroll.',
    `program_category` STRING COMMENT 'Higher‑level grouping of programs (e.g., mandatory, optional, leadership).',
    `program_code` STRING COMMENT 'Business code used to reference the onboarding program in external systems.',
    `program_end_date` DATE COMMENT 'Date when the program officially ends.',
    `program_name` STRING COMMENT 'Human‑readable name of the onboarding program.',
    `program_owner` STRING COMMENT 'Name of the internal employee responsible for the program.',
    `program_start_date` DATE COMMENT 'Date when the program officially begins.',
    `program_type` STRING COMMENT 'Category of the onboarding program indicating its primary focus.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory program reviews.',
    `onboarding_program_status` STRING COMMENT 'Current lifecycle state of the onboarding program.',
    `target_audience` STRING COMMENT 'Primary employee group for which the program is intended.',
    `training_material_url` STRING COMMENT 'Web address where program materials are hosted.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the onboarding program record.',
    `version_number` STRING COMMENT 'Version identifier for the program definition, used for change management.',
    CONSTRAINT pk_onboarding_program PRIMARY KEY(`onboarding_program_id`)
) COMMENT 'Master reference table for onboarding_program. Referenced by onboarding_program_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`people`.`calibration_session` (
    `calibration_session_id` BIGINT COMMENT 'Primary key for calibration_session',
    `employee_id` BIGINT COMMENT 'Identifier of the person who facilitated the calibration session.',
    `prior_calibration_session_id` BIGINT COMMENT 'Self-referencing FK on calibration_session (prior_calibration_session_id)',
    `average_score` DECIMAL(18,2) COMMENT 'Mean score resulting from the calibration assessments.',
    `confidentiality_flag` STRING COMMENT 'Indicates the data sensitivity level of the session record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration session record was first created in the system.',
    `duration_minutes` STRING COMMENT 'Total length of the session in minutes.',
    `effective_from` DATE COMMENT 'Date from which the calibration session becomes effective for reporting purposes.',
    `effective_until` DATE COMMENT 'Date after which the calibration session is no longer considered active; null if open‑ended.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the session ended.',
    `location` STRING COMMENT 'Physical location or venue where the session was held.',
    `max_score` DECIMAL(18,2) COMMENT 'Highest individual score recorded in the session.',
    `min_score` DECIMAL(18,2) COMMENT 'Lowest individual score recorded in the session.',
    `notes` STRING COMMENT 'Free‑form text for observations, decisions, and follow‑up actions.',
    `participant_count` STRING COMMENT 'Total number of participants who attended the session.',
    `session_category` STRING COMMENT 'Organizational scope of the session.',
    `session_code` STRING COMMENT 'External code or reference number used to identify the session in HR systems.',
    `session_name` STRING COMMENT 'Human‑readable name of the calibration session.',
    `session_type` STRING COMMENT 'Category of the calibration session indicating its purpose.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the session started.',
    `calibration_session_status` STRING COMMENT 'Current lifecycle state of the session.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the calibration session record.',
    `virtual_meeting_link` STRING COMMENT 'URL for the virtual meeting platform used for the session.',
    CONSTRAINT pk_calibration_session PRIMARY KEY(`calibration_session_id`)
) COMMENT 'Master reference table for calibration_session. Referenced by calibration_session_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ADD CONSTRAINT `fk_people_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ADD CONSTRAINT `fk_people_employee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ADD CONSTRAINT `fk_people_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`position` ADD CONSTRAINT `fk_people_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `telecommunication_ecm`.`people`.`job_profile`(`job_profile_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`position` ADD CONSTRAINT `fk_people_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`position` ADD CONSTRAINT `fk_people_position_reporting_position_id` FOREIGN KEY (`reporting_position_id`) REFERENCES `telecommunication_ecm`.`people`.`position`(`position_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`position` ADD CONSTRAINT `fk_people_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `telecommunication_ecm`.`people`.`position`(`position_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ADD CONSTRAINT `fk_people_job_profile_parent_job_profile_id` FOREIGN KEY (`parent_job_profile_id`) REFERENCES `telecommunication_ecm`.`people`.`job_profile`(`job_profile_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ADD CONSTRAINT `fk_people_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ADD CONSTRAINT `fk_people_assignment_assignment_created_by_user_employee_id` FOREIGN KEY (`assignment_created_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ADD CONSTRAINT `fk_people_assignment_assignment_employee_id` FOREIGN KEY (`assignment_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ADD CONSTRAINT `fk_people_assignment_assignment_manager_employee_id` FOREIGN KEY (`assignment_manager_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ADD CONSTRAINT `fk_people_assignment_assignment_modified_by_user_employee_id` FOREIGN KEY (`assignment_modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ADD CONSTRAINT `fk_people_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ADD CONSTRAINT `fk_people_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `telecommunication_ecm`.`people`.`position`(`position_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ADD CONSTRAINT `fk_people_assignment_superseded_assignment_id` FOREIGN KEY (`superseded_assignment_id`) REFERENCES `telecommunication_ecm`.`people`.`assignment`(`assignment_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ADD CONSTRAINT `fk_people_compensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ADD CONSTRAINT `fk_people_compensation_compensation_employee_id` FOREIGN KEY (`compensation_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ADD CONSTRAINT `fk_people_compensation_superseded_compensation_id` FOREIGN KEY (`superseded_compensation_id`) REFERENCES `telecommunication_ecm`.`people`.`compensation`(`compensation_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ADD CONSTRAINT `fk_people_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ADD CONSTRAINT `fk_people_payroll_run_tertiary_payroll_reversed_by_user_employee_id` FOREIGN KEY (`tertiary_payroll_reversed_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ADD CONSTRAINT `fk_people_payroll_run_reversal_payroll_run_id` FOREIGN KEY (`reversal_payroll_run_id`) REFERENCES `telecommunication_ecm`.`people`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ADD CONSTRAINT `fk_people_payslip_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ADD CONSTRAINT `fk_people_payslip_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `telecommunication_ecm`.`people`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ADD CONSTRAINT `fk_people_payslip_correction_of_payslip_id` FOREIGN KEY (`correction_of_payslip_id`) REFERENCES `telecommunication_ecm`.`people`.`payslip`(`payslip_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ADD CONSTRAINT `fk_people_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `telecommunication_ecm`.`people`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ADD CONSTRAINT `fk_people_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `telecommunication_ecm`.`people`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ADD CONSTRAINT `fk_people_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ADD CONSTRAINT `fk_people_benefit_enrollment_prior_benefit_enrollment_id` FOREIGN KEY (`prior_benefit_enrollment_id`) REFERENCES `telecommunication_ecm`.`people`.`benefit_enrollment`(`benefit_enrollment_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ADD CONSTRAINT `fk_people_leave_entitlement_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ADD CONSTRAINT `fk_people_leave_entitlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ADD CONSTRAINT `fk_people_leave_entitlement_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ADD CONSTRAINT `fk_people_leave_entitlement_carried_from_leave_entitlement_id` FOREIGN KEY (`carried_from_leave_entitlement_id`) REFERENCES `telecommunication_ecm`.`people`.`leave_entitlement`(`leave_entitlement_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ADD CONSTRAINT `fk_people_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ADD CONSTRAINT `fk_people_leave_request_tertiary_leave_substitute_employee_id` FOREIGN KEY (`tertiary_leave_substitute_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ADD CONSTRAINT `fk_people_leave_request_original_leave_request_id` FOREIGN KEY (`original_leave_request_id`) REFERENCES `telecommunication_ecm`.`people`.`leave_request`(`leave_request_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ADD CONSTRAINT `fk_people_performance_cycle_cycle_owner_employee_id` FOREIGN KEY (`cycle_owner_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ADD CONSTRAINT `fk_people_performance_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ADD CONSTRAINT `fk_people_performance_cycle_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ADD CONSTRAINT `fk_people_performance_cycle_prior_performance_cycle_id` FOREIGN KEY (`prior_performance_cycle_id`) REFERENCES `telecommunication_ecm`.`people`.`performance_cycle`(`performance_cycle_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ADD CONSTRAINT `fk_people_performance_review_calibration_session_id` FOREIGN KEY (`calibration_session_id`) REFERENCES `telecommunication_ecm`.`people`.`calibration_session`(`calibration_session_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ADD CONSTRAINT `fk_people_performance_review_performance_cycle_id` FOREIGN KEY (`performance_cycle_id`) REFERENCES `telecommunication_ecm`.`people`.`performance_cycle`(`performance_cycle_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ADD CONSTRAINT `fk_people_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ADD CONSTRAINT `fk_people_performance_review_prior_performance_review_id` FOREIGN KEY (`prior_performance_review_id`) REFERENCES `telecommunication_ecm`.`people`.`performance_review`(`performance_review_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ADD CONSTRAINT `fk_people_goal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ADD CONSTRAINT `fk_people_goal_goal_manager_employee_id` FOREIGN KEY (`goal_manager_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ADD CONSTRAINT `fk_people_goal_parent_goal_id` FOREIGN KEY (`parent_goal_id`) REFERENCES `telecommunication_ecm`.`people`.`goal`(`goal_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ADD CONSTRAINT `fk_people_goal_performance_cycle_id` FOREIGN KEY (`performance_cycle_id`) REFERENCES `telecommunication_ecm`.`people`.`performance_cycle`(`performance_cycle_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ADD CONSTRAINT `fk_people_learning_course_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ADD CONSTRAINT `fk_people_learning_course_primary_learning_approved_by_employee_id` FOREIGN KEY (`primary_learning_approved_by_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ADD CONSTRAINT `fk_people_learning_course_prerequisite_learning_course_id` FOREIGN KEY (`prerequisite_learning_course_id`) REFERENCES `telecommunication_ecm`.`people`.`learning_course`(`learning_course_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ADD CONSTRAINT `fk_people_learning_enrollment_learning_course_id` FOREIGN KEY (`learning_course_id`) REFERENCES `telecommunication_ecm`.`people`.`learning_course`(`learning_course_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ADD CONSTRAINT `fk_people_learning_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ADD CONSTRAINT `fk_people_learning_enrollment_retake_of_learning_enrollment_id` FOREIGN KEY (`retake_of_learning_enrollment_id`) REFERENCES `telecommunication_ecm`.`people`.`learning_enrollment`(`learning_enrollment_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ADD CONSTRAINT `fk_people_disciplinary_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ADD CONSTRAINT `fk_people_disciplinary_case_tertiary_disciplinary_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_disciplinary_hr_business_partner_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ADD CONSTRAINT `fk_people_disciplinary_case_escalated_from_disciplinary_case_id` FOREIGN KEY (`escalated_from_disciplinary_case_id`) REFERENCES `telecommunication_ecm`.`people`.`disciplinary_case`(`disciplinary_case_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ADD CONSTRAINT `fk_people_headcount_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ADD CONSTRAINT `fk_people_headcount_plan_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `telecommunication_ecm`.`people`.`job_profile`(`job_profile_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ADD CONSTRAINT `fk_people_headcount_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ADD CONSTRAINT `fk_people_headcount_plan_primary_headcount_submitted_by_employee_id` FOREIGN KEY (`primary_headcount_submitted_by_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ADD CONSTRAINT `fk_people_headcount_plan_revised_headcount_plan_id` FOREIGN KEY (`revised_headcount_plan_id`) REFERENCES `telecommunication_ecm`.`people`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ADD CONSTRAINT `fk_people_recruitment_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ADD CONSTRAINT `fk_people_recruitment_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `telecommunication_ecm`.`people`.`job_profile`(`job_profile_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ADD CONSTRAINT `fk_people_recruitment_requisition_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ADD CONSTRAINT `fk_people_recruitment_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ADD CONSTRAINT `fk_people_recruitment_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `telecommunication_ecm`.`people`.`position`(`position_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ADD CONSTRAINT `fk_people_recruitment_requisition_primary_recruitment_hiring_manager_employee_id` FOREIGN KEY (`primary_recruitment_hiring_manager_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ADD CONSTRAINT `fk_people_recruitment_requisition_quaternary_recruitment_replacement_employee_id` FOREIGN KEY (`quaternary_recruitment_replacement_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ADD CONSTRAINT `fk_people_recruitment_requisition_tertiary_recruitment_approved_by_employee_id` FOREIGN KEY (`tertiary_recruitment_approved_by_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ADD CONSTRAINT `fk_people_recruitment_requisition_reposted_from_recruitment_requisition_id` FOREIGN KEY (`reposted_from_recruitment_requisition_id`) REFERENCES `telecommunication_ecm`.`people`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ADD CONSTRAINT `fk_people_applicant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ADD CONSTRAINT `fk_people_applicant_applicant_interviewer_employee_id` FOREIGN KEY (`applicant_interviewer_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ADD CONSTRAINT `fk_people_applicant_applicant_recruiter_employee_id` FOREIGN KEY (`applicant_recruiter_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ADD CONSTRAINT `fk_people_applicant_applicant_referral_employee_id` FOREIGN KEY (`applicant_referral_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ADD CONSTRAINT `fk_people_applicant_position_id` FOREIGN KEY (`position_id`) REFERENCES `telecommunication_ecm`.`people`.`position`(`position_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ADD CONSTRAINT `fk_people_applicant_referral_applicant_id` FOREIGN KEY (`referral_applicant_id`) REFERENCES `telecommunication_ecm`.`people`.`applicant`(`applicant_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ADD CONSTRAINT `fk_people_interview_event_applicant_id` FOREIGN KEY (`applicant_id`) REFERENCES `telecommunication_ecm`.`people`.`applicant`(`applicant_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ADD CONSTRAINT `fk_people_interview_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ADD CONSTRAINT `fk_people_interview_event_quaternary_interview_coordinator_employee_id` FOREIGN KEY (`quaternary_interview_coordinator_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ADD CONSTRAINT `fk_people_interview_event_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `telecommunication_ecm`.`people`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ADD CONSTRAINT `fk_people_interview_event_rescheduled_from_interview_event_id` FOREIGN KEY (`rescheduled_from_interview_event_id`) REFERENCES `telecommunication_ecm`.`people`.`interview_event`(`interview_event_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ADD CONSTRAINT `fk_people_interview_event_tertiary_interviewer_3_employee_id` FOREIGN KEY (`tertiary_interviewer_3_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ADD CONSTRAINT `fk_people_interview_event_tertiary_quinary_interviewer_5_employee_id` FOREIGN KEY (`tertiary_quinary_interviewer_5_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ADD CONSTRAINT `fk_people_offer_letter_applicant_id` FOREIGN KEY (`applicant_id`) REFERENCES `telecommunication_ecm`.`people`.`applicant`(`applicant_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ADD CONSTRAINT `fk_people_offer_letter_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `telecommunication_ecm`.`people`.`org_unit`(`org_unit_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ADD CONSTRAINT `fk_people_offer_letter_position_id` FOREIGN KEY (`position_id`) REFERENCES `telecommunication_ecm`.`people`.`position`(`position_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ADD CONSTRAINT `fk_people_offer_letter_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ADD CONSTRAINT `fk_people_offer_letter_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `telecommunication_ecm`.`people`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ADD CONSTRAINT `fk_people_offer_letter_tertiary_offer_approved_by_employee_id` FOREIGN KEY (`tertiary_offer_approved_by_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ADD CONSTRAINT `fk_people_offer_letter_superseded_offer_letter_id` FOREIGN KEY (`superseded_offer_letter_id`) REFERENCES `telecommunication_ecm`.`people`.`offer_letter`(`offer_letter_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ADD CONSTRAINT `fk_people_onboarding_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ADD CONSTRAINT `fk_people_onboarding_task_onboarding_program_id` FOREIGN KEY (`onboarding_program_id`) REFERENCES `telecommunication_ecm`.`people`.`onboarding_program`(`onboarding_program_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ADD CONSTRAINT `fk_people_onboarding_task_primary_onboarding_employee_id` FOREIGN KEY (`primary_onboarding_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ADD CONSTRAINT `fk_people_onboarding_task_quaternary_onboarding_escalated_to_employee_id` FOREIGN KEY (`quaternary_onboarding_escalated_to_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ADD CONSTRAINT `fk_people_onboarding_task_quinary_onboarding_created_by_user_employee_id` FOREIGN KEY (`quinary_onboarding_created_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ADD CONSTRAINT `fk_people_onboarding_task_tertiary_onboarding_waived_by_employee_id` FOREIGN KEY (`tertiary_onboarding_waived_by_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ADD CONSTRAINT `fk_people_onboarding_task_prerequisite_onboarding_task_id` FOREIGN KEY (`prerequisite_onboarding_task_id`) REFERENCES `telecommunication_ecm`.`people`.`onboarding_task`(`onboarding_task_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ADD CONSTRAINT `fk_people_separation_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ADD CONSTRAINT `fk_people_separation_event_tertiary_separation_approved_by_employee_id` FOREIGN KEY (`tertiary_separation_approved_by_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ADD CONSTRAINT `fk_people_separation_event_rehire_of_separation_event_id` FOREIGN KEY (`rehire_of_separation_event_id`) REFERENCES `telecommunication_ecm`.`people`.`separation_event`(`separation_event_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ADD CONSTRAINT `fk_people_workforce_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ADD CONSTRAINT `fk_people_workforce_policy_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ADD CONSTRAINT `fk_people_workforce_policy_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ADD CONSTRAINT `fk_people_workforce_policy_primary_workforce_approved_by_employee_id` FOREIGN KEY (`primary_workforce_approved_by_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ADD CONSTRAINT `fk_people_workforce_policy_superseded_policy_workforce_policy_id` FOREIGN KEY (`superseded_policy_workforce_policy_id`) REFERENCES `telecommunication_ecm`.`people`.`workforce_policy`(`workforce_policy_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ADD CONSTRAINT `fk_people_workforce_policy_superseded_workforce_policy_id` FOREIGN KEY (`superseded_workforce_policy_id`) REFERENCES `telecommunication_ecm`.`people`.`workforce_policy`(`workforce_policy_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ADD CONSTRAINT `fk_people_policy_acknowledgment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ADD CONSTRAINT `fk_people_policy_acknowledgment_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ADD CONSTRAINT `fk_people_policy_acknowledgment_primary_policy_employee_id` FOREIGN KEY (`primary_policy_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ADD CONSTRAINT `fk_people_policy_acknowledgment_quaternary_policy_revoked_by_employee_id` FOREIGN KEY (`quaternary_policy_revoked_by_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ADD CONSTRAINT `fk_people_policy_acknowledgment_tertiary_policy_witness_employee_id` FOREIGN KEY (`tertiary_policy_witness_employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ADD CONSTRAINT `fk_people_policy_acknowledgment_workforce_policy_id` FOREIGN KEY (`workforce_policy_id`) REFERENCES `telecommunication_ecm`.`people`.`workforce_policy`(`workforce_policy_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ADD CONSTRAINT `fk_people_policy_acknowledgment_superseded_policy_acknowledgment_id` FOREIGN KEY (`superseded_policy_acknowledgment_id`) REFERENCES `telecommunication_ecm`.`people`.`policy_acknowledgment`(`policy_acknowledgment_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_program` ADD CONSTRAINT `fk_people_onboarding_program_superseded_onboarding_program_id` FOREIGN KEY (`superseded_onboarding_program_id`) REFERENCES `telecommunication_ecm`.`people`.`onboarding_program`(`onboarding_program_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`calibration_session` ADD CONSTRAINT `fk_people_calibration_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `telecommunication_ecm`.`people`.`employee`(`employee_id`);
ALTER TABLE `telecommunication_ecm`.`people`.`calibration_session` ADD CONSTRAINT `fk_people_calibration_session_prior_calibration_session_id` FOREIGN KEY (`prior_calibration_session_id`) REFERENCES `telecommunication_ecm`.`people`.`calibration_session`(`calibration_session_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`people` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `telecommunication_ecm`.`people` SET TAGS ('dbx_domain' = 'people');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on-leave|suspended|terminated|retired|deceased');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full-time|part-time|fixed-term|seasonal|intern|contractor');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non-binary|prefer not to say|other|unknown');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `hr_system_source_code` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) System Source Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|separated|domestic partnership');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `marital_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `nationality` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `nationality` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `original_hire_date` SET TAGS ('dbx_business_glossary_term' = 'Original Hire Date');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_business_glossary_term' = 'Personal Email Address');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `personal_mobile` SET TAGS ('dbx_business_glossary_term' = 'Personal Mobile Number');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `personal_mobile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `personal_mobile` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `rehire_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary resignation|involuntary termination|retirement|end of contract|layoff|mutual agreement');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Type');
ALTER TABLE `telecommunication_ecm`.`people`.`employee` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_value_regex' = 'standard|shift|flexible|remote|hybrid|on-call');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `actual_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `head_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Head Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `head_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `head_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `headcount_budget` SET TAGS ('dbx_business_glossary_term' = 'Headcount Budget');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `is_customer_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Facing');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Is Revenue Generating');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `manager_title` SET TAGS ('dbx_business_glossary_term' = 'Manager Title');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|dissolved|merged');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `workforce_type` SET TAGS ('dbx_business_glossary_term' = 'Workforce Type');
ALTER TABLE `telecommunication_ecm`.`people`.`org_unit` ALTER COLUMN `workforce_type` SET TAGS ('dbx_value_regex' = 'permanent|contract|hybrid|outsourced|offshore');
ALTER TABLE `telecommunication_ecm`.`people`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`people`.`position` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `reporting_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Position Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Position Approval Date');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `budgeted_flag` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `creation_reason` SET TAGS ('dbx_business_glossary_term' = 'Position Creation Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `creation_reason` SET TAGS ('dbx_value_regex' = 'new_business_need|replacement|organizational_restructure|expansion|regulatory_requirement|project_based');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `critical_position_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Position Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|job_share|on_call');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `exempt_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exempt Status');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `exempt_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt|not_applicable');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|filled|vacant|frozen|eliminated|pending_approval');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed_term|contractor_slot|temporary|seasonal|project_based');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `required_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Required Security Clearance Level');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `required_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|standard|enhanced|top_secret');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `required_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `required_qualifications_summary` SET TAGS ('dbx_business_glossary_term' = 'Required Qualifications Summary');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `span_of_control` SET TAGS ('dbx_business_glossary_term' = 'Span of Control');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `succession_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `supervisory_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Position Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `union_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Work Arrangement');
ALTER TABLE `telecommunication_ecm`.`people`.`position` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid|field_based|mobile');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `parent_job_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `core_competencies` SET TAGS ('dbx_business_glossary_term' = 'Core Competencies');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'Exempt|Non-Exempt');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `grade_band` SET TAGS ('dbx_business_glossary_term' = 'Grade Band');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `grade_band` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `grade_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `is_customer_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Facing Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `is_people_manager` SET TAGS ('dbx_business_glossary_term' = 'Is People Manager Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `is_safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Is Safety Sensitive Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `job_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Code');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `job_profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Deprecated|Under Review|Proposed');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `job_subfamily` SET TAGS ('dbx_business_glossary_term' = 'Job Subfamily');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `minimum_education_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Requirement');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `minimum_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Owner');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `predecessor_job_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Job Profile Code');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `remote_work_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligibility');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `remote_work_eligibility` SET TAGS ('dbx_value_regex' = 'Fully Remote|Hybrid|On-Site Only|Flexible');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `security_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `security_clearance_required` SET TAGS ('dbx_value_regex' = 'None|Confidential|Secret|Top Secret|Public Trust');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `stock_option_eligible` SET TAGS ('dbx_business_glossary_term' = 'Stock Option Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `successor_job_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Successor Job Profile Code');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `union_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Union Eligibility');
ALTER TABLE `telecommunication_ecm`.`people`.`job_profile` ALTER COLUMN `union_eligibility` SET TAGS ('dbx_value_regex' = 'Eligible|Not Eligible|Management Excluded');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `superseded_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approval Status');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^ASG-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|on_leave');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|concurrent|acting|interim');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{6}$');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `employment_category` SET TAGS ('dbx_business_glossary_term' = 'Employment Category');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `employment_category` SET TAGS ('dbx_value_regex' = 'regular_full_time|regular_part_time|temporary|intern|contractor|consultant');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Expiry Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `is_critical_role` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Role Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `is_primary_assignment` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Assignment Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `overtime_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `overtime_eligibility` SET TAGS ('dbx_value_regex' = 'eligible|exempt|not_applicable');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason Code');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason Description');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `remote_work_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligibility');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `remote_work_eligibility` SET TAGS ('dbx_value_regex' = 'eligible|not_eligible|conditional');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Sequence Number');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `source_system_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Assignment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_HCM|WORKDAY|ORACLE_HCM|MANUAL|INTEGRATION');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid|field_based|mobile');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `work_schedule_pattern` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Pattern');
ALTER TABLE `telecommunication_ecm`.`people`.`assignment` ALTER COLUMN `work_schedule_pattern` SET TAGS ('dbx_value_regex' = 'standard_40hr|compressed_week|shift_rotation|flexible|on_call|custom');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation ID');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `compensation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `compensation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `compensation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `superseded_compensation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `annual_leave_days` SET TAGS ('dbx_business_glossary_term' = 'Annual Leave Days');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `change_reason` SET TAGS ('dbx_value_regex' = 'merit_increase|promotion|market_adjustment|equity_correction|new_hire|annual_review');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Status');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_value_regex' = 'active|pending|approved|superseded|terminated');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `equity_grant_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non-exempt');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `grade_maximum_amount` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Maximum Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `grade_maximum_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `grade_minimum_amount` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Minimum Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `grade_minimum_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Housing Allowance Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `meal_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Meal Allowance Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `meal_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `mobile_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Mobile Allowance Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `mobile_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi-weekly|weekly|semi-monthly|quarterly|annual');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `pay_step` SET TAGS ('dbx_business_glossary_term' = 'Pay Step');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Type');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|commission|hybrid|contract|stipend');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `shift_differential_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `sick_leave_days` SET TAGS ('dbx_business_glossary_term' = 'Sick Leave Days');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Bonus Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `total_fixed_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fixed Compensation Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `total_fixed_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `transport_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Transport Allowance Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `transport_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `telecommunication_ecm`.`people`.`compensation` ALTER COLUMN `union_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Member Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `tertiary_payroll_reversed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `tertiary_payroll_reversed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `tertiary_payroll_reversed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `reversal_payroll_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `check_date` SET TAGS ('dbx_business_glossary_term' = 'Check Date');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `off_cycle_reason` SET TAGS ('dbx_business_glossary_term' = 'Off-Cycle Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `payroll_area` SET TAGS ('dbx_business_glossary_term' = 'Payroll Area');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `payroll_control_record` SET TAGS ('dbx_business_glossary_term' = 'Payroll Control Record');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `payroll_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payroll Frequency');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `payroll_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi-weekly|weekly|semi-monthly|quarterly|annual');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `payroll_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `payroll_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `payroll_run_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Number');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `payroll_run_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Type');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `payroll_run_type` SET TAGS ('dbx_value_regex' = 'regular|off-cycle|bonus|final-settlement|correction|advance');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `payroll_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Payroll System Reference');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `posting_date_to_gl` SET TAGS ('dbx_business_glossary_term' = 'Posting Date to General Ledger (GL)');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `total_employee_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Employee Deductions');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `total_employer_contributions` SET TAGS ('dbx_business_glossary_term' = 'Total Employer Contributions');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Pay');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Net Pay');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payroll_run` ALTER COLUMN `total_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Withheld');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `payslip_id` SET TAGS ('dbx_business_glossary_term' = 'Payslip Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `correction_of_payslip_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payslip Acknowledged Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `allowances_total` SET TAGS ('dbx_business_glossary_term' = 'Total Allowances');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last Four Digits');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `basic_salary` SET TAGS ('dbx_business_glossary_term' = 'Basic Salary');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `basic_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `basic_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payslip Delivered Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `employer_health_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Health Insurance Contribution');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `employer_health_contribution` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `employer_health_contribution` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `employer_pension_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Pension Contribution');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `employer_social_security` SET TAGS ('dbx_business_glossary_term' = 'Employer Social Security Contribution');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `employer_social_security` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `employer_social_security` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payslip Generated Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `health_insurance_premium` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Premium Deduction');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `health_insurance_premium` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `health_insurance_premium` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `income_tax` SET TAGS ('dbx_business_glossary_term' = 'Income Tax Deduction');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `leave_days_taken` SET TAGS ('dbx_business_glossary_term' = 'Leave Days Taken');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `loan_repayment` SET TAGS ('dbx_business_glossary_term' = 'Loan Repayment Deduction');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `net_pay` SET TAGS ('dbx_business_glossary_term' = 'Net Pay');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `other_deductions` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions Total');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `overtime_pay` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|cheque|cash|payroll_card');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `payslip_number` SET TAGS ('dbx_business_glossary_term' = 'Payslip Number');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `payslip_status` SET TAGS ('dbx_business_glossary_term' = 'Payslip Status');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `payslip_status` SET TAGS ('dbx_value_regex' = 'generated|delivered|acknowledged|disputed|reissued|voided');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `pension_employee_contribution` SET TAGS ('dbx_business_glossary_term' = 'Pension Employee Contribution');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Payslip Remarks');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `shift_differential` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Pay');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `social_security_employee` SET TAGS ('dbx_business_glossary_term' = 'Social Security Employee Contribution');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `social_security_employee` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `social_security_employee` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `union_dues` SET TAGS ('dbx_business_glossary_term' = 'Union Dues Deduction');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `ytd_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Pay');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `ytd_gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `ytd_gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `ytd_income_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Income Tax');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `ytd_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Net Pay');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `ytd_net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`payslip` ALTER COLUMN `ytd_net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `allows_dependent_coverage` SET TAGS ('dbx_business_glossary_term' = 'Dependent Coverage Allowed Indicator');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `annual_coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Annual Coverage Limit Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Policy Number');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Indicator');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Rate');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'per_pay_period|monthly|quarterly|annually');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copayment Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|family|domestic_partner');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Plan Deductible Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Effective End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Eligibility Criteria');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `employee_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Rate');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `employer_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Rate');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `employer_match_limit` SET TAGS ('dbx_business_glossary_term' = 'Employer Match Limit Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `employer_match_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer Match Rate');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `employment_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Employment Type Eligibility');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `employment_type_eligibility` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|all');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `enrollment_window_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Type');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `enrollment_window_type` SET TAGS ('dbx_value_regex' = 'open_enrollment|life_event|new_hire|special_enrollment');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `erisa_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Retirement Income Security Act (ERISA) Plan Number');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `erisa_plan_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `grade_band_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Grade Band Eligibility');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `hipaa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Compliant Indicator');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Enrollment Indicator');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `lifetime_coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Coverage Limit Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `minimum_tenure_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tenure in Months');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Code');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Description');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Document Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_sponsor_ein` SET TAGS ('dbx_business_glossary_term' = 'Plan Sponsor Employer Identification Number (EIN)');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_sponsor_ein` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_sponsor_ein` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Status');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_type_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type Code');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Provider Name');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Classification');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_value_regex' = 'pre_tax|post_tax|roth|tax_exempt|taxable');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `vesting_period_months` SET TAGS ('dbx_business_glossary_term' = 'Vesting Period in Months');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `prior_benefit_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `beneficiary_designation_on_file` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation On File');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `carrier_acknowledgement_received` SET TAGS ('dbx_business_glossary_term' = 'Carrier Acknowledgement Received');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `carrier_acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Carrier Acknowledgement Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `cobra_election_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Election Deadline Date');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `contribution_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contribution Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `contribution_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family|employee_domestic_partner');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `employee_monthly_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Monthly Contribution Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `employee_monthly_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `employee_monthly_contribution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `employer_monthly_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Monthly Contribution Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `employer_monthly_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Number');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_value_regex' = 'new_hire|open_enrollment|qualifying_life_event|voluntary_change|annual_renewal|rehire');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online_portal|paper_form|phone|benefits_fair|hr_representative|mobile_app');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source Record Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source System');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|waived|suspended|cancelled');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Submitted Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `enrollment_transmitted_to_carrier_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Transmitted to Carrier Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Required');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Status');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied|incomplete');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `provider_enrollment_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Enrollment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Date');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Type');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'employment_termination|plan_change|employee_request|loss_eligibility|retirement|death');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `tobacco_user_status` SET TAGS ('dbx_business_glossary_term' = 'Tobacco User Status');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `tobacco_user_status` SET TAGS ('dbx_value_regex' = 'user|non_user|declined_to_answer');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `tobacco_user_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `tobacco_user_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `waiver_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason Code');
ALTER TABLE `telecommunication_ecm`.`people`.`benefit_enrollment` ALTER COLUMN `waiver_reason_code` SET TAGS ('dbx_value_regex' = 'spouse_coverage|other_employer|government_program|cost|not_needed|other');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `leave_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Entitlement Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `carried_from_leave_entitlement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `accrual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `accrual_frequency` SET TAGS ('dbx_business_glossary_term' = 'Accrual Frequency');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `accrual_frequency` SET TAGS ('dbx_value_regex' = 'monthly|annual|per_pay_period|daily|quarterly');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `accrual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `accrued_days` SET TAGS ('dbx_business_glossary_term' = 'Accrued Days');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `balance_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Balance As-Of Date');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `carried_forward_days` SET TAGS ('dbx_business_glossary_term' = 'Carried Forward Days');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `carryover_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Carryover Expiry Date');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `carryover_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Carryover Limit Days');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `entitlement_days` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Days');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|pending');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `forfeited_days` SET TAGS ('dbx_business_glossary_term' = 'Forfeited Days');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Is Paid Leave');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `is_statutory` SET TAGS ('dbx_business_glossary_term' = 'Is Statutory Leave');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `leave_type_code` SET TAGS ('dbx_business_glossary_term' = 'Leave Type Code');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `leave_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `leave_type_name` SET TAGS ('dbx_business_glossary_term' = 'Leave Type Name');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `leave_year` SET TAGS ('dbx_business_glossary_term' = 'Leave Year');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Leave Liability Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `liability_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `liability_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Liability Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `liability_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `pending_days` SET TAGS ('dbx_business_glossary_term' = 'Pending Days');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Policy Reference');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `proration_factor` SET TAGS ('dbx_business_glossary_term' = 'Proration Factor');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `remaining_balance_days` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance Days');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_entitlement` ALTER COLUMN `taken_days` SET TAGS ('dbx_business_glossary_term' = 'Taken Days');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `tertiary_leave_substitute_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `tertiary_leave_substitute_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `tertiary_leave_substitute_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `original_leave_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `days_requested` SET TAGS ('dbx_business_glossary_term' = 'Days Requested');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `entitlement_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Balance After');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `entitlement_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Balance Before');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `half_day_period` SET TAGS ('dbx_business_glossary_term' = 'Half Day Period');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `half_day_period` SET TAGS ('dbx_value_regex' = 'MORNING|AFTERNOON');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `hr_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Override Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `hr_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Override Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `is_half_day` SET TAGS ('dbx_business_glossary_term' = 'Half Day Indicator');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `leave_type_code` SET TAGS ('dbx_business_glossary_term' = 'Leave Type Code');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'PENDING|APPROVED|REJECTED|CANCELLED|RECALLED');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `requires_documentation_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Documentation Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `return_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Confirmed Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`leave_request` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` SET TAGS ('dbx_subdomain' = 'learning_development');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `performance_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Cycle Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Owner Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `prior_performance_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `calibration_end_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Window End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `calibration_start_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Window Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `compensation_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Impact Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `compensation_impact_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `compensation_impact_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Performance Cycle Code');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Cycle Description');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Cycle End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Performance Cycle Name');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Cycle Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Cycle Status');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_value_regex' = 'planned|active|in_progress|calibration|closed|cancelled');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Cycle Type');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = 'annual_appraisal|mid_year_review|quarterly_check_in|probation_review|pip_review|360_feedback');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `distribution_guideline` SET TAGS ('dbx_business_glossary_term' = 'Rating Distribution Guideline');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `eligible_population_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligible Employee Population Criteria');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `enable_360_feedback_flag` SET TAGS ('dbx_business_glossary_term' = 'Enable 360-Degree Feedback Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `enable_calibration_flag` SET TAGS ('dbx_business_glossary_term' = 'Enable Calibration Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `enable_goal_setting_flag` SET TAGS ('dbx_business_glossary_term' = 'Enable Goal Setting Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `enable_self_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Enable Self-Assessment Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `forced_distribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Forced Distribution Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `goal_setting_end_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Setting Window End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `goal_setting_start_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Setting Window Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `manager_review_end_date` SET TAGS ('dbx_business_glossary_term' = 'Manager Review Window End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `manager_review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Manager Review Window Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `mandatory_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Participation Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `notification_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `performance_year` SET TAGS ('dbx_business_glossary_term' = 'Performance Year');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `promotion_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Eligibility Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `rating_scale_code` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Reference Code');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `rating_scale_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `self_assessment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Assessment Window End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_cycle` ALTER COLUMN `self_assessment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Assessment Window Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` SET TAGS ('dbx_subdomain' = 'learning_development');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `calibration_session_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Session ID');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `performance_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Cycle ID');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `prior_performance_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `calibration_adjusted_rating` SET TAGS ('dbx_business_glossary_term' = 'Calibration Adjusted Rating');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `competency_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Competency Assessment Score');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `development_plan_created_flag` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Created Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `employee_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment Narrative');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `final_rating_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Final Rating Confirmed Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `goal_achievement_score` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Score');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Narrative Comments');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `merit_increase_recommended_pct` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Recommended Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `merit_increase_recommended_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `overall_rating_label` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating (Label)');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `overall_rating_label` SET TAGS ('dbx_value_regex' = 'below_expectations|meets_expectations|exceeds_expectations|outstanding|exceptional');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `overall_rating_numeric` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating (Numeric)');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `pip_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `pip_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `pip_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `promotion_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommended Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `rating_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Confirmation Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Number');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Status');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|submitted|calibrated|acknowledged|closed');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `succession_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Succession Readiness Level');
ALTER TABLE `telecommunication_ecm`.`people`.`performance_review` ALTER COLUMN `succession_readiness_level` SET TAGS ('dbx_value_regex' = 'not_ready|ready_1_2_years|ready_now|high_potential');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` SET TAGS ('dbx_subdomain' = 'learning_development');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `goal_id` SET TAGS ('dbx_business_glossary_term' = 'Goal Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `goal_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `goal_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `goal_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `parent_goal_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Goal Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `performance_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Cycle Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `achievement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Achievement Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Achievement Value');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `competency_code` SET TAGS ('dbx_business_glossary_term' = 'Competency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `employee_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `employee_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_business_glossary_term' = 'Goal Category');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_value_regex' = 'business_objective|development_goal|behavioral_competency|operational_excellence|customer_satisfaction|innovation');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `goal_description` SET TAGS ('dbx_business_glossary_term' = 'Goal Description');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `goal_number` SET TAGS ('dbx_business_glossary_term' = 'Goal Number');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `goal_source` SET TAGS ('dbx_business_glossary_term' = 'Goal Source');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `goal_source` SET TAGS ('dbx_value_regex' = 'cascaded_from_manager|self_created|hr_assigned|org_objective_aligned|peer_suggested');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `goal_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Status');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `goal_status` SET TAGS ('dbx_value_regex' = 'draft|committed|in_progress|completed|cancelled|deferred');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Goal Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `is_stretch_goal` SET TAGS ('dbx_business_glossary_term' = 'Is Stretch Goal Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `linked_training_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Linked Training Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `manager_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Manager Acknowledgment Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `manager_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manager Acknowledgment Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `mid_year_progress_note` SET TAGS ('dbx_business_glossary_term' = 'Mid-Year Progress Note');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `org_unit_objective_reference` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Objective Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `target_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Name');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `target_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Goal Title');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `visibility_scope` SET TAGS ('dbx_business_glossary_term' = 'Visibility Scope');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `visibility_scope` SET TAGS ('dbx_value_regex' = 'private|manager_only|team|department|public');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Goal Weight Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`goal` ALTER COLUMN `year_end_achievement_note` SET TAGS ('dbx_business_glossary_term' = 'Year-End Achievement Note');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` SET TAGS ('dbx_subdomain' = 'learning_development');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Course Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Course Owner Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `primary_learning_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `primary_learning_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `primary_learning_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `prerequisite_learning_course_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|retired|suspended');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `competency_framework` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `course_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Course Fee Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `course_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `course_language` SET TAGS ('dbx_business_glossary_term' = 'Course Language');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `course_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `course_version` SET TAGS ('dbx_business_glossary_term' = 'Course Version');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `course_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `last_content_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Content Update Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `learning_management_system_code` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `max_enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment Capacity');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `prerequisite_courses` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Courses');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = 'internal|external_vendor|industry_association|technology_partner|academic_institution');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'foundation|intermediate|advanced|expert');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Course Tags');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_course` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Months');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` SET TAGS ('dbx_subdomain' = 'learning_development');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `learning_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Enrollment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Course Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `retake_of_learning_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `attendance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attendance Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `cpd_hours_credited` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Hours Credited');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|virtual-instructor-led|e-learning|blended|on-the-job|webinar');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `delivery_session_reference` SET TAGS ('dbx_business_glossary_term' = 'Delivery Session Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'self-enrolled|manager-assigned|hr-mandated|compliance-required|system-triggered|career-development');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `feedback_rating` SET TAGS ('dbx_business_glossary_term' = 'Feedback Rating');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `learning_hours_logged` SET TAGS ('dbx_business_glossary_term' = 'Learning Hours Logged');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `next_recertification_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recertification Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Result');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|not-applicable|waived');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `telecommunication_ecm`.`people`.`learning_enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` SET TAGS ('dbx_subdomain' = 'learning_development');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `disciplinary_case_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Case Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `escalated_from_disciplinary_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `appeal_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'appeal_upheld|appeal_rejected|outcome_modified|pending');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `appeal_outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Date');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `case_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Date');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `case_open_date` SET TAGS ('dbx_business_glossary_term' = 'Case Open Date');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `case_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Case Reference Number');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `case_reference_number` SET TAGS ('dbx_value_regex' = '^DC-[0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `case_severity` SET TAGS ('dbx_business_glossary_term' = 'Case Severity Level');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `case_severity` SET TAGS ('dbx_value_regex' = 'verbal_warning|written_warning|final_written_warning|suspension|dismissal|no_action');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|hearing_scheduled|outcome_issued|appealed|closed');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'misconduct|performance|attendance|policy_violation|harassment|grievance');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|high|executive');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `employee_representative_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Representative Present Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `evidence_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Evidence Attachment Count');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `hearing_location` SET TAGS ('dbx_business_glossary_term' = 'Hearing Location');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `improvement_plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Improvement Plan End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `improvement_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Improvement Plan Required Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `incident_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Outcome Date');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Outcome Description');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `outcome_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `outcome_type` SET TAGS ('dbx_business_glossary_term' = 'Outcome Type');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `outcome_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Policy Reference');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `previous_case_count` SET TAGS ('dbx_business_glossary_term' = 'Previous Case Count');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `suspension_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspension Paid Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `union_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Notified Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `warning_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warning Expiry Date');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `telecommunication_ecm`.`people`.`disciplinary_case` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan ID');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit ID');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `primary_headcount_submitted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `primary_headcount_submitted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `primary_headcount_submitted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `revised_headcount_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `approved_headcount` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `attrition_assumption_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attrition Assumption Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `budget_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `budget_approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^CC[0-9]{6}$');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `current_filled_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Filled Headcount');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `current_vacant_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Vacant Headcount');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `estimated_annual_cost_per_head` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Cost Per Head');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `estimated_annual_cost_per_head` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `headcount_type` SET TAGS ('dbx_business_glossary_term' = 'Headcount Type');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `headcount_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed_term|contractor|intern|temporary');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `net_new_headcount_requested` SET TAGS ('dbx_business_glossary_term' = 'Net New Headcount Requested');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `plan_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `plan_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Expiry Date');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Number');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^HCP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `planned_headcount` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `planning_cycle_reference` SET TAGS ('dbx_business_glossary_term' = 'Planning Cycle ID');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `planning_notes` SET TAGS ('dbx_business_glossary_term' = 'Planning Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `planning_quarter` SET TAGS ('dbx_business_glossary_term' = 'Planning Quarter');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `planning_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `planning_year` SET TAGS ('dbx_business_glossary_term' = 'Planning Year');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `total_estimated_annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Annual Cost');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `total_estimated_annual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`people`.`headcount_plan` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `primary_recruitment_hiring_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `primary_recruitment_hiring_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `primary_recruitment_hiring_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `quaternary_recruitment_replacement_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `quaternary_recruitment_replacement_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `quaternary_recruitment_replacement_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `reposted_from_recruitment_requisition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `budget_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Reference');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `diversity_hiring_initiative_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversity Hiring Initiative Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|intern|seasonal');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `internal_posting_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Posting Only Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Justification');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `number_of_openings` SET TAGS ('dbx_business_glossary_term' = 'Number of Openings');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `posting_end_date` SET TAGS ('dbx_business_glossary_term' = 'Posting End Date');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `posting_start_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `remote_work_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `requisition_close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `requisition_notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'backfill|new_headcount|replacement|internal_transfer|contractor_conversion|reorg');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `security_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `sourcing_channels` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channels');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `time_to_fill_target_days` SET TAGS ('dbx_business_glossary_term' = 'Time-to-Fill Target Days');
ALTER TABLE `telecommunication_ecm`.`people`.`recruitment_requisition` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `applicant_interviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Interviewer Employee Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `applicant_interviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `applicant_interviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `applicant_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `applicant_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `applicant_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `applicant_referral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Employee Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `applicant_referral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `applicant_referral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `referral_applicant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `applicant_type` SET TAGS ('dbx_business_glossary_term' = 'Applicant Type');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `applicant_type` SET TAGS ('dbx_value_regex' = 'internal|external|contractor_conversion|rehire|referral|campus');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^APP-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|cleared|flagged');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer Name');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `current_job_title` SET TAGS ('dbx_business_glossary_term' = 'Current Job Title');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Applicant Email Address');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant First Name');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Date');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Last Name');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Middle Name');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Applicant Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Offer Compensation Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `offer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `offer_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `offer_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Applicant Phone Number');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `position_applied_for` SET TAGS ('dbx_business_glossary_term' = 'Position Applied For');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `preferred_work_location` SET TAGS ('dbx_business_glossary_term' = 'Preferred Work Location');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `resume_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Resume Document Reference');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `screening_score` SET TAGS ('dbx_business_glossary_term' = 'Screening Score');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Application Source Channel');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`applicant` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Total Years of Professional Experience');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interview_event_id` SET TAGS ('dbx_business_glossary_term' = 'Interview Event ID');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Interviewer Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `quaternary_interview_coordinator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Interview Coordinator Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `quaternary_interview_coordinator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `quaternary_interview_coordinator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition ID');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `rescheduled_from_interview_event_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled From Interview Event ID');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `tertiary_interviewer_3_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Third Interviewer Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `tertiary_interviewer_3_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `tertiary_interviewer_3_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `tertiary_quinary_interviewer_5_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Fifth Interviewer Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `tertiary_quinary_interviewer_5_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `tertiary_quinary_interviewer_5_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `average_interviewer_score` SET TAGS ('dbx_business_glossary_term' = 'Average Interviewer Score');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Interview Cancellation Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `communication_skills_rating` SET TAGS ('dbx_business_glossary_term' = 'Communication Skills Rating');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `communication_skills_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `concerns_summary` SET TAGS ('dbx_business_glossary_term' = 'Candidate Concerns Summary');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `concerns_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `cultural_fit_rating` SET TAGS ('dbx_business_glossary_term' = 'Cultural Fit Rating');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `cultural_fit_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interview Duration Minutes');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `feedback_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Feedback Submitted Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interview_location` SET TAGS ('dbx_business_glossary_term' = 'Interview Location');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interview_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interview_location_type` SET TAGS ('dbx_business_glossary_term' = 'Interview Location Type');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interview_location_type` SET TAGS ('dbx_value_regex' = 'on_site|video_conference|phone|off_site');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interview_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Interview Reference Number');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interview_round_number` SET TAGS ('dbx_business_glossary_term' = 'Interview Round Number');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interview_status` SET TAGS ('dbx_business_glossary_term' = 'Interview Status');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interview_type` SET TAGS ('dbx_business_glossary_term' = 'Interview Type');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interviewer_2_score` SET TAGS ('dbx_business_glossary_term' = 'Second Interviewer Score');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interviewer_3_score` SET TAGS ('dbx_business_glossary_term' = 'Third Interviewer Score');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interviewer_4_score` SET TAGS ('dbx_business_glossary_term' = 'Fourth Interviewer Score');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `interviewer_5_score` SET TAGS ('dbx_business_glossary_term' = 'Fifth Interviewer Score');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `next_step_action` SET TAGS ('dbx_business_glossary_term' = 'Next Step Action');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `no_show_party` SET TAGS ('dbx_business_glossary_term' = 'No-Show Party');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `no_show_party` SET TAGS ('dbx_value_regex' = 'candidate|interviewer|both|none');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `outcome_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Outcome Decision Date');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `overall_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Overall Interviewer Recommendation');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `overall_recommendation` SET TAGS ('dbx_value_regex' = 'proceed|strong_proceed|hold|reject|strong_reject');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `primary_interviewer_score` SET TAGS ('dbx_business_glossary_term' = 'Primary Interviewer Score');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Candidate Strengths Summary');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `structured_feedback_notes` SET TAGS ('dbx_business_glossary_term' = 'Structured Feedback Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `structured_feedback_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `technical_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Competency Rating');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `technical_competency_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `video_meeting_link` SET TAGS ('dbx_business_glossary_term' = 'Video Meeting Link');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `video_meeting_link` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`interview_event` ALTER COLUMN `video_platform` SET TAGS ('dbx_business_glossary_term' = 'Video Conference Platform');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `offer_letter_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Letter Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Proposed Organizational Unit Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Proposed Position Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `tertiary_offer_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Approved By Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `tertiary_offer_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `tertiary_offer_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `superseded_offer_letter_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Acceptance Date');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `annual_leave_days` SET TAGS ('dbx_business_glossary_term' = 'Annual Leave Days Entitlement');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Approval Date');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `background_check_cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Clearance Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `background_check_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `background_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Offered Base Salary Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `decline_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Decline Date');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Offer Decline Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Offer Letter Document Reference');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Proposed Employment Type');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|intern');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `equity_grant_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Eligibility Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `job_grade` SET TAGS ('dbx_business_glossary_term' = 'Proposed Job Grade');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Offer Letter Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Duration in Days');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `offer_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Expiration Date');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `offer_number` SET TAGS ('dbx_business_glossary_term' = 'Offer Letter Number');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `offer_number` SET TAGS ('dbx_value_regex' = '^OFR-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Letter Status');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'draft|extended|accepted|declined|rescinded|expired');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Salary Pay Frequency');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi_weekly|weekly|annual');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `probation_period_days` SET TAGS ('dbx_business_glossary_term' = 'Probation Period Duration in Days');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `proposed_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Employment Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `relocation_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Relocation Allowance Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `relocation_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `remote_work_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligibility Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `rescind_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Rescind Date');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `rescind_reason` SET TAGS ('dbx_business_glossary_term' = 'Offer Rescind Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `sign_on_bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Sign-On Bonus Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `sign_on_bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Annual Bonus Percentage');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`offer_letter` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Proposed Work Location Code');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `onboarding_task_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Task Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `onboarding_program_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Program Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `primary_onboarding_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `primary_onboarding_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `primary_onboarding_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `quaternary_onboarding_escalated_to_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated To Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `quaternary_onboarding_escalated_to_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `quaternary_onboarding_escalated_to_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `quinary_onboarding_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `quinary_onboarding_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `quinary_onboarding_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `tertiary_onboarding_waived_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Waived By Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `tertiary_onboarding_waived_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `tertiary_onboarding_waived_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `prerequisite_onboarding_task_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Hours');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `completion_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Completion Evidence Reference');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `is_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Is Compliance Required Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `last_reminder_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `reminder_sent_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Sent Count');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `system_reference_code` SET TAGS ('dbx_business_glossary_term' = 'System Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `task_category` SET TAGS ('dbx_business_glossary_term' = 'Task Category');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `task_category` SET TAGS ('dbx_value_regex' = 'it_setup|access_provisioning|equipment_issuance|policy_acknowledgment|compliance_training|benefits_enrollment');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Task Name');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Task Number');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `task_owner_type` SET TAGS ('dbx_business_glossary_term' = 'Task Owner Type');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `task_owner_type` SET TAGS ('dbx_value_regex' = 'hr|it|manager|employee_self_service|facilities|security');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|waived|blocked');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `waiver_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waiver Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_task` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `separation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Separation Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Separation Initiated By Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `tertiary_separation_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Separation Approved By Employee Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `tertiary_separation_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `tertiary_separation_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `rehire_of_separation_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `access_revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Access Revocation Date');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Separation Comments');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `equipment_return_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Return Date');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `equipment_return_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Return Status');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `equipment_return_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|partial|complete|overdue');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `exit_interview_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Conducted Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `exit_interview_date` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Date');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `exit_interview_key_themes` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Key Themes');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `exit_interview_sentiment` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Sentiment');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `exit_interview_sentiment` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|not_applicable');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `final_settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Currency Code');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `final_settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `final_settlement_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Payment Date');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `knowledge_transfer_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Transfer Completed Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `last_working_day` SET TAGS ('dbx_business_glossary_term' = 'Last Working Day');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `notice_period_served_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Served Days');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `notice_period_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Waived Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `notice_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Notice Waiver Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `offboarding_checklist_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Checklist Completed Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `offboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Offboarding Completion Date');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `regrettable_loss_flag` SET TAGS ('dbx_business_glossary_term' = 'Regrettable Loss Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `rehire_eligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `rehire_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `resignation_letter_received_date` SET TAGS ('dbx_business_glossary_term' = 'Resignation Letter Received Date');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `separation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Separation Effective Date');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `separation_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Separation Initiation Date');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `separation_number` SET TAGS ('dbx_business_glossary_term' = 'Separation Reference Number');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `separation_number` SET TAGS ('dbx_value_regex' = '^SEP-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `separation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Separation Reason Code');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `separation_status` SET TAGS ('dbx_business_glossary_term' = 'Separation Status');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `separation_status` SET TAGS ('dbx_value_regex' = 'initiated|pending_approval|approved|in_progress|completed|cancelled');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `separation_type` SET TAGS ('dbx_business_glossary_term' = 'Separation Type');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `separation_type` SET TAGS ('dbx_value_regex' = 'resignation|termination|retirement|redundancy|end_of_contract|death_in_service');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `severance_amount` SET TAGS ('dbx_business_glossary_term' = 'Severance Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `severance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `tenure_years` SET TAGS ('dbx_business_glossary_term' = 'Tenure Years');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `unused_leave_days` SET TAGS ('dbx_business_glossary_term' = 'Unused Leave Days');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `unused_leave_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Unused Leave Payout Amount');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `unused_leave_payout_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `voluntary_flag` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Separation Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`separation_event` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `workforce_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Policy ID');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Legal Entity ID');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `primary_workforce_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `primary_workforce_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `primary_workforce_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `superseded_policy_workforce_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Policy ID');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `superseded_workforce_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `acknowledgment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Frequency');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `acknowledgment_frequency` SET TAGS ('dbx_value_regex' = 'once|annual|on_change|quarterly|biannual');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `applicable_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Applicable Business Unit');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `applicable_employee_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Employee Type');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `applicable_employee_type` SET TAGS ('dbx_value_regex' = 'all|full_time|part_time|contractor|temporary|intern');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `applicable_geography` SET TAGS ('dbx_business_glossary_term' = 'Applicable Geography');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `applicable_geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `communication_method` SET TAGS ('dbx_business_glossary_term' = 'Communication Method');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `communication_method` SET TAGS ('dbx_value_regex' = 'email|intranet|town_hall|manager_cascade|training_session|all_hands');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `exception_process_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Process Description');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `mandatory_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Acknowledgment Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_value_regex' = 'leave_policy|code_of_conduct|anti_harassment|data_privacy|byod|remote_work');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_document_url` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_language` SET TAGS ('dbx_business_glossary_term' = 'Policy Language');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Department');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_priority` SET TAGS ('dbx_business_glossary_term' = 'Policy Priority');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|superseded|retired|suspended');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_title` SET TAGS ('dbx_business_glossary_term' = 'Policy Title');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `related_policy_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Policy IDs');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `training_course_code` SET TAGS ('dbx_business_glossary_term' = 'Training Course Code');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`workforce_policy` ALTER COLUMN `violation_consequence` SET TAGS ('dbx_business_glossary_term' = 'Violation Consequence');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `policy_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Acknowledgment ID');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `primary_policy_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `quaternary_policy_revoked_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Revoked By Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `quaternary_policy_revoked_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `quaternary_policy_revoked_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `tertiary_policy_witness_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Witness Employee ID');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `tertiary_policy_witness_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `tertiary_policy_witness_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `workforce_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Policy ID');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `superseded_policy_acknowledgment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_channel` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Channel');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_channel` SET TAGS ('dbx_value_regex' = 'hr_portal|email|paper|lms|mobile_app|kiosk');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_device_type` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Device Type');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_device_type` SET TAGS ('dbx_value_regex' = 'desktop|laptop|mobile|tablet|kiosk|unknown');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment IP Address');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_location` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Location');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Method');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_method` SET TAGS ('dbx_value_regex' = 'electronic_signature|checkbox|biometric|wet_signature|verbal|system_auto');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_number` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Reference Number');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|overdue|exempted|expired|revoked');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `attestation_text` SET TAGS ('dbx_business_glossary_term' = 'Attestation Text');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `compliance_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Code');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `digital_signature_hash` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Hash');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `digital_signature_hash` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `document_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Document Attachment Count');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Due Date');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `exemption_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exemption Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Exemption Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `last_reminder_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Sent Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Acknowledgment Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `next_acknowledgment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Acknowledgment Due Date');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `policy_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revocation Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `training_completion_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Flag');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `training_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Minutes');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `training_score` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `telecommunication_ecm`.`people`.`policy_acknowledgment` ALTER COLUMN `witness_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Witness Timestamp');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_program` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_program` ALTER COLUMN `onboarding_program_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Program Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_program` ALTER COLUMN `superseded_onboarding_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`onboarding_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`people`.`calibration_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`people`.`calibration_session` SET TAGS ('dbx_subdomain' = 'learning_development');
ALTER TABLE `telecommunication_ecm`.`people`.`calibration_session` ALTER COLUMN `calibration_session_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Session Identifier');
ALTER TABLE `telecommunication_ecm`.`people`.`calibration_session` ALTER COLUMN `prior_calibration_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
