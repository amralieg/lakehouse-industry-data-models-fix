-- Schema for Domain: workforce | Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`workforce` COMMENT 'Manages internal employee records, organizational hierarchy, job roles, compensation, licensing for internal staff (underwriters, actuaries, claims adjusters), training records, and workforce capacity planning for the insurance enterprise.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key for the employee entity. System-generated surrogate key used across all internal systems to reference this employee.',
    `job_role_id` BIGINT COMMENT 'Foreign key linking to workforce.job_role. Business justification: Employee records reference job_code and job_title (STRING) which should be normalized to job_role master. This enables consistent job classification, competency mapping, and career pathing. Removes re',
    `manager_employee_id` BIGINT COMMENT 'Employee ID of the direct manager or supervisor to whom this employee reports. Establishes reporting hierarchy for organizational structure and approval workflows.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the primary department or organizational unit to which the employee is assigned. Links to organizational hierarchy for reporting and cost allocation.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Employees occupy authorized positions (headcount slots). This links the employee master record to the position catalog, enabling position-based reporting, succession planning, and organizational struc',
    `annual_base_salary` DECIMAL(18,2) COMMENT 'Employees annual base salary in USD before bonuses, commissions, or other variable compensation. Used for payroll processing and compensation planning.',
    `background_check_date` DATE COMMENT 'Date the most recent background check was completed. Used to track compliance with periodic re-screening requirements.',
    `background_check_status` STRING COMMENT 'Status of the employees pre-employment or periodic background screening. Required for roles with fiduciary responsibility or regulatory oversight.. Valid values are `Pending|Cleared|Conditional|Failed|Not Required|Expired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `date_of_birth` DATE COMMENT 'Employees date of birth. Used for age verification, benefits eligibility, retirement planning, and compliance with age-related employment regulations.',
    `disability_status` STRING COMMENT 'Employees self-identified disability status for Section 503 reporting (federal contractors) and ADA compliance. Collection is voluntary and confidential.. Valid values are `Yes|No|Prefer Not to Disclose`',
    `eeo_category` STRING COMMENT 'EEO-1 job category classification for federal equal employment opportunity reporting. Required for organizations with 100+ employees or federal contractors. [ENUM-REF-CANDIDATE: Executive|Manager|Professional|Technician|Sales|Administrative|Craft|Operative|Laborer|Service — 10 candidates stripped; promote to reference product]',
    `email_address` STRING COMMENT 'Primary corporate email address assigned to the employee. Used for business communication, system access, and identity management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employee_number` STRING COMMENT 'Business-facing unique employee identifier assigned at hire. Human-readable identifier used on badges, timesheets, and HR documents. Distinct from system surrogate key.. Valid values are `^[A-Z0-9]{6,12}$`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employees relationship with the organization. Drives access rights, payroll processing, and benefits eligibility.. Valid values are `Active|On Leave|Terminated|Retired|Deceased|Suspended`',
    `employment_type` STRING COMMENT 'Classification of the employees work arrangement. Determines benefits eligibility, overtime rules, and regulatory reporting requirements.. Valid values are `Full-Time|Part-Time|Contractor|Temporary|Intern|Seasonal`',
    `ethnicity` STRING COMMENT 'Employees self-identified ethnicity for EEO reporting and diversity analytics. Collection is voluntary per EEOC guidelines. [ENUM-REF-CANDIDATE: Hispanic or Latino|Not Hispanic or Latino|Prefer Not to Disclose|American Indian or Alaska Native|Asian|Black or African American|Native Hawaiian or Other Pacific Islander|White|Two or More Races — promote to reference product]',
    `first_name` STRING COMMENT 'Legal first name (given name) of the employee as it appears on government-issued identification and payroll records.',
    `flsa_status` STRING COMMENT 'Classification under the Fair Labor Standards Act determining overtime eligibility. Exempt employees are salaried and not eligible for overtime; non-exempt employees are eligible for overtime pay.. Valid values are `Exempt|Non-Exempt`',
    `gender` STRING COMMENT 'Employees self-identified gender. Used for Equal Employment Opportunity (EEO) reporting and diversity analytics. Collection is voluntary per EEOC guidelines.. Valid values are `Male|Female|Non-Binary|Prefer Not to Disclose`',
    `hire_date` DATE COMMENT 'Date the employee was originally hired by the organization. Used to calculate tenure, benefits eligibility, vesting schedules, and seniority.',
    `home_address_line1` STRING COMMENT 'Primary street address line for the employees residential address. Used for payroll tax withholding, benefits delivery, and emergency contact.',
    `home_address_line2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number. May be null if not applicable.',
    `home_city` STRING COMMENT 'City or municipality of the employees residential address.',
    `home_country` STRING COMMENT 'Three-letter ISO country code for the employees residential address. Used for international tax compliance and expatriate management.. Valid values are `^[A-Z]{3}$`',
    `home_postal_code` STRING COMMENT 'ZIP or postal code for the employees residential address. Used for tax withholding and benefits administration.. Valid values are `^d{5}(-d{4})?$`',
    `home_state` STRING COMMENT 'Two-letter state or province code for the employees residential address. Critical for state income tax withholding and compliance.. Valid values are `^[A-Z]{2}$`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Hourly wage rate for non-exempt employees. Null for salaried exempt employees. Used for timesheet processing and overtime calculation.',
    `hr_system_code` STRING COMMENT 'Unique identifier for this employee in the source HR system of record (e.g., Workday, SAP SuccessFactors, Oracle HCM). Used for system integration and data lineage.. Valid values are `^[A-Z0-9-]{10,36}$`',
    `i9_verification_date` DATE COMMENT 'Date the employees I-9 Employment Eligibility Verification form was completed. Required within 3 business days of hire per USCIS regulations.',
    `last_name` STRING COMMENT 'Legal last name (surname/family name) of the employee as it appears on government-issued identification and payroll records.',
    `middle_name` STRING COMMENT 'Legal middle name or middle initial of the employee. May be null if employee has no middle name.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to the employees position. Defines salary range and eligibility for incentive programs. Confidential business data.. Valid values are `^[A-Z0-9]{2,6}$`',
    `personal_phone_number` STRING COMMENT 'Employees personal mobile or home phone number for emergency contact and critical business communication outside normal hours.',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in day-to-day business interactions. May differ from legal name. Used in email signatures, business cards, and internal communications.',
    `ssn` STRING COMMENT 'United States Social Security Number for tax reporting, benefits administration, and legal identification. Required for all US-based employees.. Valid values are `^d{3}-d{2}-d{4}$`',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Null for active employees. Used for final payroll, benefits termination, and compliance reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last modified in the data platform. Used for change tracking and incremental data processing.',
    `veteran_status` STRING COMMENT 'Employees veteran status for VETS-4212 reporting (federal contractors). Collection is voluntary. [ENUM-REF-CANDIDATE: Protected Veteran|Not a Protected Veteran|Prefer Not to Disclose|Armed Forces Service Medal Veteran|Disabled Veteran|Recently Separated Veteran|Active Duty Wartime or Campaign Badge Veteran|Other Protected Veteran — promote to reference product]',
    `work_authorization_status` STRING COMMENT 'Employees current work authorization status in the United States. Critical for I-9 compliance and employment eligibility verification.. Valid values are `US Citizen|Permanent Resident|Work Visa|EAD|Pending|Expired`',
    `work_location_id` BIGINT COMMENT 'Identifier of the primary physical or virtual work location where the employee is based. Used for facilities management, tax withholding, and workforce analytics.',
    `work_phone_number` STRING COMMENT 'Primary business phone number (desk phone or mobile) assigned to the employee for work-related communication.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for every internal employee of the Life Insurance enterprise — underwriters, actuaries, claims adjusters, agents, IT staff, and all other personnel. Captures legal name, employee ID, date of birth, hire date, termination date, employment status (active, on-leave, terminated), employment type (full-time, part-time, contractor), home department, primary work location, EEO classification, FLSA status, and HR system identifier. SSOT for internal workforce identity — distinct from the agent.producer domain which owns external distribution channel participants.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the authorized position (headcount slot) within the Life Insurance enterprise.',
    `template_id` BIGINT COMMENT 'Reference to the standardized job posting template used for recruiting candidates for this position.',
    `job_role_id` BIGINT COMMENT 'Foreign key linking to workforce.job_role. Business justification: Positions are instances of job roles. A position (headcount slot) is defined by its job_role classification. This links position master to job_role catalog, enabling role-based position management, co',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or organizational unit to which this position is assigned.',
    `reports_to_position_id` BIGINT COMMENT 'Reference to the supervisory position to which this position reports, establishing the organizational hierarchy.',
    `bonus_target_percentage` DECIMAL(18,2) COMMENT 'Target annual bonus as a percentage of base salary for positions eligible for incentive compensation.',
    `budget_year` STRING COMMENT 'Fiscal year for which this position is authorized and budgeted, supporting annual workforce planning cycles.',
    `cost_center_code` STRING COMMENT 'Financial accounting code used to track salary and benefit expenses for this position in the general ledger.. Valid values are `^[0-9]{4,8}$`',
    `created_date` DATE COMMENT 'Date when the position was first established and authorized in the organizational structure.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the position record was first created in the HR system.',
    `effective_date` DATE COMMENT 'Date when the position becomes active and available for recruitment or assignment.',
    `eligible_for_bonus` BOOLEAN COMMENT 'Indicates whether the position is eligible for annual performance-based bonus or incentive compensation.',
    `end_date` DATE COMMENT 'Date when the position was or will be eliminated or frozen, null for active ongoing positions.',
    `flsa_classification` STRING COMMENT 'Classification under the Fair Labor Standards Act determining overtime eligibility and wage requirements.. Valid values are `exempt|non_exempt`',
    `fte_count` DECIMAL(18,2) COMMENT 'Authorized full-time equivalent headcount for this position, supporting fractional allocations for part-time or shared roles.',
    `is_critical_role` BOOLEAN COMMENT 'Indicates whether the position is designated as business-critical, requiring succession planning and priority recruitment.',
    `last_modified_by` STRING COMMENT 'User identifier of the HR professional or system administrator who last updated the position record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the position record was last updated in the HR system.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for the position, used for candidate screening and job posting requirements.. Valid values are `high_school|associate|bachelor|master|doctorate|professional`',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for the position.',
    `position_code` STRING COMMENT 'Business-assigned unique code for the position, used for budgeting and workforce planning references.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_description` STRING COMMENT 'Detailed narrative description of the positions responsibilities, duties, and key accountabilities.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position indicating whether it is actively recruiting, occupied, temporarily frozen, or permanently eliminated.. Valid values are `open|filled|frozen|eliminated|pending_approval`',
    `primary_work_location_code` BIGINT COMMENT 'Reference to the primary office or facility where the position is based, used for space planning and regional reporting.',
    `requires_actuarial_credential` BOOLEAN COMMENT 'Indicates whether the position requires professional actuarial credentials such as Associate of the Society of Actuaries (ASA), Fellow of the Society of Actuaries (FSA), or equivalent.',
    `requires_finra_registration` BOOLEAN COMMENT 'Indicates whether the position requires FINRA registration (e.g., Series 6, Series 7) for selling variable insurance products.',
    `requires_insurance_license` BOOLEAN COMMENT 'Indicates whether the position requires the incumbent to hold a valid state insurance license to perform job duties.',
    `salary_grade` STRING COMMENT 'Compensation grade or band assigned to the position, determining the salary range and eligibility for incentive programs.. Valid values are `^[A-Z0-9]{2,6}$`',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'Maximum annual base salary for the position in US dollars, defining the upper bound of the compensation band.',
    `salary_range_midpoint` DECIMAL(18,2) COMMENT 'Midpoint annual base salary for the position in US dollars, representing the target compensation for fully competent performance.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'Minimum annual base salary for the position in US dollars, defining the lower bound of the compensation band.',
    `span_of_control` STRING COMMENT 'Number of direct reports authorized for this position, used for organizational design and management capacity planning.',
    `succession_plan_exists` BOOLEAN COMMENT 'Indicates whether a formal succession plan has been documented for this position to ensure business continuity.',
    `title` STRING COMMENT 'Official job title for the position as it appears in organizational charts and job postings.',
    `travel_requirement_percentage` DECIMAL(18,2) COMMENT 'Expected percentage of work time requiring business travel, used for candidate expectations and expense budgeting.',
    `work_location_type` STRING COMMENT 'Designated work arrangement for the position indicating whether it is office-based, hybrid, or fully remote.. Valid values are `on_site|hybrid|remote`',
    `created_by` STRING COMMENT 'User identifier of the HR professional or system administrator who created the position record.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Master catalog of all authorized positions (headcount slots) within the Life Insurance enterprise. Captures position code, position title, job family, job level, FLSA classification, FTE count authorized, department, cost center, position status (open, filled, frozen, eliminated), and whether the position requires an insurance license or actuarial credential. Supports workforce capacity planning and headcount budgeting distinct from the individual employee record.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`job_role` (
    `job_role_id` BIGINT COMMENT 'Unique identifier for the job role. Primary key for the job role reference catalog.',
    `parent_job_role_id` BIGINT COMMENT 'Self-referencing FK on job_role (parent_job_role_id)',
    `background_check_level` STRING COMMENT 'Level of pre-employment background screening required for the role based on access to sensitive data, financial authority, or regulatory requirements.. Valid values are `none|basic|standard|enhanced|financial_services`',
    `continuing_education_hours` STRING COMMENT 'Annual or biennial continuing education hours required to maintain licenses and designations for the role. Null if no CE requirement.',
    `core_competencies` STRING COMMENT 'Comma-separated list of essential skills and competencies required for successful role performance (e.g., risk assessment, financial analysis, regulatory compliance, customer service, data analytics).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the job role record was first created in the system. Used for audit trail and data lineage.',
    `eeo_category` STRING COMMENT 'EEO-1 job category classification for the role. Required for federal EEO-1 reporting to the Equal Employment Opportunity Commission (EEOC). [ENUM-REF-CANDIDATE: executive_senior_level_officials_and_managers|first_mid_level_officials_and_managers|professionals|technicians|sales_workers|administrative_support_workers|craft_workers|operatives|laborers_and_helpers|service_workers — 10 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date when the job role definition became or will become effective for use in the organization.',
    `employment_type` STRING COMMENT 'Standard employment classification for the role indicating full-time, part-time, contract, or other employment arrangement.. Valid values are `full_time|part_time|contract|temporary|seasonal|intern`',
    `end_date` DATE COMMENT 'Date when the job role definition is no longer effective. Null for currently active roles with no planned end date.',
    `fiduciary_role` BOOLEAN COMMENT 'Indicates whether the role has fiduciary responsibilities under ERISA or state insurance fiduciary standards, requiring adherence to duty of care and loyalty standards.',
    `finra_registration_required` BOOLEAN COMMENT 'Indicates whether the role requires FINRA registration for selling variable life insurance or variable annuity products. Triggers Series 6, 7, or 63 licensing requirements.',
    `finra_series_required` STRING COMMENT 'Comma-separated list of FINRA series examinations required for the role (e.g., Series 6, Series 7, Series 63, Series 24). Applicable only when FINRA registration is required.',
    `flsa_classification` STRING COMMENT 'Classification under the Fair Labor Standards Act indicating whether the role is exempt or non-exempt from overtime pay requirements.. Valid values are `exempt|non_exempt`',
    `grade_band` STRING COMMENT 'Compensation grade band assigned to the role defining the salary range and benefits tier. Used for pay equity analysis and budgeting.. Valid values are `^[A-Z0-9]{1,5}$`',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles by function and skill set. Aligns with core business processes and organizational structure. [ENUM-REF-CANDIDATE: underwriting|actuarial|claims|finance|information_technology|operations|compliance|legal|human_resources|marketing|sales|customer_service|investment_management|product_development|risk_management|audit — 16 candidates stripped; promote to reference product]',
    `job_level` STRING COMMENT 'Hierarchical level of the role within the organization indicating seniority, scope of responsibility, and decision-making authority. [ENUM-REF-CANDIDATE: entry|intermediate|senior|lead|principal|manager|senior_manager|director|senior_director|vice_president|senior_vice_president|executive_vice_president|c_level — 13 candidates stripped; promote to reference product]',
    `job_sub_family` STRING COMMENT 'Specialized sub-category within the job family providing finer classification granularity (e.g., within actuarial: pricing, valuation, reserving).',
    `maximum_grade` STRING COMMENT 'Highest numeric grade level within the grade band for this role. Defines the ceiling for compensation progression.',
    `minimum_grade` STRING COMMENT 'Lowest numeric grade level within the grade band for this role. Defines the entry point for compensation.',
    `preferred_designations` STRING COMMENT 'Comma-separated list of professional designations or certifications preferred but not required for the role. Enhances candidate competitiveness.',
    `preferred_education_level` STRING COMMENT 'Preferred educational attainment for optimal role performance. May exceed minimum requirements.. Valid values are `high_school|associate|bachelor|master|doctorate|professional_degree`',
    `preferred_experience_years` STRING COMMENT 'Preferred number of years of relevant professional experience for optimal role performance.',
    `remote_eligible` BOOLEAN COMMENT 'Indicates whether the role is eligible for remote or hybrid work arrangements based on job requirements and organizational policy.',
    `required_designations` STRING COMMENT 'Comma-separated list of professional designations or certifications required for the role (e.g., FSA, MAAA, CPCU, CLU, ChFC, CFP, CFA, CPA). [ENUM-REF-CANDIDATE: promote to designation_type reference product for granular tracking]',
    `required_education_level` STRING COMMENT 'Minimum educational attainment required for the role. Used for candidate screening and workforce planning.. Valid values are `high_school|associate|bachelor|master|doctorate|professional_degree`',
    `required_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for the role.',
    `required_licenses` STRING COMMENT 'Comma-separated list of professional licenses or state insurance licenses required for the role (e.g., state insurance producer license for underwriters and agents). [ENUM-REF-CANDIDATE: promote to license_type reference product for granular tracking]',
    `role_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the job role across the enterprise. Used for position classification and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `role_description` STRING COMMENT 'Comprehensive description of the job role including primary responsibilities, scope of authority, and key deliverables.',
    `role_status` STRING COMMENT 'Current lifecycle status of the job role in the enterprise catalog. Active roles are available for position creation and employee assignment.. Valid values are `active|inactive|pending_approval|obsolete|under_review`',
    `role_title` STRING COMMENT 'Official job title for the role as used in position postings, organizational charts, and employee records.',
    `safety_sensitive` BOOLEAN COMMENT 'Indicates whether the role is classified as safety-sensitive, requiring drug and alcohol testing under Department of Transportation (DOT) or company policy.',
    `sec_registration_required` BOOLEAN COMMENT 'Indicates whether the role requires SEC registration as an investment adviser representative for managing variable product investments.',
    `soc_code` STRING COMMENT 'U.S. Bureau of Labor Statistics Standard Occupational Classification code for the role. Used for labor market analysis and regulatory reporting.. Valid values are `^[0-9]{2}-[0-9]{4}$`',
    `span_of_control_max` STRING COMMENT 'Maximum number of direct reports expected for this supervisory role. Null for non-supervisory roles.',
    `span_of_control_min` STRING COMMENT 'Minimum number of direct reports expected for this supervisory role. Null for non-supervisory roles.',
    `succession_criticality` STRING COMMENT 'Criticality rating for succession planning indicating the business impact of vacancy and urgency of maintaining a talent pipeline for the role.. Valid values are `low|medium|high|critical`',
    `supervisory_role` BOOLEAN COMMENT 'Indicates whether the role has direct supervisory or management responsibility for other employees.',
    `technical_skills` STRING COMMENT 'Comma-separated list of technical skills and tools required for the role (e.g., SQL, Python, Excel, actuarial software, policy administration systems).',
    `travel_requirement_pct` DECIMAL(18,2) COMMENT 'Expected percentage of work time requiring business travel. Used for role planning and candidate expectations.',
    `updated_by` STRING COMMENT 'User identifier or system account that last modified the job role record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the job role record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_job_role PRIMARY KEY(`job_role_id`)
) COMMENT 'Reference catalog of all job roles and job families used across the Life Insurance enterprise. Defines role code, role title, job family (underwriting, actuarial, claims, finance, IT, operations, compliance), job level band, minimum and maximum grade, required competencies, required licenses or designations (FSA, MAAA, CPCU, CLU, ChFC), and whether the role is subject to FINRA registration requirements for variable product sales. Provides the classification taxonomy for position and employee assignment.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit within the Life Insurance enterprise hierarchy.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the owning legal entity for statutory reporting and regulatory compliance purposes.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy, enabling multi-level organizational structure traversal for reporting and workforce planning.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Annual operating budget allocated to this organizational unit in USD for expense planning and financial management.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO currency code for the annual budget amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system.',
    `current_headcount` STRING COMMENT 'Current number of employees assigned to this organizational unit.',
    `effective_date` DATE COMMENT 'Date when this organizational unit became active or when the current configuration became effective.',
    `email_address` STRING COMMENT 'Primary business email address for this organizational unit.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `end_date` DATE COMMENT 'Date when this organizational unit was dissolved, merged, or otherwise became inactive. Null for active units.',
    `functional_area` STRING COMMENT 'Primary functional area or business domain that this organizational unit supports within the Life Insurance enterprise. [ENUM-REF-CANDIDATE: underwriting|claims|actuarial|sales|distribution|operations|finance|compliance|technology|human_resources — 10 candidates stripped; promote to reference product]',
    `geographic_region` STRING COMMENT 'Geographic region or territory served by this organizational unit (e.g., Northeast, Southeast, Midwest, West, National).',
    `headcount_capacity` STRING COMMENT 'Authorized headcount capacity for this organizational unit, used for workforce capacity planning and budgeting.',
    `hierarchy_level` STRING COMMENT 'Numeric level of this organizational unit within the enterprise hierarchy (1=top level, increasing for each level down).',
    `hierarchy_path` STRING COMMENT 'Full hierarchical path from root to this organizational unit, typically represented as slash-separated org unit codes for efficient hierarchy queries.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified.',
    `location_address_line1` STRING COMMENT 'Primary street address line for the physical location of this organizational unit.',
    `location_address_line2` STRING COMMENT 'Secondary address line (suite, floor, building) for the physical location of this organizational unit.',
    `location_city` STRING COMMENT 'City where this organizational unit is physically located.',
    `location_country_code` STRING COMMENT 'Three-letter ISO country code for the physical location of this organizational unit.. Valid values are `^[A-Z]{3}$`',
    `location_postal_code` STRING COMMENT 'ZIP or postal code for the physical location of this organizational unit.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `location_state` STRING COMMENT 'Two-letter state code where this organizational unit is physically located.. Valid values are `^[A-Z]{2}$`',
    `mission_statement` STRING COMMENT 'Mission statement or charter defining the strategic purpose and objectives of this organizational unit.',
    `org_unit_code` STRING COMMENT 'Business identifier code for the organizational unit, used in financial reporting and expense allocation systems.. Valid values are `^[A-Z0-9]{3,10}$`',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units purpose, responsibilities, and scope within the Life Insurance enterprise.',
    `org_unit_name` STRING COMMENT 'Full business name of the organizational unit (e.g., Individual Life Underwriting, Claims Operations, Actuarial Valuation).',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit within the enterprise hierarchy.. Valid values are `active|inactive|pending|suspended|dissolved|merged`',
    `org_unit_type` STRING COMMENT 'Classification of the organizational unit within the enterprise hierarchy structure.. Valid values are `division|department|team|cost_center|business_unit|branch`',
    `phone_number` STRING COMMENT 'Primary business phone number for this organizational unit.',
    `profit_center_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit is designated as a profit center (True) or cost center (False) for financial reporting purposes.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit is subject to direct regulatory reporting requirements (True/False).',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Master record for every organizational unit (department, division, business unit, team) within the Life Insurance enterprise hierarchy. Captures org unit code, org unit name, org unit type (division, department, team, cost center), parent org unit for hierarchy traversal, effective date, end date, owning legal entity, and assigned cost center. Supports multi-level organizational hierarchy modeling for reporting, expense allocation, and workforce capacity planning.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`employment_record` (
    `employment_record_id` BIGINT COMMENT 'Unique identifier for each employment event record in an employees lifecycle. Primary key for the employment record table.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or authority who approved this employment action. May be a senior manager, HR director, or executive depending on the event type and organizational policy. Required for compliance and audit purposes.',
    `primary_employment_employee_id` BIGINT COMMENT 'Reference to the employee who is the subject of this employment event. Links to the employee master record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, branch) where the employee was assigned before this event. Null for initial hire. Enables organizational movement tracking and workforce planning.',
    `position_id` BIGINT COMMENT 'Reference to the employees position before this employment event. Null for initial hire events. Used to track career progression and organizational movement.',
    `quaternary_employment_new_supervisor_employee_id` BIGINT COMMENT 'Reference to the employees direct supervisor or manager after this event. Null for termination. Critical for organizational hierarchy and management reporting.',
    `tertiary_employment_prior_supervisor_employee_id` BIGINT COMMENT 'Reference to the employees direct supervisor or manager before this event. Null for initial hire. Enables organizational hierarchy tracking and reporting line analysis.',
    `prior_employment_record_id` BIGINT COMMENT 'Self-referencing FK on employment_record (prior_employment_record_id)',
    `approval_date` DATE COMMENT 'The date on which this employment action was formally approved by the designated authority. Used for audit trail and compliance verification. May differ from the effective date.',
    `benefits_change_flag` BOOLEAN COMMENT 'Indicates whether this employment event triggers a change in the employees benefits eligibility or enrollment. True if benefits package changed due to employment type, status, or organizational policy; false otherwise. Used to trigger benefits administration workflows.',
    `comments` STRING COMMENT 'Free-text field for additional notes, context, or special circumstances related to this employment event. Used by HR administrators to document non-standard situations, approvals, or business justifications.',
    `compensation_change_flag` BOOLEAN COMMENT 'Indicates whether this employment event includes a change in the employees base compensation. True if salary or hourly rate changed; false otherwise. Used to trigger compensation record updates and payroll adjustments.',
    `effective_date` DATE COMMENT 'The date on which this employment event becomes effective and the employees status, position, or organizational assignment changes. This is the business-effective date, not the system record date.',
    `event_type` STRING COMMENT 'The type of employment action or event being recorded: hire (initial employment), rehire (return after previous termination), transfer (lateral move), promotion (upward movement), demotion (downward movement), leave of absence (temporary separation), return from leave (resumption after leave), or termination (end of employment). [ENUM-REF-CANDIDATE: hire|rehire|transfer|promotion|demotion|leave_of_absence|return_from_leave|termination — 8 candidates stripped; promote to reference product]',
    `last_working_date` DATE COMMENT 'The final date on which the employee physically worked or was on active duty. Populated for termination and leave_of_absence events. May differ from the effective date if there is a notice period or transition period. Used for payroll cutoff and benefits termination.',
    `leave_expected_return_date` DATE COMMENT 'The anticipated date on which the employee is expected to return from leave. Populated for leave_of_absence events. May be updated if leave is extended. Used for workforce capacity planning.',
    `leave_start_date` DATE COMMENT 'The date on which a leave of absence begins. Populated only for leave_of_absence event types. Used to track leave duration and return-to-work planning.',
    `leave_type` STRING COMMENT 'The category of leave being taken. Populated for leave_of_absence events. Values include medical (health-related), parental (maternity/paternity), personal (unpaid personal leave), military (service obligation), disability (short-term or long-term disability), or sabbatical (extended professional development leave). Required for compliance with FMLA and state leave laws.. Valid values are `medical|parental|personal|military|disability|sabbatical`',
    `licensing_impact_flag` BOOLEAN COMMENT 'Indicates whether this employment event impacts the employees professional licensing requirements or status. True if the new position requires different licenses (e.g., moving from underwriting to agent role) or if termination requires license surrender; false otherwise. Critical for insurance industry compliance with state Department of Insurance regulations.',
    `new_employment_status` STRING COMMENT 'The employees employment status after this event. Reflects the current state resulting from this employment action.. Valid values are `active|on_leave|suspended|terminated`',
    `new_employment_type` STRING COMMENT 'The employees employment type classification after this event. Used for benefits eligibility, compensation calculations, and regulatory reporting.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `new_job_grade` STRING COMMENT 'The employees job grade or level after this employment event. Null for termination. Used to track career progression and compensation changes.',
    `new_work_location_code` BIGINT COMMENT 'Reference to the physical work location (office, branch, home office) where the employee is based after this event. Null for termination. Used for workspace allocation and geographic reporting.',
    `notice_period_days` STRING COMMENT 'The number of days of notice provided for this employment event. Commonly used for voluntary resignations and some terminations. Null if no notice period applies. Used for transition planning and compliance with employment contracts.',
    `prior_employment_status` STRING COMMENT 'The employees employment status before this event. Null for initial hire. Values include active (working), on_leave (temporary absence), suspended (disciplinary or administrative hold), or terminated (employment ended).. Valid values are `active|on_leave|suspended|terminated`',
    `prior_employment_type` STRING COMMENT 'The employees employment type classification before this event. Null for initial hire. Distinguishes between full-time, part-time, contractor, temporary, and intern classifications for benefits and compliance purposes.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `prior_job_grade` STRING COMMENT 'The employees job grade or level before this employment event. Null for initial hire. Job grades typically represent compensation bands and organizational hierarchy levels (e.g., G1, G2, M1, E1).',
    `prior_work_location_code` BIGINT COMMENT 'Reference to the physical work location (office, branch, home office) where the employee was based before this event. Null for initial hire. Supports geographic workforce analytics and real estate planning.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for this employment event. Examples include voluntary resignation, involuntary termination, retirement, reorganization, performance-based promotion, business need transfer, medical leave, parental leave, etc. Used for workforce analytics and compliance reporting.',
    `reason_description` STRING COMMENT 'Free-text description providing additional context or details about the reason for this employment event. Supplements the standardized reason code with case-specific information.',
    `record_created_by` STRING COMMENT 'The system user ID or name of the person who created this employment record in the system. Provides accountability and audit trail for data entry. May be an HR administrator, system interface, or automated process.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this employment record was first created in the system. Provides audit trail for data lineage and compliance. Distinct from the effective_date which represents the business event date.',
    `record_updated_by` STRING COMMENT 'The system user ID or name of the person who last modified this employment record. Provides accountability for changes and supports audit trail requirements. Updated with each modification to the record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this employment record was last modified in the system. Used for audit trail, data quality monitoring, and change tracking. Updated whenever any field in the record is changed.',
    `rehire_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire by the organization. Populated for termination events. True if the employee left in good standing and may be considered for future employment; false if the employee is ineligible due to performance, conduct, or policy violations. Used in applicant screening and background checks.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this employment record in the source system. Enables traceability back to the originating system for reconciliation, audit, and troubleshooting purposes.',
    `source_system` STRING COMMENT 'The name or identifier of the source system from which this employment record originated. Examples include HRIS (Human Resources Information System), payroll system, or talent management platform. Used for data lineage tracking and integration troubleshooting.',
    `system_access_change_flag` BOOLEAN COMMENT 'Indicates whether this employment event requires changes to the employees system access rights and permissions. True if access must be provisioned, modified, or revoked; false otherwise. Used to trigger IT security workflows and ensure SOX compliance for segregation of duties.',
    `termination_type` STRING COMMENT 'The classification of employment termination. Populated only for termination event types. Values include voluntary (employee-initiated resignation), involuntary (employer-initiated termination), retirement (age or service-based exit), death (deceased employee), or end_of_contract (natural expiration of fixed-term contract). Critical for unemployment claims, severance calculations, and workforce analytics.. Valid values are `voluntary|involuntary|retirement|death|end_of_contract`',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether this employment event triggers mandatory training requirements. True if the employee must complete onboarding, role-specific training, compliance training, or system training as a result of this event; false otherwise. Used to initiate training workflows and track compliance.',
    CONSTRAINT pk_employment_record PRIMARY KEY(`employment_record_id`)
) COMMENT 'Transactional record capturing each employment event in an employees lifecycle — hire, rehire, transfer, promotion, demotion, leave of absence, return from leave, and termination. Stores event type, effective date, prior position, new position, prior org unit, new org unit, prior job grade, new job grade, reason code, action initiator, and approver. Provides the immutable audit trail of all employment status changes and job movements for an employee throughout their tenure.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`compensation` (
    `compensation_id` BIGINT COMMENT 'Unique identifier for the compensation record. Primary key for the compensation data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compensation expense must be allocated to cost centers for GL posting, budget variance analysis, and financial reporting. Payroll journal entries require cost_center_id for proper expense classificati',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom this compensation record applies. Links to the employee master record.',
    `job_role_id` BIGINT COMMENT 'Foreign key linking to workforce.job_role. Business justification: Compensation records reference job_code (STRING) which should be normalized to job_role.role_code. This enables joining to the job_role catalog for grade bands, FLSA classification, and market referen',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Compensation packages are often tied to authorized positions (headcount slots) in addition to individual employees. This links compensation to the position being filled, enabling position-based salary',
    `superseded_compensation_id` BIGINT COMMENT 'Self-referencing FK on compensation (superseded_compensation_id)',
    `annualized_base` DECIMAL(18,2) COMMENT 'The annualized equivalent of the base compensation, calculated for both salaried and hourly employees. For hourly employees, this is computed based on standard full-time hours. Enables consistent comparison across compensation types.',
    `approval_date` DATE COMMENT 'The date on which this compensation arrangement was formally approved. Supports audit trails and compliance documentation.',
    `approved_by` STRING COMMENT 'The name or identifier of the manager or HR representative who approved this compensation arrangement. Supports audit trails and compliance with approval authority policies.',
    `base_salary` DECIMAL(18,2) COMMENT 'The fixed annual salary amount for salaried employees. Null for hourly or commission-only employees. Represents the guaranteed base compensation before bonuses or incentives.',
    `commission_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the employee is eligible to earn commission-based compensation in addition to base pay. Applies primarily to sales and producer roles.',
    `commission_plan_code` STRING COMMENT 'The code identifying the specific commission plan under which the employee earns commissions. Null if commission_eligible is false. Links to commission plan reference data.',
    `compa_ratio` DECIMAL(18,2) COMMENT 'The comparative ratio of the employees actual compensation to the midpoint of the pay range for their job grade. A value of 1.00 indicates compensation at the midpoint; values above or below indicate positioning within the range. Used for pay equity analysis.',
    `compensation_status` STRING COMMENT 'The current lifecycle status of this compensation record. Active indicates the current compensation arrangement; superseded indicates a historical record replaced by a newer one; pending indicates an approved future change not yet effective.. Valid values are `active|pending|superseded|terminated`',
    `compensation_type` STRING COMMENT 'The classification of the compensation structure. Indicates whether the employee is paid a fixed salary, hourly wage, commission-based, or other arrangement.. Valid values are `salary|hourly|commission_eligible|contract|per_diem|stipend`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compensation record was first created in the system. Supports audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which compensation is denominated (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which this compensation arrangement becomes active and binding. Marks the start of the compensation period.',
    `end_date` DATE COMMENT 'The date on which this compensation arrangement ceases to be active. Null for current/open-ended compensation records.',
    `equity_grant_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the employee is eligible to receive equity-based compensation such as stock options or restricted stock units. Typically applies to executive and senior leadership roles.',
    `flsa_status` STRING COMMENT 'Indicates whether the employee is exempt or non-exempt from overtime provisions under the Fair Labor Standards Act. Critical for payroll compliance and overtime eligibility.. Valid values are `exempt|non_exempt`',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The full-time equivalency percentage representing the proportion of a full-time schedule this employee works. 100.00 for full-time, less than 100.00 for part-time. Used for workforce capacity planning and benefits eligibility.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'The hourly wage rate for hourly employees. Null for salaried employees. Used to calculate gross pay based on hours worked.',
    `last_merit_increase_date` DATE COMMENT 'The date of the most recent merit-based salary increase for this employee. Used to track compensation review cycles and eligibility for future increases.',
    `last_merit_increase_percentage` DECIMAL(18,2) COMMENT 'The percentage increase applied during the last merit review. Supports compensation history analysis and pay equity reviews.',
    `location_code` STRING COMMENT 'The code identifying the geographic location or office where the employee is based. Used for geographic pay differentials and compliance with local wage laws.',
    `long_term_incentive_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the employee is eligible for long-term incentive plans that vest over multiple years. Supports retention and long-term performance alignment.',
    `market_reference_percentile` DECIMAL(18,2) COMMENT 'The percentile of the external market salary data at which this employees compensation is positioned (e.g., 50th percentile, 75th percentile). Supports competitive pay positioning and market benchmarking.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or explanatory notes related to this compensation record. May include details on negotiated terms, special arrangements, or exceptions.',
    `overtime_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the employee is eligible to receive overtime pay. Typically aligns with FLSA non-exempt status but may reflect additional company policies.',
    `pay_band` STRING COMMENT 'The pay band or salary range category within which the employees compensation falls. Supports compensation planning and market alignment.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee receives regular paychecks. Drives payroll processing schedules and cash flow planning.. Valid values are `weekly|bi_weekly|semi_monthly|monthly`',
    `pay_grade` STRING COMMENT 'The pay grade or level assigned to the employee within the organizations compensation structure. Used for internal equity and benchmarking.',
    `reason_code` STRING COMMENT 'The business reason or trigger for this compensation record. Supports audit trails and compensation analytics. [ENUM-REF-CANDIDATE: new_hire|promotion|merit_increase|market_adjustment|reclassification|demotion|cost_of_living — 7 candidates stripped; promote to reference product]',
    `review_cycle` STRING COMMENT 'The frequency at which this employees compensation is formally reviewed for potential adjustment. Drives compensation planning and budgeting cycles.. Valid values are `annual|semi_annual|quarterly|ad_hoc|not_applicable`',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'The standard number of hours per week the employee is expected to work. Used to calculate full-time equivalency (FTE) and annualized compensation for hourly employees.',
    `target_bonus_percentage` DECIMAL(18,2) COMMENT 'The target annual bonus expressed as a percentage of base salary. Represents the expected bonus at 100% performance achievement. Null if the employee is not eligible for a bonus.',
    `target_total_compensation` DECIMAL(18,2) COMMENT 'The sum of annualized base compensation and target bonus, representing the total expected compensation at target performance. Used for total rewards statements and market benchmarking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this compensation record was last modified. Supports audit trails and change tracking.',
    CONSTRAINT pk_compensation PRIMARY KEY(`compensation_id`)
) COMMENT 'Master record of the current and historical compensation package for each employee. Captures base salary, hourly rate, pay grade, pay band, compensation type (salary, hourly, commission-eligible), effective date, end date, currency, annualized base, target bonus percentage, target total compensation, last merit increase date, last merit increase percentage, and compensation review cycle. SSOT for employee pay data supporting payroll processing, compensation benchmarking, and regulatory pay equity reporting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Unique identifier for each payroll payment event record.',
    `compensation_id` BIGINT COMMENT 'Foreign key linking to workforce.compensation. Business justification: Payroll records execute the compensation plan defined in the compensation master. This links each payroll payment event to the authoritative compensation record, enabling audit trail, variance analysi',
    `employee_id` BIGINT COMMENT 'Reference to the employee receiving this payroll payment.',
    `run_id` BIGINT COMMENT 'Reference to the payroll processing batch or run that generated this payment record.',
    `adjustment_payroll_record_id` BIGINT COMMENT 'Self-referencing FK on payroll_record (adjustment_payroll_record_id)',
    `bank_account_last_four` STRING COMMENT 'Last four digits of the employee bank account number for direct deposit verification purposes.. Valid values are `^[0-9]{4}$`',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Discretionary or performance-based bonus payments included in this payroll cycle.',
    `charitable_contribution_posttax` DECIMAL(18,2) COMMENT 'Post-tax voluntary deductions for charitable contributions through payroll giving programs.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Sales commission or incentive compensation earned during the pay period, applicable to agent and sales roles.',
    `cost_center_code` STRING COMMENT 'The organizational cost center or department code to which this payroll expense is allocated for financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll record was first created in the system.',
    `dental_insurance_pretax_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax contributions for dental insurance premiums under a Section 125 cafeteria plan.',
    `federal_income_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of federal income tax withheld from gross pay based on employee W-4 elections and IRS withholding tables.',
    `fsa_pretax_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax contributions to a Flexible Spending Account (FSA) for healthcare or dependent care expenses.',
    `garnishment_amount` DECIMAL(18,2) COMMENT 'Court-ordered wage garnishments for child support, tax levies, or other legal obligations deducted post-tax.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting payroll expense in the financial system.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total earnings before any deductions or withholdings for the pay period, including regular wages, overtime, bonuses, and commissions.',
    `health_insurance_pretax_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax contributions for health insurance premiums under a Section 125 cafeteria plan.',
    `hsa_pretax_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax contributions to a Health Savings Account (HSA) for qualified medical expenses.',
    `local_income_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of local or municipal income tax withheld, applicable in jurisdictions with local income tax requirements.',
    `medicare_tax_withheld` DECIMAL(18,2) COMMENT 'Employee portion of Medicare tax (FICA) withheld, calculated at 1.45% of all wages, plus additional 0.9% for high earners.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Final take-home pay amount after all taxes, pre-tax deductions, and post-tax deductions have been applied.',
    `overtime_hours_worked` DECIMAL(18,2) COMMENT 'Number of overtime hours worked during the pay period, typically hours exceeding 40 per week.',
    `overtime_pay_amount` DECIMAL(18,2) COMMENT 'Earnings from overtime hours, typically calculated at 1.5 times the regular hourly rate.',
    `pay_date` DATE COMMENT 'The date on which the employee receives or can access the net pay amount.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid (weekly, biweekly, semimonthly, monthly).. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_method` STRING COMMENT 'Method by which the net pay is delivered to the employee (direct deposit, physical check, pay card, or cash).. Valid values are `direct_deposit|check|pay_card|cash`',
    `pay_period_end_date` DATE COMMENT 'The last day of the pay period covered by this payroll payment.',
    `pay_period_start_date` DATE COMMENT 'The first day of the pay period covered by this payroll payment.',
    `payroll_status` STRING COMMENT 'Current processing status of this payroll record in the payroll workflow lifecycle.. Valid values are `draft|approved|processed|paid|voided|reversed`',
    `regular_hours_worked` DECIMAL(18,2) COMMENT 'Number of regular (non-overtime) hours worked during the pay period.',
    `regular_pay_amount` DECIMAL(18,2) COMMENT 'Earnings from regular hours worked at the standard hourly or salary rate.',
    `retirement_plan_pretax_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax contributions to qualified retirement plans such as 401(k), 403(b), or 457 plans.',
    `social_security_tax_withheld` DECIMAL(18,2) COMMENT 'Employee portion of Social Security tax (FICA) withheld, calculated at 6.2% of wages up to the annual wage base limit.',
    `state_income_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of state income tax withheld from gross pay based on state withholding requirements and employee elections.',
    `total_posttax_deductions` DECIMAL(18,2) COMMENT 'Sum of all post-tax deductions including garnishments, union dues, and voluntary contributions.',
    `total_pretax_deductions` DECIMAL(18,2) COMMENT 'Sum of all pre-tax deductions including retirement, health insurance, HSA, FSA, and other Section 125 plan contributions.',
    `union_dues_posttax_deduction` DECIMAL(18,2) COMMENT 'Post-tax deductions for union membership dues, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll record was last modified or updated.',
    `vision_insurance_pretax_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax contributions for vision insurance premiums under a Section 125 cafeteria plan.',
    `year_to_date_federal_tax` DECIMAL(18,2) COMMENT 'Cumulative federal income tax withheld from the beginning of the calendar year through this pay period, used for W-2 preparation.',
    `year_to_date_gross_pay` DECIMAL(18,2) COMMENT 'Cumulative gross pay for the employee from the beginning of the calendar year through this pay period, used for W-2 preparation.',
    `year_to_date_medicare_tax` DECIMAL(18,2) COMMENT 'Cumulative Medicare tax (FICA) withheld from the beginning of the calendar year through this pay period, used for W-2 preparation.',
    `year_to_date_social_security_tax` DECIMAL(18,2) COMMENT 'Cumulative Social Security tax (FICA) withheld from the beginning of the calendar year through this pay period, used for W-2 preparation.',
    `year_to_date_state_tax` DECIMAL(18,2) COMMENT 'Cumulative state income tax withheld from the beginning of the calendar year through this pay period.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Transactional record of each payroll payment event for an employee within a pay period. Captures pay period start and end dates, pay date, gross pay, federal income tax withheld, state income tax withheld, FICA (Social Security and Medicare) withheld, pre-tax deductions (401k, HSA, FSA, health insurance premiums), post-tax deductions, net pay, pay method (direct deposit, check), and payroll run identifier. Supports payroll reconciliation, W-2 preparation, and labor cost allocation to cost centers.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for each benefit enrollment record. Primary key for the benefit enrollment entity.',
    `plan_id` BIGINT COMMENT 'Unique identifier of the benefit plan elected by the employee. Links to the benefit plan master record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who made this benefit election. Links to the employee master record.',
    `superseded_benefit_enrollment_id` BIGINT COMMENT 'Self-referencing FK on benefit_enrollment (superseded_benefit_enrollment_id)',
    `beneficiary_designation_complete` BOOLEAN COMMENT 'Boolean flag indicating whether the employee has completed beneficiary designation for this benefit plan, applicable primarily to life insurance and retirement plans. True if designation is complete, False if pending or incomplete.',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or third-party administrator providing the benefit plan.',
    `cobra_continuation_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this enrollment represents COBRA continuation coverage following a qualifying event such as termination of employment or reduction in hours. True if COBRA continuation, False if active employee coverage.',
    `cobra_qualifying_event` STRING COMMENT 'Description of the qualifying event that triggered COBRA continuation eligibility, if applicable. Examples include termination of employment, reduction in hours, divorce, death of employee, loss of dependent status. Null if not a COBRA enrollment.',
    `cobra_qualifying_event_date` DATE COMMENT 'Date on which the COBRA qualifying event occurred, if applicable. Used to determine COBRA continuation period and eligibility. Null if not a COBRA enrollment.',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are deducted and remitted for this benefit plan.. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `coverage_amount` DECIMAL(18,2) COMMENT 'The face amount or benefit limit of the elected coverage, applicable primarily to life insurance, Accidental Death and Dismemberment (AD&D), and disability plans. Expressed in USD. Null for plans without a defined coverage amount.',
    `coverage_tier` STRING COMMENT 'Level of coverage elected indicating who is covered under the benefit plan: employee only, employee plus spouse, employee plus children, employee plus family, or employee plus domestic partner.. Valid values are `employee_only|employee_spouse|employee_children|employee_family|employee_domestic_partner`',
    `deduction_end_date` DATE COMMENT 'Date on which payroll deductions for employee contributions end for this benefit enrollment. Null for ongoing active enrollments.',
    `deduction_start_date` DATE COMMENT 'Date on which payroll deductions for employee contributions begin for this benefit enrollment.',
    `dependent_count` STRING COMMENT 'Number of dependents covered under this benefit enrollment, applicable when coverage tier includes spouse, children, or family.',
    `election_effective_date` DATE COMMENT 'Date on which the benefit election becomes effective and coverage begins.',
    `election_end_date` DATE COMMENT 'Date on which the benefit election ends and coverage terminates. Null for ongoing active enrollments.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'The monetary amount the employee contributes per pay period toward the cost of this benefit plan. Expressed in USD.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The monetary amount the employer contributes per pay period toward the cost of this benefit plan. Expressed in USD.',
    `enrollment_confirmation_sent_date` DATE COMMENT 'Date on which enrollment confirmation documentation was sent to the employee, either electronically or via mail.',
    `enrollment_date` DATE COMMENT 'Date on which the employee submitted or completed the benefit enrollment election.',
    `enrollment_method` STRING COMMENT 'The channel or method through which the employee completed the benefit enrollment. Online portal is web-based self-service; paper form is manual submission; phone is telephonic enrollment; benefits counselor is assisted enrollment; mobile app is smartphone application; kiosk is on-site terminal.. Valid values are `online_portal|paper_form|phone|benefits_counselor|mobile_app|kiosk`',
    `enrollment_notes` STRING COMMENT 'Free-text field for capturing additional notes, comments, or special circumstances related to this benefit enrollment, such as carrier-specific requirements, pending documentation, or enrollment exceptions.',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment confirmation number provided to the employee upon successful benefit election.',
    `enrollment_source` STRING COMMENT 'The triggering event or process that initiated this benefit enrollment. Open enrollment is the annual election period; new hire is initial enrollment upon employment; qualifying life event (QLE) includes marriage, birth, adoption, divorce, or loss of other coverage; annual reenrollment is passive continuation; rehire is re-employment enrollment; leave return is enrollment upon return from leave; benefit change is mid-year plan modification. [ENUM-REF-CANDIDATE: open_enrollment|new_hire|qualifying_life_event|annual_reenrollment|rehire|leave_return|benefit_change — 7 candidates stripped; promote to reference product]',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the benefit enrollment. Active indicates coverage is in force; pending indicates awaiting approval or effective date; terminated indicates coverage has ended; waived indicates employee declined coverage; cancelled indicates enrollment was voided; suspended indicates temporary hold.. Valid values are `active|pending|terminated|waived|cancelled|suspended`',
    `eoi_status` STRING COMMENT 'Current status of the Evidence of Insurability underwriting process, if required. Not required indicates no EOI needed; pending indicates awaiting submission; in review indicates carrier is evaluating; approved indicates coverage granted; declined indicates coverage denied.. Valid values are `not_required|pending|approved|declined|in_review`',
    `evidence_of_insurability_required` BOOLEAN COMMENT 'Boolean flag indicating whether the employee is required to provide Evidence of Insurability (medical underwriting) for this benefit election, typically for life insurance or disability coverage above guaranteed issue limits. True if EOI is required, False otherwise.',
    `imputed_income_amount` DECIMAL(18,2) COMMENT 'The amount of imputed income per pay period attributable to employer-provided group term life insurance coverage exceeding fifty thousand dollars, as required by IRS Section 79. Expressed in USD. Null if no imputed income applies.',
    `plan_name` STRING COMMENT 'Full name of the specific benefit plan elected by the employee, as marketed and administered by the carrier or plan sponsor.',
    `plan_type` STRING COMMENT 'Category of benefit plan elected. Includes medical, dental, vision, life insurance, Accidental Death and Dismemberment (AD&D), Short-Term Disability (STD), Long-Term Disability (LTD), 401k retirement, Health Savings Account (HSA), Flexible Spending Account (FSA), Employee Assistance Program (EAP), and supplemental coverages. [ENUM-REF-CANDIDATE: medical|dental|vision|life_insurance|add|std|ltd|401k|hsa|fsa|eap|supplemental_life|dependent_life|critical_illness|accident|legal — 16 candidates stripped; promote to reference product]',
    `plan_year` STRING COMMENT 'The benefit plan year to which this enrollment applies, typically represented as a four-digit year (e.g., 2024). Used for tracking annual enrollment cycles and plan year reporting.',
    `pre_tax_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether employee contributions for this benefit plan are deducted on a pre-tax basis under Section 125 cafeteria plan rules. True if pre-tax, False if post-tax.',
    `qle_date` DATE COMMENT 'Date on which the qualifying life event occurred, if applicable. Used to validate timeliness of enrollment election under HIPAA and Section 125 rules. Null if not a QLE enrollment.',
    `qle_type` STRING COMMENT 'Specific type of qualifying life event that permitted mid-year enrollment or change, if applicable. Examples include marriage, divorce, birth, adoption, death of dependent, loss of other coverage, change in employment status. Null if enrollment was not triggered by a QLE.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this benefit enrollment record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this benefit enrollment record was last modified in the system.',
    `tobacco_user_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the employee self-identified as a tobacco user, which may affect premium rates for certain benefit plans such as life insurance or medical coverage. True if tobacco user, False otherwise.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Total premium cost per pay period for this benefit plan, representing the sum of employee and employer contributions. Expressed in USD.',
    `waiver_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the employee explicitly waived (declined) this benefit plan. True if waived, False if elected.',
    `waiver_reason` STRING COMMENT 'Reason provided by the employee for waiving the benefit plan, if applicable. Common reasons include coverage under spouse plan, coverage under parent plan, cost, or other coverage. Null if benefit was not waived.',
    `wellness_program_participation` BOOLEAN COMMENT 'Boolean flag indicating whether the employee is participating in an employer-sponsored wellness program that may provide premium discounts or incentives for this benefit plan. True if participating, False otherwise.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Master and transactional record of each employees benefit plan elections. Captures benefit plan type (medical, dental, vision, life insurance, AD&D, LTD, STD, 401k, HSA, FSA, EAP), plan name, coverage tier (employee only, employee+spouse, family), election effective date, election end date, employee contribution amount, employer contribution amount, enrollment source (open enrollment, new hire, qualifying life event), and waiver indicator. Tracks the full benefit enrollment lifecycle including open enrollment changes and qualifying life event updates.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`staff_license` (
    `staff_license_id` BIGINT COMMENT 'Unique identifier for the staff license record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee who holds this license.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Staff licenses are mandated by specific regulatory obligations (state DOI requirements, FINRA registrations, continuing education mandates). Linking licenses to obligations enables compliance tracking',
    `renewed_staff_license_id` BIGINT COMMENT 'Self-referencing FK on staff_license (renewed_staff_license_id)',
    `appointment_date` DATE COMMENT 'The date on which the company appointed the employee to represent it in the issuing jurisdiction.',
    `appointment_status` STRING COMMENT 'Indicates whether the employee is appointed by the company to act on its behalf in the issuing jurisdiction (appointed, not appointed, pending, terminated).. Valid values are `appointed|not_appointed|pending|terminated`',
    `background_check_date` DATE COMMENT 'The date on which the most recent background check or regulatory screening was completed for this license.',
    `background_check_status` STRING COMMENT 'The result of the most recent background check or regulatory screening (passed, failed, pending, not required).. Valid values are `passed|failed|pending|not_required`',
    `ce_compliance_status` STRING COMMENT 'Indicates whether the employee is in compliance with continuing education requirements (compliant, non-compliant, at risk of non-compliance, not applicable).. Valid values are `compliant|non_compliant|at_risk|not_applicable`',
    `ce_credits_completed` DECIMAL(18,2) COMMENT 'The number of continuing education credits the employee has completed toward the current renewal requirement.',
    `ce_credits_remaining` DECIMAL(18,2) COMMENT 'The number of continuing education credits still needed to meet the renewal requirement (calculated as required minus completed).',
    `ce_credits_required` DECIMAL(18,2) COMMENT 'The total number of continuing education credits required for the current renewal period to maintain the license or designation.',
    `company_sponsored_flag` BOOLEAN COMMENT 'Indicates whether the license or designation is sponsored, paid for, or required by the company (True) or is held independently by the employee (False).',
    `compliance_notes` STRING COMMENT 'Free-text field for compliance officers to record notes, exceptions, or special conditions related to this license.',
    `crd_number` STRING COMMENT 'The unique identifier assigned to the employee in the Financial Industry Regulatory Authority (FINRA) Central Registration Depository (CRD) system for securities registrations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this staff license record was first created in the system.',
    `designation_type` STRING COMMENT 'The professional designation or certification held by the employee. Includes actuarial designations (Fellow of the Society of Actuaries (FSA), Member of the American Academy of Actuaries (MAAA)), insurance designations (Chartered Life Underwriter (CLU), Chartered Financial Consultant (ChFC), Chartered Property Casualty Underwriter (CPCU)), financial designations (Chartered Financial Analyst (CFA), Certified Financial Planner (CFP)), and Financial Industry Regulatory Authority (FINRA) series registrations (Series 6, 7, 26, 63). [ENUM-REF-CANDIDATE: FSA|MAAA|CLU|ChFC|CPCU|CFA|CFP|FINRA_6|FINRA_7|FINRA_26|FINRA_63|other — 12 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'The date on which the license became active and the employee was authorized to perform licensed activities.',
    `expiration_date` DATE COMMENT 'The date on which the license or designation expires and must be renewed to remain valid.',
    `issue_date` DATE COMMENT 'The date on which the license or designation was originally issued to the employee.',
    `issuing_authority` STRING COMMENT 'The name of the regulatory body or professional organization that issued the license or designation (e.g., New York Department of Financial Services, Society of Actuaries, FINRA).',
    `issuing_jurisdiction` STRING COMMENT 'The state, province, or regulatory jurisdiction that issued the license or registration (e.g., New York, California, Texas, FINRA for securities registrations).',
    `last_renewal_date` DATE COMMENT 'The most recent date on which the license or designation was renewed.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this staff license record was most recently modified.',
    `license_class` STRING COMMENT 'The classification of the license based on the employees residency status in the issuing jurisdiction (resident, non-resident, reciprocal).. Valid values are `resident|non_resident|reciprocal`',
    `license_number` STRING COMMENT 'The unique license number or registration number issued by the regulatory authority or professional body.',
    `license_status` STRING COMMENT 'The current status of the license or designation in its lifecycle (active, expired, suspended, revoked, surrendered, pending approval, inactive). [ENUM-REF-CANDIDATE: active|expired|suspended|revoked|surrendered|pending|inactive — 7 candidates stripped; promote to reference product]',
    `license_type` STRING COMMENT 'The category of insurance license held by the employee (e.g., life, health, variable, property and casualty, surplus lines, limited lines).. Valid values are `life|health|variable|property_casualty|surplus_lines|limited_lines`',
    `license_verification_url` STRING COMMENT 'The web address or uniform resource locator (URL) where the license status can be verified with the issuing authority.',
    `lines_of_authority` STRING COMMENT 'The specific lines of insurance or product categories the employee is authorized to transact under this license (e.g., life, accident and health, variable contracts, long-term care). Multiple lines may be comma-separated.',
    `next_renewal_date` DATE COMMENT 'The upcoming date by which the license or designation must be renewed to avoid expiration.',
    `nipr_number` STRING COMMENT 'The unique identifier assigned to the employee in the National Insurance Producer Registry (NIPR) system, used for multi-state license management.',
    `termination_date` DATE COMMENT 'The date on which the license or appointment was terminated, surrendered, or revoked.',
    `termination_reason` STRING COMMENT 'The reason for the termination, surrender, or revocation of the license (e.g., voluntary surrender, regulatory action, non-renewal, employment termination).',
    CONSTRAINT pk_staff_license PRIMARY KEY(`staff_license_id`)
) COMMENT 'Master record of all insurance licenses, professional designations, and regulatory registrations held by internal employees — distinct from agent.license which tracks external producer licenses. Captures license type (life, health, variable, P&C), issuing state or jurisdiction, license number, issue date, expiration date, renewal date, CE credits required, CE credits completed, license status (active, expired, suspended, surrendered), and whether the license is company-sponsored. Tracks FSA, MAAA, CLU, ChFC, CPCU, CFA, and FINRA Series 6/7/26/63 registrations for actuaries, underwriters, and variable product staff.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`ce_credit` (
    `ce_credit_id` BIGINT COMMENT 'Unique identifier for each continuing education credit record. Primary key for the CE credit transaction.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who earned this continuing education credit. Links to the employee master record.',
    `staff_license_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_license. Business justification: CE credits are earned to maintain staff licenses held by internal employees. The existing license_id FK points to agent.license (cross-domain for external agents). For internal workforce, ce_credit sh',
    `corrected_ce_credit_id` BIGINT COMMENT 'Self-referencing FK on ce_credit (corrected_ce_credit_id)',
    `applicable_state` STRING COMMENT 'Two-letter state code indicating the jurisdiction where this CE credit is recognized and applicable for license renewal.. Valid values are `^[A-Z]{2}$`',
    `audit_selected_flag` BOOLEAN COMMENT 'Indicates whether this CE credit record has been selected for regulatory audit or verification by the state licensing authority.',
    `carryover_eligible_flag` BOOLEAN COMMENT 'Indicates whether excess CE credits earned in this reporting period can be carried over to the next renewal cycle.',
    `certificate_number` STRING COMMENT 'Unique certificate or completion identifier issued by the CE provider as proof of course completion.',
    `completion_date` DATE COMMENT 'Date on which the employee successfully completed the continuing education course and earned the credit.',
    `completion_method` STRING COMMENT 'Delivery format or instructional method through which the employee completed the CE course.. Valid values are `classroom|webinar|self_study|conference|on_demand`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred by the company or employee for the CE course, including tuition, materials, and registration fees. Expressed in USD.',
    `course_category` STRING COMMENT 'Subject matter category or topic area of the CE course (e.g., underwriting, actuarial science, claims management, compliance, product knowledge).',
    `course_number` STRING COMMENT 'Unique course identifier or catalog number assigned by the CE provider or state regulatory authority.',
    `course_title` STRING COMMENT 'Full title of the continuing education course or training program completed by the employee.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CE credit record was first created in the system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of continuing education credit hours earned upon successful completion of the course. Measured in hours with fractional precision.',
    `credit_type` STRING COMMENT 'Classification of the CE credit based on subject matter and regulatory requirements. Determines applicability toward specific license renewal categories.. Valid values are `general|ethics|state_specific|annuity|long_term_care|flood`',
    `designation_code` STRING COMMENT 'Code representing the professional designation or certification for which this CE credit applies (e.g., CLU, ChFC, CFP, FSA, FLMI).',
    `expiration_date` DATE COMMENT 'Date on which this CE credit expires and is no longer valid for license renewal or designation maintenance purposes.',
    `instructor_name` STRING COMMENT 'Name of the instructor or facilitator who delivered the continuing education course.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special circumstances, or clarifications related to this CE credit record.',
    `provider_approval_number` STRING COMMENT 'State-issued approval or registration number for the CE provider, confirming authorization to offer continuing education.',
    `provider_name` STRING COMMENT 'Name of the organization or institution that delivered the continuing education course.',
    `reimbursement_eligible_flag` BOOLEAN COMMENT 'Indicates whether the CE course cost is eligible for reimbursement under company training and development policies.',
    `reporting_period_end_date` DATE COMMENT 'End date of the license renewal or compliance reporting period to which this CE credit applies.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the license renewal or compliance reporting period to which this CE credit applies.',
    `submission_confirmation_number` STRING COMMENT 'Confirmation or tracking number issued by the state licensing authority upon receipt of the CE credit submission.',
    `submission_date` DATE COMMENT 'Date on which the CE credit was submitted to the state licensing authority for recording and compliance verification.',
    `submission_status` STRING COMMENT 'Current status of the CE credit submission to the state licensing authority or regulatory body.. Valid values are `pending|submitted|accepted|rejected|expired`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CE credit record was last modified or updated in the system.',
    `verification_date` DATE COMMENT 'Date on which the CE credit was verified or audited by the state licensing authority or internal compliance team.',
    `verification_status` STRING COMMENT 'Status of the regulatory verification or audit process for this CE credit record.. Valid values are `not_verified|verified|failed_verification|pending_verification`',
    CONSTRAINT pk_ce_credit PRIMARY KEY(`ce_credit_id`)
) COMMENT 'Transactional record of each continuing education (CE) credit earned by an employee toward license renewal or professional designation maintenance. Captures CE provider name, course title, course number, credit hours earned, credit type (ethics, general, state-specific), completion date, applicable license or designation, reporting period, and submission status to the licensing authority. Supports automated CE tracking and license renewal compliance for underwriters, actuaries, claims adjusters, and variable product staff.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`staff_training` (
    `staff_training_id` BIGINT COMMENT 'Unique identifier for the staff training course record.',
    `course_owner_employee_id` BIGINT COMMENT 'Identifier of the internal employee responsible for course content, updates, and quality assurance. Typically a subject matter expert or training manager.',
    `employee_id` BIGINT COMMENT 'System user identifier of the person who created the course record. Used for audit trail and data governance.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who last modified the course record. Used for audit trail and change management.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Training courses are mandated by specific regulations (FINRA CE requirements, state suitability training, AML/BSA training mandates). Linking courses to obligations supports compliance reporting, CE c',
    `prerequisite_staff_training_id` BIGINT COMMENT 'Self-referencing FK on staff_training (prerequisite_staff_training_id)',
    `accreditation_body` STRING COMMENT 'Name of the professional organization or regulatory body that has accredited or approved this course for CE credit (e.g., Society of Actuaries, LOMA, state insurance departments).',
    `accreditation_number` STRING COMMENT 'Unique accreditation or approval number issued by the accrediting body, required for CE credit reporting to state insurance departments.',
    `assessment_method` STRING COMMENT 'Type of evaluation used to measure course completion and competency. None indicates no formal assessment required.. Valid values are `exam|quiz|project|practical|observation|none`',
    `average_completion_rate_pct` DECIMAL(18,2) COMMENT 'Historical average percentage of enrolled participants who successfully complete the course. Used for course effectiveness evaluation and capacity planning.',
    `average_satisfaction_score` DECIMAL(18,2) COMMENT 'Mean participant satisfaction rating from post-course evaluations, typically on a 1-5 scale. Used for continuous improvement and vendor performance assessment.',
    `ce_credit_hours` DECIMAL(18,2) COMMENT 'Number of Continuing Education credit hours awarded upon successful completion, applicable for licensed professionals (agents, actuaries, underwriters) who must maintain state or professional certifications.',
    `ce_credit_type` STRING COMMENT 'Classification of CE credit for regulatory reporting. Ethics credits often have separate hour requirements per NAIC and state insurance departments.. Valid values are `general|ethics|product_specific|technical|none`',
    `certification_issued` BOOLEAN COMMENT 'Indicates whether a formal certificate of completion is issued upon successful course completion. Used for compliance documentation and employee development records.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Average cost to deliver the training per participant, including instructor fees, materials, facility rental, and vendor charges. Used for training budget planning and ROI analysis.',
    `course_category` STRING COMMENT 'High-level classification of the training course type. Technical includes underwriting, actuarial, and claims training; compliance is tracked separately in compliance.training_course.. Valid values are `technical|compliance|leadership|sales|product|professional_development`',
    `course_code` STRING COMMENT 'Unique alphanumeric code identifying the training course in the Learning Management System (LMS). Used for course catalog lookup and enrollment processing.. Valid values are `^[A-Z0-9]{4,12}$`',
    `course_description` STRING COMMENT 'Detailed narrative describing the course objectives, content outline, learning outcomes, and target audience. Used in course catalog and enrollment communications.',
    `course_materials_url` STRING COMMENT 'Web link or LMS path to access course materials, handouts, reference documents, and supplementary resources.',
    `course_status` STRING COMMENT 'Current lifecycle state of the training course. Active courses are available for enrollment; inactive courses are temporarily unavailable; retired courses are archived and no longer offered.. Valid values are `active|inactive|under_review|retired|draft`',
    `course_title` STRING COMMENT 'Full descriptive title of the training course as displayed in the course catalog and on completion certificates.',
    `course_type` STRING COMMENT 'Functional classification indicating the purpose and target audience scope of the training course.. Valid values are `role_specific|general|onboarding|certification|continuing_education`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the course record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost_per_participant (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Instructional delivery format. ILT (Instructor-Led Training) is in-person classroom; vILT (virtual Instructor-Led Training) is live online; eLearning is asynchronous digital; OJT (On-the-Job Training) is hands-on mentorship; blended combines multiple methods.. Valid values are `ilt|vilt|elearning|ojt|blended|self_paced`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total instructional time required to complete the course, measured in hours. Used for capacity planning and Continuing Education (CE) credit calculation.',
    `effective_end_date` DATE COMMENT 'Date when the course is retired or no longer available for new enrollments. Null for courses with indefinite availability.',
    `effective_start_date` DATE COMMENT 'Date when the course becomes available for enrollment and delivery. Used for course catalog publishing and scheduling.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether completion of this course is required for one or more job roles. True if mandatory for at least one role; false if entirely optional.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language of course delivery and materials (e.g., ENG for English, SPA for Spanish, FRA for French).. Valid values are `^[A-Z]{3}$`',
    `last_content_review_date` DATE COMMENT 'Date of the most recent content accuracy and relevance review. Used to ensure training materials remain current with regulatory changes, product updates, and industry best practices.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the course record was most recently updated.',
    `learning_objectives` STRING COMMENT 'Structured list of specific skills, knowledge, or competencies participants will acquire upon successful completion. Used for competency mapping and skills gap analysis.',
    `max_enrollment_capacity` STRING COMMENT 'Maximum number of participants allowed per course session. Applicable primarily to ILT and vILT courses with instructor or facility constraints. Null for self-paced eLearning.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next mandatory content review. Ensures training materials are periodically updated to reflect regulatory changes (NAIC, state insurance departments) and business process evolution.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score (percentage or points) required to successfully complete the course and receive credit. Null for courses without formal assessment.',
    `prerequisite_courses` STRING COMMENT 'Comma-separated list of course codes that must be completed before enrolling in this course. Null if no prerequisites exist.',
    `recurrence_frequency_months` STRING COMMENT 'Number of months between required re-certifications or refresher training. Null for one-time courses. Common values: 12 (annual), 24 (biennial), 36 (triennial).',
    `target_job_roles` STRING COMMENT 'Comma-separated list of job role codes for which this training is designed or required (e.g., UW01,UW02 for underwriter roles, ACT01 for actuaries, CLM01 for claims adjusters).',
    `vendor_course_code` STRING COMMENT 'External vendors unique identifier for the course, used for integration with third-party Learning Management Systems (LMS) and completion tracking.',
    `vendor_provider_name` STRING COMMENT 'Name of the external training vendor or content provider if the course is sourced externally. Null for internally developed courses.',
    `version_number` STRING COMMENT 'Semantic version identifier for the course content (e.g., 1.0, 2.1). Incremented when course materials are updated. Used for audit trail and completion record accuracy.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_staff_training PRIMARY KEY(`staff_training_id`)
) COMMENT 'Master catalog of internal training programs and courses offered to Life Insurance employees — distinct from compliance.training_course which tracks regulatory compliance training. Covers role-specific technical training for underwriters (mortality tables, APS interpretation), actuaries (Prophet/AXIS modeling, PBR), claims adjusters (contestability, SIU protocols), and general professional development. Captures course code, course title, delivery method (ILT, vILT, eLearning, OJT), duration hours, passing score threshold, recurrence frequency, and whether completion is mandatory for a given job role.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` (
    `training_enrollment_id` BIGINT COMMENT 'Unique identifier for the training enrollment record. Primary key for the training enrollment entity.',
    `training_session_id` BIGINT COMMENT 'Unique identifier of the specific delivery session or class instance for this enrollment. Links to the scheduled training session.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee enrolled in the training course. Links to the employee master record.',
    `staff_training_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_training. Business justification: Training enrollments for internal workforce should link to the in-domain staff_training catalog, not the cross-domain compliance.training_course. This is an in-domain correction. staff_training is the',
    `reenrollment_training_enrollment_id` BIGINT COMMENT 'Self-referencing FK on training_enrollment (reenrollment_training_enrollment_id)',
    `actual_start_date` DATE COMMENT 'Actual date when the employee began participating in the training course. May differ from scheduled start date due to late joins or rescheduling.',
    `attendance_percentage` DECIMAL(18,2) COMMENT 'Percentage of scheduled training sessions or modules that the employee attended or completed, used for compliance and completion tracking.',
    `certificate_expiration_date` DATE COMMENT 'Date when the training certificate expires and the employee must retake or renew the training to maintain compliance or certification.',
    `certificate_issue_date` DATE COMMENT 'Date when the training completion certificate was issued to the employee.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a completion certificate was issued to the employee upon successful completion of the training course.',
    `certificate_number` STRING COMMENT 'Unique certificate number or identifier issued to the employee as proof of training completion, used for verification and audit purposes.',
    `ceu_awarded` DECIMAL(18,2) COMMENT 'Number of Continuing Education Units awarded for professional licensing or certification maintenance upon successful completion.',
    `comments` STRING COMMENT 'Additional notes, feedback, or observations related to the training enrollment, completion, or employee performance.',
    `completion_date` DATE COMMENT 'Date when the employee successfully completed the training course and met all requirements.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of the training course content, modules, or activities that the employee has completed. Tracks progress toward full completion.',
    `compliance_due_date` DATE COMMENT 'Deadline by which the employee must complete the training to meet regulatory or organizational compliance requirements.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this training enrollment, including tuition, materials, instructor fees, and facility costs.',
    `cost_center_code` STRING COMMENT 'Cost center or department code to which the training expense is allocated for financial reporting and budgeting.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training enrollment record was first created in the system.',
    `credit_hours_awarded` DECIMAL(18,2) COMMENT 'Number of continuing education or professional development credit hours awarded upon successful completion of the training course.',
    `delivery_method` STRING COMMENT 'Method or modality through which the training is delivered, such as in-person classroom, virtual live session, self-paced e-learning, or blended approach.. Valid values are `classroom|virtual_live|e_learning|blended|on_the_job|webinar`',
    `enrollment_date` DATE COMMENT 'Date when the employee registered or was enrolled in the training course.',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment confirmation number provided to the employee upon registration.',
    `enrollment_source` STRING COMMENT 'Origin or channel through which the enrollment was initiated, such as employee self-service, manager assignment, HR mandate, or compliance requirement.. Valid values are `self_service|manager_assigned|hr_assigned|compliance_required|career_development_plan`',
    `enrollment_status` STRING COMMENT 'Current status of the training enrollment in its lifecycle. Tracks progression from initial enrollment through completion or withdrawal. [ENUM-REF-CANDIDATE: enrolled|in_progress|completed|withdrawn|failed|cancelled|no_show — 7 candidates stripped; promote to reference product]',
    `enrollment_type` STRING COMMENT 'Classification of the enrollment indicating whether the training is mandatory, voluntary, recommended by manager, or assigned by the organization.. Valid values are `mandatory|voluntary|recommended|assigned`',
    `instructor_name` STRING COMMENT 'Full name of the instructor or facilitator delivering the training session for this enrollment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the training enrollment record was last updated or modified in the system.',
    `manager_approval_date` DATE COMMENT 'Date when the employees manager approved the training enrollment request.',
    `manager_approval_flag` BOOLEAN COMMENT 'Indicates whether the employees manager approved the training enrollment, required for certain voluntary or cost-incurring training programs.',
    `mandatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this training enrollment is required for regulatory compliance, licensing, or mandatory organizational policy adherence.',
    `pass_fail_status` STRING COMMENT 'Indicates whether the employee passed or failed the training course based on assessment results and completion criteria.. Valid values are `pass|fail|not_assessed|pending`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training course and receive credit. Used to determine pass/fail status.',
    `scheduled_end_date` DATE COMMENT 'Planned date when the training course or session is scheduled to conclude for this enrollment.',
    `scheduled_start_date` DATE COMMENT 'Planned date when the training course or session is scheduled to begin for this enrollment.',
    `score_achieved` DECIMAL(18,2) COMMENT 'Numeric score or grade achieved by the employee on the training assessment or final exam, typically expressed as a percentage or point value.',
    `training_location` STRING COMMENT 'Physical location, facility name, or virtual platform where the training session is conducted.',
    `withdrawal_date` DATE COMMENT 'Date when the employee withdrew from or was removed from the training course prior to completion.',
    `withdrawal_reason` STRING COMMENT 'Free-text explanation or categorized reason for why the employee withdrew from or did not complete the training course.',
    CONSTRAINT pk_training_enrollment PRIMARY KEY(`training_enrollment_id`)
) COMMENT 'Transactional record of an employees enrollment in and completion of an internal training course. Captures enrollment date, scheduled start date, completion date, score achieved, pass/fail status, completion status (enrolled, in-progress, completed, withdrawn, failed), delivery session identifier, instructor name, and credit hours awarded. Provides the individual training completion history for each employee supporting skills gap analysis, mandatory training compliance, and career development tracking.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` (
    `workforce_performance_review_id` BIGINT COMMENT 'Unique identifier for each formal employee performance evaluation record. Primary key for the workforce performance review entity.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit (department, division, cost center) to which the employee belonged during the review period. Links to the org_unit master record.',
    `position_id` BIGINT COMMENT 'Identifier of the position held by the employee at the time of review. Links to the position master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed. Links to the employee master record in the workforce domain.',
    `quaternary_workforce_created_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who initiated the performance review record. Used for audit trail and accountability.',
    `quinary_workforce_last_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who most recently modified the performance review record. Used for audit trail and change tracking.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the senior manager or HR business partner who reviewed and approved the performance rating during calibration. Links to the employee master record.',
    `tertiary_workforce_final_approver_employee_id` BIGINT COMMENT 'Identifier of the executive or HR leader who provided final approval for the review and associated compensation decisions. Links to the employee master record.',
    `prior_period_workforce_performance_review_id` BIGINT COMMENT 'Self-referencing FK on workforce_performance_review (prior_period_workforce_performance_review_id)',
    `bonus_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee qualifies for a performance bonus based on this review rating. True if eligible, False otherwise. Drives incentive compensation decisions.',
    `calibration_date` DATE COMMENT 'Date when the calibration session was completed and ratings were finalized across the organizational unit.',
    `calibration_status` STRING COMMENT 'Indicates whether the review rating has been through the calibration process where managers collectively review and normalize ratings across teams to ensure consistency and fairness.. Valid values are `not_required|pending|in_progress|completed|exempted`',
    `competency_rating` STRING COMMENT 'Assessment of the employees demonstration of core competencies, behavioral standards, and role-specific skills (e.g., leadership, technical expertise, customer focus).. Valid values are `exceeds|meets|partially_meets|does_not_meet|not_applicable`',
    `competency_score` DECIMAL(18,2) COMMENT 'Numeric score for competency assessment component (e.g., 1.0 to 5.0 scale). Contributes to overall rating calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was first created in the system. Used for audit trail and process timing analysis.',
    `employee_acknowledgement_date` DATE COMMENT 'Date when the employee acknowledged receipt and review of their performance evaluation. Required for compliance and documentation purposes.',
    `employee_acknowledgement_flag` BOOLEAN COMMENT 'Indicates whether the employee has formally acknowledged the performance review. True if acknowledged, False if pending. Tracks completion of the review communication process.',
    `employee_comments` STRING COMMENT 'Self-assessment narrative provided by the employee reflecting on their own performance, accomplishments, challenges, and development needs during the review period.',
    `employee_dispute_flag` BOOLEAN COMMENT 'Indicates whether the employee has formally disputed or disagreed with the performance rating. True if dispute was filed, False otherwise. Triggers HR review and potential appeals process.',
    `employee_self_assessment_flag` BOOLEAN COMMENT 'Indicates whether the employee completed a self-assessment as part of the review process. True if self-assessment was submitted, False otherwise.',
    `final_approval_date` DATE COMMENT 'Date when the final rating and all associated decisions (merit increase, bonus, PIP) were formally approved by senior management or HR leadership.',
    `goal_achievement_rating` STRING COMMENT 'Assessment of the employees success in achieving individual performance goals and objectives set at the beginning of the review period.. Valid values are `exceeds|meets|partially_meets|does_not_meet|not_applicable`',
    `goal_achievement_score` DECIMAL(18,2) COMMENT 'Numeric score for goal achievement component (e.g., 1.0 to 5.0 scale). Contributes to overall rating calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was most recently updated. Tracks the latest change to any field in the review.',
    `manager_comments` STRING COMMENT 'Detailed narrative feedback provided by the manager regarding the employees performance, strengths, areas for development, and specific examples supporting the ratings.',
    `merit_increase_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee qualifies for a merit-based salary increase based on this review rating. True if eligible, False otherwise. Drives compensation planning decisions.',
    `merit_increase_percentage` DECIMAL(18,2) COMMENT 'The percentage salary increase awarded to the employee based on their performance rating. Null if no increase was granted. Used for compensation budget tracking and equity analysis.',
    `overall_rating` STRING COMMENT 'The final, holistic performance rating assigned to the employee for the review period. Drives compensation decisions, promotion eligibility, and performance improvement plans.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score corresponding to the overall rating (e.g., 1.0 to 5.0 scale). Used for quantitative analysis, merit increase calculations, and workforce analytics.',
    `pip_indicator` BOOLEAN COMMENT 'Indicates whether a Performance Improvement Plan was initiated as a result of this review. True if PIP was triggered, False otherwise. Used to track employees requiring formal performance intervention.',
    `pip_start_date` DATE COMMENT 'Date when the Performance Improvement Plan officially commenced. Null if no PIP was initiated.',
    `promotion_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for promotion consideration based on this review rating. True if eligible, False otherwise. Typically requires meeting or exceeding performance expectations.',
    `review_completion_date` DATE COMMENT 'Date when the performance review was finalized and communicated to the employee. Marks the official completion of the review cycle.',
    `review_cycle_year` STRING COMMENT 'The calendar year or fiscal year in which the performance review cycle occurred. Used for year-over-year performance trending and workforce analytics.',
    `review_period_end_date` DATE COMMENT 'The last day of the performance evaluation period being assessed (e.g., December 31 for annual reviews).',
    `review_period_start_date` DATE COMMENT 'The first day of the performance evaluation period being assessed (e.g., January 1 for annual reviews).',
    `review_status` STRING COMMENT 'Current workflow state of the performance review process. Tracks progression from employee self-assessment through final approval. [ENUM-REF-CANDIDATE: draft|submitted|manager_review|calibration|approved|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `review_type` STRING COMMENT 'The category of performance review being conducted. Determines the review cycle, criteria, and business impact (e.g., annual reviews drive merit increases, probationary reviews determine employment continuation).. Valid values are `annual|mid_year|probationary|project_based|promotion|pip_followup`',
    CONSTRAINT pk_workforce_performance_review PRIMARY KEY(`workforce_performance_review_id`)
) COMMENT 'Master and transactional record of each formal employee performance evaluation cycle. Captures review period (annual, mid-year, probationary), review type, overall rating (e.g., exceeds expectations, meets expectations, needs improvement), individual goal ratings, competency ratings, manager comments, employee self-assessment indicator, calibration status, final rating approval date, and performance improvement plan (PIP) indicator. Supports merit increase decisions, promotion eligibility, and workforce development planning.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`performance_goal` (
    `performance_goal_id` BIGINT COMMENT 'Unique identifier for the performance goal record. Primary key.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created this performance goal record.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this performance goal record.',
    `plan_id` BIGINT COMMENT 'Identifier of the employee development plan or training program linked to this goal, if the goal is development-focused.',
    `primary_performance_employee_id` BIGINT COMMENT 'Identifier of the employee to whom this performance goal is assigned.',
    `tertiary_performance_approved_by_employee_id` BIGINT COMMENT 'Identifier of the manager or Human Resources (HR) representative who approved this goal.',
    `workforce_performance_review_id` BIGINT COMMENT 'Foreign key linking to workforce.workforce_performance_review. Business justification: Performance goals are set within the context of a formal performance review cycle. The existing performance_cycle_id (BIGINT) references a non-existent product; workforce_performance_review is the act',
    `parent_performance_goal_id` BIGINT COMMENT 'Self-referencing FK on performance_goal (parent_performance_goal_id)',
    `achievement_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of goal achievement, typically (actual_value / target_value) * 100, used for performance rating and bonus calculation.',
    `actual_completion_date` DATE COMMENT 'Actual date on which the goal was completed or closed.',
    `actual_value` DECIMAL(18,2) COMMENT 'Numeric actual value achieved by the employee for the specified metric at the time of measurement or review.',
    `alignment_to_corporate_objective` STRING COMMENT 'Reference to the corporate strategic objective or Key Result (KR) to which this goal is aligned, supporting cascading goal frameworks such as Objectives and Key Results (OKR) or Management by Objectives (MBO).',
    `approval_date` DATE COMMENT 'Date on which the goal was formally approved.',
    `approval_status` STRING COMMENT 'Approval workflow status for the goal: pending (awaiting manager or Human Resources (HR) approval), approved (finalized), rejected (not accepted), revision_requested (sent back for changes).. Valid values are `pending|approved|rejected|revision_requested`',
    `cascade_source` STRING COMMENT 'Origin of the goal: manager_assigned (cascaded from manager), employee_created (self-initiated), hr_initiated (Human Resources (HR) driven), or system_generated (auto-populated from templates or corporate objectives).. Valid values are `manager_assigned|employee_created|hr_initiated|system_generated`',
    `comments` STRING COMMENT 'Free-text comments or notes from the employee, manager, or Human Resources (HR) regarding goal progress, challenges, or achievements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance goal record was first created in the system.',
    `goal_category` STRING COMMENT 'Classification of the goal by business focus area: financial (revenue, cost), operational (efficiency, quality), development (skills, career), compliance (regulatory, policy), strategic (transformation, innovation), or customer (satisfaction, retention).. Valid values are `financial|operational|development|compliance|strategic|customer`',
    `goal_description` STRING COMMENT 'Detailed narrative description of the performance goal, including expected outcomes and success criteria.',
    `goal_number` STRING COMMENT 'Business-facing unique number or code assigned to this performance goal for tracking and reference purposes.',
    `goal_status` STRING COMMENT 'Current lifecycle status of the performance goal: draft (not yet finalized), active (approved and in effect), in_progress (being worked on), completed (achieved or closed), cancelled (no longer applicable), deferred (postponed to future cycle).. Valid values are `draft|active|in_progress|completed|cancelled|deferred`',
    `goal_title` STRING COMMENT 'Short, descriptive title summarizing the performance goal.',
    `goal_type` STRING COMMENT 'Scope of the goal: individual (employee-specific), team (shared by a team), departmental (division-level), or corporate (enterprise-wide cascade).. Valid values are `individual|team|departmental|corporate`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this goal is mandatory (required for all employees in a role or level) or optional.',
    `is_stretch_goal` BOOLEAN COMMENT 'Indicates whether this is a stretch goal (aspirational, beyond normal expectations) versus a standard performance goal.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance goal record was last updated.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review or check-in for this goal.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review or check-in for this goal.',
    `performance_rating` STRING COMMENT 'Qualitative rating assigned to the goal achievement: exceeds (surpassed target), meets (achieved target), partially_meets (made progress but did not fully achieve), does_not_meet (failed to achieve), not_rated (not yet evaluated).. Valid values are `exceeds|meets|partially_meets|does_not_meet|not_rated`',
    `review_frequency` STRING COMMENT 'Cadence at which progress toward this goal is formally reviewed: monthly, quarterly, semi-annually, annually, or continuous (ongoing tracking).. Valid values are `monthly|quarterly|semi_annually|annually|continuous`',
    `start_date` DATE COMMENT 'Date on which the performance goal becomes effective and tracking begins.',
    `target_completion_date` DATE COMMENT 'Expected date by which the goal should be achieved or reviewed.',
    `target_metric_name` STRING COMMENT 'Name of the key performance indicator (KPI) or metric being measured for this goal (e.g., New Business (NB) Annual Premium Equivalent (APE), Claims Adjudication Cycle Time, Underwriting Accuracy Rate).',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target value the employee is expected to achieve for the specified metric.',
    `unit_of_measure` STRING COMMENT 'Unit in which the target and actual values are expressed (e.g., USD, percentage, count, days, policies).',
    `weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight of this goal in the employees overall performance evaluation, typically summing to 100% across all goals for the cycle.',
    CONSTRAINT pk_performance_goal PRIMARY KEY(`performance_goal_id`)
) COMMENT 'Master record of individual performance goals set for an employee within a performance review cycle. Captures goal title, goal description, goal category (financial, operational, development, compliance), target metric, target value, actual value, weight percentage, goal status (draft, active, completed, cancelled), alignment to corporate objective, and cascade source (manager-assigned vs. employee-created). Supports MBO (Management by Objectives) frameworks and OKR-style goal alignment across the enterprise.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for each employee leave request transaction. Primary key for the leave request record.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created the leave request record in the system (typically the employee or HR administrator).',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified the leave request record in the system (employee, manager, or HR administrator).',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit (department, division) to which the employee belongs. Used for leave analytics and workforce planning by business unit.',
    `position_id` BIGINT COMMENT 'Identifier of the position held by the employee at the time of the leave request. Used for workforce capacity planning and backfill analysis.',
    `primary_leave_employee_id` BIGINT COMMENT 'Identifier of the employee submitting the leave request. Links to the employee master record.',
    `tertiary_leave_substitute_employee_id` BIGINT COMMENT 'Identifier of the employee assigned to cover the absent employees responsibilities during the leave period. Used for workforce continuity planning.',
    `extended_leave_request_id` BIGINT COMMENT 'Self-referencing FK on leave_request (extended_leave_request_id)',
    `actual_return_date` DATE COMMENT 'Date the employee actually returned to work following the leave period. May differ from approved end date if leave was extended or employee returned early.',
    `approval_date` DATE COMMENT 'Date when the leave request was approved by the manager. Used for tracking approval timeliness and audit trail.',
    `approved_end_date` DATE COMMENT 'Date approved by management for the leave period to end. This is the expected return-to-work date for workforce planning purposes.',
    `approved_start_date` DATE COMMENT 'Date approved by management for the leave period to begin. This is the official start date for payroll and workforce planning purposes.',
    `cancellation_reason` STRING COMMENT 'Explanation provided by the employee or manager for cancelling the leave request after initial submission or approval.',
    `comments` STRING COMMENT 'Free-text comments or notes provided by the employee, manager, or HR regarding the leave request. Used for additional context and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the leave request record was first created in the system. Used for audit trail and data lineage tracking.',
    `denial_reason` STRING COMMENT 'Explanation provided by the manager for denying the leave request. Required for denied requests to support compliance and employee relations.',
    `fmla_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for FMLA protection for this leave request based on tenure, hours worked, and employer size requirements.',
    `fmla_qualifying_reason` STRING COMMENT 'The specific FMLA qualifying reason for the leave request (e.g., serious health condition of employee, birth/adoption of child, care for family member with serious health condition, military family leave).',
    `intermittent_leave_flag` BOOLEAN COMMENT 'Indicates whether this is an intermittent leave request (taken in separate blocks of time rather than one continuous period) or a reduced schedule leave.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the leave request record was last updated in the system. Used for audit trail and change tracking.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'Remaining leave balance (in days or hours) for the applicable leave type after this request was processed. Used for entitlement tracking and future request validation.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'Available leave balance (in days or hours) for the applicable leave type before this request was processed. Used for entitlement tracking.',
    `leave_status` STRING COMMENT 'Current workflow status of the leave request. Pending (awaiting approval), Approved (authorized by manager), Denied (rejected), Cancelled (withdrawn by employee), In-Progress (leave period active), Closed (leave completed and employee returned).. Valid values are `pending|approved|denied|cancelled|in-progress|closed`',
    `leave_type` STRING COMMENT 'Classification of leave request type. FMLA (Family and Medical Leave Act), ADA (Americans with Disabilities Act accommodation), Military (military service leave), Bereavement (death of family member), PTO (Paid Time Off), Sick (illness leave), Parental (maternity/paternity), STD (Short-Term Disability), LTD (Long-Term Disability). [ENUM-REF-CANDIDATE: FMLA|ADA|Military|Bereavement|PTO|Sick|Parental|STD|LTD — 9 candidates stripped; promote to reference product]',
    `medical_certification_received_date` DATE COMMENT 'Date when medical certification documentation was received by HR. Used for tracking compliance with FMLA certification deadlines.',
    `medical_certification_received_flag` BOOLEAN COMMENT 'Indicates whether required medical certification documentation has been received and validated by HR.',
    `medical_certification_required_flag` BOOLEAN COMMENT 'Indicates whether medical certification documentation is required for this leave request (typically for FMLA, ADA, STD, LTD leave types).',
    `paid_leave_flag` BOOLEAN COMMENT 'Indicates whether the leave period is paid (using accrued PTO, sick time, or disability benefits) or unpaid.',
    `request_date` DATE COMMENT 'Date when the employee submitted the leave request. Used for tracking request timeliness and compliance with advance notice requirements.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the leave request, used for tracking and reference in HR systems and employee communications.. Valid values are `^LR-[0-9]{8}$`',
    `requested_end_date` DATE COMMENT 'Date the employee requested to end the leave period and return to work. May differ from approved end date or actual return date.',
    `requested_start_date` DATE COMMENT 'Date the employee requested to begin the leave period. May differ from approved start date if modified during approval process.',
    `total_days_approved` DECIMAL(18,2) COMMENT 'Total number of calendar or business days approved by management for this leave period. Used for payroll calculations and FMLA entitlement tracking.',
    `total_days_requested` DECIMAL(18,2) COMMENT 'Total number of calendar or business days requested by the employee for this leave period. May include partial days for intermittent leave.',
    `total_hours_approved` DECIMAL(18,2) COMMENT 'Total number of work hours approved for this leave period. Used for payroll calculations and FMLA hour-based entitlement tracking.',
    `total_hours_requested` DECIMAL(18,2) COMMENT 'Total number of work hours requested for this leave period. Used for hourly employees and intermittent leave tracking.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Transactional record of each employee leave request and approval event. Captures leave type (FMLA, ADA accommodation, military, bereavement, PTO, sick, parental, short-term disability, long-term disability), requested start date, requested end date, approved start date, approved end date, total days requested, total days approved, leave status (pending, approved, denied, cancelled, in-progress, closed), FMLA eligibility indicator, intermittent leave indicator, and return-to-work date. Supports FMLA compliance tracking and workforce availability planning.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`time_record` (
    `time_record_id` BIGINT COMMENT 'Unique identifier for the time and attendance record. Primary key for the time_record product.',
    `payroll_period_id` BIGINT COMMENT 'Reference to the payroll period in which this time entry will be processed for payment. Links to the payroll calendar.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who recorded this time entry. Links to the employee master record in the workforce domain.',
    `tertiary_time_adjusted_by_employee_id` BIGINT COMMENT 'Reference to the employee (typically HR or manager) who made an adjustment to this time entry. Used for audit trail and accountability.',
    `work_schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.work_schedule. Business justification: Time records are validated against work schedules. This links each time entry to the employees assigned work schedule, enabling schedule compliance validation, overtime calculation, and shift differen',
    `corrected_time_record_id` BIGINT COMMENT 'Self-referencing FK on time_record (corrected_time_record_id)',
    `activity_code` STRING COMMENT 'Code representing the type of work activity performed during this time entry (e.g., underwriting, claims processing, actuarial analysis). Used for activity-based costing and productivity analysis.',
    `adjustment_reason` STRING COMMENT 'Reason for any manual adjustment made to this time entry after initial submission. Used for audit trail and compliance documentation.',
    `adjustment_timestamp` TIMESTAMP COMMENT 'The date and time when this time entry was last adjusted. Used for audit trail and change tracking.',
    `approval_status` STRING COMMENT 'Current approval status of this time entry in the workflow. Time entries must be approved before being processed for payroll.. Valid values are `pending|approved|rejected|submitted|draft`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this time entry was approved. Used for audit trail and payroll processing cutoff determination.',
    `break_duration_minutes` STRING COMMENT 'Total duration of unpaid breaks taken during this work shift, measured in minutes. Deducted from total hours worked for payroll calculation.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'The precise date and time when the employee clocked in or started their work shift. Used for calculating total hours worked and overtime compliance.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'The precise date and time when the employee clocked out or ended their work shift. Used for calculating total hours worked and overtime compliance.',
    `cost_center_code` STRING COMMENT 'The cost center to which this time entrys labor cost should be allocated. Used for departmental expense tracking and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this time record was first created in the system. Used for audit trail and data lineage tracking.',
    `exception_code` STRING COMMENT 'Code indicating any time and attendance exception or violation (e.g., late arrival, early departure, missed punch, unauthorized overtime). Used for compliance monitoring and corrective action.',
    `exception_notes` STRING COMMENT 'Free-text notes explaining any time and attendance exceptions or special circumstances for this time entry. Used for manager review and audit documentation.',
    `holiday_hours` DECIMAL(18,2) COMMENT 'The number of hours worked on a company-recognized holiday. May be eligible for premium pay rates per company policy.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this time record was last modified. Used for audit trail and change tracking.',
    `meal_break_duration_minutes` STRING COMMENT 'Duration of unpaid meal break taken during this work shift, measured in minutes. Required by law in many jurisdictions for shifts exceeding certain hours.',
    `overtime_hours_worked` DECIMAL(18,2) COMMENT 'The number of overtime hours worked during this time entry, typically hours exceeding 40 per week or 8 per day depending on jurisdiction. Used for overtime premium calculation and FLSA compliance reporting.',
    `payroll_batch_number` STRING COMMENT 'Identifier of the payroll batch run that processed this time entry. Used for payroll reconciliation and audit purposes.',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether this time entry has been processed in a payroll run. Once true, the record is typically locked from further edits.',
    `project_code` STRING COMMENT 'Optional project identifier for time entries allocated to specific projects or initiatives. Used for project cost accounting and resource utilization analysis.',
    `pto_hours_used` DECIMAL(18,2) COMMENT 'The number of paid time off hours used during this time entry. Reduces the employees available PTO balance and is paid at regular rate.',
    `regular_hours_worked` DECIMAL(18,2) COMMENT 'The number of regular (non-overtime) hours worked during this time entry. Used for standard payroll calculation and labor cost allocation.',
    `shift_type` STRING COMMENT 'The type of work shift for this time entry. Used for shift differential pay calculation and workforce scheduling analytics.. Valid values are `day|evening|night|split|on_call|weekend`',
    `sick_hours_used` DECIMAL(18,2) COMMENT 'The number of sick leave hours used during this time entry. Reduces the employees available sick leave balance and is paid at regular rate.',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when this time entry was submitted for approval. Used for workflow tracking and timeliness monitoring.',
    `time_entry_method` STRING COMMENT 'The method by which this time entry was captured. Used for audit purposes and to identify potential time fraud patterns.. Valid values are `biometric|badge_swipe|manual|mobile_app|web_portal|supervisor_entry`',
    `work_date` DATE COMMENT 'The calendar date for which this time entry applies. Used for payroll period assignment and labor cost allocation.',
    `work_location_code` BIGINT COMMENT 'Reference to the physical work location where the employee performed work during this time entry. Used for facility cost allocation and occupancy tracking.',
    `work_location_type` STRING COMMENT 'The location type where the employee performed work during this time entry. Used for remote work policy compliance and facility capacity planning.. Valid values are `in_office|remote|hybrid|field|client_site`',
    CONSTRAINT pk_time_record PRIMARY KEY(`time_record_id`)
) COMMENT 'Transactional record of employee time and attendance entries for a given work period. Captures work date, clock-in time, clock-out time, regular hours worked, overtime hours worked, holiday hours, PTO hours used, sick hours used, shift type (day, evening, night), work location type (in-office, remote, hybrid), cost center charged, and approval status. Supports payroll processing, overtime compliance under FLSA, and labor cost allocation to underwriting, claims, actuarial, and other functional departments.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'Unique identifier for the headcount plan record. Primary key for workforce capacity planning and budgeting.',
    `approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who approved this headcount plan.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created this headcount plan record.',
    `job_role_id` BIGINT COMMENT 'Foreign key linking to workforce.job_role. Business justification: Headcount planning records reference job_family and job_level (STRING) which should be normalized to job_role master. This enables consistent workforce planning by role, competency gap analysis, and b',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this headcount plan record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit for which this headcount plan applies.',
    `position_id` BIGINT COMMENT 'Reference to the specific position or job role covered by this headcount plan.',
    `prior_period_headcount_plan_id` BIGINT COMMENT 'Self-referencing FK on headcount_plan (prior_period_headcount_plan_id)',
    `approval_date` DATE COMMENT 'Date when the headcount plan was formally approved by authorized management.',
    `approved_headcount` DECIMAL(18,2) COMMENT 'Total approved headcount for this organizational unit, job family, and planning period, expressed in Full-Time Equivalent (FTE) units.',
    `attrition_assumption_percentage` DECIMAL(18,2) COMMENT 'Assumed attrition rate as a percentage for this organizational unit and job family, used for backfill planning.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation budget amount.. Valid values are `^[A-Z]{3}$`',
    `business_justification` STRING COMMENT 'Detailed business justification for the headcount plan, explaining capacity needs, workload drivers, and strategic alignment.',
    `capacity_driver` STRING COMMENT 'Primary business driver for this headcount plan (e.g., new business volume, claims workload, regulatory compliance, strategic initiative). [ENUM-REF-CANDIDATE: new_business_volume|claims_workload|regulatory_compliance|strategic_initiative|technology_transformation|market_expansion|operational_efficiency — 7 candidates stripped; promote to reference product]',
    `compensation_budget_amount` DECIMAL(18,2) COMMENT 'Total compensation budget amount allocated for this headcount plan, including salaries, bonuses, and benefits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this headcount plan record was first created in the system.',
    `critical_role_flag` BOOLEAN COMMENT 'Indicates whether this headcount plan covers critical roles essential for business continuity and regulatory compliance.',
    `current_filled_headcount` DECIMAL(18,2) COMMENT 'Current number of filled positions in Full-Time Equivalent (FTE) units as of the plan snapshot date.',
    `fte_budget` DECIMAL(18,2) COMMENT 'Total Full-Time Equivalent (FTE) budget allocated for this organizational unit and job family for the planning period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this headcount plan record was last modified or updated.',
    `open_headcount` DECIMAL(18,2) COMMENT 'Number of open or vacant positions in Full-Time Equivalent (FTE) units, calculated as approved minus filled headcount.',
    `plan_code` STRING COMMENT 'Business identifier code for the headcount plan, used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `plan_effective_date` DATE COMMENT 'Date when this headcount plan becomes effective and binding for workforce planning.',
    `plan_end_date` DATE COMMENT 'Date when this headcount plan expires or is superseded by a new plan.',
    `plan_name` STRING COMMENT 'Descriptive name of the headcount plan for business user identification.',
    `plan_notes` STRING COMMENT 'Additional notes, comments, or context regarding this headcount plan for internal reference.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the headcount plan (draft, submitted, approved, locked, rejected, superseded).. Valid values are `draft|submitted|approved|locked|rejected|superseded`',
    `planned_backfills` DECIMAL(18,2) COMMENT 'Number of backfill positions planned to replace attrition in Full-Time Equivalent (FTE) units.',
    `planned_eliminations` DECIMAL(18,2) COMMENT 'Number of positions planned for elimination or reduction in Full-Time Equivalent (FTE) units.',
    `planned_new_hires` DECIMAL(18,2) COMMENT 'Number of new hire positions planned for this period in Full-Time Equivalent (FTE) units, representing net growth.',
    `planning_month` STRING COMMENT 'Month within the planning year (1-12), applicable for monthly planning periods.',
    `planning_period_type` STRING COMMENT 'Type of planning period for this headcount plan (annual, quarterly, monthly, semi-annual).. Valid values are `annual|quarterly|monthly|semi_annual`',
    `planning_quarter` STRING COMMENT 'Fiscal quarter within the planning year (1-4), applicable for quarterly planning periods.',
    `planning_year` STRING COMMENT 'Fiscal or calendar year for which this headcount plan is effective.',
    `productivity_assumption` DECIMAL(18,2) COMMENT 'Assumed productivity rate per Full-Time Equivalent (FTE) used to calculate required headcount from workload volume.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this headcount plan is driven by regulatory requirements (e.g., National Association of Insurance Commissioners (NAIC) staffing mandates, State Department of Insurance requirements).',
    `succession_plan_exists_flag` BOOLEAN COMMENT 'Indicates whether a succession plan exists for the positions covered by this headcount plan.',
    `version_number` STRING COMMENT 'Version number of this headcount plan, incremented with each revision or update.',
    `workload_volume_assumption` DECIMAL(18,2) COMMENT 'Assumed workload volume (e.g., number of policies, claims, applications) that drives the headcount requirement for this plan.',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'Master record for workforce capacity planning and headcount budgeting by org unit, job family, and planning period. Captures planning period (annual, quarterly), org unit, job family, approved headcount, current filled headcount, open headcount, attrition assumption percentage, planned new hires, planned backfills, planned eliminations, FTE budget, and plan status (draft, approved, locked). Supports actuarial and underwriting capacity planning to ensure adequate staffing for new business volumes and claims workloads.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Unique identifier for the position requisition record. Primary key for the requisition entity.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created this requisition record in the system.',
    `headcount_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.headcount_plan. Business justification: Requisitions fulfill approved headcount plans. This links the talent acquisition process (requisition) to the workforce capacity planning process (headcount_plan), enabling budget tracking, plan vs. a',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this requisition record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit or department where the position will be located.',
    `position_id` BIGINT COMMENT 'Reference to the position template or job profile that this requisition is hiring for.',
    `requisition_hiring_manager_employee_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager responsible for this requisition and will supervise the hired candidate.',
    `requisition_recruiter_employee_id` BIGINT COMMENT 'Reference to the internal recruiter or talent acquisition specialist assigned to manage this requisition.',
    `requisition_replacement_employee_id` BIGINT COMMENT 'Reference to the employee being replaced, if this is a backfill or replacement requisition. Used for knowledge transfer planning and transition management.',
    `replacement_requisition_id` BIGINT COMMENT 'Self-referencing FK on requisition (replacement_requisition_id)',
    `actual_time_to_fill_days` STRING COMMENT 'Actual number of days taken to fill this requisition from open date to offer acceptance. Key recruiting performance metric.',
    `approval_status` STRING COMMENT 'Status of the requisition approval workflow indicating whether the requisition has been submitted, is pending review, approved by all required approvers, rejected, or withdrawn.. Valid values are `not_submitted|pending|approved|rejected|withdrawn`',
    `budget_year` STRING COMMENT 'Fiscal year for which this requisition is budgeted and approved. Used for headcount planning and budget tracking.',
    `close_date` DATE COMMENT 'Date when the requisition was closed, either due to being filled, cancelled, or withdrawn. Used for time-to-fill and recruiting cycle analytics.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the salary and benefits for this position will be charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this requisition record was first created in the system.',
    `employment_type` STRING COMMENT 'Type of employment arrangement for the position (full-time, part-time, contract, temporary, intern).. Valid values are `full_time|part_time|contract|temporary|intern`',
    `fte_count` DECIMAL(18,2) COMMENT 'Number of full-time equivalent positions represented by this requisition. Typically 1.0 for full-time, may be fractional for part-time roles.',
    `headcount_approved` STRING COMMENT 'Number of positions approved to be filled under this requisition. Typically 1, but may be greater for bulk hiring.',
    `is_critical_role` BOOLEAN COMMENT 'Indicates whether this position is designated as a critical role for business operations or strategic initiatives, requiring expedited or specialized recruiting attention.',
    `job_description` STRING COMMENT 'Detailed description of the position responsibilities, qualifications, and requirements used for job postings and candidate communication.',
    `job_family` STRING COMMENT 'Broad occupational category or job family for the requisition (e.g., Actuarial, Underwriting, Claims, Sales, IT, Finance).',
    `job_level` STRING COMMENT 'Organizational level or grade of the position (e.g., Entry, Mid, Senior, Manager, Director, VP).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this requisition record was last modified in the system.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for the position (e.g., High School, Associate Degree, Bachelor Degree, Master Degree, Doctorate).',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of relevant work experience required for the position.',
    `open_date` DATE COMMENT 'Date when the requisition was officially opened and active recruiting began. Key metric for time-to-fill calculations.',
    `posting_title` STRING COMMENT 'The job title used in external job postings and advertisements. May be optimized for search and candidate attraction, differing from internal position title.',
    `primary_work_location_code` BIGINT COMMENT 'Reference to the primary office or work location where the position will be based, if applicable.',
    `priority_level` STRING COMMENT 'Business priority assigned to this requisition indicating urgency of filling the position.. Valid values are `low|medium|high|critical`',
    `requires_actuarial_credential` BOOLEAN COMMENT 'Indicates whether the position requires actuarial credentials such as Associate of the Society of Actuaries (ASA), Fellow of the Society of Actuaries (FSA), or similar designations.',
    `requires_finra_registration` BOOLEAN COMMENT 'Indicates whether the position requires FINRA registration (e.g., Series 6, Series 7, Series 63) for selling variable insurance products or securities.',
    `requires_insurance_license` BOOLEAN COMMENT 'Indicates whether the position requires the candidate to hold or obtain a state insurance license (e.g., for agent, underwriter, or producer roles).',
    `requisition_number` STRING COMMENT 'Business-facing unique requisition number used for tracking and reference in the talent acquisition process. Externally visible identifier.. Valid values are `^REQ-[0-9]{6,10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the requisition in the talent acquisition workflow (draft, pending approval, open for sourcing, on hold, in progress with candidates, filled, cancelled, closed). [ENUM-REF-CANDIDATE: draft|pending_approval|open|on_hold|in_progress|filled|cancelled|closed — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the requisition indicating whether it is for new headcount growth, backfill of a vacated position, replacement, contract-to-hire conversion, temporary assignment, internship, or seasonal role. [ENUM-REF-CANDIDATE: new_headcount|backfill|replacement|contract_to_hire|temporary|intern|seasonal — 7 candidates stripped; promote to reference product]',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary range (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'Maximum salary amount for the position salary range. Used for budgeting and offer negotiation guidance.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'Minimum salary amount for the position salary range. Used for budgeting and offer negotiation guidance.',
    `sourcing_channels` STRING COMMENT 'Comma-separated list of recruiting channels being used or planned for this requisition (e.g., internal posting, job boards, LinkedIn, agency, employee referral, campus recruiting).',
    `target_start_date` DATE COMMENT 'Desired or planned start date for the new hire to begin employment. Used for workforce planning and recruiting timeline management.',
    `time_to_fill_target_days` STRING COMMENT 'Target number of days to fill this requisition from open date to offer acceptance. Used for recruiting performance measurement and Service Level Agreement (SLA) tracking.',
    `travel_requirement_percentage` STRING COMMENT 'Percentage of time the position requires business travel (0-100). Important for candidate expectations and role planning.',
    `work_location_type` STRING COMMENT 'Type of work arrangement for the position indicating whether it is onsite at a company location, fully remote, or hybrid.. Valid values are `onsite|remote|hybrid`',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Master and transactional record for each open position requisition in the talent acquisition process. Captures requisition number, position title, job role, org unit, hiring manager, requisition type (new headcount, backfill, contract-to-hire), target start date, approved headcount count, requisition status (draft, open, on-hold, filled, cancelled), sourcing channels used, time-to-fill target days, and whether the role requires an insurance license or actuarial designation. Drives the recruiting workflow from job posting through offer acceptance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`candidate` (
    `candidate_id` BIGINT COMMENT 'Unique identifier for each candidate who has applied for or been considered for a position at Life Insurance. Primary key for the candidate entity.',
    `employee_id` BIGINT COMMENT 'Employee ID of the hiring manager or department head who is responsible for the final hiring decision for this candidate.',
    `candidate_recruiter_employee_id` BIGINT COMMENT 'Employee ID of the internal recruiter or talent acquisition specialist assigned to manage this candidates recruitment process.',
    `candidate_referral_source_employee_id` BIGINT COMMENT 'Employee ID of the internal employee who referred this candidate, if the source channel was employee referral.',
    `referred_by_candidate_id` BIGINT COMMENT 'Self-referencing FK on candidate (referred_by_candidate_id)',
    `actual_start_date` DATE COMMENT 'The actual date on which the candidate began employment with Life Insurance.',
    `application_date` DATE COMMENT 'The date on which the candidate submitted their application or was first entered into the recruitment system.',
    `background_check_date` DATE COMMENT 'The date on which the background check was completed for the candidate.',
    `background_check_status` STRING COMMENT 'Status of the background check process for the candidate (e.g., not started, in progress, clear, conditional, failed).. Valid values are `not_started|in_progress|clear|conditional|failed`',
    `candidate_status` STRING COMMENT 'Current status of the candidate in the recruitment pipeline (e.g., active, screening, interviewing, offer extended, hired, rejected, withdrawn). [ENUM-REF-CANDIDATE: active|screening|interviewing|offer_extended|hired|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this candidate record was first created in the system.',
    `current_employer` STRING COMMENT 'The name of the organization where the candidate is currently employed, if applicable.',
    `degree_field` STRING COMMENT 'The primary field of study or major for the candidates highest degree (e.g., Actuarial Science, Finance, Business Administration, Computer Science).',
    `disability_status` STRING COMMENT 'Self-identified disability status of the candidate for EEOC and OFCCP reporting purposes. Voluntary disclosure.. Valid values are `yes|no|decline_to_state`',
    `drug_test_date` DATE COMMENT 'The date on which the drug screening test was administered or completed.',
    `drug_test_status` STRING COMMENT 'Status of the pre-employment drug screening test for the candidate (e.g., not required, scheduled, passed, failed, pending).. Valid values are `not_required|scheduled|passed|failed|pending`',
    `eeoc_ethnicity` STRING COMMENT 'Self-identified ethnicity or race of the candidate for EEOC reporting and diversity tracking purposes. Voluntary disclosure. [ENUM-REF-CANDIDATE: hispanic_latino|white|black_african_american|asian|native_hawaiian_pacific_islander|american_indian_alaska_native|two_or_more_races|decline_to_state — promote to reference product]',
    `eeoc_gender` STRING COMMENT 'Self-identified gender of the candidate for EEOC reporting and diversity tracking purposes. Voluntary disclosure.. Valid values are `male|female|non_binary|decline_to_state`',
    `email_address` STRING COMMENT 'Primary email address used for candidate communication and correspondence throughout the recruitment process.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expected_start_date` DATE COMMENT 'The anticipated or agreed-upon date on which the candidate is expected to begin employment if hired.',
    `first_name` STRING COMMENT 'The first or given name of the candidate as provided in the application.',
    `highest_education_level` STRING COMMENT 'The highest level of formal education completed by the candidate (e.g., high school, associate degree, bachelor degree, master degree, doctorate, professional degree).. Valid values are `high_school|associate|bachelor|master|doctorate|professional`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this candidate record was most recently updated or modified.',
    `last_name` STRING COMMENT 'The last or family name of the candidate as provided in the application.',
    `middle_name` STRING COMMENT 'The middle name or initial of the candidate, if provided.',
    `notes` STRING COMMENT 'Free-form text field for recruiters and hiring managers to capture additional notes, observations, or comments about the candidate throughout the recruitment process.',
    `offer_accepted_date` DATE COMMENT 'The date on which the candidate accepted the employment offer.',
    `offer_declined_date` DATE COMMENT 'The date on which the candidate declined the employment offer.',
    `offer_extended_date` DATE COMMENT 'The date on which a formal employment offer was extended to the candidate.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the candidate, used for interview scheduling and recruitment communication.',
    `position_applied_for` STRING COMMENT 'The job title or position name that the candidate applied for or is being considered for.',
    `professional_designations` STRING COMMENT 'Comma-separated list of relevant professional designations and certifications held by the candidate (e.g., FSA, MAAA, CLU, CPCU, ChFC, CFP, CFA, CPA, FLMI).',
    `rejection_reason` STRING COMMENT 'The primary reason or category for rejecting the candidates application (e.g., qualifications not met, failed background check, position filled, candidate withdrew).',
    `resume_on_file_flag` BOOLEAN COMMENT 'Indicates whether a resume or curriculum vitae document has been received and stored for this candidate.',
    `salary_expectation_amount` DECIMAL(18,2) COMMENT 'The candidates stated salary expectation or requirement for the position, if disclosed during the application or interview process.',
    `salary_expectation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary expectation amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `source_channel` STRING COMMENT 'The channel or method through which the candidate was sourced or applied (e.g., job board, employee referral, recruiting agency, direct application, career site, social media).. Valid values are `job_board|referral|agency|direct|career_site|social_media`',
    `veteran_status` STRING COMMENT 'Self-identified veteran status of the candidate for EEOC and OFCCP reporting purposes. Voluntary disclosure. [ENUM-REF-CANDIDATE: protected_veteran|non_veteran|decline_to_state|disabled_veteran|recently_separated_veteran|active_duty_wartime_veteran|armed_forces_service_medal_veteran — promote to reference product]',
    `willing_to_relocate_flag` BOOLEAN COMMENT 'Indicates whether the candidate has expressed willingness to relocate for the position.',
    `withdrawal_reason` STRING COMMENT 'The reason provided by the candidate for withdrawing their application (e.g., accepted another offer, no longer interested, relocation issues).',
    `work_authorization_status` STRING COMMENT 'The candidates current work authorization status in the country where the position is located (e.g., citizen, permanent resident, work visa holder, requires sponsorship).. Valid values are `citizen|permanent_resident|work_visa|requires_sponsorship`',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total number of years of relevant professional experience the candidate has accumulated in their career.',
    CONSTRAINT pk_candidate PRIMARY KEY(`candidate_id`)
) COMMENT 'Master record for each individual who has applied for or been considered for a position at Life Insurance. Captures candidate name, source channel (job board, referral, agency, direct), application date, current employer, years of experience, highest education level, relevant designations (FSA, MAAA, CLU, CPCU), resume indicator, candidate status (active, hired, rejected, withdrawn), background check status, and EEOC self-identification data. Supports talent pipeline management and diversity recruiting reporting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`interview_event` (
    `interview_event_id` BIGINT COMMENT 'Unique identifier for each interview event conducted as part of the talent acquisition process.',
    `candidate_id` BIGINT COMMENT 'Reference to the candidate being interviewed.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or recruiter who created this interview event record.',
    `document_id` BIGINT COMMENT 'Reference to the document management system identifier for detailed interview notes and supporting documentation.',
    `interview_scorecard_id` BIGINT COMMENT 'Reference to the standardized interview scorecard or evaluation template used for this interview.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who most recently modified this interview event record.',
    `primary_interviewer_employee_id` BIGINT COMMENT 'Reference to the employee who served as the lead or primary interviewer for this interview event.',
    `requisition_id` BIGINT COMMENT 'Reference to the job requisition for which this interview was conducted.',
    `rescheduled_from_interview_event_id` BIGINT COMMENT 'Reference to the original interview event ID if this interview is a rescheduled version of a previous interview.',
    `follow_up_interview_event_id` BIGINT COMMENT 'Self-referencing FK on interview_event (follow_up_interview_event_id)',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the interview concluded.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the interview began, which may differ from the scheduled start time.',
    `behavioral_competency_rating` DECIMAL(18,2) COMMENT 'Rating of the candidates behavioral attributes, soft skills, cultural fit, and alignment with company values.',
    `cancellation_reason` STRING COMMENT 'Explanation or reason code for why the interview was cancelled, if applicable (e.g., candidate withdrew, position closed, scheduling conflict).',
    `communication_skills_rating` DECIMAL(18,2) COMMENT 'Rating of the candidates verbal and written communication effectiveness, clarity, and professionalism.',
    `concerns_noted` STRING COMMENT 'Specific concerns, weaknesses, or areas of improvement identified during the interview.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this interview event record was first created in the system.',
    `cultural_fit_rating` DECIMAL(18,2) COMMENT 'Rating of how well the candidates values, work style, and personality align with the organizations culture.',
    `disposition_reason` STRING COMMENT 'Reason code or explanation for the interview outcome or status change (e.g., candidate declined, skills mismatch, position filled, proceeding to next round).',
    `diversity_panel_flag` BOOLEAN COMMENT 'Indicates whether this interview included a diverse panel of interviewers as part of the organizations diversity and inclusion hiring practices.',
    `duration_minutes` STRING COMMENT 'The total length of the interview in minutes, calculated from actual start and end times.',
    `hire_recommendation` STRING COMMENT 'The interviewers recommendation on whether to proceed with hiring this candidate (strong yes, yes, maybe, no, strong no).. Valid values are `strong_yes|yes|maybe|no|strong_no`',
    `interview_format` STRING COMMENT 'The delivery method or medium through which the interview was conducted (in-person, video conference, phone call, or asynchronous recorded).. Valid values are `in_person|video|phone|asynchronous`',
    `interview_location` STRING COMMENT 'Physical location, office address, or virtual meeting platform URL where the interview took place.',
    `interview_panel_employee_ids` STRING COMMENT 'Comma-separated list of employee IDs representing all interviewers who participated in this interview event, including the primary interviewer.',
    `interview_round_number` STRING COMMENT 'Sequential number indicating which round of interviews this represents in the hiring process (e.g., 1 for first round, 2 for second round).',
    `interview_status` STRING COMMENT 'Current status of the interview event in its lifecycle (scheduled, completed, cancelled by company or candidate, candidate no-show, or rescheduled).. Valid values are `scheduled|completed|cancelled|no_show|rescheduled`',
    `interview_type` STRING COMMENT 'Classification of the interview based on its purpose and structure (phone screen, technical assessment, behavioral interview, panel interview, final interview, or case study).. Valid values are `phone_screen|technical|behavioral|panel|final|case_study`',
    `interviewer_feedback_summary` STRING COMMENT 'Consolidated textual summary of the interviewers observations, comments, and assessment of the candidates performance during the interview.',
    `interviewer_training_completed_flag` BOOLEAN COMMENT 'Indicates whether the primary interviewer has completed required interviewer training and certification to conduct compliant, bias-free interviews.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this interview event record was most recently updated.',
    `next_step_action` STRING COMMENT 'Recommended or planned next action in the hiring process following this interview (e.g., schedule final interview, extend offer, send rejection, request additional references).',
    `overall_rating` DECIMAL(18,2) COMMENT 'Composite numerical rating assigned to the candidate based on interview performance, typically on a scale such as 1.00 to 5.00.',
    `problem_solving_rating` DECIMAL(18,2) COMMENT 'Rating of the candidates analytical thinking, problem-solving approach, and ability to handle complex scenarios.',
    `rating_scale` STRING COMMENT 'Description of the rating scale used for evaluation (e.g., 1-5 scale where 5 is excellent, Strong Hire/Hire/No Hire).',
    `recording_consent_obtained` BOOLEAN COMMENT 'Indicates whether the candidate provided explicit consent for the interview to be recorded (audio or video), as required by applicable privacy laws.',
    `recording_url` STRING COMMENT 'Secure storage location or URL where the interview recording is archived, if recording was conducted and consented to.',
    `scheduled_date` DATE COMMENT 'The date on which the interview was originally scheduled to occur.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time when the interview was scheduled to end.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the interview was scheduled to begin.',
    `strengths_noted` STRING COMMENT 'Specific strengths, positive attributes, or standout qualities observed during the interview.',
    `structured_interview_compliance_flag` BOOLEAN COMMENT 'Indicates whether the interview followed the organizations structured interview process and standardized question set to ensure fairness and legal compliance.',
    `technical_competency_rating` DECIMAL(18,2) COMMENT 'Rating of the candidates technical skills and job-specific competencies relevant to the position (e.g., actuarial knowledge, underwriting expertise, claims adjudication skills).',
    CONSTRAINT pk_interview_event PRIMARY KEY(`interview_event_id`)
) COMMENT 'Transactional record of each interview conducted as part of the talent acquisition process for a requisition. Captures interview date, interview type (phone screen, technical, behavioral, panel, final), interviewer employee IDs, candidate ID, requisition ID, interview format (in-person, video, phone), overall interview rating, hire recommendation (yes, no, maybe), interviewer feedback summary, and disposition reason. Supports structured interview process compliance and hiring decision audit trails.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`offer` (
    `offer_id` BIGINT COMMENT 'Unique identifier for the employment offer record. Primary key for the offer entity.',
    `candidate_id` BIGINT COMMENT 'Reference to the candidate who received this employment offer. Links to the talent acquisition candidate record.',
    `employee_id` BIGINT COMMENT 'User ID of the system user who created the offer record. Used for audit trail and accountability.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the system user who last modified the offer record. Used for audit trail and accountability.',
    `template_id` BIGINT COMMENT 'Reference to the document template used to generate the offer letter. Supports audit trail and template version control.',
    `offer_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who provided final approval for the offer. Typically a senior leader or HR business partner.',
    `offer_employee_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager for this position. Responsible for offer approval and candidate selection.',
    `offer_recruiter_employee_id` BIGINT COMMENT 'Reference to the internal recruiter or talent acquisition specialist who managed the recruitment process and offer generation.',
    `position_id` BIGINT COMMENT 'Reference to the position being offered. Links to the organizational position structure.',
    `requisition_id` BIGINT COMMENT 'Reference to the job requisition for which this offer was extended. Links to the approved position opening.',
    `revised_offer_id` BIGINT COMMENT 'Self-referencing FK on offer (revised_offer_id)',
    `acceptance_date` DATE COMMENT 'Date the candidate formally accepted the employment offer. Null if offer has not been accepted.',
    `approval_date` DATE COMMENT 'Date the offer was formally approved by the authorized approver. Precedes the offer date.',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a background check is required as a condition of employment. True if required, false otherwise.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Annual base salary offered to the candidate. For hourly positions, this represents the annualized equivalent based on standard hours.',
    `contingent_offer_flag` BOOLEAN COMMENT 'Indicates whether the offer is contingent upon successful completion of background check, drug screening, or other conditions. True if contingent, false if unconditional.',
    `counter_offer_indicator` BOOLEAN COMMENT 'Indicates whether the candidate submitted a counter-offer requesting modified terms. True if counter-offer was received, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the offer record was first created in the system. Used for audit trail and data lineage.',
    `decline_date` DATE COMMENT 'Date the candidate formally declined the employment offer. Null if offer has not been declined.',
    `decline_reason_code` STRING COMMENT 'Standardized reason code indicating why the candidate declined the offer. Used for talent acquisition analytics and offer competitiveness assessment. Null if offer was not declined.. Valid values are `compensation|location|career_growth|benefits|accepted_other_offer|personal_reasons`',
    `decline_reason_notes` STRING COMMENT 'Free-text notes providing additional context about why the candidate declined the offer. Null if offer was not declined or no additional notes captured.',
    `department_name` STRING COMMENT 'Name of the department or organizational unit where the candidate will be employed. Captured at offer time for candidate communication.',
    `drug_screening_required` BOOLEAN COMMENT 'Indicates whether pre-employment drug screening is required. True if required, false otherwise.',
    `employment_type` STRING COMMENT 'Classification of the employment arrangement being offered. Determines benefits eligibility and employment terms.. Valid values are `full_time|part_time|contract|temporary|intern`',
    `equity_grant_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for equity compensation such as stock options or restricted stock units. True if eligible, false otherwise.',
    `expiration_date` DATE COMMENT 'Date by which the candidate must accept or decline the offer. After this date, the offer is automatically expired unless extended.',
    `flsa_classification` STRING COMMENT 'FLSA overtime eligibility classification for the position. Exempt employees are not eligible for overtime pay; non-exempt employees are eligible.. Valid values are `exempt|non_exempt`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Hourly wage rate for non-exempt or hourly positions. Null for salaried positions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the offer record was last updated. Used for audit trail and change tracking.',
    `letter_sent_date` DATE COMMENT 'Date the formal offer letter document was sent to the candidate. Used for tracking offer communication timeline.',
    `license_requirement_notes` STRING COMMENT 'Free-text description of any insurance licenses, actuarial credentials, or FINRA registrations required for the position. Null if no special licensing required.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special arrangements, or negotiation details related to the offer.',
    `offer_date` DATE COMMENT 'Date the employment offer was formally extended to the candidate. Represents the official offer event timestamp for lifecycle tracking.',
    `offer_number` STRING COMMENT 'Business-facing unique offer reference number used for tracking and communication with candidates and hiring managers.',
    `offer_status` STRING COMMENT 'Current status of the employment offer in its lifecycle. Tracks the offer from extension through final disposition.. Valid values are `pending|accepted|declined|rescinded|expired|withdrawn`',
    `pay_frequency` STRING COMMENT 'Frequency of salary payments. Determines payroll cycle for the employee.. Valid values are `weekly|bi_weekly|semi_monthly|monthly`',
    `proposed_start_date` DATE COMMENT 'Proposed first day of employment for the candidate if the offer is accepted. Used for onboarding planning and workforce capacity forecasting.',
    `relocation_amount` DECIMAL(18,2) COMMENT 'Total relocation assistance amount offered to the candidate. Null if no relocation assistance is provided.',
    `relocation_assistance_offered` BOOLEAN COMMENT 'Indicates whether relocation assistance or reimbursement is included in the offer. True if relocation support is provided, false otherwise.',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base salary amount. Typically USD for US-based positions.. Valid values are `^[A-Z]{3}$`',
    `sign_on_bonus_amount` DECIMAL(18,2) COMMENT 'One-time sign-on bonus offered to the candidate. Typically used to attract high-demand talent or offset candidate losses from prior employer. Null if no sign-on bonus offered.',
    `target_bonus_percentage` DECIMAL(18,2) COMMENT 'Target annual bonus as a percentage of base salary. Represents the expected bonus at 100% performance achievement. Null if position is not bonus-eligible.',
    `work_location` STRING COMMENT 'Primary work location or office site for the position. May include remote, hybrid, or specific office location details.',
    CONSTRAINT pk_offer PRIMARY KEY(`offer_id`)
) COMMENT 'Transactional record of each employment offer extended to a candidate. Captures offer date, offer expiration date, position title, base salary offered, sign-on bonus offered, target bonus percentage, start date proposed, offer status (pending, accepted, declined, rescinded, expired), decline reason code, and counter-offer indicator. Provides the formal offer management record linking the talent acquisition process to the employee onboarding and employment record creation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` (
    `disciplinary_action_id` BIGINT COMMENT 'Unique identifier for the disciplinary action record. Primary key for the disciplinary action entity.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Disciplinary actions cite specific policy violations for documentation, pattern analysis, and regulatory reporting (market conduct exams, producer oversight). Policy linkage is essential for tracking ',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who is the subject of the disciplinary action. Links to the employee master record.',
    `quaternary_disciplinary_last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the system user who last modified this disciplinary action record. Used for audit trail and accountability.',
    `tertiary_disciplinary_created_by_user_employee_id` BIGINT COMMENT 'User identifier of the system user who created this disciplinary action record. Used for audit trail and accountability.',
    `escalated_from_disciplinary_action_id` BIGINT COMMENT 'Self-referencing FK on disciplinary_action (escalated_from_disciplinary_action_id)',
    `action_date` DATE COMMENT 'The date on which the disciplinary action was formally issued or taken against the employee.',
    `action_number` STRING COMMENT 'Business-facing unique reference number for the disciplinary action case, used for tracking and documentation purposes.',
    `action_status` STRING COMMENT 'Current status of the disciplinary action record in its lifecycle. Active indicates the action is in effect; resolved indicates completion; expunged indicates removal from record per policy or legal requirement.. Valid values are `active|resolved|expunged|under_review|appealed|overturned`',
    `action_type` STRING COMMENT 'Classification of the disciplinary action taken. Indicates the severity and nature of the corrective measure applied. [ENUM-REF-CANDIDATE: verbal_warning|written_warning|final_warning|performance_improvement_plan|suspension|termination_for_cause|demotion|probation — 8 candidates stripped; promote to reference product]',
    `appeal_filed_date` DATE COMMENT 'Date on which the employee filed a formal appeal or grievance. Null if no appeal was filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the employee has filed a formal appeal or grievance against the disciplinary action.',
    `appeal_outcome` STRING COMMENT 'Result of the employee appeal or grievance process. Indicates whether the original disciplinary action was upheld, overturned, or modified.. Valid values are `upheld|overturned|modified|pending|withdrawn|not_applicable`',
    `appeal_resolution_date` DATE COMMENT 'Date on which the appeal or grievance was formally resolved. Null if no appeal was filed or if still pending.',
    `corrective_action_plan` STRING COMMENT 'Description of the corrective actions, performance improvement steps, or behavioral expectations required of the employee to resolve the issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this disciplinary action record was first created in the system. Used for audit trail and data lineage.',
    `documentation_location` STRING COMMENT 'File path, document management system reference, or physical location where the complete disciplinary action documentation is stored.',
    `effective_date` DATE COMMENT 'The date from which the disciplinary action becomes effective and enforceable. May differ from action_date if there is a notice period.',
    `employee_acknowledgment_date` DATE COMMENT 'Date on which the employee acknowledged receipt and understanding of the disciplinary action documentation.',
    `employee_acknowledgment_method` STRING COMMENT 'Method by which the employee acknowledged the disciplinary action (e.g., physical signature, electronic signature, verbal acknowledgment, or refusal to sign).. Valid values are `signature|electronic_signature|verbal|refused|not_applicable`',
    `employee_statement` STRING COMMENT 'Written statement or comments provided by the employee in response to the disciplinary action. Confidential employee relations data.',
    `expungement_date` DATE COMMENT 'Date on which the disciplinary action record was expunged or removed from the employees permanent record, typically after a specified clean period or per legal requirement.',
    `expungement_reason` STRING COMMENT 'Reason for expunging the disciplinary action from the employee record (e.g., clean record period elapsed, appeal overturned, legal requirement).',
    `hr_case_number` STRING COMMENT 'Reference number of the broader HR case or investigation file associated with this disciplinary action. Used for cross-referencing with employee relations case management systems.',
    `improvement_deadline_date` DATE COMMENT 'Target date by which the employee must demonstrate improvement or complete corrective actions. Applicable for performance improvement plans and probationary periods.',
    `issuing_department` STRING COMMENT 'Name or code of the department or business unit from which the disciplinary action was issued.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this disciplinary action record was last modified in the system. Used for audit trail and data lineage.',
    `legal_review_date` DATE COMMENT 'Date on which the legal department completed its review of the disciplinary action. Null if legal review was not required.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether the disciplinary action required review and approval by the legal department prior to issuance, typically for terminations or high-risk actions.',
    `license_impact_flag` BOOLEAN COMMENT 'Indicates whether the disciplinary action impacts the employees professional licenses or registrations (e.g., insurance producer license, actuarial credentials, FINRA registration).',
    `notes` STRING COMMENT 'Additional confidential notes, context, or follow-up information related to the disciplinary action. Used for internal HR reference and case management.',
    `prior_warnings_count` STRING COMMENT 'Number of prior disciplinary warnings or actions on record for this employee at the time this action was issued. Used to track progressive discipline.',
    `regulatory_authority` STRING COMMENT 'Name or code of the regulatory body to which the disciplinary action was reported (e.g., state insurance department, FINRA, SEC).',
    `regulatory_report_date` DATE COMMENT 'Date on which the disciplinary action was reported to the applicable regulatory authority. Null if reporting is not required or not yet completed.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this disciplinary action must be reported to regulatory authorities (e.g., state insurance departments for licensed staff, FINRA for registered representatives).',
    `suspension_end_date` DATE COMMENT 'End date of the suspension period if the disciplinary action includes a suspension. Null if not applicable.',
    `suspension_paid_flag` BOOLEAN COMMENT 'Indicates whether the suspension is paid (true) or unpaid (false). Applicable only when action_type is suspension.',
    `suspension_start_date` DATE COMMENT 'Start date of the suspension period if the disciplinary action includes a suspension. Null if not applicable.',
    `termination_date` DATE COMMENT 'Effective date of employment termination if the disciplinary action results in termination for cause. Null if not applicable.',
    `termination_reason_code` STRING COMMENT 'Standardized code representing the reason for termination. Used for regulatory reporting and workforce analytics.',
    `violation_category` STRING COMMENT 'High-level category of the policy or conduct violation that triggered the disciplinary action. [ENUM-REF-CANDIDATE: attendance|conduct|performance|policy_violation|compliance_breach|safety_violation|ethics_violation|fraud|harassment — 9 candidates stripped; promote to reference product]',
    `violation_description` STRING COMMENT 'Detailed narrative description of the specific policy violation, misconduct, or performance issue that led to the disciplinary action. Contains sensitive employee relations information.',
    `witness_employee_ids` STRING COMMENT 'Comma-separated list of employee identifiers who witnessed the incident or were present during the disciplinary meeting. Confidential employee relations data.',
    CONSTRAINT pk_disciplinary_action PRIMARY KEY(`disciplinary_action_id`)
) COMMENT 'Transactional record of formal disciplinary actions taken against an employee. Captures action type (verbal warning, written warning, performance improvement plan, suspension, termination for cause), action date, policy violation description, prior warnings count, action issued by (manager/HR), employee acknowledgment date, appeal filed indicator, appeal outcome, and action status (active, resolved, expunged). Supports employee relations case management, termination documentation, and regulatory compliance for licensed insurance staff.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`succession_plan` (
    `succession_plan_id` BIGINT COMMENT 'Unique identifier for the succession plan record. Primary key for the succession plan entity.',
    `plan_id` BIGINT COMMENT 'Reference to the formal individual development plan created for successors to address identified competency gaps and prepare them for the target position.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created the succession plan record. Used for audit trail and accountability.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who most recently modified the succession plan record. Used for audit trail and accountability.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit or department that owns the target position and succession plan. Used for reporting and governance.',
    `owner_employee_id` BIGINT COMMENT 'Reference to the HR business partner or executive responsible for maintaining and executing the succession plan.',
    `primary_successor_employee_id` BIGINT COMMENT 'Reference to the primary identified successor employee for the target position. This is the top-ranked candidate in the succession plan.',
    `position_id` BIGINT COMMENT 'Reference to the critical position or role for which succession planning is being conducted. Links to the position master record.',
    `tertiary_succession_approved_by_employee_id` BIGINT COMMENT 'Reference to the executive or senior leader who formally approved the succession plan.',
    `tertiary_successor_employee_id` BIGINT COMMENT 'Reference to the tertiary identified successor employee for the target position. This is the third-ranked candidate in the succession plan.',
    `superseded_succession_plan_id` BIGINT COMMENT 'Self-referencing FK on succession_plan (superseded_succession_plan_id)',
    `approval_date` DATE COMMENT 'Date when the succession plan was formally approved by executive leadership.',
    `business_impact_rating` STRING COMMENT 'Assessment of the business impact if the target position becomes vacant without a ready successor. Reflects the criticality of the role to business operations, regulatory compliance, and strategic objectives.. Valid values are `low|moderate|high|critical`',
    `confidentiality_level` STRING COMMENT 'Classification of the confidentiality level for the succession plan, as succession planning information is typically highly sensitive and restricted to executive leadership and HR.. Valid values are `public|internal|confidential|highly_confidential`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the succession plan record was first created in the system. Used for audit trail and data lineage.',
    `critical_competencies_required` STRING COMMENT 'List or description of the critical competencies, skills, and qualifications required for the target position. May include actuarial credentials, insurance licenses, FINRA registrations, or specialized technical expertise.',
    `development_gap_assessment` STRING COMMENT 'Detailed narrative assessment of the skills, experience, and competency gaps that identified successors need to address before being ready for the target position. Informs individual development plans.',
    `emergency_contact_plan_exists` BOOLEAN COMMENT 'Boolean indicator of whether an emergency contact and communication plan exists for immediate activation if the incumbent unexpectedly departs.',
    `key_person_risk_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this succession plan addresses a key-person risk where specialized insurance expertise (actuarial, underwriting, claims) creates significant organizational vulnerability.',
    `knowledge_transfer_plan_exists` BOOLEAN COMMENT 'Boolean indicator of whether a formal knowledge transfer plan exists to capture and transfer critical institutional knowledge from the incumbent to successors.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the succession plan record was most recently updated. Used for audit trail and change tracking.',
    `last_review_date` DATE COMMENT 'Date when the succession plan was most recently reviewed and updated by HR and business leadership.',
    `plan_code` STRING COMMENT 'Business identifier code for the succession plan, typically formatted as SP-XXXXXX for external reference and reporting.. Valid values are `^SP-[0-9]{6}$`',
    `plan_effective_date` DATE COMMENT 'Date when the succession plan becomes active and effective for business continuity planning purposes.',
    `plan_expiration_date` DATE COMMENT 'Date when the succession plan expires or is scheduled to be closed, typically aligned with anticipated transition dates or organizational restructuring.',
    `plan_notes` STRING COMMENT 'Free-text field for additional notes, observations, or context about the succession plan, including special considerations, external candidate options, or organizational changes affecting the plan.',
    `plan_review_date` DATE COMMENT 'Scheduled date for the next formal review and update of the succession plan. Ensures plans remain current with organizational changes and successor development progress.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the succession plan indicating its stage in the planning and approval workflow.. Valid values are `draft|active|under_review|approved|suspended|closed`',
    `plan_type` STRING COMMENT 'Classification of the succession plan based on urgency and purpose: emergency (immediate need), planned (anticipated transition), development (long-term talent pipeline), or retention (key person risk mitigation).. Valid values are `emergency|planned|development|retention`',
    `primary_successor_readiness_rating` STRING COMMENT 'Assessment of the primary successors current readiness level to assume the target position, based on skills, experience, and performance evaluation.. Valid values are `ready_now|ready_with_development|emerging_talent|not_ready`',
    `readiness_horizon` STRING COMMENT 'Time horizon indicating when identified successors are expected to be ready to assume the target position. Critical for business continuity planning and talent development prioritization.. Valid values are `ready_now|1_to_2_years|3_to_5_years|5_plus_years`',
    `retention_risk_rating` STRING COMMENT 'Assessment of the risk that the incumbent or identified successors may leave the organization, creating succession continuity risk. Critical for key-person risk management in specialized insurance roles.. Valid values are `low|moderate|high|critical`',
    `secondary_successor_readiness_rating` STRING COMMENT 'Assessment of the secondary successors current readiness level to assume the target position.. Valid values are `ready_now|ready_with_development|emerging_talent|not_ready`',
    `tertiary_successor_readiness_rating` STRING COMMENT 'Assessment of the tertiary successors current readiness level to assume the target position.. Valid values are `ready_now|ready_with_development|emerging_talent|not_ready`',
    CONSTRAINT pk_succession_plan PRIMARY KEY(`succession_plan_id`)
) COMMENT 'Master record for succession planning for key positions and critical roles within the Life Insurance enterprise. Captures target position, incumbent employee, succession readiness horizon (ready now, 1-2 years, 3-5 years), identified successor employees, successor readiness rating, development gap assessment, retention risk rating, and plan review date. Supports business continuity planning for critical actuarial, underwriting, and executive roles where specialized insurance expertise creates significant key-person risk.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`work_schedule` (
    `work_schedule_id` BIGINT COMMENT 'Unique identifier for the work schedule record. Primary key.',
    `approved_by_employee_id` BIGINT COMMENT 'Employee identifier of the HR or management personnel who approved this work schedule for use.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created this work schedule record.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this work schedule record.',
    `superseded_work_schedule_id` BIGINT COMMENT 'Self-referencing FK on work_schedule (superseded_work_schedule_id)',
    `applicable_departments` STRING COMMENT 'Comma-separated list of departments or organizational units that use this schedule (e.g., Claims Operations, Customer Service, Underwriting).',
    `applicable_job_families` STRING COMMENT 'Comma-separated list of job families or roles this schedule is designed for (e.g., Claims Adjusters, Customer Service Representatives, Underwriters, Actuaries).',
    `approval_date` DATE COMMENT 'Date when this work schedule was formally approved for implementation.',
    `capacity_planning_factor` DECIMAL(18,2) COMMENT 'Multiplier used in workforce capacity planning to convert headcount to available work hours. Accounts for breaks, meetings, and non-productive time.',
    `compliance_notes` STRING COMMENT 'Notes regarding compliance considerations for this schedule, including state-specific labor law requirements, union contract provisions, or FLSA considerations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work schedule record was first created in the system.',
    `daily_hours` DECIMAL(18,2) COMMENT 'Standard number of hours per work day for this schedule. Used for daily overtime calculations and capacity planning.',
    `effective_date` DATE COMMENT 'Date when this work schedule becomes effective and can be assigned to employees or organizational units.',
    `end_date` DATE COMMENT 'Date when this work schedule is no longer valid for new assignments. Null for schedules with no planned end date.',
    `flsa_classification` STRING COMMENT 'FLSA classification typically associated with this schedule. Exempt = salaried, not eligible for overtime; Non-exempt = hourly, eligible for overtime.. Valid values are `exempt|non_exempt`',
    `geographic_scope` STRING COMMENT 'Geographic regions or locations where this schedule is applicable. Used to ensure compliance with state-specific labor laws.',
    `holiday_schedule_code` STRING COMMENT 'Reference code to the holiday calendar applicable to this work schedule. Determines which holidays are observed and how holiday pay is calculated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work schedule record was last updated.',
    `lunch_break_minutes` STRING COMMENT 'Standard unpaid lunch break duration in minutes. Used to calculate net working hours and compliance with state labor laws.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether employees on this schedule are eligible for overtime pay under Fair Labor Standards Act (FLSA) regulations. True for non-exempt positions.',
    `overtime_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours per week after which overtime pay applies. Typically 40 hours under FLSA, but may vary by state or schedule type.',
    `paid_break_minutes` STRING COMMENT 'Total paid rest break time per day in minutes. Includes short breaks mandated by labor regulations.',
    `pto_accrual_basis` STRING COMMENT 'Basis for calculating PTO accrual for employees on this schedule. Hours-worked = accrual per hour worked, Pay-period = fixed accrual per pay period, Annual = annual grant.. Valid values are `hours_worked|pay_period|annual`',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether this schedule supports remote or hybrid work arrangements. Used for workspace capacity planning and technology provisioning.',
    `remote_work_percentage` DECIMAL(18,2) COMMENT 'Percentage of work time that can be performed remotely under this schedule (0-100). Used for hybrid work planning and office space allocation.',
    `rotation_cycle_days` STRING COMMENT 'Number of days in the rotation cycle for shift-based schedules (e.g., 14 for a two-week rotation, 28 for a four-week rotation). Null for non-rotating schedules.',
    `schedule_code` STRING COMMENT 'Business identifier code for the work schedule used in HR systems and reporting. Unique alphanumeric code assigned to each schedule pattern.. Valid values are `^[A-Z0-9]{3,10}$`',
    `schedule_description` STRING COMMENT 'Detailed description of the work schedule including any special conditions, rotation patterns, or business context for its use.',
    `schedule_name` STRING COMMENT 'Human-readable name of the work schedule (e.g., Standard 40-Hour Week, Compressed 4/10, Claims Night Shift).',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the work schedule. Active = in use, Inactive = not currently assigned, Pending = approved but not yet effective, Deprecated = phased out.. Valid values are `active|inactive|pending|deprecated`',
    `schedule_type` STRING COMMENT 'Classification of the work schedule pattern. Standard = traditional fixed hours, Flex = flexible start/end times, Compressed = longer days with fewer workdays, Shift-based = rotating or fixed shifts, Part-time = reduced hours, On-call = variable availability.. Valid values are `standard|flex|compressed|shift_based|part_time|on_call`',
    `shift_differential_eligible` BOOLEAN COMMENT 'Indicates whether employees on this schedule are eligible for shift differential pay (e.g., evening, night, or weekend premium).',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional pay rate multiplier for shift differential (e.g., 0.15 for 15% premium). Null if shift differential is not applicable.',
    `shift_end_time` TIMESTAMP COMMENT 'Standard end time for the work shift in HH:MM format (24-hour clock). Null for flex schedules without fixed end time.',
    `shift_start_time` TIMESTAMP COMMENT 'Standard start time for the work shift in HH:MM format (24-hour clock). Null for flex schedules without fixed start time.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'The standard number of hours per week defined by this schedule. Used for Full-Time Equivalent (FTE) calculations and overtime eligibility determination.',
    `time_tracking_required` BOOLEAN COMMENT 'Indicates whether employees on this schedule must track time via time clock or timesheet system. Typically true for non-exempt employees.',
    `weekend_work_required` BOOLEAN COMMENT 'Indicates whether this schedule includes regular weekend work days (Saturday or Sunday). Used for staffing planning and shift differential calculations.',
    `work_days_pattern` STRING COMMENT 'Pattern of work days in the schedule (e.g., Mon-Fri, Mon-Thu, rotating 4-on-3-off, weekend shift). Describes which days of the week or rotation cycle are work days.',
    CONSTRAINT pk_work_schedule PRIMARY KEY(`work_schedule_id`)
) COMMENT 'Master record defining the standard work schedules and shift patterns assigned to employees or org units. Captures schedule name, schedule type (standard, flex, compressed, shift-based), standard hours per week, work days pattern, shift start time, shift end time, overtime eligibility, remote work eligibility percentage, and effective date range. Supports time and attendance management, FLSA overtime calculations, and workforce capacity planning for claims processing centers and customer service operations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` (
    `uw_authority_assignment_id` BIGINT COMMENT 'Unique identifier for the underwriting authority assignment record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'User identifier of the system user or administrator who created this authority assignment record. Supports audit and accountability.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the system user or administrator who last modified this authority assignment record. Supports audit and accountability.',
    `primary_uw_employee_id` BIGINT COMMENT 'Unique identifier of the underwriter employee to whom this authority is assigned. Links to the employee master record.',
    `sox_control_id` BIGINT COMMENT 'Reference identifier linking this authority assignment to the SOX internal control framework. Supports audit and compliance verification of underwriting approval limits.',
    `uw_authority_id` BIGINT COMMENT 'Identifier of the authority schedule being assigned. References the underwriting authority definition that establishes the authority level framework.',
    `uw_employee_id` BIGINT COMMENT 'FK to workforce.employee.employee_id — Underwriting authority assignments must link to the employee record. This enables authority limit validation during case assignment and ensures only authorized underwriters approve cases within their ',
    `superseded_uw_authority_assignment_id` BIGINT COMMENT 'Self-referencing FK on uw_authority_assignment (superseded_uw_authority_assignment_id)',
    `approval_date` DATE COMMENT 'Date when the approving officer authorized this authority assignment.',
    `assignment_number` STRING COMMENT 'Business-readable unique identifier for this authority assignment, used for tracking and audit purposes.',
    `assignment_reason` STRING COMMENT 'Business reason or trigger for creating or modifying this authority assignment. Supports audit and compliance reporting. [ENUM-REF-CANDIDATE: new_hire|promotion|annual_review|credential_attainment|performance_based|temporary_coverage|organizational_change — 7 candidates stripped; promote to reference product]',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the authority assignment. Active assignments are in force; suspended assignments are temporarily inactive; expired assignments have passed their expiration date; revoked assignments have been permanently withdrawn; pending approval assignments await management authorization.. Valid values are `active|suspended|expired|revoked|pending_approval`',
    `audit_trail_notes` STRING COMMENT 'Free-text field for capturing audit-relevant notes, change history summaries, or compliance observations related to this authority assignment.',
    `authority_level` STRING COMMENT 'Classification of the underwriting authority level assigned to the employee. Determines the scope and limits of underwriting decisions the employee can approve independently.. Valid values are `junior|senior|chief|senior_vice_president|executive`',
    `certification_required` STRING COMMENT 'Professional certifications or designations required to hold this authority level. May include FLMI, CLU, FALU, or other industry credentials.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this authority assignment record was first created in the system. Part of the audit trail for SOX compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the maximum face amount and other monetary limits in this assignment.. Valid values are `^[A-Z]{3}$`',
    `delegation_allowed` BOOLEAN COMMENT 'Indicates whether the underwriter is permitted to temporarily delegate their authority to another qualified underwriter during absence or workload management.',
    `effective_date` DATE COMMENT 'Date when this authority assignment becomes active and the underwriter can begin exercising the assigned authority.',
    `expiration_date` DATE COMMENT 'Date when this authority assignment expires or is scheduled for review. Null indicates an open-ended assignment subject to periodic review.',
    `geographic_territory` STRING COMMENT 'Geographic region or list of states/jurisdictions where this authority assignment is valid. May be comma-separated state codes or region identifiers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this authority assignment record was last updated. Part of the audit trail for tracking changes to underwriting authority.',
    `last_review_date` DATE COMMENT 'Date when this authority assignment was last reviewed by management or compliance. Supports periodic recertification requirements.',
    `maximum_age_limit` STRING COMMENT 'Maximum age of applicant that the underwriter is authorized to approve without escalation. Cases involving applicants older than this age require senior review.',
    `maximum_face_amount` DECIMAL(18,2) COMMENT 'Maximum death benefit face amount that the underwriter is authorized to approve without escalation or additional review. Expressed in the currency specified by the currency code.',
    `minimum_age_limit` STRING COMMENT 'Minimum age of applicant that the underwriter is authorized to approve. Cases involving applicants younger than this age (e.g., juvenile insurance) may require specialized review.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this authority assignment. Ensures ongoing compliance with underwriting policy and regulatory requirements.',
    `product_lines_authorized` STRING COMMENT 'Comma-separated list of product line codes the underwriter is authorized to underwrite. Common values include WL (Whole Life), UL (Universal Life), IUL (Indexed Universal Life), VUL (Variable Universal Life), FIA (Fixed Indexed Annuity), DI (Disability Income), LTC (Long-Term Care).',
    `requires_medical_director_consult` BOOLEAN COMMENT 'Indicates whether cases at this authority level require consultation with or approval from the medical director for certain medical conditions or risk factors.',
    `requires_reinsurance_approval` BOOLEAN COMMENT 'Indicates whether cases at or near the maximum face amount require pre-approval or notification to reinsurance partners before final underwriting decision.',
    `risk_class_limit` STRING COMMENT 'Highest risk classification the underwriter is authorized to approve. Underwriters cannot approve cases with risk ratings worse than this limit without escalation. [ENUM-REF-CANDIDATE: preferred_plus|preferred|standard_plus|standard|substandard_table_2|substandard_table_4|substandard_table_6|decline — 8 candidates stripped; promote to reference product]',
    `special_conditions` STRING COMMENT 'Free-text field capturing any special conditions, restrictions, or notes associated with this authority assignment. May include limitations on specific riders, occupational classes, or medical conditions.',
    `training_completion_date` DATE COMMENT 'Date when the underwriter completed required training for this authority level. Supports compliance with competency and credentialing requirements.',
    CONSTRAINT pk_uw_authority_assignment PRIMARY KEY(`uw_authority_assignment_id`)
) COMMENT 'Master record assigning underwriting authority limits to individual underwriter employees. Captures employee ID, authority level (junior, senior, chief, SVP), maximum face amount authorized, product lines authorized (WL, UL, IUL, VUL, FIA, DI, LTC), risk class limit, effective date, expiration date, and approving officer. Distinct from underwriting.uw_authority which defines the authority schedule itself — this entity records the individual assignment of that authority to a specific employee, supporting SOX controls over underwriting approval limits.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`background_check` (
    `background_check_id` BIGINT COMMENT 'Unique identifier for the background check record. Primary key.',
    `position_id` BIGINT COMMENT 'Reference to the position for which this background check was conducted.',
    `employee_id` BIGINT COMMENT 'Reference to the employee subject to this background check.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Background checks are mandated by specific regulations (state licensing requirements, FINRA registration, fiduciary role standards, access to PHI/PII). Linking checks to obligations supports complianc',
    `requisition_id` BIGINT COMMENT 'Foreign key linking to workforce.requisition. Business justification: Background checks are often performed as part of the hiring process for a specific requisition. This links the background screening event to the talent acquisition workflow. The FK will be nullable (b',
    `tertiary_background_reviewed_by_employee_id` BIGINT COMMENT 'Reference to the HR staff member who reviewed and adjudicated the background check results.',
    `renewal_background_check_id` BIGINT COMMENT 'Self-referencing FK on background_check (renewal_background_check_id)',
    `access_to_policyholder_data` BOOLEAN COMMENT 'Indicates whether the employee will have access to policyholder financial or personal data, requiring enhanced background screening.',
    `adjudication_date` DATE COMMENT 'Date when the final employment decision was made based on the background check results.',
    `adjudication_notes` STRING COMMENT 'Internal notes documenting the rationale for the adjudication decision, including any mitigating factors or employee explanations considered.',
    `adjudication_outcome` STRING COMMENT 'Final employment decision outcome after reviewing the background check results and any employee dispute or explanation.. Valid values are `approved|denied|conditional_approval|pending|not_applicable`',
    `adverse_action_notice_date` DATE COMMENT 'Date when the adverse action notice was sent to the employee.',
    `adverse_action_notice_issued` BOOLEAN COMMENT 'Indicates whether a pre-adverse or adverse action notice was issued to the employee as required by FCRA when negative information may impact employment decisions.',
    `background_check_status` STRING COMMENT 'Current lifecycle status of the background check process.. Valid values are `ordered|in_progress|completed|cancelled|expired`',
    `check_number` STRING COMMENT 'Externally-known unique identifier or case number assigned by the screening vendor for this background check.',
    `check_reason` STRING COMMENT 'Business reason or trigger for conducting this background check.. Valid values are `pre_employment|periodic_review|promotion|role_change|regulatory_requirement|incident_triggered`',
    `check_type` STRING COMMENT 'Type of background screening performed. [ENUM-REF-CANDIDATE: criminal|credit|education_verification|employment_verification|professional_license_verification|finra_brokercheck|oig_exclusion_list|motor_vehicle_record|drug_screening|reference_check — promote to reference product]',
    `completion_date` DATE COMMENT 'Date when the background check was completed and results were received from the vendor.',
    `consent_date` DATE COMMENT 'Date when the employee provided written consent for the background check.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether written consent was obtained from the employee prior to conducting the background check as required by FCRA.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost charged by the screening vendor for conducting this background check.',
    `credit_check_performed` BOOLEAN COMMENT 'Indicates whether a credit history check was performed as part of this background screening.',
    `criminal_check_scope` STRING COMMENT 'Geographic scope of the criminal background check performed.. Valid values are `county|state|federal|national|international`',
    `criminal_records_found` BOOLEAN COMMENT 'Indicates whether any criminal records were discovered during the background check.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the background check cost amount.. Valid values are `^[A-Z]{3}$`',
    `dispute_filed` BOOLEAN COMMENT 'Indicates whether the employee filed a dispute regarding the accuracy or completeness of the background check results.',
    `dispute_resolution_date` DATE COMMENT 'Date when any employee dispute regarding the background check was resolved.',
    `education_verified` BOOLEAN COMMENT 'Indicates whether educational credentials were verified as part of this background check.',
    `employment_verified` BOOLEAN COMMENT 'Indicates whether previous employment history was verified as part of this background check.',
    `expiration_date` DATE COMMENT 'Date when this background check expires and a new check is required per company policy or regulatory requirements.',
    `finra_brokercheck_performed` BOOLEAN COMMENT 'Indicates whether a FINRA BrokerCheck screening was performed for registered representatives.',
    `oig_exclusion_check_performed` BOOLEAN COMMENT 'Indicates whether the employee was screened against the OIG List of Excluded Individuals and Entities.',
    `oig_exclusion_found` BOOLEAN COMMENT 'Indicates whether the employee was found on the OIG exclusion list.',
    `order_date` DATE COMMENT 'Date when the background check was ordered or initiated by the company.',
    `professional_license_verified` BOOLEAN COMMENT 'Indicates whether professional licenses or designations were verified as part of this background check.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this background check record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this background check record was last modified.',
    `requires_finra_registration` BOOLEAN COMMENT 'Indicates whether the position requires FINRA registration for variable product sales, triggering BrokerCheck screening requirements.',
    `requires_insurance_license` BOOLEAN COMMENT 'Indicates whether the position requires an active insurance license, triggering enhanced background screening requirements.',
    `result` STRING COMMENT 'Overall outcome of the background check screening.. Valid values are `clear|adverse|pending_review|incomplete|cancelled`',
    `screening_vendor` STRING COMMENT 'Name of the third-party background screening vendor or Consumer Reporting Agency (CRA) that conducted the check.',
    `vendor_report_url` STRING COMMENT 'Secure URL link to the detailed background check report provided by the screening vendor.',
    CONSTRAINT pk_background_check PRIMARY KEY(`background_check_id`)
) COMMENT 'Transactional record of pre-employment and periodic background screening events for employees. Captures check type (criminal, credit, education verification, employment verification, professional license verification, FINRA BrokerCheck, OIG exclusion list), screening vendor, order date, completion date, result (clear, adverse, pending review), adverse action notice issued indicator, and adjudication outcome. Required for all employees in licensed insurance roles, variable product staff subject to FINRA, and employees with access to policyholder financial data.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`employee_skill` (
    `employee_skill_id` BIGINT COMMENT 'Unique identifier for the employee skill record. Primary key for the employee skill association entity.',
    `plan_id` BIGINT COMMENT 'Reference to the employee development plan associated with acquiring or improving this skill.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who possesses this skill. Links to the employee master record in the workforce domain.',
    `superseded_employee_skill_id` BIGINT COMMENT 'Self-referencing FK on employee_skill (superseded_employee_skill_id)',
    `assessment_date` DATE COMMENT 'Date when the skill proficiency was most recently assessed or validated.',
    `assessment_method` STRING COMMENT 'Method used to evaluate and validate the employees proficiency level in this skill.. Valid values are `self_assessed|manager_assessed|certification|examination|peer_review`',
    `ce_credits_required` DECIMAL(18,2) COMMENT 'Number of continuing education credits required to maintain this certification or skill designation during the renewal period.',
    `certification_date` DATE COMMENT 'Date when the professional certification or designation was originally awarded to the employee.',
    `certification_name` STRING COMMENT 'Name of the professional certification or designation associated with this skill, if applicable. Examples include Fellow of the Society of Actuaries (FSA), Chartered Life Underwriter (CLU), or Certified Insurance Counselor (CIC).',
    `certification_number` STRING COMMENT 'Unique identifier or credential number issued by the certifying body for this professional designation.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred by the organization for training, certification, or skill development related to this competency.',
    `critical_skill_flag` BOOLEAN COMMENT 'Indicates whether this skill is designated as business-critical or strategically important for organizational capability planning.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount associated with skill development.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when this skill record became effective and the employee was recognized as possessing this competency.',
    `end_date` DATE COMMENT 'Date when this skill record was terminated or the employee no longer maintains this competency, if applicable.',
    `endorsement_count` STRING COMMENT 'Number of peer or manager endorsements received validating the employees proficiency in this skill.',
    `expiration_date` DATE COMMENT 'Date when the skill certification or designation expires and requires renewal or recertification, if applicable.',
    `issuing_organization` STRING COMMENT 'Name of the professional body, institution, or organization that issued the certification or validated the skill.',
    `last_used_date` DATE COMMENT 'Most recent date when the employee actively utilized this skill in their work assignments or projects.',
    `notes` STRING COMMENT 'Additional comments, context, or observations regarding the employees skill, proficiency, or certification status.',
    `primary_skill_flag` BOOLEAN COMMENT 'Indicates whether this is a core or primary skill for the employees current role and responsibilities.',
    `proficiency_level` STRING COMMENT 'Current level of competency the employee has achieved in this skill. Ranges from beginner through expert levels.. Valid values are `beginner|intermediate|advanced|expert`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee skill record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee skill record was most recently modified or updated.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this skill or certification requires periodic renewal or continuing education to maintain validity.',
    `skill_category` STRING COMMENT 'High-level classification of the skill type. Categories include technical, actuarial, underwriting, claims, regulatory, and leadership competencies relevant to insurance operations.. Valid values are `technical|actuarial|underwriting|claims|regulatory|leadership`',
    `skill_code` STRING COMMENT 'Standardized code representing the skill or competency. Used for system identification and reporting purposes.. Valid values are `^[A-Z0-9]{3,10}$`',
    `skill_gap_flag` BOOLEAN COMMENT 'Indicates whether this skill represents a development area or gap relative to the employees target role requirements.',
    `skill_name` STRING COMMENT 'Full descriptive name of the skill, competency, or professional designation attributed to the employee.',
    `skill_status` STRING COMMENT 'Current lifecycle status of the skill record indicating whether it is actively maintained, has lapsed, or requires validation.. Valid values are `active|inactive|expired|pending_validation`',
    `skill_subcategory` STRING COMMENT 'Detailed classification within the skill category providing granular segmentation of competencies.',
    `target_proficiency_level` STRING COMMENT 'Desired or required proficiency level for this skill based on the employees role or career development plan.. Valid values are `beginner|intermediate|advanced|expert`',
    `training_source` STRING COMMENT 'Name of the institution, vendor, or program through which the employee acquired this skill or certification.',
    `transferable_skill_flag` BOOLEAN COMMENT 'Indicates whether this skill is applicable across multiple roles, departments, or business functions within the organization.',
    `verification_date` DATE COMMENT 'Date when the skill or certification was verified by human resources or a designated authority.',
    `verification_status` STRING COMMENT 'Status indicating whether the skill claim has been independently verified through documentation or assessment.. Valid values are `verified|pending|unverified|disputed`',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Number of years the employee has actively practiced or applied this skill in a professional capacity.',
    CONSTRAINT pk_employee_skill PRIMARY KEY(`employee_skill_id`)
) COMMENT 'Association and master record capturing the skills, competencies, and professional designations attributed to each employee. Captures skill category (technical, actuarial, underwriting, claims, regulatory, leadership, technology), skill name, proficiency level (beginner, intermediate, advanced, expert), assessment method (self-assessed, manager-assessed, certification), assessment date, and expiration date where applicable. Supports skills inventory management, workforce capacity planning, and identification of internal candidates for specialized insurance roles.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`work_location` (
    `work_location_id` BIGINT COMMENT 'Primary key for work_location',
    `employee_id` BIGINT COMMENT 'Employee identifier of the location manager or site lead responsible for this work location.',
    `region_id` BIGINT COMMENT 'Reference to the geographic or organizational region to which this work location belongs.',
    `parent_work_location_id` BIGINT COMMENT 'Self-referencing FK on work_location (parent_work_location_id)',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the work location meets accessibility standards for individuals with disabilities.',
    `address_line_1` STRING COMMENT 'Primary street address of the work location.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building number.',
    `building_ownership` STRING COMMENT 'Indicates whether the work location is owned, leased, or shared by the organization.',
    `city` STRING COMMENT 'City where the work location is situated.',
    `closed_date` DATE COMMENT 'Date when the work location was permanently closed, if applicable.',
    `cost_center_code` STRING COMMENT 'Financial cost center code associated with the work location for expense tracking and budgeting.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the work location is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the work location record was first created in the system.',
    `email_address` STRING COMMENT 'General contact email address for the work location.',
    `emergency_contact_name` STRING COMMENT 'Name of the primary emergency contact person for the work location.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the primary emergency contact for the work location.',
    `fax_number` STRING COMMENT 'Fax number for the work location, if applicable.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the work location in decimal degrees.',
    `lease_expiration_date` DATE COMMENT 'Date when the current lease agreement for the work location expires, if leased.',
    `location_code` STRING COMMENT 'Business identifier code for the work location, used in operational systems and reporting.',
    `location_name` STRING COMMENT 'Official name of the work location (e.g., New York Regional Office, Chicago Claims Center).',
    `location_type` STRING COMMENT 'Classification of the work location based on its operational function within the insurance enterprise.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the work location in decimal degrees.',
    `notes` STRING COMMENT 'Additional notes or comments about the work location, including special instructions or operational details.',
    `opened_date` DATE COMMENT 'Date when the work location was officially opened for business operations.',
    `parking_spaces` STRING COMMENT 'Number of parking spaces available at the work location.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the work location.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the work location address.',
    `seating_capacity` STRING COMMENT 'Maximum number of employees that can be seated at the work location.',
    `security_level` STRING COMMENT 'Classification of physical security measures in place at the work location.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total square footage of the work location facility.',
    `state_province` STRING COMMENT 'State or province of the work location.',
    `work_location_status` STRING COMMENT 'Current operational status of the work location.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the work location (e.g., America/New_York).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the work location record was last modified in the system.',
    CONSTRAINT pk_work_location PRIMARY KEY(`work_location_id`)
) COMMENT 'Master reference table for work_location. Referenced by work_location_id.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`interview_scorecard` (
    `interview_scorecard_id` BIGINT COMMENT 'Primary key for interview_scorecard',
    `candidate_id` BIGINT COMMENT 'Reference to the candidate being evaluated in this interview.',
    `employee_id` BIGINT COMMENT 'Reference to the employee conducting the interview evaluation.',
    `requisition_id` BIGINT COMMENT 'Reference to the job opening for which the candidate is being interviewed.',
    `reviewed_by_employee_id` BIGINT COMMENT 'Reference to the hiring manager or HR personnel who reviewed this scorecard.',
    `revised_interview_scorecard_id` BIGINT COMMENT 'Self-referencing FK on interview_scorecard (revised_interview_scorecard_id)',
    `advance_to_next_round` BOOLEAN COMMENT 'Indicator of whether the interviewer recommends advancing the candidate to the next interview round.',
    `candidate_salary_expectation` DECIMAL(18,2) COMMENT 'The salary amount or range that the candidate indicated as their compensation expectation.',
    `communication_score` DECIMAL(18,2) COMMENT 'Numeric rating of the candidates verbal and written communication effectiveness.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this interview scorecard record was first created in the system.',
    `cultural_fit_score` DECIMAL(18,2) COMMENT 'Numeric rating of how well the candidate aligns with the organizations values and culture.',
    `detailed_feedback` STRING COMMENT 'Comprehensive written feedback from the interviewer covering all aspects of the candidates performance and interview responses.',
    `insurance_industry_knowledge_score` DECIMAL(18,2) COMMENT 'Numeric rating of the candidates understanding of life insurance, annuities, underwriting, actuarial concepts, and regulatory requirements specific to the insurance industry.',
    `interview_date` DATE COMMENT 'Date when the interview was conducted.',
    `interview_duration_minutes` STRING COMMENT 'Total length of the interview session measured in minutes.',
    `interview_location` STRING COMMENT 'Physical or virtual location where the interview was conducted (office address, video platform, phone).',
    `interview_round_number` STRING COMMENT 'Sequential number indicating which interview round this scorecard represents (e.g., 1 for first round, 2 for second round).',
    `interview_type` STRING COMMENT 'Classification of the interview format and focus area.',
    `leadership_potential_score` DECIMAL(18,2) COMMENT 'Numeric rating of the candidates demonstrated or potential leadership capabilities.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this interview scorecard record was last updated.',
    `overall_rating` STRING COMMENT 'Interviewers overall hiring recommendation for the candidate.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregate numeric score representing the candidates overall performance, typically on a scale such as 1-5 or 1-10.',
    `problem_solving_score` DECIMAL(18,2) COMMENT 'Numeric rating of the candidates analytical thinking and problem-solving abilities.',
    `questions_asked` STRING COMMENT 'List or summary of the key questions posed to the candidate during the interview session.',
    `recommendation_notes` STRING COMMENT 'Additional notes and context supporting the interviewers hiring recommendation decision.',
    `red_flags_identified` STRING COMMENT 'Documentation of any concerns, warning signs, or disqualifying factors observed during the interview.',
    `relocation_required` BOOLEAN COMMENT 'Indicator of whether the candidate would need to relocate for this position.',
    `relocation_willingness` STRING COMMENT 'The candidates expressed willingness to relocate if required for the position.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the scorecard was reviewed by the hiring manager or HR team.',
    `salary_expectation_discussed` BOOLEAN COMMENT 'Indicator of whether compensation expectations were discussed during the interview.',
    `scorecard_status` STRING COMMENT 'Current workflow state of the interview scorecard in the evaluation and approval process.',
    `scorecard_template_version` STRING COMMENT 'Version identifier of the interview scorecard template used for this evaluation.',
    `start_date_availability` DATE COMMENT 'Earliest date the candidate indicated they would be available to begin employment.',
    `strengths_summary` STRING COMMENT 'Narrative description of the candidates key strengths and positive attributes observed during the interview.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the interviewer submitted the completed scorecard for review.',
    `technical_competency_score` DECIMAL(18,2) COMMENT 'Numeric rating of the candidates technical skills and domain knowledge relevant to the position.',
    `weaknesses_summary` STRING COMMENT 'Narrative description of areas where the candidate showed gaps, weaknesses, or opportunities for improvement.',
    CONSTRAINT pk_interview_scorecard PRIMARY KEY(`interview_scorecard_id`)
) COMMENT 'Master reference table for interview_scorecard. Referenced by interview_scorecard_id.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`payroll_period` (
    `payroll_period_id` BIGINT COMMENT 'Primary key for payroll_period',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved the payroll for this period.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the company or legal entity for which this payroll period applies.',
    `payroll_calendar_id` BIGINT COMMENT 'Reference to the payroll calendar that defines the schedule and rules for this period.',
    `prior_payroll_period_id` BIGINT COMMENT 'Self-referencing FK on payroll_period (prior_payroll_period_id)',
    `approval_date` DATE COMMENT 'The date on which the payroll for this period was approved for payment.',
    `calendar_month` STRING COMMENT 'The calendar month number (1-12) in which this payroll period primarily falls.',
    `calendar_year` STRING COMMENT 'The calendar year in which this payroll period falls (e.g., 2024).',
    `check_date` DATE COMMENT 'The date printed on physical paychecks or used as the effective date for electronic payments.',
    `closed_date` DATE COMMENT 'The date on which this payroll period was officially closed and locked from further changes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period record was first created in the system.',
    `cutoff_date` DATE COMMENT 'The deadline date by which time and attendance data must be submitted for this payroll period.',
    `payroll_period_description` STRING COMMENT 'Additional descriptive information about this payroll period, including any special circumstances or notes.',
    `end_date` DATE COMMENT 'The last calendar date included in this payroll period.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) in which this payroll period falls.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this payroll period falls, used for financial reporting and budgeting.',
    `frequency_type` STRING COMMENT 'The frequency at which payroll is processed for this period (weekly, bi-weekly, semi-monthly, monthly, quarterly, annual).',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether this period is used for payroll adjustments or corrections rather than regular payroll (true/false).',
    `is_current_period` BOOLEAN COMMENT 'Indicates whether this is the current active payroll period (true/false).',
    `is_year_end_period` BOOLEAN COMMENT 'Indicates whether this is the final payroll period of the calendar or fiscal year, requiring special year-end processing (true/false).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period record was last modified.',
    `payment_date` DATE COMMENT 'The date on which employees are paid for this payroll period.',
    `period_name` STRING COMMENT 'Human-readable name or label for the payroll period (e.g., January 2024 Period 1, PP01-2024).',
    `period_number` STRING COMMENT 'Sequential number of the payroll period within the calendar or fiscal year (e.g., 1 for first period, 26 for 26th bi-weekly period).',
    `processing_date` DATE COMMENT 'The date on which payroll calculations were executed for this period.',
    `start_date` DATE COMMENT 'The first calendar date included in this payroll period.',
    `payroll_period_status` STRING COMMENT 'Current lifecycle status of the payroll period (draft, open, processing, closed, archived).',
    `tax_period` STRING COMMENT 'The sequential tax period number within the tax year, used for quarterly tax reporting.',
    `tax_year` STRING COMMENT 'The tax year to which this payroll periods earnings and withholdings are attributed for tax reporting purposes.',
    `total_days` STRING COMMENT 'The total number of calendar days in this payroll period.',
    `working_days` STRING COMMENT 'The number of standard working days (excluding weekends and holidays) in this payroll period.',
    CONSTRAINT pk_payroll_period PRIMARY KEY(`payroll_period_id`)
) COMMENT 'Master reference table for payroll_period. Referenced by payroll_period_id.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`training_session` (
    `training_session_id` BIGINT COMMENT 'Primary key for training_session',
    `employee_id` BIGINT COMMENT 'Reference to the primary instructor or facilitator leading this training session.',
    `work_location_id` BIGINT COMMENT 'Reference to the physical location or facility where the training session is held. Null for virtual sessions.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department sponsoring or organizing this training session.',
    `staff_training_id` BIGINT COMMENT 'Reference to the course or training program that this session delivers.',
    `rescheduled_training_session_id` BIGINT COMMENT 'Self-referencing FK on training_session (rescheduled_training_session_id)',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the training session concluded.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the training session commenced.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether participants must complete an assessment or examination to successfully complete this training session.',
    `attendance_count` STRING COMMENT 'The number of participants who actually attended the training session.',
    `average_satisfaction_score` DECIMAL(18,2) COMMENT 'The average satisfaction rating provided by participants, typically on a scale of 1 to 5.',
    `cancellation_reason` STRING COMMENT 'The reason provided for cancelling or postponing the training session.',
    `certification_eligible_flag` BOOLEAN COMMENT 'Indicates whether successful completion of this session qualifies participants for professional certification or continuing education credits.',
    `competency_level` STRING COMMENT 'The skill or competency level targeted by this training session.',
    `completion_count` STRING COMMENT 'The number of participants who successfully completed the training session and met all requirements.',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'The number of continuing education credits awarded upon successful completion of this training session, applicable for licensed professionals such as actuaries, underwriters, and claims adjusters.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'The cost incurred per participant for this training session, including materials, instructor fees, and facility costs.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this training session record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per participant.',
    `duration_hours` DECIMAL(18,2) COMMENT 'The planned duration of the training session measured in hours.',
    `enrolled_count` STRING COMMENT 'The current number of participants enrolled in this training session.',
    `feedback_collected_flag` BOOLEAN COMMENT 'Indicates whether participant feedback or evaluations were collected for this training session.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language of instruction for this training session.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether attendance at this training session is mandatory for enrolled participants.',
    `materials_provided_flag` BOOLEAN COMMENT 'Indicates whether training materials, handouts, or resources are provided to participants.',
    `max_capacity` STRING COMMENT 'The maximum number of participants that can be enrolled in this training session.',
    `meeting_url` STRING COMMENT 'The web link for accessing the virtual training session.',
    `modified_by` STRING COMMENT 'The user or system identifier of the person who last modified this training session record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this training session record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this training session.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'The minimum percentage score required to pass the assessment and successfully complete the training session.',
    `scheduled_end_date` DATE COMMENT 'The planned end date for the training session.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise scheduled end date and time for the training session.',
    `scheduled_start_date` DATE COMMENT 'The planned start date for the training session.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise scheduled start date and time for the training session.',
    `session_code` STRING COMMENT 'Business identifier code for the training session, used for external reference and scheduling systems.',
    `session_status` STRING COMMENT 'Current lifecycle status of the training session.',
    `session_title` STRING COMMENT 'The official title or name of this specific training session.',
    `session_type` STRING COMMENT 'The delivery modality of the training session.',
    `training_category` STRING COMMENT 'The broad category or domain of the training content.',
    `virtual_platform` STRING COMMENT 'The virtual meeting platform used for remote or hybrid training delivery.',
    `created_by` STRING COMMENT 'The user or system identifier of the person who created this training session record.',
    CONSTRAINT pk_training_session PRIMARY KEY(`training_session_id`)
) COMMENT 'Master reference table for training_session. Referenced by delivery_session_id.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`team` (
    `team_id` BIGINT COMMENT 'Primary key for team',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Annual operating budget allocated to the team in USD.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the team budget.',
    `business_unit` STRING COMMENT 'Business unit designation for the team within the enterprise structure.',
    `contact_email` STRING COMMENT 'Primary email address for contacting the team or team manager.',
    `contact_phone` STRING COMMENT 'Primary phone number for contacting the team or team manager.',
    `cost_center_code` STRING COMMENT 'Financial cost center code assigned to the team for budget tracking and expense allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the team record was first created in the system.',
    `department_id` BIGINT COMMENT 'Reference to the department to which this team belongs within the organizational hierarchy.',
    `disbandment_date` DATE COMMENT 'Date when the team was officially disbanded or dissolved. Null for active teams.',
    `disbandment_reason` STRING COMMENT 'Business reason or justification for team disbandment, if applicable.',
    `division_id` BIGINT COMMENT 'Reference to the division to which this team belongs within the organizational hierarchy.',
    `effective_end_date` DATE COMMENT 'Date when the team ceased or will cease operations. Null for active teams.',
    `effective_start_date` DATE COMMENT 'Date when the team became or will become operationally active.',
    `formation_date` DATE COMMENT 'Date when the team was officially formed or established within the organization.',
    `functional_area` STRING COMMENT 'Primary functional area or business domain that the team supports within the insurance enterprise.',
    `is_customer_facing` BOOLEAN COMMENT 'Indicates whether the team has direct interaction with external customers or policyholders.',
    `is_licensed_required` BOOLEAN COMMENT 'Indicates whether team members are required to hold professional insurance licenses (e.g., underwriting, actuarial, sales).',
    `is_regulatory_oversight` BOOLEAN COMMENT 'Indicates whether the team is subject to direct regulatory oversight or compliance monitoring.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review or assessment conducted for the team.',
    `license_type_required` STRING COMMENT 'Type of professional license required for team members, if applicable (e.g., Life & Health, Property & Casualty, Actuarial).',
    `location_id` BIGINT COMMENT 'Reference to the primary physical location or office where the team is based.',
    `manager_employee_id` BIGINT COMMENT 'Reference to the employee who manages this team.',
    `mission_statement` STRING COMMENT 'Official mission or purpose statement describing the teams objectives and responsibilities.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about the team.',
    `parent_team_id` BIGINT COMMENT 'Reference to the parent team in a hierarchical team structure. Null for top-level teams.',
    `performance_rating` STRING COMMENT 'Most recent performance rating or assessment for the team as a whole.',
    `product_line` STRING COMMENT 'Insurance product line or portfolio that the team primarily supports (e.g., life, annuities, group).',
    `service_level_tier` STRING COMMENT 'Service or support tier classification for the team, indicating escalation level or specialization.',
    `shift_pattern` STRING COMMENT 'Standard shift or schedule pattern for the team, if applicable (e.g., 9-5, 24/7 rotation, flex).',
    `target_headcount` STRING COMMENT 'Planned or target number of employees for the team based on workforce planning.',
    `team_code` STRING COMMENT 'Business identifier code for the team, used for external references and reporting.',
    `team_name` STRING COMMENT 'Official name of the team within the organizational structure.',
    `team_size` STRING COMMENT 'Current number of employees assigned to the team.',
    `team_status` STRING COMMENT 'Current operational status of the team within the organization.',
    `team_type` STRING COMMENT 'Classification of the team based on its organizational purpose and structure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the team record was last modified in the system.',
    `work_model` STRING COMMENT 'Primary work arrangement model for the team members.',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'Master reference table for team. Referenced by assigned_team_id.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`region` (
    `region_id` BIGINT COMMENT 'Primary key for region',
    `annual_premium_target_amount` DECIMAL(18,2) COMMENT 'Target annual premium revenue goal for the region in the base currency.',
    `cost_center_code` STRING COMMENT 'General ledger cost center code assigned to this region for financial accounting and expense tracking.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the primary country this region operates within.',
    `created_by_user_id` STRING COMMENT 'User identifier of the person who created this region record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this region record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for financial targets and reporting in this region.',
    `region_description` STRING COMMENT 'Detailed textual description of the region, its purpose, coverage, and any special characteristics or business notes.',
    `distribution_channel_mix` STRING COMMENT 'Comma-separated list of primary distribution channels used in this region (e.g., agent, broker, direct, bancassurance, worksite).',
    `effective_end_date` DATE COMMENT 'Date when this region ceased operations or was deactivated. Null for currently active regions.',
    `effective_start_date` DATE COMMENT 'Date when this region became active and operational for business purposes.',
    `employee_headcount` STRING COMMENT 'Total number of employees assigned to this region.',
    `geographic_scope` STRING COMMENT 'The geographic breadth of the region (national, multi-state, single state, metropolitan area, county, or local).',
    `headquarters_office_id` BIGINT COMMENT 'Identifier of the primary office or facility serving as the regional headquarters.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the regional hierarchy (e.g., 1=national, 2=division, 3=district, 4=territory) for organizational rollup and reporting.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this region is currently active and available for assignment and operations.',
    `last_modified_by_user_id` STRING COMMENT 'User identifier of the person who last modified this region record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this region record was last updated.',
    `licensed_states_count` STRING COMMENT 'Number of states or jurisdictions in which the region is licensed to conduct insurance business.',
    `market_segment_focus` STRING COMMENT 'Primary market segment or customer demographic this region focuses on (e.g., individual life, group life, annuities, high net worth).',
    `office_address_line_1` STRING COMMENT 'First line of the regional headquarters street address.',
    `office_address_line_2` STRING COMMENT 'Second line of the regional headquarters street address (suite, floor, building).',
    `office_city` STRING COMMENT 'City where the regional headquarters is located.',
    `office_country_code` STRING COMMENT 'Three-letter ISO country code for the regional headquarters location.',
    `office_email_address` STRING COMMENT 'General email address for the regional headquarters office.',
    `office_fax_number` STRING COMMENT 'Fax number for the regional headquarters office.',
    `office_phone_number` STRING COMMENT 'Primary contact phone number for the regional headquarters.',
    `office_postal_code` STRING COMMENT 'Postal or ZIP code for the regional headquarters address.',
    `office_state_province` STRING COMMENT 'State or province code for the regional headquarters location.',
    `parent_region_id` BIGINT COMMENT 'Reference to the parent region in a hierarchical structure, enabling multi-level regional rollups (e.g., district rolls up to division).',
    `profit_center_code` STRING COMMENT 'General ledger profit center code for revenue and profitability reporting for this region.',
    `region_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the region for business use and reporting.',
    `region_name` STRING COMMENT 'Full business name of the region (e.g., Northeast, Pacific Northwest, Mid-Atlantic).',
    `region_type` STRING COMMENT 'Classification of the region by its primary business function (sales territory, operational zone, administrative district, underwriting region, claims jurisdiction, or composite multi-function).',
    `regional_manager_employee_id` BIGINT COMMENT 'Employee identifier of the manager responsible for this region.',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory jurisdiction or insurance department governing this region (e.g., state insurance commissioner, provincial regulator).',
    `state_province_list` STRING COMMENT 'Comma-separated list of state or province codes covered by this region (e.g., NY,NJ,CT for a Northeast region).',
    `region_status` STRING COMMENT 'Current lifecycle status of the region indicating whether it is actively used for business operations.',
    `time_zone` STRING COMMENT 'Primary time zone for the region using IANA time zone database format (e.g., America/New_York, America/Chicago).',
    CONSTRAINT pk_region PRIMARY KEY(`region_id`)
) COMMENT 'Master reference table for region. Referenced by region_id.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`workforce`.`payroll_calendar` (
    `payroll_calendar_id` BIGINT COMMENT 'Primary key for payroll_calendar',
    `prior_payroll_calendar_id` BIGINT COMMENT 'Self-referencing FK on payroll_calendar (prior_payroll_calendar_id)',
    `approved_by_user_id` STRING COMMENT 'Identifier of the user who approved this payroll period for processing.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period was approved for processing. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `calendar_code` STRING COMMENT 'Business identifier code for the payroll calendar (e.g., BIWEEKLY_US, MONTHLY_CA). Used for external reference and integration.',
    `calendar_name` STRING COMMENT 'Human-readable name of the payroll calendar (e.g., US Biweekly Payroll, Canada Monthly Payroll).',
    `calendar_year` STRING COMMENT 'The calendar year to which this payroll period belongs (e.g., 2024).',
    `check_date` DATE COMMENT 'The date printed on physical payroll checks or used as the effective date for electronic payments. May differ from pay_date due to banking schedules. Format: yyyy-MM-dd.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period was closed and archived. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the jurisdiction for this payroll calendar (e.g., USA, CAN, GBR).',
    `created_by_user_id` STRING COMMENT 'Identifier of the user or system account that created this payroll calendar record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll calendar record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `payroll_calendar_description` STRING COMMENT 'Additional descriptive text or notes about this payroll period (e.g., special processing instructions, holiday adjustments).',
    `effective_end_date` DATE COMMENT 'The date on which this payroll calendar configuration ceases to be effective. Nullable for open-ended calendars. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'The date from which this payroll calendar configuration becomes effective. Format: yyyy-MM-dd.',
    `fiscal_period` STRING COMMENT 'The fiscal period or month number (1-12 or 1-13 for 13-period calendars) within the fiscal year.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) to which this payroll period belongs.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this payroll period is assigned for financial reporting purposes. May differ from calendar_year.',
    `frequency_type` STRING COMMENT 'The frequency at which payroll is processed for this calendar (weekly, biweekly, semi-monthly, monthly, quarterly, annual).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this payroll calendar record is currently active (true) or has been deactivated (false).',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether this is a special adjustment or correction period (true) or a regular payroll period (false).',
    `is_off_cycle` BOOLEAN COMMENT 'Indicates whether this is an off-cycle payroll run (true) outside the regular schedule, or a standard scheduled payroll (false).',
    `legal_entity_code` STRING COMMENT 'Code identifying the legal entity or subsidiary that owns this payroll calendar. Used for multi-entity organizations.',
    `locked_by_user_id` STRING COMMENT 'Identifier of the user or system account that locked this payroll period.',
    `locked_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period was locked to prevent further timesheet or data changes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `modified_by_user_id` STRING COMMENT 'Identifier of the user or system account that last modified this payroll calendar record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll calendar record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `pay_date` DATE COMMENT 'The date on which employees are paid for this payroll period. Format: yyyy-MM-dd.',
    `pay_period_number` STRING COMMENT 'Sequential number of the pay period within the calendar year (e.g., 1-26 for biweekly, 1-12 for monthly).',
    `payroll_group_code` STRING COMMENT 'Code identifying the employee group or division using this payroll calendar (e.g., SALARIED, HOURLY, EXECUTIVE, UNION_A).',
    `payroll_processing_date` DATE COMMENT 'The date on which payroll calculations and processing are scheduled to occur. Format: yyyy-MM-dd.',
    `period_end_date` DATE COMMENT 'The last day of the payroll period. Format: yyyy-MM-dd.',
    `period_start_date` DATE COMMENT 'The first day of the payroll period. Format: yyyy-MM-dd.',
    `state_province_code` STRING COMMENT 'Two or three-letter code for the state or province jurisdiction (e.g., CA for California, ON for Ontario). Nullable for national-level calendars.',
    `payroll_calendar_status` STRING COMMENT 'Current lifecycle status of the payroll period (draft: not yet active, open: accepting timesheets, locked: no further changes, processing: payroll being calculated, completed: payroll processed, closed: period archived).',
    `tax_year` STRING COMMENT 'The tax year to which this payroll period belongs for tax withholding and reporting purposes.',
    `timesheet_due_date` DATE COMMENT 'The deadline by which timesheets must be submitted for this payroll period. Format: yyyy-MM-dd.',
    `total_days_count` STRING COMMENT 'The total number of calendar days in this payroll period.',
    `working_days_count` STRING COMMENT 'The number of working days (excluding weekends and holidays) within this payroll period.',
    CONSTRAINT pk_payroll_calendar PRIMARY KEY(`payroll_calendar_id`)
) COMMENT 'Master reference table for payroll_calendar. Referenced by payroll_calendar_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `life_insurance_ecm`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `life_insurance_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `life_insurance_ecm`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `life_insurance_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ADD CONSTRAINT `fk_workforce_job_role_parent_job_role_id` FOREIGN KEY (`parent_job_role_id`) REFERENCES `life_insurance_ecm`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_primary_employment_employee_id` FOREIGN KEY (`primary_employment_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_position_id` FOREIGN KEY (`position_id`) REFERENCES `life_insurance_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_quaternary_employment_new_supervisor_employee_id` FOREIGN KEY (`quaternary_employment_new_supervisor_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_tertiary_employment_prior_supervisor_employee_id` FOREIGN KEY (`tertiary_employment_prior_supervisor_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_prior_employment_record_id` FOREIGN KEY (`prior_employment_record_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employment_record`(`employment_record_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `life_insurance_ecm`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_position_id` FOREIGN KEY (`position_id`) REFERENCES `life_insurance_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_superseded_compensation_id` FOREIGN KEY (`superseded_compensation_id`) REFERENCES `life_insurance_ecm`.`workforce`.`compensation`(`compensation_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_compensation_id` FOREIGN KEY (`compensation_id`) REFERENCES `life_insurance_ecm`.`workforce`.`compensation`(`compensation_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_adjustment_payroll_record_id` FOREIGN KEY (`adjustment_payroll_record_id`) REFERENCES `life_insurance_ecm`.`workforce`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_superseded_benefit_enrollment_id` FOREIGN KEY (`superseded_benefit_enrollment_id`) REFERENCES `life_insurance_ecm`.`workforce`.`benefit_enrollment`(`benefit_enrollment_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ADD CONSTRAINT `fk_workforce_staff_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ADD CONSTRAINT `fk_workforce_staff_license_renewed_staff_license_id` FOREIGN KEY (`renewed_staff_license_id`) REFERENCES `life_insurance_ecm`.`workforce`.`staff_license`(`staff_license_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ADD CONSTRAINT `fk_workforce_ce_credit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ADD CONSTRAINT `fk_workforce_ce_credit_staff_license_id` FOREIGN KEY (`staff_license_id`) REFERENCES `life_insurance_ecm`.`workforce`.`staff_license`(`staff_license_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ADD CONSTRAINT `fk_workforce_ce_credit_corrected_ce_credit_id` FOREIGN KEY (`corrected_ce_credit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`ce_credit`(`ce_credit_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ADD CONSTRAINT `fk_workforce_staff_training_course_owner_employee_id` FOREIGN KEY (`course_owner_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ADD CONSTRAINT `fk_workforce_staff_training_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ADD CONSTRAINT `fk_workforce_staff_training_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ADD CONSTRAINT `fk_workforce_staff_training_prerequisite_staff_training_id` FOREIGN KEY (`prerequisite_staff_training_id`) REFERENCES `life_insurance_ecm`.`workforce`.`staff_training`(`staff_training_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_training_session_id` FOREIGN KEY (`training_session_id`) REFERENCES `life_insurance_ecm`.`workforce`.`training_session`(`training_session_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_staff_training_id` FOREIGN KEY (`staff_training_id`) REFERENCES `life_insurance_ecm`.`workforce`.`staff_training`(`staff_training_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_reenrollment_training_enrollment_id` FOREIGN KEY (`reenrollment_training_enrollment_id`) REFERENCES `life_insurance_ecm`.`workforce`.`training_enrollment`(`training_enrollment_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ADD CONSTRAINT `fk_workforce_workforce_performance_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ADD CONSTRAINT `fk_workforce_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `life_insurance_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ADD CONSTRAINT `fk_workforce_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ADD CONSTRAINT `fk_workforce_workforce_performance_review_quaternary_workforce_created_by_user_employee_id` FOREIGN KEY (`quaternary_workforce_created_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ADD CONSTRAINT `fk_workforce_workforce_performance_review_quinary_workforce_last_modified_by_user_employee_id` FOREIGN KEY (`quinary_workforce_last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ADD CONSTRAINT `fk_workforce_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ADD CONSTRAINT `fk_workforce_workforce_performance_review_tertiary_workforce_final_approver_employee_id` FOREIGN KEY (`tertiary_workforce_final_approver_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ADD CONSTRAINT `fk_workforce_workforce_performance_review_prior_period_workforce_performance_review_id` FOREIGN KEY (`prior_period_workforce_performance_review_id`) REFERENCES `life_insurance_ecm`.`workforce`.`workforce_performance_review`(`workforce_performance_review_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ADD CONSTRAINT `fk_workforce_performance_goal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ADD CONSTRAINT `fk_workforce_performance_goal_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ADD CONSTRAINT `fk_workforce_performance_goal_primary_performance_employee_id` FOREIGN KEY (`primary_performance_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ADD CONSTRAINT `fk_workforce_performance_goal_tertiary_performance_approved_by_employee_id` FOREIGN KEY (`tertiary_performance_approved_by_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ADD CONSTRAINT `fk_workforce_performance_goal_workforce_performance_review_id` FOREIGN KEY (`workforce_performance_review_id`) REFERENCES `life_insurance_ecm`.`workforce`.`workforce_performance_review`(`workforce_performance_review_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ADD CONSTRAINT `fk_workforce_performance_goal_parent_performance_goal_id` FOREIGN KEY (`parent_performance_goal_id`) REFERENCES `life_insurance_ecm`.`workforce`.`performance_goal`(`performance_goal_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_position_id` FOREIGN KEY (`position_id`) REFERENCES `life_insurance_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_tertiary_leave_substitute_employee_id` FOREIGN KEY (`tertiary_leave_substitute_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_extended_leave_request_id` FOREIGN KEY (`extended_leave_request_id`) REFERENCES `life_insurance_ecm`.`workforce`.`leave_request`(`leave_request_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ADD CONSTRAINT `fk_workforce_time_record_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `life_insurance_ecm`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ADD CONSTRAINT `fk_workforce_time_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ADD CONSTRAINT `fk_workforce_time_record_tertiary_time_adjusted_by_employee_id` FOREIGN KEY (`tertiary_time_adjusted_by_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ADD CONSTRAINT `fk_workforce_time_record_work_schedule_id` FOREIGN KEY (`work_schedule_id`) REFERENCES `life_insurance_ecm`.`workforce`.`work_schedule`(`work_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ADD CONSTRAINT `fk_workforce_time_record_corrected_time_record_id` FOREIGN KEY (`corrected_time_record_id`) REFERENCES `life_insurance_ecm`.`workforce`.`time_record`(`time_record_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `life_insurance_ecm`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `life_insurance_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_prior_period_headcount_plan_id` FOREIGN KEY (`prior_period_headcount_plan_id`) REFERENCES `life_insurance_ecm`.`workforce`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_headcount_plan_id` FOREIGN KEY (`headcount_plan_id`) REFERENCES `life_insurance_ecm`.`workforce`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `life_insurance_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_requisition_hiring_manager_employee_id` FOREIGN KEY (`requisition_hiring_manager_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_requisition_recruiter_employee_id` FOREIGN KEY (`requisition_recruiter_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_requisition_replacement_employee_id` FOREIGN KEY (`requisition_replacement_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_replacement_requisition_id` FOREIGN KEY (`replacement_requisition_id`) REFERENCES `life_insurance_ecm`.`workforce`.`requisition`(`requisition_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_candidate_recruiter_employee_id` FOREIGN KEY (`candidate_recruiter_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_candidate_referral_source_employee_id` FOREIGN KEY (`candidate_referral_source_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_referred_by_candidate_id` FOREIGN KEY (`referred_by_candidate_id`) REFERENCES `life_insurance_ecm`.`workforce`.`candidate`(`candidate_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_candidate_id` FOREIGN KEY (`candidate_id`) REFERENCES `life_insurance_ecm`.`workforce`.`candidate`(`candidate_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_interview_scorecard_id` FOREIGN KEY (`interview_scorecard_id`) REFERENCES `life_insurance_ecm`.`workforce`.`interview_scorecard`(`interview_scorecard_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_primary_interviewer_employee_id` FOREIGN KEY (`primary_interviewer_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `life_insurance_ecm`.`workforce`.`requisition`(`requisition_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_rescheduled_from_interview_event_id` FOREIGN KEY (`rescheduled_from_interview_event_id`) REFERENCES `life_insurance_ecm`.`workforce`.`interview_event`(`interview_event_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ADD CONSTRAINT `fk_workforce_interview_event_follow_up_interview_event_id` FOREIGN KEY (`follow_up_interview_event_id`) REFERENCES `life_insurance_ecm`.`workforce`.`interview_event`(`interview_event_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ADD CONSTRAINT `fk_workforce_offer_candidate_id` FOREIGN KEY (`candidate_id`) REFERENCES `life_insurance_ecm`.`workforce`.`candidate`(`candidate_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ADD CONSTRAINT `fk_workforce_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ADD CONSTRAINT `fk_workforce_offer_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ADD CONSTRAINT `fk_workforce_offer_offer_approved_by_employee_id` FOREIGN KEY (`offer_approved_by_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ADD CONSTRAINT `fk_workforce_offer_offer_employee_id` FOREIGN KEY (`offer_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ADD CONSTRAINT `fk_workforce_offer_offer_recruiter_employee_id` FOREIGN KEY (`offer_recruiter_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ADD CONSTRAINT `fk_workforce_offer_position_id` FOREIGN KEY (`position_id`) REFERENCES `life_insurance_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ADD CONSTRAINT `fk_workforce_offer_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `life_insurance_ecm`.`workforce`.`requisition`(`requisition_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ADD CONSTRAINT `fk_workforce_offer_revised_offer_id` FOREIGN KEY (`revised_offer_id`) REFERENCES `life_insurance_ecm`.`workforce`.`offer`(`offer_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_quaternary_disciplinary_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_disciplinary_last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_tertiary_disciplinary_created_by_user_employee_id` FOREIGN KEY (`tertiary_disciplinary_created_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_escalated_from_disciplinary_action_id` FOREIGN KEY (`escalated_from_disciplinary_action_id`) REFERENCES `life_insurance_ecm`.`workforce`.`disciplinary_action`(`disciplinary_action_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_primary_successor_employee_id` FOREIGN KEY (`primary_successor_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `life_insurance_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_tertiary_succession_approved_by_employee_id` FOREIGN KEY (`tertiary_succession_approved_by_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_tertiary_successor_employee_id` FOREIGN KEY (`tertiary_successor_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_superseded_succession_plan_id` FOREIGN KEY (`superseded_succession_plan_id`) REFERENCES `life_insurance_ecm`.`workforce`.`succession_plan`(`succession_plan_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ADD CONSTRAINT `fk_workforce_work_schedule_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ADD CONSTRAINT `fk_workforce_work_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ADD CONSTRAINT `fk_workforce_work_schedule_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ADD CONSTRAINT `fk_workforce_work_schedule_superseded_work_schedule_id` FOREIGN KEY (`superseded_work_schedule_id`) REFERENCES `life_insurance_ecm`.`workforce`.`work_schedule`(`work_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ADD CONSTRAINT `fk_workforce_uw_authority_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ADD CONSTRAINT `fk_workforce_uw_authority_assignment_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ADD CONSTRAINT `fk_workforce_uw_authority_assignment_primary_uw_employee_id` FOREIGN KEY (`primary_uw_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ADD CONSTRAINT `fk_workforce_uw_authority_assignment_uw_employee_id` FOREIGN KEY (`uw_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ADD CONSTRAINT `fk_workforce_uw_authority_assignment_superseded_uw_authority_assignment_id` FOREIGN KEY (`superseded_uw_authority_assignment_id`) REFERENCES `life_insurance_ecm`.`workforce`.`uw_authority_assignment`(`uw_authority_assignment_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_position_id` FOREIGN KEY (`position_id`) REFERENCES `life_insurance_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `life_insurance_ecm`.`workforce`.`requisition`(`requisition_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_tertiary_background_reviewed_by_employee_id` FOREIGN KEY (`tertiary_background_reviewed_by_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_renewal_background_check_id` FOREIGN KEY (`renewal_background_check_id`) REFERENCES `life_insurance_ecm`.`workforce`.`background_check`(`background_check_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ADD CONSTRAINT `fk_workforce_employee_skill_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ADD CONSTRAINT `fk_workforce_employee_skill_superseded_employee_skill_id` FOREIGN KEY (`superseded_employee_skill_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee_skill`(`employee_skill_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ADD CONSTRAINT `fk_workforce_work_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ADD CONSTRAINT `fk_workforce_work_location_region_id` FOREIGN KEY (`region_id`) REFERENCES `life_insurance_ecm`.`workforce`.`region`(`region_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ADD CONSTRAINT `fk_workforce_work_location_parent_work_location_id` FOREIGN KEY (`parent_work_location_id`) REFERENCES `life_insurance_ecm`.`workforce`.`work_location`(`work_location_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_scorecard` ADD CONSTRAINT `fk_workforce_interview_scorecard_candidate_id` FOREIGN KEY (`candidate_id`) REFERENCES `life_insurance_ecm`.`workforce`.`candidate`(`candidate_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_scorecard` ADD CONSTRAINT `fk_workforce_interview_scorecard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_scorecard` ADD CONSTRAINT `fk_workforce_interview_scorecard_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `life_insurance_ecm`.`workforce`.`requisition`(`requisition_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_scorecard` ADD CONSTRAINT `fk_workforce_interview_scorecard_reviewed_by_employee_id` FOREIGN KEY (`reviewed_by_employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_scorecard` ADD CONSTRAINT `fk_workforce_interview_scorecard_revised_interview_scorecard_id` FOREIGN KEY (`revised_interview_scorecard_id`) REFERENCES `life_insurance_ecm`.`workforce`.`interview_scorecard`(`interview_scorecard_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_payroll_calendar_id` FOREIGN KEY (`payroll_calendar_id`) REFERENCES `life_insurance_ecm`.`workforce`.`payroll_calendar`(`payroll_calendar_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_prior_payroll_period_id` FOREIGN KEY (`prior_payroll_period_id`) REFERENCES `life_insurance_ecm`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `life_insurance_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `life_insurance_ecm`.`workforce`.`work_location`(`work_location_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `life_insurance_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_staff_training_id` FOREIGN KEY (`staff_training_id`) REFERENCES `life_insurance_ecm`.`workforce`.`staff_training`(`staff_training_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_rescheduled_training_session_id` FOREIGN KEY (`rescheduled_training_session_id`) REFERENCES `life_insurance_ecm`.`workforce`.`training_session`(`training_session_id`);
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_calendar` ADD CONSTRAINT `fk_workforce_payroll_calendar_prior_payroll_calendar_id` FOREIGN KEY (`prior_payroll_calendar_id`) REFERENCES `life_insurance_ecm`.`workforce`.`payroll_calendar`(`payroll_calendar_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `life_insurance_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'employee_administration');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `annual_base_salary` SET TAGS ('dbx_business_glossary_term' = 'Annual Base Salary');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `annual_base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `annual_base_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'Pending|Cleared|Conditional|Failed|Not Required|Expired');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth (DOB)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'Yes|No|Prefer Not to Disclose');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `eeo_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Category');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'Active|On Leave|Terminated|Retired|Deceased|Suspended');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'Full-Time|Part-Time|Contractor|Temporary|Intern|Seasonal');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Employee Ethnicity');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `ethnicity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'Exempt|Non-Exempt');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Employee Gender');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'Male|Female|Non-Binary|Prefer Not to Disclose');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Hire Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Employee Home Address Line 1');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Employee Home Address Line 2');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('dbx_business_glossary_term' = 'Employee Home City');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_country` SET TAGS ('dbx_business_glossary_term' = 'Employee Home Country');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Employee Home Postal Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_state` SET TAGS ('dbx_business_glossary_term' = 'Employee Home State');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `home_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `hr_system_code` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) System Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `hr_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,36}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `i9_verification_date` SET TAGS ('dbx_business_glossary_term' = 'I-9 Verification Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `personal_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Personal Phone Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `personal_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `personal_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Preferred Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('dbx_value_regex' = '^d{3}-d{2}-d{4}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Termination Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `veteran_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `veteran_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'US Citizen|Permanent Resident|Work Visa|EAD|Pending|Expired');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Work Phone Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'employee_administration');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Template Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Position Created Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Position Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `eligible_for_bonus` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Bonus Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Position End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `fte_count` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Count');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `is_critical_role` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Role Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `minimum_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|filled|frozen|eliminated|pending_approval');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `primary_work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Work Location Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `requires_actuarial_credential` SET TAGS ('dbx_business_glossary_term' = 'Requires Actuarial Credential Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `requires_finra_registration` SET TAGS ('dbx_business_glossary_term' = 'Requires Financial Industry Regulatory Authority (FINRA) Registration Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `requires_insurance_license` SET TAGS ('dbx_business_glossary_term' = 'Requires Insurance License Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `salary_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `salary_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Midpoint');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `span_of_control` SET TAGS ('dbx_business_glossary_term' = 'Span of Control');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `succession_plan_exists` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Exists Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_site|hybrid|remote');
ALTER TABLE `life_insurance_ecm`.`workforce`.`position` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` SET TAGS ('dbx_subdomain' = 'employee_administration');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `parent_job_role_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `background_check_level` SET TAGS ('dbx_business_glossary_term' = 'Background Check Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `background_check_level` SET TAGS ('dbx_value_regex' = 'none|basic|standard|enhanced|financial_services');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `continuing_education_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Hours Required');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `core_competencies` SET TAGS ('dbx_business_glossary_term' = 'Core Competencies');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `eeo_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Category');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|seasonal|intern');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `fiduciary_role` SET TAGS ('dbx_business_glossary_term' = 'Fiduciary Role Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `finra_registration_required` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Registration Required');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `finra_series_required` SET TAGS ('dbx_business_glossary_term' = 'FINRA Series Examinations Required');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `grade_band` SET TAGS ('dbx_business_glossary_term' = 'Grade Band');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `grade_band` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `job_sub_family` SET TAGS ('dbx_business_glossary_term' = 'Job Sub-Family');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `maximum_grade` SET TAGS ('dbx_business_glossary_term' = 'Maximum Grade');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `minimum_grade` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `preferred_designations` SET TAGS ('dbx_business_glossary_term' = 'Preferred Professional Designations');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `preferred_education_level` SET TAGS ('dbx_business_glossary_term' = 'Preferred Education Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `preferred_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional_degree');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `preferred_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Preferred Experience Years');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `required_designations` SET TAGS ('dbx_business_glossary_term' = 'Required Professional Designations');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `required_education_level` SET TAGS ('dbx_business_glossary_term' = 'Required Education Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `required_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional_degree');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `required_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Required Experience Years');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `required_licenses` SET TAGS ('dbx_business_glossary_term' = 'Required Professional Licenses');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Role Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `role_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `role_description` SET TAGS ('dbx_business_glossary_term' = 'Role Description');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `role_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|obsolete|under_review');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Safety Sensitive Role Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `sec_registration_required` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Registration Required');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `soc_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Occupational Classification (SOC) Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `soc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{4}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `span_of_control_max` SET TAGS ('dbx_business_glossary_term' = 'Span of Control Maximum');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `span_of_control_min` SET TAGS ('dbx_business_glossary_term' = 'Span of Control Minimum');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `succession_criticality` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Criticality');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `succession_criticality` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `supervisory_role` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Role Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `technical_skills` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `travel_requirement_pct` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `life_insurance_ecm`.`workforce`.`job_role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'employee_administration');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `current_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_capacity` SET TAGS ('dbx_business_glossary_term' = 'Headcount Capacity');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Location Address Line 1');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Location Address Line 2');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Location Country Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Location Postal Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_state` SET TAGS ('dbx_business_glossary_term' = 'Location State');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `mission_statement` SET TAGS ('dbx_business_glossary_term' = 'Mission Statement');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|dissolved|merged');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_value_regex' = 'division|department|team|cost_center|business_unit|branch');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `profit_center_flag` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`org_unit` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` SET TAGS ('dbx_subdomain' = 'employee_administration');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `employment_record_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Record Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Action Approver Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Organizational Unit Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Position Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `quaternary_employment_new_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'New Supervisor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `quaternary_employment_new_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `quaternary_employment_new_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `tertiary_employment_prior_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Supervisor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `tertiary_employment_prior_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `tertiary_employment_prior_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `prior_employment_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Employment Action Approval Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `benefits_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Benefits Change Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Comments');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `compensation_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `compensation_change_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `compensation_change_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `last_working_date` SET TAGS ('dbx_business_glossary_term' = 'Last Working Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `leave_expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Leave of Absence Expected Return Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `leave_start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave of Absence Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave of Absence Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'medical|parental|personal|military|disability|sabbatical');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `licensing_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Licensing Impact Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `new_employment_status` SET TAGS ('dbx_business_glossary_term' = 'New Employment Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `new_employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|terminated');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `new_employment_type` SET TAGS ('dbx_business_glossary_term' = 'New Employment Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `new_employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `new_job_grade` SET TAGS ('dbx_business_glossary_term' = 'New Job Grade Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `new_work_location_code` SET TAGS ('dbx_business_glossary_term' = 'New Work Location Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `prior_employment_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Employment Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `prior_employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|terminated');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `prior_employment_type` SET TAGS ('dbx_business_glossary_term' = 'Prior Employment Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `prior_employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `prior_job_grade` SET TAGS ('dbx_business_glossary_term' = 'Prior Job Grade Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `prior_work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Work Location Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Reason Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Reason Description');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `rehire_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `system_access_change_flag` SET TAGS ('dbx_business_glossary_term' = 'System Access Change Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `termination_type` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|retirement|death|end_of_contract');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employment_record` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `superseded_compensation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `annualized_base` SET TAGS ('dbx_business_glossary_term' = 'Annualized Base Compensation');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `annualized_base` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `base_salary` SET TAGS ('dbx_business_glossary_term' = 'Base Salary');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compa_ratio` SET TAGS ('dbx_business_glossary_term' = 'Compa-Ratio');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compa_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Record Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_value_regex' = 'active|pending|superseded|terminated');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|commission_eligible|contract|per_diem|stipend');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_eligible` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Eligible');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalency (FTE) Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `last_merit_increase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Merit Increase Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `last_merit_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Last Merit Increase Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `last_merit_increase_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `long_term_incentive_eligible` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Incentive (LTI) Eligible');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `market_reference_percentile` SET TAGS ('dbx_business_glossary_term' = 'Market Reference Percentile');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `market_reference_percentile` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_band` SET TAGS ('dbx_business_glossary_term' = 'Pay Band');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|semi_monthly|monthly');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Reason Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Compensation Review Cycle');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|ad_hoc|not_applicable');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Bonus Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `target_total_compensation` SET TAGS ('dbx_business_glossary_term' = 'Target Total Compensation');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `target_total_compensation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`compensation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `adjustment_payroll_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last Four Digits');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `charitable_contribution_posttax` SET TAGS ('dbx_business_glossary_term' = 'Charitable Contribution Post-Tax Deduction');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `dental_insurance_pretax_deduction` SET TAGS ('dbx_business_glossary_term' = 'Dental Insurance Pre-Tax Deduction');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Federal Income Tax Withheld');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `fsa_pretax_deduction` SET TAGS ('dbx_business_glossary_term' = 'Flexible Spending Account (FSA) Pre-Tax Deduction');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Garnishment Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_pretax_deduction` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Pre-Tax Deduction');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_pretax_deduction` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_pretax_deduction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `hsa_pretax_deduction` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Pre-Tax Deduction');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Local Income Tax Withheld');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax Withheld (FICA)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|pay_card|cash');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_value_regex' = 'draft|approved|processed|paid|voided|reversed');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `regular_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `regular_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Regular Pay Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `retirement_plan_pretax_deduction` SET TAGS ('dbx_business_glossary_term' = 'Retirement Plan Pre-Tax Deduction (401k)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax Withheld (FICA)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'State Income Tax Withheld');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_posttax_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Post-Tax Deductions');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_pretax_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Pre-Tax Deductions');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `union_dues_posttax_deduction` SET TAGS ('dbx_business_glossary_term' = 'Union Dues Post-Tax Deduction');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `vision_insurance_pretax_deduction` SET TAGS ('dbx_business_glossary_term' = 'Vision Insurance Pre-Tax Deduction');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_federal_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Federal Income Tax Withheld');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Pay');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_medicare_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Medicare Tax Withheld');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_social_security_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Social Security Tax Withheld');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_social_security_tax` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_social_security_tax` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_state_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) State Income Tax Withheld');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `superseded_benefit_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_designation_complete` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation Complete');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_continuation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Continuation Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_qualifying_event` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Qualifying Event');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Qualifying Event Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family|employee_domestic_partner');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `deduction_end_date` SET TAGS ('dbx_business_glossary_term' = 'Deduction End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `deduction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Deduction Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `election_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Election Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `election_end_date` SET TAGS ('dbx_business_glossary_term' = 'Election End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_confirmation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Sent Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online_portal|paper_form|phone|benefits_counselor|mobile_app|kiosk');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|waived|cancelled|suspended');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `eoi_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `eoi_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|declined|in_review');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Required');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `imputed_income_amount` SET TAGS ('dbx_business_glossary_term' = 'Imputed Income Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `pre_tax_indicator` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qle_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qle_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `tobacco_user_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tobacco User Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_indicator` SET TAGS ('dbx_business_glossary_term' = 'Waiver Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `wellness_program_participation` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Participation');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` SET TAGS ('dbx_subdomain' = 'learning_compliance');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `staff_license_id` SET TAGS ('dbx_business_glossary_term' = 'Staff License Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `renewed_staff_license_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `appointment_status` SET TAGS ('dbx_value_regex' = 'appointed|not_appointed|pending|terminated');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `ce_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Compliance Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `ce_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|at_risk|not_applicable');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `ce_credits_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Credits Completed');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `ce_credits_remaining` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Credits Remaining');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `ce_credits_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Credits Required');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `company_sponsored_flag` SET TAGS ('dbx_business_glossary_term' = 'Company Sponsored Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `crd_number` SET TAGS ('dbx_business_glossary_term' = 'Central Registration Depository (CRD) Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `crd_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `designation_type` SET TAGS ('dbx_business_glossary_term' = 'Professional Designation Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'License Issue Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `issuing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Issuing Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `license_class` SET TAGS ('dbx_business_glossary_term' = 'License Class');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `license_class` SET TAGS ('dbx_value_regex' = 'resident|non_resident|reciprocal');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'life|health|variable|property_casualty|surplus_lines|limited_lines');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `license_verification_url` SET TAGS ('dbx_business_glossary_term' = 'License Verification Uniform Resource Locator (URL)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `lines_of_authority` SET TAGS ('dbx_business_glossary_term' = 'Lines of Authority (LOA)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `nipr_number` SET TAGS ('dbx_business_glossary_term' = 'National Insurance Producer Registry (NIPR) Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `nipr_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'License Termination Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_license` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'License Termination Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` SET TAGS ('dbx_subdomain' = 'learning_compliance');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `ce_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Credit Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `staff_license_id` SET TAGS ('dbx_business_glossary_term' = 'Staff License Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `corrected_ce_credit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `applicable_state` SET TAGS ('dbx_business_glossary_term' = 'Applicable State');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `applicable_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `audit_selected_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Selected Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `carryover_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Carryover Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Course Completion Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `completion_method` SET TAGS ('dbx_business_glossary_term' = 'Completion Method');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `completion_method` SET TAGS ('dbx_value_regex' = 'classroom|webinar|self_study|conference|on_demand');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Course Cost Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `course_number` SET TAGS ('dbx_business_glossary_term' = 'Course Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours Earned');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'general|ethics|state_specific|annuity|long_term_care|flood');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `designation_code` SET TAGS ('dbx_business_glossary_term' = 'Professional Designation Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Expiration Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `provider_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Provider Approval Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Provider Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `reimbursement_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `submission_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Confirmation Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|accepted|rejected|expired');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`ce_credit` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|verified|failed_verification|pending_verification');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` SET TAGS ('dbx_subdomain' = 'learning_compliance');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `staff_training_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Training ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Course Owner Employee ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `prerequisite_staff_training_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'exam|quiz|project|practical|observation|none');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `average_completion_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Average Completion Rate Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `average_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Average Satisfaction Score');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `ce_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Credit Hours');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `ce_credit_type` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Credit Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `ce_credit_type` SET TAGS ('dbx_value_regex' = 'general|ethics|product_specific|technical|none');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `certification_issued` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Participant');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_category` SET TAGS ('dbx_value_regex' = 'technical|compliance|leadership|sales|product|professional_development');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_materials_url` SET TAGS ('dbx_business_glossary_term' = 'Course Materials URL');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|retired|draft');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `course_type` SET TAGS ('dbx_value_regex' = 'role_specific|general|onboarding|certification|continuing_education');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'ilt|vilt|elearning|ojt|blended|self_paced');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `last_content_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Content Review Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `learning_objectives` SET TAGS ('dbx_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `max_enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment Capacity');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `prerequisite_courses` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Courses');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `recurrence_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency Months');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `target_job_roles` SET TAGS ('dbx_business_glossary_term' = 'Target Job Roles');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `vendor_course_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Course ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `vendor_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Provider Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`staff_training` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` SET TAGS ('dbx_subdomain' = 'learning_compliance');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_session_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Session Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `staff_training_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Training Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `reenrollment_training_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `attendance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attendance Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `certificate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiration Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `ceu_awarded` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Units (CEU) Awarded');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `compliance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Due Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `credit_hours_awarded` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours Awarded');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|virtual_live|e_learning|blended|on_the_job|webinar');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'self_service|manager_assigned|hr_assigned|compliance_required|career_development_plan');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'mandatory|voluntary|recommended|assigned');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `manager_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Manager Approval Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `manager_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Manager Approval Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `mandatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_assessed|pending');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `score_achieved` SET TAGS ('dbx_business_glossary_term' = 'Score Achieved');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `workforce_performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Performance Review Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `quaternary_workforce_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `quaternary_workforce_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `quaternary_workforce_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `quinary_workforce_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `quinary_workforce_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `quinary_workforce_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `tertiary_workforce_final_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Final Approver Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `tertiary_workforce_final_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `tertiary_workforce_final_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `prior_period_workforce_performance_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `bonus_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|exempted');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|partially_meets|does_not_meet|not_applicable');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `competency_score` SET TAGS ('dbx_business_glossary_term' = 'Competency Score');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `employee_acknowledgement_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `employee_dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Dispute Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `employee_self_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `goal_achievement_rating` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `goal_achievement_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|partially_meets|does_not_meet|not_applicable');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `goal_achievement_score` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Score');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Comments');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `merit_increase_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `pip_indicator` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `pip_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `promotion_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `review_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Year');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`workforce_performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|project_based|promotion|pip_followup');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `performance_goal_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Goal Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Development Plan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `tertiary_performance_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `tertiary_performance_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `tertiary_performance_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `workforce_performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `parent_performance_goal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `achievement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Achievement Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `alignment_to_corporate_objective` SET TAGS ('dbx_business_glossary_term' = 'Alignment to Corporate Objective');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_requested');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `cascade_source` SET TAGS ('dbx_business_glossary_term' = 'Cascade Source');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `cascade_source` SET TAGS ('dbx_value_regex' = 'manager_assigned|employee_created|hr_initiated|system_generated');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Goal Comments');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_business_glossary_term' = 'Goal Category');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_value_regex' = 'financial|operational|development|compliance|strategic|customer');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `goal_description` SET TAGS ('dbx_business_glossary_term' = 'Goal Description');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `goal_number` SET TAGS ('dbx_business_glossary_term' = 'Goal Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `goal_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `goal_status` SET TAGS ('dbx_value_regex' = 'draft|active|in_progress|completed|cancelled|deferred');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `goal_title` SET TAGS ('dbx_business_glossary_term' = 'Goal Title');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `goal_type` SET TAGS ('dbx_business_glossary_term' = 'Goal Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `goal_type` SET TAGS ('dbx_value_regex' = 'individual|team|departmental|corporate');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Goal Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `is_stretch_goal` SET TAGS ('dbx_business_glossary_term' = 'Is Stretch Goal Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|partially_meets|does_not_meet|not_rated');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|continuous');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `target_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `life_insurance_ecm`.`workforce`.`performance_goal` ALTER COLUMN `weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Weight Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_substitute_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_substitute_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_substitute_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `extended_leave_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return to Work Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Approval Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `approved_end_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Cancellation Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Comments');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Denial Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_qualifying_reason` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Qualifying Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_qualifying_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `intermittent_leave_flag` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance After Request');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Before Request');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|cancelled|in-progress|closed');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `paid_leave_flag` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submission Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{8}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `total_days_approved` SET TAGS ('dbx_business_glossary_term' = 'Total Days Approved');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `total_days_requested` SET TAGS ('dbx_business_glossary_term' = 'Total Days Requested');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `total_hours_approved` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Approved');
ALTER TABLE `life_insurance_ecm`.`workforce`.`leave_request` ALTER COLUMN `total_hours_requested` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Requested');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `time_record_id` SET TAGS ('dbx_business_glossary_term' = 'Time Record Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `tertiary_time_adjusted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted By Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `tertiary_time_adjusted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `tertiary_time_adjusted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `work_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `corrected_time_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|submitted|draft');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration in Minutes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-In Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-Out Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `holiday_hours` SET TAGS ('dbx_business_glossary_term' = 'Holiday Hours');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `meal_break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Meal Break Duration in Minutes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `overtime_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `payroll_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Batch Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `pto_hours_used` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Hours Used');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `regular_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|split|on_call|weekend');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `sick_hours_used` SET TAGS ('dbx_business_glossary_term' = 'Sick Hours Used');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `time_entry_method` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Method');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `time_entry_method` SET TAGS ('dbx_value_regex' = 'biometric|badge_swipe|manual|mobile_app|web_portal|supervisor_entry');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`time_record` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'in_office|remote|hybrid|field|client_site');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `prior_period_headcount_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_headcount` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `attrition_assumption_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attrition Assumption Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `capacity_driver` SET TAGS ('dbx_business_glossary_term' = 'Capacity Driver');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `compensation_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Budget Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `compensation_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `critical_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Role Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `current_filled_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Filled Headcount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fte_budget` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Budget');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `open_headcount` SET TAGS ('dbx_business_glossary_term' = 'Open Headcount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|locked|rejected|superseded');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planned_backfills` SET TAGS ('dbx_business_glossary_term' = 'Planned Backfills');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planned_eliminations` SET TAGS ('dbx_business_glossary_term' = 'Planned Eliminations');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planned_new_hires` SET TAGS ('dbx_business_glossary_term' = 'Planned New Hires');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_month` SET TAGS ('dbx_business_glossary_term' = 'Planning Month');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|semi_annual');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_quarter` SET TAGS ('dbx_business_glossary_term' = 'Planning Quarter');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_year` SET TAGS ('dbx_business_glossary_term' = 'Planning Year');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `productivity_assumption` SET TAGS ('dbx_business_glossary_term' = 'Productivity Assumption');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `succession_plan_exists_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Exists Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `workload_volume_assumption` SET TAGS ('dbx_business_glossary_term' = 'Workload Volume Assumption');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_hiring_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_hiring_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_hiring_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_replacement_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_replacement_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_replacement_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `replacement_requisition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `actual_time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Time-to-Fill Days');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected|withdrawn');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|intern');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `fte_count` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Count');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `headcount_approved` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `is_critical_role` SET TAGS ('dbx_business_glossary_term' = 'Critical Role Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `minimum_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `posting_title` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Title');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `primary_work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Work Location Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requires_actuarial_credential` SET TAGS ('dbx_business_glossary_term' = 'Requires Actuarial Credential Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requires_finra_registration` SET TAGS ('dbx_business_glossary_term' = 'Requires Financial Industry Regulatory Authority (FINRA) Registration Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requires_insurance_license` SET TAGS ('dbx_business_glossary_term' = 'Requires Insurance License Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `sourcing_channels` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channels');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `time_to_fill_target_days` SET TAGS ('dbx_business_glossary_term' = 'Time-to-Fill Target Days');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`requisition` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'onsite|remote|hybrid');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_referral_source_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_referral_source_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_referral_source_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `referred_by_candidate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|clear|conditional|failed');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_status` SET TAGS ('dbx_business_glossary_term' = 'Candidate Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `current_employer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `degree_field` SET TAGS ('dbx_business_glossary_term' = 'Degree Field of Study');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'yes|no|decline_to_state');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `disability_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `drug_test_date` SET TAGS ('dbx_business_glossary_term' = 'Drug Test Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `drug_test_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Test Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `drug_test_status` SET TAGS ('dbx_value_regex' = 'not_required|scheduled|passed|failed|pending');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `eeoc_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity Commission (EEOC) Ethnicity');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `eeoc_ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `eeoc_gender` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity Commission (EEOC) Gender');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `eeoc_gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|decline_to_state');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `eeoc_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Candidate Email Address');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate First Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Last Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Middle Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Candidate Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_declined_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Declined Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_extended_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Candidate Phone Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `position_applied_for` SET TAGS ('dbx_business_glossary_term' = 'Position Applied For');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `professional_designations` SET TAGS ('dbx_business_glossary_term' = 'Professional Designations');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `resume_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Resume on File Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `salary_expectation_amount` SET TAGS ('dbx_business_glossary_term' = 'Salary Expectation Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `salary_expectation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `salary_expectation_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Expectation Currency Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `salary_expectation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `salary_expectation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `salary_expectation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Candidate Source Channel');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'job_board|referral|agency|direct|career_site|social_media');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `willing_to_relocate_flag` SET TAGS ('dbx_business_glossary_term' = 'Willing to Relocate Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|work_visa|requires_sponsorship');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`candidate` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Professional Experience');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interview_event_id` SET TAGS ('dbx_business_glossary_term' = 'Interview Event Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Interview Notes Document Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `document_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interview_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Interview Scorecard Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `primary_interviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Interviewer Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `primary_interviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `primary_interviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `rescheduled_from_interview_event_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled From Interview Event Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `follow_up_interview_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `behavioral_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Competency Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Interview Cancellation Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `communication_skills_rating` SET TAGS ('dbx_business_glossary_term' = 'Communication Skills Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `concerns_noted` SET TAGS ('dbx_business_glossary_term' = 'Candidate Concerns Noted');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `concerns_noted` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `cultural_fit_rating` SET TAGS ('dbx_business_glossary_term' = 'Cultural Fit Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Interview Disposition Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `diversity_panel_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversity Panel Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interview Duration in Minutes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `hire_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Hire Recommendation');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `hire_recommendation` SET TAGS ('dbx_value_regex' = 'strong_yes|yes|maybe|no|strong_no');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interview_format` SET TAGS ('dbx_business_glossary_term' = 'Interview Format');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interview_format` SET TAGS ('dbx_value_regex' = 'in_person|video|phone|asynchronous');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interview_location` SET TAGS ('dbx_business_glossary_term' = 'Interview Location');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interview_panel_employee_ids` SET TAGS ('dbx_business_glossary_term' = 'Interview Panel Employee Identifiers (IDs)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interview_round_number` SET TAGS ('dbx_business_glossary_term' = 'Interview Round Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interview_status` SET TAGS ('dbx_business_glossary_term' = 'Interview Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interview_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|cancelled|no_show|rescheduled');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interview_type` SET TAGS ('dbx_business_glossary_term' = 'Interview Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interview_type` SET TAGS ('dbx_value_regex' = 'phone_screen|technical|behavioral|panel|final|case_study');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interviewer_feedback_summary` SET TAGS ('dbx_business_glossary_term' = 'Interviewer Feedback Summary');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interviewer_feedback_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `interviewer_training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Interviewer Training Completed Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `next_step_action` SET TAGS ('dbx_business_glossary_term' = 'Next Step Action');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Interview Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `problem_solving_rating` SET TAGS ('dbx_business_glossary_term' = 'Problem Solving Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `rating_scale` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `recording_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Recording Consent Obtained Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `recording_url` SET TAGS ('dbx_business_glossary_term' = 'Interview Recording Uniform Resource Locator (URL)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `recording_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Interview Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `strengths_noted` SET TAGS ('dbx_business_glossary_term' = 'Candidate Strengths Noted');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `strengths_noted` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `structured_interview_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Structured Interview Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_event` ALTER COLUMN `technical_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Competency Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Letter Template Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Approved By Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `revised_offer_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Approval Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `contingent_offer_flag` SET TAGS ('dbx_business_glossary_term' = 'Contingent Offer Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `counter_offer_indicator` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `decline_date` SET TAGS ('dbx_business_glossary_term' = 'Decline Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_value_regex' = 'compensation|location|career_growth|benefits|accepted_other_offer|personal_reasons');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `decline_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `drug_screening_required` SET TAGS ('dbx_business_glossary_term' = 'Drug Screening Required Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|intern');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `equity_grant_eligible` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Expiration Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `letter_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Letter Sent Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `license_requirement_notes` SET TAGS ('dbx_business_glossary_term' = 'License Requirement Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Offer Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_number` SET TAGS ('dbx_business_glossary_term' = 'Offer Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|declined|rescinded|expired|withdrawn');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|semi_monthly|monthly');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `proposed_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `relocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Relocation Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `relocation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `relocation_assistance_offered` SET TAGS ('dbx_business_glossary_term' = 'Relocation Assistance Offered Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `sign_on_bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Sign-On Bonus Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `sign_on_bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Bonus Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`offer` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `quaternary_disciplinary_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `quaternary_disciplinary_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `quaternary_disciplinary_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `escalated_from_disciplinary_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'active|resolved|expunged|under_review|appealed|overturned');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|pending|withdrawn|not_applicable');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `documentation_location` SET TAGS ('dbx_business_glossary_term' = 'Documentation Location');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Action Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_method` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Method');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_method` SET TAGS ('dbx_value_regex' = 'signature|electronic_signature|verbal|refused|not_applicable');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_statement` SET TAGS ('dbx_business_glossary_term' = 'Employee Statement');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_statement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `expungement_date` SET TAGS ('dbx_business_glossary_term' = 'Expungement Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `expungement_reason` SET TAGS ('dbx_business_glossary_term' = 'Expungement Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `hr_case_number` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Case Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `improvement_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Improvement Deadline Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `issuing_department` SET TAGS ('dbx_business_glossary_term' = 'Issuing Department');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `license_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'License Impact Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Action Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `prior_warnings_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Warnings Count');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspension Paid Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Violation Category');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `violation_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `witness_employee_ids` SET TAGS ('dbx_business_glossary_term' = 'Witness Employee Identifiers (IDs)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `witness_employee_ids` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `succession_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_successor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Successor Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_successor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_successor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Target Position Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_succession_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_succession_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_succession_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_successor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Successor Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_successor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_successor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `superseded_succession_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `business_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `business_impact_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|highly_confidential');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `critical_competencies_required` SET TAGS ('dbx_business_glossary_term' = 'Critical Competencies Required');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `development_gap_assessment` SET TAGS ('dbx_business_glossary_term' = 'Development Gap Assessment');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `emergency_contact_plan_exists` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Plan Exists Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `key_person_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Person Risk Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `knowledge_transfer_plan_exists` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Transfer Plan Exists Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^SP-[0-9]{6}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Expiration Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_review_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|approved|suspended|closed');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'emergency|planned|development|retention');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_successor_readiness_rating` SET TAGS ('dbx_business_glossary_term' = 'Primary Successor Readiness Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_successor_readiness_rating` SET TAGS ('dbx_value_regex' = 'ready_now|ready_with_development|emerging_talent|not_ready');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `readiness_horizon` SET TAGS ('dbx_business_glossary_term' = 'Successor Readiness Horizon');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `readiness_horizon` SET TAGS ('dbx_value_regex' = 'ready_now|1_to_2_years|3_to_5_years|5_plus_years');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Retention Risk Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `secondary_successor_readiness_rating` SET TAGS ('dbx_business_glossary_term' = 'Secondary Successor Readiness Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `secondary_successor_readiness_rating` SET TAGS ('dbx_value_regex' = 'ready_now|ready_with_development|emerging_talent|not_ready');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_successor_readiness_rating` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Successor Readiness Rating');
ALTER TABLE `life_insurance_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_successor_readiness_rating` SET TAGS ('dbx_value_regex' = 'ready_now|ready_with_development|emerging_talent|not_ready');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` SET TAGS ('dbx_subdomain' = 'employee_administration');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `work_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `superseded_work_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `applicable_departments` SET TAGS ('dbx_business_glossary_term' = 'Applicable Departments');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `applicable_job_families` SET TAGS ('dbx_business_glossary_term' = 'Applicable Job Families');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `capacity_planning_factor` SET TAGS ('dbx_business_glossary_term' = 'Capacity Planning Factor');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `daily_hours` SET TAGS ('dbx_business_glossary_term' = 'Daily Hours');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `holiday_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Holiday Schedule Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `lunch_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Lunch Break Minutes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `overtime_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Threshold Hours');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `paid_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Paid Break Minutes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `pto_accrual_basis` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Accrual Basis');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `pto_accrual_basis` SET TAGS ('dbx_value_regex' = 'hours_worked|pay_period|annual');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `remote_work_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `remote_work_percentage` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Percentage');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `rotation_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Rotation Cycle Days');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'standard|flex|compressed|shift_based|part_time|on_call');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `shift_differential_eligible` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Eligible');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `time_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Time Tracking Required');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `weekend_work_required` SET TAGS ('dbx_business_glossary_term' = 'Weekend Work Required');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_schedule` ALTER COLUMN `work_days_pattern` SET TAGS ('dbx_business_glossary_term' = 'Work Days Pattern');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` SET TAGS ('dbx_subdomain' = 'learning_compliance');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `uw_authority_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting (UW) Authority Assignment Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `primary_uw_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `primary_uw_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `primary_uw_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `uw_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting (UW) Authority Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `uw_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `uw_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `superseded_uw_authority_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|revoked|pending_approval');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `authority_level` SET TAGS ('dbx_business_glossary_term' = 'Authority Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `authority_level` SET TAGS ('dbx_value_regex' = 'junior|senior|chief|senior_vice_president|executive');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `delegation_allowed` SET TAGS ('dbx_business_glossary_term' = 'Delegation Allowed');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `geographic_territory` SET TAGS ('dbx_business_glossary_term' = 'Geographic Territory');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `maximum_age_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Limit');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `maximum_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Face Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `minimum_age_limit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Limit');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `product_lines_authorized` SET TAGS ('dbx_business_glossary_term' = 'Product Lines Authorized');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `requires_medical_director_consult` SET TAGS ('dbx_business_glossary_term' = 'Requires Medical Director Consultation');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `requires_medical_director_consult` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `requires_medical_director_consult` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `requires_reinsurance_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Reinsurance Approval');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `risk_class_limit` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Limit');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `life_insurance_ecm`.`workforce`.`uw_authority_assignment` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` SET TAGS ('dbx_subdomain' = 'learning_compliance');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `background_check_id` SET TAGS ('dbx_business_glossary_term' = 'Background Check Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `tertiary_background_reviewed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `tertiary_background_reviewed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `tertiary_background_reviewed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `renewal_background_check_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `access_to_policyholder_data` SET TAGS ('dbx_business_glossary_term' = 'Access to Policyholder Data Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `adjudication_date` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `adjudication_notes` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `adjudication_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `adjudication_outcome` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Outcome');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `adjudication_outcome` SET TAGS ('dbx_value_regex' = 'approved|denied|conditional_approval|pending|not_applicable');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `adverse_action_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Action Notice Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `adverse_action_notice_issued` SET TAGS ('dbx_business_glossary_term' = 'Adverse Action Notice Issued Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'ordered|in_progress|completed|cancelled|expired');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Background Check Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `check_reason` SET TAGS ('dbx_business_glossary_term' = 'Background Check Reason');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `check_reason` SET TAGS ('dbx_value_regex' = 'pre_employment|periodic_review|promotion|role_change|regulatory_requirement|incident_triggered');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `check_type` SET TAGS ('dbx_business_glossary_term' = 'Background Check Type');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Consent Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Employee Consent Obtained Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Background Check Cost Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `credit_check_performed` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Performed Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `criminal_check_scope` SET TAGS ('dbx_business_glossary_term' = 'Criminal Background Check Scope');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `criminal_check_scope` SET TAGS ('dbx_value_regex' = 'county|state|federal|national|international');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `criminal_records_found` SET TAGS ('dbx_business_glossary_term' = 'Criminal Records Found Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `dispute_filed` SET TAGS ('dbx_business_glossary_term' = 'Employee Dispute Filed Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `education_verified` SET TAGS ('dbx_business_glossary_term' = 'Education Verified Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `employment_verified` SET TAGS ('dbx_business_glossary_term' = 'Employment History Verified Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Expiration Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `finra_brokercheck_performed` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) BrokerCheck Performed Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `oig_exclusion_check_performed` SET TAGS ('dbx_business_glossary_term' = 'Office of Inspector General (OIG) Exclusion List Check Performed Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `oig_exclusion_found` SET TAGS ('dbx_business_glossary_term' = 'Office of Inspector General (OIG) Exclusion Found Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Order Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `professional_license_verified` SET TAGS ('dbx_business_glossary_term' = 'Professional License Verified Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `requires_finra_registration` SET TAGS ('dbx_business_glossary_term' = 'Requires Financial Industry Regulatory Authority (FINRA) Registration Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `requires_insurance_license` SET TAGS ('dbx_business_glossary_term' = 'Requires Insurance License Indicator');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Background Check Result');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `result` SET TAGS ('dbx_value_regex' = 'clear|adverse|pending_review|incomplete|cancelled');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `screening_vendor` SET TAGS ('dbx_business_glossary_term' = 'Screening Vendor Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `vendor_report_url` SET TAGS ('dbx_business_glossary_term' = 'Vendor Report Uniform Resource Locator (URL)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`background_check` ALTER COLUMN `vendor_report_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` SET TAGS ('dbx_subdomain' = 'employee_administration');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `employee_skill_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Skill Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `superseded_employee_skill_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'self_assessed|manager_assessed|certification|examination|peer_review');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `ce_credits_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Credits Required');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `critical_skill_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Skill Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `endorsement_count` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Count');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `issuing_organization` SET TAGS ('dbx_business_glossary_term' = 'Issuing Organization');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `primary_skill_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Skill Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_value_regex' = 'beginner|intermediate|advanced|expert');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `skill_category` SET TAGS ('dbx_business_glossary_term' = 'Skill Category');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `skill_category` SET TAGS ('dbx_value_regex' = 'technical|actuarial|underwriting|claims|regulatory|leadership');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `skill_code` SET TAGS ('dbx_business_glossary_term' = 'Skill Code');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `skill_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `skill_gap_flag` SET TAGS ('dbx_business_glossary_term' = 'Skill Gap Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `skill_name` SET TAGS ('dbx_business_glossary_term' = 'Skill Name');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `skill_status` SET TAGS ('dbx_business_glossary_term' = 'Skill Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `skill_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending_validation');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `skill_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Skill Subcategory');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `target_proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Target Proficiency Level');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `target_proficiency_level` SET TAGS ('dbx_value_regex' = 'beginner|intermediate|advanced|expert');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `training_source` SET TAGS ('dbx_business_glossary_term' = 'Training Source');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `transferable_skill_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferable Skill Flag');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|unverified|disputed');
ALTER TABLE `life_insurance_ecm`.`workforce`.`employee_skill` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` SET TAGS ('dbx_subdomain' = 'employee_administration');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `parent_work_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`work_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_scorecard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_scorecard` SET TAGS ('dbx_subdomain' = 'talent_management');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_scorecard` ALTER COLUMN `interview_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Interview Scorecard Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_scorecard` ALTER COLUMN `revised_interview_scorecard_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`interview_scorecard` ALTER COLUMN `candidate_salary_expectation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_period` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_period` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_period` ALTER COLUMN `prior_payroll_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_session` SET TAGS ('dbx_subdomain' = 'learning_compliance');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_session` ALTER COLUMN `training_session_id` SET TAGS ('dbx_business_glossary_term' = 'Training Session Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_session` ALTER COLUMN `rescheduled_training_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_session` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`training_session` ALTER COLUMN `meeting_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`team` SET TAGS ('dbx_subdomain' = 'employee_administration');
ALTER TABLE `life_insurance_ecm`.`workforce`.`team` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`team` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` SET TAGS ('dbx_subdomain' = 'employee_administration');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`region` ALTER COLUMN `office_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_calendar` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_calendar` ALTER COLUMN `payroll_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Calendar Identifier');
ALTER TABLE `life_insurance_ecm`.`workforce`.`payroll_calendar` ALTER COLUMN `prior_payroll_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
