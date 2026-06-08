-- Schema for Domain: workforce | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`workforce` COMMENT 'SSOT for all human capital data including employee profiles, organizational hierarchy, payroll, benefits, driver certifications, warehouse labor scheduling, FTE planning, talent management, and workforce KPIs. Owns role-based competency records, DOT/ICAO crew qualification compliance, shift scheduling, and labor cost allocation. Powered by Workday HCM and supports operational labor planning across freight and fulfillment domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key sourced from Workday HCM. Serves as the single source of truth for worker identity across all Transport Shipping systems.',
    `manager_employee_id` BIGINT COMMENT 'Employee ID of the direct manager/supervisor to whom this employee reports. Establishes organizational hierarchy and reporting structure.',
    `background_check_date` DATE COMMENT 'Date of the most recent background check performed on the employee. Required for security compliance in logistics and supply chain operations.',
    `cost_center` STRING COMMENT 'Financial cost center code to which the employees labor costs are allocated. Used for P&L reporting, budget management, and financial analysis.. Valid values are `^[0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the system. Used for audit trail and data lineage tracking.',
    `customs_broker_license` STRING COMMENT 'License number for employees certified as customs brokers, authorized to clear goods through customs on behalf of importers/exporters. Required for customs brokerage operations.',
    `date_of_birth` DATE COMMENT 'Employees date of birth, used for age verification for regulatory compliance (e.g., DOT driver age requirements, ICAO crew qualifications) and benefits eligibility.',
    `department` STRING COMMENT 'Organizational department to which the employee is assigned (e.g., Express Parcel Delivery, Freight Forwarding, Warehouse Operations, Customs Brokerage, Finance, Human Resources).',
    `dot_medical_certification_date` DATE COMMENT 'Date of the most recent DOT medical examination certification for commercial drivers. Required for compliance with US DOT Federal Motor Carrier Safety Administration regulations.',
    `dot_medical_expiry_date` DATE COMMENT 'Expiration date of the employees DOT medical certification. Drivers must maintain valid medical certification to operate commercial vehicles.',
    `driver_license_expiry_date` DATE COMMENT 'Expiration date of the employees drivers license. Critical for DOT compliance monitoring and ensuring only qualified drivers operate vehicles.',
    `driver_license_number` STRING COMMENT 'Drivers license number for employees in driving roles (delivery drivers, freight drivers). Required for DOT compliance and fleet management.',
    `email_address` STRING COMMENT 'Primary corporate email address assigned to the employee for business communications. Primary contact channel for digital correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of employee emergency. Critical for employee safety and incident response.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact person. Used for urgent communications in case of workplace incidents or emergencies.',
    `employee_number` STRING COMMENT 'Human-readable business identifier for the employee, typically displayed on badges and used in operational systems. Externally-known unique code assigned at hire.. Valid values are `^[A-Z0-9]{6,12}$`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee within the organization. Indicates whether the employee is actively working, on leave, suspended, or separated from the company.. Valid values are `active|on_leave|suspended|terminated|retired|deceased`',
    `employment_type` STRING COMMENT 'Classification of the employees employment arrangement. Covers full-time, part-time, contract, temporary, seasonal, and intern workers including drivers, warehouse operatives, freight agents, customs brokers, and corporate staff.. Valid values are `full_time|part_time|contract|temporary|seasonal|intern`',
    `first_name` STRING COMMENT 'Legal first name of the employee as recorded in official employment documents and government identification.',
    `forklift_certification` BOOLEAN COMMENT 'Indicates whether the employee is certified to operate forklifts and material handling equipment in warehouse and distribution center operations.',
    `fte` DECIMAL(18,2) COMMENT 'Full-Time Equivalent designation representing the proportion of full-time work this employee performs (e.g., 1.00 for full-time, 0.50 for half-time). Used for workforce capacity planning and labor cost allocation.',
    `hazmat_certification` BOOLEAN COMMENT 'Indicates whether the employee holds valid hazardous materials handling certification, required for transporting dangerous goods per IMDG Code and ICAO Technical Instructions.',
    `hazmat_certification_expiry_date` DATE COMMENT 'Expiration date of the employees HAZMAT certification. Must be renewed periodically to maintain compliance with dangerous goods transport regulations.',
    `hire_date` DATE COMMENT 'Date the employee was hired and commenced employment with Transport Shipping. Used for tenure calculations, benefits eligibility, and seniority determination.',
    `job_code` STRING COMMENT 'Standardized code representing the job classification within the organizations job catalog. Used for compensation benchmarking, workforce planning, and organizational structure.. Valid values are `^[A-Z0-9]{4,10}$`',
    `job_family` STRING COMMENT 'Broad grouping of similar jobs (e.g., Operations, Transportation, Warehouse, Customer Service, Finance, IT) used for talent management and career pathing.',
    `job_level` STRING COMMENT 'Hierarchical level of the position within the organization, used for compensation bands, approval authorities, and organizational structure. [ENUM-REF-CANDIDATE: entry|intermediate|senior|lead|manager|director|executive — 7 candidates stripped; promote to reference product]',
    `job_title` STRING COMMENT 'Official job title assigned to the employee, reflecting their role and level within the organization (e.g., Freight Agent, Warehouse Operative, Customs Broker, Delivery Driver, Supply Chain Manager).',
    `last_name` STRING COMMENT 'Legal last name (surname/family name) of the employee as recorded in official employment documents and government identification.',
    `middle_name` STRING COMMENT 'Middle name or initial of the employee, if applicable, as recorded in official employment documents.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the employee, particularly important for field workers including drivers, warehouse operatives, and freight agents requiring real-time communication.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number in USA, National Insurance Number in UK) used for tax reporting and employment verification.',
    `passport_number` STRING COMMENT 'Passport number for employees requiring international travel for cross-border shipping operations, customs brokerage, or global freight forwarding assignments.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to the employees position, defining the salary range and compensation structure. Business-sensitive data used for compensation planning.. Valid values are `^[A-Z0-9]{2,6}$`',
    `pay_type` STRING COMMENT 'Method by which the employee is compensated (salary, hourly, commission, piece rate). Critical for payroll processing and labor cost calculation.. Valid values are `salary|hourly|commission|piece_rate`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee, used for operational communications and emergency contact.',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in day-to-day business interactions, which may differ from legal name.',
    `security_clearance_level` STRING COMMENT 'Level of security clearance granted to the employee for access to sensitive facilities, cargo, and information. Important for C-TPAT and AEO compliance.. Valid values are `none|basic|standard|enhanced|top_secret`',
    `termination_date` DATE COMMENT 'Date the employees employment ended, whether through resignation, retirement, or termination. Null for active employees.',
    `termination_reason` STRING COMMENT 'Reason for employment separation. Used for workforce analytics, turnover analysis, and compliance reporting.. Valid values are `resignation|retirement|layoff|termination_for_cause|end_of_contract|deceased`',
    `union_code` STRING COMMENT 'Code identifying the specific labor union to which the employee belongs, if applicable. Used for labor agreement compliance and union dues processing.',
    `union_membership` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union. Important for collective bargaining compliance, labor relations, and workforce management.',
    `work_city` STRING COMMENT 'City where the employees primary work location is situated. Used for geographic workforce distribution analysis and regional labor planning.',
    `work_country` STRING COMMENT 'Three-letter ISO country code representing the country where the employee primarily works. Used for regulatory compliance, tax reporting, and workforce analytics.. Valid values are `^[A-Z]{3}$`',
    `work_location` STRING COMMENT 'Primary physical work location or facility where the employee is based (e.g., warehouse, distribution center, office, terminal, depot). Critical for workforce scheduling and labor planning.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Core master record for all employees across Transport Shipping, serving as the SSOT for worker identity, employment status, job classification, and organizational placement. Sourced from Workday HCM and covers full-time, part-time, contract, and temporary workers including drivers, warehouse operatives, freight agents, customs brokers, and corporate staff. Captures personal details, employment type, hire/termination dates, work location, cost center assignment, and FTE designation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key for the org_unit product.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Organizational units operate under legal entities (company codes) for statutory reporting and intercompany transactions. Legal consolidation, tax jurisdiction assignment, and entity-level financial st',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Organizational units map to cost centers for financial reporting hierarchy. Budget allocation, cost center manager assignment, and consolidation reporting require this master data link between org str',
    `employee_id` BIGINT COMMENT 'Reference to the employee who manages this organizational unit. Used for reporting lines and approval workflows.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy. Enables multi-level organizational structure from enterprise down to team level.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Business units (org_units) are P&L responsible entities mapped to profit centers. Segment reporting, EBITDA analysis, and management accounting require linking organizational units to their profit cen',
    `program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Safety programs are scoped and managed by organizational units (department-level safety initiatives, regional compliance programs). Transport operations implement safety programs at business unit, reg',
    `budget_amount_annual` DECIMAL(18,2) COMMENT 'Annual operating budget allocated to this organizational unit in USD. Used for financial planning and variance analysis.',
    `business_unit_code` STRING COMMENT 'High-level business unit identifier for enterprise-wide segmentation and reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `compliance_framework` STRING COMMENT 'Primary regulatory or compliance framework applicable to this organizational unit (e.g., DOT, ICAO, GDPR, SOX). [ENUM-REF-CANDIDATE: DOT|ICAO|IMO|GDPR|SOX|C-TPAT|AEO|ISO_28000 — promote to reference product]',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the organizational unit operates. Used for regulatory compliance and labor law adherence.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial transactions and budget reporting for this organizational unit.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit was closed or became inactive. Null for currently active units.',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit became active and operational. Used for historical reporting and organizational change tracking.',
    `external_org_code` STRING COMMENT 'External system identifier for this organizational unit used in integrations with ERP, TMS, WMS, and other operational systems.',
    `functional_area` STRING COMMENT 'Primary business function or operational domain that this organizational unit supports within Transport Shipping. [ENUM-REF-CANDIDATE: freight_operations|warehouse_operations|fleet_management|customer_service|sales|finance|hr|it|legal|compliance — 10 candidates stripped; promote to reference product]',
    `headcount_actual` DECIMAL(18,2) COMMENT 'Current actual headcount for this organizational unit expressed in FTE. Calculated from active employee assignments.',
    `headcount_planned` DECIMAL(18,2) COMMENT 'Planned headcount for this organizational unit expressed in FTE. Used for workforce planning and budget allocation.',
    `hierarchy_level` STRING COMMENT 'Numeric level of this organizational unit within the enterprise hierarchy. Level 1 is enterprise root, higher numbers represent deeper nesting.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether labor costs from this organizational unit are billable to customers or treated as overhead.',
    `is_revenue_generating` BOOLEAN COMMENT 'Indicates whether this organizational unit directly generates revenue through customer-facing operations.',
    `location_code` STRING COMMENT 'Physical location or site code where this organizational unit is primarily based. Supports multi-site workforce planning.. Valid values are `^[A-Z]{3}[0-9]{3}$`',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this organizational unit record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified.',
    `operational_scope` STRING COMMENT 'Geographic scope of operations for this organizational unit. Determines reporting requirements and compliance frameworks.. Valid values are `global|regional|national|local`',
    `org_unit_code` STRING COMMENT 'Business identifier code for the organizational unit. Used for external reporting and integration with financial systems.. Valid values are `^[A-Z0-9]{3,20}$`',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units purpose, responsibilities, and scope of operations.',
    `org_unit_name` STRING COMMENT 'Full name of the organizational unit as displayed in business reports and organizational charts.',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. Active units are operational and can have employees assigned.. Valid values are `active|inactive|pending|closed`',
    `org_unit_type` STRING COMMENT 'Classification of the organizational unit indicating its level and function within the enterprise hierarchy.. Valid values are `division|department|cost_center|team|region|district`',
    `region_code` STRING COMMENT 'Geographic region code for multi-region organizational reporting and workforce planning.. Valid values are `^[A-Z]{2,5}$`',
    `short_name` STRING COMMENT 'Abbreviated name of the organizational unit for use in constrained display contexts and reports.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the organizational units primary operating location. Used for shift scheduling and labor planning.',
    `union_representation` STRING COMMENT 'Indicates whether employees in this organizational unit are represented by labor unions. Impacts labor relations and compliance.. Valid values are `unionized|non_unionized|mixed`',
    `created_by` STRING COMMENT 'User identifier of the person who created this organizational unit record.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational hierarchy master representing all business units, departments, cost centers, and operational divisions within Transport Shipping. Supports multi-level hierarchy from enterprise down to team level, enabling labor cost allocation, headcount reporting, and workforce planning across freight, warehouse, fleet, and corporate functions. Sourced from Workday HCM Supervisory Organization.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the authorized headcount position within the organizational structure. Primary key. Inferred role: MASTER_RESOURCE (authorized headcount position is a resource the business manages).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Positions are budgeted to cost centers for FTE planning and budget authorization. Headcount budget vs. actual reporting and position control require linking positions to their funding cost center.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Positions dedicated to specific suppliers (Key Account Manager - Carrier X, Supplier Relationship Manager - Vendor Y). Enables dedicated supplier relationship role tracking, vendor-specific position p',
    `job_profile_id` BIGINT COMMENT 'Reference to the standardized job profile that defines the roles responsibilities, competencies, and requirements. Links to the job catalog maintained in Workday HCM.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department or business unit to which this position belongs. Supports organizational hierarchy reporting.',
    `employee_id` BIGINT COMMENT 'The user ID of the HR administrator or system user who created this position record. Used for audit trail and accountability.',
    `position_last_modified_by_user_employee_id` BIGINT COMMENT 'The user ID of the HR administrator or system user who last modified this position record. Used for audit trail and change management.',
    `supervisor_position_id` BIGINT COMMENT 'Reference to the position that supervises this position, establishing the reporting line in the organizational hierarchy. Null for top-level executive positions.',
    `location_id` BIGINT COMMENT 'Reference to the primary physical work location for this position (e.g., warehouse, distribution center, office, terminal). Links to location master data.',
    `budget_authorization_date` DATE COMMENT 'The date on which this position was approved and authorized in the workforce budget. Used for headcount planning and financial tracking.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or operating division to which this position belongs (e.g., Express Parcel, Freight Forwarding, E-Commerce Fulfillment, Contract Logistics). Supports divisional reporting.. Valid values are `^[A-Z0-9]{2,8}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the positions work location (e.g., USA, GBR, DEU, CHN). Used for compliance with country-specific labor laws and reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this position record was first created in the Workday HCM system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'The date on which this position is scheduled to be closed or eliminated. Null for ongoing positions. Used for temporary or project-based positions.',
    `effective_start_date` DATE COMMENT 'The date from which this position becomes active and available for hiring or assignment. Supports workforce planning timelines.',
    `flsa_status` STRING COMMENT 'Classification under the Fair Labor Standards Act determining overtime eligibility. Exempt positions are salaried and not eligible for overtime; non-exempt positions are hourly and eligible for overtime pay.. Valid values are `exempt|non_exempt`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The authorized FTE allocation for this position, representing the proportion of a full-time workload (e.g., 1.00 for full-time, 0.50 for half-time). Used for workforce planning and labor cost budgeting.',
    `grade_level` STRING COMMENT 'The compensation grade or pay band assigned to this position, determining salary range and benefits eligibility. Aligns with organizational compensation structure.. Valid values are `^[A-Z0-9]{1,6}$`',
    `is_critical_role` BOOLEAN COMMENT 'Indicates whether this position is classified as business-critical, requiring priority succession planning and talent pipeline development. Typically includes key operational, compliance, and leadership roles.',
    `is_remote_eligible` BOOLEAN COMMENT 'Indicates whether this position is eligible for remote or hybrid work arrangements. Most logistics operational roles (warehouse, freight handling, driving) are not remote-eligible; corporate and support roles may be.',
    `is_safety_sensitive` BOOLEAN COMMENT 'Indicates whether this position is classified as safety-sensitive under DOT regulations, requiring enhanced screening, medical certification, and compliance monitoring (e.g., commercial drivers, hazmat handlers, aircraft loaders).',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles (e.g., Operations, Finance, IT, Customer Service, Warehouse, Transportation). Used for workforce segmentation and talent management.',
    `job_function` STRING COMMENT 'Specific functional area within the job family (e.g., Freight Forwarding, Last-Mile Delivery, Customs Brokerage, Warehouse Operations, Fleet Management). Enables detailed workforce analytics.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this position record was last updated in the Workday HCM system. Used for change tracking and audit compliance.',
    `minimum_education_level` STRING COMMENT 'The minimum educational qualification required for this position (e.g., High School Diploma, Associate Degree, Bachelors Degree, Masters Degree). Used for recruitment and talent acquisition.',
    `minimum_experience_years` STRING COMMENT 'The minimum number of years of relevant work experience required for this position. Used for recruitment screening and talent assessment.',
    `position_description` STRING COMMENT 'Detailed narrative description of the positions responsibilities, duties, and scope. Used for job postings, performance management, and organizational documentation.',
    `position_number` STRING COMMENT 'Externally-known unique business identifier for the position, used in HR systems and organizational charts. Typically alphanumeric code assigned by Workday HCM.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_status` STRING COMMENT 'Current lifecycle status of the position. Active positions are available for hiring or currently filled; frozen positions are temporarily suspended; closed positions are eliminated; pending approval positions await budget authorization.. Valid values are `active|frozen|closed|pending_approval`',
    `position_type` STRING COMMENT 'Classification of the position based on employment duration and nature. Regular positions are permanent; temporary and seasonal positions are time-limited; contract positions are for specific projects; intern positions are for training programs.. Valid values are `regular|temporary|seasonal|contract|intern`',
    `region_code` STRING COMMENT 'Code identifying the geographic region for this position (e.g., NAM for North America, EUR for Europe, APAC for Asia-Pacific). Used for regional workforce planning and reporting.. Valid values are `^[A-Z]{2,3}$`',
    `requires_customs_clearance` BOOLEAN COMMENT 'Indicates whether this position requires customs security clearance or background checks under C-TPAT or AEO programs due to access to secure cargo areas or trade compliance systems.',
    `requires_dot_certification` BOOLEAN COMMENT 'Indicates whether this position requires DOT certification (e.g., Commercial Drivers License for truck drivers, ICAO crew qualifications for air freight personnel).',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'The standard number of working hours per week for this position (e.g., 40.00 for full-time, 20.00 for part-time). Used for scheduling and labor cost calculations.',
    `time_type` STRING COMMENT 'Indicates whether the position is full-time or part-time based on standard working hours. Used for benefits eligibility and workforce planning.. Valid values are `full_time|part_time`',
    `title` STRING COMMENT 'Official job title for the position as defined in the organizational structure (e.g., Senior Warehouse Manager, Freight Operations Supervisor, Customs Compliance Analyst).',
    `travel_requirement_percentage` STRING COMMENT 'The expected percentage of work time requiring business travel (0-100). Relevant for field sales, regional operations managers, and compliance auditors.',
    `union_code` STRING COMMENT 'Code identifying the labor union representing this position, if applicable. Null for non-union positions. Used for collective bargaining agreement compliance and labor relations.. Valid values are `^[A-Z0-9]{2,8}$`',
    `work_shift` STRING COMMENT 'The primary work shift assigned to this position. Critical for 24/7 logistics operations including warehouse, freight handling, and last-mile delivery.. Valid values are `day|evening|night|rotating|flexible`',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized headcount positions within the organizational structure, representing approved roles that may be filled or vacant. Tracks position title, job profile, FTE allocation, grade level, work location, reporting line, and budget authorization. Enables workforce planning, vacancy management, and FTE tracking across all operational and corporate functions. Sourced from Workday HCM Position Management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile. Primary key for the job profile entity.',
    `reports_to_job_profile_id` BIGINT COMMENT 'Identifier of the job profile to which this role typically reports in the organizational hierarchy. Defines standard reporting relationships for organizational design.',
    `training_id` BIGINT COMMENT 'Foreign key linking to safety.safety_training. Business justification: Safety training requirements are defined by job profile in transport operations (role-based mandatory training matrix). DOT-regulated positions, hazmat handlers, and forklift operators each require sp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the job profile record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary range (e.g., USD, EUR, GBP). Supports multi-currency compensation structures for global operations.. Valid values are `^[A-Z]{3}$`',
    `education_level_required` STRING COMMENT 'Minimum educational qualification required for the job profile, ranging from high school diploma to advanced degrees or professional certifications. [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctorate|professional_certification|none — 7 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when the job profile is retired or superseded. Null for currently active profiles. Used for historical tracking and compliance reporting.',
    `effective_start_date` DATE COMMENT 'Date when the job profile becomes active and available for use in position management and workforce planning. Supports time-based organizational changes.',
    `flsa_classification` STRING COMMENT 'Classification under the US Fair Labor Standards Act determining overtime eligibility. Exempt employees are salaried and not eligible for overtime; non-exempt employees are eligible for overtime pay.. Valid values are `exempt|non_exempt`',
    `is_customer_facing` BOOLEAN COMMENT 'Indicates whether the job profile involves direct interaction with external customers, affecting training requirements and service level expectations.',
    `is_safety_sensitive` BOOLEAN COMMENT 'Indicates whether the job profile is classified as safety-sensitive, requiring drug and alcohol testing and heightened safety protocols. Applies to roles such as drivers, pilots, and equipment operators.',
    `is_union_eligible` BOOLEAN COMMENT 'Indicates whether the job profile is eligible for union membership or collective bargaining representation, affecting labor relations and compensation structures.',
    `job_category` STRING COMMENT 'Classification of the job based on the nature of work performed, distinguishing between operational, administrative, technical, managerial, and executive roles.. Valid values are `operational|administrative|technical|managerial|professional|executive`',
    `job_code` STRING COMMENT 'Unique alphanumeric code assigned to the job profile for identification and reference across HR systems. Used in payroll, position management, and workforce planning.. Valid values are `^[A-Z0-9]{4,12}$`',
    `job_description` STRING COMMENT 'Comprehensive description of the job role, including key responsibilities, duties, reporting relationships, and performance expectations. Used in job postings and employee onboarding.',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles together for career pathing, compensation benchmarking, and workforce planning. Examples include operations, sales, warehouse, fleet management. [ENUM-REF-CANDIDATE: operations|sales|customer_service|warehouse|fleet|finance|hr|it|legal|compliance|procurement|marketing|executive — 13 candidates stripped; promote to reference product]',
    `job_level` STRING COMMENT 'Hierarchical level of the job within the organization, indicating seniority, scope of responsibility, and decision-making authority. Used for career progression and organizational structure. [ENUM-REF-CANDIDATE: entry|intermediate|senior|lead|manager|director|vp|executive — 8 candidates stripped; promote to reference product]',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of the job profile. Active profiles are available for position creation; inactive or obsolete profiles are retained for historical reference only.. Valid values are `active|inactive|draft|obsolete`',
    `job_title` STRING COMMENT 'Official title of the job role as it appears in organizational documentation, employment contracts, and external job postings.',
    `key_responsibilities` STRING COMMENT 'Summary of the primary duties and accountabilities associated with the job profile. Used for performance management and role clarity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the job profile record was last updated. Used for change tracking and data quality monitoring.',
    `last_reviewed_date` DATE COMMENT 'Date when the job profile was last reviewed and validated by HR or business leadership. Used to ensure job profiles remain current and aligned with business needs.',
    `max_salary` DECIMAL(18,2) COMMENT 'Maximum annual salary for the job profile within the assigned pay grade. Defines the upper limit for compensation within this role.',
    `min_salary` DECIMAL(18,2) COMMENT 'Minimum annual salary for the job profile within the assigned pay grade. Used for compensation benchmarking and offer generation.',
    `min_years_experience` STRING COMMENT 'Minimum number of years of relevant work experience required for the job profile. Used in recruitment and candidate screening.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the job profile. Supports proactive governance and ensures job profiles are updated regularly.',
    `pay_grade` STRING COMMENT 'Compensation band or grade assigned to the job profile, defining the salary range and benefits tier. Used for compensation planning and pay equity analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    `physical_requirements` STRING COMMENT 'Description of physical demands and working conditions associated with the job, such as lifting requirements, standing duration, exposure to weather, or operation of heavy equipment. Used for ADA compliance and workplace safety.',
    `required_competencies` STRING COMMENT 'List of skills, knowledge areas, and behavioral competencies required for successful performance in the job role. Used for talent assessment and development planning.',
    `requires_customs_broker_license` BOOLEAN COMMENT 'Indicates whether the job profile requires a licensed customs broker credential for managing customs declarations and trade compliance activities.',
    `requires_dot_qualification` BOOLEAN COMMENT 'Indicates whether the job profile requires US Department of Transportation driver qualification and medical certification for commercial vehicle operation.',
    `requires_forklift_certification` BOOLEAN COMMENT 'Indicates whether the job profile requires forklift operator certification for warehouse and distribution center operations.',
    `requires_hazmat_endorsement` BOOLEAN COMMENT 'Indicates whether the job profile requires a HAZMAT endorsement on commercial driver license for transporting hazardous materials.',
    `requires_iata_dg_certification` BOOLEAN COMMENT 'Indicates whether the job profile requires IATA Dangerous Goods handling certification for air freight operations involving hazardous materials.',
    `requires_security_clearance` BOOLEAN COMMENT 'Indicates whether the job profile requires security clearance or background screening for roles with access to sensitive cargo, facilities, or data.',
    `travel_requirement_pct` STRING COMMENT 'Percentage of work time expected to involve business travel. Used for role expectations and expense planning.',
    `work_schedule_type` STRING COMMENT 'Standard work schedule pattern for the job profile, indicating whether the role is full-time, part-time, shift-based, on-call, or seasonal.. Valid values are `full_time|part_time|shift|on_call|seasonal|flexible`',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Standardized job role definitions used across Transport Shipping, capturing role title, job family, job level, required competencies, pay grade band, FLSA classification, and whether the role requires operational certifications (e.g., DOT driver qualification, IATA DG handling, customs broker license). Acts as the template from which positions and employee assignments are derived. Sourced from Workday HCM Job Profile.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` (
    `worker_assignment_id` BIGINT COMMENT 'Unique identifier for the worker assignment record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Worker assignments determine which cost center absorbs labor costs. Time tracking, payroll allocation, and operational cost reporting depend on this link for accurate cost center expense attribution.',
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile defining the role, competencies, and responsibilities associated with this assignment.',
    `labor_contract_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_contract. Business justification: Worker assignments are governed by labor contracts that define employment terms, work conditions, and assignment rules. Linking worker_assignment to labor_contract provides contractual traceability fo',
    `location_id` BIGINT COMMENT 'Unique identifier for the physical work location (office, warehouse, terminal, depot) where the employee performs duties under this assignment.',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit (department, division, business unit) to which the employee is assigned.',
    `position_id` BIGINT COMMENT 'Unique identifier for the position to which the employee is assigned. Links to the position master record defining job responsibilities and requirements.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee being assigned. Links to the employee master record in the workforce domain.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Workers assigned to contract execution (contract administrator assigned to master service agreement, compliance manager assigned to carrier contract). Enables contract-specific resource allocation, as',
    `shift_schedule_id` BIGINT COMMENT 'Unique identifier for the work schedule pattern (standard hours, shift pattern, flexible schedule) associated with this assignment.',
    `assignment_number` STRING COMMENT 'Business identifier for the assignment, typically system-generated or HR-assigned reference number used for tracking and reporting.',
    `assignment_reason` STRING COMMENT 'Business reason or event triggering this assignment (e.g., new hire, promotion, transfer, reorganization, backfill, project assignment). Used for workforce analytics and change tracking.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment indicating whether it is currently active, temporarily suspended, pending activation, or terminated.. Valid values are `active|inactive|suspended|pending|terminated`',
    `assignment_type` STRING COMMENT 'Classification of the assignment indicating whether it is the employees primary role, a secondary concurrent assignment, temporary coverage, project-based, or acting capacity.. Valid values are `primary|secondary|concurrent|temporary|project|acting`',
    `business_title` STRING COMMENT 'External-facing or business title used for this assignment, which may differ from the formal job profile title. Used for business cards, email signatures, and external communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `customs_broker_license_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this assignment requires a valid customs broker license for trade compliance and customs declaration activities.',
    `default_expense_cost_center` STRING COMMENT 'Default cost center code to which employee expenses (travel, supplies, etc.) for this assignment are charged. May differ from labor cost center.',
    `dot_safety_sensitive_flag` BOOLEAN COMMENT 'Boolean indicator of whether this assignment is classified as a DOT safety-sensitive position requiring drug and alcohol testing and compliance with hours-of-service regulations.',
    `driver_qualification_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this assignment requires valid commercial driver qualifications and certifications (CDL, ICAO crew license, etc.).',
    `effective_end_date` DATE COMMENT 'Date when this assignment ends or is superseded by a new assignment. Null for current active assignments. Supports historical tracking of organizational moves and role changes.',
    `effective_start_date` DATE COMMENT 'Date when this assignment becomes effective and the employee begins performing duties in this role. Used for historical tracking and temporal queries.',
    `employment_type` STRING COMMENT 'Classification of the employment relationship for this assignment indicating full-time, part-time, contractor, temporary, seasonal, or intern status.. Valid values are `full_time|part_time|contractor|temporary|seasonal|intern`',
    `flsa_status` STRING COMMENT 'Classification under the Fair Labor Standards Act indicating whether the position is exempt or non-exempt from overtime pay requirements.. Valid values are `exempt|non_exempt`',
    `fte_percentage` DECIMAL(18,2) COMMENT 'Percentage of full-time equivalent hours allocated to this assignment, expressed as a decimal (e.g., 100.00 for full-time, 50.00 for half-time). Used for workforce planning and labor cost allocation.',
    `hazmat_certification_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this assignment requires hazardous materials handling certification per IMDG Code or ICAO Technical Instructions.',
    `job_family` STRING COMMENT 'Broad categorization of the job role (e.g., Operations, Sales, Finance, IT, Warehouse, Fleet) used for workforce analytics and talent management.',
    `job_level` STRING COMMENT 'Hierarchical level of the position within the organization (e.g., Entry, Mid, Senior, Manager, Director, Executive) used for career progression and reporting structure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last updated. Used for change tracking and audit compliance.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to this position, defining the salary range and benefits eligibility. Business-confidential for compensation planning.',
    `pay_rate_type` STRING COMMENT 'Method by which compensation is calculated for this assignment: salary, hourly wage, commission-based, or piece-rate. Business-confidential for compensation planning.. Valid values are `salary|hourly|commission|piece_rate`',
    `probation_end_date` DATE COMMENT 'Date when the probationary period for this assignment ends, after which the employee achieves regular status. Null if no probation applies.',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether this assignment is eligible for remote or work-from-home arrangements per company policy.',
    `scheduled_weekly_hours` DECIMAL(18,2) COMMENT 'Number of hours per week the employee is scheduled to work under this assignment. Used for labor planning and compliance with working time regulations.',
    `source_system` STRING COMMENT 'Identifier of the source system from which this assignment record originated (e.g., Workday HCM, SAP HCM). Used for data lineage and integration troubleshooting.',
    `source_system_code` STRING COMMENT 'Unique identifier for this assignment in the source system. Used for reconciliation and bidirectional synchronization with operational systems.',
    `succession_plan_flag` BOOLEAN COMMENT 'Boolean indicator of whether this assignment is part of a formal succession planning program for critical roles and leadership development.',
    `time_type` STRING COMMENT 'Classification of how time is tracked and compensated for this assignment: salaried (exempt from hourly tracking) or hourly (time-based compensation).. Valid values are `salaried|hourly`',
    `travel_requirement_percentage` DECIMAL(18,2) COMMENT 'Expected percentage of work time requiring business travel for this assignment, used for workforce planning and expense forecasting.',
    `union_code` STRING COMMENT 'Code identifying the labor union or collective bargaining unit to which this assignment is subject, if applicable. Used for compliance with labor agreements.',
    `work_shift` STRING COMMENT 'Designated shift pattern for this assignment (e.g., Day Shift, Night Shift, Rotating, Split Shift) used for warehouse and fleet operations scheduling.',
    `worker_category` STRING COMMENT 'High-level categorization of the worker type for this assignment (e.g., Employee, Contingent Worker, Contractor, Consultant) used for workforce segmentation and reporting.',
    CONSTRAINT pk_worker_assignment PRIMARY KEY(`worker_assignment_id`)
) COMMENT 'Transactional record of an employees assignment to a specific position, org unit, location, and role at a point in time. Captures effective dates, assignment type (primary/secondary), work schedule, manager, cost center, and FTE percentage. Supports historical tracking of organizational moves, promotions, transfers, and role changes. Sourced from Workday HCM staffing events.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Unique identifier for the payroll record. Primary key.',
    `compensation_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.compensation_plan. Business justification: Payroll execution must trace back to the compensation plan that governed the pay calculation for that period. This provides auditability and ensures payroll amounts can be reconciled to approved compe',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payroll accounting posts labor costs to cost centers for GL reporting and budget tracking. Replaces denormalized cost_center_code string with proper FK for financial consolidation and variance analysi',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee for whom this payroll record was generated. Links to the employee master data.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Payroll transactions must post to the correct fiscal period for period-end close, accrual accounting, and financial statement preparation. Links payroll timing to financial reporting calendar.',
    `payroll_run_id` BIGINT COMMENT 'Identifier of the payroll processing batch or run that generated this record. Links to the payroll run master.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Payroll processed by third-party payroll suppliers (ADP, Paychex, regional payroll providers). Enables payroll vendor cost allocation, supplier-specific payroll tracking, payroll service procurement m',
    `tax_account_id` BIGINT COMMENT 'Foreign key linking to finance.tax_account. Business justification: Payroll tax withholding (federal, state, social security, medicare) posts to specific tax GL accounts for remittance tracking and tax filing. Essential for payroll tax compliance and reconciliation.',
    `allowance_amount` DECIMAL(18,2) COMMENT 'Total allowances paid, including transportation, housing, meal, mobile, or other employee allowances.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The regular base salary or wage component of gross pay for the pay period.',
    `benefit_deduction_amount` DECIMAL(18,2) COMMENT 'Total employee-paid benefit deductions including health insurance, dental, vision, life insurance, and retirement contributions.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Total bonus payments included in this payroll record, such as performance bonuses, retention bonuses, or spot awards.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Total commission earnings for sales or performance-based roles during the pay period.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payroll record.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The department or business unit to which the employee belongs for organizational reporting.',
    `employer_benefit_contribution_amount` DECIMAL(18,2) COMMENT 'Total employer contributions to employee benefits including retirement matching, health insurance subsidies, and other employer-paid benefits.',
    `employer_tax_amount` DECIMAL(18,2) COMMENT 'Total employer-paid payroll taxes including employer portion of social security, medicare, unemployment, and other statutory taxes.',
    `federal_tax_amount` DECIMAL(18,2) COMMENT 'Federal income tax withheld from gross pay for the pay period.',
    `garnishment_amount` DECIMAL(18,2) COMMENT 'Total wage garnishments for child support, tax levies, or court-ordered deductions.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total gross earnings before any deductions, including base salary, overtime, bonuses, and allowances.',
    `health_insurance_deduction_amount` DECIMAL(18,2) COMMENT 'Employee-paid portion of health insurance premiums deducted from gross pay.',
    `job_code` STRING COMMENT 'The job classification or role code of the employee during the pay period, used for labor analytics and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll record was last updated or modified.',
    `local_tax_amount` DECIMAL(18,2) COMMENT 'Local or municipal income tax withheld from gross pay for the pay period.',
    `location_code` STRING COMMENT 'The work location or facility code where the employee performed work during the pay period.',
    `medicare_tax_amount` DECIMAL(18,2) COMMENT 'Medicare tax withheld from gross pay for the pay period.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Final take-home pay after all deductions, representing the amount paid to the employee.',
    `other_deduction_amount` DECIMAL(18,2) COMMENT 'Miscellaneous deductions not categorized elsewhere, such as union dues, loan repayments, or voluntary contributions.',
    `overtime_amount` DECIMAL(18,2) COMMENT 'Total overtime pay earned during the pay period, including standard and premium overtime rates.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total number of overtime hours worked during the pay period.',
    `pay_date` DATE COMMENT 'The date on which payment was issued or scheduled to be issued to the employee.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid (e.g., weekly, biweekly, monthly).. Valid values are `weekly|biweekly|semimonthly|monthly|quarterly|annual`',
    `pay_period_end_date` DATE COMMENT 'The last date of the pay period covered by this payroll record.',
    `pay_period_start_date` DATE COMMENT 'The first date of the pay period covered by this payroll record.',
    `payment_method` STRING COMMENT 'The method by which net pay is disbursed to the employee.. Valid values are `direct_deposit|check|cash|wire_transfer|paycard`',
    `payroll_approved_by` STRING COMMENT 'User ID or name of the payroll administrator who approved this payroll record for payment.',
    `payroll_approved_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll record was approved for payment.',
    `payroll_processed_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll record was calculated and finalized in the payroll system.',
    `payroll_status` STRING COMMENT 'Current processing status of the payroll record in the payroll lifecycle.. Valid values are `draft|calculated|approved|paid|voided|reversed`',
    `pto_hours_used` DECIMAL(18,2) COMMENT 'Number of paid time off hours taken during the pay period, including vacation, sick leave, and personal days.',
    `pto_payout_amount` DECIMAL(18,2) COMMENT 'Monetary value of PTO hours paid out during the pay period, either as part of regular pay or upon termination.',
    `regular_hours_worked` DECIMAL(18,2) COMMENT 'Total number of regular (non-overtime) hours worked during the pay period.',
    `retirement_contribution_amount` DECIMAL(18,2) COMMENT 'Employee contribution to retirement plans such as 401(k), 403(b), or pension plans.',
    `shift_differential_amount` DECIMAL(18,2) COMMENT 'Additional pay for working non-standard shifts (night shift, weekend shift) in warehouse or freight operations.',
    `social_security_tax_amount` DECIMAL(18,2) COMMENT 'Social security tax (FICA) withheld from gross pay for the pay period.',
    `state_tax_amount` DECIMAL(18,2) COMMENT 'State income tax withheld from gross pay for the pay period.',
    `tax_withholding_amount` DECIMAL(18,2) COMMENT 'Total tax withholdings including federal, state, local, and social security taxes.',
    `total_deductions_amount` DECIMAL(18,2) COMMENT 'Sum of all deductions from gross pay, including taxes, benefits, garnishments, and other withholdings.',
    `total_labor_cost_amount` DECIMAL(18,2) COMMENT 'Fully-loaded labor cost including gross pay, employer taxes, and employer benefit contributions for cost allocation and P&L reporting.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Periodic payroll processing records capturing gross pay, net pay, deductions, tax withholdings, overtime, allowances, and pay period details for each employee. Supports labor cost allocation to cost centers, freight operations, and warehouse functions. Tracks pay frequency, payment method, currency, and payroll run status. Sourced from Workday HCM Payroll.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Unique identifier for the compensation plan record. Primary key.',
    `carbon_offset_transaction_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_transaction. Business justification: Green incentive programs tie compensation bonuses to carbon reduction achievements. Linking enables sustainability-linked compensation administration, carbon credit allocation to employee performance,',
    `agreement_id` BIGINT COMMENT 'Reference to the collective bargaining agreement governing this compensation plan. Null for non-union plans.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compensation plans are budgeted and charged to cost centers. Budget approval, headcount planning, and labor cost forecasting require linking compensation to the responsible cost center for financial c',
    `labor_contract_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_contract. Business justification: Compensation plans are governed by labor contracts (individual or collective bargaining agreements). Linking compensation_plan to labor_contract provides contractual traceability and ensures compensat',
    `employee_id` BIGINT COMMENT 'Reference to the employee assigned to this compensation plan.',
    `tertiary_compensation_modified_by_user_employee_id` BIGINT COMMENT 'System user ID of the person who last modified this record. Used for audit trail and accountability.',
    `approval_date` DATE COMMENT 'Date when the compensation plan was approved. Null if not yet approved.',
    `approval_status` STRING COMMENT 'Workflow approval status for the compensation plan. Plans must be approved before becoming active.. Valid values are `draft|pending_approval|approved|rejected`',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Annual base salary amount for salaried employees. Null for hourly or commission-only plans. Expressed in plan currency.',
    `bonus_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for performance or annual bonuses under this plan. True if eligible, False otherwise.',
    `commission_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for sales or performance commissions under this plan. True if eligible, False otherwise.',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'Commission rate as a percentage of sales or revenue (e.g., 2.50 for 2.5%). Null if not commission-eligible.',
    `compensation_plan_status` STRING COMMENT 'Current lifecycle status of the compensation plan assignment. Active plans are in effect; inactive/terminated plans are historical.. Valid values are `active|inactive|suspended|pending|terminated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compensation plan record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this plan (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this compensation plan ceases to be effective. Nullable for open-ended plans. Used for plan transitions and terminations.',
    `effective_start_date` DATE COMMENT 'Date when this compensation plan becomes effective for the employee. Marks the beginning of the compensation agreement period.',
    `flsa_classification` STRING COMMENT 'FLSA classification determining overtime eligibility. Exempt employees are not eligible for overtime; non-exempt employees are.. Valid values are `exempt|non_exempt`',
    `grade_band` STRING COMMENT 'Organizational grade or band level for this compensation plan (e.g., E1, M3, D5). Used for pay equity and career progression.. Valid values are `^[A-Z0-9]{1,6}$`',
    `hazmat_premium_amount` DECIMAL(18,2) COMMENT 'Additional pay for handling hazardous materials (HAZMAT) shipments. Common for drivers and warehouse staff with HAZMAT certification.',
    `health_insurance_subsidy_amount` DECIMAL(18,2) COMMENT 'Monthly employer subsidy toward employee health insurance premiums. Null if no subsidy provided.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Standard hourly pay rate for hourly employees. Null for salaried plans. Used for warehouse labor, drivers, and operational staff.',
    `job_code` STRING COMMENT 'Standardized job classification code associated with this compensation plan. Links to job description and competency requirements.. Valid values are `^[A-Z0-9]{4,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compensation plan record was last updated. Used for audit trail and change tracking.',
    `mileage_reimbursement_rate` DECIMAL(18,2) COMMENT 'Reimbursement rate per mile or kilometer for drivers using personal vehicles or for mileage-based compensation. Null if not applicable.',
    `notes` STRING COMMENT 'Free-text notes or comments about the compensation plan. Used for special conditions, exceptions, or clarifications.',
    `overnight_driver_allowance` DECIMAL(18,2) COMMENT 'Per-night allowance for drivers on overnight or long-haul routes. Covers lodging and meals. Null if not applicable.',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to hourly rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Null if overtime not applicable.',
    `pay_frequency` STRING COMMENT 'Frequency of payroll disbursement for this plan: weekly, biweekly (every two weeks), semimonthly (twice per month), or monthly.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_range_maximum` DECIMAL(18,2) COMMENT 'Maximum compensation amount for the grade band or plan. Ceiling for the role without promotion.',
    `pay_range_midpoint` DECIMAL(18,2) COMMENT 'Midpoint compensation amount for the grade band or plan. Target for fully competent performance in role.',
    `pay_range_minimum` DECIMAL(18,2) COMMENT 'Minimum compensation amount for the grade band or plan. Used for pay equity analysis and compliance reporting.',
    `per_diem_amount` DECIMAL(18,2) COMMENT 'Daily allowance for meals and incidental expenses during business travel. Common for drivers and field staff. Null if not applicable.',
    `plan_code` STRING COMMENT 'Business identifier code for the compensation plan structure. Externally-known unique code used in payroll and HR systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `plan_name` STRING COMMENT 'Human-readable name of the compensation plan (e.g., Driver Base + Mileage, Warehouse Hourly Shift, Executive Salary Band 5).',
    `plan_type` STRING COMMENT 'Classification of the compensation structure: salary (fixed annual), hourly (time-based), commission (performance-based), piece_rate (per-unit), or hybrid (combination).. Valid values are `salary|hourly|commission|piece_rate|hybrid`',
    `reason_for_change` STRING COMMENT 'Business justification for creating or modifying this compensation plan (e.g., Annual merit increase, Promotion to supervisor, Market adjustment).',
    `retirement_contribution_percentage` DECIMAL(18,2) COMMENT 'Employer contribution to retirement plan as a percentage of base salary (e.g., 5.00 for 5% match). Null if no employer contribution.',
    `shift_differential_amount` DECIMAL(18,2) COMMENT 'Additional hourly pay for non-standard shifts (e.g., night shift, weekend shift). Null if no differential applies.',
    `source_system_code` STRING COMMENT 'Code identifying the source system of record for this compensation plan (e.g., WORKDAY_HCM, SAP_HR). Used for data lineage and integration.. Valid values are `^[A-Z_]{2,20}$`',
    `stock_option_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for equity compensation (stock options, RSUs) under this plan. True if eligible, False otherwise.',
    `target_bonus_percentage` DECIMAL(18,2) COMMENT 'Target annual bonus as a percentage of base salary (e.g., 15.00 for 15%). Null if not bonus-eligible.',
    `union_affiliation_code` STRING COMMENT 'Code identifying the labor union affiliation for this compensation plan. Null for non-union employees. Used for collective bargaining agreement (CBA) compliance.. Valid values are `^[A-Z0-9]{2,10}$`',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Master record of compensation structures assigned to employees, including base salary, hourly rate, bonus eligibility, commission structure, shift differentials, and allowances (e.g., hazmat handling premium, overnight driver allowance). Captures grade band, pay range, effective dates, and compensation type. Sourced from Workday HCM Compensation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment record. Primary key for the benefit enrollment entity.',
    `plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan in which the employee is enrolled. Links to the benefit plan master record.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Benefits administered by third-party suppliers (insurance carriers, benefits administrators, wellness program providers). Enables benefits supplier tracking, vendor-specific enrollment management, ben',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee enrolling in the benefit program. Links to the employee master record in Workday HCM.',
    `annual_election_amount` DECIMAL(18,2) COMMENT 'Total annual amount elected by the employee for contribution-based benefits such as Flexible Spending Accounts (FSA) or Health Savings Accounts (HSA). Represents the employees annual commitment for the plan year.',
    `beneficiary_designation` STRING COMMENT 'Name or identifier of the primary beneficiary designated to receive benefits in the event of employee death. Applicable to life insurance and retirement plans. May contain multiple beneficiaries with percentage allocations.',
    `benefit_category` STRING COMMENT 'High-level classification of the benefit program type. Health includes medical insurance; dental includes dental insurance; vision includes vision insurance; life insurance includes basic and supplemental life coverage; disability includes short-term and long-term disability; retirement includes 401k and pension plans; flexible spending includes FSA and HSA accounts; employee assistance includes EAP programs; wellness includes gym memberships and wellness programs; supplemental includes additional voluntary benefits. [ENUM-REF-CANDIDATE: health|dental|vision|life_insurance|disability|retirement|flexible_spending|employee_assistance|wellness|supplemental — 10 candidates stripped; promote to reference product]',
    `carrier_confirmation_date` DATE COMMENT 'Date when the benefit carrier confirmed receipt and acceptance of the enrollment. Null if carrier has not yet confirmed. Used for reconciliation and issue resolution.',
    `carrier_group_number` STRING COMMENT 'Group policy number assigned by the benefit carrier to identify the employer group plan. All employees under the same plan share this group number. Used for carrier billing and administration.',
    `carrier_policy_number` STRING COMMENT 'Policy or member identification number assigned by the benefit carrier or insurance provider. Used for claims processing, provider verification, and coordination of benefits. Format varies by carrier.',
    `carrier_submission_date` DATE COMMENT 'Date when the enrollment was transmitted to the benefit carrier for processing. Used to track enrollment processing timelines and ensure timely coverage activation.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether this enrollment is eligible for COBRA continuation coverage upon termination of employment. True for health, dental, and vision plans; false for life insurance and retirement plans. Determined by plan type and company size.',
    `cobra_end_date` DATE COMMENT 'Date when COBRA continuation coverage ends. Typically 18 months after start date for termination events, 36 months for certain qualifying events. Null for active COBRA enrollments.',
    `cobra_start_date` DATE COMMENT 'Date when COBRA continuation coverage begins following a qualifying event such as termination of employment. Null for active employees. Typically the day after employment termination or loss of eligibility.',
    `contribution_basis` STRING COMMENT 'Tax treatment of employee contributions. Pre-tax indicates contributions reduce taxable income (Section 125 plans); post-tax indicates contributions are made with after-tax dollars; employer paid indicates no employee contribution required.. Valid values are `pre_tax|post_tax|employer_paid`',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are deducted and remitted. Aligns with company payroll schedule. Weekly indicates 52 pay periods; biweekly indicates 26 pay periods; semimonthly indicates 24 pay periods; monthly indicates 12 pay periods; annual indicates single annual payment.. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Face value or benefit amount of the coverage for life insurance and disability plans. Represents the maximum benefit payable. For health plans, may represent out-of-pocket maximum or deductible amount. Null for plans without defined coverage amounts.',
    `coverage_effective_date` DATE COMMENT 'Date when the benefit coverage begins and the employee is eligible to use the benefit. Typically the first day of the month following enrollment or the hire date for new employees.',
    `coverage_end_date` DATE COMMENT 'Date when the benefit coverage ends. Null for active enrollments. Populated upon termination, cancellation, or when employee opts out during open enrollment.',
    `coverage_tier` STRING COMMENT 'Level of coverage elected by the employee. Employee only covers the employee; employee spouse covers employee and spouse or domestic partner; employee children covers employee and dependent children; employee family covers employee, spouse, and dependent children.. Valid values are `employee_only|employee_spouse|employee_children|employee_family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in Workday HCM Benefits system. Used for audit trail and data lineage tracking.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the employee must pay out-of-pocket before insurance coverage begins paying claims. Applicable to health, dental, and vision plans. Amount varies by coverage tier and plan design.',
    `dependent_count` STRING COMMENT 'Number of dependents covered under this enrollment. Zero for employee-only coverage. Used for premium calculation and compliance reporting.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Amount the employee contributes per pay period toward the benefit premium or plan cost. Deducted from employee paycheck on a pre-tax or post-tax basis depending on plan type.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Amount the employer contributes per pay period toward the benefit premium or plan cost. Represents company subsidy of employee benefit coverage.',
    `enrollment_confirmation_sent_date` DATE COMMENT 'Date when enrollment confirmation documentation was sent to the employee. Used for compliance tracking and audit trail. Confirmation includes coverage details, premium amounts, and effective dates.',
    `enrollment_date` DATE COMMENT 'Date when the employee submitted the enrollment election. May differ from coverage effective date due to waiting periods or enrollment processing time.',
    `enrollment_method` STRING COMMENT 'Channel through which the employee completed the benefit enrollment. Online self service indicates Workday portal; HR representative indicates assisted enrollment; benefits fair indicates enrollment at company event; phone indicates call center enrollment; paper form indicates manual form submission; auto enrollment indicates system-generated default enrollment.. Valid values are `online_self_service|hr_representative|benefits_fair|phone|paper_form|auto_enrollment`',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment reference number generated by Workday HCM Benefits module. Used for tracking and communication with employees and benefit providers.. Valid values are `^ENR-[0-9]{8}$`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the benefit enrollment. Active indicates coverage is in effect; pending indicates awaiting approval or effective date; terminated indicates coverage has ended; suspended indicates temporary hold; waived indicates employee declined coverage; cancelled indicates enrollment was voided.. Valid values are `active|pending|terminated|suspended|waived|cancelled`',
    `enrollment_type` STRING COMMENT 'Classification of the enrollment event that triggered this benefit enrollment. New hire indicates initial enrollment upon joining; annual open indicates enrollment during open enrollment period; qualifying life event indicates enrollment due to marriage, birth, adoption, or other qualifying event; mid year change indicates voluntary change outside open enrollment; rehire indicates enrollment upon return to company; status change indicates enrollment due to FTE or role change.. Valid values are `new_hire|annual_open|qualifying_life_event|mid_year_change|rehire|status_change`',
    `evidence_of_insurability_required_flag` BOOLEAN COMMENT 'Indicates whether the employee must provide medical evidence of insurability for coverage approval. True for supplemental life insurance above guaranteed issue amounts or late enrollments; false for standard enrollments within guaranteed issue limits.',
    `evidence_of_insurability_status` STRING COMMENT 'Current status of evidence of insurability review by the insurance carrier. Not required indicates no EOI needed; pending indicates under carrier review; approved indicates coverage approved; denied indicates coverage denied due to health conditions.. Valid values are `not_required|pending|approved|denied`',
    `hsa_eligible_flag` BOOLEAN COMMENT 'Indicates whether this health plan enrollment qualifies the employee for a Health Savings Account. True for high-deductible health plans (HDHP) meeting IRS requirements; false for traditional health plans.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last updated in Workday HCM Benefits system. Captures any changes to enrollment status, contribution amounts, coverage tier, or other enrollment attributes.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount the employee will pay in a plan year for covered services. Once reached, the plan pays 100% of covered expenses. Applicable to health plans. Required disclosure under Affordable Care Act (ACA).',
    `plan_year` STRING COMMENT 'Calendar year or fiscal year for which this enrollment is effective. Used for annual benefit plan administration, open enrollment tracking, and compliance reporting. Format YYYY.',
    `qualifying_event_date` DATE COMMENT 'Date when the qualifying life event occurred. Used to validate enrollment timing and compliance with 30-day or 60-day election windows required by IRS and HIPAA regulations. Null for non-QLE enrollments.',
    `qualifying_event_type` STRING COMMENT 'Type of qualifying life event that permitted mid-year enrollment change outside of open enrollment period. Marriage, divorce, birth, adoption, death of dependent, loss of other coverage, or change in employment status. Null for enrollments during open enrollment or new hire periods. [ENUM-REF-CANDIDATE: marriage|divorce|birth|adoption|death|loss_of_coverage|employment_change — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'Name of the source system from which this enrollment record originated. Typically Workday HCM Benefits module. Used for data lineage and integration troubleshooting.',
    `source_system_code` STRING COMMENT 'Unique identifier for this enrollment record in the source system (Workday HCM). Used for reconciliation, data synchronization, and traceability back to the operational system of record.',
    `termination_reason` STRING COMMENT 'Reason for termination of benefit enrollment. Employment termination indicates employee left company; employee waiver indicates employee opted out; plan discontinuation indicates employer ended plan; ineligibility indicates employee no longer meets eligibility criteria; non-payment indicates failure to pay premiums; COBRA expiration indicates end of continuation coverage period. Null for active enrollments.. Valid values are `employment_termination|employee_waiver|plan_discontinuation|ineligibility|non_payment|cobra_expiration`',
    `tobacco_user_flag` BOOLEAN COMMENT 'Indicates whether the employee is a tobacco user. Used for premium rating and wellness program eligibility. True indicates tobacco use; false indicates non-tobacco user. Self-reported by employee during enrollment.',
    `waiver_reason` STRING COMMENT 'Reason provided by employee for declining or waiving benefit coverage. Covered elsewhere indicates coverage through spouse or other source; cost indicates employee cannot afford premium; not needed indicates employee does not require coverage; other indicates alternative reason. Null for active enrollments.. Valid values are `covered_elsewhere|cost|not_needed|other`',
    `wellness_program_participant_flag` BOOLEAN COMMENT 'Indicates whether the employee is enrolled in the company wellness program associated with this benefit. True indicates active participation; false indicates not enrolled. May affect premium rates or provide incentive credits.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Records of employee enrollment in benefit programs including health insurance, dental, vision, life insurance, retirement plans (401k/pension), and employee assistance programs. Captures enrollment dates, coverage tier, dependent details, contribution amounts, and benefit plan type. Sourced from Workday HCM Benefits.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` (
    `driver_qualification_id` BIGINT COMMENT 'Unique identifier for the driver qualification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee record in the workforce system. Links this qualification record to the drivers core HR profile.',
    `fuel_consumption_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.fuel_consumption_record. Business justification: Driver qualification and training directly impact fuel efficiency. Linking enables eco-driving performance analysis, driver-level emissions KPIs, and targeted training for high-consumption drivers in ',
    `alcohol_test_last_date` DATE COMMENT 'Date of the most recent alcohol test administered to the driver. Testing is required post-accident, reasonable suspicion, and return-to-duty.',
    `alcohol_test_result` STRING COMMENT 'Result of the most recent alcohol test. A positive result (BAC 0.04% or higher) or refusal disqualifies the driver.. Valid values are `negative|positive|refused|pending`',
    `background_check_date` DATE COMMENT 'Date of the most recent background check conducted on the driver, including criminal history and employment verification.',
    `background_check_status` STRING COMMENT 'Result of the most recent background check. Certain criminal offenses disqualify drivers from operating commercial vehicles.. Valid values are `clear|pending|disqualifying_offense|under_review`',
    `cdl_class` STRING COMMENT 'The class of CDL held by the driver, determining the types of vehicles they are authorized to operate. Class A for combination vehicles, Class B for heavy straight vehicles, Class C for vehicles carrying hazardous materials or 16+ passengers.. Valid values are `Class A|Class B|Class C`',
    `cdl_expiration_date` DATE COMMENT 'Date the CDL expires and must be renewed. Critical for maintaining operational dispatch eligibility.',
    `cdl_issue_date` DATE COMMENT 'Date the current CDL was issued by the licensing authority.',
    `cdl_number` STRING COMMENT 'The unique CDL number issued by the state licensing authority. Required for all commercial vehicle operators.',
    `cdl_state_issued` STRING COMMENT 'Two-letter US state code where the CDL was issued. Drivers may only hold one CDL at a time per federal law.. Valid values are `^[A-Z]{2}$`',
    `clearinghouse_query_date` DATE COMMENT 'Date of the most recent query to the FMCSA Drug and Alcohol Clearinghouse. Employers must conduct pre-employment queries and annual queries for all CDL drivers.',
    `clearinghouse_status` STRING COMMENT 'Current status in the FMCSA Drug and Alcohol Clearinghouse. Indicates whether any drug or alcohol violations are on record that would prohibit the driver from performing safety-sensitive functions.. Valid values are `clear|violation_pending|prohibited|resolved`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system.',
    `disqualification_end_date` DATE COMMENT 'Date the disqualification period ends and the driver may be eligible for reinstatement, if applicable. Null for permanent disqualifications.',
    `disqualification_reason` STRING COMMENT 'Detailed reason if the driver is disqualified from operating commercial vehicles. Includes regulatory citation and specific violation or condition.',
    `disqualification_start_date` DATE COMMENT 'Date the disqualification period began, if applicable.',
    `drug_test_last_date` DATE COMMENT 'Date of the most recent drug test administered to the driver. FMCSA requires pre-employment, random, post-accident, reasonable suspicion, and return-to-duty testing.',
    `drug_test_result` STRING COMMENT 'Result of the most recent drug test. A positive result or refusal to test disqualifies the driver from safety-sensitive functions.. Valid values are `negative|positive|refused|pending`',
    `endorsement_doubles_triples` BOOLEAN COMMENT 'Indicates whether the driver holds a valid doubles/triples endorsement (T) for towing multiple trailers.',
    `endorsement_hazmat` BOOLEAN COMMENT 'Indicates whether the driver holds a valid HAZMAT endorsement (H) allowing transport of hazardous materials as defined by IMDG and DOT regulations.',
    `endorsement_passenger` BOOLEAN COMMENT 'Indicates whether the driver holds a valid passenger endorsement (P) for operating vehicles designed to transport 16 or more passengers.',
    `endorsement_tanker` BOOLEAN COMMENT 'Indicates whether the driver holds a valid tanker endorsement (N) for operating tank vehicles.',
    `hos_eligibility_status` STRING COMMENT 'Current eligibility status for dispatch based on Hours of Service compliance. Indicates whether the driver has available hours under 11-hour driving and 14-hour on-duty limits.. Valid values are `eligible|hours_exceeded|violation_pending|out_of_service`',
    `hos_violation_count_12m` STRING COMMENT 'Number of HOS violations recorded in the past 12 months. Used for compliance monitoring and driver performance evaluation.',
    `medical_certificate_expiration_date` DATE COMMENT 'Date the medical examiners certificate expires. Drivers must maintain a current medical certificate to remain qualified. Typically valid for 12-24 months.',
    `medical_certificate_issue_date` DATE COMMENT 'Date the medical examiners certificate was issued following the drivers physical examination.',
    `medical_certificate_number` STRING COMMENT 'Unique identifier for the drivers medical examiners certificate issued by a certified medical examiner on the National Registry.',
    `medical_examiner_name` STRING COMMENT 'Name of the certified medical examiner who performed the physical examination and issued the certificate.',
    `medical_examiner_registry_number` STRING COMMENT 'The unique registry number of the medical examiner on the FMCSA National Registry of Certified Medical Examiners.',
    `medical_variance_exemption` STRING COMMENT 'Type of medical variance or exemption granted by FMCSA if the driver does not meet standard physical qualification requirements but has been granted an exemption.. Valid values are `none|vision|diabetes|hearing|seizure|other`',
    `mvr_review_date` DATE COMMENT 'Date of the most recent Motor Vehicle Record review conducted by the employer. FMCSA requires annual MVR reviews for all drivers.',
    `mvr_status` STRING COMMENT 'Current status of the drivers MVR based on the most recent review. Indicates whether any violations or disqualifying offenses are present.. Valid values are `clear|violations_minor|violations_major|disqualifying|pending_review`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next comprehensive qualification review. Used for proactive compliance management and renewal planning.',
    `notes` STRING COMMENT 'Free-text notes regarding the drivers qualification status, special conditions, accommodations, or compliance actions. Used for internal tracking and audit trail.',
    `qualification_file_complete` BOOLEAN COMMENT 'Indicates whether the drivers qualification file contains all required documents per FMCSA regulations (application, MVR, medical certificate, road test, etc.).',
    `qualification_status` STRING COMMENT 'Current operational status of the drivers qualification. Determines dispatch eligibility and compliance standing.. Valid values are `qualified|expired|suspended|pending_renewal|disqualified|under_review`',
    `road_test_date` DATE COMMENT 'Date the driver successfully completed the employers road test demonstrating ability to operate the type of commercial vehicle they will drive.',
    `road_test_examiner` STRING COMMENT 'Name of the qualified examiner who administered and certified the drivers road test.',
    `training_completion_date` DATE COMMENT 'Date the driver completed Entry-Level Driver Training requirements for their CDL class and endorsements, if applicable.',
    `training_provider` STRING COMMENT 'Name of the FMCSA-registered training provider that delivered the Entry-Level Driver Training.',
    `updated_by` STRING COMMENT 'User ID or name of the person who last updated this qualification record. Supports compliance audit and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last modified. Used for audit trail and data lineage.',
    CONSTRAINT pk_driver_qualification PRIMARY KEY(`driver_qualification_id`)
) COMMENT 'DOT-compliant driver qualification records for all commercial vehicle operators, capturing CDL class, endorsements (hazmat, tanker, doubles/triples), medical examiner certificate, MVR review status, drug and alcohol testing compliance, hours-of-service eligibility, and qualification expiry dates. Critical for DOT FMCSA compliance and operational dispatch eligibility. Supports fleet and last-mile delivery domains.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` (
    `crew_certification_id` BIGINT COMMENT 'Unique identifier for the crew certification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who holds this certification. Links to the employee master record in the workforce domain.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Certifications required by specific suppliers (hazmat handling for chemical suppliers, security clearances for defense contractors). Enables supplier-mandated workforce compliance tracking, vendor-spe',
    `airside_pass_number` STRING COMMENT 'Unique identifier for the airside access pass or security badge issued to the crew member. Required for personnel working in restricted airport areas.',
    `assessment_result` STRING COMMENT 'Outcome of the certification assessment. Indicates whether the crew member met the required competency standards.. Valid values are `pass|fail|conditional_pass|exempt`',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score or grade achieved by the crew member on the certification assessment or examination. May be percentage or numeric score.',
    `background_check_date` DATE COMMENT 'Date of the most recent background check or security screening conducted for this certification. Required for security-sensitive certifications.',
    `background_check_status` STRING COMMENT 'Current status of the background check or security screening. Indicates whether the crew member has been cleared for security-sensitive operations.. Valid values are `cleared|pending|flagged|expired`',
    `certification_number` STRING COMMENT 'Unique certification number or credential identifier issued by the certifying authority. This is the externally-known business identifier for the certification.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Indicates whether the certification is valid and in good standing.. Valid values are `active|expired|suspended|revoked|pending_renewal|under_review`',
    `certification_type` STRING COMMENT 'Type or category of certification held by the crew member. Classifies the certification by its functional purpose in air cargo and aviation operations. [ENUM-REF-CANDIDATE: dangerous_goods_handling|security_awareness|known_consignor_authorization|airside_pass|cargo_screening|load_planning|hazmat_transport|customs_compliance|forklift_operation|other — 10 candidates stripped; promote to reference product]',
    `competency_level` STRING COMMENT 'Level of competency or proficiency achieved by the crew member for this certification. Used for role assignment and capability planning.. Valid values are `basic|intermediate|advanced|expert|instructor`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Used for audit trail and data lineage.',
    `dangerous_goods_category` STRING COMMENT 'Specific dangerous goods class or category the crew member is certified to handle (e.g., Class 1 Explosives, Class 3 Flammable Liquids, Class 7 Radioactive Materials). Applicable for DG handling certifications.',
    `digital_certificate_url` STRING COMMENT 'URL or file path to the digital copy of the certification document stored in the document management system.',
    `document_reference_number` STRING COMMENT 'Reference number or identifier for the physical or digital certification document or certificate issued to the crew member.',
    `effective_date` DATE COMMENT 'Date from which the certification becomes valid and the crew member is authorized to perform the certified activities.',
    `endorsements` STRING COMMENT 'Additional endorsements, qualifications, or specializations added to the base certification (e.g., instructor authorization, advanced handling techniques).',
    `expiry_date` DATE COMMENT 'Date on which the certification expires and is no longer valid. Crew member must renew or recertify before this date to maintain authorization.',
    `issue_date` DATE COMMENT 'Date on which the certification was originally issued to the crew member. Represents the start of the certification validity period.',
    `issuing_authority` STRING COMMENT 'Name of the organization or regulatory body that issued the certification (e.g., IATA, ICAO, national aviation authority, training provider).',
    `issuing_authority_code` STRING COMMENT 'Standardized code or identifier for the issuing authority, used for regulatory reporting and compliance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last updated or modified. Used for audit trail and change tracking.',
    `last_renewal_date` DATE COMMENT 'Date of the most recent renewal or recertification. Tracks the certification maintenance history.',
    `next_renewal_due_date` DATE COMMENT 'Date by which the certification must be renewed to avoid expiration. Used for proactive workforce planning and compliance monitoring.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the certification. Used for special circumstances, exceptions, or supplementary information.',
    `recertification_reason` STRING COMMENT 'Reason why recertification is required (e.g., certification expiration, regulatory changes, incident investigation, performance concerns).. Valid values are `expiration|regulatory_change|incident|performance_issue|voluntary`',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether the crew member is required to undergo recertification or refresher training. True if recertification is required, False otherwise.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the certification is currently in compliance with all applicable regulatory requirements. True if compliant, False if non-compliant or expired.',
    `restrictions` STRING COMMENT 'Any limitations, conditions, or restrictions placed on the certification (e.g., supervised operations only, specific cargo types excluded, geographic limitations).',
    `revocation_date` DATE COMMENT 'Date on which the certification was permanently revoked. Applicable when certification status is revoked.',
    `revocation_reason` STRING COMMENT 'Reason for certification revocation (e.g., serious safety violation, fraud, criminal conviction, gross negligence).',
    `scope_of_authorization` STRING COMMENT 'Detailed description of the activities, operations, or cargo types the crew member is authorized to handle under this certification (e.g., Class 1 explosives, radioactive materials, lithium batteries).',
    `security_clearance_level` STRING COMMENT 'Level of security clearance held by the crew member. Required for certain aviation and cargo security roles.. Valid values are `basic|enhanced|top_secret|none`',
    `source_system` STRING COMMENT 'Name or identifier of the source system from which this certification record originated (e.g., Workday HCM, training management system, regulatory authority database).',
    `suspension_date` DATE COMMENT 'Date on which the certification was suspended. Applicable when certification status is suspended.',
    `suspension_reason` STRING COMMENT 'Reason for certification suspension (e.g., safety violation, non-compliance, pending investigation, medical issues).',
    `training_completion_date` DATE COMMENT 'Date on which the crew member completed the required training program that led to this certification.',
    `training_course_code` STRING COMMENT 'Standardized code or identifier for the training course completed by the crew member.',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total number of hours of training completed for this certification. Used for compliance reporting and workforce development tracking.',
    `training_provider` STRING COMMENT 'Name of the organization or institution that provided the training program for this certification.',
    `verification_date` DATE COMMENT 'Date on which the crew members competency was last verified or validated by the issuing authority or employer.',
    `verification_method` STRING COMMENT 'Method used to verify the crew members competency for this certification (e.g., written examination, practical demonstration, on-the-job evaluation).. Valid values are `written_exam|practical_test|online_assessment|on_job_evaluation|portfolio_review`',
    `verified_by` STRING COMMENT 'Name or identifier of the person or authority who verified the crew members competency for this certification.',
    CONSTRAINT pk_crew_certification PRIMARY KEY(`crew_certification_id`)
) COMMENT 'IATA and ICAO-compliant crew qualification and certification records for air cargo and aviation personnel, including dangerous goods (DG) handling certification, security awareness training, known consignor authorization, and airside pass status. Captures certification type, issuing authority, issue date, expiry date, and renewal status. Supports customs and air freight operations compliance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`competency_record` (
    `competency_record_id` BIGINT COMMENT 'Unique identifier for the competency record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who last updated this competency record.',
    `primary_competency_employee_id` BIGINT COMMENT 'Identifier of the employee to whom this competency record belongs. Links to the employee master data in Workday HCM.',
    `tertiary_competency_verified_by_employee_id` BIGINT COMMENT 'Identifier of the person who verified the competency certification or credential (typically HR or compliance staff).',
    `assessment_date` DATE COMMENT 'Date when the competency assessment was conducted.',
    `assessment_method` STRING COMMENT 'Method used to assess the competency: observation (on-the-job), test (written or online), certification (external credential), self-assessment, peer review, manager review, simulation, or practical exam. [ENUM-REF-CANDIDATE: observation|test|certification|self_assessment|peer_review|manager_review|simulation|practical_exam — 8 candidates stripped; promote to reference product]',
    `assessment_notes` STRING COMMENT 'Free-text notes or comments from the assessor regarding the competency assessment, including strengths, areas for improvement, or context.',
    `assessor_name` STRING COMMENT 'Full name of the person who conducted the competency assessment.',
    `certification_authority` STRING COMMENT 'Name of the organization or regulatory body that issued the certification (e.g., DOT, ICAO, OSHA, IATA, internal training department).',
    `certification_number` STRING COMMENT 'External certification or credential number associated with this competency, if applicable (e.g., DOT medical examiner certificate, ICAO dangerous goods certification, forklift operator license).',
    `competency_category` STRING COMMENT 'Detailed category or domain of the competency (e.g., Warehouse Operations, Transportation Management, Customs and Trade, Customer Service, Safety and Compliance, Leadership and Management).',
    `competency_name` STRING COMMENT 'Name of the competency being assessed (e.g., Forklift Operation, WMS Proficiency, TMS Usage, Customs Classification, Leadership, Communication, Problem-Solving).',
    `competency_status` STRING COMMENT 'Current lifecycle status of the competency record: active (valid and current), expired (past expiry date), pending_renewal (approaching expiry), suspended (temporarily invalid), or revoked (permanently invalid).. Valid values are `active|expired|pending_renewal|suspended|revoked`',
    `competency_type` STRING COMMENT 'Category of the competency: operational (forklift, WMS, TMS), professional (communication, problem-solving), technical (customs classification, EDI), leadership (team management), safety (hazmat handling), or compliance (DOT, ICAO certifications).. Valid values are `operational|professional|technical|leadership|safety|compliance`',
    `compliance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this competency is required for regulatory or compliance purposes (True), such as DOT driver qualifications or ICAO dangerous goods handling, or is non-regulatory (False).',
    `cost_center_code` STRING COMMENT 'Cost center code associated with the training or assessment costs for this competency record. Used for labor cost allocation and workforce planning.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `development_plan_flag` BOOLEAN COMMENT 'Indicates whether a development plan has been created to improve this competency (True) or not (False).',
    `effective_date` DATE COMMENT 'Date from which the competency record or certification becomes valid and effective.',
    `expiry_date` DATE COMMENT 'Date when the competency certification or assessment expires and requires renewal or reassessment. Null if the competency does not expire.',
    `gap_to_target` STRING COMMENT 'Assessment of the gap between current proficiency and target proficiency: none (at or above target), minor (one level below), moderate (two levels below), or significant (three or more levels below).. Valid values are `none|minor|moderate|significant`',
    `job_family` STRING COMMENT 'Job family or functional area to which this competency applies (e.g., Warehouse Operations, Transportation, Customs Brokerage, Customer Service, Management).',
    `job_level` STRING COMMENT 'Job level or grade for which this competency is relevant (e.g., Entry, Mid, Senior, Manager, Executive).',
    `last_used_date` DATE COMMENT 'Date when the employee last applied or used this competency in their work. Helps track competency currency and relevance.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this competency is mandatory for the employees current role (True) or optional (False).',
    `proficiency_level` STRING COMMENT 'Current proficiency level of the employee in this competency: novice (beginner), intermediate (developing), advanced (proficient), expert (highly skilled), or master (subject matter expert).. Valid values are `novice|intermediate|advanced|expert|master`',
    `proficiency_score` DECIMAL(18,2) COMMENT 'Numeric score representing the proficiency level, typically on a scale of 0-100 or 0-5, depending on the assessment framework used.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this competency record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this competency record was last updated in the system.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory body or governing organization that mandates this competency (e.g., DOT, ICAO, OSHA, WCO, IMO). Null if not a regulatory competency.',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals or reassessments for this competency. Null if renewal is not required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this competency requires periodic renewal or reassessment (True) or is a one-time assessment (False).',
    `role_requirement_flag` BOOLEAN COMMENT 'Indicates whether this competency is a formal requirement for the employees job role (True) or is an additional skill (False).',
    `source_system` STRING COMMENT 'Name of the source system from which this competency record originated (e.g., Workday HCM, external training provider system, manual entry).',
    `target_proficiency_level` STRING COMMENT 'Desired or target proficiency level for this competency, as defined by the employees development plan or role requirements.. Valid values are `novice|intermediate|advanced|expert|master`',
    `training_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for training and assessment to achieve this competency, including course fees, materials, and instructor costs.',
    `training_hours_completed` DECIMAL(18,2) COMMENT 'Total number of training hours completed by the employee to achieve this competency level.',
    `training_program_name` STRING COMMENT 'Name of the training program or course completed to develop this competency.',
    `verification_date` DATE COMMENT 'Date when the competency certification or credential was verified by the organization.',
    `verification_status` STRING COMMENT 'Status of verification for external certifications or credentials: verified (documentation confirmed), pending_verification (under review), not_verified (no documentation provided), or rejected (documentation invalid).. Valid values are `verified|pending_verification|not_verified|rejected`',
    CONSTRAINT pk_competency_record PRIMARY KEY(`competency_record_id`)
) COMMENT 'Role-based competency assessments and skill proficiency records for employees, capturing competency name, proficiency level, assessment date, assessor, and expiry. Covers operational competencies (forklift operation, WMS proficiency, TMS usage, customs classification) and professional competencies (leadership, communication, problem-solving). Supports talent management and workforce development planning.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Unique identifier for the shift schedule record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Shift schedules generate labor costs posted to cost centers. Operational cost tracking and labor budget variance analysis require linking scheduled shifts to the cost center that absorbs the expense.',
    `energy_consumption_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.energy_consumption_record. Business justification: Facility shift operations drive energy consumption patterns. Linking enables labor-energy optimization, Scope 2 emissions allocation to operational shifts, and energy intensity analysis per labor hour',
    `facility_id` BIGINT COMMENT 'Identifier of the warehouse, distribution center, or operational facility where the shift takes place.',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Incidents occurring during scheduled shifts require shift context for pattern analysis (shift type, time-of-day trends), fatigue correlation studies, and shift-specific safety metrics reporting. Trans',
    `observation_id` BIGINT COMMENT 'Foreign key linking to safety.safety_observation. Business justification: Safety observations made during shifts need shift context for trend analysis by shift type, time, and supervisor. Enables identification of shift-specific hazards and targeted safety interventions in ',
    `employee_id` BIGINT COMMENT 'Identifier of the employee assigned to this shift. Links to the employee master record in Workday HCM.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Shifts scheduled for on-site work at supplier facilities (vendor audits, quality inspections, on-site vendor management). Enables supplier site visit scheduling, on-site vendor management labor planni',
    `tertiary_shift_original_employee_id` BIGINT COMMENT 'Identifier of the employee originally scheduled for this shift, if the shift was subsequently swapped or reassigned. Null if no change occurred.',
    `absence_covered_flag` BOOLEAN COMMENT 'Indicates whether this shift was created to cover an employee absence (sick leave, vacation, emergency). True if this is a coverage shift, False otherwise.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the employee clocked out or ended the shift.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'The actual number of hours the employee worked during this shift, excluding breaks. Used for payroll calculation and labor cost allocation.',
    `actual_productivity_units` DECIMAL(18,2) COMMENT 'The actual productivity output achieved during this shift, measured in the same units as labor standard. Used to calculate performance variance.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the employee clocked in or started the shift. May differ from scheduled start due to early arrival or tardiness.',
    `assignment_status` STRING COMMENT 'Current status of the shift assignment. Scheduled = shift is planned but not yet confirmed; Confirmed = employee has acknowledged; In Progress = shift is currently active; Completed = shift finished normally; Cancelled = shift was cancelled before start; No Show = employee did not report; Swapped = shift was reassigned to another employee. [ENUM-REF-CANDIDATE: scheduled|confirmed|in_progress|completed|cancelled|no_show|swapped — 7 candidates stripped; promote to reference product]',
    `attendance_confirmation_method` STRING COMMENT 'Method used to confirm employee attendance for this shift. Biometric = fingerprint/facial recognition; Badge Scan = RFID badge; Manual Entry = supervisor input; Mobile App = employee self-service; Supervisor Approval = manager verification.. Valid values are `biometric|badge_scan|manual_entry|mobile_app|supervisor_approval`',
    `break_duration_minutes` STRING COMMENT 'Total duration of scheduled breaks during the shift in minutes (e.g., 30 minutes for lunch, 15 minutes for rest breaks). Unpaid breaks are excluded from hours worked.',
    `certification_required` STRING COMMENT 'Specific certifications or qualifications required to work this shift (e.g., Forklift License, DOT Medical Card, Hazmat Handling, IATA Dangerous Goods). Ensures compliance with safety and regulatory requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for labor cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Code identifying the operational department or cost center this shift is assigned to (e.g., WH-OPS, DOCK-INBOUND, FREIGHT-SORT). Used for labor cost allocation.',
    `equipment_assigned` STRING COMMENT 'Identifier or description of equipment assigned to the employee for this shift (e.g., Forklift #23, Scanner Device #456, Delivery Van #789).',
    `headcount_assigned` STRING COMMENT 'The number of employees currently assigned to this shift. May be less than, equal to, or greater than the requirement.',
    `headcount_requirement` STRING COMMENT 'The number of employees required for this shift to meet operational demand. Used for capacity planning and schedule optimization.',
    `integration_source_system` STRING COMMENT 'The source system from which this shift schedule record originated. Workday = HCM system; Manhattan WMS = warehouse labor management; Manual = direct entry; Mobile App = employee self-service.. Valid values are `workday|manhattan_wms|manual|mobile_app`',
    `job_role` STRING COMMENT 'The specific job role or function the employee is performing during this shift (e.g., Warehouse Picker, Dock Worker, Forklift Operator, Freight Handler, Driver, Supervisor).',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'The total labor cost for this shift including base pay, overtime premium, and shift differentials. Calculated based on actual hours worked and employee pay rate. Feeds finance cost allocation.',
    `labor_standard_units` DECIMAL(18,2) COMMENT 'The expected productivity output for this shift measured in standard units (e.g., cases picked, pallets moved, shipments processed). Used to calculate labor efficiency.',
    `notes` STRING COMMENT 'Free-text notes or comments about this shift assignment. May include special instructions, coverage reasons, performance observations, or incident notes.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked during this shift. Overtime is typically defined as hours worked beyond 8 hours per day or 40 hours per week, subject to local labor laws.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this shift schedule record was first created in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this shift schedule record was last updated in the data platform.',
    `schedule_created_by` STRING COMMENT 'Username or identifier of the scheduler, manager, or system that created this shift assignment.',
    `schedule_modified_by` STRING COMMENT 'Username or identifier of the person or system that last modified this shift assignment.',
    `schedule_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this shift schedule was last modified. Tracks changes for audit and compliance purposes.',
    `schedule_period_end_date` DATE COMMENT 'The last date of the scheduling period this shift belongs to.',
    `schedule_period_start_date` DATE COMMENT 'The first date of the scheduling period this shift belongs to. Scheduling periods are typically weekly or bi-weekly cycles.',
    `schedule_published_timestamp` TIMESTAMP COMMENT 'Date and time when this shift schedule was published and communicated to the employee. Used to track advance notice compliance with labor regulations.',
    `scheduled_duration_hours` DECIMAL(18,2) COMMENT 'The planned duration of the shift in hours, excluding breaks. Calculated from scheduled start and end times minus break duration.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'The planned date and time when the shift is scheduled to end.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'The planned date and time when the shift is scheduled to begin.',
    `shift_code` STRING COMMENT 'Business identifier or code for the shift template (e.g., WH-DAY-01, DOCK-NIGHT-A). Used for scheduling and reporting purposes.',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional pay rate percentage or amount applied for working undesirable shifts (e.g., night shift, weekend, holiday). Expressed as a percentage or flat amount per hour.',
    `shift_name` STRING COMMENT 'Human-readable name or description of the shift (e.g., Morning Warehouse Shift, Night Dock Operations).',
    `shift_type` STRING COMMENT 'Classification of the shift based on time of day and pattern. Day shifts typically run 6am-2pm, night shifts 10pm-6am, split shifts have a break in the middle, swing shifts cover evening hours, rotating shifts alternate between day/night, and on-call shifts are standby assignments.. Valid values are `day|night|split|swing|rotating|on_call`',
    `work_location_zone` STRING COMMENT 'Specific zone or area within the facility where the employee is assigned during this shift (e.g., Receiving Dock A, Pick Zone 3, Shipping Lane 5). Used for detailed labor tracking.',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Planned and executed shift schedules for operational workforce including warehouse pickers, dock workers, drivers, and freight handlers. Contains both the schedule definition (shift type, start/end times, location, headcount requirement) and individual employee shift assignments (assignment status, actual hours worked, overtime, breaks). Captures day/night/split shifts, schedule periods, swap requests, and absence coverage. Supports Manhattan WMS labor management integration, real-time labor visibility, and feeds labor cost allocation to finance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` (
    `shift_assignment_id` BIGINT COMMENT 'Unique identifier for the shift assignment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee assigned to this shift. Links to the employee master record in the workforce domain.',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the shift schedule template or pattern that this assignment is based on. Links to the shift schedule master.',
    `tertiary_shift_original_employee_id` BIGINT COMMENT 'Identifier of the employee originally scheduled for this shift before any swap or reassignment. Null if no change occurred. Used for schedule change tracking and audit.',
    `location_id` BIGINT COMMENT 'Identifier of the physical work location (warehouse, distribution center, terminal, or office) where the shift is performed.',
    `absence_reason_code` STRING COMMENT 'Code identifying the reason for absence if the employee did not complete the shift (e.g., sick leave, personal leave, emergency, unauthorized). Used for absence management and compliance tracking.',
    `actual_end_time` TIMESTAMP COMMENT 'Actual clock-out or end timestamp recorded when the employee completes the shift. Used for payroll, labor cost allocation, and attendance tracking.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'Actual duration worked in hours, calculated from actual start and end times minus break duration. Used for payroll processing and labor cost allocation.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual clock-in or start timestamp recorded when the employee begins the shift. Used for payroll, labor cost allocation, and attendance tracking.',
    `assignment_date` DATE COMMENT 'The calendar date for which this shift assignment is scheduled. Primary business event date for labor planning and scheduling.',
    `assignment_priority` STRING COMMENT 'Business priority level of this shift assignment. Used for resource allocation decisions and shift coverage planning during high-demand periods.. Valid values are `critical|high|normal|low`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the shift assignment. Tracks progression from scheduled through completion or cancellation. [ENUM-REF-CANDIDATE: scheduled|confirmed|in_progress|completed|swapped|cancelled|no_show|absent — 8 candidates stripped; promote to reference product]',
    `attendance_status` STRING COMMENT 'Actual attendance outcome for this shift assignment. Used for attendance tracking, performance management, and labor productivity analysis.. Valid values are `present|absent|late|early_departure|partial`',
    `break_duration_minutes` STRING COMMENT 'Total duration of breaks taken during the shift in minutes. Includes meal breaks and rest periods. Deducted from total shift time for payroll calculation.',
    `certification_required` STRING COMMENT 'Comma-separated list of certifications or qualifications required to perform this shift (e.g., forklift license, hazmat handling, DOT medical card, IATA dangerous goods). Used for compliance verification.',
    `compliance_verified` BOOLEAN COMMENT 'Indicates whether the assigned employee has been verified to hold all required certifications and qualifications for this shift. Used for regulatory compliance and safety management.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which labor hours and costs for this shift are allocated. Used for financial reporting and labor cost analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shift assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for labor cost amount. Supports multi-currency payroll and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `is_holiday_shift` BOOLEAN COMMENT 'Indicates whether this shift falls on a recognized holiday. Affects pay rate calculation and premium pay eligibility.',
    `is_overtime` BOOLEAN COMMENT 'Indicates whether this shift assignment includes overtime hours. Used for labor cost analysis and compliance reporting.',
    `is_weekend_shift` BOOLEAN COMMENT 'Indicates whether this shift falls on a weekend day. May affect pay rate calculation and shift differential eligibility.',
    `job_role_code` STRING COMMENT 'Code identifying the specific job role or function the employee performs during this shift (e.g., warehouse picker, forklift operator, dock loader, dispatcher).',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost for this shift assignment including base pay, overtime premiums, shift differentials, and benefits allocation. Used for financial reporting and operational cost analysis.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this shift assignment record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this shift assignment record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this shift assignment. May include special instructions, incident reports, or operational remarks.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours worked beyond the standard work period that qualify for overtime pay. Calculated based on applicable labor regulations and collective bargaining agreements.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Planned end date and time for the shift assignment. Used for labor planning and schedule adherence tracking.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Planned duration of the shift in hours. Calculated from scheduled start and end times. Used for labor capacity planning and Full-Time Equivalent (FTE) calculations.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned start date and time for the shift assignment. Used for labor planning and schedule adherence tracking.',
    `shift_differential_code` STRING COMMENT 'Code identifying the shift differential pay category applicable to this assignment (e.g., night shift, weekend, hazard). Used for payroll premium calculation.',
    `shift_type` STRING COMMENT 'Classification of the shift assignment type. Determines pay rules, labor cost allocation, and compliance tracking.. Valid values are `regular|overtime|on_call|standby|split|double`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the work location where this shift is performed. Used for accurate time conversion and cross-region labor reporting.',
    `created_by` STRING COMMENT 'User identifier or system account that created this shift assignment record. Used for audit trail and accountability.',
    CONSTRAINT pk_shift_assignment PRIMARY KEY(`shift_assignment_id`)
) COMMENT 'Transactional record assigning individual employees to specific shift schedules at a given work location and date. Captures assignment status (scheduled, confirmed, swapped, absent), actual start/end times, overtime flag, break duration, and labor hours logged. Enables real-time labor visibility for warehouse and freight operations and feeds labor cost allocation to finance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`absence_record` (
    `absence_record_id` BIGINT COMMENT 'Unique identifier for the absence record. Primary key.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the manager or supervisor who approved or denied the absence request.',
    `fmla_case_id` BIGINT COMMENT 'Unique identifier for the FMLA case if this absence is covered under FMLA regulations. Null if not FMLA-related.',
    `job_profile_id` BIGINT COMMENT 'Unique identifier of the employees job profile or role at the time of absence. Used for backfill and coverage planning.',
    `occupational_health_case_id` BIGINT COMMENT 'Foreign key linking to safety.occupational_health_case. Business justification: Occupational health cases result in absences (days away from work, restricted duty). Workers compensation and OSHA recordkeeping require correlation between health cases and absence records. Enables ',
    `org_unit_id` BIGINT COMMENT 'Unique identifier of the organizational unit (department, division, cost center) to which the employee belongs at the time of absence. Used for workforce planning and coverage analysis.',
    `primary_absence_employee_id` BIGINT COMMENT 'Unique identifier of the employee who is absent. Links to the employee master record in Workday HCM.',
    `shift_schedule_id` BIGINT COMMENT 'Unique identifier of the shift or schedule that the employee was assigned to during the absence period. Critical for warehouse and driver scheduling.',
    `absence_reason` STRING COMMENT 'Detailed reason or description provided by the employee for the absence. May include medical, personal, or family-related explanations.',
    `absence_status` STRING COMMENT 'Current status of the absence request in the approval and execution workflow.. Valid values are `requested|approved|denied|cancelled|completed`',
    `absence_type` STRING COMMENT 'Category of absence or leave taken by the employee. Includes annual leave, sick leave, FMLA (Family and Medical Leave Act), parental leave, bereavement, and unpaid leave.. Valid values are `annual_leave|sick_leave|fmla|parental_leave|bereavement|unpaid_leave`',
    `approval_date` DATE COMMENT 'Date when the absence request was approved or denied by the approver.',
    `cancellation_date` DATE COMMENT 'Date when the absence request was cancelled by the employee or manager. Null if not cancelled.',
    `cancellation_reason` STRING COMMENT 'Explanation provided when the absence request was cancelled. Null if not cancelled.',
    `coverage_arranged` BOOLEAN COMMENT 'Indicates whether replacement or coverage for the absent employee has been arranged (true) or not (false). Used for operational continuity tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this absence record was first created in the lakehouse. Used for data lineage and audit trail.',
    `denial_reason` STRING COMMENT 'Explanation provided by the approver if the absence request was denied. Null if approved.',
    `end_date` DATE COMMENT 'Last date of the absence period.',
    `external_absence_code` STRING COMMENT 'Unique identifier for this absence record in the source system (e.g., Workday HCM). Used for reconciliation and traceability.',
    `impact_on_operations` STRING COMMENT 'Assessment of the operational impact of this absence on business continuity, service delivery, and team productivity.. Valid values are `none|low|medium|high|critical`',
    `is_intermittent` BOOLEAN COMMENT 'Indicates whether this absence is part of an intermittent leave arrangement (true) or a continuous block of leave (false). Relevant for FMLA and chronic condition management.',
    `is_paid` BOOLEAN COMMENT 'Indicates whether the absence is paid leave (true) or unpaid leave (false).',
    `leave_balance_consumed` DECIMAL(18,2) COMMENT 'Amount of leave balance (in days or hours) deducted from the employees accrued leave balance for this absence.',
    `location_code` STRING COMMENT 'Code representing the employees primary work location at the time of absence. Used for site-level staffing coverage analysis.',
    `medical_certification_received` BOOLEAN COMMENT 'Indicates whether the required medical certification has been received (true) or is still pending (false). Null if not required.',
    `medical_certification_required` BOOLEAN COMMENT 'Indicates whether medical certification or documentation is required for this absence (true) or not (false). Typically required for sick leave and FMLA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this absence record was last modified in the lakehouse. Used for change tracking and audit trail.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the absence record. May include coordination details, special circumstances, or follow-up actions.',
    `request_date` DATE COMMENT 'Date when the employee submitted the absence request.',
    `return_to_work_date` DATE COMMENT 'Actual date when the employee returned to work following the absence. May differ from planned end date.',
    `source_system` STRING COMMENT 'Name of the source system from which this absence record was ingested. Typically Workday HCM Absence Management module.',
    `start_date` DATE COMMENT 'First date of the absence period.',
    `total_days` DECIMAL(18,2) COMMENT 'Total number of days (including partial days) covered by this absence record. Calculated based on working days and hours.',
    `total_hours` DECIMAL(18,2) COMMENT 'Total number of hours covered by this absence record. Used for partial-day absences and hourly leave tracking.',
    CONSTRAINT pk_absence_record PRIMARY KEY(`absence_record_id`)
) COMMENT 'Records of employee absences, leave requests, and time-off events including annual leave, sick leave, FMLA, parental leave, bereavement, and unpaid leave. Captures leave type, requested dates, approved dates, approver, leave balance consumed, and return-to-work date. Sourced from Workday HCM Absence Management and critical for operational staffing coverage planning.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` (
    `labor_cost_allocation_id` BIGINT COMMENT 'Unique identifier for the labor cost allocation record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the customer contract or Service Level Agreement (SLA) to which the labor cost is allocated for contract logistics billing.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account to which the labor cost is allocated, used for contract logistics billing and customer-specific cost tracking.',
    `employee_id` BIGINT COMMENT 'User identifier of the person or system process that created the labor cost allocation record.',
    `freight_order_id` BIGINT COMMENT 'Identifier of the specific freight order or shipment to which the labor cost is allocated, if applicable.',
    `labor_activity_id` BIGINT COMMENT 'Identifier of the specific warehouse operation (e.g., order fulfillment, receiving, put-away) to which the labor cost is allocated.',
    `modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person or system process that last modified the labor cost allocation record.',
    `payroll_record_id` BIGINT COMMENT 'Foreign key linking to workforce.payroll_record. Business justification: Labor cost allocations are derived from payroll records. One payroll_record may generate multiple labor_cost_allocation records when an employees time is split across multiple cost centers, projects,',
    `position_id` BIGINT COMMENT 'Identifier of the position held by the employee during the allocation period.',
    `primary_labor_employee_id` BIGINT COMMENT 'Identifier of the employee whose labor cost is being allocated.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Labor costs allocated to contract management activities (administration, compliance monitoring, performance tracking). Enables contract administration cost tracking, total cost of ownership analysis, ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Labor cost allocation to profit centers enables P&L reporting by business segment. EBITDA calculation, segment profitability analysis, and management reporting require linking allocated labor costs to',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Labor costs allocated to supplier management activities (vendor audits, on-site support, relationship management). Enables supplier relationship management cost tracking, vendor-specific labor spend a',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The specific labor cost amount allocated to this cost center, operational function, or customer contract, calculated as total_labor_cost_amount multiplied by allocation_percentage.',
    `allocated_hours` DECIMAL(18,2) COMMENT 'The number of hours allocated to this cost center, operational function, or customer contract, calculated as hours_worked multiplied by allocation_percentage.',
    `allocation_basis` STRING COMMENT 'The basis or driver used for allocating labor costs, such as hours worked, headcount, revenue generated, transaction volume, or facility square footage. [ENUM-REF-CANDIDATE: hours|headcount|revenue|volume|square_footage|transactions|custom — 7 candidates stripped; promote to reference product]',
    `allocation_date` DATE COMMENT 'The business date on which the labor cost allocation is effective, typically the last day of the pay period or the posting date.',
    `allocation_method` STRING COMMENT 'The method used to determine the allocation percentage, such as manual entry, time tracking system, activity-based costing, or default percentage split.. Valid values are `manual|time_tracking|activity_based|percentage_split|project_assignment|default_split`',
    `allocation_notes` STRING COMMENT 'Free-text notes or comments providing additional context or justification for the labor cost allocation.',
    `allocation_number` STRING COMMENT 'Business identifier for the labor cost allocation transaction, used for tracking and audit purposes.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the employees total labor cost allocated to this cost center, operational function, or customer contract. Sum of all allocation percentages for an employee in a pay period should equal 100.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the labor cost allocation record in the approval and posting workflow.. Valid values are `draft|pending_approval|approved|posted|rejected|reversed`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the labor cost allocation was approved.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The portion of the allocated amount representing base salary or regular wages for the pay period.',
    `benefits_amount` DECIMAL(18,2) COMMENT 'The portion of the allocated amount representing employer-paid benefits (health insurance, retirement contributions, etc.) for the pay period.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'The portion of the allocated amount representing bonuses, incentives, or variable compensation for the pay period.',
    `business_unit_code` STRING COMMENT 'The business unit code to which the labor cost is allocated for segment reporting and business unit Profit and Loss (P&L) analysis.',
    `cost_center_code` STRING COMMENT 'The cost center to which the labor cost is allocated, representing a specific operational unit or department.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the labor cost is incurred and allocated.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the labor cost allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated labor cost amount.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year to which the labor cost allocation applies.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which the labor cost allocation applies for financial reporting purposes.',
    `freight_mode` STRING COMMENT 'The freight transportation mode to which the labor cost is allocated, if applicable to freight forwarding operations.. Valid values are `air|ocean|road|rail|multimodal|not_applicable`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The Full-Time Equivalent allocation for this cost center or operational function, representing the proportion of a full-time position allocated.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which the labor cost is posted, typically representing labor expense or Operating Expenditure (OPEX).',
    `hours_worked` DECIMAL(18,2) COMMENT 'The total number of hours worked by the employee during the pay period that are being allocated.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this allocated labor cost is billable to a customer under a contract logistics or Third-Party Logistics (3PL) arrangement.',
    `is_capitalized` BOOLEAN COMMENT 'Indicates whether this allocated labor cost is capitalized as Capital Expenditure (CAPEX) rather than expensed as Operating Expenditure (OPEX), typically for project or asset development work.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the labor cost allocation record was last modified.',
    `operational_function` STRING COMMENT 'The specific operational function or business process to which the labor cost is allocated, aligning with core business processes. [ENUM-REF-CANDIDATE: express_parcel_delivery|freight_forwarding|warehouse_operations|last_mile_delivery|customs_brokerage|fleet_management|customer_service|administration|sales|it_support — 10 candidates stripped; promote to reference product]',
    `overtime_amount` DECIMAL(18,2) COMMENT 'The portion of the allocated amount representing overtime pay for the pay period.',
    `pay_period_end_date` DATE COMMENT 'The last day of the payroll period for which labor costs are being allocated.',
    `pay_period_start_date` DATE COMMENT 'The first day of the payroll period for which labor costs are being allocated.',
    `posting_date` DATE COMMENT 'The date on which the labor cost allocation was posted to the General Ledger (GL) in SAP S/4HANA Finance.',
    `region_code` STRING COMMENT 'The geographic region code to which the labor cost is allocated for regional reporting and analysis.',
    `total_labor_cost_amount` DECIMAL(18,2) COMMENT 'The total labor cost for the employee during the pay period, including base salary, overtime, bonuses, and employer-paid benefits, before allocation.',
    `warehouse_location_code` STRING COMMENT 'The warehouse or distribution center location code to which the labor cost is allocated, if applicable to warehouse operations.',
    CONSTRAINT pk_labor_cost_allocation PRIMARY KEY(`labor_cost_allocation_id`)
) COMMENT 'Transactional records allocating employee labor costs to specific cost centers, operational functions, freight modes, warehouse locations, or customer contracts. Captures allocation percentage, allocated amount, currency, pay period, cost center code, and operational reference (e.g., freight order, warehouse operation). Feeds SAP S/4HANA Finance for P&L and OPEX reporting and supports contract logistics billing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` (
    `fte_plan_id` BIGINT COMMENT 'Unique identifier for the FTE plan record. Primary key for workforce planning headcount targets.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this FTE plan. Provides audit trail for workforce planning governance.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: FTE plans consume approved budgets. Budget authorization workflow and headcount budget tracking require linking workforce plans to the specific budget version/line they draw from for financial control',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Workforce planning (FTE plans) must align with cost center budgets. Budget vs. plan variance reporting and headcount authorization require linking planned FTEs to their funding cost center.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit for which this FTE plan applies. Enables hierarchical rollup of workforce plans across business units, departments, and cost centers.',
    `version_id` BIGINT COMMENT 'Reference to the workforce planning version or scenario. Links to the planning cycle and version control for what-if analysis and multi-scenario planning.',
    `position_id` BIGINT COMMENT 'Reference to the specific position or job profile for which FTE is planned. Nullable when planning at aggregate job family level rather than individual position level.',
    `actual_fte` DECIMAL(18,2) COMMENT 'Current actual FTE headcount as of the measurement date. Used to calculate variance against plan and track hiring execution.',
    `approval_date` DATE COMMENT 'Date when the FTE plan was formally approved by authorized management. Establishes the baseline for plan execution tracking.',
    `average_salary` DECIMAL(18,2) COMMENT 'Average annual salary per FTE for this job family and location. Used for labor cost modeling and budget planning.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved labor budget amount for the planned FTE in this period. Includes base salary, benefits, and other compensation costs.',
    `budget_authorization_date` DATE COMMENT 'Date when the FTE plan and associated labor budget were formally authorized by finance and executive leadership.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the planned FTE location. Supports multi-country workforce planning and regulatory compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FTE plan record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount. Supports multi-currency workforce planning across global operations.. Valid values are `^[A-Z]{3}$`',
    `external_plan_code` STRING COMMENT 'Unique identifier for this FTE plan in the source system. Enables traceability and reconciliation with upstream HCM system.',
    `hiring_plan_status` STRING COMMENT 'Current status of the hiring plan execution for this FTE plan. Tracks progress from approval through fulfillment.. Valid values are `approved|in_progress|on_hold|completed|cancelled|pending_approval`',
    `is_critical_role` BOOLEAN COMMENT 'Indicates whether this position is classified as business-critical for operational continuity. Prioritizes hiring and succession planning for key roles.',
    `is_remote_eligible` BOOLEAN COMMENT 'Indicates whether the planned position is eligible for remote or hybrid work arrangements. Expands talent pool for non-operational roles.',
    `is_safety_sensitive` BOOLEAN COMMENT 'Indicates whether the planned position is classified as safety-sensitive under DOT or ICAO regulations. Requires additional compliance tracking for driver and crew roles.',
    `job_family` STRING COMMENT 'Broad job family classification for workforce planning aggregation. Enables planning and analysis by functional area across freight, warehouse, last-mile delivery, and support functions. [ENUM-REF-CANDIDATE: operations|warehouse|driver|customer_service|sales|finance|hr|it|legal|executive|management — 11 candidates stripped; promote to reference product]',
    `job_profile_code` STRING COMMENT 'Standardized job profile or role code from the enterprise job catalog. Used for competency mapping and labor cost modeling.',
    `location_code` STRING COMMENT 'Work location code where the planned FTE will be deployed. Critical for regional capacity planning and labor market analysis.',
    `minimum_education_level` STRING COMMENT 'Minimum education level required for the planned position. Used for talent acquisition planning and candidate screening.. Valid values are `high_school|associate|bachelor|master|doctorate|professional_certification`',
    `minimum_experience_years` STRING COMMENT 'Minimum years of relevant work experience required for the planned position. Guides recruitment strategy and compensation planning.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this FTE plan record. Tracks responsibility for plan changes and updates.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this FTE plan record was last modified. Tracks changes to workforce plans over time.',
    `open_positions` STRING COMMENT 'Number of approved but unfilled positions within this FTE plan. Tracks hiring pipeline and recruitment needs.',
    `plan_end_date` DATE COMMENT 'Effective end date for this FTE plan record. Defines the planning horizon and enables time-phased workforce planning.',
    `plan_notes` STRING COMMENT 'Free-text notes and comments regarding the FTE plan. Captures business justification, special considerations, and planning assumptions.',
    `plan_start_date` DATE COMMENT 'Effective start date for this FTE plan record. Defines when the planned headcount target becomes active.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the FTE plan record. Tracks progression from draft through approval to active execution.. Valid values are `draft|submitted|approved|active|closed|cancelled`',
    `planned_fte` DECIMAL(18,2) COMMENT 'Target FTE headcount approved for this organizational unit, job family, and planning period. Represents the authorized workforce capacity level.',
    `planning_period` STRING COMMENT 'Time period identifier for the workforce plan (e.g., 2024-Q1, 2024-FY, 2024-01). Supports annual, quarterly, and monthly planning cycles.',
    `region_code` STRING COMMENT 'Geographic region code for regional workforce planning and capacity analysis. Supports network planning for freight and fulfillment operations.',
    `requires_customs_clearance` BOOLEAN COMMENT 'Indicates whether the planned position requires customs clearance or security vetting (e.g., C-TPAT, AEO). Required for customs brokerage and international freight roles.',
    `requires_dot_certification` BOOLEAN COMMENT 'Indicates whether the planned position requires DOT certification (e.g., CDL for drivers). Impacts hiring requirements and compliance planning.',
    `source_system` STRING COMMENT 'Identifier of the source system from which this FTE plan record originated. Typically Workday HCM Workforce Planning module.',
    `time_type` STRING COMMENT 'Employment time type for the planned FTE. Distinguishes permanent full-time from part-time, contractor, and seasonal workforce.. Valid values are `full_time|part_time|contractor|temporary|seasonal`',
    `travel_requirement_percentage` STRING COMMENT 'Percentage of time the position requires business travel. Relevant for sales, operations management, and field service roles.',
    `union_code` STRING COMMENT 'Labor union or collective bargaining unit code if applicable. Required for compliance with union agreements and labor relations planning.',
    `variance_fte` DECIMAL(18,2) COMMENT 'Difference between planned and actual FTE (actual minus planned). Positive variance indicates overstaffing; negative indicates understaffing or open positions.',
    `work_shift` STRING COMMENT 'Primary work shift for the planned FTE. Critical for 24/7 operations planning in freight terminals, warehouses, and last-mile delivery.. Valid values are `day|night|swing|rotating|on_call`',
    `created_by` STRING COMMENT 'User identifier of the person who created this FTE plan record. Provides accountability for workforce planning data entry.',
    CONSTRAINT pk_fte_plan PRIMARY KEY(`fte_plan_id`)
) COMMENT 'Workforce planning records capturing approved FTE headcount targets by org unit, job family, location, and planning period. Tracks planned FTE, actual FTE, variance, hiring plan status, and budget authorization. Supports annual workforce planning cycles and operational capacity planning for freight, warehouse, and last-mile delivery functions. Sourced from Workday HCM Workforce Planning.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` (
    `recruitment_requisition_id` BIGINT COMMENT 'Unique identifier for the recruitment requisition record. Primary key.',
    `employee_id` BIGINT COMMENT 'System user identifier of the person who last modified this requisition record.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Requisitions must reference an approved budget for headcount authorization. Budget consumption tracking and hiring freeze enforcement require linking requisitions to the specific budget they draw agai',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Hiring requisitions require budget authorization from a cost center. Requisition approval workflow and open-position budget tracking depend on linking requisitions to the funding cost center for spend',
    `fte_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.fte_plan. Business justification: Recruitment requisitions are opened to fulfill FTE plan gaps. Linking requisition to fte_plan provides planning traceability and enables workforce planning analytics (e.g., time from plan approval to ',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile that defines the role requirements, competencies, and responsibilities for this requisition.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit or department where the position will be located.',
    `position_id` BIGINT COMMENT 'Reference to the position being filled by this requisition. Links to the approved position in the organizational structure.',
    `primary_recruitment_hiring_manager_employee_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager responsible for this requisition and will supervise the hired candidate.',
    `quaternary_recruitment_replacement_employee_id` BIGINT COMMENT 'Reference to the employee being replaced if this is a replacement or backfill requisition. Null for new positions.',
    `quinary_recruitment_employee_id` BIGINT COMMENT 'System user identifier of the person who created this requisition record.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Recruitment requisitions for contractor/temp labor from staffing suppliers. Enables contingent workforce procurement tracking, staffing vendor requisition management, temporary labor supplier performa',
    `tertiary_recruitment_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who provided final approval for this requisition, typically a senior manager or HR business partner.',
    `location_id` BIGINT COMMENT 'Reference to the primary work location or facility where the hired employee will be based.',
    `approval_date` DATE COMMENT 'Date when the requisition received final budget and headcount approval from authorized approvers.',
    `business_justification` STRING COMMENT 'Narrative explanation of the business need and rationale for opening this requisition. Used for approval routing and workforce planning.',
    `candidate_count` STRING COMMENT 'Total number of candidates who applied or were sourced for this requisition. Used for funnel analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this requisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for salary and compensation amounts.. Valid values are `^[A-Z]{3}$`',
    `flsa_status` STRING COMMENT 'Classification of the position under FLSA regulations determining overtime eligibility. Exempt positions are salaried and not eligible for overtime.. Valid values are `exempt|non_exempt`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The FTE allocation for this position expressed as a decimal where 1.00 represents full-time. Part-time positions have values less than 1.00.',
    `grade_level` STRING COMMENT 'Compensation grade or level assigned to the position within the organizations pay structure.. Valid values are `^[A-Z0-9]{1,5}$`',
    `headcount_quantity` STRING COMMENT 'Number of positions to be filled under this requisition. Typically 1 but may be higher for bulk hiring needs.',
    `interview_count` STRING COMMENT 'Total number of candidate interviews conducted for this requisition. Used for recruiting process analysis.',
    `is_remote_eligible` BOOLEAN COMMENT 'Flag indicating whether the position is eligible for remote or work-from-home arrangements.',
    `is_safety_sensitive` BOOLEAN COMMENT 'Flag indicating whether the position is classified as safety-sensitive requiring additional screening and compliance with safety regulations.',
    `job_description` STRING COMMENT 'Detailed description of the role responsibilities, requirements, and qualifications used in job postings and candidate communications.',
    `job_family` STRING COMMENT 'Broad occupational category or job family that groups similar roles together for talent management and career pathing purposes.',
    `job_function` STRING COMMENT 'Functional area or business domain of the role such as operations, finance, sales, or logistics.',
    `job_title` STRING COMMENT 'The official job title for the position being recruited. Used in job postings and offer letters.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for candidates applying to this position.. Valid values are `high_school|associate|bachelor|master|doctorate|professional_certification`',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant work experience required for this position.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this requisition record was last modified or updated.',
    `offer_acceptance_rate` DECIMAL(18,2) COMMENT 'Percentage of offers extended that were accepted by candidates for this requisition. Used to measure recruiting effectiveness.',
    `posting_title` STRING COMMENT 'The job title used in external job postings and advertisements. May differ from the internal job title for marketing purposes.',
    `priority_level` STRING COMMENT 'Business priority assigned to this requisition indicating urgency of filling the position. Used for recruiter workload prioritization.. Valid values are `critical|high|medium|low`',
    `requires_customs_clearance` BOOLEAN COMMENT 'Flag indicating whether the position requires security clearance or background checks for customs and trade compliance roles.',
    `requires_dot_certification` BOOLEAN COMMENT 'Flag indicating whether the position requires DOT certification for safety-sensitive roles such as commercial drivers or aircraft crew.',
    `requisition_close_date` DATE COMMENT 'Date when the requisition was closed either due to being filled, cancelled, or withdrawn. Marks the end of the time-to-fill measurement.',
    `requisition_number` STRING COMMENT 'Externally visible unique requisition number assigned by the recruiting system. Used for tracking and communication with hiring managers and candidates.. Valid values are `^REQ-[0-9]{8}$`',
    `requisition_open_date` DATE COMMENT 'Date when the requisition was officially opened and approved for recruiting. Marks the start of the time-to-fill measurement.',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the recruitment requisition. Tracks progression from opening through closure.. Valid values are `open|in_progress|on_hold|filled|cancelled|closed`',
    `requisition_type` STRING COMMENT 'Classification of the requisition based on the hiring need. Distinguishes between new positions, replacements, and temporary staffing. [ENUM-REF-CANDIDATE: new_hire|replacement|backfill|expansion|seasonal|temporary|contractor — 7 candidates stripped; promote to reference product]',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'Maximum salary amount for the position based on the assigned grade level and market data. Used for offer preparation and budget planning.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'Minimum salary amount for the position based on the assigned grade level and market data. Used for offer preparation and budget planning.',
    `sourcing_channel` STRING COMMENT 'Primary channel or method used to source candidates for this requisition. Used for recruiting effectiveness analysis. [ENUM-REF-CANDIDATE: internal|external|referral|agency|campus|job_board|social_media|direct_sourcing — 8 candidates stripped; promote to reference product]',
    `target_start_date` DATE COMMENT 'Desired or planned start date for the hired candidate to begin employment. Used for workforce planning and onboarding scheduling.',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from requisition open date to requisition close date. Key performance indicator (KPI) for recruiting efficiency.',
    `time_type` STRING COMMENT 'Employment time classification indicating whether the position is full-time, part-time, seasonal, or temporary.. Valid values are `full_time|part_time|seasonal|temporary`',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of time the role requires business travel expressed as an integer from 0 to 100.',
    `union_code` STRING COMMENT 'Code identifying the labor union representing this position if applicable. Null for non-union positions.. Valid values are `^[A-Z0-9]{2,10}$`',
    CONSTRAINT pk_recruitment_requisition PRIMARY KEY(`recruitment_requisition_id`)
) COMMENT 'Hiring requisition records capturing approved headcount requests, job profile, target start date, hiring manager, recruiter assignment, requisition status (open, in-progress, filled, cancelled), and sourcing channel. Tracks time-to-fill, offer acceptance rate, and links to the position being filled. Sourced from Workday HCM Recruiting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created the performance review record. Audit trail for accountability.',
    `modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified the performance review record. Audit trail for accountability.',
    `position_id` BIGINT COMMENT 'Identifier of the position held by the employee during the review period. Links to the position master record for organizational context.',
    `primary_performance_employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed. Links to the employee master record in the workforce domain.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the primary reviewer, typically the direct manager or supervisor conducting the performance evaluation.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Employee performance reviews increasingly include sustainability KPIs (fuel efficiency, waste reduction, carbon targets). Linking enables target cascading, individual accountability tracking, and sust',
    `worker_assignment_id` BIGINT COMMENT 'Foreign key linking to workforce.worker_assignment. Business justification: Performance reviews are conducted in the context of a specific worker assignment. While performance_review already has employee_id and position_id, linking to worker_assignment provides the full assig',
    `acknowledgement_date` DATE COMMENT 'Date when the employee acknowledged receipt and review of their performance evaluation. Confirms the employee has been informed of the review outcome.',
    `acknowledgement_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee has acknowledged their performance review. True indicates the employee has reviewed and acknowledged the evaluation.',
    `bonus_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee is eligible for a performance bonus based on this review. Supports variable compensation planning.',
    `bonus_payout_percentage` DECIMAL(18,2) COMMENT 'Percentage of target bonus to be paid out based on performance review results. Expressed as a percentage of the employees target bonus amount. Business-confidential data.',
    `calibration_date` DATE COMMENT 'Date when the performance review rating was calibrated with peer managers. Ensures consistency in rating standards across teams and departments.',
    `calibration_status` STRING COMMENT 'Status indicating whether the performance review has undergone calibration with peer managers to ensure rating consistency and fairness across the organization.. Valid values are `not_calibrated|pending_calibration|calibrated|calibration_waived`',
    `competency_rating_score` DECIMAL(18,2) COMMENT 'Aggregate numeric score representing the employees demonstration of core competencies and behavioral expectations during the review period.',
    `cost_center_code` STRING COMMENT 'Cost center code associated with the employee during the review period. Used for financial reporting and labor cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was first created in the system. Audit trail for record creation.',
    `customer_service_rating` STRING COMMENT 'Rating of the employees customer service quality and responsiveness. Applicable to customer-facing roles in express delivery, freight forwarding, and customer support.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable`',
    `department_code` STRING COMMENT 'Department code of the employee during the review period. Provides organizational context for performance analysis.',
    `development_areas` STRING COMMENT 'Summary of areas where the employee needs development or improvement. Informs training plans and coaching priorities.',
    `development_plan_created_flag` BOOLEAN COMMENT 'Boolean indicator of whether an individual development plan was created as part of this performance review. Supports career development and skill-building initiatives.',
    `employee_self_assessment_comments` STRING COMMENT 'Narrative comments provided by the employee as part of their self-assessment. Captures the employees perspective on their achievements and development needs.',
    `goal_achievement_score` DECIMAL(18,2) COMMENT 'Numeric score representing the percentage or degree to which the employee achieved their assigned goals during the review period. Used for performance-based compensation decisions.',
    `job_family` STRING COMMENT 'Job family classification of the employees role during the review period. Used for competency benchmarking and career pathing.',
    `key_strengths` STRING COMMENT 'Summary of the employees key strengths and areas of excellence identified during the review. Used for talent management and role alignment.',
    `leadership_rating` STRING COMMENT 'Rating of the employees leadership capabilities and behaviors. Applicable to roles with leadership responsibilities or leadership potential assessment.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|not_applicable`',
    `manager_comments` STRING COMMENT 'Detailed narrative comments provided by the reviewing manager. Includes strengths, areas for improvement, and specific examples of performance during the review period.',
    `merit_increase_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee is eligible for a merit-based salary increase based on this performance review. Drives compensation planning decisions.',
    `merit_increase_percentage` DECIMAL(18,2) COMMENT 'Recommended percentage increase in base salary as a result of this performance review. Used for merit-based compensation adjustments. Business-confidential data.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was last modified. Audit trail for record updates.',
    `overall_rating` STRING COMMENT 'Summary performance rating assigned to the employee for the review period. Represents the holistic assessment of performance against expectations.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall performance rating. Typically on a scale of 1.0 to 5.0, used for quantitative analysis and merit calculations.',
    `pip_flag` BOOLEAN COMMENT 'Boolean indicator of whether a Performance Improvement Plan was initiated as a result of this review. True indicates the employee is placed on a formal improvement plan.',
    `pip_start_date` DATE COMMENT 'Start date of the Performance Improvement Plan if one was initiated. Marks the beginning of the formal improvement period.',
    `promotion_recommended_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee is recommended for promotion based on this performance review. Used for succession planning and talent management.',
    `review_completion_date` DATE COMMENT 'Date when the performance review was finalized and approved. Represents the official completion timestamp for the review cycle.',
    `review_period_end_date` DATE COMMENT 'End date of the performance review period being evaluated. Marks the close of the evaluation cycle.',
    `review_period_start_date` DATE COMMENT 'Start date of the performance review period being evaluated. Typically aligns with fiscal year or mid-year cycle.',
    `review_status` STRING COMMENT 'Current lifecycle status of the performance review. Tracks progression from draft through calibration to final approval. [ENUM-REF-CANDIDATE: draft|submitted|manager_review|calibration|approved|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `review_template_name` STRING COMMENT 'Name of the performance review template used for this evaluation. Different templates may apply to different job families or organizational levels.',
    `review_type` STRING COMMENT 'Type of performance review being conducted. Distinguishes between annual, mid-year, probationary, project-based, ad-hoc, and exit reviews.. Valid values are `annual|mid_year|probationary|project_based|ad_hoc|exit`',
    `reviewer_name` STRING COMMENT 'Full name of the primary reviewer conducting the performance evaluation. Denormalized for reporting convenience.',
    `safety_compliance_rating` STRING COMMENT 'Rating of the employees adherence to safety protocols and regulations. Critical for warehouse, fleet, and freight operations roles. Aligns with DOT and ICAO safety requirements.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable`',
    `succession_readiness_level` STRING COMMENT 'Assessment of the employees readiness to move into a higher-level or critical role. Used for succession planning and talent pipeline management.. Valid values are `ready_now|ready_1_year|ready_2_3_years|not_ready|not_applicable`',
    `teamwork_rating` STRING COMMENT 'Rating of the employees ability to work effectively in teams and collaborate across functions. Critical for cross-functional logistics operations.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Annual and mid-year employee performance review records capturing review period, overall rating, goal achievement scores, competency ratings, manager comments, calibration status, and performance improvement plan (PIP) flag. Supports talent management, succession planning, and merit-based compensation decisions. Sourced from Workday HCM Performance Management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Unique identifier for the training record. Primary key for the training record entity.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Sustainability training programs (eco-driving, waste reduction, energy efficiency) must link to corporate initiatives for compliance tracking, ROI measurement, and regulatory reporting of workforce ca',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who completed the training or competency assessment. Links to the employee master record in the workforce domain.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Training on supplier-specific systems, processes, requirements (vendor portal training, supplier integration). Enables supplier integration training tracking, vendor-specific competency management, su',
    `tertiary_training_verified_by_employee_id` BIGINT COMMENT 'Unique identifier of the employee or compliance officer who verified the training certification or competency. Links to employee master record. Used for audit trail and accountability.',
    `assessment_date` DATE COMMENT 'Date on which the competency proficiency level was formally assessed or evaluated. May differ from completion date for ongoing competency evaluations separate from initial training.',
    `assessment_method` STRING COMMENT 'Method used to evaluate competency proficiency or training completion. Written exam indicates knowledge test. Practical test indicates hands-on demonstration. Observation indicates supervisor evaluation during work. Self-assessment indicates employee self-rating. Manager assessment indicates formal manager evaluation. Peer review indicates colleague feedback. Simulation indicates performance in simulated environment. [ENUM-REF-CANDIDATE: written_exam|practical_test|observation|self_assessment|manager_assessment|peer_review|simulation — 7 candidates stripped; promote to reference product]',
    `assessor_name` STRING COMMENT 'Full name of the individual who conducted the competency assessment or training evaluation. May be internal manager, certified assessor, or external evaluator. Used for reporting and audit purposes.',
    `certification_authority` STRING COMMENT 'Name of the regulatory body, industry association, or certifying organization that issued the certification or credential. Examples: US DOT, IATA, IMO, OSHA, National Safety Council, customs authorities.',
    `certification_number` STRING COMMENT 'Unique certificate or credential number issued by the certifying authority upon successful completion. Required for regulatory certifications (DOT medical examiner certificate, IATA DG shipper certificate, customs broker license). Used for verification and audit purposes.',
    `completion_date` DATE COMMENT 'Date on which the employee successfully completed the training course or passed the competency assessment. Used to track compliance status and renewal requirements.',
    `compliance_requirement_flag` BOOLEAN COMMENT 'Indicates whether the training is required to meet regulatory compliance obligations. True indicates training mandated by DOT, IATA, C-TPAT, IMDG Code, customs regulations, or other governing bodies. False indicates non-regulatory training.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the training costs are allocated. Used for labor cost tracking, budget management, and financial reporting of training investments by organizational unit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training record was first created in the system. Used for audit trail, data lineage, and record lifecycle tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount. Examples: USD, EUR, GBP, CNY. Used for multi-currency financial reporting and cost analysis.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which the training certification or competency qualification becomes valid and effective. May differ from completion date if there is a processing or approval delay. Used for compliance verification and role assignment.',
    `expiry_date` DATE COMMENT 'Date on which the training certification or competency qualification expires and requires renewal. Critical for regulatory compliance tracking (DOT certifications, IATA DG, customs broker licenses). Null for non-expiring competencies.',
    `job_family` STRING COMMENT 'Broad occupational category or job family for which this training or competency is relevant. Examples: Operations, Transportation, Warehouse, Customs Brokerage, Customer Service, Sales, Finance, IT. Used to align training with role requirements and career paths.',
    `job_level` STRING COMMENT 'Organizational level or grade for which this training or competency is targeted. Examples: Entry Level, Individual Contributor, Team Lead, Manager, Senior Manager, Director, Executive. Used for competency framework alignment and development planning.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the training or competency is mandatory for the employees role. True indicates required training that must be completed for compliance or job performance. False indicates optional or elective training for professional development.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the training record was last updated or modified. Used for audit trail, change tracking, and data synchronization. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text notes or comments about the training completion, competency assessment, or special circumstances. May include assessor observations, accommodation details, remediation plans, or audit findings. Used for documentation and follow-up actions.',
    `pass_fail_status` STRING COMMENT 'Outcome of the training assessment or competency evaluation. Pass indicates successful completion meeting minimum requirements. Fail indicates unsuccessful attempt. Incomplete indicates assessment not yet finished. Waived indicates requirement exempted. In progress indicates ongoing assessment.. Valid values are `pass|fail|incomplete|waived|in_progress`',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum score required to successfully pass the training assessment or competency evaluation. Used to determine pass/fail status. Typically expressed as a percentage or raw score threshold.',
    `proficiency_level` STRING COMMENT 'Assessed level of proficiency or mastery for the competency. Novice indicates foundational awareness. Basic indicates ability to perform with supervision. Intermediate indicates independent performance. Advanced indicates ability to mentor others. Expert indicates recognized authority. Master indicates industry-leading expertise.. Valid values are `novice|basic|intermediate|advanced|expert|master`',
    `proficiency_score` DECIMAL(18,2) COMMENT 'Numeric score representing the level of competency proficiency achieved. May be expressed as a percentage, scale rating, or standardized score depending on assessment methodology. Used for talent analytics and capability gap analysis.',
    `provider_name` STRING COMMENT 'Name of the organization or individual that delivered the training or conducted the competency assessment. May be internal training department, external vendor, regulatory body, or certified assessor.',
    `provider_type` STRING COMMENT 'Classification of the training provider. Internal indicates company-delivered training. External vendor includes third-party training companies. Regulatory body includes IATA, DOT, customs authorities. Industry association includes freight forwarder associations, logistics councils.. Valid values are `internal|external_vendor|regulatory_body|industry_association|academic_institution`',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority or governing body that mandates the training requirement. Examples: US Department of Transportation (DOT), International Air Transport Association (IATA), International Maritime Organization (IMO), Customs and Border Protection (CBP), Occupational Safety and Health Administration (OSHA).',
    `renewal_due_date` DATE COMMENT 'Target date by which the training or certification must be renewed to maintain compliance. May be set earlier than expiry date to allow processing time. Used for proactive renewal scheduling and compliance alerts.',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals of the training certification or competency. Common values: 12 (annual), 24 (biennial), 36 (triennial). Null for non-expiring qualifications. Used to calculate renewal due dates and compliance tracking.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the training certification or competency requires periodic renewal. True indicates time-limited certification that must be renewed. False indicates one-time or permanent qualification.',
    `role_requirement_flag` BOOLEAN COMMENT 'Indicates whether the training or competency is a formal requirement for the employees current job role. True indicates training is part of the role profile and required for job performance. False indicates training is supplementary or developmental.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the employee on the training assessment or competency evaluation. Typically expressed as a percentage (0.00 to 100.00) or raw score depending on assessment method.',
    `source_system` STRING COMMENT 'Name of the operational system from which the training record was sourced. Examples: Workday HCM, external learning management system (LMS), regulatory authority database, manual entry. Used for data lineage and integration troubleshooting.',
    `training_category` STRING COMMENT 'High-level classification of the training content area. Regulatory compliance includes DOT, IATA DG, C-TPAT, IMDG Code, customs procedures. Operational skills include equipment operation, system usage. Safety certification includes OSHA, first aid, emergency response.. Valid values are `regulatory_compliance|operational_skills|safety_certification|technical_proficiency|soft_skills|management_development`',
    `training_code` STRING COMMENT 'Standardized code or identifier for the training course or competency in the learning management system. Used for catalog lookup and reporting.',
    `training_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for the training course or competency assessment. Includes tuition fees, materials, travel expenses, and allocated labor costs. Used for training ROI analysis and budget tracking.',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of hours the employee spent completing the training course or competency development program. Used for compliance reporting, labor cost allocation, and professional development tracking.',
    `training_method` STRING COMMENT 'Method by which the training was delivered. Classroom indicates in-person instructor-led training. Online indicates e-learning or virtual training. On-the-job indicates practical training during work. Blended indicates combination of methods. Simulation indicates virtual or physical simulation environment. Workshop indicates hands-on group training.. Valid values are `classroom|online|on_the_job|blended|simulation|workshop`',
    `training_name` STRING COMMENT 'Full name of the training course, certification program, or competency being assessed. Examples: DOT Hazmat Awareness, IATA Dangerous Goods Regulations, Forklift Operator Certification, WMS Advanced User Training.',
    `training_status` STRING COMMENT 'Current status of the training record. Completed indicates successful finish. In progress indicates ongoing training. Scheduled indicates future enrollment. Overdue indicates missed deadline. Expired indicates certification lapsed. Waived indicates requirement exempted. Cancelled indicates training withdrawn. [ENUM-REF-CANDIDATE: completed|in_progress|scheduled|overdue|expired|waived|cancelled — 7 candidates stripped; promote to reference product]',
    `training_type` STRING COMMENT 'Category of training or competency assessment. Compliance includes DOT, IATA, C-TPAT, IMDG, customs procedures. Operational includes forklift, WMS, TMS. Professional development includes career advancement programs.. Valid values are `compliance|operational|professional_development|safety|technical|leadership`',
    `verification_date` DATE COMMENT 'Date on which the training certification or competency was verified or validated by the certifying authority or internal compliance team. Used for audit trail and compliance documentation.',
    `verification_status` STRING COMMENT 'Status of third-party verification or validation of the training certification. Verified indicates certification confirmed by issuing authority. Pending indicates verification in progress. Rejected indicates certification could not be validated. Not required indicates no external verification needed.. Valid values are `verified|pending|rejected|not_required`',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Unified record of employee training completions, skill assessments, and competency proficiency levels. Covers mandatory compliance training (DOT regulations, IATA DG awareness, C-TPAT security, IMDG Code, customs procedures), operational skills (forklift, WMS, TMS), professional development, and assessed competency levels with proficiency ratings. Captures course/competency name, provider/assessor, completion/assessment date, score, proficiency level, pass/fail status, and renewal dates. Critical for regulatory compliance, talent development, and role-based capability tracking across all operational and corporate functions.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` (
    `hours_of_service_log_id` BIGINT COMMENT 'Unique identifier for the hours of service log record. Primary key for the HOS log entry.',
    `fatigue_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.fatigue_risk_assessment. Business justification: Fatigue risk assessments analyze HOS log patterns to verify compliance and identify fatigue trends. DOT regulations require correlation between duty hours and fatigue assessments. Enables automated fl',
    `employee_id` BIGINT COMMENT 'Reference to the commercial driver employee who generated this HOS record. Links to the employee master record in the workforce domain.',
    `tertiary_hours_employee_id` BIGINT COMMENT 'Identifier of the user (driver or supervisor) who made edits to this log entry. Required for audit trail and accountability.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the commercial motor vehicle operated during this duty period. Links to the fleet vehicle master record.',
    `annotation_text` STRING COMMENT 'Free-text annotation or comment added by the driver to explain special circumstances, duty status changes, or other relevant information for this log entry.',
    `certification_status` STRING COMMENT 'The certification status of this HOS log. Certified: driver has reviewed and certified the log as accurate. Uncertified: log has not been certified by driver. Rejected: log was rejected by driver or supervisor. Pending: awaiting driver certification.. Valid values are `certified|uncertified|rejected|pending`',
    `certification_timestamp` TIMESTAMP COMMENT 'The date and time when the driver certified this HOS log as accurate and complete. Required within 13 days of the log date per DOT regulations.',
    `cycle_hours_accumulated` DECIMAL(18,2) COMMENT 'Cumulative on-duty hours for the current 7-day or 8-day cycle. Used to enforce the 60-hour/7-day or 70-hour/8-day limits per DOT regulations.',
    `cycle_type` STRING COMMENT 'The regulatory cycle the driver is operating under. 60-hour/7-day cycle for drivers who do not operate every day of the week. 70-hour/8-day cycle for drivers who operate every day of the week.. Valid values are `60_hour_7_day|70_hour_8_day`',
    `dispatch_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the driver is eligible for new dispatch assignments based on current HOS status. True if eligible, False if driver has insufficient hours remaining.',
    `distance_traveled` DECIMAL(18,2) COMMENT 'Total distance traveled in miles or kilometers during this duty status segment. Calculated from odometer readings or GPS tracking.',
    `distance_unit` STRING COMMENT 'Unit of measure for distance values recorded in this log entry. Typically miles for US operations, kilometers for international operations.. Valid values are `miles|kilometers`',
    `driving_hours_accumulated` DECIMAL(18,2) COMMENT 'Cumulative driving hours for the current duty period up to and including this log entry. Used to enforce the 11-hour driving limit per DOT regulations.',
    `duration_hours` DECIMAL(18,2) COMMENT 'The total duration in hours that the driver spent in this duty status segment. Calculated as the difference between start and end timestamps.',
    `duty_status` STRING COMMENT 'The drivers duty status for this log segment. Off Duty: driver is relieved from work and all responsibility for performing work. Sleeper Berth: driver is resting in the sleeper berth of the vehicle. Driving: driver is operating the commercial motor vehicle. On Duty Not Driving: driver is performing work other than driving (loading, inspections, paperwork, etc.).. Valid values are `off_duty|sleeper_berth|driving|on_duty_not_driving`',
    `duty_status_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the driver ended this duty status segment and transitioned to a different status.',
    `duty_status_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the driver began this duty status segment. Captured automatically by Electronic Logging Device (ELD) or manually recorded.',
    `edit_flag` BOOLEAN COMMENT 'Indicates whether this log entry has been edited or modified after initial creation. True if edited, False if original. All edits must be tracked per DOT requirements.',
    `edit_reason` STRING COMMENT 'Explanation provided by the driver or supervisor for why this log entry was edited. Required for audit trail and DOT compliance.',
    `edited_timestamp` TIMESTAMP COMMENT 'The date and time when this log entry was last edited. Part of the required audit trail for DOT compliance.',
    `eld_device_code` STRING COMMENT 'Unique identifier of the Electronic Logging Device that captured this record. Required for ELD compliance and audit trail.',
    `eld_registration_number` STRING COMMENT 'The FMCSA registration identifier for the ELD device. Required for DOT compliance verification.',
    `home_terminal_time_zone` STRING COMMENT 'The time zone of the drivers home terminal. HOS calculations are based on home terminal time per DOT regulations.',
    `hours_remaining_in_cycle` DECIMAL(18,2) COMMENT 'Calculated number of hours remaining in the current 60/70-hour cycle before the driver must take a 34-hour restart. Used for weekly dispatch planning.',
    `hours_remaining_on_duty` DECIMAL(18,2) COMMENT 'Calculated number of on-duty hours remaining before the driver reaches the 14-hour on-duty limit. Used for dispatch planning and route optimization.',
    `hours_remaining_to_drive` DECIMAL(18,2) COMMENT 'Calculated number of driving hours remaining before the driver reaches the 11-hour driving limit. Used for dispatch planning and load assignment.',
    `location_description` STRING COMMENT 'Human-readable description of the location where the duty status change occurred. Typically includes city and state or nearest landmark.',
    `location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate where the duty status change occurred. Captured automatically by Electronic Logging Device (ELD) GPS system.',
    `location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate where the duty status change occurred. Captured automatically by Electronic Logging Device (ELD) GPS system.',
    `log_date` DATE COMMENT 'The calendar date for which this hours of service record applies. Represents the 24-hour duty period starting at midnight in the drivers home terminal time zone.',
    `log_entry_method` STRING COMMENT 'The method by which this HOS record was created. Automatic ELD: captured automatically by electronic logging device. Manual ELD: driver manually entered via ELD interface. Paper Log: transcribed from paper logbook for legacy compliance.. Valid values are `automatic_eld|manual_eld|paper_log`',
    `odometer_reading_end` DECIMAL(18,2) COMMENT 'Vehicle odometer reading in miles or kilometers at the end of this duty status segment. Used to calculate distance traveled during the segment.',
    `odometer_reading_start` DECIMAL(18,2) COMMENT 'Vehicle odometer reading in miles or kilometers at the start of this duty status segment. Used for distance verification and compliance auditing.',
    `on_duty_hours_accumulated` DECIMAL(18,2) COMMENT 'Cumulative on-duty hours (driving plus on-duty not driving) for the current duty period. Used to enforce the 14-hour on-duty limit per DOT regulations.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this HOS log record was first created in the database. Part of the audit trail for data lineage and compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this HOS log record was last updated in the database. Tracks all modifications for audit and compliance purposes.',
    `rest_break_compliant_flag` BOOLEAN COMMENT 'Indicates whether the driver has taken the required 30-minute rest break within the first 8 hours of driving. True if compliant, False if violation.',
    `shipment_number` STRING COMMENT 'The shipment or load number associated with this duty period. Links HOS records to freight operations for dispatch and billing purposes.',
    `trailer_number` STRING COMMENT 'Identification number of the trailer being hauled during this duty status segment. Required for DOT compliance and asset tracking.',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether this log entry resulted in a violation of DOT hours of service regulations. True if a violation occurred, False otherwise.',
    `violation_severity` STRING COMMENT 'The severity classification of the HOS violation for compliance reporting and driver safety scoring. Critical violations may result in immediate out-of-service orders.. Valid values are `none|minor|moderate|major|critical`',
    `violation_type` STRING COMMENT 'The specific type of HOS violation that occurred. Driving Limit: exceeded 11-hour driving limit. On Duty Limit: exceeded 14-hour on-duty limit. Cycle Limit: exceeded 60/70-hour cycle limit. Rest Break: failed to take required 30-minute break. Sleeper Berth: improper use of sleeper berth provision. None: no violation.. Valid values are `driving_limit|on_duty_limit|cycle_limit|rest_break|sleeper_berth|none`',
    CONSTRAINT pk_hours_of_service_log PRIMARY KEY(`hours_of_service_log_id`)
) COMMENT 'Electronic logging device (ELD) and manual hours-of-service (HOS) records for commercial drivers, capturing driving hours, on-duty hours, off-duty hours, sleeper berth time, cycle used, and violation flags. Mandatory under DOT FMCSA 49 CFR Part 395 for all CMV operators. Feeds driver dispatch eligibility checks and supports DOT audit compliance. Integrates with fleet telematics and GPS systems.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` (
    `drug_alcohol_test_id` BIGINT COMMENT 'Unique identifier for the drug and alcohol test record. Primary key for the drug_alcohol_test product.',
    `driver_safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.driver_safety_program. Business justification: Drug/alcohol testing is administered under driver safety programs (random pool management, post-accident protocols, reasonable suspicion). DOT compliance requires program-level tracking of testing rat',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who underwent the drug and alcohol test. Links to the employee master record in the workforce domain.',
    `random_pool_id` BIGINT COMMENT 'Identifier of the random testing pool from which the employee was selected for a random test. Used to track compliance with DOT minimum random testing rate requirements (50% for drugs, 10% for alcohol).',
    `accident_date` DATE COMMENT 'Date of the qualifying accident that triggered a post-accident test. DOT requires post-accident testing for accidents involving fatality, bodily injury requiring immediate medical treatment, or disabling damage to a vehicle requiring tow-away.',
    `accident_report_number` STRING COMMENT 'Official accident or incident report number associated with a post-accident test. Links the test record to the accident investigation file.',
    `alcohol_concentration` DECIMAL(18,2) COMMENT 'Measured blood alcohol concentration (BAC) level expressed as a decimal (e.g., 0.040 for 0.04%). DOT prohibits safety-sensitive duties at 0.04% or higher. Null if alcohol test was not performed or result was refused/cancelled.',
    `alcohol_result` STRING COMMENT 'Specific result of the alcohol component of the test. Separated from drug result for tests that include both categories.. Valid values are `negative|positive|refused|cancelled|invalid|not tested`',
    `cdl_required` BOOLEAN COMMENT 'Indicates whether the employee is required to hold a valid Commercial Driver License (CDL) for the position being tested. CDL holders are subject to FMCSA drug and alcohol testing regulations.',
    `chain_of_custody_number` STRING COMMENT 'Unique chain of custody form number that tracks the specimen from collection through laboratory analysis. Critical for maintaining specimen integrity and legal defensibility of test results.',
    `collection_site_code` STRING COMMENT 'Standardized code identifying the collection site. Used for vendor management and compliance reporting.',
    `collection_site_name` STRING COMMENT 'Name of the facility or location where the specimen was collected. May be an on-site clinic, third-party collection facility, or mobile testing unit.',
    `collector_name` STRING COMMENT 'Name of the trained specimen collector who performed the collection. Required for chain of custody documentation.',
    `compliance_year` STRING COMMENT 'Calendar year in which the test was conducted. Used for annual DOT compliance reporting and random testing rate calculations.',
    `cost_center_code` STRING COMMENT 'Cost center to which the testing expense is allocated. Used for financial tracking and departmental cost allocation of drug and alcohol testing programs.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this drug and alcohol test record was first created in the system. Used for audit trail and data lineage tracking.',
    `drug_result` STRING COMMENT 'Specific result of the drug component of the test. Separated from alcohol result for tests that include both categories.. Valid values are `negative|positive|refused|cancelled|invalid|not tested`',
    `job_function_tested` STRING COMMENT 'Specific safety-sensitive job function for which the employee was tested (e.g., commercial driver, aircraft pilot, flight attendant, aircraft maintenance technician, warehouse forklift operator). Used for compliance reporting by job category.',
    `laboratory_code` STRING COMMENT 'Standardized code identifying the HHS-certified laboratory. Used for vendor management and quality assurance.',
    `laboratory_name` STRING COMMENT 'Name of the Department of Health and Human Services (HHS) certified laboratory that analyzed the specimen.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or automated process that last modified this test record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this drug and alcohol test record was last modified. Updated whenever any field in the record changes. Used for audit trail and change tracking.',
    `mro_name` STRING COMMENT 'Name of the licensed physician Medical Review Officer who reviewed and verified the test result. MRO is responsible for determining if there is a legitimate medical explanation for a positive result.',
    `mro_verification_date` DATE COMMENT 'Date on which the MRO completed verification of the test result and communicated the final determination to the employer.',
    `mro_verification_status` STRING COMMENT 'Status of the MRO verification process. Verified indicates MRO has completed review; pending indicates review is in progress; unable to contact indicates employee did not respond to MRO contact attempts; cancelled by MRO indicates test was invalidated during MRO review.. Valid values are `verified|pending|unable to contact|cancelled by mro`',
    `notes` STRING COMMENT 'Additional notes, comments, or special circumstances related to the test. May include procedural deviations, employee statements, or follow-up actions required.',
    `random_selection_date` DATE COMMENT 'Date on which the employee was randomly selected for testing. Used to verify unannounced nature of random tests and compliance with selection procedures.',
    `reasonable_suspicion_basis` STRING COMMENT 'Documented observations and specific, contemporaneous, articulable facts that led a trained supervisor to require a reasonable suspicion test. May include appearance, behavior, speech, or body odor consistent with substance use.',
    `record_retention_date` DATE COMMENT 'Date through which this test record must be retained to meet DOT recordkeeping requirements. DOT requires retention of positive and refusal records for 5 years; negative records for 1 year; records of employee refusals to test for 5 years.',
    `refusal_reason` STRING COMMENT 'Documented reason for a refused test result. May include failure to provide sufficient specimen, failure to remain at collection site, adulterating or substituting specimen, failure to cooperate with testing process, or explicit refusal. A refusal is treated as a positive result under DOT regulations.',
    `regulatory_authority` STRING COMMENT 'Department of Transportation (DOT) operating administration under whose regulations this test was conducted. FMCSA for commercial motor vehicle drivers; FAA for aviation personnel; FTA for transit employees; PHMSA for pipeline workers; FRA for railroad employees; USCG for maritime workers.. Valid values are `FMCSA|FAA|FTA|PHMSA|FRA|USCG`',
    `safety_sensitive_position` BOOLEAN COMMENT 'Indicates whether the employee holds a DOT-defined safety-sensitive position at the time of testing. Only safety-sensitive employees are subject to DOT drug and alcohol testing requirements.',
    `sap_evaluation_status` STRING COMMENT 'Current status of the SAP evaluation and treatment process. Not required for negative tests; pending indicates referral made but evaluation not started; in progress indicates employee is undergoing treatment; completed indicates SAP has cleared employee for return-to-duty testing; non-compliant indicates employee failed to complete SAP requirements.. Valid values are `not required|pending|in progress|completed|non-compliant`',
    `sap_name` STRING COMMENT 'Name of the qualified Substance Abuse Professional (licensed physician, social worker, psychologist, or addiction counselor) to whom the employee was referred for evaluation and treatment.',
    `sap_referral_date` DATE COMMENT 'Date on which the employee was referred to a Substance Abuse Professional following a positive or refused test result.',
    `sap_referral_required` BOOLEAN COMMENT 'Indicates whether the employee must be referred to a Substance Abuse Professional for evaluation and treatment. Required for all positive, refused, and adulterated test results before the employee can return to safety-sensitive duties.',
    `specimen_number` STRING COMMENT 'Unique identifier assigned to the specimen by the collection site or laboratory. Used to maintain chain of custody and link test results to the employee while preserving confidentiality.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected for testing. Urine is standard for drug tests; breath is standard for alcohol tests; blood, saliva, and hair may be used in specific circumstances or for extended detection windows.. Valid values are `urine|breath|blood|saliva|hair`',
    `substances_detected` STRING COMMENT 'List of specific controlled substances or drug classes detected in a positive drug test (e.g., marijuana, cocaine, opiates, amphetamines, phencyclidine). Null for negative or alcohol-only tests.',
    `supervisor_name` STRING COMMENT 'Name of the trained supervisor who made the reasonable suspicion determination and directed the employee to testing. Supervisor must have completed DOT-required reasonable suspicion training.',
    `test_category` STRING COMMENT 'Category of substance tested: drug only, alcohol only, or both drug and alcohol in a combined testing event.. Valid values are `drug|alcohol|both`',
    `test_date` DATE COMMENT 'Date on which the drug and alcohol test specimen was collected. This is the principal business event date for the test record.',
    `test_number` STRING COMMENT 'Externally-known unique test number or specimen identifier assigned by the testing facility or Medical Review Officer (MRO). Used for tracking and audit purposes.',
    `test_result` STRING COMMENT 'Final result of the drug and alcohol test. Negative indicates no prohibited substances detected; positive indicates presence of prohibited substances above cutoff levels; refused indicates employee declined to provide specimen; cancelled indicates test was invalidated due to procedural error; invalid indicates specimen could not be analyzed.. Valid values are `negative|positive|refused|cancelled|invalid`',
    `test_status` STRING COMMENT 'Current lifecycle status of the test record. Tracks the test from scheduling through final verification and record completion. [ENUM-REF-CANDIDATE: scheduled|specimen collected|in transit|at laboratory|under review|verified|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `test_timestamp` TIMESTAMP COMMENT 'Precise date and time when the specimen collection occurred. Used for post-accident testing timeline compliance and audit trail.',
    `test_type` STRING COMMENT 'Type of drug and alcohol test conducted. Pre-employment tests are conducted before hire; random tests are unannounced selections from the pool; post-accident tests follow qualifying incidents; reasonable suspicion tests are based on observed behavior; return-to-duty tests are required before returning after a positive result; follow-up tests are part of a monitoring program.. Valid values are `pre-employment|random|post-accident|reasonable suspicion|return-to-duty|follow-up`',
    `testing_vendor_code` STRING COMMENT 'Identifier of the third-party vendor or consortium that manages the drug and alcohol testing program. Used for vendor performance tracking and invoice reconciliation.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or automated process that created this test record. Used for audit trail and accountability.',
    CONSTRAINT pk_drug_alcohol_test PRIMARY KEY(`drug_alcohol_test_id`)
) COMMENT 'DOT-mandated drug and alcohol testing records for safety-sensitive transportation employees including pre-employment, random, post-accident, reasonable suspicion, and return-to-duty tests. Captures test type, test date, specimen type, result (negative/positive/refused), MRO verification status, and SAP referral if applicable. Critical for DOT FMCSA, FAA, and FTA compliance programs.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`location` (
    `location_id` BIGINT COMMENT 'Unique identifier for the workforce location record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Workforce locations operate under legal entities for statutory compliance. Payroll tax jurisdiction, labor law compliance, and entity-level headcount reporting require linking locations to their compa',
    `employee_id` BIGINT COMMENT 'Employee ID of the location manager or site supervisor responsible for this workforce location. Links to employee master data in Workday HCM.',
    `address_line_1` STRING COMMENT 'Primary street address line for the workforce location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or unit information. Organizational contact data classified as confidential.',
    `building_square_footage` DECIMAL(18,2) COMMENT 'Total building area in square feet. Used for facilities cost allocation, space utilization analysis, and capacity planning.',
    `business_unit_code` STRING COMMENT 'Business unit or division code that owns this location (e.g., EXPRESS, FREIGHT, ECOM). Used for organizational hierarchy and reporting.. Valid values are `^[A-Z0-9]{2,6}$`',
    `city` STRING COMMENT 'City or municipality where the workforce location is situated.',
    `compliance_framework` STRING COMMENT 'Comma-separated list of compliance frameworks applicable to this location (e.g., ISO 28000, C-TPAT, AEO, SOX). Drives audit requirements and certification tracking.',
    `cost_center_code` STRING COMMENT 'Financial cost center code associated with this location for labor cost allocation and P&L reporting. Links to SAP S/4HANA Finance.. Valid values are `^[A-Z0-9]{4,10}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code (e.g., USA, CAN, MEX). Determines regulatory jurisdiction and labor law compliance requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this workforce location record was first created in the system. Used for audit trail and data lineage.',
    `current_headcount` STRING COMMENT 'Current number of employees assigned to this workforce location. Updated periodically from Workday HCM.',
    `effective_end_date` DATE COMMENT 'Date when this workforce location ceased operations or was decommissioned. Null for currently active locations.',
    `effective_start_date` DATE COMMENT 'Date when this workforce location became operational and available for employee assignment and shift scheduling.',
    `email_address` STRING COMMENT 'Primary email contact for the workforce location. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `external_location_code` STRING COMMENT 'External system identifier for this location from source systems (e.g., Workday HCM location ID, SAP TM plant code). Used for cross-system reconciliation.',
    `facility_type` STRING COMMENT 'Classification of the physical facility type. CFS = Container Freight Station, ICD = Inland Container Depot. Determines operational capabilities and regulatory requirements. [ENUM-REF-CANDIDATE: warehouse|distribution_center|freight_station|cfs|icd|airport_cargo_terminal|corporate_office|cross_dock — 8 candidates stripped; promote to reference product]',
    `is_safety_sensitive_site` BOOLEAN COMMENT 'Indicates whether this location handles safety-sensitive operations requiring DOT/ICAO certifications, dangerous goods handling, or enhanced safety protocols.',
    `is_union_location` BOOLEAN COMMENT 'Indicates whether this location has unionized workforce. Determines applicable labor agreements, shift rules, and compliance requirements.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees. Used for route optimization, fleet management, and geospatial analytics.',
    `lease_expiry_date` DATE COMMENT 'Date when the lease agreement for this location expires. Null for owned properties. Used for real estate planning and renewal tracking.',
    `lease_or_owned` STRING COMMENT 'Indicates whether the location is owned by the company, leased, or subleased. Impacts financial reporting and CAPEX/OPEX allocation.. Valid values are `owned|leased|subleased`',
    `location_code` STRING COMMENT 'Unique business identifier code for the workforce location, used across operational systems for shift scheduling, labor allocation, and payroll processing. Typically follows company-specific alphanumeric format.. Valid values are `^[A-Z0-9]{3,10}$`',
    `location_description` STRING COMMENT 'Free-text description providing additional context about the workforce location, its operational scope, and special characteristics.',
    `location_name` STRING COMMENT 'Full business name of the workforce location (e.g., Chicago OHare Cargo Terminal, Newark Distribution Center).',
    `location_status` STRING COMMENT 'Current operational status of the workforce location. Active locations are available for shift scheduling and labor allocation.. Valid values are `active|inactive|under_construction|temporarily_closed|decommissioned`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees. Used for route optimization, fleet management, and geospatial analytics.',
    `modified_by` STRING COMMENT 'User ID or system identifier that last modified this workforce location record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this workforce location record was last modified. Used for audit trail and change tracking.',
    `operates_24_7` BOOLEAN COMMENT 'Indicates whether this location operates continuously (24 hours, 7 days per week). Impacts shift scheduling, labor planning, and operational support requirements.',
    `operational_capacity_fte` DECIMAL(18,2) COMMENT 'Maximum workforce capacity at this location measured in Full-Time Equivalents. Used for labor planning and resource allocation.',
    `parking_capacity` STRING COMMENT 'Number of parking spaces available at this location for employee and visitor vehicles. Used for facilities planning and employee amenities assessment.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the workforce location. Organizational contact data classified as confidential.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the workforce location. Organizational contact data classified as confidential.',
    `region_code` STRING COMMENT 'Geographic or operational region code (e.g., NORAM, EMEA, APAC, LATAM). Used for regional workforce planning and performance analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory jurisdiction governing labor law, safety, and employment compliance at this location (e.g., US DOT, EU GDPR, ICAO). Determines applicable compliance frameworks.',
    `requires_security_clearance` BOOLEAN COMMENT 'Indicates whether employees at this location require security clearance (e.g., C-TPAT, AEO, airside access). Determines background check and certification requirements.',
    `shift_pattern` STRING COMMENT 'Standard shift pattern or rotation schedule used at this location (e.g., 3-shift rotation, 4-on-4-off, day shift only). Guides workforce scheduling in Manhattan WMS.',
    `short_name` STRING COMMENT 'Abbreviated or short name for the location used in operational displays and reports (e.g., ORD Cargo, EWR DC).',
    `state_province_code` STRING COMMENT 'ISO 3166-2 subdivision code for state, province, or region (e.g., IL, CA, ON).. Valid values are `^[A-Z]{2,3}$`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the location (e.g., America/Chicago, Europe/London). Critical for shift scheduling and labor hour calculations across distributed operations.',
    `union_code` STRING COMMENT 'Code identifying the labor union representing workers at this location, if applicable. Used for contract management and labor relations.',
    `warehouse_management_system` STRING COMMENT 'Name and version of the WMS deployed at this location (e.g., Manhattan WMS v2022, SAP EWM). Used for system integration and labor tracking.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this workforce location record. Used for audit trail and accountability.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master record of all physical work locations where Transport Shipping employees are deployed, including warehouses, distribution centers, freight stations, CFS facilities, ICD depots, airport cargo terminals, and corporate offices. Captures location code, address, country, timezone, facility type, and operational capacity. Used for shift scheduling, labor allocation, and regulatory jurisdiction determination.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` (
    `labor_contract_id` BIGINT COMMENT 'Unique identifier for the labor contract record. Primary key for the labor contract entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee to whom this labor contract applies. Links to the employee master record in the workforce domain.',
    `job_profile_id` BIGINT COMMENT 'Identifier linking to the standardized job profile that defines role responsibilities, competencies, and requirements for this contract.',
    `annual_leave_days` STRING COMMENT 'Number of paid annual leave (vacation) days per year granted under this contract. May increase with tenure.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Annual base salary amount specified in the labor contract. Excludes bonuses, commissions, allowances, and other variable compensation.',
    `bonus_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for performance-based or discretionary bonuses under this contract.',
    `cba_reference_number` STRING COMMENT 'Reference number of the applicable collective bargaining agreement if this contract is governed by a union CBA. Null for non-union individual contracts.',
    `contract_duration_months` STRING COMMENT 'Total duration of the contract in months. Applicable primarily to fixed-term contracts. Null for permanent or open-ended contracts.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the labor contract. Used for reference in legal documents, HR systems, and employee communications.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the labor contract. Indicates whether the contract is in draft, active, suspended, terminated, expired, or renewed state.. Valid values are `draft|active|suspended|terminated|expired|renewed`',
    `contract_type` STRING COMMENT 'Classification of the labor contract. Distinguishes between individual employment contracts, collective bargaining agreements (CBAs), agency worker agreements, and other contract forms. [ENUM-REF-CANDIDATE: individual_employment|collective_bargaining_agreement|agency_worker|fixed_term|permanent|temporary|seasonal|apprenticeship — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this labor contract record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this contract (base salary, hourly rate, allowances).',
    `effective_end_date` DATE COMMENT 'Date when the labor contract expires or terminates. Nullable for open-ended permanent contracts. For fixed-term contracts, represents the contract expiration date.',
    `effective_start_date` DATE COMMENT 'Date when the labor contract becomes legally binding and employment terms take effect. Marks the beginning of the contract period.',
    `flsa_classification` STRING COMMENT 'Classification under the US Fair Labor Standards Act indicating whether the employee is exempt or non-exempt from overtime pay requirements. Applicable to US-based contracts.. Valid values are `exempt|non_exempt`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation for this contract, expressed as a decimal (e.g., 1.0000 for full-time, 0.5000 for half-time). Used for workforce planning and budgeting.',
    `governing_law` STRING COMMENT 'Legal framework or specific statute governing the employment relationship. May reference national labor codes, state employment acts, or international conventions.',
    `hazmat_premium_amount` DECIMAL(18,2) COMMENT 'Additional compensation for employees handling hazardous materials or dangerous goods. Applicable to drivers, warehouse workers, and freight handlers with HAZMAT endorsements.',
    `health_insurance_coverage` STRING COMMENT 'Level of health insurance coverage provided under this contract. Indicates whether coverage extends to employee only, employee and spouse, or full family.. Valid values are `employee_only|employee_spouse|employee_family|none`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Hourly wage rate for hourly-paid employees. Null for salaried employees. Used to calculate regular pay and overtime.',
    `job_title` STRING COMMENT 'Official job title as stated in the labor contract. May differ from operational role titles used in day-to-day management.',
    `jurisdiction_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the legal jurisdiction governing this labor contract. Determines applicable labor laws and regulations.',
    `jurisdiction_state_province` STRING COMMENT 'State or province within the country where the contract is governed. Relevant for countries with state-level labor regulations (e.g., USA, Canada, Australia).',
    `mileage_reimbursement_rate` DECIMAL(18,2) COMMENT 'Rate per mile (or kilometer) for reimbursing employees who use personal vehicles for business purposes. Null if not applicable.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this labor contract record. Used for audit and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this labor contract record was last modified. Updated whenever any field in the record changes.',
    `notice_period_days` STRING COMMENT 'Number of days of advance notice required for contract termination by either party. May vary based on tenure, role, or jurisdiction.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for overtime pay under this contract. True for non-exempt employees; false for exempt employees.',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the base hourly rate to calculate overtime pay (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Null if overtime is not applicable.',
    `pay_frequency` STRING COMMENT 'Frequency at which the employee is paid under this contract. Determines payroll cycle and payment schedule.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `per_diem_amount` DECIMAL(18,2) COMMENT 'Daily allowance for meals, lodging, and incidental expenses when the employee is required to travel or work away from their home location. Common for long-haul drivers and field personnel.',
    `probation_end_date` DATE COMMENT 'Date when the probationary period ends and full employment terms take effect. Calculated from effective start date and probation period.',
    `probation_period_months` STRING COMMENT 'Duration of the probationary period in months during which either party may terminate the contract with reduced notice. Null if no probation period applies.',
    `redundancy_terms` STRING COMMENT 'Contractual terms governing severance pay, notice period, and entitlements in the event of redundancy or layoff. May reference statutory minimums or enhanced provisions.',
    `renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether this contract is eligible for renewal upon expiration. Applicable primarily to fixed-term contracts.',
    `retirement_contribution_percentage` DECIMAL(18,2) COMMENT 'Employer contribution to retirement or pension plan as a percentage of base salary. Null if no employer contribution applies.',
    `severance_pay_weeks` STRING COMMENT 'Number of weeks of base pay provided as severance in the event of involuntary termination or redundancy. May vary by tenure and jurisdiction.',
    `shift_differential_amount` DECIMAL(18,2) COMMENT 'Additional hourly or daily premium paid for working non-standard shifts (night, weekend, holiday). Null if no shift differential applies.',
    `sick_leave_days` STRING COMMENT 'Number of paid sick leave days per year granted under this contract. May be statutory or enhanced.',
    `signed_date` DATE COMMENT 'Date when the labor contract was signed by both the employee and the employer. Marks the formal agreement date.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Contractually agreed standard working hours per week. Used to determine full-time equivalent (FTE) allocation and overtime thresholds.',
    `target_bonus_percentage` DECIMAL(18,2) COMMENT 'Target annual bonus as a percentage of base salary. Actual bonus may vary based on performance. Null if bonus is not applicable.',
    `termination_date` DATE COMMENT 'Actual date when the contract was terminated. Null for active contracts. Populated when contract status changes to terminated.',
    `termination_reason` STRING COMMENT 'Reason for contract termination. May include voluntary resignation, involuntary termination, redundancy, retirement, end of fixed term, or mutual agreement.',
    `union_code` STRING COMMENT 'Code identifying the labor union representing the employee under this contract. Null for non-union employees.',
    `union_name` STRING COMMENT 'Full name of the labor union representing the employee. Null for non-union employees.',
    `work_location_code` STRING COMMENT 'Code identifying the primary work location or facility where the employee performs duties under this contract. Links to location master data.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this labor contract record in the system. Used for audit and accountability.',
    CONSTRAINT pk_labor_contract PRIMARY KEY(`labor_contract_id`)
) COMMENT 'Individual and collective labor agreement records governing employment terms for Transport Shipping workers, including union collective bargaining agreements (CBAs), individual employment contracts, and agency worker agreements. Captures contract type, effective dates, notice period, probation terms, applicable CBA reference, jurisdiction, and key entitlements (overtime rules, shift premiums, redundancy terms). Distinct from commercial contracts owned by the contract domain.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` (
    `initiative_participation_id` BIGINT COMMENT 'Unique identifier for the employee-initiative participation record. Primary key for the association.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee participating in the sustainability initiative. References the core employee master record from Workday HCM.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to the sustainability initiative in which the employee is participating. References the master record for green logistics initiatives and decarbonisation projects.',
    `achievement_percentage` DECIMAL(18,2) COMMENT 'Percentage of the assigned KPI target that the employee has achieved (0-100+). Used for performance evaluation, incentive calculation, and tracking individual contribution to sustainability goals. Explicitly identified in detection phase relationship data.',
    `contribution_hours` DECIMAL(18,2) COMMENT 'Total hours the employee has contributed or is allocated to contribute to the sustainability initiative. Used for resource planning, cost allocation, and measuring human capital investment in ESG projects. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the participation record was created in the system. Used for audit trail and data lineage tracking.',
    `kpi_target_assigned` STRING COMMENT 'Specific key performance indicator or target assigned to this employee for this initiative (e.g., 500 tCO2e reduction, 10 EV deployments, 15% modal shift). Enables individual accountability and performance tracking within the initiative. Explicitly identified in detection phase relationship data.',
    `participation_end_date` DATE COMMENT 'Date when the employees participation in the sustainability initiative ended or is planned to end. Null for ongoing participation. Enables tracking of participation history and resource allocation over time. Explicitly identified in detection phase relationship data.',
    `participation_start_date` DATE COMMENT 'Date when the employee began participating in or was assigned to the sustainability initiative. Used for tracking participation duration and historical staffing analysis. Explicitly identified in detection phase relationship data.',
    `participation_status` STRING COMMENT 'Current status of the employees participation in the initiative (active, on_hold, completed, withdrawn). Tracks the lifecycle of the participation relationship and enables filtering for active vs. historical assignments.',
    `responsibility_level` STRING COMMENT 'Level of responsibility or accountability the employee has for the initiative (e.g., primary, secondary, advisory, support). Distinguishes between core team members and supporting contributors. Explicitly identified in detection phase relationship data.',
    `role_in_initiative` STRING COMMENT 'The specific role the employee plays in the sustainability initiative (e.g., sponsor, contributor, champion, technical lead, analyst, coordinator). Defines the nature of their participation and level of accountability. Explicitly identified in detection phase relationship data.',
    `time_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the employees working time allocated to this sustainability initiative (0-100). Used for capacity planning, workload balancing, and ensuring employees are not over-committed across multiple initiatives.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the participation record was last updated. Used for audit trail and tracking changes to participation details.',
    CONSTRAINT pk_initiative_participation PRIMARY KEY(`initiative_participation_id`)
) COMMENT 'This association product represents the participation relationship between employees and sustainability initiatives within Transport Shippings green logistics program. It captures the operational assignment of employees to decarbonisation projects and fleet electrification initiatives, tracking their specific roles, time allocation, and individual contribution metrics. Each record links one employee to one sustainability initiative with attributes that exist only in the context of this participation relationship, enabling portfolio management of green initiative staffing and ROI tracking for human capital investment in ESG programs.. Existence Justification: In Transport Shippings sustainability program, employees participate in multiple green logistics initiatives simultaneously (e.g., a logistics manager may contribute to both fleet electrification and route optimization projects), and each sustainability initiative requires cross-functional teams with multiple employees in various roles (sponsor, technical lead, contributor, champion). The business actively manages these participation relationships as operational records, tracking role assignments, time allocation, contribution hours, individual KPI targets, and achievement metrics for each employee-initiative pairing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` (
    `workforce_training_completion_id` BIGINT COMMENT 'Primary key for workforce_training_completion',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who completed the training',
    `training_id` BIGINT COMMENT 'Foreign key linking to the safety training course that was completed',
    `training_session_id` BIGINT COMMENT 'Identifier for the specific training session or class instance in which this completion occurred. Links to scheduling system for session-level tracking (instructor, location, cohort).',
    `assessment_score` DECIMAL(18,2) COMMENT 'Percentage score achieved by the employee on the competency assessment for this training completion. Used to determine pass/fail status against the course passing_score_percentage.',
    `attempt_number` STRING COMMENT 'Sequential attempt number for this employee-training combination. Increments if employee fails and retakes the assessment. Used to track training effectiveness and employee learning curves.',
    `certificate_expiry_date` DATE COMMENT 'Date on which the training certificate expires and recertification is required. Calculated from completion_date plus certification_validity_months from the training course master. Used for automated expiry alerts and compliance monitoring.',
    `certificate_number` STRING COMMENT 'Unique certificate number issued upon successful completion of the training course. Required for regulatory audits and compliance verification.',
    `completion_date` DATE COMMENT 'Date on which the employee successfully completed the safety training course. Used for compliance tracking and refresher scheduling.',
    `compliance_status` STRING COMMENT 'Current compliance status of this training completion record. Indicates whether the employee remains compliant, needs recertification, or has expired certification. Used for workforce compliance reporting and operational readiness.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Actual cost incurred for this specific training completion. May differ from the course master cost_per_participant due to negotiated rates, group discounts, or internal delivery. Used for training budget tracking and cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was created in the safety management system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost_amount (e.g., USD, EUR, GBP). Required for multi-currency cost tracking across global operations.',
    `instructor_name` STRING COMMENT 'Name of the instructor who delivered this training session. Used for instructor effectiveness analysis and quality assurance.',
    `pass_fail_status` STRING COMMENT 'Outcome of the competency assessment for this training completion. Determines whether certification is issued and compliance is achieved.',
    `training_completion_reference` BIGINT COMMENT 'Unique identifier for this training completion record. Primary key.',
    `training_location` STRING COMMENT 'Physical location or facility where the training was delivered (e.g., warehouse code, training center, online). Used for geographic compliance reporting and resource planning.',
    `training_provider_name` STRING COMMENT 'Name of the organization or individual who delivered this specific training session. May differ from the course master external_provider_name if delivered by internal trainers or alternate providers.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this training completion record. Used for change tracking and data synchronization.',
    CONSTRAINT pk_workforce_training_completion PRIMARY KEY(`workforce_training_completion_id`)
) COMMENT 'This association product represents the completion event between employee and safety_training. It captures the operational record of each instance when an employee completes a safety training course, including assessment results, certification details, and compliance tracking. Each record links one employee to one safety_training with attributes that exist only in the context of this completion relationship.. Existence Justification: In Transport Shipping operations, employees complete multiple safety training courses throughout their employment (hazmat, forklift certification, DOT compliance, first aid, emergency response), and each safety training course is completed by many employees across the workforce. The business actively manages training completions as operational records with completion dates, assessment scores, certificate numbers, expiry dates, and compliance status tracking. This is a recognized business process called training completion or certification management that safety teams query, monitor, and report on for regulatory compliance and operational readiness.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` (
    `target_accountability_id` BIGINT COMMENT 'Unique identifier for this accountability assignment record. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to the organizational unit that holds accountability for this sustainability target',
    `target_id` BIGINT COMMENT 'Foreign key linking to the sustainability target for which accountability is assigned',
    `accountability_level` STRING COMMENT 'The level of accountability this organizational unit holds for the target. Primary indicates direct ownership and decision-making authority. Secondary indicates shared responsibility with reporting obligations. Contributing indicates supporting role. Monitoring indicates oversight or tracking responsibility without operational accountability.',
    `assignment_date` DATE COMMENT 'The date when this accountability assignment was formally established and communicated to the organizational unit. Used for tracking when responsibility was delegated.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this accountability assignment. Active assignments are in force. Pending assignments are approved but not yet effective. Suspended assignments are temporarily on hold. Completed assignments have fulfilled their target. Cancelled assignments were terminated before completion.',
    `budget_allocation` DECIMAL(18,2) COMMENT 'The budget amount in USD allocated to this organizational unit specifically for achieving their portion of this sustainability target. Used for tracking investment in emissions reduction projects, renewable energy initiatives, waste reduction programs, etc.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accountability assignment record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date when this organizational units accountability for this target ends. Null for ongoing accountability. Populated when accountability is transferred to another unit or when the target is achieved or retired.',
    `effective_start_date` DATE COMMENT 'The date from which this organizational units accountability for this target becomes active. May differ from assignment_date if accountability is assigned in advance of the effective period.',
    `escalation_threshold` DECIMAL(18,2) COMMENT 'The percentage variance from target trajectory that triggers escalation to executive leadership. For example, if set to 10.00, any deviation of 10% or more from the planned progress path requires escalation and corrective action planning.',
    `milestone_ownership` STRING COMMENT 'Indicates whether this organizational unit owns specific interim milestones for this target. Full ownership means the unit is responsible for achieving defined milestones. Partial means shared milestone responsibility. None means the unit contributes to the overall target but does not own specific milestones.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accountability assignment record was last modified.',
    `reporting_responsibility` STRING COMMENT 'The frequency and nature of reporting obligations this organizational unit has for progress against this target. Defines whether the unit must submit monthly progress reports, quarterly updates, annual summaries, or ad-hoc reports as requested.',
    `responsible_executive` STRING COMMENT 'Name or identifier of the executive within this organizational unit who holds ultimate accountability for this target assignment. Used for escalation and executive reporting.',
    `target_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the overall sustainability target allocated to this organizational unit. Used when a corporate target is split across multiple business units (e.g., 40% of emissions reduction target assigned to freight operations, 30% to warehouse operations, 30% to fleet). Sum of allocations across all org units for a given target should equal 100%.',
    CONSTRAINT pk_target_accountability PRIMARY KEY(`target_accountability_id`)
) COMMENT 'This association product represents the accountability assignment between organizational units and sustainability targets within Transport Shippings ESG governance framework. It captures the distributed responsibility model where corporate sustainability commitments cascade to multiple business units with defined accountability levels, budget allocations, and reporting responsibilities. Each record links one org_unit to one sustainability_target with attributes that exist only in the context of this accountability relationship, enabling tracking of which units are responsible for which portions of each target and how progress is measured and reported.. Existence Justification: In Transport Shippings ESG governance model, corporate sustainability targets (e.g., 50% emissions reduction by 2030, 100% renewable energy by 2040) cascade to multiple organizational units with distributed accountability. A single target like Net Zero by 2050 is allocated across freight operations, warehouse operations, fleet management, and corporate functions, each with defined allocation percentages, budget splits, and reporting responsibilities. Conversely, a single organizational unit like European Freight Operations holds accountability for multiple targets simultaneously (emissions reduction, waste diversion, renewable energy adoption, sustainable packaging). This is an operational M:N relationship where the business actively manages accountability assignments, tracks progress by unit-target combination, and escalates when units fall behind their allocated portions.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` (
    `fmla_case_id` BIGINT COMMENT 'Primary key for fmla_case',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who initiated or is the subject of this FMLA case.',
    `hr_administrator_employee_id` BIGINT COMMENT 'Identifier of the HR administrator or leave specialist assigned to manage this FMLA case.',
    `manager_employee_id` BIGINT COMMENT 'Identifier of the employees direct manager at the time of the FMLA case, responsible for operational coverage planning.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: fmla_case has department_id BIGINT. In the workforce domain, departments/business units are represented by org_unit. Creating org_unit_id FK to properly link to the organizational hierarchy and removi',
    `location_id` BIGINT COMMENT 'Identifier of the employees primary work location (warehouse, distribution center, terminal, or office) at the time of the FMLA case.',
    `recurrence_fmla_case_id` BIGINT COMMENT 'Self-referencing FK on fmla_case (recurrence_fmla_case_id)',
    `case_number` STRING COMMENT 'Externally-known business reference number assigned to the FMLA case for tracking and correspondence purposes.',
    `case_status` STRING COMMENT 'Current lifecycle status of the FMLA case indicating its position in the approval and administration workflow.',
    `case_type` STRING COMMENT 'Classification of the FMLA leave type indicating whether the leave is taken continuously, intermittently, or on a reduced schedule basis.',
    `certification_due_date` DATE COMMENT 'Deadline by which the employee must submit medical certification. Typically 15 calendar days from employer request.',
    `certification_received_date` DATE COMMENT 'Date the employer received the completed medical certification from the employee or healthcare provider.',
    `closed_date` DATE COMMENT 'Date the FMLA case was formally closed, either due to return to work, exhaustion of entitlement, separation, or administrative closure.',
    `condition_description` STRING COMMENT 'General description of the serious health condition or qualifying reason supporting the FMLA leave. Contains protected health information.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the FMLA case record was first created in the system.',
    `denial_reason` STRING COMMENT 'Explanation of why the FMLA leave request was denied, such as ineligibility, insufficient certification, or exhausted entitlement.',
    `designation_notice_date` DATE COMMENT 'Date the employer issued the designation notice informing the employee whether the leave qualifies as FMLA-protected.',
    `eligibility_determination_date` DATE COMMENT 'Date on which the employer made the formal determination of the employees eligibility for FMLA leave. Must be within 5 business days of request per regulation.',
    `entitlement_hours_total` DECIMAL(18,2) COMMENT 'Total number of FMLA leave hours the employee is entitled to within the 12-month leave year (typically 480 hours for standard full-time, up to 1,040 for military caregiver).',
    `family_member_relationship` STRING COMMENT 'Relationship of the person with the serious health condition to the employee, determining FMLA qualifying reason eligibility.',
    `fitness_for_duty_received_date` DATE COMMENT 'Date the fitness-for-duty certification was received from the employees healthcare provider clearing them for return to work.',
    `fitness_for_duty_required` BOOLEAN COMMENT 'Indicates whether the employee must provide a fitness-for-duty certification before returning to work, particularly relevant for DOT-regulated driver positions.',
    `healthcare_provider_name` STRING COMMENT 'Name of the healthcare provider who issued the medical certification supporting the FMLA leave request.',
    `hours_remaining` DECIMAL(18,2) COMMENT 'Number of FMLA leave hours remaining in the employees entitlement balance for this case within the current leave year.',
    `hours_used` DECIMAL(18,2) COMMENT 'Cumulative number of FMLA leave hours the employee has consumed against their entitlement for this case.',
    `intermittent_duration_per_episode` STRING COMMENT 'Expected duration of each intermittent leave episode as certified by the healthcare provider (e.g., 1-3 days per episode, 2-4 hours per episode).',
    `intermittent_frequency` STRING COMMENT 'Expected frequency of intermittent leave episodes as certified by the healthcare provider (e.g., 2-3 times per month, weekly treatments).',
    `is_concurrent_with_std` BOOLEAN COMMENT 'Indicates whether this FMLA leave runs concurrently with a short-term disability benefit claim.',
    `is_concurrent_with_workers_comp` BOOLEAN COMMENT 'Indicates whether this FMLA leave runs concurrently with a workers compensation absence.',
    `is_eligible` BOOLEAN COMMENT 'Indicates whether the employee met FMLA eligibility requirements (12 months employment, 1,250 hours worked, 50+ employees within 75 miles).',
    `is_key_employee` BOOLEAN COMMENT 'Indicates whether the employee is classified as a key employee (salaried, among highest-paid 10%), which may affect job restoration rights under FMLA.',
    `is_paid_leave_substituted` BOOLEAN COMMENT 'Indicates whether the employee or employer has elected to substitute accrued paid leave (vacation, sick, PTO) for unpaid FMLA leave.',
    `is_work_related` BOOLEAN COMMENT 'Indicates whether the serious health condition is related to a workplace injury or occupational illness, which may trigger concurrent workers compensation coverage.',
    `job_protection_status` STRING COMMENT 'Status of the employees job restoration rights under FMLA, indicating whether the employees position is protected, has been restored, or if key employee exception applies.',
    `leave_end_date` DATE COMMENT 'Last date of the FMLA leave period, either as originally approved or as actually concluded. Nullable for open-ended intermittent cases.',
    `leave_reason` STRING COMMENT 'The qualifying reason for the FMLA leave request as defined by federal regulations. Determines eligibility and entitlement duration.',
    `leave_start_date` DATE COMMENT 'First date of the approved FMLA leave period when the employee begins absence from work.',
    `leave_year_method` STRING COMMENT 'Method used by the employer to calculate the 12-month FMLA leave year period for entitlement tracking.',
    `leave_year_start_date` DATE COMMENT 'Start date of the 12-month leave year period applicable to this FMLA case based on the employers chosen calculation method.',
    `medical_certification_status` STRING COMMENT 'Status of the medical certification documentation required to support the FMLA leave request for serious health conditions.',
    `notes` STRING COMMENT 'Free-text administrative notes related to the FMLA case, including communications, decisions, and case management observations. May contain sensitive information.',
    `recertification_due_date` DATE COMMENT 'Date by which the employee must provide updated medical recertification, typically every 30 days or at the end of the certified period.',
    `request_date` DATE COMMENT 'Date the employee formally submitted the FMLA leave request to the employer.',
    `return_to_work_date` DATE COMMENT 'Actual date the employee returned to work following FMLA leave, or expected return date if still on leave.',
    `state_leave_law_applies` BOOLEAN COMMENT 'Indicates whether a state-level family/medical leave law also applies to this case, potentially providing additional protections beyond federal FMLA.',
    `state_leave_law_code` STRING COMMENT 'Code identifying the applicable state family/medical leave law (e.g., CFRA for California, PFML for Massachusetts) that runs concurrently with federal FMLA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the FMLA case record was last modified in the system.',
    CONSTRAINT pk_fmla_case PRIMARY KEY(`fmla_case_id`)
) COMMENT 'Master reference table for fmla_case. Referenced by fmla_case_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`random_pool` (
    `random_pool_id` BIGINT COMMENT 'Primary key for random_pool',
    `prior_random_pool_id` BIGINT COMMENT 'Self-referencing FK on random_pool (prior_random_pool_id)',
    `certification_required` STRING COMMENT 'Specific certifications or qualifications (e.g., DOT, ICAO, forklift, hazmat) required for pool membership, supporting compliance with regulatory standards.',
    `cooldown_period_hours` STRING COMMENT 'Minimum number of hours a member must wait after being selected before becoming eligible for selection again from this pool.',
    `cost_center_code` STRING COMMENT 'Cost center to which labor costs from pool selections are allocated for financial reporting and budgeting.',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the country where this random pool operates, relevant for labor law compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this random pool record was first created in the system.',
    `current_member_count` STRING COMMENT 'Current number of active members enrolled in the random pool, updated as members are added or removed.',
    `random_pool_description` STRING COMMENT 'Detailed description of the random pools purpose, selection criteria, and intended use within workforce operations.',
    `effective_end_date` DATE COMMENT 'Date after which this random pool is no longer active for selections. Null indicates an open-ended pool with no planned expiration.',
    `effective_start_date` DATE COMMENT 'Date from which this random pool becomes active and available for workforce selection operations.',
    `eligibility_criteria` STRING COMMENT 'Business rules or criteria that determine which workforce members qualify for inclusion in this random pool (e.g., certification level, seniority, job classification).',
    `facility_code` STRING COMMENT 'Code identifying the facility, warehouse, or hub where this random pool is primarily utilized for labor scheduling.',
    `is_drug_test_required` BOOLEAN COMMENT 'Indicates whether members of this pool must maintain current drug testing compliance per DOT or company safety regulations.',
    `is_overtime_eligible` BOOLEAN COMMENT 'Indicates whether members selected from this pool are eligible for overtime assignments under labor agreements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this random pool record was last updated or modified.',
    `last_selection_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent selection event drawn from this pool, used for tracking pool utilization and freshness.',
    `max_consecutive_selections` STRING COMMENT 'Maximum number of consecutive times a single member can be selected before being excluded from the next draw, ensuring fairness.',
    `maximum_pool_size` STRING COMMENT 'Maximum number of members allowed in the pool to maintain manageable selection ratios and equitable assignment distribution.',
    `minimum_pool_size` STRING COMMENT 'Minimum number of eligible members required in the pool before selections can be made, ensuring adequate coverage for operational needs.',
    `notes` STRING COMMENT 'Free-text notes or comments about the random pool for operational context, special instructions, or administrative remarks.',
    `owning_department` STRING COMMENT 'Department or organizational unit responsible for managing and maintaining this random pool within the workforce hierarchy.',
    `pool_code` STRING COMMENT 'Unique business code identifying the random pool for cross-system reference and operational use in workforce scheduling systems.',
    `pool_name` STRING COMMENT 'Human-readable name of the random pool used for display in workforce management interfaces and reporting.',
    `pool_type` STRING COMMENT 'Classification of the random pool by workforce category, indicating the type of labor resource the pool draws from.',
    `priority_level` STRING COMMENT 'Numeric priority ranking of the pool used when multiple pools are available for the same assignment, with lower numbers indicating higher priority.',
    `region_code` STRING COMMENT 'Geographic region code indicating the operational area this random pool serves for workforce deployment.',
    `rotation_interval_days` STRING COMMENT 'Number of days between mandatory pool membership rotations to ensure equitable opportunity distribution among eligible workers.',
    `selection_frequency` STRING COMMENT 'How often selections are drawn from this pool for workforce assignment or scheduling cycles.',
    `selection_method` STRING COMMENT 'Algorithm or method used to select members from the pool for assignment to shifts, routes, or tasks.',
    `shift_pattern` STRING COMMENT 'The shift pattern or schedule type that this random pool is associated with for labor scheduling purposes.',
    `random_pool_status` STRING COMMENT 'Current lifecycle status of the random pool indicating whether it is available for workforce selection operations.',
    `union_agreement_code` STRING COMMENT 'Code referencing the collective bargaining agreement or union contract that governs random selection rules for this pool.',
    CONSTRAINT pk_random_pool PRIMARY KEY(`random_pool_id`)
) COMMENT 'Master reference table for random_pool. Referenced by random_pool_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Primary key for payroll_run',
    `employee_id` BIGINT COMMENT 'Identifier of the payroll administrator or manager who approved this payroll run for processing. Required for SOX compliance and segregation of duties audit trail.',
    `company_code_id` BIGINT COMMENT 'Identifier for the legal entity or company under which this payroll run is processed. Critical for multi-entity logistics organizations operating across jurisdictions.',
    `cost_center_id` BIGINT COMMENT 'Primary cost center to which this payroll runs labor costs are allocated. For multi-cost-center runs, this represents the dominant allocation target.',
    `initiated_by_employee_id` BIGINT COMMENT 'Identifier of the payroll specialist who initiated this payroll run. Supports segregation of duties controls requiring different individuals to initiate and approve.',
    `pay_group_id` BIGINT COMMENT 'Identifier for the pay group this run processes. Pay groups segment the workforce by pay frequency, legal entity, or operational division (e.g., drivers, warehouse staff, corporate).',
    `reversed_run_id` BIGINT COMMENT 'Identifier of the original payroll run that this run reverses, if this is a reversal run. Establishes the audit trail between correction and original transactions.',
    `reversal_payroll_run_id` BIGINT COMMENT 'Self-referencing FK on payroll_run (reversal_payroll_run_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll run was approved for payment disbursement. Represents the authorization checkpoint in the payroll workflow.',
    `bank_file_reference` STRING COMMENT 'Reference number for the ACH/bank file generated for direct deposit payments. Used for reconciliation with banking institutions and payment confirmation.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit (e.g., express delivery, freight forwarding, supply chain management, e-commerce fulfillment) associated with this payroll run.',
    `check_count` STRING COMMENT 'Total number of individual payment transactions (checks or direct deposits) generated by this payroll run. May differ from employee count due to multiple payment methods per employee.',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the jurisdiction under which this payroll run is processed. Determines applicable tax laws and labor regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll run record was first created in the system. Represents the initial setup of the run prior to processing.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payroll run. Indicates the currency in which gross pay, deductions, and net pay are denominated.',
    `payroll_run_description` STRING COMMENT 'Free-text description or notes about this payroll run providing context such as special processing instructions, reason for off-cycle run, or other operational commentary.',
    `employee_count` STRING COMMENT 'Total number of employees processed in this payroll run. Includes all active employees in the pay group who received compensation during the pay period.',
    `employer_benefits_amount` DECIMAL(18,2) COMMENT 'Total employer-paid benefits contributions for this payroll run including health insurance, retirement plan matching, life insurance, and other employer-funded benefits.',
    `employer_tax_amount` DECIMAL(18,2) COMMENT 'Total employer-side tax liability for this payroll run including FICA employer match, FUTA, SUTA, and other jurisdiction-specific employer taxes.',
    `error_count` STRING COMMENT 'Number of calculation or validation errors encountered during payroll run processing. Zero indicates a clean run; non-zero requires review before approval.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) to which this payroll run is attributed. Supports period-close reporting and labor cost accrual processes.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this payroll run is attributed for financial reporting purposes. May differ from calendar year depending on company fiscal calendar.',
    `garnishment_count` STRING COMMENT 'Number of active wage garnishment orders processed in this payroll run. Includes court-ordered child support, tax levies, and creditor garnishments requiring compliance tracking.',
    `gl_posting_date` DATE COMMENT 'Date on which payroll journal entries were posted to the general ledger. Used for financial period alignment and accounting reconciliation.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total gross compensation amount for all employees included in this payroll run before any deductions or withholdings. Includes base pay, overtime, shift differentials, and allowances.',
    `is_final_run` BOOLEAN COMMENT 'Indicates whether this is the final payroll run for the pay period. False for preliminary/preview runs used for validation before the confirmed disbursement run.',
    `is_retroactive` BOOLEAN COMMENT 'Indicates whether this payroll run includes retroactive pay adjustments for prior periods. True when back-dated compensation changes (e.g., rate increases, reclassifications) are processed.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Total net pay disbursed to all employees in this payroll run after all deductions. Represents the actual cash outflow for employee compensation.',
    `overtime_hours_total` DECIMAL(18,2) COMMENT 'Aggregate overtime hours across all employees in this payroll run. Critical for DOT hours-of-service compliance monitoring for drivers and warehouse labor cost analysis.',
    `pay_frequency` STRING COMMENT 'The frequency at which this payroll run cycle occurs. Determines the cadence of compensation disbursement for the associated pay group.',
    `pay_period_end_date` DATE COMMENT 'Last day of the pay period covered by this payroll run. Defines the end of the earnings accumulation window.',
    `pay_period_start_date` DATE COMMENT 'First day of the pay period covered by this payroll run. Defines the beginning of the earnings accumulation window.',
    `payment_date` DATE COMMENT 'The date on which employee payments are disbursed (direct deposit or check date). This is the constructive receipt date for tax purposes.',
    `payment_method` STRING COMMENT 'Primary disbursement method used for this payroll run. Mixed indicates the run contains multiple payment methods across employees.',
    `processing_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll run calculation processing completed. Used with start timestamp to measure processing duration and identify performance issues.',
    `processing_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll run calculation processing began. Used for SLA monitoring and payroll operations performance tracking.',
    `regular_hours_total` DECIMAL(18,2) COMMENT 'Aggregate regular (non-overtime) hours worked across all employees in this payroll run. Used for FTE planning and labor utilization analysis.',
    `reversal_reason` STRING COMMENT 'Explanation for why a payroll run was reversed, if applicable. Captures the business justification for voiding a previously completed run (e.g., calculation error, duplicate processing).',
    `run_number` STRING COMMENT 'Externally-visible business identifier for the payroll run, used in communications and audit trails. Typically follows a structured format including year and sequence.',
    `run_type` STRING COMMENT 'Classification of the payroll run indicating its nature. Regular runs are scheduled cycles; supplemental covers additional payments; off-cycle handles ad-hoc processing; correction adjusts prior errors; bonus processes incentive payments; final handles employee separations.',
    `payroll_run_status` STRING COMMENT 'Current state of the payroll run in its processing lifecycle. Draft indicates setup; in_progress means calculations are running; completed means processing finished; posted means entries sent to GL; reversed indicates full reversal; cancelled means run was abandoned.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the specific tax jurisdiction (state, province, or local) applicable to this payroll run. Supports multi-jurisdiction payroll processing for distributed logistics operations.',
    `total_deductions_amount` DECIMAL(18,2) COMMENT 'Aggregate amount of all employee deductions in this payroll run including tax withholdings, benefit premiums, retirement contributions, garnishments, and voluntary deductions.',
    `total_labor_cost` DECIMAL(18,2) COMMENT 'Fully-loaded labor cost for this payroll run including gross pay, employer taxes, and employer benefit contributions. Used for labor cost allocation across freight and fulfillment operations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this payroll run record. Tracks when status changes, amount updates, or other modifications occurred.',
    `warning_count` STRING COMMENT 'Number of non-blocking warnings generated during payroll run processing. Warnings flag potential issues (e.g., unusual overtime, missing time entries) that do not prevent completion.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master reference table for payroll_run. Referenced by payroll_run_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`training_session` (
    `training_session_id` BIGINT COMMENT 'Primary key for training_session',
    `training_course_id` BIGINT COMMENT 'Reference to the parent course or learning program that this session belongs to within the training curriculum.',
    `facility_id` BIGINT COMMENT 'Reference to the physical facility or location where the training session is conducted, such as a warehouse training room or distribution center.',
    `employee_id` BIGINT COMMENT 'Reference to the employee record of the primary instructor or facilitator delivering the training session.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: training_session has department_id BIGINT. In the workforce domain, departments are modeled as org_unit. Creating properly-named org_unit_id FK and removing denormalized department_id. Links training ',
    `prerequisite_session_id` BIGINT COMMENT 'Reference to another training session that must be completed before enrollment in this session is permitted.',
    `rescheduled_training_session_id` BIGINT COMMENT 'Self-referencing FK on training_session (rescheduled_training_session_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the training session concluded, used for duration calculation and compliance records.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the training session commenced, recorded for attendance and compliance tracking.',
    `assessment_required` BOOLEAN COMMENT 'Indicates whether participants must complete a formal assessment or examination as part of this training session.',
    `attendance_count` STRING COMMENT 'Actual number of participants who attended the training session, recorded upon session completion.',
    `cancellation_reason` STRING COMMENT 'Reason provided when a training session is cancelled or postponed, used for workforce planning analysis and rescheduling.',
    `training_session_category` STRING COMMENT 'High-level subject category grouping the training session for reporting and curriculum planning purposes. [ENUM-REF-CANDIDATE: safety|compliance|technical|leadership|operational|onboarding|soft_skills|hazmat|driver_certification|warehouse_ops|customer_service — promote to reference product]',
    `certification_type` STRING COMMENT 'Type of professional certification or regulatory qualification that this training session contributes toward, relevant for DOT/ICAO crew qualification compliance.',
    `competency_area` STRING COMMENT 'The role-based competency domain that this training session develops, aligned with the organizations competency framework.',
    `compliance_required` BOOLEAN COMMENT 'Indicates whether this training session is mandated by regulatory or company compliance requirements (e.g., DOT hours-of-service, OSHA safety).',
    `cost_center_code` STRING COMMENT 'Organizational cost center code to which the training session expense is allocated for financial reporting and labor cost tracking.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost_per_session amount.',
    `cost_per_session` DECIMAL(18,2) COMMENT 'Total cost allocated to conducting this training session including instructor fees, materials, and facility charges, used for labor cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training session record was first created in the system of record.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of continuing education or professional development credit hours awarded upon successful completion of this training session.',
    `delivery_platform` STRING COMMENT 'Name or identifier of the platform used to deliver the training (e.g., Workday Learning, Teams, Zoom, in-person facility name) for virtual and blended sessions.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Planned total duration of the training session measured in hours, used for labor scheduling and credit hour tracking.',
    `effective_date` DATE COMMENT 'Date from which the training session content and certification validity become effective for compliance purposes.',
    `enrolled_count` STRING COMMENT 'Current number of participants enrolled in the training session at the time of record update.',
    `expiration_date` DATE COMMENT 'Date after which the training session content is no longer valid and must be refreshed or the session version retired.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this training session record is currently active and available for enrollment versus archived or retired.',
    `language` STRING COMMENT 'ISO 639-1 language code indicating the primary language in which the training session is delivered.',
    `materials_provided` BOOLEAN COMMENT 'Indicates whether training materials (manuals, handouts, digital resources) are provided to participants as part of the session.',
    `max_capacity` STRING COMMENT 'Maximum number of participants that can be enrolled in this training session based on room capacity or virtual platform limits.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training session record was last updated or modified.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score or percentage required for a participant to pass the training session assessment, applicable for certification and compliance courses.',
    `recurrence_interval_months` STRING COMMENT 'Number of months after which this training must be repeated for ongoing compliance or certification renewal purposes.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority mandating this training (e.g., DOT, OSHA, ICAO, IMO) when the session is compliance-driven.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'The planned date and time when the training session is scheduled to conclude.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'The planned date and time when the training session is scheduled to begin.',
    `session_code` STRING COMMENT 'Externally-known unique business identifier code for the training session, used for scheduling and enrollment references across Workday HCM and operational systems.',
    `session_description` STRING COMMENT 'Detailed narrative description of the training session content, learning objectives, and expected outcomes.',
    `session_type` STRING COMMENT 'Classification of the training delivery method indicating how the session is conducted.',
    `training_session_status` STRING COMMENT 'Current lifecycle state of the training session indicating its progress from scheduling through completion or cancellation.',
    `target_job_family` STRING COMMENT 'The job family or role group that this training session is designed for (e.g., drivers, warehouse associates, freight handlers, management).',
    `timezone` STRING COMMENT 'IANA timezone identifier for the training session location or virtual meeting, ensuring correct scheduling across global operations.',
    `title` STRING COMMENT 'Human-readable title or name of the training session describing the subject matter covered.',
    `version_number` STRING COMMENT 'Version identifier for the training content, allowing tracking of curriculum updates and ensuring participants receive current material.',
    `virtual_meeting_url` STRING COMMENT 'Web URL for joining the training session when delivered virtually, applicable for remote and blended delivery modes.',
    CONSTRAINT pk_training_session PRIMARY KEY(`training_session_id`)
) COMMENT 'Master reference table for training_session. Referenced by training_session_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Primary key for training_course',
    `prerequisite_training_course_id` BIGINT COMMENT 'Self-referencing FK on training_course (prerequisite_training_course_id)',
    `applicable_job_family` STRING COMMENT 'The Workday HCM job family or families to which this course applies, supporting role-based competency assignment and workforce planning.',
    `training_course_category` STRING COMMENT 'High-level subject area or functional category the course belongs to (e.g., safety, compliance, operations, leadership, technical skills). [ENUM-REF-CANDIDATE: safety|compliance|operations|leadership|technical|customer_service|hazmat|driving|warehouse — promote to reference product]',
    `certification_body` STRING COMMENT 'External certification or accreditation body that recognizes or accredits this training course (e.g., IATA, Smith System, National Safety Council).',
    `competency_area` STRING COMMENT 'The competency domain or skill cluster that this course develops, aligned with the organizations competency framework for talent management.',
    `compliance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this course is mandated by a regulatory body or internal compliance policy. True means the course is legally or contractually required for certain roles.',
    `content_owner` STRING COMMENT 'Name or identifier of the business unit or individual responsible for maintaining and updating the course content.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost per participant amount.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Standard cost allocated per participant for this training course, used for labor cost allocation and workforce budget planning.',
    `country_applicability` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this course is applicable or required, supporting global logistics operations across multiple jurisdictions.',
    `course_code` STRING COMMENT 'Externally-known unique alphanumeric code used to identify the training course across systems and communications. Used in Workday HCM learning module as the course catalog identifier.',
    `course_description` STRING COMMENT 'Detailed narrative description of the training course content, objectives, and learning outcomes.',
    `course_type` STRING COMMENT 'Classification of the training course by its purpose or requirement level within the organization.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this training course record was first created in the system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of continuing education or professional development credit hours awarded upon successful completion of the course.',
    `delivery_method` STRING COMMENT 'The instructional format or modality through which the training course is delivered to participants.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total estimated duration of the training course measured in hours, including all modules and assessments.',
    `effective_date` DATE COMMENT 'Date from which this course version becomes available for enrollment and scheduling.',
    `enrollment_open_flag` BOOLEAN COMMENT 'Indicates whether the course is currently accepting new enrollments. Used by workforce scheduling systems to determine available training options.',
    `hazmat_certification_flag` BOOLEAN COMMENT 'Indicates whether this course provides or renews hazardous materials handling certification required for freight and express delivery operations.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 region) indicating the primary language in which the course content is delivered.',
    `last_review_date` DATE COMMENT 'Date when the course content was last reviewed for accuracy and regulatory alignment. Supports compliance audit trails.',
    `lms_course_url` STRING COMMENT 'Direct URL link to the course within the Learning Management System for e-learning and blended delivery access.',
    `max_attempts` STRING COMMENT 'Maximum number of attempts allowed for the final assessment before requiring course re-enrollment.',
    `max_class_size` STRING COMMENT 'Maximum number of participants allowed per session or cohort for instructor-led or virtual classroom delivery.',
    `modified_date` TIMESTAMP COMMENT 'Timestamp when this training course record was last updated or modified.',
    `next_review_date` DATE COMMENT 'Date when the next content review is scheduled, ensuring ongoing regulatory compliance and content freshness.',
    `passing_score_percent` DECIMAL(18,2) COMMENT 'Minimum assessment score percentage required to successfully complete the course and receive certification.',
    `prerequisite_course_code` STRING COMMENT 'Course code of the prerequisite training that must be completed before enrolling in this course. Null if no prerequisite exists.',
    `provider_name` STRING COMMENT 'Name of the external training provider or internal department responsible for developing and delivering the course content.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether periodic recertification is required after the validity period expires. Essential for DOT and ICAO compliance tracking.',
    `regulatory_domain` STRING COMMENT 'The regulatory body or compliance framework that mandates or governs this training course. Critical for DOT driver certifications, ICAO crew qualifications, and OSHA safety requirements in logistics.',
    `renewal_grace_period_days` STRING COMMENT 'Number of days after certification expiry during which an employee may still operate while completing recertification, per regulatory allowance.',
    `retirement_date` DATE COMMENT 'Date on which this course is retired and no longer available for new enrollments. Null for currently active courses.',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether this course covers safety-critical operations where non-compliance could result in injury, environmental harm, or regulatory penalty.',
    `skill_level` STRING COMMENT 'The proficiency level targeted by this course, used for role-based competency mapping and talent development planning.',
    `training_course_status` STRING COMMENT 'Current state of the training course in its lifecycle, indicating whether it is available for enrollment.',
    `target_audience` STRING COMMENT 'Description of the intended audience or job roles for this course (e.g., CDL drivers, warehouse associates, freight handlers, supply chain managers).',
    `title` STRING COMMENT 'Human-readable name or title of the training course as displayed in the learning catalog.',
    `validity_period_months` STRING COMMENT 'Number of months the certification or qualification remains valid after course completion before recertification is required. Critical for DOT/ICAO crew qualification compliance tracking.',
    `version_number` STRING COMMENT 'Version identifier for the course content, used to track curriculum updates and ensure employees complete the most current version.',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Master reference table for training_course. Referenced by course_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`workforce`.`pay_group` (
    `pay_group_id` BIGINT COMMENT 'Primary key for pay_group',
    `parent_pay_group_id` BIGINT COMMENT 'Self-referencing FK on pay_group (parent_pay_group_id)',
    `approval_required` BOOLEAN COMMENT 'Indicates whether payroll runs for this pay group require managerial or HR approval before disbursement.',
    `benefits_eligible` BOOLEAN COMMENT 'Indicates whether employees in this pay group are eligible for company-sponsored benefits (health insurance, retirement plans, etc.).',
    `pay_group_code` STRING COMMENT 'Short alphanumeric business code uniquely identifying the pay group within the organization. Used as the externally-known reference in Workday HCM and downstream payroll systems.',
    `collective_bargaining_agreement_ref` STRING COMMENT 'Reference code or name of the applicable collective bargaining agreement governing compensation terms for unionized pay groups.',
    `cost_center_code` STRING COMMENT 'Default cost center code for labor cost allocation and financial reporting associated with this pay group.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the jurisdiction whose labor laws and tax regulations govern this pay group.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this pay group record was initially created in the system of record.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which this pay groups compensation is denominated (e.g., USD, EUR, GBP).',
    `default_payment_method` STRING COMMENT 'The default disbursement method for employees assigned to this pay group unless overridden at the individual level.',
    `pay_group_description` STRING COMMENT 'Detailed narrative description of the pay groups purpose, scope, and applicable employee population.',
    `dot_regulated` BOOLEAN COMMENT 'Indicates whether this pay group includes positions subject to DOT hours-of-service regulations, affecting overtime and scheduling rules for drivers and crew.',
    `effective_end_date` DATE COMMENT 'Date after which this pay group is no longer valid for new assignments. Null indicates an open-ended/currently active configuration.',
    `effective_start_date` DATE COMMENT 'Date from which this pay group configuration becomes effective and can be assigned to employees.',
    `garnishment_processing_enabled` BOOLEAN COMMENT 'Indicates whether this pay group supports automated wage garnishment deductions as required by court orders or tax levies.',
    `gl_account_code` STRING COMMENT 'Default general ledger account code used for posting payroll expenses for employees in this pay group.',
    `headcount` STRING COMMENT 'Current number of active employees assigned to this pay group. Updated periodically for workforce planning and capacity reporting.',
    `labor_category` STRING COMMENT 'Broad operational labor category for workforce planning and cost allocation across logistics functions (warehouse operations, driving, office, management, field operations).',
    `last_payroll_run_date` DATE COMMENT 'Date of the most recent completed payroll processing run for this pay group.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity (company or subsidiary) under which this pay group operates. Determines tax filing obligations and statutory reporting.',
    `minimum_wage_rate` DECIMAL(18,2) COMMENT 'The applicable minimum hourly wage rate for this pay group based on jurisdiction. Used for compliance validation against local labor laws.',
    `modified_date` TIMESTAMP COMMENT 'Timestamp when this pay group record was last updated or modified.',
    `pay_group_name` STRING COMMENT 'Human-readable descriptive name of the pay group, used in reporting and employee-facing communications (e.g., US Salaried Bi-Weekly, EU Hourly Weekly).',
    `next_pay_date` DATE COMMENT 'The next upcoming payment disbursement date for employees in this pay group. Updated after each payroll run completion.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether employees in this pay group are eligible for overtime compensation under applicable labor regulations (FLSA non-exempt status).',
    `pay_calendar_id` BIGINT COMMENT 'Identifier of the associated pay calendar that defines specific pay period start/end dates and payment dates for this group.',
    `pay_frequency` STRING COMMENT 'The cadence at which employees in this pay group receive compensation. Drives payroll calendar generation and labor cost accrual periods.',
    `pay_lag_days` STRING COMMENT 'Number of days between the end of a pay period and the actual payment date. Represents the processing delay for payroll calculation and disbursement.',
    `pay_period_days` STRING COMMENT 'Number of calendar days in a standard pay period for this group. Used for labor cost allocation and accrual calculations.',
    `payroll_provider` STRING COMMENT 'Name or identifier of the external payroll processing provider or internal system responsible for executing payroll runs for this group.',
    `region` STRING COMMENT 'Geographic operating region or business unit region to which this pay group is assigned for organizational reporting purposes.',
    `retirement_plan_eligible` BOOLEAN COMMENT 'Indicates whether employees in this pay group are eligible to participate in employer-sponsored retirement/pension plans.',
    `retroactive_pay_enabled` BOOLEAN COMMENT 'Indicates whether this pay group supports retroactive pay adjustments for backdated compensation changes.',
    `shift_differential_eligible` BOOLEAN COMMENT 'Indicates whether employees in this pay group qualify for shift differential pay premiums for non-standard working hours (nights, weekends, holidays).',
    `source_system` STRING COMMENT 'Name or identifier of the originating system of record (e.g., Workday HCM) from which this pay group data was sourced.',
    `standard_work_hours_per_week` DECIMAL(18,2) COMMENT 'The standard number of working hours per week for full-time employees in this pay group. Used for FTE calculations and overtime threshold determination.',
    `pay_group_status` STRING COMMENT 'Current lifecycle status of the pay group indicating whether it is actively used for payroll processing.',
    `tax_jurisdiction` STRING COMMENT 'The primary tax jurisdiction (state, province, or region) applicable to payroll tax withholding and reporting for this pay group.',
    `time_zone` STRING COMMENT 'IANA time zone identifier (e.g., America/New_York) used for determining pay period boundaries and scheduling cutoff times.',
    `pay_group_type` STRING COMMENT 'Classification of the pay group by compensation structure. Determines how earnings are calculated for members of this group.',
    `union_affiliated` BOOLEAN COMMENT 'Indicates whether this pay group is governed by a collective bargaining agreement (CBA) with a labor union, affecting pay scales and benefits.',
    CONSTRAINT pk_pay_group PRIMARY KEY(`pay_group_id`)
) COMMENT 'Master reference table for pay_group. Referenced by pay_group_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_position_last_modified_by_user_employee_id` FOREIGN KEY (`position_last_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_supervisor_position_id` FOREIGN KEY (`supervisor_position_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_location_id` FOREIGN KEY (`location_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_reports_to_job_profile_id` FOREIGN KEY (`reports_to_job_profile_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ADD CONSTRAINT `fk_workforce_worker_assignment_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ADD CONSTRAINT `fk_workforce_worker_assignment_labor_contract_id` FOREIGN KEY (`labor_contract_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`labor_contract`(`labor_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ADD CONSTRAINT `fk_workforce_worker_assignment_location_id` FOREIGN KEY (`location_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ADD CONSTRAINT `fk_workforce_worker_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ADD CONSTRAINT `fk_workforce_worker_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ADD CONSTRAINT `fk_workforce_worker_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ADD CONSTRAINT `fk_workforce_worker_assignment_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_labor_contract_id` FOREIGN KEY (`labor_contract_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`labor_contract`(`labor_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_tertiary_compensation_modified_by_user_employee_id` FOREIGN KEY (`tertiary_compensation_modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ADD CONSTRAINT `fk_workforce_driver_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ADD CONSTRAINT `fk_workforce_crew_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ADD CONSTRAINT `fk_workforce_competency_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ADD CONSTRAINT `fk_workforce_competency_record_primary_competency_employee_id` FOREIGN KEY (`primary_competency_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ADD CONSTRAINT `fk_workforce_competency_record_tertiary_competency_verified_by_employee_id` FOREIGN KEY (`tertiary_competency_verified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_tertiary_shift_original_employee_id` FOREIGN KEY (`tertiary_shift_original_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_tertiary_shift_original_employee_id` FOREIGN KEY (`tertiary_shift_original_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_location_id` FOREIGN KEY (`location_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_fmla_case_id` FOREIGN KEY (`fmla_case_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`fmla_case`(`fmla_case_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_primary_absence_employee_id` FOREIGN KEY (`primary_absence_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_payroll_record_id` FOREIGN KEY (`payroll_record_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_position_id` FOREIGN KEY (`position_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_primary_labor_employee_id` FOREIGN KEY (`primary_labor_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ADD CONSTRAINT `fk_workforce_fte_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ADD CONSTRAINT `fk_workforce_fte_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ADD CONSTRAINT `fk_workforce_fte_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_fte_plan_id` FOREIGN KEY (`fte_plan_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`fte_plan`(`fte_plan_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_primary_recruitment_hiring_manager_employee_id` FOREIGN KEY (`primary_recruitment_hiring_manager_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_quaternary_recruitment_replacement_employee_id` FOREIGN KEY (`quaternary_recruitment_replacement_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_quinary_recruitment_employee_id` FOREIGN KEY (`quinary_recruitment_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_tertiary_recruitment_approved_by_employee_id` FOREIGN KEY (`tertiary_recruitment_approved_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_location_id` FOREIGN KEY (`location_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_primary_performance_employee_id` FOREIGN KEY (`primary_performance_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_worker_assignment_id` FOREIGN KEY (`worker_assignment_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`worker_assignment`(`worker_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_tertiary_training_verified_by_employee_id` FOREIGN KEY (`tertiary_training_verified_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ADD CONSTRAINT `fk_workforce_hours_of_service_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ADD CONSTRAINT `fk_workforce_hours_of_service_log_tertiary_hours_employee_id` FOREIGN KEY (`tertiary_hours_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ADD CONSTRAINT `fk_workforce_drug_alcohol_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ADD CONSTRAINT `fk_workforce_drug_alcohol_test_random_pool_id` FOREIGN KEY (`random_pool_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`random_pool`(`random_pool_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ADD CONSTRAINT `fk_workforce_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ADD CONSTRAINT `fk_workforce_labor_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ADD CONSTRAINT `fk_workforce_labor_contract_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ADD CONSTRAINT `fk_workforce_initiative_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ADD CONSTRAINT `fk_workforce_workforce_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ADD CONSTRAINT `fk_workforce_workforce_training_completion_training_session_id` FOREIGN KEY (`training_session_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`training_session`(`training_session_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ADD CONSTRAINT `fk_workforce_target_accountability_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ADD CONSTRAINT `fk_workforce_fmla_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ADD CONSTRAINT `fk_workforce_fmla_case_hr_administrator_employee_id` FOREIGN KEY (`hr_administrator_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ADD CONSTRAINT `fk_workforce_fmla_case_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ADD CONSTRAINT `fk_workforce_fmla_case_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ADD CONSTRAINT `fk_workforce_fmla_case_location_id` FOREIGN KEY (`location_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ADD CONSTRAINT `fk_workforce_fmla_case_recurrence_fmla_case_id` FOREIGN KEY (`recurrence_fmla_case_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`fmla_case`(`fmla_case_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`random_pool` ADD CONSTRAINT `fk_workforce_random_pool_prior_random_pool_id` FOREIGN KEY (`prior_random_pool_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`random_pool`(`random_pool_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_initiated_by_employee_id` FOREIGN KEY (`initiated_by_employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_pay_group_id` FOREIGN KEY (`pay_group_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`pay_group`(`pay_group_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_reversed_run_id` FOREIGN KEY (`reversed_run_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_reversal_payroll_run_id` FOREIGN KEY (`reversal_payroll_run_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_prerequisite_session_id` FOREIGN KEY (`prerequisite_session_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`training_session`(`training_session_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_rescheduled_training_session_id` FOREIGN KEY (`rescheduled_training_session_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`training_session`(`training_session_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_prerequisite_training_course_id` FOREIGN KEY (`prerequisite_training_course_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `transport_shipping_ecm`.`workforce`.`pay_group` ADD CONSTRAINT `fk_workforce_pay_group_parent_pay_group_id` FOREIGN KEY (`parent_pay_group_id`) REFERENCES `transport_shipping_ecm`.`workforce`.`pay_group`(`pay_group_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `transport_shipping_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'organization_structure');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `customs_broker_license` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker License Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `customs_broker_license` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `customs_broker_license` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `dot_medical_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Medical Certification Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `dot_medical_certification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `dot_medical_certification_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `dot_medical_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Medical Certification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `dot_medical_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `dot_medical_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `driver_license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Driver License Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `driver_license_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `driver_license_expiry_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_business_glossary_term' = 'Driver License Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|terminated|retired|deceased');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|seasonal|intern');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `forklift_certification` SET TAGS ('dbx_business_glossary_term' = 'Forklift Certification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `fte` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `hazmat_certification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `hazmat_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Mobile Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Passport Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|commission|piece_rate');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|standard|enhanced|top_secret');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'resignation|retirement|layoff|termination_for_cause|end_of_contract|deceased');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `union_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `union_membership` SET TAGS ('dbx_business_glossary_term' = 'Union Membership');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `union_membership` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `work_city` SET TAGS ('dbx_business_glossary_term' = 'Work City');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `work_country` SET TAGS ('dbx_business_glossary_term' = 'Work Country');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `work_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`employee` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'organization_structure');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `external_org_code` SET TAGS ('dbx_business_glossary_term' = 'External Organization ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_actual` SET TAGS ('dbx_business_glossary_term' = 'Headcount Actual (Full-Time Equivalent)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_planned` SET TAGS ('dbx_business_glossary_term' = 'Headcount Planned (Full-Time Equivalent)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Is Revenue Generating Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `operational_scope` SET TAGS ('dbx_business_glossary_term' = 'Operational Scope');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `operational_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_value_regex' = 'division|department|cost_center|team|region|district');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `union_representation` SET TAGS ('dbx_business_glossary_term' = 'Union Representation Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `union_representation` SET TAGS ('dbx_value_regex' = 'unionized|non_unionized|mixed');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'organization_structure');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `position_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `position_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `position_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `supervisor_position_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Position Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `budget_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Authorization Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `grade_level` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `grade_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `is_critical_role` SET TAGS ('dbx_business_glossary_term' = 'Critical Role Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `is_remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `is_safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Safety-Sensitive Position Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `job_function` SET TAGS ('dbx_business_glossary_term' = 'Job Function');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `position_number` SET TAGS ('dbx_business_glossary_term' = 'Position Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `position_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|frozen|closed|pending_approval');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'regular|temporary|seasonal|contract|intern');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `requires_customs_clearance` SET TAGS ('dbx_business_glossary_term' = 'Customs Security Clearance Required Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `requires_dot_certification` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Certification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `time_type` SET TAGS ('dbx_business_glossary_term' = 'Time Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `time_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Union Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `work_shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`position` ALTER COLUMN `work_shift` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|flexible');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'organization_structure');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `reports_to_job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Job Profile Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `education_level_required` SET TAGS ('dbx_business_glossary_term' = 'Education Level Required');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `is_customer_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Facing');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `is_safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Is Safety Sensitive');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `is_union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Union Eligible');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_category` SET TAGS ('dbx_business_glossary_term' = 'Job Category');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_category` SET TAGS ('dbx_value_regex' = 'operational|administrative|technical|managerial|professional|executive');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|obsolete');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `key_responsibilities` SET TAGS ('dbx_business_glossary_term' = 'Key Responsibilities');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `max_salary` SET TAGS ('dbx_business_glossary_term' = 'Maximum Salary');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `max_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `min_salary` SET TAGS ('dbx_business_glossary_term' = 'Minimum Salary');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `min_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `min_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `physical_requirements` SET TAGS ('dbx_business_glossary_term' = 'Physical Requirements');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `required_competencies` SET TAGS ('dbx_business_glossary_term' = 'Required Competencies');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `requires_customs_broker_license` SET TAGS ('dbx_business_glossary_term' = 'Requires Customs Broker License');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `requires_dot_qualification` SET TAGS ('dbx_business_glossary_term' = 'Requires Department of Transportation (DOT) Qualification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `requires_forklift_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires Forklift Certification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `requires_hazmat_endorsement` SET TAGS ('dbx_business_glossary_term' = 'Requires Hazardous Materials (HAZMAT) Endorsement');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `requires_iata_dg_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires International Air Transport Association (IATA) Dangerous Goods (DG) Certification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `requires_security_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Security Clearance');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement_pct` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`job_profile` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|shift|on_call|seasonal|flexible');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` SET TAGS ('dbx_subdomain' = 'organization_structure');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `worker_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Assignment ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `labor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Contract Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|concurrent|temporary|project|acting');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `business_title` SET TAGS ('dbx_business_glossary_term' = 'Business Title');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `customs_broker_license_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker License Required Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `default_expense_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Default Expense Cost Center');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `dot_safety_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Safety-Sensitive Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `driver_qualification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Driver Qualification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|seasonal|intern');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `hazmat_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|commission|piece_rate');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `remote_work_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `scheduled_weekly_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Weekly Hours');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `succession_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `time_type` SET TAGS ('dbx_business_glossary_term' = 'Time Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `time_type` SET TAGS ('dbx_value_regex' = 'salaried|hourly');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `work_shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`worker_assignment` ALTER COLUMN `worker_category` SET TAGS ('dbx_business_glossary_term' = 'Worker Category');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowance Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `benefit_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Deduction Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employer_benefit_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Benefit Contribution Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employer_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `federal_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Garnishment Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Deduction Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_deduction_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_deduction_amount` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `local_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `medicare_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `other_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Deduction Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|quarterly|annual');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|cash|wire_transfer|paycard');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Payroll Approved By');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|approved|paid|voided|reversed');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pto_hours_used` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Hours Used');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pto_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Payout Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `regular_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Retirement Contribution Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `state_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'State Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `carbon_offset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Transaction Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `labor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Contract Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `tertiary_compensation_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `tertiary_compensation_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `tertiary_compensation_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `grade_band` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade Band');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `grade_band` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `hazmat_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Premium Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `hazmat_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `health_insurance_subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Subsidy Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `health_insurance_subsidy_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `health_insurance_subsidy_amount` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `mileage_reimbursement_rate` SET TAGS ('dbx_business_glossary_term' = 'Mileage Reimbursement Rate');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Notes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `overnight_driver_allowance` SET TAGS ('dbx_business_glossary_term' = 'Overnight Driver Allowance');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `overnight_driver_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate Multiplier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Maximum');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_range_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Midpoint');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_range_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Minimum');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `per_diem_amount` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|commission|piece_rate|hybrid');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `reason_for_change` SET TAGS ('dbx_business_glossary_term' = 'Reason for Change');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `retirement_contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retirement Contribution Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z_]{2,20}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `stock_option_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Stock Option Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Bonus Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `union_affiliation_code` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `union_affiliation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Benefits Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Election Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_designation` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_designation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Confirmation Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_group_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Group Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Policy Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Submission Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_end_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_start_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_basis` SET TAGS ('dbx_business_glossary_term' = 'Contribution Basis');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_basis` SET TAGS ('dbx_value_regex' = 'pre_tax|post_tax|employer_paid');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_confirmation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Sent Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online_self_service|hr_representative|benefits_fair|phone|paper_form|auto_enrollment');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^ENR-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|suspended|waived|cancelled');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'new_hire|annual_open|qualifying_life_event|mid_year_change|rehire|status_change');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Required Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `hsa_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'employment_termination|employee_waiver|plan_discontinuation|ineligibility|non_payment|cobra_expiration');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `tobacco_user_flag` SET TAGS ('dbx_business_glossary_term' = 'Tobacco User Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `tobacco_user_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_value_regex' = 'covered_elsewhere|cost|not_needed|other');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `wellness_program_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Participant Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `driver_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Qualification ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `fuel_consumption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Record Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `alcohol_test_last_date` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Test Last Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `alcohol_test_last_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `alcohol_test_result` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Test Result');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `alcohol_test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|refused|pending');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `alcohol_test_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'clear|pending|disqualifying_offense|under_review');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `background_check_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `cdl_class` SET TAGS ('dbx_business_glossary_term' = 'Commercial Drivers License (CDL) Class');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `cdl_class` SET TAGS ('dbx_value_regex' = 'Class A|Class B|Class C');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `cdl_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Drivers License (CDL) Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `cdl_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Drivers License (CDL) Issue Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `cdl_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Drivers License (CDL) Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `cdl_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `cdl_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `cdl_state_issued` SET TAGS ('dbx_business_glossary_term' = 'Commercial Drivers License (CDL) State Issued');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `cdl_state_issued` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `clearinghouse_query_date` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Clearinghouse Query Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `clearinghouse_status` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Clearinghouse Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `clearinghouse_status` SET TAGS ('dbx_value_regex' = 'clear|violation_pending|prohibited|resolved');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `clearinghouse_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `disqualification_end_date` SET TAGS ('dbx_business_glossary_term' = 'Disqualification End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `disqualification_start_date` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `drug_test_last_date` SET TAGS ('dbx_business_glossary_term' = 'Drug Test Last Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `drug_test_last_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `drug_test_result` SET TAGS ('dbx_business_glossary_term' = 'Drug Test Result');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `drug_test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|refused|pending');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `drug_test_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `endorsement_doubles_triples` SET TAGS ('dbx_business_glossary_term' = 'Doubles/Triples Endorsement');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `endorsement_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Endorsement');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `endorsement_passenger` SET TAGS ('dbx_business_glossary_term' = 'Passenger Endorsement');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `endorsement_tanker` SET TAGS ('dbx_business_glossary_term' = 'Tanker Endorsement');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `hos_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Eligibility Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `hos_eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|hours_exceeded|violation_pending|out_of_service');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `hos_violation_count_12m` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Violation Count (12 Months)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_certificate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_certificate_expiration_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_certificate_expiration_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Issue Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_certificate_issue_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_certificate_issue_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Examiners Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_examiner_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Examiner Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_examiner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_examiner_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_examiner_registry_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Examiner National Registry Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_examiner_registry_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_examiner_registry_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_variance_exemption` SET TAGS ('dbx_business_glossary_term' = 'Medical Variance or Exemption Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_variance_exemption` SET TAGS ('dbx_value_regex' = 'none|vision|diabetes|hearing|seizure|other');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `medical_variance_exemption` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `mvr_review_date` SET TAGS ('dbx_business_glossary_term' = 'Motor Vehicle Record (MVR) Review Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `mvr_status` SET TAGS ('dbx_business_glossary_term' = 'Motor Vehicle Record (MVR) Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `mvr_status` SET TAGS ('dbx_value_regex' = 'clear|violations_minor|violations_major|disqualifying|pending_review');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Qualification Review Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `qualification_file_complete` SET TAGS ('dbx_business_glossary_term' = 'Qualification File Complete Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|expired|suspended|pending_renewal|disqualified|under_review');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `road_test_date` SET TAGS ('dbx_business_glossary_term' = 'Road Test Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `road_test_examiner` SET TAGS ('dbx_business_glossary_term' = 'Road Test Examiner Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Entry-Level Driver Training (ELDT) Completion Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`driver_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `crew_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Certification ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Required By Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `airside_pass_number` SET TAGS ('dbx_business_glossary_term' = 'Airside Pass Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `airside_pass_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `airside_pass_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Assessment Result');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `assessment_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|exempt');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|flagged|expired');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal|under_review');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `competency_level` SET TAGS ('dbx_business_glossary_term' = 'Competency Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `competency_level` SET TAGS ('dbx_value_regex' = 'basic|intermediate|advanced|expert|instructor');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `dangerous_goods_category` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Category');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `digital_certificate_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Certificate URL');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `endorsements` SET TAGS ('dbx_business_glossary_term' = 'Endorsements');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `issuing_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `recertification_reason` SET TAGS ('dbx_business_glossary_term' = 'Recertification Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `recertification_reason` SET TAGS ('dbx_value_regex' = 'expiration|regulatory_change|incident|performance_issue|voluntary');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Restrictions');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `scope_of_authorization` SET TAGS ('dbx_business_glossary_term' = 'Scope of Authorization');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'basic|enhanced|top_secret|none');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `training_course_code` SET TAGS ('dbx_business_glossary_term' = 'Training Course Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Hours');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'written_exam|practical_test|online_assessment|on_job_evaluation|portfolio_review');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`crew_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `competency_record_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Record ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `primary_competency_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `primary_competency_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `primary_competency_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `tertiary_competency_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `tertiary_competency_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `tertiary_competency_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `certification_authority` SET TAGS ('dbx_business_glossary_term' = 'Certification Authority');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `competency_category` SET TAGS ('dbx_business_glossary_term' = 'Competency Category');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `competency_name` SET TAGS ('dbx_business_glossary_term' = 'Competency Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `competency_status` SET TAGS ('dbx_business_glossary_term' = 'Competency Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `competency_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending_renewal|suspended|revoked');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `competency_type` SET TAGS ('dbx_business_glossary_term' = 'Competency Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `competency_type` SET TAGS ('dbx_value_regex' = 'operational|professional|technical|leadership|safety|compliance');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `compliance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `development_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `gap_to_target` SET TAGS ('dbx_business_glossary_term' = 'Gap to Target');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `gap_to_target` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|significant');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_value_regex' = 'novice|intermediate|advanced|expert|master');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `proficiency_score` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Score');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency (Months)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `role_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Role Requirement Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `target_proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Target Proficiency Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `target_proficiency_level` SET TAGS ('dbx_value_regex' = 'novice|intermediate|advanced|expert|master');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `training_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Completed');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `training_program_name` SET TAGS ('dbx_business_glossary_term' = 'Training Program Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`competency_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|not_verified|rejected');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'scheduling_operations');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `energy_consumption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Record Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `tertiary_shift_original_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Original Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `tertiary_shift_original_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `tertiary_shift_original_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `absence_covered_flag` SET TAGS ('dbx_business_glossary_term' = 'Absence Covered Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `actual_productivity_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Productivity Units');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `attendance_confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'Attendance Confirmation Method');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `attendance_confirmation_method` SET TAGS ('dbx_value_regex' = 'biometric|badge_scan|manual_entry|mobile_app|supervisor_approval');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `equipment_assigned` SET TAGS ('dbx_business_glossary_term' = 'Equipment Assigned');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `headcount_assigned` SET TAGS ('dbx_business_glossary_term' = 'Headcount Assigned');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `headcount_requirement` SET TAGS ('dbx_business_glossary_term' = 'Headcount Requirement');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `integration_source_system` SET TAGS ('dbx_business_glossary_term' = 'Integration Source System');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `integration_source_system` SET TAGS ('dbx_value_regex' = 'workday|manhattan_wms|manual|mobile_app');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `job_role` SET TAGS ('dbx_business_glossary_term' = 'Job Role');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `labor_standard_units` SET TAGS ('dbx_business_glossary_term' = 'Labor Standard Units');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Notes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_created_by` SET TAGS ('dbx_business_glossary_term' = 'Schedule Created By');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Schedule Modified By');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Published Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Duration Hours');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|split|swing|rotating|on_call');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `work_location_zone` SET TAGS ('dbx_business_glossary_term' = 'Work Location Zone');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` SET TAGS ('dbx_subdomain' = 'scheduling_operations');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `tertiary_shift_original_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Original Employee Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `tertiary_shift_original_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `tertiary_shift_original_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `absence_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `attendance_status` SET TAGS ('dbx_value_regex' = 'present|absent|late|early_departure|partial');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration in Minutes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `is_holiday_shift` SET TAGS ('dbx_business_glossary_term' = 'Holiday Shift Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `is_overtime` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `is_weekend_shift` SET TAGS ('dbx_business_glossary_term' = 'Weekend Shift Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `job_role_code` SET TAGS ('dbx_business_glossary_term' = 'Job Role Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_differential_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|on_call|standby|split|double');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` SET TAGS ('dbx_subdomain' = 'scheduling_operations');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Record ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `fmla_case_id` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Case ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `occupational_health_case_id` SET TAGS ('dbx_business_glossary_term' = 'Occupational Health Case Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `occupational_health_case_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `occupational_health_case_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `primary_absence_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `primary_absence_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `primary_absence_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_reason` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_status` SET TAGS ('dbx_business_glossary_term' = 'Absence Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_status` SET TAGS ('dbx_value_regex' = 'requested|approved|denied|cancelled|completed');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_type` SET TAGS ('dbx_business_glossary_term' = 'Absence Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_type` SET TAGS ('dbx_value_regex' = 'annual_leave|sick_leave|fmla|parental_leave|bereavement|unpaid_leave');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `coverage_arranged` SET TAGS ('dbx_business_glossary_term' = 'Coverage Arranged');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Absence End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `external_absence_code` SET TAGS ('dbx_business_glossary_term' = 'External Absence ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `impact_on_operations` SET TAGS ('dbx_business_glossary_term' = 'Impact on Operations');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `impact_on_operations` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `is_intermittent` SET TAGS ('dbx_business_glossary_term' = 'Is Intermittent Leave');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Is Paid Leave');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `leave_balance_consumed` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Consumed');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Absence Notes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `total_days` SET TAGS ('dbx_business_glossary_term' = 'Total Absence Days');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`absence_record` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Absence Hours');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `labor_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Allocation ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `labor_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Operation ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocated_hours` SET TAGS ('dbx_business_glossary_term' = 'Allocated Hours');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'manual|time_tracking|activity_based|percentage_split|project_assignment|default_split');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|rejected|reversed');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `benefits_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefits Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `freight_mode` SET TAGS ('dbx_business_glossary_term' = 'Freight Mode');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `freight_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `is_capitalized` SET TAGS ('dbx_business_glossary_term' = 'Is Capitalized');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `operational_function` SET TAGS ('dbx_business_glossary_term' = 'Operational Function');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `overtime_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `total_labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` SET TAGS ('dbx_subdomain' = 'organization_structure');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `fte_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Plan ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `actual_fte` SET TAGS ('dbx_business_glossary_term' = 'Actual Full-Time Equivalent (FTE)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `average_salary` SET TAGS ('dbx_business_glossary_term' = 'Average Salary');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `average_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `budget_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Authorization Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `external_plan_code` SET TAGS ('dbx_business_glossary_term' = 'External Plan ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `hiring_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Hiring Plan Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `hiring_plan_status` SET TAGS ('dbx_value_regex' = 'approved|in_progress|on_hold|completed|cancelled|pending_approval');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `is_critical_role` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Role');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `is_remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Remote Eligible');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `is_safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Is Safety Sensitive Position');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `job_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional_certification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `open_positions` SET TAGS ('dbx_business_glossary_term' = 'Open Positions Count');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|closed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `planned_fte` SET TAGS ('dbx_business_glossary_term' = 'Planned Full-Time Equivalent (FTE)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `planning_period` SET TAGS ('dbx_business_glossary_term' = 'Planning Period');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `requires_customs_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Customs Clearance');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `requires_dot_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires Department of Transportation (DOT) Certification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `time_type` SET TAGS ('dbx_business_glossary_term' = 'Time Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `time_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|seasonal');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `variance_fte` SET TAGS ('dbx_business_glossary_term' = 'Variance Full-Time Equivalent (FTE)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `work_shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `work_shift` SET TAGS ('dbx_value_regex' = 'day|night|swing|rotating|on_call');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fte_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_subdomain' = 'organization_structure');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `fte_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Fte Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `primary_recruitment_hiring_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `primary_recruitment_hiring_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `primary_recruitment_hiring_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `quaternary_recruitment_replacement_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `quaternary_recruitment_replacement_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `quaternary_recruitment_replacement_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `quinary_recruitment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `quinary_recruitment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `quinary_recruitment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Staffing Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `candidate_count` SET TAGS ('dbx_business_glossary_term' = 'Candidate Count');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `grade_level` SET TAGS ('dbx_business_glossary_term' = 'Grade Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `grade_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `headcount_quantity` SET TAGS ('dbx_business_glossary_term' = 'Headcount Quantity');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `interview_count` SET TAGS ('dbx_business_glossary_term' = 'Interview Count');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `is_remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Remote Eligible');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `is_safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Is Safety Sensitive');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_function` SET TAGS ('dbx_business_glossary_term' = 'Job Function');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional_certification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `offer_acceptance_rate` SET TAGS ('dbx_business_glossary_term' = 'Offer Acceptance Rate');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `posting_title` SET TAGS ('dbx_business_glossary_term' = 'Posting Title');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requires_customs_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Customs Clearance');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requires_dot_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires Department of Transportation (DOT) Certification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|on_hold|filled|cancelled|closed');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `sourcing_channel` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channel');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill Days');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `time_type` SET TAGS ('dbx_business_glossary_term' = 'Time Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `time_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|temporary');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `worker_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Assignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `acknowledgement_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `bonus_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `bonus_payout_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bonus Payout Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `bonus_payout_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_calibrated|pending_calibration|calibrated|calibration_waived');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating Score');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `customer_service_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Rating');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `customer_service_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_areas` SET TAGS ('dbx_business_glossary_term' = 'Development Areas');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_plan_created_flag` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Created Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment Comments');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_score` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Score');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `key_strengths` SET TAGS ('dbx_business_glossary_term' = 'Key Strengths');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Rating');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Comments');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommended Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_template_name` SET TAGS ('dbx_business_glossary_term' = 'Review Template Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|project_based|ad_hoc|exit');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `safety_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Compliance Rating');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `safety_compliance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `succession_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Succession Readiness Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `succession_readiness_level` SET TAGS ('dbx_value_regex' = 'ready_now|ready_1_year|ready_2_3_years|not_ready|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `teamwork_rating` SET TAGS ('dbx_business_glossary_term' = 'Teamwork and Collaboration Rating');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`performance_review` ALTER COLUMN `teamwork_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `tertiary_training_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `tertiary_training_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `tertiary_training_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Competency Assessment Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `certification_authority` SET TAGS ('dbx_business_glossary_term' = 'Certification Authority');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `compliance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Training Record Notes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|incomplete|waived|in_progress');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Passing Score');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Competency Proficiency Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_value_regex' = 'novice|basic|intermediate|advanced|expert|master');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `proficiency_score` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Score');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Training Provider or Assessor Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = 'internal|external_vendor|regulatory_body|industry_association|academic_institution');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency in Months');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `role_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Role Requirement Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'regulatory_compliance|operational_skills|safety_certification|technical_proficiency|soft_skills|management_development');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `training_code` SET TAGS ('dbx_business_glossary_term' = 'Training Course Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Completed');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `training_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `training_method` SET TAGS ('dbx_value_regex' = 'classroom|online|on_the_job|blended|simulation|workshop');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `training_name` SET TAGS ('dbx_business_glossary_term' = 'Training or Competency Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Record Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'compliance|operational|professional_development|safety|technical|leadership');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|rejected|not_required');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `hours_of_service_log_id` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Log ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `fatigue_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Assessment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `tertiary_hours_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Edited By User ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `tertiary_hours_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `tertiary_hours_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Motor Vehicle (CMV) ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `annotation_text` SET TAGS ('dbx_business_glossary_term' = 'Log Annotation Text');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Log Certification Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|uncertified|rejected|pending');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `certification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Log Certification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `cycle_hours_accumulated` SET TAGS ('dbx_business_glossary_term' = 'Cycle Hours Accumulated');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Cycle Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = '60_hour_7_day|70_hour_8_day');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `dispatch_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Eligibility Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `distance_traveled` SET TAGS ('dbx_business_glossary_term' = 'Distance Traveled');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `distance_unit` SET TAGS ('dbx_business_glossary_term' = 'Distance Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `distance_unit` SET TAGS ('dbx_value_regex' = 'miles|kilometers');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `driving_hours_accumulated` SET TAGS ('dbx_business_glossary_term' = 'Driving Hours Accumulated');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duty Status Duration Hours');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `duty_status` SET TAGS ('dbx_business_glossary_term' = 'Duty Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `duty_status` SET TAGS ('dbx_value_regex' = 'off_duty|sleeper_berth|driving|on_duty_not_driving');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `duty_status_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Duty Status End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `duty_status_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Duty Status Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `edit_flag` SET TAGS ('dbx_business_glossary_term' = 'Log Edit Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `edit_reason` SET TAGS ('dbx_business_glossary_term' = 'Log Edit Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `edited_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Log Edit Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `eld_device_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Logging Device (ELD) Device ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `eld_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `eld_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `eld_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Logging Device (ELD) Registration ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `home_terminal_time_zone` SET TAGS ('dbx_business_glossary_term' = 'Home Terminal Time Zone');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `hours_remaining_in_cycle` SET TAGS ('dbx_business_glossary_term' = 'Hours Remaining in Cycle');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `hours_remaining_on_duty` SET TAGS ('dbx_business_glossary_term' = 'Hours Remaining On-Duty');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `hours_remaining_to_drive` SET TAGS ('dbx_business_glossary_term' = 'Hours Remaining to Drive');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Duty Status Change Location Description');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Duty Status Change Location Latitude');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Duty Status Change Location Longitude');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `log_date` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Log Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `log_entry_method` SET TAGS ('dbx_business_glossary_term' = 'Log Entry Method');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `log_entry_method` SET TAGS ('dbx_value_regex' = 'automatic_eld|manual_eld|paper_log');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `odometer_reading_end` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading at Duty Status End');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `odometer_reading_start` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading at Duty Status Start');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `on_duty_hours_accumulated` SET TAGS ('dbx_business_glossary_term' = 'On-Duty Hours Accumulated');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `rest_break_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Rest Break Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Violation Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `violation_severity` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `violation_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|major|critical');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Violation Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`hours_of_service_log` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'driving_limit|on_duty_limit|cycle_limit|rest_break|sleeper_berth|none');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `drug_alcohol_test_id` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Test ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `driver_safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `random_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Random Testing Pool ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `accident_date` SET TAGS ('dbx_business_glossary_term' = 'Accident Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `accident_report_number` SET TAGS ('dbx_business_glossary_term' = 'Accident Report Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `alcohol_concentration` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Concentration');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `alcohol_concentration` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `alcohol_concentration` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `alcohol_result` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Test Result');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `alcohol_result` SET TAGS ('dbx_value_regex' = 'negative|positive|refused|cancelled|invalid|not tested');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `alcohol_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `alcohol_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `cdl_required` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Required');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `collection_site_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Site Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `collection_site_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Site Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `collector_name` SET TAGS ('dbx_business_glossary_term' = 'Collector Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `collector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `drug_result` SET TAGS ('dbx_business_glossary_term' = 'Drug Test Result');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `drug_result` SET TAGS ('dbx_value_regex' = 'negative|positive|refused|cancelled|invalid|not tested');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `drug_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `drug_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `job_function_tested` SET TAGS ('dbx_business_glossary_term' = 'Job Function Tested');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `laboratory_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `mro_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Review Officer (MRO) Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `mro_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `mro_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Review Officer (MRO) Verification Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `mro_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Review Officer (MRO) Verification Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `mro_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|unable to contact|cancelled by mro');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `random_selection_date` SET TAGS ('dbx_business_glossary_term' = 'Random Selection Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `reasonable_suspicion_basis` SET TAGS ('dbx_business_glossary_term' = 'Reasonable Suspicion Basis');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `reasonable_suspicion_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `record_retention_date` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `refusal_reason` SET TAGS ('dbx_business_glossary_term' = 'Refusal Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `refusal_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `refusal_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'FMCSA|FAA|FTA|PHMSA|FRA|USCG');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `safety_sensitive_position` SET TAGS ('dbx_business_glossary_term' = 'Safety-Sensitive Position');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `sap_evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Substance Abuse Professional (SAP) Evaluation Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `sap_evaluation_status` SET TAGS ('dbx_value_regex' = 'not required|pending|in progress|completed|non-compliant');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `sap_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Abuse Professional (SAP) Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `sap_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `sap_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Substance Abuse Professional (SAP) Referral Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `sap_referral_required` SET TAGS ('dbx_business_glossary_term' = 'Substance Abuse Professional (SAP) Referral Required');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `specimen_number` SET TAGS ('dbx_business_glossary_term' = 'Specimen ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `specimen_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `specimen_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `specimen_type` SET TAGS ('dbx_value_regex' = 'urine|breath|blood|saliva|hair');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `substances_detected` SET TAGS ('dbx_business_glossary_term' = 'Substances Detected');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `substances_detected` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `substances_detected` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Test Category');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `test_category` SET TAGS ('dbx_value_regex' = 'drug|alcohol|both');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|refused|cancelled|invalid');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `test_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `test_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'pre-employment|random|post-accident|reasonable suspicion|return-to-duty|follow-up');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `testing_vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Testing Vendor Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`drug_alcohol_test` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` SET TAGS ('dbx_subdomain' = 'organization_structure');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Location Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `building_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Building Square Footage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `current_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `external_location_code` SET TAGS ('dbx_business_glossary_term' = 'External Location Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `is_safety_sensitive_site` SET TAGS ('dbx_business_glossary_term' = 'Is Safety-Sensitive Site Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `is_union_location` SET TAGS ('dbx_business_glossary_term' = 'Is Union Location Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `lease_or_owned` SET TAGS ('dbx_business_glossary_term' = 'Lease or Owned Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `lease_or_owned` SET TAGS ('dbx_value_regex' = 'owned|leased|subleased');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|temporarily_closed|decommissioned');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `operates_24_7` SET TAGS ('dbx_business_glossary_term' = 'Operates 24/7 Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `operational_capacity_fte` SET TAGS ('dbx_business_glossary_term' = 'Operational Capacity Full-Time Equivalent (FTE)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `parking_capacity` SET TAGS ('dbx_business_glossary_term' = 'Parking Capacity');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `requires_security_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Security Clearance Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Location Short Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `warehouse_management_system` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`location` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `labor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Contract ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `annual_leave_days` SET TAGS ('dbx_business_glossary_term' = 'Annual Leave Days');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `bonus_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `cba_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Reference Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration in Months');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|renewed');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `hazmat_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Premium Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `health_insurance_coverage` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Coverage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `health_insurance_coverage` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_family|none');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `health_insurance_coverage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `health_insurance_coverage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `jurisdiction_state_province` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State or Province');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `mileage_reimbursement_rate` SET TAGS ('dbx_business_glossary_term' = 'Mileage Reimbursement Rate');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period in Days');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate Multiplier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `per_diem_amount` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `probation_period_months` SET TAGS ('dbx_business_glossary_term' = 'Probation Period in Months');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `redundancy_terms` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Terms');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `renewal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `retirement_contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retirement Contribution Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `severance_pay_weeks` SET TAGS ('dbx_business_glossary_term' = 'Severance Pay in Weeks');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `sick_leave_days` SET TAGS ('dbx_business_glossary_term' = 'Sick Leave Days');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Bonus Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`labor_contract` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` SET TAGS ('dbx_subdomain' = 'scheduling_operations');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` SET TAGS ('dbx_association_edges' = 'workforce.employee,sustainability.sustainability_initiative');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `initiative_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Participation ID');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Participation - Employee Id');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Participation - Sustainability Initiative Id');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `achievement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Achievement Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `contribution_hours` SET TAGS ('dbx_business_glossary_term' = 'Contribution Hours');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `kpi_target_assigned` SET TAGS ('dbx_business_glossary_term' = 'KPI Target Assigned');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `participation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Participation End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `participation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `responsibility_level` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `role_in_initiative` SET TAGS ('dbx_business_glossary_term' = 'Role in Initiative');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `time_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Time Allocation Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`initiative_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` SET TAGS ('dbx_association_edges' = 'workforce.employee,safety.safety_training');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `workforce_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'workforce_training_completion Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Employee Id');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Safety Training Id');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `training_session_id` SET TAGS ('dbx_business_glossary_term' = 'Training Session Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Training Attempt Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Training Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Training Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Training Instructor Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `training_completion_reference` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `training_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`workforce_training_completion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` SET TAGS ('dbx_subdomain' = 'scheduling_operations');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` SET TAGS ('dbx_association_edges' = 'workforce.org_unit,sustainability.sustainability_target');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `target_accountability_id` SET TAGS ('dbx_business_glossary_term' = 'Target Accountability Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Target Accountability - Org Unit Id');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Target Accountability - Sustainability Target Id');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `accountability_level` SET TAGS ('dbx_business_glossary_term' = 'Accountability Level');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Accountability Assignment Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Amount');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Accountability Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accountability Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `escalation_threshold` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `milestone_ownership` SET TAGS ('dbx_business_glossary_term' = 'Milestone Ownership');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `reporting_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Reporting Responsibility');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `responsible_executive` SET TAGS ('dbx_business_glossary_term' = 'Responsible Executive Name');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`target_accountability` ALTER COLUMN `target_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Allocation Percentage');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ALTER COLUMN `fmla_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fmla Case Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ALTER COLUMN `recurrence_fmla_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ALTER COLUMN `condition_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ALTER COLUMN `condition_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ALTER COLUMN `healthcare_provider_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ALTER COLUMN `healthcare_provider_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`fmla_case` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`random_pool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`random_pool` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`random_pool` ALTER COLUMN `random_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Random Pool Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`random_pool` ALTER COLUMN `prior_random_pool_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ALTER COLUMN `reversal_payroll_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ALTER COLUMN `bank_file_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employer_benefits_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employer_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_session` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_session` ALTER COLUMN `training_session_id` SET TAGS ('dbx_business_glossary_term' = 'Training Session Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_session` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_session` ALTER COLUMN `rescheduled_training_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`training_course` ALTER COLUMN `prerequisite_training_course_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`pay_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`pay_group` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`pay_group` ALTER COLUMN `pay_group_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Group Identifier');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`pay_group` ALTER COLUMN `parent_pay_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`workforce`.`pay_group` ALTER COLUMN `minimum_wage_rate` SET TAGS ('dbx_confidential' = 'true');
