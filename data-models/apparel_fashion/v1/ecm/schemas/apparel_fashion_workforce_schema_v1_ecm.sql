-- Schema for Domain: workforce | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:39

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`workforce` COMMENT 'Manages employee master data, organizational hierarchy, payroll, benefits, talent acquisition, performance management, and labor compliance across retail associates, corporate staff, and distribution center teams. Supports seasonal workforce planning and store staffing models via Workday HCM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key. System-generated surrogate key for all workforce identity data across retail stores, corporate offices, and distribution centers.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Employees are hired into standardized job profiles. Employee currently has denormalized job_code, job_family, job_level attributes. Adding job_profile_id FK normalizes this relationship and allows acc',
    `manager_employee_id` BIGINT COMMENT 'Employee ID of the direct manager or supervisor. Establishes organizational reporting hierarchy.',
    `cost_center` STRING COMMENT 'Financial cost center code for labor expense allocation. Links employee payroll costs to General Ledger (GL) accounts.. Valid values are `^[0-9]{4,8}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in the system. Used for audit trail and data lineage.',
    `date_of_birth` DATE COMMENT 'Date of birth of the employee. Used for age verification, benefits eligibility, and compliance reporting.',
    `department` STRING COMMENT 'Organizational department or functional area to which the employee is assigned (e.g., Merchandising, Store Operations, Finance, IT).',
    `eeo_classification` STRING COMMENT 'EEO-1 job category classification for regulatory reporting (e.g., Executive/Senior Officials, Professionals, Sales Workers, Service Workers). Used for diversity and compliance reporting.',
    `email_address` STRING COMMENT 'Primary corporate email address for the employee. Used for internal communications and system access.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee record. Active employees are on payroll and eligible for work assignments.. Valid values are `active|on-leave|suspended|terminated`',
    `employment_type` STRING COMMENT 'Classification of employment arrangement. Determines benefits eligibility, scheduling rules, and labor compliance requirements.. Valid values are `full-time|part-time|seasonal|contractor|temporary|intern`',
    `first_name` STRING COMMENT 'Legal first name of the employee as recorded in HR system.',
    `flsa_status` STRING COMMENT 'Classification under FLSA determining overtime eligibility. Exempt employees are salaried and not eligible for overtime; non-exempt employees are eligible for overtime pay.. Valid values are `exempt|non-exempt`',
    `hire_date` DATE COMMENT 'Date the employee was originally hired or rehired. Used for tenure calculations, benefits eligibility, and anniversary tracking.',
    `job_title` STRING COMMENT 'Official job title or position name assigned to the employee. Used for organizational reporting and role-based access control.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the employee as recorded in HR system.',
    `middle_name` STRING COMMENT 'Middle name or initial of the employee. Nullable.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was last updated. Used for change tracking and audit trail.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number in USA, National Insurance Number in UK). Used for tax reporting and payroll.',
    `pay_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for employee compensation (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `pay_grade` STRING COMMENT 'Compensation band or grade level. Defines salary range and progression path for the role.. Valid values are `^[A-Z0-9]{2,6}$`',
    `pay_rate` DECIMAL(18,2) COMMENT 'Current base pay rate for the employee. Represents hourly rate for hourly employees or annual salary for salaried employees. Currency determined by work location.',
    `pay_type` STRING COMMENT 'Compensation structure for the employee. Determines payroll calculation method and time tracking requirements.. Valid values are `hourly|salaried|commission|contract`',
    `performance_rating` STRING COMMENT 'Most recent annual performance review rating. Used for talent management, succession planning, and compensation decisions.',
    `performance_review_date` DATE COMMENT 'Date of the most recent formal performance review. Used for tracking review cycles and next review scheduling.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee. May be mobile or landline.',
    `preferred_name` STRING COMMENT 'Preferred or chosen name used by the employee in workplace communications. May differ from legal name.',
    `rehire_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire based on termination circumstances and performance history.',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Nullable for active employees. Used for offboarding, final payroll, and compliance reporting.',
    `termination_reason` STRING COMMENT 'Classification of the reason for employment termination. Used for turnover analysis and compliance reporting. Nullable for active employees.. Valid values are `voluntary|involuntary|retirement|end-of-contract|layoff`',
    `union_code` STRING COMMENT 'Identifier for the labor union to which the employee belongs. Nullable for non-union employees.. Valid values are `^[A-Z0-9]{2,8}$`',
    `union_member_flag` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union. Determines applicable collective bargaining agreements and labor rules.',
    `work_authorization_expiry_date` DATE COMMENT 'Expiration date of work authorization (e.g., visa expiry). Nullable for citizens and permanent residents. Used for compliance monitoring and renewal alerts.',
    `work_authorization_status` STRING COMMENT 'Legal authorization status for the employee to work in the jurisdiction. Used for I-9 compliance and visa tracking.. Valid values are `citizen|permanent-resident|work-visa|pending|expired`',
    `work_location_code` STRING COMMENT 'Unique identifier for the employees primary work location (store number, office code, or distribution center ID).. Valid values are `^[A-Z0-9]{4,10}$`',
    `work_location_type` STRING COMMENT 'Category of primary work location. Determines applicable labor policies, scheduling systems, and operational workflows.. Valid values are `retail-store|corporate-office|distribution-center|remote|field`',
    `workday_employee_code` STRING COMMENT 'External employee identifier from Workday HCM system. Business key for integration with source HR system.. Valid values are `^[A-Z0-9]{6,12}$`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for all employees across retail stores, corporate offices, and distribution centers. Captures personal details, employment type (full-time, part-time, seasonal, contractor), job classification, hire date, termination date, employment status, work authorization, EEO classification, and Workday HCM employee ID. SSOT for all workforce identity data in the apparel-fashion enterprise.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the authorized headcount position within the organization. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Positions are budgeted against cost centers for headcount planning and salary budgeting. Apparel companies track position costs (approved headcount budget) by cost center for OTB headcount management ',
    `department_id` BIGINT COMMENT 'Reference to the department or cost center to which this position is assigned for budgeting and organizational reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the employee currently occupying this position. Null if the position is vacant.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Positions are defined by job profiles. Position currently has denormalized job_family, job_level, flsa_classification attributes. Adding job_profile_id FK normalizes this relationship and ensures posi',
    `org_unit_id` BIGINT COMMENT 'Reference to the physical work location (store, distribution center, corporate office) where this position is based.',
    `supervisor_position_id` BIGINT COMMENT 'Reference to the position that this position reports to in the organizational hierarchy. Null for top-level executive positions.',
    `talent_requisition_id` BIGINT COMMENT 'Reference to the active job requisition for this position if it is currently vacant and approved for hiring. Null if position is filled or not approved for recruitment.',
    `annual_salary_max` DECIMAL(18,2) COMMENT 'Maximum annual salary for the position based on the assigned pay grade. Used for compensation planning and budgeting.',
    `annual_salary_min` DECIMAL(18,2) COMMENT 'Minimum annual salary for the position based on the assigned pay grade. Used for compensation planning and budgeting.',
    `budget_year` STRING COMMENT 'Fiscal year for which this position is budgeted and approved as part of the Open-to-Buy (OTB) headcount planning process.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for salary and compensation amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this position was eliminated or is scheduled to be eliminated. Null for active positions with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this position was created or became effective in the organizational structure.',
    `eligible_for_bonus` BOOLEAN COMMENT 'Indicates whether the position is eligible for annual performance bonuses or incentive compensation. True if eligible; False otherwise.',
    `eligible_for_commission` BOOLEAN COMMENT 'Indicates whether the position is eligible for sales commission or variable pay based on performance metrics. True if eligible; False otherwise.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation for the position. 1.0000 represents a full-time position; values less than 1.0 represent part-time positions (e.g., 0.5000 for half-time).',
    `is_critical_position` BOOLEAN COMMENT 'Indicates whether this position is designated as business-critical, requiring priority succession planning and talent development. True for critical positions; False otherwise.',
    `is_filled` BOOLEAN COMMENT 'Indicates whether the position is currently occupied by an employee. True if filled; False if vacant.',
    `is_seasonal` BOOLEAN COMMENT 'Indicates whether this is a seasonal position typically filled during peak retail periods (e.g., holiday season, back-to-school). True for seasonal positions; False for year-round positions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was last updated in the system.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for the position as defined in the job profile.. Valid values are `High School|Associate Degree|Bachelor Degree|Master Degree|Doctoral Degree|Professional Certification`',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant work experience required for the position.',
    `pay_grade` STRING COMMENT 'Compensation band assigned to the position, defining the salary range and eligibility for incentive programs.. Valid values are `^[A-Z]{1,2}[0-9]{1,2}$`',
    `position_code` STRING COMMENT 'Business-assigned unique code for the position, used for external reporting and integration with payroll and HR systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_description` STRING COMMENT 'Detailed description of the position responsibilities, key accountabilities, and scope of work. Used for job postings and performance management.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position. Active positions are available for hiring; Frozen positions are temporarily on hold; Eliminated positions have been removed from the headcount plan; Pending Approval positions are awaiting budget authorization.. Valid values are `Active|Frozen|Eliminated|Pending Approval`',
    `position_type` STRING COMMENT 'Employment type classification for the position. Regular positions are permanent; Temporary positions have a defined end date; Contract positions are filled by external contractors; Intern positions are for student or graduate programs.. Valid values are `Regular|Temporary|Contract|Intern`',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for remote or hybrid work arrangements. True if remote work is permitted; False if the position requires on-site presence.',
    `seasonal_end_date` DATE COMMENT 'End date for seasonal positions, indicating when the position is typically eliminated each year. Null for non-seasonal positions.',
    `seasonal_start_date` DATE COMMENT 'Start date for seasonal positions, indicating when the position becomes active each year. Null for non-seasonal positions.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Expected number of working hours per week for the position. Typically 40.00 for full-time positions; varies for part-time positions based on FTE allocation.',
    `title` STRING COMMENT 'Official job title for the position as it appears in organizational charts and job postings.',
    `travel_requirement_pct` DECIMAL(18,2) COMMENT 'Expected percentage of time the position requires business travel. 0.00 for no travel; values up to 100.00 for positions requiring extensive travel.',
    `union_code` STRING COMMENT 'Code identifying the labor union representing this position, if applicable. Null for non-unionized positions.',
    `work_shift` STRING COMMENT 'Primary work shift assigned to the position, relevant for retail store associates and distribution center teams.. Valid values are `Day|Evening|Night|Rotating|Flexible`',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Defines authorized headcount positions within the organization, including job title, job family, job level, FLSA classification (exempt/non-exempt), pay grade, department, location, FTE allocation, and whether the position is filled or vacant. Supports open-to-buy headcount planning and seasonal staffing models for retail and DC teams.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Org units must link to legal entities for organizational hierarchy aligned to company structure and entity-level reporting. Apparel companies with multiple brands/regions require org_unit→company_code',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Org units must link to finance cost centers for labor cost allocation, departmental budgeting, and P&L reporting. Apparel retailers track store/DC labor costs via org_unit→cost_center. Replaces denorm',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the responsible manager or supervisor for this organizational unit.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy. Enables hierarchical roll-up for workforce reporting and labor cost allocation.',
    `retail_store_id` BIGINT COMMENT 'Reference to the physical location or facility where this organizational unit operates.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocation for this organizational unit in local currency. Used for labor cost planning and variance analysis.',
    `business_unit_code` STRING COMMENT 'Strategic business unit code for executive reporting and performance management. Aligns with KPI dashboards.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for budget and financial reporting (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `division_code` STRING COMMENT 'Business division code for divisional reporting and strategic planning (e.g., RETAIL, WHOLESALE, ECOMM).. Valid values are `^[A-Z0-9]{2,10}$`',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit becomes inactive or is closed. Null for currently active units. Supports historical reporting.',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit becomes active and available for workforce assignment. Supports temporal hierarchy management.',
    `gl_segment` STRING COMMENT 'General ledger segment code for financial reporting and consolidation. Used for EBITDA and P&L roll-up.. Valid values are `^[0-9]{4,10}$`',
    `headcount_capacity` STRING COMMENT 'Maximum planned headcount capacity for this organizational unit. Used for workforce planning and seasonal staffing models.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the organizational hierarchy (e.g., 1=corporate, 2=division, 3=region, 4=store). Enables hierarchical roll-up queries.',
    `hierarchy_path` STRING COMMENT 'Full hierarchical path from root to this unit (e.g., /CORP/RETAIL/NORAM/STORE001). Supports recursive queries and reporting.',
    `is_seasonal` BOOLEAN COMMENT 'Indicates whether this organizational unit operates on a seasonal basis (e.g., pop-up stores, seasonal distribution centers). Supports seasonal workforce planning.',
    `labor_union_code` STRING COMMENT 'Labor union or collective bargaining agreement code applicable to this organizational unit. Supports labor compliance and FLA reporting.. Valid values are `^[A-Z0-9]{2,15}$`',
    `modified_by` STRING COMMENT 'User identifier who last modified this organizational unit record. Supports change management and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified. Supports change tracking and audit compliance.',
    `org_unit_description` STRING COMMENT 'Detailed business description of the organizational units purpose, scope, and operational responsibilities.',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. Indicates operational state and availability for workforce assignment.. Valid values are `active|inactive|pending|closed|suspended|planned`',
    `profit_center_code` STRING COMMENT 'Profit center code for P&L reporting and profitability analysis. Used for GMROI and financial performance tracking.. Valid values are `^[A-Z0-9]{4,12}$`',
    `region_code` STRING COMMENT 'Geographic region code for regional reporting and workforce planning (e.g., NORAM, EMEA, APAC).. Valid values are `^[A-Z]{2,10}$`',
    `sla_compliance_required` BOOLEAN COMMENT 'Indicates whether this organizational unit is subject to SLA compliance requirements for operational performance tracking.',
    `store_cluster_code` STRING COMMENT 'Store cluster or group code for merchandising and allocation planning. Used for assortment planning and inventory allocation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for this organizational unit (e.g., America/New_York, Europe/London). Used for shift scheduling and payroll processing.. Valid values are `^[A-Za-z/_]+$`',
    `unit_code` STRING COMMENT 'Business identifier code for the organizational unit. Used for external reporting and system integration.. Valid values are `^[A-Z0-9]{3,20}$`',
    `unit_name` STRING COMMENT 'Full business name of the organizational unit (e.g., North America Retail Operations, Distribution Center East, Corporate Marketing).',
    `unit_type` STRING COMMENT 'Classification of the organizational unit type. Determines reporting structure and operational characteristics. [ENUM-REF-CANDIDATE: store|distribution_center|corporate|regional|division|department|cost_center|business_unit — 8 candidates stripped; promote to reference product]',
    `created_by` STRING COMMENT 'User identifier who created this organizational unit record. Supports audit trail and GDPR compliance.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational hierarchy node representing departments, cost centers, divisions, regions, and store clusters within the apparel-fashion enterprise. Captures unit name, unit type (store, DC, corporate, regional), parent unit, cost center code, GL segment, effective dates, and responsible manager. Enables hierarchical roll-up for workforce reporting and labor cost allocation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile. Primary key. Serves as the template identifier for position creation and talent acquisition in Workday HCM.',
    `approved_by` STRING COMMENT 'Name or identifier of the HR business partner or executive who approved this job profile for use. Required for governance and compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile was formally approved for use in position creation and talent acquisition.',
    `bonus_eligible_flag` BOOLEAN COMMENT 'Indicates whether positions in this job profile are eligible for performance-based bonus compensation.',
    `career_path_progression` STRING COMMENT 'Typical next-level job profiles in the career progression path. Used for succession planning and employee development.',
    `certifications_required` STRING COMMENT 'Professional certifications or licenses required or preferred for this job profile. Examples include CPA, PHR, PMP, or industry-specific certifications.',
    `commission_eligible_flag` BOOLEAN COMMENT 'Indicates whether positions in this job profile are eligible for commission-based compensation, common in retail and wholesale sales roles.',
    `competency_requirements` STRING COMMENT 'Detailed list of competencies required for this job profile including behavioral, technical, and leadership competencies. Used for talent assessment and development planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was first created in the system. Used for audit trail and data lineage.',
    `critical_role_flag` BOOLEAN COMMENT 'Indicates whether this job profile is designated as business-critical requiring succession planning and talent pipeline development.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the pay range amounts. Supports multi-country operations.. Valid values are `^[A-Z]{3}$`',
    `education_level_required` STRING COMMENT 'Minimum education level required for this job profile. Used for candidate screening and talent acquisition. [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctorate|professional_certification|none — 7 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this job profile is no longer active for new position creation. Null for open-ended profiles. Supports job profile retirement.',
    `effective_start_date` DATE COMMENT 'Date when this job profile becomes active and available for position creation and hiring. Supports temporal validity.',
    `employment_type` STRING COMMENT 'Standard employment type associated with this job profile indicating work schedule and duration expectations.. Valid values are `full_time|part_time|seasonal|temporary|contract|intern`',
    `flsa_classification` STRING COMMENT 'Classification under the Fair Labor Standards Act determining overtime eligibility. Exempt employees are not eligible for overtime pay; non-exempt employees are eligible.. Valid values are `exempt|non_exempt`',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles together for career pathing and compensation planning in apparel fashion business. [ENUM-REF-CANDIDATE: retail_operations|merchandising|design|supply_chain|corporate|distribution|e_commerce|marketing|finance|human_resources|information_technology|legal|customer_service — 13 candidates stripped; promote to reference product]',
    `job_level` STRING COMMENT 'Hierarchical level of the job profile within the organization indicating seniority and scope of responsibility. [ENUM-REF-CANDIDATE: entry|intermediate|senior|lead|manager|senior_manager|director|senior_director|vice_president|senior_vice_president|executive — 11 candidates stripped; promote to reference product]',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of the job profile indicating whether it is available for position creation and hiring.. Valid values are `active|inactive|draft|under_review|archived`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was last updated. Used for change tracking and audit compliance.',
    `management_level` STRING COMMENT 'Indicates whether this job profile includes people management responsibilities and at what level.. Valid values are `individual_contributor|people_manager|manager_of_managers|executive`',
    `pay_frequency` STRING COMMENT 'Standard pay frequency for positions created from this job profile indicating how often compensation is disbursed.. Valid values are `hourly|weekly|biweekly|semimonthly|monthly|annual`',
    `pay_grade` STRING COMMENT 'Compensation grade level defining the pay range band for this job profile. Used for salary planning and equity analysis.. Valid values are `^[A-Z]{1,2}[0-9]{1,2}$`',
    `pay_range_maximum` DECIMAL(18,2) COMMENT 'Maximum annual salary or hourly wage for this job profile in the base currency. Represents the ceiling for this role.',
    `pay_range_midpoint` DECIMAL(18,2) COMMENT 'Midpoint annual salary or hourly wage for this job profile representing the target compensation for fully competent performance.',
    `pay_range_minimum` DECIMAL(18,2) COMMENT 'Minimum annual salary or hourly wage for this job profile in the base currency. Used for compensation planning and offer generation.',
    `physical_requirements` STRING COMMENT 'Physical demands and requirements of the job including lifting, standing, mobility, and environmental conditions. Required for ADA compliance and workplace safety.',
    `profile_code` STRING COMMENT 'Business identifier code for the job profile used across HR systems and organizational documentation. Externally-known unique code.. Valid values are `^[A-Z0-9]{6,12}$`',
    `profile_description` STRING COMMENT 'Comprehensive description of the job profile including purpose, scope, and key responsibilities.',
    `profile_name` STRING COMMENT 'Official name of the job profile as it appears in organizational documentation and job postings.',
    `seasonal_role_flag` BOOLEAN COMMENT 'Indicates whether this job profile is used for seasonal workforce planning, common in retail store operations during peak periods.',
    `skill_requirements` STRING COMMENT 'Specific skills required for successful performance in this job profile including technical skills, software proficiency, and domain expertise.',
    `span_of_control_max` STRING COMMENT 'Maximum number of direct reports typically managed by positions in this job profile. Used for organizational planning.',
    `span_of_control_min` STRING COMMENT 'Minimum number of direct reports typically managed by positions in this job profile. Null for individual contributor roles.',
    `stock_eligible_flag` BOOLEAN COMMENT 'Indicates whether positions in this job profile are eligible for equity compensation such as stock options or restricted stock units.',
    `supervisory_organization` STRING COMMENT 'Default supervisory organization or department where positions from this job profile typically reside in the organizational hierarchy.',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of time spent traveling for business purposes. Used for candidate expectations and expense planning.',
    `union_eligible_flag` BOOLEAN COMMENT 'Indicates whether positions created from this job profile are eligible for union membership or collective bargaining representation.',
    `version_number` STRING COMMENT 'Version number of this job profile record. Incremented with each significant update to track profile evolution over time.',
    `work_location_type` STRING COMMENT 'Standard work location arrangement for this job profile indicating whether the role is performed on-site, remotely, or in a hybrid model.. Valid values are `on_site|remote|hybrid`',
    `years_experience_required` STRING COMMENT 'Minimum number of years of relevant work experience required for this job profile. Used for candidate qualification.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Reference catalog of standardized job profiles defining competency requirements, skill requirements, certifications required, pay range bands, job family, job level, and FLSA classification. Used as the template for position creation and talent acquisition in Workday HCM. Distinct from position (which is a headcount slot) and employee (who fills it).';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` (
    `staffing_model_id` BIGINT COMMENT 'Unique identifier for the staffing model record. Primary key for workforce planning and headcount budgeting scenarios.',
    `budget_period_id` BIGINT COMMENT 'Reference to the financial planning period (fiscal year, quarter, month) for which this staffing model is defined.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Staffing models with labor_budget_amount must reconcile to finance cost center budgets for headcount vs. financial budget alignment. Critical for apparel seasonal hiring planning and OTB labor budget ',
    `job_family_id` BIGINT COMMENT 'Reference to the job family classification (retail associate, warehouse operator, merchandiser, designer, etc.) covered by this staffing model.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (store, distribution center, corporate department) for which this staffing model applies.',
    `role_id` BIGINT COMMENT 'Reference to the specific role or position within the job family for which headcount is planned.',
    `season_id` BIGINT COMMENT 'Reference to the merchandising season (Spring/Summer, Fall/Winter, Holiday) driving seasonal workforce adjustments.',
    `actual_headcount` DECIMAL(18,2) COMMENT 'Current or realized number of employees or FTE in this role and organizational unit, used for variance analysis against target.',
    `approval_date` DATE COMMENT 'Date when the staffing model was formally approved by the approving authority.',
    `approval_status` STRING COMMENT 'Current approval workflow state of the staffing model: draft (in development), submitted (pending review), approved (authorized for execution), rejected (not approved), revised (changes requested), active (currently in effect), archived (historical record). [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|revised|active|archived — 7 candidates stripped; promote to reference product]',
    `approving_authority` STRING COMMENT 'Name or identifier of the executive, manager, or committee who approved this staffing model (e.g., VP Retail Operations, CFO, Workforce Planning Committee).',
    `coverage_ratio` DECIMAL(18,2) COMMENT 'Ratio of planned staff to workload drivers (e.g., employees per 1000 square feet of retail space, warehouse staff per 10,000 units shipped), supporting capacity-based staffing models.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this staffing model record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this staffing model expires or is superseded by a new model. Null for open-ended models.',
    `effective_start_date` DATE COMMENT 'Date when this staffing model becomes active and begins driving headcount management decisions.',
    `headcount_variance` DECIMAL(18,2) COMMENT 'Difference between actual and target headcount (actual minus target), indicating over-staffing (positive) or under-staffing (negative).',
    `labor_budget_amount` DECIMAL(18,2) COMMENT 'Total financial budget allocated for labor costs (wages, benefits, payroll taxes) for this staffing model scenario, supporting financial workforce plan integration.',
    `labor_budget_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the labor budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `last_modified_by` STRING COMMENT 'User ID or name of the workforce planner who most recently updated this staffing model record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this staffing model record was most recently updated.',
    `location_type` STRING COMMENT 'Type of business location for which this staffing model applies, supporting location-specific workforce planning strategies. [ENUM-REF-CANDIDATE: retail_store|distribution_center|corporate_office|design_studio|warehouse|call_center|regional_office — 7 candidates stripped; promote to reference product]',
    `model_name` STRING COMMENT 'Business-friendly name for the staffing model scenario (e.g., FY2024 Holiday Retail Ramp, Q2 DC Expansion Plan).',
    `model_type` STRING COMMENT 'Classification of the staffing model scenario: baseline (steady-state), seasonal (recurring pattern), expansion (growth initiative), reduction (cost optimization), peak_period (holiday/back-to-school surge), special_event (store opening, promotional event).. Valid values are `baseline|seasonal|expansion|reduction|peak_period|special_event`',
    `model_version` STRING COMMENT 'Version number of this staffing model, incremented when revisions are made. Supports change tracking and audit trail.',
    `notes` STRING COMMENT 'Free-text notes capturing assumptions, constraints, special considerations, or business context for this staffing model (e.g., Assumes 15% attrition during peak, Contingent on new store opening approval).',
    `otb_headcount_budget` DECIMAL(18,2) COMMENT 'Remaining authorized headcount capacity available for hiring within this model, analogous to Open-to-Buy inventory budget. Calculated as target_headcount minus committed hires.',
    `peak_end_date` DATE COMMENT 'Date when peak period concludes and staffing wind-down begins (e.g., end of holiday returns period).',
    `peak_period_multiplier` DECIMAL(18,2) COMMENT 'Additional multiplier for short-duration peak periods (Black Friday, Cyber Monday, back-to-school week) requiring temporary surge staffing beyond seasonal baseline.',
    `peak_start_date` DATE COMMENT 'Date when peak staffing levels must be achieved (e.g., first day of holiday shopping season).',
    `planning_scenario` STRING COMMENT 'Name of the broader workforce planning scenario or initiative this model supports (e.g., FY2024 Store Expansion, Omnichannel Transformation, Cost Optimization Initiative).',
    `ramp_end_date` DATE COMMENT 'Date when staffing returns to baseline levels after seasonal wind-down is complete.',
    `ramp_start_date` DATE COMMENT 'Date when seasonal or peak-period staffing ramp-up begins (e.g., pre-holiday hiring start date).',
    `seasonal_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to baseline headcount to account for seasonal demand fluctuations (e.g., 1.25 for 25% increase during holiday season, 0.85 for 15% reduction post-season).',
    `target_headcount` DECIMAL(18,2) COMMENT 'Planned number of employees or Full-Time Equivalents (FTE) for this role and organizational unit during the budget period.',
    `target_hours_per_week` DECIMAL(18,2) COMMENT 'Planned average weekly hours per employee for this role, supporting part-time, full-time, and variable-hour workforce planning.',
    `workforce_segment` STRING COMMENT 'Employment classification for the workforce covered by this model: full_time (permanent FT), part_time (permanent PT), seasonal (recurring temporary), temporary (non-recurring), contractor (external), intern (student/trainee).. Valid values are `full_time|part_time|seasonal|temporary|contractor|intern`',
    `created_by` STRING COMMENT 'User ID or name of the workforce planner who created this staffing model record.',
    CONSTRAINT pk_staffing_model PRIMARY KEY(`staffing_model_id`)
) COMMENT 'SSOT for workforce planning, headcount budgeting, and labor modeling across stores, DCs, and corporate functions. Captures target headcount by role, job family, and org unit; hours-per-week targets; seasonal adjustment factors and peak period multipliers (holiday, back-to-school, end-of-season); coverage ratios; planned vs actual FTE count; headcount variance; budget period; seasonal ramp schedule (pre-holiday ramp, holiday peak, post-holiday wind-down); approval status and approving authority; and financial workforce plan integration points (Anaplan). Drives OTB headcount management, open-to-buy labor budget alignment, seasonal workforce ramp planning for retail associates and DC temporary staff, and variance reporting against approved headcount budgets.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` (
    `shift_assignment_id` BIGINT COMMENT 'Unique identifier for the shift assignment record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Retail shift labor costs must post to store/department cost centers for daily labor cost tracking and store P&L. Critical for apparel retail labor management and cost control. Replaces denormalized co',
    `department_id` BIGINT COMMENT 'Identifier of the department or functional area within the location where the employee is assigned for this shift.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or administrator who last modified this shift assignment record. Used for audit and accountability.',
    `primary_shift_employee_id` BIGINT COMMENT 'Identifier of the employee assigned to this shift. Links to employee master data in Workday HCM.',
    `retail_store_id` BIGINT COMMENT 'Identifier of the physical location where the shift takes place (store, distribution center, corporate office).',
    `role_id` BIGINT COMMENT 'Identifier of the job role or position the employee is performing during this shift (e.g., sales associate, cashier, warehouse picker).',
    `shift_swap_request_id` BIGINT COMMENT 'Identifier of the shift swap or trade request if this shift was reassigned through an employee-initiated swap process. Used for tracking shift flexibility programs.',
    `absence_reason_code` STRING COMMENT 'Standardized code indicating the reason for absence if the employee did not work the scheduled shift (sick leave, vacation, personal leave, bereavement, jury duty, unpaid leave, other). [ENUM-REF-CANDIDATE: sick|vacation|personal|bereavement|jury_duty|unpaid|other — 7 candidates stripped; promote to reference product]',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the employee clocked out or completed the shift. Captured from Point of Sale (POS) or time and attendance systems.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours the employee actually worked during this shift, calculated from actual clock-in and clock-out times. Used for payroll processing.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the employee clocked in or began the shift. Captured from Point of Sale (POS) or time and attendance systems.',
    `attendance_status` STRING COMMENT 'Attendance outcome for this shift indicating whether the employee was present, absent, late, left early, or was a no-call no-show. Used for attendance tracking and performance management.. Valid values are `present|absent|late|early_departure|no_call_no_show|excused`',
    `break_duration_minutes` STRING COMMENT 'Total duration of unpaid breaks taken during the shift, measured in minutes. Used to calculate net working hours for payroll.',
    `compliance_violation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this shift assignment resulted in a labor compliance violation (e.g., insufficient rest period, excessive hours, minor labor law breach). Used for compliance monitoring.',
    `compliance_violation_type` STRING COMMENT 'Type of labor compliance violation associated with this shift, if any (insufficient rest period, maximum hours exceeded, minor labor law violation, predictive scheduling violation, other).. Valid values are `rest_period|max_hours|minor_labor|predictive_scheduling|other`',
    `early_departure_minutes` STRING COMMENT 'Number of minutes the employee left before the scheduled shift end time. Used for attendance policy enforcement.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the location where the employee clocked in, if mobile time tracking is enabled. Used for location verification and compliance.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the location where the employee clocked in, if mobile time tracking is enabled. Used for location verification and compliance.',
    `is_holiday_shift` BOOLEAN COMMENT 'Boolean flag indicating whether this shift falls on a recognized company holiday, which may trigger premium pay rates.',
    `is_overtime_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the employee is eligible for overtime pay during this shift based on employment classification (non-exempt vs exempt).',
    `is_seasonal_worker` BOOLEAN COMMENT 'Boolean flag indicating whether the employee assigned to this shift is classified as a seasonal or temporary worker. Used for workforce planning and compliance reporting.',
    `labor_standard_hours` DECIMAL(18,2) COMMENT 'Standard or expected hours for this type of shift based on labor planning models. Used for productivity analysis and variance reporting.',
    `last_modified_datetime` TIMESTAMP COMMENT 'Date and time when this shift assignment record was last updated. Used for audit trail and change tracking.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked during this shift, typically hours exceeding standard daily or weekly thresholds. Subject to premium pay rates.',
    `pay_code` STRING COMMENT 'Pay classification code for this shift indicating the type of compensation (regular, overtime, holiday pay, sick pay, vacation pay, double-time, premium pay). Used for payroll processing. [ENUM-REF-CANDIDATE: regular|overtime|holiday|sick_pay|vacation_pay|double_time|premium — 7 candidates stripped; promote to reference product]',
    `schedule_created_datetime` TIMESTAMP COMMENT 'Date and time when this shift assignment was originally created in the scheduling system. Used for audit and compliance tracking.',
    `schedule_published_datetime` TIMESTAMP COMMENT 'Date and time when this shift assignment was published and communicated to the employee. Used for compliance with predictive scheduling laws.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time when the employee is scheduled to complete the shift. Used for labor planning and scheduling compliance.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Total number of hours the employee was scheduled to work during this shift, calculated from scheduled start and end times.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time when the employee is scheduled to begin the shift. Used for labor planning and scheduling compliance.',
    `shift_notes` STRING COMMENT 'Free-text notes or comments about the shift, such as special instructions, incidents, or performance observations. Used for operational communication.',
    `shift_status` STRING COMMENT 'Current lifecycle status of the shift assignment indicating whether it is scheduled, confirmed, in progress, completed, cancelled, or resulted in a no-show.. Valid values are `scheduled|confirmed|in_progress|completed|cancelled|no_show`',
    `shift_type` STRING COMMENT 'Classification of the shift based on timing and operational pattern (opening, closing, mid-day, overnight, split, on-call).. Valid values are `opening|closing|mid|overnight|split|on_call`',
    `tardiness_minutes` STRING COMMENT 'Number of minutes the employee was late for the scheduled shift start time. Used for attendance policy enforcement.',
    `time_clock_device_code` STRING COMMENT 'Identifier of the physical or digital time clock device used by the employee to clock in and out for this shift. Used for audit and fraud prevention.',
    CONSTRAINT pk_shift_assignment PRIMARY KEY(`shift_assignment_id`)
) COMMENT 'Transactional record of a specific shift assigned to an employee at a store, DC, or corporate location. Captures scheduled start/end datetime, actual start/end datetime, shift type (opening, closing, mid, overnight), location, department, role, attendance status (present, absent, late, no-call-no-show), and hours worked. Supports labor scheduling, OTIF staffing, and attendance tracking.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique identifier for the time entry record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Time entries with labor_cost_amount must post to cost centers for GL integration and labor cost accounting. Apparel operations require time→cost_center link for payroll GL posting and labor variance a',
    `employee_id` BIGINT COMMENT 'Identifier of the user who last modified this time entry record, used for audit trail and accountability.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or cost center to which the labor hours should be charged.',
    `pay_period_id` BIGINT COMMENT 'Identifier of the pay period to which this time entry belongs. Used for payroll processing and reporting.',
    `payroll_run_id` BIGINT COMMENT 'Identifier of the payroll run in which this time entry was processed and paid.',
    `primary_time_employee_id` BIGINT COMMENT 'Identifier of the employee who recorded this time entry. Links to employee master data in Workday HCM.',
    `shift_assignment_id` BIGINT COMMENT 'Foreign key linking to workforce.shift_assignment. Business justification: Time entries are often associated with scheduled shift assignments. When an employee clocks in/out for a scheduled shift, the time_entry should reference the shift_assignment to enable variance analys',
    `work_location_org_unit_id` BIGINT COMMENT 'Identifier of the physical location where the work was performed, such as retail store, distribution center, or corporate office.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the time entry was approved by the manager.',
    `break_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of breaks taken during the shift, measured in minutes. Includes meal breaks and rest breaks.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'The exact date and time when the employee clocked in or started their shift.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'The exact date and time when the employee clocked out or ended their shift.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this time entry record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the labor cost amount.. Valid values are `^[A-Z]{3}$`',
    `device_identifier` STRING COMMENT 'Unique identifier of the device or terminal used to record the time entry, such as biometric scanner ID, mobile device ID, or POS terminal number.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of hours worked that qualify for double-time pay, typically for work on holidays or beyond daily overtime thresholds.',
    `entry_status` STRING COMMENT 'Current approval and processing status of the time entry. Tracks the entry through submission, approval, and payroll processing workflow.. Valid values are `draft|submitted|approved|rejected|pending_review|processed`',
    `exception_code` STRING COMMENT 'Code indicating any time and attendance exception associated with this entry, such as late arrival, early departure, missed punch, or unauthorized overtime.',
    `exception_notes` STRING COMMENT 'Free-text notes explaining any exceptions, corrections, or special circumstances related to this time entry.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate where the clock-in or clock-out occurred, captured from mobile time entry applications for location verification.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate where the clock-in or clock-out occurred, captured from mobile time entry applications for location verification.',
    `ip_address` STRING COMMENT 'Internet Protocol address from which the time entry was submitted, used for audit and fraud prevention.',
    `is_holiday_worked` BOOLEAN COMMENT 'Indicates whether the time entry represents work performed on a company-recognized holiday, which may qualify for premium pay.',
    `is_manual_entry` BOOLEAN COMMENT 'Indicates whether this time entry was manually entered by a manager or HR administrator rather than captured through automated time clock systems.',
    `job_code` STRING COMMENT 'The job classification or position code under which the employee worked during this time entry. Used for labor cost allocation and compliance reporting.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost associated with this time entry, including base pay, overtime premiums, and shift differentials. Used for financial reporting and cost allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this time entry record was last updated or modified.',
    `manual_entry_reason` STRING COMMENT 'Explanation for why the time entry was manually entered, such as missed punch, system outage, or retroactive correction.',
    `meal_break_violation_flag` BOOLEAN COMMENT 'Indicates whether this time entry violated meal break requirements under applicable labor laws, requiring penalty pay or corrective action.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours worked beyond regular hours that qualify for overtime pay, typically at 1.5x regular rate.',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether this time entry has been processed in a payroll run and included in employee compensation.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of hours worked at regular pay rate, typically up to 40 hours per week or 8 hours per day depending on jurisdiction.',
    `rest_break_violation_flag` BOOLEAN COMMENT 'Indicates whether this time entry violated rest break requirements under applicable labor laws.',
    `shift_differential_code` STRING COMMENT 'Code indicating any shift differential pay applicable to this time entry, such as night shift, weekend, or holiday premium.',
    `time_entry_date` DATE COMMENT 'The calendar date on which the work was performed.',
    `time_entry_source` STRING COMMENT 'The system or method used to capture the time entry. Indicates whether the entry was recorded via biometric device, mobile application, web portal, manual entry by manager, point-of-sale terminal, or self-service kiosk.. Valid values are `biometric|mobile_app|web_portal|manual|pos_terminal|kiosk`',
    `time_type` STRING COMMENT 'Classification of the time entry indicating the nature of hours worked or time off taken. Determines pay calculation and accrual impact. [ENUM-REF-CANDIDATE: regular|overtime|holiday|sick|vacation|bereavement|jury_duty|training — 8 candidates stripped; promote to reference product]',
    `total_hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours worked during this time entry, calculated as clock-out minus clock-in minus break duration.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Captures individual clock-in/clock-out records for hourly employees including punch-in datetime, punch-out datetime, break duration, total hours, overtime hours, pay period, time entry source (biometric, mobile, manual), approval status, and approving manager. Feeds payroll processing and labor cost reporting. Distinct from shift_assignment which is the planned schedule.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request record. Primary key.',
    `employee_id` BIGINT COMMENT 'System user identifier of the person who created the leave request record, typically the employee or an HR administrator.',
    `job_profile_id` BIGINT COMMENT 'Identifier of the employees job profile or role at the time of the leave request, used for seasonal staffing gap analysis.',
    `modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who last modified the leave request record.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the employees department or cost center at the time of the leave request.',
    `primary_leave_employee_id` BIGINT COMMENT 'Identifier of the employee submitting the leave request. Links to employee master data in Workday HCM.',
    `tertiary_leave_coverage_assigned_to_employee_id` BIGINT COMMENT 'Identifier of the employee assigned to cover the absent employees responsibilities during the leave period.',
    `work_location_org_unit_id` BIGINT COMMENT 'Identifier of the employees primary work location (store, distribution center, or corporate office) at the time of the leave request.',
    `actual_return_date` DATE COMMENT 'Actual date when the employee returned to work, which may differ from the scheduled return date due to extensions or early returns.',
    `approval_comments` STRING COMMENT 'Manager notes or comments provided during the approval or denial decision.',
    `approval_date` DATE COMMENT 'Date when the leave request was approved or denied by the manager.',
    `benefits_continuation_flag` BOOLEAN COMMENT 'Indicates whether employee benefits (health insurance, retirement contributions) continue during the leave period.',
    `certification_due_date` DATE COMMENT 'Deadline by which the employee must submit required medical certification documentation.',
    `coverage_plan_required` BOOLEAN COMMENT 'Indicates whether a staffing coverage plan is required for this leave, typically for extended absences or critical roles.',
    `denial_reason` STRING COMMENT 'Explanation provided by the manager when a leave request is denied, including business justification.',
    `end_date` DATE COMMENT 'Last date of the requested leave period. Null for open-ended or intermittent leave.',
    `fmla_case_number` STRING COMMENT 'Unique case identifier for FMLA-qualifying leave requests, used for compliance tracking and reporting.. Valid values are `^FMLA-[0-9]{6}$`',
    `fmla_hours_used` DECIMAL(18,2) COMMENT 'Total FMLA hours consumed by this leave request, counted against the employees annual 480-hour FMLA entitlement.',
    `intermittent_frequency` STRING COMMENT 'Expected frequency pattern for intermittent leave, such as weekly, bi-weekly, or as-needed.',
    `is_fmla_qualifying` BOOLEAN COMMENT 'Indicates whether the leave request qualifies for FMLA protection under federal law.',
    `is_intermittent` BOOLEAN COMMENT 'Indicates whether the leave is intermittent (taken in separate blocks of time) rather than continuous.',
    `is_paid_leave` BOOLEAN COMMENT 'Indicates whether the leave request is for paid time off (True) or unpaid leave (False).',
    `is_seasonal_employee` BOOLEAN COMMENT 'Indicates whether the employee is classified as seasonal at the time of the leave request, impacting leave eligibility and staffing planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the leave request record was last updated, including status changes, edits, or approvals.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'Remaining leave balance (in hours) for the applicable leave type after this request was approved and processed.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'Available leave balance (in hours) for the applicable leave type before this request was processed.',
    `leave_subtype` STRING COMMENT 'Detailed classification within the leave type, such as Continuous FMLA, Intermittent FMLA, Personal PTO, Vacation PTO, or Medical Sick Leave.',
    `leave_type` STRING COMMENT 'Category of leave requested: PTO (Paid Time Off), FMLA (Family and Medical Leave Act), Maternity, Paternity, Bereavement, Unpaid, or Sick leave. [ENUM-REF-CANDIDATE: PTO|FMLA|Maternity|Paternity|Bereavement|Unpaid|Sick — 7 candidates stripped; promote to reference product]',
    `medical_certification_received` BOOLEAN COMMENT 'Indicates whether required medical certification has been received and validated by HR.',
    `medical_certification_required` BOOLEAN COMMENT 'Indicates whether medical certification documentation is required to support the leave request.',
    `payroll_impact_flag` BOOLEAN COMMENT 'Indicates whether this leave request impacts payroll processing, requiring adjustments to regular pay, benefits, or deductions.',
    `reason_description` STRING COMMENT 'Employee-provided explanation or justification for the leave request. May contain sensitive personal information.',
    `request_date` DATE COMMENT 'Date when the employee submitted the leave request.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the leave request, formatted as LR-YYYYNNNN for external reference and tracking.. Valid values are `^LR-[0-9]{8}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the leave request in the approval workflow. [ENUM-REF-CANDIDATE: Draft|Submitted|Pending Approval|Approved|Denied|Cancelled|Withdrawn — 7 candidates stripped; promote to reference product]',
    `return_to_work_date` DATE COMMENT 'Scheduled date when the employee is expected to return to work following the leave period.',
    `start_date` DATE COMMENT 'First date of the requested leave period.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the leave request was submitted by the employee.',
    `total_days_requested` DECIMAL(18,2) COMMENT 'Total number of leave days requested, including partial days for intermittent leave. Calculated as business days between start and end dates.',
    `total_hours_requested` DECIMAL(18,2) COMMENT 'Total number of leave hours requested, used for hourly employees and intermittent leave tracking.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Tracks employee leave requests and approved absences including leave type (PTO, FMLA, maternity/paternity, bereavement, unpaid, sick), request date, start date, end date, total days, approval status, approving manager, and return-to-work date. Supports FMLA compliance tracking, leave balance management, and seasonal staffing gap analysis for retail and DC operations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique identifier for the payroll run. Primary key for the payroll run entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Payroll runs must link to legal entity (company_code) for multi-entity payroll processing, GL posting by entity, and statutory reporting. Apparel companies with multiple subsidiaries require payroll→c',
    `employee_id` BIGINT COMMENT 'User ID of the payroll manager or authorized approver who approved this payroll run for processing.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run was approved for processing.',
    `cost_center_allocation_method` STRING COMMENT 'Method used to allocate labor costs to cost centers: single (all to one cost center), proportional (split by percentage), time-based (by hours worked per cost center), or project-based (by project assignment).. Valid values are `single|proportional|time_based|project_based`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payroll run (e.g., USD, CAD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `gl_posting_date` DATE COMMENT 'Date on which payroll expenses and liabilities from this run are posted to the general ledger in SAP S/4HANA FI/CO.',
    `gl_posting_status` STRING COMMENT 'Status of general ledger posting for this payroll run: pending (not yet posted), posted (successfully recorded in GL), reversed (posting reversed due to correction), or error (posting failed).. Valid values are `pending|posted|reversed|error`',
    `is_year_end_adjustment` BOOLEAN COMMENT 'Boolean flag indicating whether this payroll run includes year-end adjustments for W-2 reconciliation, tax corrections, or annual bonus payouts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments about this payroll run, including special processing instructions, exceptions, or explanations for off-cycle runs.',
    `pay_frequency` STRING COMMENT 'Frequency of payroll processing for this run: weekly (52 times per year), bi-weekly (26 times per year), semi-monthly (24 times per year), or monthly (12 times per year).. Valid values are `weekly|bi_weekly|semi_monthly|monthly`',
    `pay_group_code` STRING COMMENT 'Code identifying the pay group or payroll calendar group (e.g., RETAIL_HOURLY, CORP_SALARY, DC_HOURLY). Used to segment employees by payment schedule and processing rules.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `pay_period_end_date` DATE COMMENT 'Last day of the pay period covered by this payroll run.',
    `pay_period_start_date` DATE COMMENT 'First day of the pay period covered by this payroll run.',
    `payment_batch_code` STRING COMMENT 'Identifier for the payment batch or ACH (Automated Clearing House) file generated for this payroll run. Used to track payment processing through banking systems.. Valid values are `^[A-Z0-9_-]{5,30}$`',
    `payment_date` DATE COMMENT 'Date on which employees will receive payment for this payroll run. Also known as check date or pay date.',
    `payment_method` STRING COMMENT 'Primary payment method used for this payroll run: direct deposit (ACH transfer to bank account), check (paper check), cash (physical currency), or paycard (prepaid debit card).. Valid values are `direct_deposit|check|cash|paycard`',
    `payroll_run_number` STRING COMMENT 'Business-facing unique identifier for the payroll run, typically formatted as PR-YYYYMMDD-XXX or similar pattern used in Workday HCM.. Valid values are `^PR-[0-9]{6,10}$`',
    `payroll_type` STRING COMMENT 'Type of payroll run: regular (scheduled bi-weekly or monthly), off-cycle (unscheduled), bonus (annual or quarterly bonuses), commission (sales commissions), adjustment (corrections), or final (termination payouts).. Valid values are `regular|off_cycle|bonus|commission|adjustment|final`',
    `processing_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run was processed and finalized in Workday HCM.',
    `run_status` STRING COMMENT 'Current lifecycle status of the payroll run: draft (being prepared), calculated (amounts computed), approved (manager approved), submitted (sent to payment processor), processed (payments initiated), paid (funds disbursed), cancelled (voided before payment), or reversed (corrected after payment). [ENUM-REF-CANDIDATE: draft|calculated|approved|submitted|processed|paid|cancelled|reversed — 8 candidates stripped; promote to reference product]',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run was submitted for approval.',
    `tax_jurisdiction_count` STRING COMMENT 'Number of distinct tax jurisdictions (federal, state, local) represented in this payroll run. Critical for multi-state tax compliance for retail associates.',
    `total_employee_count` STRING COMMENT 'Total number of employees included in this payroll run.',
    `total_employee_tax_amount` DECIMAL(18,2) COMMENT 'Total employee-paid payroll taxes withheld in this run, including federal income tax, state income tax, local tax, employee portion of FICA, and other mandatory withholdings.',
    `total_employer_tax_amount` DECIMAL(18,2) COMMENT 'Total employer-paid payroll taxes for this run, including employer portion of FICA (Federal Insurance Contributions Act), FUTA (Federal Unemployment Tax Act), SUTA (State Unemployment Tax Act), and other employer tax obligations.',
    `total_gross_pay_amount` DECIMAL(18,2) COMMENT 'Total gross pay amount for all employees in this payroll run before any deductions. Includes base salary, overtime, bonuses, commissions, and other earnings.',
    `total_net_pay_amount` DECIMAL(18,2) COMMENT 'Total net pay amount for all employees in this payroll run after all deductions. This is the total amount disbursed to employees.',
    `total_overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours across all hourly employees in this payroll run. Overtime is typically hours worked beyond 40 hours per week.',
    `total_post_tax_deduction_amount` DECIMAL(18,2) COMMENT 'Total post-tax deductions for all employees in this run, including garnishments, union dues, charitable contributions, and Roth 401(k) contributions.',
    `total_pre_tax_deduction_amount` DECIMAL(18,2) COMMENT 'Total pre-tax deductions for all employees in this run, including 401(k) contributions, health insurance premiums, FSA (Flexible Spending Account) contributions, and HSA (Health Savings Account) contributions.',
    `total_pto_hours` DECIMAL(18,2) COMMENT 'Total paid time off hours paid out in this payroll run, including vacation, sick leave, and personal days.',
    `total_regular_hours` DECIMAL(18,2) COMMENT 'Total regular work hours across all hourly employees in this payroll run.',
    `w2_tax_year` STRING COMMENT 'Calendar year for which this payroll run contributes to W-2 (Wage and Tax Statement) reporting. Typically the year of the pay period end date.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'SSOT for all payroll processing and compensation disbursement. Header level captures pay period dates, payroll type (regular, off-cycle, bonus), run status, total gross/net pay, employer taxes, total deductions, payment method, and processing timestamp. Line-item level captures per-employee earnings and deduction records including pay component type (base salary, overtime, commission, bonus, PTO payout, garnishment, 401k deduction, health premium, FICA), amount, hours, rate, pre/post-tax flag, and GL account mapping. Supports COGS labor allocation, store-level labor cost reporting, W-2 generation, and multi-state tax compliance for retail associates across jurisdictions.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Unique identifier for the compensation plan record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compensation plans must link to cost centers for salary budget tracking and merit increase planning. Apparel companies manage compensation budgets by cost center for annual planning and budget vs. act',
    `employee_id` BIGINT COMMENT 'Reference to the employee to whom this compensation plan applies.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Compensation plans are structured around job profiles. The compensation_plan has job_code which should be normalized to job_profile_id FK. Job profile defines pay grade, competency requirements, and c',
    `annual_review_month` STRING COMMENT 'Month (1-12) in which the employees annual compensation review is scheduled under this plan.',
    `approval_date` DATE COMMENT 'Date on which this compensation plan was approved.',
    `approval_status` STRING COMMENT 'Workflow approval status for this compensation plan (draft, pending approval, approved, rejected).. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the manager or HR representative who approved this compensation plan.',
    `base_pay_amount` DECIMAL(18,2) COMMENT 'The base compensation amount for the employee under this plan. For salaried employees, this is annual salary; for hourly employees, this is hourly rate.',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for performance or discretionary bonuses under this compensation plan.',
    `bonus_target_percentage` DECIMAL(18,2) COMMENT 'Target bonus as a percentage of base pay. For example, 15.00 represents a 15% target bonus.',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for commission-based compensation under this plan.',
    `commission_plan_code` STRING COMMENT 'Reference code to the commission plan structure that defines commission rates, tiers, and calculation rules for this employee.',
    `compa_ratio` DECIMAL(18,2) COMMENT 'Comparative ratio expressing the employees base pay as a percentage of the midpoint for their pay grade. Used for pay equity analysis. For example, 95.00 means the employee earns 95% of the grade midpoint.',
    `compensation_plan_status` STRING COMMENT 'Current lifecycle status of the compensation plan (active, inactive, pending approval, suspended, expired).. Valid values are `active|inactive|pending|suspended|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compensation plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this compensation plan (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Code identifying the department or cost center to which this compensation plan is charged.',
    `effective_end_date` DATE COMMENT 'Date when this compensation plan ceases to be effective. Null for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when this compensation plan becomes effective and binding for the employee.',
    `equity_grant_amount` DECIMAL(18,2) COMMENT 'Monetary value or number of equity units granted to the employee under this compensation plan.',
    `equity_grant_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for equity compensation (stock options, restricted stock units, or other equity instruments) under this plan.',
    `flsa_status` STRING COMMENT 'Classification of the employee under the Fair Labor Standards Act: exempt (not eligible for overtime) or non-exempt (eligible for overtime).. Valid values are `exempt|non_exempt`',
    `last_review_date` DATE COMMENT 'Date of the most recent compensation review or adjustment for this plan.',
    `location_code` STRING COMMENT 'Code identifying the work location or site associated with this compensation plan (e.g., store number, office code, distribution center identifier).',
    `merit_increase_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for merit-based salary increases under this compensation plan.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compensation plan record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compensation review or adjustment.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this compensation plan, including special terms, conditions, or justifications.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for overtime pay under labor regulations (typically applies to non-exempt hourly employees).',
    `pay_frequency` STRING COMMENT 'Frequency at which the employee is paid under this plan (weekly, biweekly, semimonthly, monthly, quarterly, annual).. Valid values are `weekly|biweekly|semimonthly|monthly|quarterly|annual`',
    `pay_grade` STRING COMMENT 'Pay grade or band assigned to this compensation plan, used for internal equity and compensation benchmarking (e.g., Grade 5, Band C, Level 3).',
    `pay_range_maximum` DECIMAL(18,2) COMMENT 'Maximum compensation amount for the pay grade or band associated with this plan.',
    `pay_range_midpoint` DECIMAL(18,2) COMMENT 'Midpoint compensation amount for the pay grade or band associated with this plan.',
    `pay_range_minimum` DECIMAL(18,2) COMMENT 'Minimum compensation amount for the pay grade or band associated with this plan.',
    `plan_name` STRING COMMENT 'Business-friendly name or title of the compensation plan (e.g., Retail Associate Base Plan, Corporate Executive Plan).',
    `plan_type` STRING COMMENT 'Classification of the compensation structure (base salary, hourly wage, commission only, salary plus commission, salary plus bonus, contract).. Valid values are `base_salary|hourly_wage|commission_only|salary_plus_commission|salary_plus_bonus|contract`',
    `reason_code` STRING COMMENT 'Code indicating the business reason for creating or modifying this compensation plan (new hire, promotion, merit increase, market adjustment, transfer, demotion, cost of living adjustment, reclassification). [ENUM-REF-CANDIDATE: new_hire|promotion|merit_increase|market_adjustment|transfer|demotion|cost_of_living|reclassification — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Defines the compensation structure for an employee including base pay, pay frequency, pay grade, merit increase eligibility, bonus target percentage, commission plan reference, equity grants, and effective date range. Tracks compensation history over time as plans change. Supports annual compensation review cycles and pay equity analysis.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment record. Primary key for the benefit enrollment entity.',
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan selected by the employee. Links to the benefit plan catalog.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Benefit enrollments must link to legal entity for benefit cost allocation, entity-level benefit accounting, and statutory reporting (ACA 1095-C by entity). Apparel companies require benefit→company_co',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee enrolling in benefits. Links to the employee master record in Workday HCM.',
    `aca_affordability_safe_harbor` STRING COMMENT 'Safe harbor method used to determine ACA affordability for this enrollment. Employers can use federal poverty line, rate of pay, or W-2 wages to demonstrate that coverage offered meets affordability requirements and avoid employer shared responsibility penalties.. Valid values are `federal_poverty_line|rate_of_pay|w2_wages|not_applicable`',
    `aca_minimum_value_met_flag` BOOLEAN COMMENT 'Indicates whether the benefit plan meets the ACA minimum value standard of covering at least 60% of the total allowed cost of benefits. Required for ACA compliance and Form 1095-C reporting.',
    `annual_premium_amount` DECIMAL(18,2) COMMENT 'Total annual cost of the benefit plan for the selected coverage tier. Represents the combined employer and employee contribution before any cost-sharing splits.',
    `beneficiary_count` STRING COMMENT 'Number of beneficiaries designated for life insurance and retirement plan death benefits. Applicable for life insurance, AD&D, and 401k plan enrollments.',
    `carrier_confirmation_received_flag` BOOLEAN COMMENT 'Indicates whether the benefit carrier has confirmed receipt and processing of the enrollment. Confirmation typically includes member ID assignment and coverage effective date validation.',
    `carrier_member_number` STRING COMMENT 'Unique member identifier assigned by the benefit carrier for this enrollment. Used for claims processing, provider verification, and member services. Differs from employee ID and is carrier-specific.',
    `carrier_notification_sent_date` DATE COMMENT 'Date on which enrollment data was transmitted to the benefit carrier. Used to track carrier processing timelines and resolve coverage activation issues.',
    `carrier_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the enrollment information was transmitted to the benefit carrier for coverage activation. Typically sent via EDI 834 transaction for medical, dental, and vision plans.',
    `cobra_election_date` DATE COMMENT 'Date on which the former employee or qualified beneficiary elected to continue coverage under COBRA. Must occur within 60 days of the later of the qualifying event date or the date the COBRA notice was provided.',
    `cobra_expiration_date` DATE COMMENT 'Date on which COBRA continuation coverage ends. Typically 18 months after the qualifying event for termination or reduction in hours, 36 months for divorce or dependent loss of eligibility.',
    `cobra_qualifying_event` STRING COMMENT 'Type of qualifying event that triggered COBRA continuation coverage eligibility. Termination of employment and reduction in hours are most common for employees; divorce and dependent aging out apply to dependents.. Valid values are `termination|reduction_hours|divorce|death|medicare_entitlement|dependent_loss`',
    `coverage_tier` STRING COMMENT 'Level of coverage elected by the employee, determining who is covered under the benefit plan. Employee only covers the individual, employee plus spouse covers two adults, employee plus children covers employee and dependents under 26, and employee plus family covers all eligible dependents.. Valid values are `employee_only|employee_spouse|employee_children|employee_family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit enrollment record was first created in the system. Used for audit trail and data lineage tracking.',
    `dependent_count` STRING COMMENT 'Number of eligible dependents covered under this enrollment. Includes spouse, domestic partner, and children under age 26 as defined by ACA dependent coverage provisions.',
    `effective_end_date` DATE COMMENT 'Date on which benefit coverage ends. Null for active enrollments. Populated upon termination of employment, plan change, or waiver. For COBRA, typically 18 months after qualifying event.',
    `effective_start_date` DATE COMMENT 'Date on which benefit coverage begins. For new hires, typically the first day of the month following hire date or 30 days after hire. For open enrollment, typically January 1st of the plan year.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Annual amount deducted from employee pay for benefit premium. Typically deducted pre-tax for qualified plans under Section 125. Used for payroll processing and W-2 reporting.',
    `employee_discount_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for the Apparel Fashion employee discount program as part of their benefits package. Typically available to retail associates and corporate staff for purchasing company merchandise at reduced prices.',
    `employee_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount on company merchandise available to the employee. Varies by employee type and tenure. Retail associates typically receive 20-30% discount, corporate staff may receive higher tiers.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Annual amount contributed by Apparel Fashion toward the employee benefit premium. Used for ACA affordability calculations and ERISA reporting.',
    `enrollment_confirmation_sent_date` DATE COMMENT 'Date on which the enrollment confirmation was sent to the employee via email or postal mail. Used for audit trail and compliance documentation.',
    `enrollment_confirmation_sent_flag` BOOLEAN COMMENT 'Indicates whether an enrollment confirmation notification was sent to the employee. Confirmation includes enrollment number, coverage details, premium amounts, and effective dates.',
    `enrollment_date` DATE COMMENT 'Date on which the employee submitted their benefit election. This is the transaction date for the enrollment event and may differ from the coverage effective date.',
    `enrollment_number` STRING COMMENT 'Business-facing enrollment confirmation number provided to the employee upon successful enrollment. Used for reference in benefits inquiries and claims.',
    `enrollment_source` STRING COMMENT 'Channel or system through which the benefit enrollment was submitted. Employee self-service indicates online enrollment through Workday portal, HR representative indicates manual entry by HR staff, automated renewal applies to passive enrollments carried forward from prior year.. Valid values are `employee_self_service|hr_representative|benefits_administrator|automated_renewal|edi_feed`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the benefit enrollment. Active indicates coverage is in force, waived means employee declined coverage, terminated indicates coverage has ended, pending is awaiting approval or effective date, suspended is temporarily inactive, and COBRA active indicates continuation coverage post-employment.. Valid values are `active|waived|terminated|pending|suspended|cobra_active`',
    `enrollment_type` STRING COMMENT 'Classification of the enrollment event that triggered this benefit election. New hire enrollments occur within 30 days of hire date, open enrollment is the annual election period, qualifying life events include marriage/birth/divorce, and COBRA applies to continuation coverage after employment termination.. Valid values are `new_hire|open_enrollment|qualifying_life_event|annual_renewal|cobra|special_enrollment`',
    `form_1095c_furnished_date` DATE COMMENT 'Date on which Form 1095-C was provided to the employee. Must be furnished by January 31st following the calendar year of coverage per IRS requirements.',
    `form_1095c_generated_flag` BOOLEAN COMMENT 'Indicates whether IRS Form 1095-C has been generated for this enrollment record. Form 1095-C is required for ACA reporting to document that coverage was offered to the employee and dependents.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit enrollment record was last updated. Captures any changes to enrollment status, coverage tier, premium amounts, or other enrollment attributes.',
    `notes` STRING COMMENT 'Free-text field for capturing additional information about the enrollment such as special circumstances, exceptions, or processing notes. Used by benefits administrators for case management and audit documentation.',
    `payroll_deduction_frequency` STRING COMMENT 'Frequency at which employee benefit contributions are deducted from payroll. Aligns with the company payroll schedule for retail associates, corporate staff, and distribution center teams.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `per_pay_period_deduction_amount` DECIMAL(18,2) COMMENT 'Employee contribution amount deducted each pay period. Calculated by dividing annual employee contribution by number of pay periods per year based on payroll deduction frequency.',
    `plan_year` STRING COMMENT 'Calendar year for which this benefit enrollment is effective. Typically aligns with open enrollment periods and ACA reporting requirements.',
    `qualifying_life_event_date` DATE COMMENT 'Date on which the qualifying life event occurred. Used to determine the 30-day election window and coverage effective date for mid-year changes.',
    `qualifying_life_event_type` STRING COMMENT 'Type of qualifying life event that triggered a mid-year enrollment change outside of open enrollment. QLE allows employees to modify benefit elections within 30 days of the event as permitted by HIPAA special enrollment rights. [ENUM-REF-CANDIDATE: marriage|divorce|birth|adoption|death|loss_of_coverage|employment_change — 7 candidates stripped; promote to reference product]',
    `vesting_date` DATE COMMENT 'Date on which the employee becomes fully vested in employer contributions. Typically after 3-5 years of service depending on the plan vesting schedule (cliff or graded).',
    `vesting_percentage` DECIMAL(18,2) COMMENT 'Percentage of employer contributions that the employee is entitled to retain upon termination. Applicable to retirement plans such as 401k with employer match. Increases based on years of service per the plan vesting schedule.',
    `waiver_reason` STRING COMMENT 'Reason provided by employee for declining benefit coverage. Required for ACA reporting to demonstrate that coverage was offered but declined. Spouse coverage and other employer coverage are most common reasons. [ENUM-REF-CANDIDATE: spouse_coverage|other_employer_coverage|medicare|medicaid|tricare|cost|not_needed — 7 candidates stripped; promote to reference product]',
    `waiver_signed_date` DATE COMMENT 'Date on which the employee signed the benefit waiver form. Required documentation for ACA compliance to prove that coverage was offered and voluntarily declined.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'SSOT for the complete employee benefits lifecycle. Plan catalog section defines available benefit plans including plan name, type (medical, dental, vision, retirement, life, disability, supplemental), carrier, plan year, coverage tiers, employer/employee contribution rates, eligibility rules, vesting schedules, and open enrollment windows. Enrollment section captures individual employee elections including selected plan, coverage tier, enrollment/effective dates, annual premium, contribution amounts, dependent/beneficiary coverage, life event triggers, and enrollment status (active, waived, terminated, COBRA). Supports open enrollment management, ACA compliance reporting (1095-C generation), COBRA administration, qualifying life event processing, and employee discount program tracking for retail associates.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` (
    `talent_requisition_id` BIGINT COMMENT 'Unique identifier for the talent requisition record. Primary key for the talent requisition entity.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that will bear the compensation and benefits expense for the hired candidate.',
    `department_id` BIGINT COMMENT 'Reference to the department or organizational unit that will employ the hired candidate.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile that defines the role, responsibilities, competencies, and compensation band for this requisition.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Hiring processes must comply with labor law obligations (EEO posting requirements, work authorization verification, wage transparency laws). Requisitions track compliance obligation fulfillment for re',
    `org_unit_id` BIGINT COMMENT 'Reference to the primary work location (store, distribution center, corporate office) where the hired candidate will be based.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager responsible for approving the requisition and making the final hiring decision.',
    `quaternary_talent_approved_by_employee_id` BIGINT COMMENT 'Reference to the final approver who authorized the requisition to be opened for recruiting.',
    `tertiary_talent_replacement_for_employee_id` BIGINT COMMENT 'Reference to the employee being replaced, if this is a replacement requisition. Used to track turnover and succession planning.',
    `approval_workflow_status` STRING COMMENT 'The current step or status in the multi-level approval workflow (e.g., Pending Hiring Manager, Pending HR, Pending Finance, Approved). Tracks requisition through approval chain.',
    `approved_headcount` STRING COMMENT 'The number of positions approved for hire under this requisition. Typically 1 for individual roles, may be greater for high-volume retail associate hiring.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time the requisition received final approval and was authorized to proceed to active recruiting.',
    `cancellation_reason` STRING COMMENT 'The business reason for cancelling the requisition, if applicable (e.g., budget cut, role eliminated, internal transfer, business priority change). Used for workforce planning analysis.',
    `compensation_grade` STRING COMMENT 'The compensation or pay grade assigned to this position, which determines the salary range and benefits eligibility.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time the requisition record was first created in the system. Audit trail for requisition lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary range (e.g., USD, EUR, GBP). Supports multi-country operations.. Valid values are `^[A-Z]{3}$`',
    `diversity_initiative_flag` BOOLEAN COMMENT 'Indicates whether this requisition is part of a diversity and inclusion hiring initiative. Used for diversity pipeline tracking and reporting.',
    `employment_type` STRING COMMENT 'The employment classification for the position: full-time (40 hours/week), part-time (less than 40 hours/week), casual (on-call or variable hours), or seasonal (fixed-term for peak periods).. Valid values are `full_time|part_time|casual|seasonal`',
    `is_remote_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for remote or work-from-home arrangements. True: remote work allowed; False: on-site work required.',
    `job_description` STRING COMMENT 'Detailed description of the role, including responsibilities, qualifications, required skills, and working conditions. Used in job postings and candidate communications.',
    `job_posting_title` STRING COMMENT 'The external-facing job title used in job postings and advertisements. May differ from the internal job title for marketing or branding purposes.',
    `job_title` STRING COMMENT 'The official job title for the position being recruited, as it will appear in job postings and offer letters.',
    `minimum_education_level` STRING COMMENT 'The minimum educational qualification required for the position. None: no formal education required; High School: diploma or equivalent; Associate: 2-year degree; Bachelor: 4-year degree; Master: graduate degree; Doctorate: PhD or equivalent.. Valid values are `none|high_school|associate|bachelor|master|doctorate`',
    `minimum_experience_years` STRING COMMENT 'The minimum number of years of relevant work experience required for the position. Zero indicates entry-level roles.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time the requisition record was last updated. Audit trail for tracking changes to requisition details.',
    `positions_filled` STRING COMMENT 'The number of positions that have been successfully filled (candidates hired) under this requisition. Used to track progress toward approved headcount.',
    `priority_level` STRING COMMENT 'The urgency or business priority of filling this requisition. Critical: immediate business impact; High: important for operations; Medium: standard priority; Low: can be filled opportunistically.. Valid values are `low|medium|high|critical`',
    `requisition_close_date` DATE COMMENT 'The date the requisition was closed, either because all positions were filled, the requisition was cancelled, or it expired. End point for time-to-fill KPI calculation.',
    `requisition_number` STRING COMMENT 'Business identifier for the requisition, externally visible and used for tracking and communication. Format: REQ-YYYYNNNN.. Valid values are `^REQ-[0-9]{8}$`',
    `requisition_open_date` DATE COMMENT 'The date the requisition was approved and opened for active recruiting. Start point for time-to-fill KPI calculation.',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the requisition. Draft: being prepared; Pending Approval: submitted for approval; Approved: approved but not yet posted; Open: actively recruiting; On Hold: temporarily paused; Filled: candidate hired; Cancelled: requisition withdrawn; Closed: requisition completed or expired. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|open|on_hold|filled|cancelled|closed — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the requisition based on the nature of the hire. New Position: net new headcount; Replacement: backfill for departure; Seasonal: holiday or back-to-school temporary hire; Temporary: fixed-term assignment; Contract: contingent worker; Intern: student or graduate program.. Valid values are `new_position|replacement|seasonal|temporary|contract|intern`',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'The maximum annual salary or hourly wage for the position, in the local currency. Used for budgeting and offer preparation.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'The minimum annual salary or hourly wage for the position, in the local currency. Used for budgeting and offer preparation.',
    `seasonal_campaign` STRING COMMENT 'The name or identifier of the seasonal hiring campaign this requisition belongs to (e.g., Holiday 2024, Back-to-School 2024). Used for high-volume retail associate hiring planning.',
    `sourcing_channel_strategy` STRING COMMENT 'The planned or preferred sourcing channels for candidate acquisition, such as job boards, employee referrals, campus recruiting, social media, recruitment agencies, or internal transfers. May be a comma-separated list.',
    `target_fill_date` DATE COMMENT 'The target date by which the requisition should be filled. Used for SLA (Service Level Agreement) tracking and recruiter performance measurement.',
    `target_start_date` DATE COMMENT 'The desired or planned start date for the hired candidate(s). Used for workforce planning and onboarding preparation.',
    `time_to_fill_days` STRING COMMENT 'The number of calendar days from requisition open date to the date the first candidate accepted an offer. Key performance indicator (KPI) for recruiting efficiency.',
    `travel_requirement_percentage` STRING COMMENT 'The estimated percentage of time the role requires business travel. Zero indicates no travel; 100 indicates constant travel.',
    CONSTRAINT pk_talent_requisition PRIMARY KEY(`talent_requisition_id`)
) COMMENT 'SSOT for the full talent acquisition lifecycle from requisition approval through candidate hire. Requisition header captures requisition number, job profile, target location, hiring manager, recruiter, requisition status (draft, approved, open, filled, cancelled), target start date, approved headcount, sourcing channel strategy, and time-to-fill KPI. Candidate application records capture applicant identity, contact details, application date, source channel (job board, referral, campus, walk-in, internal transfer), pipeline stage (applied, screened, phone screen, interviewed, offered, hired, rejected, withdrawn), interview scores, offer details (compensation, start date, contingencies), background check status, and disposition reason. Supports funnel analysis, seasonal hiring ramp planning (holiday, back-to-school), recruiter productivity reporting, diversity pipeline tracking, and high-volume retail associate hiring workflows.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review or disciplinary action record. Primary key.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Policy violations documented in performance reviews (harassment, safety violations, code of conduct breaches) trigger formal compliance incidents requiring investigation and regulatory reporting. Link',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Performance reviews evaluate employees against job profile competency requirements. Adding job_profile_id FK allows comparison of performance ratings against the competency_requirements and skill_requ',
    `employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed or subject to disciplinary action.',
    `quaternary_performance_hr_business_partner_employee_id` BIGINT COMMENT 'Identifier of the HR Business Partner who reviewed and validated the performance review or disciplinary action for compliance and fairness.',
    `tertiary_performance_reviewing_manager_employee_id` BIGINT COMMENT 'Identifier of the second-level manager or reviewer who approved the performance review or disciplinary action.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the employee filed an appeal or grievance regarding the performance review or disciplinary action.',
    `appeal_outcome` STRING COMMENT 'Outcome of the employee appeal or grievance process, if applicable.. Valid values are `upheld|overturned|modified|pending|not_applicable`',
    `calibration_session_date` DATE COMMENT 'Date of the talent calibration session where this performance review was discussed.',
    `calibration_session_flag` BOOLEAN COMMENT 'Indicates whether this performance review was discussed and calibrated in a talent calibration session to ensure rating consistency across the organization.',
    `competency_communication_rating` STRING COMMENT 'Rating for communication skills competency.. Valid values are `exceeds|meets|needs_improvement|not_applicable`',
    `competency_leadership_rating` STRING COMMENT 'Rating for leadership competency. Applicable to managers and supervisors.. Valid values are `exceeds|meets|needs_improvement|not_applicable`',
    `competency_teamwork_rating` STRING COMMENT 'Rating for teamwork and collaboration competency.. Valid values are `exceeds|meets|needs_improvement|not_applicable`',
    `competency_technical_rating` STRING COMMENT 'Rating for technical or job-specific skills competency.. Valid values are `exceeds|meets|needs_improvement|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review or disciplinary action record was first created in the system.',
    `development_plan_actions` STRING COMMENT 'Summary of development plan actions, training recommendations, or improvement areas identified during the review.',
    `document_url` STRING COMMENT 'URL or file path to the full performance review or disciplinary action document stored in the document management system.',
    `employee_acknowledgment_date` DATE COMMENT 'Date the employee acknowledged the performance review or disciplinary action.',
    `employee_acknowledgment_status` STRING COMMENT 'Status indicating whether the employee has acknowledged receipt and review of the performance review or disciplinary document.. Valid values are `acknowledged|not_acknowledged|refused_to_sign`',
    `employee_comments` STRING COMMENT 'Comments or feedback provided by the employee in response to the performance review or disciplinary action.',
    `finalized_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review or disciplinary action was finalized and locked from further edits.',
    `goal_achievement_percentage` DECIMAL(18,2) COMMENT 'Percentage of performance goals or OKRs (Objectives and Key Results) / KPIs (Key Performance Indicators) achieved during the review period.',
    `incident_date` DATE COMMENT 'Date of the incident or policy violation that triggered the disciplinary action. Null for performance reviews.',
    `incident_description` STRING COMMENT 'Detailed description of the incident, policy violation, or conduct issue. Applicable for disciplinary actions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review or disciplinary action record was last modified.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether this performance review or disciplinary action requires legal review for compliance and risk mitigation.',
    `merit_increase_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for a merit increase based on this performance review.',
    `overall_rating` STRING COMMENT 'Overall performance rating assigned to the employee for the review period. Not applicable for disciplinary actions.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score corresponding to the overall performance rating, typically on a scale (e.g., 1.0 to 5.0). Supports merit increase calculations and calibration.',
    `pip_end_date` DATE COMMENT 'End date of the Performance Improvement Plan, if applicable for this review.',
    `pip_outcome` STRING COMMENT 'Outcome of the Performance Improvement Plan: successful completion, unsuccessful (leading to further action), or in progress.. Valid values are `successful|unsuccessful|in_progress|not_applicable`',
    `pip_start_date` DATE COMMENT 'Start date of the Performance Improvement Plan, if applicable for this review.',
    `policy_violated` STRING COMMENT 'Name or code of the company policy violated, applicable for disciplinary actions. Null for performance reviews.',
    `promotion_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for promotion consideration based on this performance review.',
    `resolution_status` STRING COMMENT 'Current status of the performance review or disciplinary action resolution process.. Valid values are `open|in_progress|resolved|closed`',
    `review_date` DATE COMMENT 'Date the performance review or disciplinary meeting was conducted.',
    `review_period_end_date` DATE COMMENT 'End date of the performance evaluation period being assessed.',
    `review_period_start_date` DATE COMMENT 'Start date of the performance evaluation period being assessed.',
    `review_status` STRING COMMENT 'Current workflow status of the performance review or disciplinary action document.. Valid values are `draft|submitted|approved|finalized|archived`',
    `review_type` STRING COMMENT 'Type of performance evaluation or disciplinary document. Distinguishes between performance reviews (annual, mid-year, probationary, 360) and progressive discipline actions (verbal warning, written warning, PIP, suspension, termination). [ENUM-REF-CANDIDATE: annual_review|mid_year_review|probationary_review|360_assessment|verbal_warning|written_warning|performance_improvement_plan|suspension|termination — promote to reference product]',
    `termination_recommended_flag` BOOLEAN COMMENT 'Indicates whether termination is recommended as a result of this performance review or disciplinary action.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'SSOT for all formal performance evaluation and conduct documentation. Covers annual performance reviews, mid-year check-ins, probationary evaluations, 360 assessments, goal tracking (OKRs/KPIs), and the full progressive discipline lifecycle (verbal warnings, written warnings, PIPs, suspensions, terminations for cause). Captures review period, document type, overall rating, competency ratings, goal achievement percentage, development plan actions, policy violated (if disciplinary), incident date, incident description, issuing manager, reviewing manager, HR business partner, employee acknowledgment status, appeal outcome, resolution status, and calibration session flag. Supports merit increase decisions, promotion eligibility, progressive discipline management, legal defensibility for terminations, talent calibration sessions, and succession planning inputs across retail, DC, and corporate populations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` (
    `learning_enrollment_id` BIGINT COMMENT 'Unique identifier for the learning enrollment record. Primary key for the learning enrollment entity.',
    `course_id` BIGINT COMMENT 'Unique identifier of the training course or learning program. Links to the course catalog.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee enrolled in the training program. Links to the employee master data in Workday HCM.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Training courses are often tied to job profile requirements. Learning enrollment should reference the job profile for which the training is required or recommended. This enables tracking of role-speci',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Mandatory compliance training (sexual harassment prevention, workplace safety, ethics, data privacy) directly fulfills regulatory obligations. Tracks which training courses satisfy specific legal requ',
    `actual_start_date` DATE COMMENT 'Actual date when the employee began the training course. Null if the employee has not yet started the course.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved by the employee on the course assessment or exam, typically expressed as a percentage (0.00 to 100.00). Null if the course does not include an assessment or if not yet taken.',
    `attempts_count` STRING COMMENT 'Number of times the employee has attempted the course assessment. Used to track retakes and learning effectiveness.',
    `certification_expiry_date` DATE COMMENT 'Date when the certification expires and requires renewal. Null for certifications that do not expire or if no certification was issued. Critical for compliance training audit trails.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether a formal certification or credential was issued upon successful completion of the course. True if certification was issued, False otherwise.',
    `certification_number` STRING COMMENT 'Unique alphanumeric identifier of the certification or credential issued to the employee upon course completion. Null if no certification was issued.',
    `completion_date` DATE COMMENT 'Date when the employee successfully completed the training course. Null if the course is in progress or not completed.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of the course content completed by the employee, ranging from 0.00 to 100.00. Used to track progress for in-progress courses.',
    `completion_status` STRING COMMENT 'Current status of the employees progress in the training course: not_started (enrolled but not begun), in_progress (actively taking the course), completed (successfully finished), failed (did not meet passing criteria), withdrawn (employee dropped the course), or expired (deadline passed without completion).. Valid values are `not_started|in_progress|completed|failed|withdrawn|expired`',
    `compliance_category` STRING COMMENT 'Regulatory or policy compliance area addressed by the training course: harassment_prevention (anti-harassment and discrimination training), workplace_safety (OSHA and safety protocols), labor_standards (FLA and WRAP requirements), data_privacy (GDPR and CCPA training), financial_compliance (SOX and financial controls), or product_safety (CPSC and product safety standards). Null for non-compliance courses. [ENUM-REF-CANDIDATE: harassment_prevention|workplace_safety|labor_standards|data_privacy|financial_compliance|product_safety|environmental_compliance|trade_compliance — promote to reference product]. Valid values are `harassment_prevention|workplace_safety|labor_standards|data_privacy|financial_compliance|product_safety`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for the employees enrollment in the training course, including tuition, materials, travel, and instructor fees. Expressed in the companys reporting currency. Used for training budget tracking and ROI analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the learning enrollment record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, EUR, GBP). Supports multi-currency training cost tracking for global operations.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Method by which the training is delivered: instructor_led (in-person classroom), e_learning (online self-paced), blended (combination of methods), on_the_job (hands-on training), virtual_classroom (live online session), or self_paced (asynchronous learning).. Valid values are `instructor_led|e_learning|blended|on_the_job|virtual_classroom|self_paced`',
    `due_date` DATE COMMENT 'Final deadline by which the employee must complete the training course to remain compliant. Critical for mandatory compliance training tracking and audit trails. May differ from scheduled_end_date for flexible learning paths.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training course in hours (e.g., 2.50 for a 2.5-hour course, 40.00 for a week-long program). Used for tracking training investment and compliance reporting.',
    `enrollment_date` DATE COMMENT 'Date when the employee was enrolled in the training course. Represents the official registration date in the learning management system.',
    `enrollment_source` STRING COMMENT 'Origin or trigger for the employees enrollment in the training course: manager_assigned (manager-initiated), self_enrolled (employee self-service), hr_assigned (HR department-initiated), system_triggered (automated based on role or event), compliance_required (regulatory mandate), or career_development (part of individual development plan).. Valid values are `manager_assigned|self_enrolled|hr_assigned|system_triggered|compliance_required|career_development`',
    `feedback_comments` STRING COMMENT 'Free-text comments provided by the employee regarding their training experience. Used for qualitative assessment of training effectiveness and continuous improvement.',
    `feedback_rating` DECIMAL(18,2) COMMENT 'Employees satisfaction rating for the training course, typically on a scale of 1.00 to 5.00. Used to measure training effectiveness and quality. Null if feedback has not been provided.',
    `instructor_name` STRING COMMENT 'Full name of the instructor or facilitator who delivered the training course. Null for self-paced or e-learning courses without a designated instructor.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the learning enrollment record was last updated. Used for audit trail and change tracking.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the training course is mandatory for the employee based on their role, location, or regulatory requirements. True if mandatory, False if optional.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the course assessment, expressed as a percentage (e.g., 80.00 for 80%). Used to determine completion status.',
    `recertification_interval_months` STRING COMMENT 'Number of months between required recertification cycles (e.g., 12 for annual recertification, 24 for biennial). Null if recertification is not required.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether the employee must retake the course periodically to maintain certification or compliance. True if recertification is required, False otherwise.',
    `scheduled_end_date` DATE COMMENT 'Planned date by which the employee is expected to complete the training course. Used for tracking compliance deadlines and learning plan milestones.',
    `scheduled_start_date` DATE COMMENT 'Planned date when the employee is expected to begin the training course. May differ from enrollment date for future-scheduled courses.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was conducted (e.g., Corporate HQ - Conference Room A, Distribution Center - Training Room, Online Platform, Store #1234). Null for fully self-paced online courses.',
    `waitlist_flag` BOOLEAN COMMENT 'Indicates whether the employee is currently on a waitlist for the course due to capacity constraints. True if waitlisted, False if actively enrolled.',
    CONSTRAINT pk_learning_enrollment PRIMARY KEY(`learning_enrollment_id`)
) COMMENT 'Tracks employee enrollment and completion of training programs including onboarding, product knowledge, compliance training (harassment prevention, safety, FLA labor standards), visual merchandising techniques, and leadership development. Captures course name, course type, enrollment date, completion date, completion status, score, and certification expiry date. Supports FLA and WRAP compliance audit trails.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` (
    `labor_compliance_event_id` BIGINT COMMENT 'Unique identifier for the labor compliance event record.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Labor compliance events are discovered during factory social compliance audits (WRAP, BSCI, SA8000) or trigger follow-up audits. Links labor violations to the audit that identified them or that they n',
    `corrective_action_plan_id` BIGINT COMMENT 'Identifier linking this compliance event to a formal Corrective Action Plan (CAP) document or record in the compliance management system.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or compliance officer who last modified this record.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Labor compliance violations (wage/hour violations, break violations, child labor, forced labor) escalate to formal compliance incidents requiring regulatory notification and remediation tracking. Natu',
    `location_org_unit_id` BIGINT COMMENT 'Identifier of the facility, store, distribution center, or corporate office where the compliance event occurred.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Labor compliance events occur within organizational units and must be tracked by department for regulatory reporting. labor_compliance_event has department_code string attribute which should be normal',
    `primary_labor_employee_id` BIGINT COMMENT 'Identifier of the employee affected by or involved in the compliance event.',
    `quaternary_labor_remediation_owner_employee_id` BIGINT COMMENT 'Identifier of the employee or compliance officer assigned to own and execute the remediation action.',
    `tertiary_labor_manager_employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor responsible for the affected employee or location at the time of the event.',
    `audit_reference_number` STRING COMMENT 'External reference number or identifier from FLA, WRAP, or other third-party audit reports linking this event to a formal audit finding.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this labor compliance event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `detected_by` STRING COMMENT 'Source or method by which the compliance event was detected (e.g., automated system alert, manager report, employee complaint, audit finding). [ENUM-REF-CANDIDATE: system_automated|manager_report|employee_report|internal_audit|external_audit|whistleblower|regulatory_inspection — 7 candidates stripped; promote to reference product]',
    `event_date` DATE COMMENT 'Date when the labor compliance event or violation occurred.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the labor compliance event was recorded or detected in the system.',
    `event_type` STRING COMMENT 'Category of labor compliance event or violation. Includes wage-and-hour incidents, missed meal/rest break violations, overtime threshold breaches, child labor checks, work authorization expiry alerts, and FLA/WRAP audit findings. [ENUM-REF-CANDIDATE: wage_hour_violation|missed_meal_break|missed_rest_break|overtime_threshold_breach|child_labor_check|work_authorization_expiry|fla_audit_finding|wrap_audit_finding|safety_violation|discrimination_incident — 10 candidates stripped; promote to reference product]',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Monetary value of the financial impact or penalty associated with the compliance event, including back wages, fines, or settlements. Expressed in USD.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this labor compliance event record was last updated or modified.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context related to the compliance event, remediation progress, or resolution.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this compliance event is a repeat occurrence for the same employee or location, signaling a pattern requiring escalated intervention.',
    `regulatory_filing_date` DATE COMMENT 'Date when the compliance event was formally reported or filed with the applicable regulatory authority. Null if no filing is required or filing is pending.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this compliance event requires formal reporting or filing with a regulatory body (e.g., FTC, OSHA, state labor department).',
    `regulatory_framework` STRING COMMENT 'The governing regulatory framework or standard under which the compliance event is classified (e.g., FLSA for wage-hour, FLA for labor rights, WRAP for production standards, OSHA for safety). [ENUM-REF-CANDIDATE: flsa|fla|wrap|osha|state_labor_law|local_ordinance|international_labor_standards|company_policy — 8 candidates stripped; promote to reference product]',
    `remediation_action` STRING COMMENT 'Description of the corrective or remediation action taken or planned to address the compliance event and prevent recurrence.',
    `remediation_completed_date` DATE COMMENT 'Actual date when the remediation action was completed and verified. Null if remediation is still in progress.',
    `remediation_due_date` DATE COMMENT 'Target date by which the remediation action must be completed to achieve compliance.',
    `resolution_status` STRING COMMENT 'Current status of the compliance event in the resolution workflow, indicating whether it is open, being addressed, resolved, or closed.. Valid values are `open|in_progress|pending_verification|resolved|closed|escalated`',
    `root_cause_category` STRING COMMENT 'Classification of the underlying root cause of the compliance event, used for trend analysis and systemic remediation planning. [ENUM-REF-CANDIDATE: policy_gap|training_deficiency|system_error|management_oversight|workload_pressure|inadequate_staffing|process_failure — 7 candidates stripped; promote to reference product]',
    `severity_level` STRING COMMENT 'Severity classification of the compliance event indicating the level of risk or impact to the business and affected employees.. Valid values are `critical|high|medium|low|informational`',
    `violation_description` STRING COMMENT 'Detailed narrative description of the labor compliance event or violation, including circumstances and context.',
    CONSTRAINT pk_labor_compliance_event PRIMARY KEY(`labor_compliance_event_id`)
) COMMENT 'Records labor law compliance events and violations including wage-and-hour incidents, missed meal/rest break violations, overtime threshold breaches, child labor checks, work authorization expiry alerts, and FLA/WRAP audit findings. Captures event type, event date, employee affected, location, severity, remediation action, and resolution status. Critical for FTC, FLA, and WRAP regulatory compliance.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Primary key for benefit_plan',
    `superseded_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (superseded_benefit_plan_id)',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or third-party administrator providing the benefit plan.',
    `carrier_policy_number` STRING COMMENT 'Unique policy or contract number assigned by the insurance carrier for this benefit plan.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of covered expenses the employee pays after meeting the deductible.',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are collected for the benefit plan.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee pays for specific covered services (e.g., doctor visits, prescriptions).',
    `coverage_level` STRING COMMENT 'Scope of coverage indicating who is eligible under the plan (employee only, family, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this benefit plan.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the employee must pay before the plan begins coverage. Applicable to health and insurance plans.',
    `effective_end_date` DATE COMMENT 'Date when the benefit plan is no longer available for new enrollments. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the benefit plan becomes active and available for employee enrollment.',
    `eligibility_criteria` STRING COMMENT 'Description of employee eligibility requirements for enrollment in this benefit plan (e.g., full-time status, waiting period).',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Standard monetary amount the employee contributes per pay period for this benefit plan.',
    `employee_group_code` STRING COMMENT 'Code identifying the employee group or division eligible for this benefit plan (e.g., corporate, retail, distribution center).',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Standard monetary amount the employer contributes per pay period for this benefit plan.',
    `enrollment_period_end_date` DATE COMMENT 'End date of the annual open enrollment period for this benefit plan.',
    `enrollment_period_start_date` DATE COMMENT 'Start date of the annual open enrollment period when employees can elect or change this benefit plan.',
    `is_aca_compliant` BOOLEAN COMMENT 'Indicates whether this benefit plan meets Affordable Care Act minimum essential coverage and affordability requirements.',
    `is_cobra_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan is subject to COBRA continuation coverage requirements.',
    `is_fsa_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan allows employees to contribute to a Flexible Spending Account for eligible expenses.',
    `is_hsa_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan qualifies as a high-deductible health plan eligible for Health Savings Account contributions.',
    `is_pre_tax_eligible` BOOLEAN COMMENT 'Indicates whether employee contributions to this benefit plan are eligible for pre-tax payroll deduction under IRS Section 125.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was last modified in the system.',
    `network_type` STRING COMMENT 'Type of provider network for health plans (PPO, HMO, EPO, POS, or indemnity).',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or administrative comments about the benefit plan.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount the employee will pay out-of-pocket in a plan year before the plan covers 100% of costs.',
    `plan_administrator_email` STRING COMMENT 'Email address of the plan administrator for employee inquiries and plan management.',
    `plan_administrator_name` STRING COMMENT 'Name of the individual or department responsible for administering this benefit plan.',
    `plan_administrator_phone` STRING COMMENT 'Phone number of the plan administrator for employee support and plan inquiries.',
    `plan_category` STRING COMMENT 'Broader classification grouping related benefit types for reporting and administration.',
    `plan_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the benefit plan in HR systems and employee communications.',
    `plan_document_url` STRING COMMENT 'URL or file path to the official plan document, summary plan description, or benefits guide.',
    `plan_name` STRING COMMENT 'Human-readable name of the benefit plan as displayed to employees and in HR documentation.',
    `plan_type` STRING COMMENT 'Category of benefit plan indicating the primary coverage area.',
    `plan_year_end_date` DATE COMMENT 'End date of the benefit plan year for coverage and contribution calculations.',
    `plan_year_start_date` DATE COMMENT 'Start date of the benefit plan year for coverage and contribution calculations.',
    `benefit_plan_status` STRING COMMENT 'Current lifecycle state of the benefit plan indicating availability for enrollment and administration.',
    `summary_plan_description` STRING COMMENT 'Brief textual summary of the benefit plan features, coverage, and key terms for employee communication.',
    `waiting_period_days` STRING COMMENT 'Number of days a new employee must wait before becoming eligible to enroll in this benefit plan.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by benefit_plan_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`course` (
    `course_id` BIGINT COMMENT 'Primary key for course',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the external training vendor in the procurement or vendor management system.',
    `prerequisite_course_id` BIGINT COMMENT 'Self-referencing FK on course (prerequisite_course_id)',
    `assessment_required` BOOLEAN COMMENT 'Indicates whether learners must complete a formal assessment or examination to pass the course.',
    `average_rating` DECIMAL(18,2) COMMENT 'The mean rating score provided by learners who have completed the course, typically on a 1-5 scale.',
    `course_category` STRING COMMENT 'Business classification grouping courses by subject area or functional domain.',
    `certification_awarded` BOOLEAN COMMENT 'Indicates whether successful completion of the course results in a formal certification.',
    `certification_name` STRING COMMENT 'The name of the certification awarded upon successful course completion, if applicable.',
    `certification_validity_months` STRING COMMENT 'The number of months the certification remains valid before renewal or recertification is required.',
    `compliance_framework` STRING COMMENT 'The regulatory or industry compliance framework that mandates this course (e.g., OSHA, SOX, GDPR).',
    `compliance_required` BOOLEAN COMMENT 'Indicates whether the course is mandatory for regulatory or organizational compliance purposes.',
    `content_owner` STRING COMMENT 'The name or identifier of the department, team, or individual responsible for course content and maintenance.',
    `content_url` STRING COMMENT 'The web address or link to access the course content in the learning management system or content repository.',
    `cost_per_learner` DECIMAL(18,2) COMMENT 'The standard cost charged or budgeted per learner for course delivery, in USD.',
    `course_code` STRING COMMENT 'Externally-known unique alphanumeric code for the course, used in catalogs and registration systems.',
    `course_type` STRING COMMENT 'Classification of the course delivery method and format.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the course record was first created in the system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'The number of continuing education or professional development credits awarded upon successful completion.',
    `delivery_method` STRING COMMENT 'The instructional delivery channel or platform through which the course is provided.',
    `course_description` STRING COMMENT 'Detailed narrative describing the course content, objectives, and learning outcomes.',
    `difficulty_level` STRING COMMENT 'The skill or knowledge level required or targeted by the course content.',
    `duration_hours` DECIMAL(18,2) COMMENT 'The total instructional time required to complete the course, measured in hours.',
    `effective_end_date` DATE COMMENT 'The date after which the course is no longer available for new enrollments or delivery.',
    `effective_start_date` DATE COMMENT 'The date from which the course becomes available for enrollment and delivery.',
    `is_mobile_compatible` BOOLEAN COMMENT 'Indicates whether the course content is accessible and optimized for mobile devices.',
    `language` STRING COMMENT 'The primary language in which the course content is delivered, using ISO 639-2 three-letter codes.',
    `last_review_date` DATE COMMENT 'The date when the course content was last reviewed for accuracy, relevance, and compliance.',
    `learning_objectives` STRING COMMENT 'Structured list of specific skills, knowledge, or competencies learners will acquire upon completion.',
    `max_enrollment` STRING COMMENT 'The maximum number of learners that can be enrolled in a single offering of the course.',
    `min_enrollment` STRING COMMENT 'The minimum number of learners required for a course offering to proceed.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the course record was last updated or modified.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of course content and relevance.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'The minimum percentage score required on assessments to successfully complete the course.',
    `prerequisites` STRING COMMENT 'Description of required prior knowledge, skills, or completed courses necessary before enrolling.',
    `retired_timestamp` TIMESTAMP COMMENT 'The date and time when the course was retired or archived from active use.',
    `short_title` STRING COMMENT 'Abbreviated or shortened version of the course title for display in constrained UI spaces.',
    `course_status` STRING COMMENT 'Current lifecycle state of the course indicating availability and operational readiness.',
    `tags` STRING COMMENT 'Comma-separated keywords or labels used for course search, filtering, and categorization.',
    `target_audience` STRING COMMENT 'Description of the intended learner population or job roles for which the course is designed.',
    `thumbnail_url` STRING COMMENT 'The web address of the course thumbnail or preview image used in catalogs and search results.',
    `title` STRING COMMENT 'The official name or title of the course as displayed to learners and in catalogs.',
    `version` STRING COMMENT 'The version number of the course content, used to track revisions and updates.',
    CONSTRAINT pk_course PRIMARY KEY(`course_id`)
) COMMENT 'Master reference table for course. Referenced by course_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`department` (
    `department_id` BIGINT COMMENT 'Primary key for department',
    `division_id` BIGINT COMMENT 'Reference to the business division to which this department belongs. Used for high-level organizational segmentation and financial reporting.',
    `location_id` BIGINT COMMENT 'Reference to the primary physical location or facility where this department operates. Used for workforce planning, space management, and logistics.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who serves as the department manager or head. Used for organizational hierarchy, approval workflows, and reporting lines.',
    `parent_department_id` BIGINT COMMENT 'Reference to the parent department in the organizational hierarchy. Enables multi-level department structures and roll-up reporting. Null for top-level departments.',
    `budget_amount_annual` DECIMAL(18,2) COMMENT 'Total annual operating budget allocated to this department in the organizations base currency. Includes payroll, operating expenses, and capital expenditures.',
    `cost_center_code` STRING COMMENT 'Financial accounting code used to track expenses and budget allocation for this department. Links to general ledger and financial planning systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this department record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the departments budget and financial reporting. Typically matches the currency of the departments primary location.',
    `department_code` STRING COMMENT 'Short alphanumeric code used to identify the department in business operations and reporting. Typically used in payroll, time tracking, and financial systems.',
    `department_type` STRING COMMENT 'Classification of the department based on its primary function within the organization. Distinguishes between corporate functions, retail operations, distribution centers, manufacturing facilities, and support services.',
    `department_description` STRING COMMENT 'Detailed description of the departments purpose, responsibilities, and scope of operations within the organization.',
    `effective_end_date` DATE COMMENT 'Date when this department ceased operations or when the current configuration ended. Null for currently active departments. Used for historical analysis and organizational restructuring tracking.',
    `effective_start_date` DATE COMMENT 'Date when this department became operational or when the current configuration became effective. Used for historical tracking and organizational change management.',
    `headcount_actual` STRING COMMENT 'Current number of active employees assigned to this department. Used for staffing analysis and variance reporting against planned headcount.',
    `headcount_planned` STRING COMMENT 'Approved number of full-time equivalent positions budgeted for this department. Used for workforce planning and budget management.',
    `is_customer_facing` BOOLEAN COMMENT 'Indicates whether this department has direct customer interaction. True for retail associates, customer service, and sales; false for back-office functions.',
    `is_revenue_generating` BOOLEAN COMMENT 'Indicates whether this department directly generates revenue for the organization. True for retail stores, sales teams, and e-commerce; false for support functions like HR, IT, and finance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this department record was last updated. Used for change tracking, audit compliance, and data synchronization.',
    `department_name` STRING COMMENT 'Full official name of the department as recognized in organizational structure and human resources systems.',
    `requires_seasonal_staffing` BOOLEAN COMMENT 'Indicates whether this department requires seasonal or temporary workforce augmentation during peak periods such as holidays, back-to-school, or fashion season launches.',
    `safety_certification_required` BOOLEAN COMMENT 'Indicates whether employees in this department must complete safety training and certification. Typically true for distribution centers, manufacturing, and warehouse operations.',
    `short_name` STRING COMMENT 'Abbreviated or shortened name of the department used in reports, dashboards, and user interfaces where space is limited.',
    `department_status` STRING COMMENT 'Current operational status of the department in the organizational hierarchy. Active departments are fully operational, inactive are temporarily non-operational, suspended are under review, planned are future departments, and closed are permanently discontinued.',
    `union_representation_flag` BOOLEAN COMMENT 'Indicates whether employees in this department are represented by a labor union or collective bargaining agreement. Used for labor relations, contract compliance, and workforce planning.',
    `work_schedule_type` STRING COMMENT 'Primary work schedule pattern for employees in this department. Standard for 9-5 office work, shift for retail and distribution centers, flexible for variable hours, remote for work-from-home, hybrid for mixed office/remote, and on-call for emergency response.',
    `workday_department_code` STRING COMMENT 'External identifier for this department in the Workday HCM system. Used for data integration, synchronization, and cross-system reconciliation between the lakehouse and the source HR system.',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Master reference table for department. Referenced by department_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`role` (
    `role_id` BIGINT COMMENT 'Primary key for role',
    `cost_center_id` BIGINT COMMENT 'Reference to the financial cost center that budgets and tracks expenses for employees in this role.',
    `department_id` BIGINT COMMENT 'Reference to the primary department or organizational unit where this role is typically positioned.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this role definition or most recent changes.',
    `reports_to_role_id` BIGINT COMMENT 'Reference to the supervisory role that this role typically reports to in the organizational hierarchy. Nullable for executive roles.',
    `approval_status` STRING COMMENT 'Current approval workflow state for new or modified role definitions.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this role definition was approved through the governance workflow.',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether employees in this role are eligible for performance-based bonus compensation.',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether employees in this role are eligible for sales commission or incentive compensation.',
    `compensation_band_maximum` DECIMAL(18,2) COMMENT 'Maximum salary or hourly wage for this role within the established compensation structure.',
    `compensation_band_minimum` DECIMAL(18,2) COMMENT 'Minimum salary or hourly wage for this role within the established compensation structure.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation band values.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this role record was first created in the system.',
    `role_description` STRING COMMENT 'Comprehensive narrative describing the purpose, scope, and key responsibilities of the role.',
    `effective_end_date` DATE COMMENT 'Date when this role definition was retired or superseded. Null for currently active roles.',
    `effective_start_date` DATE COMMENT 'Date when this role definition became active and available for employee assignment.',
    `employment_type` STRING COMMENT 'Standard employment classification indicating expected work schedule and duration for this role.',
    `flsa_classification` STRING COMMENT 'Classification under US labor law determining overtime eligibility and wage requirements.',
    `headcount_target` STRING COMMENT 'Planned number of employees to be assigned to this role across the organization for workforce planning purposes.',
    `is_customer_facing` BOOLEAN COMMENT 'Indicates whether the role involves direct interaction with external customers, used for training and performance management.',
    `is_safety_sensitive` BOOLEAN COMMENT 'Indicates whether the role involves responsibilities that could impact workplace safety, requiring additional screening or compliance measures.',
    `is_seasonal` BOOLEAN COMMENT 'Indicates whether this role is typically filled on a seasonal basis to support peak business periods such as holiday retail seasons.',
    `job_grade` STRING COMMENT 'Compensation grade level assigned to the role for salary band determination and career progression mapping.',
    `job_level` STRING COMMENT 'Numeric representation of the roles hierarchical position within the organization, used for reporting structure and career pathing.',
    `key_responsibilities` STRING COMMENT 'Detailed list of primary duties and accountabilities expected from individuals in this role.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this role record was most recently updated.',
    `last_reviewed_date` DATE COMMENT 'Date when this role definition was last reviewed for accuracy and relevance by HR or management.',
    `minimum_education_level` STRING COMMENT 'Lowest level of formal education required for eligibility to hold this role.',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for this role.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this role definition to ensure continued alignment with business needs.',
    `physical_requirements` STRING COMMENT 'Description of physical demands and working conditions associated with the role, including lifting, standing, or environmental factors.',
    `preferred_qualifications` STRING COMMENT 'Additional desirable qualifications that enhance candidate suitability but are not mandatory for the role.',
    `required_qualifications` STRING COMMENT 'Mandatory education, certifications, experience, and skills necessary to perform the role successfully.',
    `role_code` STRING COMMENT 'Unique business identifier code for the role used across HR systems and organizational charts.',
    `role_family` STRING COMMENT 'High-level categorization grouping similar roles together for workforce planning and talent management purposes.',
    `role_type` STRING COMMENT 'Classification indicating the level of leadership responsibility and organizational hierarchy position.',
    `role_status` STRING COMMENT 'Current lifecycle state of the role indicating whether it is available for assignment, retired, or awaiting approval.',
    `title` STRING COMMENT 'Official job title or role name as displayed on organizational charts, job postings, and employee records.',
    `travel_requirement_percentage` DECIMAL(18,2) COMMENT 'Expected percentage of work time requiring business travel, used for candidate expectations and expense planning.',
    `work_location_type` STRING COMMENT 'Indicates whether the role requires physical presence at a company location, can be performed remotely, or follows a hybrid model.',
    CONSTRAINT pk_role PRIMARY KEY(`role_id`)
) COMMENT 'Master reference table for role. Referenced by role_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` (
    `shift_swap_request_id` BIGINT COMMENT 'Primary key for shift_swap_request',
    `department_id` BIGINT COMMENT 'Department or functional area within the location where the shift swap applies (e.g., sales floor, stockroom, customer service).',
    `employee_id` BIGINT COMMENT 'Store manager or supervisor responsible for reviewing and approving the shift swap request.',
    `shift_id` BIGINT COMMENT 'The shift assignment that the requesting employee wants to swap away from.',
    `proposed_shift_id` BIGINT COMMENT 'The shift assignment that the requesting employee is willing to take in exchange. May be null for one-way swap requests.',
    `requesting_employee_id` BIGINT COMMENT 'Employee who is initiating the shift swap request and seeking to exchange their assigned shift.',
    `retail_store_id` BIGINT COMMENT 'Retail store or distribution center location where the shift swap would occur.',
    `target_employee_id` BIGINT COMMENT 'Employee who is being asked to swap shifts with the requesting employee. May be null if request is open to any qualified employee.',
    `counterpart_shift_swap_request_id` BIGINT COMMENT 'Self-referencing FK on shift_swap_request (counterpart_shift_swap_request_id)',
    `cancellation_reason` STRING COMMENT 'Explanation provided by the requesting employee for why they cancelled the shift swap request.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the shift swap request was cancelled by the requesting employee. Null if not cancelled.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the shift swap was fully executed and schedule changes were finalized. Null until completed.',
    `compliance_check_status` STRING COMMENT 'Status of automated compliance validation ensuring the swap meets labor law requirements (rest periods, maximum hours, etc.).',
    `compliance_violation_notes` STRING COMMENT 'Details of any labor compliance violations detected during automated validation of the shift swap request.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shift swap request record was first created in the system.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the shift swap request will automatically expire if not acted upon.',
    `impacts_overtime` BOOLEAN COMMENT 'Indicates whether approving this shift swap would result in overtime hours for either employee involved.',
    `is_reciprocal_swap` BOOLEAN COMMENT 'Indicates whether this is a mutual two-way swap where both employees exchange shifts, versus a one-way coverage request.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this shift swap request record was most recently updated.',
    `manager_approval_status` STRING COMMENT 'Whether the manager has approved, rejected, or not yet reviewed the shift swap request.',
    `manager_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the manager approved or rejected the shift swap request. Null if pending manager review.',
    `manager_notes` STRING COMMENT 'Comments or feedback provided by the approving manager regarding their decision on the swap request.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether notification has been sent to the target employee and manager about this swap request.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when notification was sent to relevant parties about the shift swap request.',
    `priority_level` STRING COMMENT 'Priority classification of the shift swap request based on urgency and business impact.',
    `reason_description` STRING COMMENT 'Detailed explanation provided by the requesting employee for why they need to swap shifts.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the shift swap request, formatted as SSR-YYYYMMDD sequence.',
    `request_status` STRING COMMENT 'Current lifecycle status of the shift swap request in the approval workflow.',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the shift swap request was originally submitted by the requesting employee.',
    `request_type` STRING COMMENT 'Classification of swap request: direct (specific employee targeted), open (any qualified employee), or partial (portion of shift).',
    `requires_seniority_match` BOOLEAN COMMENT 'Indicates whether the target employee must have comparable seniority level for the swap to be approved.',
    `requires_skill_match` BOOLEAN COMMENT 'Indicates whether the target employee must possess the same skills or certifications as the requesting employee for the swap to be valid.',
    `swap_reason_code` STRING COMMENT 'Categorized reason why the employee is requesting the shift swap.',
    `system_source` STRING COMMENT 'The system or channel through which the shift swap request was submitted (Workday HCM, mobile app, web portal).',
    `target_response_status` STRING COMMENT 'Whether the target employee has accepted, declined, or not yet responded to the swap request.',
    `target_response_timestamp` TIMESTAMP COMMENT 'Date and time when the target employee accepted or declined the swap request. Null if no response yet.',
    CONSTRAINT pk_shift_swap_request PRIMARY KEY(`shift_swap_request_id`)
) COMMENT 'Master reference table for shift_swap_request. Referenced by shift_swap_request_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`job_family` (
    `job_family_id` BIGINT COMMENT 'Primary key for job_family',
    `competency_model_id` BIGINT COMMENT 'Reference to the competency model or framework that defines the skills, knowledge, and behaviors required for success in this job family.',
    `parent_job_family_id` BIGINT COMMENT 'Reference to a parent job family in a hierarchical job family structure, enabling multi-level organizational taxonomy.',
    `bonus_eligible` BOOLEAN COMMENT 'Flag indicating whether positions in this job family are typically eligible for performance-based bonus or incentive compensation.',
    `career_path_type` STRING COMMENT 'The typical career progression model for this job family, indicating whether roles follow an individual contributor, management, or dual-track advancement path.',
    `job_family_category` STRING COMMENT 'High-level categorization of the job family by business function or operational area within the apparel and fashion organization.',
    `job_family_code` STRING COMMENT 'Unique alphanumeric code representing the job family, used for external identification and integration with payroll and HR systems.',
    `commission_eligible` BOOLEAN COMMENT 'Flag indicating whether positions in this job family are eligible for commission-based compensation, common in sales and retail roles.',
    `compensation_grade_maximum` STRING COMMENT 'The maximum compensation grade or pay band associated with this job family, defining the upper limit of compensation progression.',
    `compensation_grade_minimum` STRING COMMENT 'The minimum compensation grade or pay band associated with this job family, used for salary structure and equity analysis.',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this job family record, supporting audit and accountability requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this job family record was first created in the system, used for audit trail and data lineage tracking.',
    `critical_skill_indicator` BOOLEAN COMMENT 'Flag indicating whether this job family represents critical skills or hard-to-fill positions requiring specialized talent acquisition strategies.',
    `job_family_description` STRING COMMENT 'Detailed description of the job family, including the nature of work, typical responsibilities, and scope of roles included within this family.',
    `eeo_category` STRING COMMENT 'The Equal Employment Opportunity job category used for regulatory reporting and workforce diversity analysis.',
    `effective_end_date` DATE COMMENT 'The date when this job family definition is no longer active, used for historical tracking and workforce analytics. Null indicates the job family is currently active.',
    `effective_start_date` DATE COMMENT 'The date when this job family definition became or will become active and available for use in workforce planning and hiring.',
    `flsa_classification` STRING COMMENT 'The Fair Labor Standards Act classification indicating whether roles in this job family are typically exempt or non-exempt from overtime pay requirements.',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this job family record, supporting change management and audit requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this job family record was last updated, used for change tracking and data quality monitoring.',
    `level_range_maximum` STRING COMMENT 'The maximum job level or grade associated with positions in this job family, defining the career ceiling within this family.',
    `level_range_minimum` STRING COMMENT 'The minimum job level or grade associated with positions in this job family, used for compensation and career progression planning.',
    `job_family_name` STRING COMMENT 'The official name of the job family, representing a group of related jobs with similar work content and skill requirements.',
    `remote_work_eligible` BOOLEAN COMMENT 'Flag indicating whether positions in this job family are eligible for remote or hybrid work arrangements.',
    `seasonal_indicator` BOOLEAN COMMENT 'Flag indicating whether this job family typically includes seasonal or temporary positions, common in retail and distribution operations during peak periods.',
    `source_system` STRING COMMENT 'The name or identifier of the source system from which this job family record originated, typically Workday HCM, used for data lineage and integration tracking.',
    `source_system_code` STRING COMMENT 'The unique identifier for this job family in the source system, used for reconciliation and bidirectional synchronization with Workday HCM.',
    `job_family_status` STRING COMMENT 'Current lifecycle status of the job family indicating whether it is actively used for workforce planning and hiring.',
    `stock_option_eligible` BOOLEAN COMMENT 'Flag indicating whether positions in this job family are eligible for equity compensation such as stock options or restricted stock units.',
    `succession_planning_priority` STRING COMMENT 'The priority level assigned to this job family for succession planning and leadership development initiatives.',
    `travel_requirement_percentage` STRING COMMENT 'The typical percentage of time employees in this job family are expected to travel for business purposes, expressed as an integer from 0 to 100.',
    `typical_education_requirement` STRING COMMENT 'The typical minimum education level required or preferred for positions within this job family.',
    `typical_experience_years` STRING COMMENT 'The typical number of years of relevant work experience required or preferred for entry into this job family.',
    `union_eligible` BOOLEAN COMMENT 'Flag indicating whether positions in this job family are eligible for union membership or collective bargaining representation.',
    CONSTRAINT pk_job_family PRIMARY KEY(`job_family_id`)
) COMMENT 'Master reference table for job_family. Referenced by job_family_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`budget_period` (
    `budget_period_id` BIGINT COMMENT 'Primary key for budget_period',
    `parent_period_id` BIGINT COMMENT 'Reference to the parent budget period in a hierarchical structure (e.g., a quarterly period may reference its parent annual period).',
    `prior_budget_period_id` BIGINT COMMENT 'Self-referencing FK on budget_period (prior_budget_period_id)',
    `approval_status` STRING COMMENT 'Approval workflow status indicating whether the budget period has been reviewed and approved by management.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this budget period.',
    `approved_date` DATE COMMENT 'The date when the budget period was formally approved by authorized management.',
    `budget_version` STRING COMMENT 'Version identifier for the budget associated with this period, supporting multiple budget scenarios (e.g., Original, Revised, Forecast).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget period record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget amounts in this period (e.g., USD, EUR, GBP).',
    `budget_period_description` STRING COMMENT 'Detailed description or notes about this budget period, including special considerations, planning assumptions, or business context.',
    `duration_days` STRING COMMENT 'The total number of calendar days in this budget period.',
    `end_date` DATE COMMENT 'The effective end date when this budget period concludes (inclusive).',
    `fiscal_month` STRING COMMENT 'The fiscal month within the fiscal year (1-12), if applicable to this budget period type.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the fiscal year (1-4), if applicable to this budget period type.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget period belongs (e.g., 2024).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this budget period is currently active and available for use in budget planning and tracking processes.',
    `is_current` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active budget period for operational planning and tracking.',
    `is_locked` BOOLEAN COMMENT 'Boolean flag indicating whether this budget period is locked and cannot be modified.',
    `lock_date` DATE COMMENT 'The date when this budget period was locked to prevent further modifications, typically after approval or period close.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget period record was last modified.',
    `period_code` STRING COMMENT 'Business identifier code for the budget period, used for external reference and reporting (e.g., FY2024Q1, BP2024H1).',
    `period_name` STRING COMMENT 'Human-readable name of the budget period (e.g., Fiscal Year 2024 Quarter 1, Spring 2024 Budget Cycle).',
    `period_type` STRING COMMENT 'Classification of the budget period by duration and recurrence pattern.',
    `planning_cycle` STRING COMMENT 'The name or identifier of the broader planning cycle or budget process to which this period belongs (e.g., Annual Operating Plan 2024, Mid-Year Reforecast).',
    `reporting_entity` STRING COMMENT 'The organizational entity or business unit for which this budget period applies (e.g., Corporate, North America Region, Retail Division).',
    `sort_order` STRING COMMENT 'Numeric value used to control the display order of budget periods in reports and user interfaces.',
    `start_date` DATE COMMENT 'The effective start date when this budget period begins (inclusive).',
    `budget_period_status` STRING COMMENT 'Current lifecycle status of the budget period indicating whether it is in planning, active use, or historical state.',
    CONSTRAINT pk_budget_period PRIMARY KEY(`budget_period_id`)
) COMMENT 'Master reference table for budget_period. Referenced by budget_period_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`pay_period` (
    `pay_period_id` BIGINT COMMENT 'Primary key for pay_period',
    `prior_pay_period_id` BIGINT COMMENT 'Self-referencing FK on pay_period (prior_pay_period_id)',
    `calendar_month` STRING COMMENT 'The calendar month (1-12) in which the pay period primarily falls.',
    `calendar_year` STRING COMMENT 'The calendar year in which this pay period falls (e.g., 2024).',
    `check_date` DATE COMMENT 'The date printed on physical paychecks or used as the effective date for direct deposits.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when this pay period was officially closed and locked for further time entry or changes.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the jurisdiction where this pay period applies (e.g., USA, CAN, GBR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pay period record was first created in the system.',
    `end_date` DATE COMMENT 'The last calendar date included in this pay period.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) to which this pay period belongs.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this pay period belongs (e.g., 2024).',
    `is_adjustment_period` BOOLEAN COMMENT 'Boolean flag indicating whether this pay period is designated for payroll adjustments or corrections (True/False).',
    `is_current` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active pay period (True/False).',
    `is_year_end` BOOLEAN COMMENT 'Boolean flag indicating whether this is the final pay period of the fiscal or calendar year (True/False).',
    `legal_entity_code` STRING COMMENT 'Code identifying the legal entity or subsidiary to which this pay period applies.',
    `locked_timestamp` TIMESTAMP COMMENT 'Timestamp when this pay period was locked for audit or compliance purposes, preventing any further modifications.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pay period record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about this pay period (e.g., special processing instructions, holiday impacts).',
    `pay_frequency_type` STRING COMMENT 'The frequency at which employees are paid during this period (weekly, bi-weekly, semi-monthly, monthly).',
    `pay_group_code` STRING COMMENT 'Code identifying the pay group or employee population to which this pay period applies (e.g., RETAIL, CORPORATE, DC).',
    `pay_period_name` STRING COMMENT 'Human-readable name or label for the pay period (e.g., PP01-2024, January 2024 - Period 1).',
    `pay_period_number` STRING COMMENT 'Sequential number of the pay period within the fiscal or calendar year (e.g., 1, 2, 3...26 for bi-weekly).',
    `payment_date` DATE COMMENT 'The date on which employees are paid for this pay period.',
    `payroll_processing_date` DATE COMMENT 'The date on which payroll calculations and processing are executed for this pay period.',
    `start_date` DATE COMMENT 'The first calendar date included in this pay period.',
    `pay_period_status` STRING COMMENT 'Current lifecycle status of the pay period (open for time entry, in-progress for payroll processing, closed after payment, locked for audit, archived).',
    `time_zone` STRING COMMENT 'The time zone in which this pay period operates (e.g., America/New_York, America/Los_Angeles).',
    `timesheet_due_date` DATE COMMENT 'The deadline by which employees must submit timesheets for this pay period.',
    `total_days` STRING COMMENT 'The total number of calendar days in this pay period.',
    `working_days` STRING COMMENT 'The number of standard working days (excluding weekends and holidays) in this pay period.',
    CONSTRAINT pk_pay_period PRIMARY KEY(`pay_period_id`)
) COMMENT 'Master reference table for pay_period. Referenced by pay_period_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`location` (
    `location_id` BIGINT COMMENT 'Primary key for location',
    `parent_location_id` BIGINT COMMENT 'Self-referencing FK on location (parent_location_id)',
    `accessibility_features` STRING COMMENT 'Description of accessibility features available at the location (e.g., wheelchair access, elevators, accessible restrooms). Supports ADA compliance and inclusive workplace practices.',
    `address_line_1` STRING COMMENT 'Primary street address line for the location (street number, street name, building name). Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line for the location (suite, floor, unit, apartment). Organizational contact data classified as confidential.',
    `city` STRING COMMENT 'City or municipality where the location is situated. Organizational contact data classified as confidential.',
    `closing_date` DATE COMMENT 'Date when the location permanently ceased operations. Null for active locations.',
    `cost_center_code` STRING COMMENT 'Financial cost center code associated with the location for accounting and budget allocation purposes.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the location is situated (e.g., USA, GBR, FRA, CHN, IND).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for financial transactions at this location (e.g., USD, GBP, EUR, CNY).',
    `district` STRING COMMENT 'Business district or sub-region within a region to which the location belongs. Used for district manager assignments and localized operations.',
    `email_address` STRING COMMENT 'Primary contact email address for the location. Organizational contact data classified as confidential.',
    `is_seasonal` BOOLEAN COMMENT 'Indicates whether the location operates on a seasonal basis (e.g., pop-up stores, seasonal outlets). True if seasonal, False if year-round.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection conducted at the location.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the location in decimal degrees. Used for mapping, logistics routing, and proximity analytics.',
    `lease_end_date` DATE COMMENT 'Date when the lease agreement for the location expires. Applicable only to leased locations. Used for lease renewal planning.',
    `lease_or_owned` STRING COMMENT 'Indicates whether the location is leased, owned, or subleased by the organization.',
    `lease_start_date` DATE COMMENT 'Date when the lease agreement for the location became effective. Applicable only to leased locations.',
    `location_code` STRING COMMENT 'Externally-known unique business identifier for the location (e.g., store code, warehouse code, office code). Used for operational reference and reporting.',
    `location_name` STRING COMMENT 'Human-readable name of the location (e.g., Manhattan Flagship Store, Portland Distribution Center, Corporate Headquarters).',
    `location_status` STRING COMMENT 'Current operational status of the location in its lifecycle.',
    `location_type` STRING COMMENT 'Classification of the location by its primary business function within the apparel and fashion operations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the location in decimal degrees. Used for mapping, logistics routing, and proximity analytics.',
    `manager_employee_id` BIGINT COMMENT 'Employee identifier of the location manager or site lead responsible for day-to-day operations.',
    `monthly_rent_amount` DECIMAL(18,2) COMMENT 'Monthly rent payment amount for leased locations in the locations local currency. Used for financial planning and cost allocation.',
    `next_inspection_date` DATE COMMENT 'Scheduled date for the next safety or compliance inspection at the location.',
    `opening_date` DATE COMMENT 'Date when the location first opened for business operations.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the location (e.g., Mon-Fri 9:00-18:00, Mon-Sat 10:00-21:00, Sun 11:00-19:00). Used for staffing and customer communication.',
    `parking_spaces` STRING COMMENT 'Number of parking spaces available at the location for employees and visitors.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the location. Organizational contact data classified as confidential.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the location address. Organizational contact data classified as confidential.',
    `region` STRING COMMENT 'Business region or geographic market segment to which the location belongs (e.g., North America, EMEA, Asia Pacific). Used for regional reporting and organizational hierarchy.',
    `safety_certification` STRING COMMENT 'Safety and compliance certifications held by the location (e.g., OSHA compliance, fire safety certification, building code compliance).',
    `seasonal_close_month` STRING COMMENT 'Month number (1-12) when a seasonal location typically closes for the off-season. Applicable only to seasonal locations.',
    `seasonal_open_month` STRING COMMENT 'Month number (1-12) when a seasonal location typically opens for operations. Applicable only to seasonal locations.',
    `seating_capacity` STRING COMMENT 'Maximum number of employees or workstations that can be accommodated at the location. Applicable to corporate offices and design studios.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the location in square feet. Used for capacity planning, lease management, and operational cost allocation.',
    `state_province` STRING COMMENT 'State, province, or region where the location is situated. Organizational contact data classified as confidential.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the location (e.g., America/New_York, Europe/London). Used for scheduling, payroll, and operational reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was last modified in the system. Used for audit trail and change tracking.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master reference table for location. Referenced by location_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`workforce`.`competency_model` (
    `competency_model_id` BIGINT COMMENT 'Primary key for competency_model',
    `parent_competency_model_id` BIGINT COMMENT 'Self-referencing FK on competency_model (parent_competency_model_id)',
    `approval_date` DATE COMMENT 'Date when the competency model was formally approved. Null if not yet approved.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the competency model before it can be activated.',
    `approved_by_employee_id` BIGINT COMMENT 'Reference to the executive or HR leader who approved this competency model for organizational use. Null if not yet approved.',
    `business_unit_id` BIGINT COMMENT 'Reference to the specific business unit or division this competency model is designed for. Null for enterprise-wide models.',
    `competency_count` STRING COMMENT 'Total number of individual competencies included in this competency model.',
    `created_by_employee_id` BIGINT COMMENT 'Reference to the employee who originally created this competency model record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this competency model record was first created in the system.',
    `competency_model_description` STRING COMMENT 'Detailed description of the competency model purpose, scope, and intended application within the organization.',
    `effective_end_date` DATE COMMENT 'Date when this competency model is no longer active. Null for open-ended models.',
    `effective_start_date` DATE COMMENT 'Date when this competency model becomes active and available for assignment to roles and employees.',
    `external_reference_url` STRING COMMENT 'Web link to external documentation, industry frameworks, or certification standards this competency model aligns with.',
    `is_global` BOOLEAN COMMENT 'Indicates whether this competency model applies globally across all regions or is region-specific.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this competency model is mandatory for all employees in the target audience or optional for development purposes.',
    `job_family_id` BIGINT COMMENT 'Reference to the job family this competency model is associated with for role-based competency mapping.',
    `job_level_id` BIGINT COMMENT 'Reference to the organizational job level (e.g., entry, mid, senior, executive) this model applies to.',
    `last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who last modified this competency model record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this competency model record was last updated.',
    `last_review_date` DATE COMMENT 'Date when the competency model was last reviewed for accuracy and relevance.',
    `model_code` STRING COMMENT 'Externally-known unique business identifier code for the competency model used in HR systems and documentation.',
    `model_name` STRING COMMENT 'Human-readable name of the competency model (e.g., Retail Store Manager Competencies, Distribution Center Leadership Model).',
    `model_type` STRING COMMENT 'Classification of the competency model by its primary focus area.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the competency model.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the competency model for internal reference.',
    `owner_employee_id` BIGINT COMMENT 'Reference to the HR business partner or talent management leader responsible for maintaining this competency model.',
    `parent_model_id` BIGINT COMMENT 'Reference to a parent or predecessor competency model if this model is derived from or supersedes another model. Null for standalone models.',
    `proficiency_scale_id` BIGINT COMMENT 'Reference to the proficiency rating scale used to assess competency levels within this model (e.g., 1-5 scale, beginner-expert).',
    `region_code` STRING COMMENT 'Three-letter ISO country code indicating the specific region this competency model applies to. Null for global models.',
    `review_frequency_months` STRING COMMENT 'Scheduled interval in months for periodic review and update of the competency model to ensure relevance (e.g., 12, 24).',
    `competency_model_status` STRING COMMENT 'Current lifecycle status of the competency model indicating whether it is available for use in talent management processes.',
    `target_audience` STRING COMMENT 'Primary employee population or workforce segment for which this competency model is designed.',
    `usage_count` STRING COMMENT 'Number of active employee assignments or job profiles currently using this competency model.',
    `version_number` STRING COMMENT 'Version identifier for the competency model to track revisions and updates over time (e.g., 1.0, 2.1).',
    CONSTRAINT pk_competency_model PRIMARY KEY(`competency_model_id`)
) COMMENT 'Master reference table for competency_model. Referenced by competency_model_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_department_id` FOREIGN KEY (`department_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_supervisor_position_id` FOREIGN KEY (`supervisor_position_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_talent_requisition_id` FOREIGN KEY (`talent_requisition_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`talent_requisition`(`talent_requisition_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ADD CONSTRAINT `fk_workforce_staffing_model_budget_period_id` FOREIGN KEY (`budget_period_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`budget_period`(`budget_period_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ADD CONSTRAINT `fk_workforce_staffing_model_job_family_id` FOREIGN KEY (`job_family_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`job_family`(`job_family_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ADD CONSTRAINT `fk_workforce_staffing_model_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ADD CONSTRAINT `fk_workforce_staffing_model_role_id` FOREIGN KEY (`role_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`role`(`role_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_department_id` FOREIGN KEY (`department_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_primary_shift_employee_id` FOREIGN KEY (`primary_shift_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_role_id` FOREIGN KEY (`role_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`role`(`role_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_swap_request_id` FOREIGN KEY (`shift_swap_request_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`shift_swap_request`(`shift_swap_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_pay_period_id` FOREIGN KEY (`pay_period_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`pay_period`(`pay_period_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_primary_time_employee_id` FOREIGN KEY (`primary_time_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_shift_assignment_id` FOREIGN KEY (`shift_assignment_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`shift_assignment`(`shift_assignment_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_work_location_org_unit_id` FOREIGN KEY (`work_location_org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_tertiary_leave_coverage_assigned_to_employee_id` FOREIGN KEY (`tertiary_leave_coverage_assigned_to_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_work_location_org_unit_id` FOREIGN KEY (`work_location_org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ADD CONSTRAINT `fk_workforce_talent_requisition_department_id` FOREIGN KEY (`department_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ADD CONSTRAINT `fk_workforce_talent_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ADD CONSTRAINT `fk_workforce_talent_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ADD CONSTRAINT `fk_workforce_talent_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ADD CONSTRAINT `fk_workforce_talent_requisition_quaternary_talent_approved_by_employee_id` FOREIGN KEY (`quaternary_talent_approved_by_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ADD CONSTRAINT `fk_workforce_talent_requisition_tertiary_talent_replacement_for_employee_id` FOREIGN KEY (`tertiary_talent_replacement_for_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_quaternary_performance_hr_business_partner_employee_id` FOREIGN KEY (`quaternary_performance_hr_business_partner_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_tertiary_performance_reviewing_manager_employee_id` FOREIGN KEY (`tertiary_performance_reviewing_manager_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_course_id` FOREIGN KEY (`course_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`course`(`course_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ADD CONSTRAINT `fk_workforce_labor_compliance_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ADD CONSTRAINT `fk_workforce_labor_compliance_event_location_org_unit_id` FOREIGN KEY (`location_org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ADD CONSTRAINT `fk_workforce_labor_compliance_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ADD CONSTRAINT `fk_workforce_labor_compliance_event_primary_labor_employee_id` FOREIGN KEY (`primary_labor_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ADD CONSTRAINT `fk_workforce_labor_compliance_event_quaternary_labor_remediation_owner_employee_id` FOREIGN KEY (`quaternary_labor_remediation_owner_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ADD CONSTRAINT `fk_workforce_labor_compliance_event_tertiary_labor_manager_employee_id` FOREIGN KEY (`tertiary_labor_manager_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`course` ADD CONSTRAINT `fk_workforce_course_prerequisite_course_id` FOREIGN KEY (`prerequisite_course_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`course`(`course_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_location_id` FOREIGN KEY (`location_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_parent_department_id` FOREIGN KEY (`parent_department_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`role` ADD CONSTRAINT `fk_workforce_role_department_id` FOREIGN KEY (`department_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`role` ADD CONSTRAINT `fk_workforce_role_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`role` ADD CONSTRAINT `fk_workforce_role_reports_to_role_id` FOREIGN KEY (`reports_to_role_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`role`(`role_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` ADD CONSTRAINT `fk_workforce_shift_swap_request_department_id` FOREIGN KEY (`department_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` ADD CONSTRAINT `fk_workforce_shift_swap_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` ADD CONSTRAINT `fk_workforce_shift_swap_request_requesting_employee_id` FOREIGN KEY (`requesting_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` ADD CONSTRAINT `fk_workforce_shift_swap_request_target_employee_id` FOREIGN KEY (`target_employee_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` ADD CONSTRAINT `fk_workforce_shift_swap_request_counterpart_shift_swap_request_id` FOREIGN KEY (`counterpart_shift_swap_request_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`shift_swap_request`(`shift_swap_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_family` ADD CONSTRAINT `fk_workforce_job_family_competency_model_id` FOREIGN KEY (`competency_model_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`competency_model`(`competency_model_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_family` ADD CONSTRAINT `fk_workforce_job_family_parent_job_family_id` FOREIGN KEY (`parent_job_family_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`job_family`(`job_family_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`budget_period` ADD CONSTRAINT `fk_workforce_budget_period_parent_period_id` FOREIGN KEY (`parent_period_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`budget_period`(`budget_period_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`budget_period` ADD CONSTRAINT `fk_workforce_budget_period_prior_budget_period_id` FOREIGN KEY (`prior_budget_period_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`budget_period`(`budget_period_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`pay_period` ADD CONSTRAINT `fk_workforce_pay_period_prior_pay_period_id` FOREIGN KEY (`prior_pay_period_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`pay_period`(`pay_period_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ADD CONSTRAINT `fk_workforce_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`competency_model` ADD CONSTRAINT `fk_workforce_competency_model_parent_competency_model_id` FOREIGN KEY (`parent_competency_model_id`) REFERENCES `apparel_fashion_ecm`.`workforce`.`competency_model`(`competency_model_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `apparel_fashion_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `eeo_classification` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Classification');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on-leave|suspended|terminated');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full-time|part-time|seasonal|contractor|temporary|intern');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non-exempt');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `pay_currency` SET TAGS ('dbx_business_glossary_term' = 'Pay Currency');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `pay_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_value_regex' = 'hourly|salaried|commission|contract');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Preferred Name');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `rehire_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|retirement|end-of-contract|layoff');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `union_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Member Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent-resident|work-visa|pending|expired');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `work_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'retail-store|corporate-office|distribution-center|remote|field');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `workday_employee_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Human Capital Management (HCM) Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `workday_employee_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `workday_employee_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`employee` ALTER COLUMN `workday_employee_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Employee Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `supervisor_position_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Position Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `talent_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `annual_salary_max` SET TAGS ('dbx_business_glossary_term' = 'Annual Salary Maximum');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `annual_salary_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `annual_salary_min` SET TAGS ('dbx_business_glossary_term' = 'Annual Salary Minimum');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `annual_salary_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `eligible_for_bonus` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Bonus');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `eligible_for_commission` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Commission');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `is_critical_position` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Position');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `is_filled` SET TAGS ('dbx_business_glossary_term' = 'Is Position Filled');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `is_seasonal` SET TAGS ('dbx_business_glossary_term' = 'Is Seasonal Position');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'High School|Associate Degree|Bachelor Degree|Master Degree|Doctoral Degree|Professional Certification');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}[0-9]{1,2}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'Active|Frozen|Eliminated|Pending Approval');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'Regular|Temporary|Contract|Intern');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `remote_work_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `seasonal_end_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `seasonal_start_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `travel_requirement_pct` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `work_shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`position` ALTER COLUMN `work_shift` SET TAGS ('dbx_value_regex' = 'Day|Evening|Night|Rotating|Flexible');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `division_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `gl_segment` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Segment');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `gl_segment` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_capacity` SET TAGS ('dbx_business_glossary_term' = 'Headcount Capacity');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_seasonal` SET TAGS ('dbx_business_glossary_term' = 'Is Seasonal Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `labor_union_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Union Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `labor_union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|suspended|planned');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `sla_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `store_cluster_code` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `store_cluster_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = '^[A-Za-z/_]+$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `bonus_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `career_path_progression` SET TAGS ('dbx_business_glossary_term' = 'Career Path Progression');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Certifications Required');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `competency_requirements` SET TAGS ('dbx_business_glossary_term' = 'Competency Requirements');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `critical_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Role Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `education_level_required` SET TAGS ('dbx_business_glossary_term' = 'Education Level Required');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|temporary|contract|intern');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|archived');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_business_glossary_term' = 'Management Level');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_value_regex' = 'individual_contributor|people_manager|manager_of_managers|executive');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'hourly|weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}[0-9]{1,2}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Maximum');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_range_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Midpoint');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_range_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Minimum');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `physical_requirements` SET TAGS ('dbx_business_glossary_term' = 'Physical Requirements');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Description');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Name');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `seasonal_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Role Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `skill_requirements` SET TAGS ('dbx_business_glossary_term' = 'Skill Requirements');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `span_of_control_max` SET TAGS ('dbx_business_glossary_term' = 'Span of Control Maximum');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `span_of_control_min` SET TAGS ('dbx_business_glossary_term' = 'Span of Control Minimum');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `stock_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Stock Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `supervisory_organization` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Organization');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `union_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_profile` ALTER COLUMN `years_experience_required` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience Required');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `staffing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Staffing Model ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `budget_period_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Period ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `job_family_id` SET TAGS ('dbx_business_glossary_term' = 'Job Family ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `actual_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Coverage Ratio');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `headcount_variance` SET TAGS ('dbx_business_glossary_term' = 'Headcount Variance');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `labor_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `labor_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `labor_budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Currency');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `labor_budget_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Staffing Model Name');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Staffing Model Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'baseline|seasonal|expansion|reduction|peak_period|special_event');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Planning Notes');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `otb_headcount_budget` SET TAGS ('dbx_business_glossary_term' = 'Open-to-Buy (OTB) Headcount Budget');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `peak_end_date` SET TAGS ('dbx_business_glossary_term' = 'Peak End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `peak_period_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Peak Period Multiplier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `peak_start_date` SET TAGS ('dbx_business_glossary_term' = 'Peak Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_business_glossary_term' = 'Planning Scenario');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `ramp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Ramp End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `ramp_start_date` SET TAGS ('dbx_business_glossary_term' = 'Ramp Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `seasonal_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Adjustment Factor');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `target_headcount` SET TAGS ('dbx_business_glossary_term' = 'Target Headcount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `target_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Target Hours Per Week');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `workforce_segment` SET TAGS ('dbx_business_glossary_term' = 'Workforce Segment');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `workforce_segment` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|temporary|contractor|intern');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`staffing_model` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` SET TAGS ('dbx_subdomain' = 'time_scheduling');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `primary_shift_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `primary_shift_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `primary_shift_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_swap_request_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Swap Request Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `absence_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `attendance_status` SET TAGS ('dbx_value_regex' = 'present|absent|late|early_departure|no_call_no_show|excused');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration in Minutes');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `compliance_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `compliance_violation_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `compliance_violation_type` SET TAGS ('dbx_value_regex' = 'rest_period|max_hours|minor_labor|predictive_scheduling|other');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `early_departure_minutes` SET TAGS ('dbx_business_glossary_term' = 'Early Departure in Minutes');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `is_holiday_shift` SET TAGS ('dbx_business_glossary_term' = 'Is Holiday Shift Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `is_overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Overtime Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `is_seasonal_worker` SET TAGS ('dbx_business_glossary_term' = 'Is Seasonal Worker Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `labor_standard_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Standard Hours');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `pay_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `schedule_created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Schedule Created Date and Time');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `schedule_published_datetime` SET TAGS ('dbx_business_glossary_term' = 'Schedule Published Date and Time');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Notes');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_status` SET TAGS ('dbx_value_regex' = 'scheduled|confirmed|in_progress|completed|cancelled|no_show');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'opening|closing|mid|overnight|split|on_call');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `tardiness_minutes` SET TAGS ('dbx_business_glossary_term' = 'Tardiness in Minutes');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `time_clock_device_code` SET TAGS ('dbx_business_glossary_term' = 'Time Clock Device Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `time_clock_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `time_clock_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'time_scheduling');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `pay_period_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Period ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `shift_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_location_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration in Minutes');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock In Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock Out Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|pending_review|processed');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `is_holiday_worked` SET TAGS ('dbx_business_glossary_term' = 'Is Holiday Worked Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `is_manual_entry` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Entry Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `manual_entry_reason` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Reason');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `meal_break_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Meal Break Violation Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `rest_break_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Rest Break Violation Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `shift_differential_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_source` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Source');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_source` SET TAGS ('dbx_value_regex' = 'biometric|mobile_app|web_portal|manual|pos_terminal|kiosk');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_type` SET TAGS ('dbx_business_glossary_term' = 'Time Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`time_entry` ALTER COLUMN `total_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'time_scheduling');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_coverage_assigned_to_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assigned To Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_coverage_assigned_to_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_coverage_assigned_to_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `work_location_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `benefits_continuation_flag` SET TAGS ('dbx_business_glossary_term' = 'Benefits Continuation Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `certification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Due Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `coverage_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Coverage Plan Required');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Case Number');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_value_regex' = '^FMLA-[0-9]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_hours_used` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Hours Used');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `intermittent_frequency` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Frequency');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_fmla_qualifying` SET TAGS ('dbx_business_glossary_term' = 'Is FMLA (Family and Medical Leave Act) Qualifying');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_intermittent` SET TAGS ('dbx_business_glossary_term' = 'Is Intermittent Leave');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_paid_leave` SET TAGS ('dbx_business_glossary_term' = 'Is Paid Leave');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_seasonal_employee` SET TAGS ('dbx_business_glossary_term' = 'Is Seasonal Employee');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance After Request');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Before Request');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_subtype` SET TAGS ('dbx_business_glossary_term' = 'Leave Subtype');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `payroll_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Impact Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `reason_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{8}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `total_days_requested` SET TAGS ('dbx_business_glossary_term' = 'Total Days Requested');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`leave_request` ALTER COLUMN `total_hours_requested` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Requested');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `cost_center_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Allocation Method');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `cost_center_allocation_method` SET TAGS ('dbx_value_regex' = 'single|proportional|time_based|project_based');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|error');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `is_year_end_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Is Year-End Adjustment Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Notes');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|semi_monthly|monthly');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_group_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Group Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payment_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payment_batch_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{5,30}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|cash|paycard');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Number');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_type` SET TAGS ('dbx_value_regex' = 'regular|off_cycle|bonus|commission|adjustment|final');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `tax_jurisdiction_count` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Count');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Total Employee Count');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employee_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Employee Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Employer Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Pay Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Pay Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Overtime Hours');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_post_tax_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Post-Tax Deduction Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_pre_tax_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Pre-Tax Deduction Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_pto_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Time Off (PTO) Hours');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Regular Hours');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`payroll_run` ALTER COLUMN `w2_tax_year` SET TAGS ('dbx_business_glossary_term' = 'W-2 Tax Year');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `annual_review_month` SET TAGS ('dbx_business_glossary_term' = 'Annual Review Month');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Percentage');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compa_ratio` SET TAGS ('dbx_business_glossary_term' = 'Compa-Ratio');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `equity_grant_amount` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `equity_grant_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `equity_grant_eligible` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `merit_increase_eligible` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Notes');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|quarterly|annual');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Maximum');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_range_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Midpoint');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Minimum');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Name');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'base_salary|hourly_wage|commission_only|salary_plus_commission|salary_plus_bonus|contract');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `aca_affordability_safe_harbor` SET TAGS ('dbx_business_glossary_term' = 'ACA Affordability Safe Harbor');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `aca_affordability_safe_harbor` SET TAGS ('dbx_value_regex' = 'federal_poverty_line|rate_of_pay|w2_wages|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `aca_minimum_value_met_flag` SET TAGS ('dbx_business_glossary_term' = 'ACA Minimum Value Met Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Premium Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Count');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_confirmation_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Carrier Confirmation Received Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Member ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Notification Sent Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Carrier Notification Sent Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_election_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_qualifying_event` SET TAGS ('dbx_business_glossary_term' = 'COBRA Qualifying Event');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_qualifying_event` SET TAGS ('dbx_value_regex' = 'termination|reduction_hours|divorce|death|medicare_entitlement|dependent_loss');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_discount_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Discount Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Employee Discount Percentage');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_confirmation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Sent Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_confirmation_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Sent Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'employee_self_service|hr_representative|benefits_administrator|automated_renewal|edi_feed');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|waived|terminated|pending|suspended|cobra_active');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'new_hire|open_enrollment|qualifying_life_event|annual_renewal|cobra|special_enrollment');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `form_1095c_furnished_date` SET TAGS ('dbx_business_glossary_term' = 'Form 1095-C Furnished Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `form_1095c_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Form 1095-C Generated Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `payroll_deduction_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payroll Deduction Frequency');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `payroll_deduction_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `per_pay_period_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Per Pay Period Deduction Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `vesting_date` SET TAGS ('dbx_business_glossary_term' = 'Vesting Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `vesting_percentage` SET TAGS ('dbx_business_glossary_term' = 'Vesting Percentage');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Signed Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `talent_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Requisition ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `quaternary_talent_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `quaternary_talent_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `quaternary_talent_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `tertiary_talent_replacement_for_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement For Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `tertiary_talent_replacement_for_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `tertiary_talent_replacement_for_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `approved_headcount` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `diversity_initiative_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversity Initiative Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|casual|seasonal');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `is_remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Remote Eligible');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `job_posting_title` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Title');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'none|high_school|associate|bachelor|master|doctorate');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `positions_filled` SET TAGS ('dbx_business_glossary_term' = 'Positions Filled');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `requisition_close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{8}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `requisition_open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'new_position|replacement|seasonal|temporary|contract|intern');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `seasonal_campaign` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Campaign');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `sourcing_channel_strategy` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channel Strategy');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `target_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Target Fill Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`talent_requisition` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `quaternary_performance_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'HR Business Partner (HRBP) ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `quaternary_performance_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `quaternary_performance_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_reviewing_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Manager ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_reviewing_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_reviewing_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|pending|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_session_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Session Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_session_flag` SET TAGS ('dbx_business_glossary_term' = 'Calibration Session Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_communication_rating` SET TAGS ('dbx_business_glossary_term' = 'Competency Communication Rating');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_communication_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs_improvement|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Competency Leadership Rating');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_leadership_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs_improvement|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_teamwork_rating` SET TAGS ('dbx_business_glossary_term' = 'Competency Teamwork Rating');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_teamwork_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs_improvement|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_technical_rating` SET TAGS ('dbx_business_glossary_term' = 'Competency Technical Rating');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_technical_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs_improvement|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_plan_actions` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Actions');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgment_status` SET TAGS ('dbx_value_regex' = 'acknowledged|not_acknowledged|refused_to_sign');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finalized Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Percentage');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `incident_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_outcome` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Outcome');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_outcome` SET TAGS ('dbx_value_regex' = 'successful|unsuccessful|in_progress|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `policy_violated` SET TAGS ('dbx_business_glossary_term' = 'Policy Violated');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|finalized|archived');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`performance_review` ALTER COLUMN `termination_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination Recommended Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `learning_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Enrollment Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `attempts_count` SET TAGS ('dbx_business_glossary_term' = 'Attempts Count');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed|withdrawn|expired');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'harassment_prevention|workplace_safety|labor_standards|data_privacy|financial_compliance|product_safety');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'instructor_led|e_learning|blended|on_the_job|virtual_classroom|self_paced');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'manager_assigned|self_enrolled|hr_assigned|system_triggered|compliance_required|career_development');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `feedback_rating` SET TAGS ('dbx_business_glossary_term' = 'Feedback Rating');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `recertification_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Interval Months');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `waitlist_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` SET TAGS ('dbx_subdomain' = 'time_scheduling');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `labor_compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Compliance Event ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `location_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `quaternary_labor_remediation_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `quaternary_labor_remediation_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `quaternary_labor_remediation_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `tertiary_labor_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager ID');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `tertiary_labor_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `tertiary_labor_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `audit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `detected_by` SET TAGS ('dbx_business_glossary_term' = 'Detected By');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Type');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `remediation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completed Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|resolved|closed|escalated');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`labor_compliance_event` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`course` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`course` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`course` ALTER COLUMN `prerequisite_course_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`course` ALTER COLUMN `cost_per_learner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`department` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`department` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`department` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`role` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`role` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`role` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Identifier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`role` ALTER COLUMN `compensation_band_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`role` ALTER COLUMN `compensation_band_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`role` ALTER COLUMN `job_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` SET TAGS ('dbx_subdomain' = 'time_scheduling');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` ALTER COLUMN `shift_swap_request_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Swap Request Identifier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`shift_swap_request` ALTER COLUMN `counterpart_shift_swap_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_family` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`job_family` ALTER COLUMN `job_family_id` SET TAGS ('dbx_business_glossary_term' = 'Job Family Identifier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`budget_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`budget_period` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`budget_period` ALTER COLUMN `budget_period_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Identifier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`budget_period` ALTER COLUMN `prior_budget_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`pay_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`pay_period` SET TAGS ('dbx_subdomain' = 'time_scheduling');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`pay_period` ALTER COLUMN `pay_period_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Identifier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`pay_period` ALTER COLUMN `prior_pay_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `parent_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `monthly_rent_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`competency_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`competency_model` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`competency_model` ALTER COLUMN `competency_model_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Model Identifier');
ALTER TABLE `apparel_fashion_ecm`.`workforce`.`competency_model` ALTER COLUMN `parent_competency_model_id` SET TAGS ('dbx_self_ref_fk' = 'true');
