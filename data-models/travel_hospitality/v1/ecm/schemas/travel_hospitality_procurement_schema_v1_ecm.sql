-- Schema for Domain: procurement | Business: Travel Hospitality | Version: v1_ecm
-- Generated on: 2026-05-08 03:58:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `travel_hospitality_ecm`.`procurement` COMMENT 'Purchasing and vendor management for property operations including supplier contracts, purchase orders, receiving, spend analytics, and goods receipt. Manages vendor relationships, contract compliance, procurement categories (F&B supplies, housekeeping, FF&E), and cost optimization. Integrates with SAP S/4HANA MM module. Supports both CapEx procurement (PIP projects) and OpEx purchasing.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key for the employee entity. System of record identifier used across all workforce management systems.',
    `manager_employee_id` BIGINT COMMENT 'Employee identifier of the direct manager or supervisor to whom this employee reports. Enables organizational hierarchy analysis and reporting structure visualization. Self-referential foreign key to employee table.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the operational department to which the employee is assigned (e.g., Front Desk, Housekeeping, Food and Beverage, Sales, Engineering). Critical for USALI labor cost allocation and departmental GOP analysis.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Employee occupies an authorized position. Position is the authoritative source for job definitions, titles, codes, and levels. This normalizes job attributes and links workforce planning (position = h',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property where the employee is primarily assigned. Links to the property master data for location-based workforce analytics and USALI labor cost reporting by property.',
    `ada_accommodation_description` STRING COMMENT 'Description of the specific workplace accommodations provided to the employee under ADA or equivalent legislation. Highly sensitive health-related information. Used for accommodation implementation and compliance documentation.',
    `ada_accommodation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee requires workplace accommodations under ADA or equivalent disability legislation. Used for compliance tracking and accommodation management. Confidential but not direct health information.',
    `cost_center_id` BIGINT COMMENT 'Financial cost center to which the employees labor costs are allocated. Used for financial reporting, budgeting, and USALI compliance. Links to the finance cost center master.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the system. Used for data lineage, audit trail, and record lifecycle tracking.',
    `date_of_birth` DATE COMMENT 'Date of birth of the employee. Used for age verification, benefits eligibility, retirement planning, and compliance with labor laws regarding minimum working age.',
    `email_address` STRING COMMENT 'Primary corporate email address assigned to the employee for business communications, system access, and official correspondence. Critical for Oracle HCM Cloud and internal communication systems.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the person to contact in case of employee emergency. Used for employee safety and crisis management. Confidential employee information.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact person. Used for employee safety and crisis management. Confidential employee information.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee (e.g., spouse, parent, sibling, friend). Used for emergency response prioritization and communication.',
    `employee_number` STRING COMMENT 'Human-readable employee number or badge number assigned by the organization. Used for timekeeping, access control, payroll identification, and operational reference. May differ from system employee_id.',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee record indicating whether the employee is actively working, on leave, suspended, terminated, retired, or deceased. Used for workforce planning and payroll processing.. Valid values are `active|on-leave|suspended|terminated|retired|deceased`',
    `employment_type` STRING COMMENT 'Classification of employment arrangement indicating whether the employee is full-time, part-time, seasonal, contract, temporary, or intern. Critical for labor cost analysis, benefits eligibility, and USALI reporting.. Valid values are `full-time|part-time|seasonal|contract|temporary|intern`',
    `first_name` STRING COMMENT 'Legal first name of the employee as recorded in official employment records and payroll systems. Used for identification, communication, and compliance with employment regulations.',
    `food_safety_certification_expiry_date` DATE COMMENT 'Date when the employees food safety certification expires. Null if not applicable to role. Used for proactive recertification scheduling and F&B compliance management.',
    `food_safety_certification_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee holds a current food safety certification (e.g., ServSafe, ISO 22000). Required for Food and Beverage department employees. Used for compliance with health department regulations.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'Full-Time Equivalent percentage representing the employees work commitment relative to a full-time position. 1.0 = 100% full-time, 0.5 = 50% part-time. Critical for workforce capacity planning and labor cost analysis.',
    `hire_date` DATE COMMENT 'Date the employee was originally hired by the organization. Used for calculating tenure, seniority, benefits eligibility, and anniversary recognition. Critical for workforce analytics and retention analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last updated. Used for change tracking, data quality monitoring, and audit compliance.',
    `last_name` STRING COMMENT 'Legal last name (surname/family name) of the employee as recorded in official employment records and payroll systems. Used for identification, communication, and compliance with employment regulations.',
    `middle_name` STRING COMMENT 'Middle name or initial of the employee if applicable. Optional field used for complete legal identification in employment records.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number in USA, National Insurance Number in UK). Used for tax reporting, payroll processing, and employment verification. Highly sensitive PII.',
    `oracle_hcm_employee_code` STRING COMMENT 'External employee identifier from Oracle HCM Cloud system. Used for integration and reconciliation between lakehouse and source HCM system. Critical for maintaining data lineage from system of record.',
    `osha_training_current_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employees required OSHA safety training is current and up-to-date. Used for workplace safety compliance, audit readiness, and training program management.',
    `osha_training_expiry_date` DATE COMMENT 'Date when the employees current OSHA safety training certification expires. Used for proactive training renewal scheduling and compliance management.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to the employees position. Used for salary administration, compensation benchmarking, and pay equity analysis. Business-confidential but not direct PII.',
    `pay_type` STRING COMMENT 'Classification of how the employee is compensated (hourly wages, salaried, commission-based, or contract). Critical for payroll processing, labor cost calculation, and USALI reporting.. Valid values are `hourly|salaried|commission|contract`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee. Used for emergency contact, scheduling notifications, and operational communications. May be mobile or landline.',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in day-to-day operations, which may differ from legal name. Used for name badges, internal communications, and guest-facing interactions.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Standard number of hours the employee is scheduled to work per week based on their employment type. Used for FTE calculation, scheduling, and labor cost forecasting. Typically 40 for full-time, variable for part-time.',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Null for active employees. Used for turnover analysis, exit processing, and historical workforce reporting. Critical for calculating turnover rates and retention metrics.',
    `termination_reason` STRING COMMENT 'Classification of the reason for employment termination. Used for turnover analysis, exit trend identification, and workforce planning. Null for active employees. [ENUM-REF-CANDIDATE: voluntary-resignation|involuntary-termination|retirement|end-of-contract|layoff|death|other — 7 candidates stripped; promote to reference product]',
    `union_code` STRING COMMENT 'Code identifying the specific labor union to which the employee belongs, if applicable. Null for non-union employees. Used for contract administration and labor relations tracking.',
    `union_membership_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee is a member of a labor union. Used for labor relations management, collective bargaining compliance, and union dues processing.',
    `work_authorization_expiry_date` DATE COMMENT 'Date when the employees work authorization expires (if applicable). Null for citizens and permanent residents. Used for proactive renewal tracking and compliance management.',
    `work_authorization_status` STRING COMMENT 'Current status of the employees legal authorization to work in the jurisdiction. Critical for compliance with immigration and employment laws. Used for I-9 compliance tracking in USA and equivalent requirements in other jurisdictions.. Valid values are `citizen|permanent-resident|work-visa|pending-verification|expired|not-authorized`',
    `work_location_type` STRING COMMENT 'Classification of where the employee primarily performs their work. Indicates whether the employee works on-property at a hotel/resort, remotely, in a hybrid arrangement, at corporate office, or across multiple properties.. Valid values are `on-property|remote|hybrid|corporate-office|multi-property`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for all hotel and resort employees across properties. Captures full employment profile including personal details, employment type (full-time, part-time, seasonal, contract), job classification, department assignment, property assignment, hire date, termination date, employment status, OSHA compliance flags, ADA accommodation requirements, work authorization status, and Oracle HCM Cloud employee identifier. SSOT for employee identity across the workforce domain. Supports USALI labor cost reporting by department.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the authorized position within the hotel organizational structure. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit or department to which this position belongs within the property structure.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where this position is authorized.',
    `reports_to_position_id` BIGINT COMMENT 'Reference to the supervisory position to which this position reports in the organizational hierarchy. Enables organizational chart construction.',
    `ada_accommodation_required` BOOLEAN COMMENT 'Indicates whether this position has been identified as requiring reasonable accommodation under ADA compliance guidelines.',
    `budgeted_annual_salary` DECIMAL(18,2) COMMENT 'Planned annual base salary for this position as defined in the labor budget. Used for CPOR (Cost Per Occupied Room) labor cost calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this position record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budgeted salary amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this position was eliminated or frozen. Null for currently active positions. Used for historical workforce planning analysis.',
    `effective_start_date` DATE COMMENT 'Date when this position became active and available for assignment in the organizational structure.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation for this position expressed as a decimal (1.00 = full-time, 0.50 = half-time). Used for headcount planning and labor cost budgeting.',
    `is_budgeted` BOOLEAN COMMENT 'Indicates whether this position is included in the approved annual labor budget and headcount plan.',
    `is_exempt` BOOLEAN COMMENT 'Indicates whether this position is exempt from overtime pay requirements under the Fair Labor Standards Act (FLSA). Used for payroll and labor cost compliance.',
    `is_supervisory` BOOLEAN COMMENT 'Indicates whether this position has direct supervisory or management responsibilities over other employees.',
    `is_union` BOOLEAN COMMENT 'Indicates whether this position is covered by a collective bargaining agreement or union contract.',
    `job_code` STRING COMMENT 'Standardized job classification code linking this position to a job profile with defined competencies, responsibilities, and compensation bands.. Valid values are `^[A-Z0-9]{3,10}$`',
    `last_updated_by` STRING COMMENT 'Username or identifier of the system user who most recently modified this position record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this position record was most recently modified.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for this position as defined in the job profile.. Valid values are `high_school|associate|bachelor|master|doctorate|none`',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of relevant work experience required for this position.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to this position, defining the salary range and benefits eligibility.. Valid values are `^[A-Z0-9]{2,6}$`',
    `physical_requirements` STRING COMMENT 'Description of physical demands and working conditions for this position (e.g., standing for extended periods, lifting up to 50 lbs, exposure to kitchen heat). Used for ADA compliance and OSHA safety planning.',
    `position_code` STRING COMMENT 'Unique alphanumeric code identifying the position within the enterprise position catalog. Used for workforce planning and budgeting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `position_description` STRING COMMENT 'Detailed narrative description of the positions responsibilities, duties, and scope. Used for job postings and talent acquisition.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position. Active = authorized and available for assignment; Frozen = temporarily unavailable; Eliminated = removed from headcount plan; Proposed = pending approval.. Valid values are `active|frozen|eliminated|proposed`',
    `position_type` STRING COMMENT 'Classification of the position based on employment duration and nature. Regular = permanent; Seasonal = recurring high-demand periods; Temporary = fixed-term; Contract = third-party; On-Call = as-needed.. Valid values are `regular|seasonal|temporary|contract|on_call`',
    `required_certifications` STRING COMMENT 'Comma-separated list of mandatory certifications, licenses, or credentials required for this position (e.g., ServSafe Food Handler, CPR/First Aid, Certified Revenue Management Executive). Used for compliance tracking per OSHA and ADA requirements.',
    `shift_eligibility` STRING COMMENT 'Shift pattern or time-of-day eligibility for this position. Used for scheduling and labor management in 24/7 hotel operations.. Valid values are `day|evening|night|rotating|any`',
    `title` STRING COMMENT 'Official job title for the position as defined in the organizational structure (e.g., Front Desk Agent, Executive Chef, Revenue Manager).',
    `union_code` STRING COMMENT 'Code identifying the labor union or collective bargaining unit covering this position, if applicable.. Valid values are `^[A-Z0-9]{2,10}$`',
    `usali_department_code` STRING COMMENT 'Four-digit USALI department classification code for labor cost reporting and financial statement preparation per USALI standards (e.g., 3110 Rooms - Front Office, 4110 Food - Restaurants).. Valid values are `^[0-9]{4}$`',
    `work_location_type` STRING COMMENT 'Primary work location arrangement for this position. On-Property = hotel premises; Remote = off-site; Hybrid = combination; Field = traveling/multi-site.. Valid values are `on_property|remote|hybrid|field`',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this position record.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized positions (headcount plan) within the hotel organizational structure. Defines job titles, job codes, USALI department classifications, pay grade, FTE allocation, required certifications, shift eligibility, and whether the position is budgeted. Links to the organizational unit and property. Supports workforce planning and labor cost budgeting per USALI standards. Sourced from Oracle HCM Cloud Position Management.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Reference to the finance cost center for labor and expense allocation. Enables CPOR (Cost Per Occupied Room) labor component reporting.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy. Enables multi-level organizational structure modeling (e.g., department within division).',
    `property_id` BIGINT COMMENT 'Reference to the property to which this organizational unit belongs. Links department to specific hotel or resort location.',
    `actual_headcount` STRING COMMENT 'Current number of active employees assigned to this organizational unit. Used to track variance against budgeted headcount.',
    `budgeted_headcount` STRING COMMENT 'Planned number of full-time equivalent (FTE) employees allocated to this organizational unit. Used for workforce planning and labor cost budgeting.',
    `certification_type` STRING COMMENT 'Type of certification or license required for employees in this organizational unit (e.g., ServSafe, HVAC License, Lifeguard, ADA Compliance Training). Supports compliance with OSHA and industry regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit was closed or became inactive. Null for currently active units. Used for historical tracking and organizational change management.',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit became active and operational. Used for historical tracking and organizational change management.',
    `email_address` STRING COMMENT 'Primary email address for this organizational unit. Used for internal communication and departmental correspondence. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `hierarchy_level` STRING COMMENT 'Numeric level in the organizational hierarchy. Level 1 is top-level (e.g., corporate), increasing numbers represent deeper nesting (e.g., 2=division, 3=department, 4=team).',
    `hierarchy_path` STRING COMMENT 'Full hierarchical path from root to this unit, typically represented as slash-separated IDs or codes (e.g., /CORP/ROOMS/FRONTDESK). Enables efficient hierarchy queries.',
    `is_guest_facing` BOOLEAN COMMENT 'Indicates whether this organizational unit has direct guest interaction (e.g., Front Desk, Concierge, F&B service) or is back-of-house (e.g., Housekeeping, Engineering). Used for service quality and NPS tracking.',
    `is_revenue_generating` BOOLEAN COMMENT 'Indicates whether this organizational unit directly generates revenue (e.g., Rooms, F&B, Spa) or is a support/overhead department (e.g., Engineering, Admin). Used for GOP and GOPPAR calculations.',
    `is_unionized` BOOLEAN COMMENT 'Indicates whether employees in this organizational unit are represented by a labor union. Affects scheduling rules, overtime policies, and labor cost management.',
    `labor_cost_percentage_target` DECIMAL(18,2) COMMENT 'Target labor cost as percentage of revenue for this organizational unit. Key metric for GOP (Gross Operating Profit) management and USALI labor cost reporting.',
    `labor_productivity_standard` DECIMAL(18,2) COMMENT 'Standard productivity measure for this organizational unit, expressed as units per labor hour (e.g., rooms cleaned per hour, covers served per hour, check-ins per hour). Used for optimal staffing calculations.',
    `location_code` STRING COMMENT 'Physical location code or building identifier where this organizational unit operates (e.g., Main Building, Tower A, Spa Building). Used for facility management and space allocation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified. Used for audit trail and change tracking.',
    `org_unit_code` STRING COMMENT 'Short alphanumeric code identifying the organizational unit. Used in payroll, scheduling, and financial reporting systems. Typically 2-10 characters.. Valid values are `^[A-Z0-9]{2,10}$`',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units purpose, responsibilities, and scope of operations.',
    `org_unit_name` STRING COMMENT 'Full business name of the organizational unit (e.g., Front Desk Operations, Housekeeping, Food and Beverage, Engineering, Sales and Marketing).',
    `org_unit_status` STRING COMMENT 'Current operational status of the organizational unit. Indicates whether the unit is actively staffed and operational.. Valid values are `active|inactive|suspended|planned|closed`',
    `org_unit_type` STRING COMMENT 'Classification of the organizational unit level in the hierarchy. Defines whether this is a division, department, team, cost center, or work group.. Valid values are `division|department|team|cost_center|work_group`',
    `phone_number` STRING COMMENT 'Primary contact phone number for this organizational unit. Used for internal communication and guest inquiries. Organizational contact data classified as confidential.. Valid values are `^+?[1-9]d{1,14}$`',
    `productivity_target_percentage` DECIMAL(18,2) COMMENT 'Target productivity achievement percentage for this organizational unit. Typically 85-100%, representing expected efficiency relative to standard time.',
    `productivity_unit_of_measure` STRING COMMENT 'Unit of measure for labor productivity standard. Defines how productivity is measured for this organizational unit (e.g., rooms per hour for housekeeping, covers per hour for F&B).. Valid values are `rooms_per_hour|covers_per_hour|check_ins_per_hour|setups_per_hour|minutes_per_unit|units_per_shift`',
    `requires_certification` BOOLEAN COMMENT 'Indicates whether employees in this organizational unit require specific certifications or licenses (e.g., food safety for F&B, engineering licenses, lifeguard certification). Used for compliance tracking.',
    `shift_pattern` STRING COMMENT 'Standard shift pattern for this organizational unit. Defines typical scheduling model (e.g., 24x7 for front desk, AM/PM for housekeeping, business hours for sales).. Valid values are `24x7|am_pm_night|am_pm|business_hours|on_call|variable`',
    `standard_time_per_unit` DECIMAL(18,2) COMMENT 'Standard time in minutes required to complete one unit of work (e.g., 30 minutes to clean one room, 15 minutes per banquet setup). Used for scheduling and labor planning.',
    `union_affiliation` STRING COMMENT 'Name of labor union representing employees in this organizational unit, if applicable. Used for labor relations, collective bargaining, and compliance with union agreements.',
    `usali_classification` STRING COMMENT 'USALI department classification for financial reporting. Aligns organizational unit to standard hospitality accounting categories (Rooms, F&B, Spa, Engineering, Sales, Admin). [ENUM-REF-CANDIDATE: rooms|food_and_beverage|spa|golf|recreation|engineering|sales_marketing|admin_general|property_operations|other — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational hierarchy and department structure for hotel and resort operations. Defines divisions, departments, and cost centers aligned to USALI classifications (Rooms, F&B, Spa, Engineering, Sales, Admin) with department codes, cost center references, property assignments, parent-child hierarchy, and department managers. Includes labor productivity standards by department and task type (room cleaning, turndown, check-in, F&B cover, banquet setup) with standard time per unit, units per labor hour, and productivity targets. Enables labor cost allocation, CPOR labor component reporting, optimal staffing calculations relative to occupancy, and workforce planning against budgeted headcount.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` (
    `shift_template_id` BIGINT COMMENT 'Unique identifier for the shift template. Primary key for reusable shift pattern definitions used across hotel departments.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center where labor hours for this shift template are charged. Used for USALI departmental labor cost reporting and CPOR (Cost Per Occupied Room) calculations.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Shift templates are defined for organizational units (departments). The shift_template table has an unlinked department_id (BIGINT) which should reference org_unit for consistency. This links shift de',
    `employee_id` BIGINT COMMENT 'Reference to the user (typically HR manager or department head) who created this shift template. Used for accountability and audit purposes.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where this shift template is defined. Allows property-specific shift patterns within a multi-property portfolio.',
    `break_duration_minutes` STRING COMMENT 'Total break time allocated within the shift in minutes (e.g., 30, 60). Includes meal breaks and rest periods as required by labor regulations.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether employees must hold specific certifications to work this shift (e.g., food handler certification for F&B shifts, CPR certification for pool attendants) (True/False).',
    `consecutive_days_limit` STRING COMMENT 'Maximum number of consecutive days an employee can be scheduled for this shift template before a mandatory rest day, per labor regulations and fatigue management policies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shift template record was first created in the system. Used for audit trail and template lifecycle tracking.',
    `effective_end_date` DATE COMMENT 'Date when this shift template is retired or superseded. Null indicates the template is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this shift template becomes active and available for scheduling. Supports versioning of shift patterns over time.',
    `holiday_shift_flag` BOOLEAN COMMENT 'Indicates whether this shift template is designated for holiday scheduling, which typically carries premium pay rates (True/False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this shift template record was last updated. Used for audit trail and change tracking.',
    `maximum_staffing_level` STRING COMMENT 'Maximum number of employees that can be scheduled for this shift pattern based on operational capacity and labor budget constraints.',
    `meal_allowance_eligible_flag` BOOLEAN COMMENT 'Indicates whether employees working this shift are eligible for complimentary or subsidized meals as part of compensation (True/False).',
    `minimum_staffing_level` STRING COMMENT 'Minimum number of employees required to work this shift pattern to meet operational standards and guest service levels (e.g., 2 front desk agents, 5 housekeepers).',
    `notes` STRING COMMENT 'Free-text field for additional scheduling instructions, special requirements, or operational notes related to this shift template (e.g., Requires bilingual staff, Peak check-in period).',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether hours worked on this shift template are eligible for overtime compensation under labor regulations and hotel policy (True/False).',
    `paid_break_minutes` STRING COMMENT 'Portion of break time that is compensated (e.g., 15-minute paid rest breaks). Used to calculate net paid hours.',
    `paid_hours` DECIMAL(18,2) COMMENT 'Net paid hours for the shift, excluding unpaid breaks (e.g., 7.50 for an 8-hour shift with 30-minute unpaid lunch). Used for payroll and labor cost calculations.',
    `rest_hours_required` STRING COMMENT 'Minimum number of hours required between the end of this shift and the start of the next shift for the same employee, per labor regulations.',
    `rotation_pattern` STRING COMMENT 'Describes how this shift template fits into a rotation schedule (e.g., 5-on-2-off, 4-on-3-off, rotating weekends). Used for fair scheduling and work-life balance.',
    `seasonal_applicability` STRING COMMENT 'Defines when this shift template is active based on hotel seasonality patterns. Year-round templates apply continuously; seasonal templates apply during high/low demand periods.. Valid values are `year_round|peak_season|off_season|summer|winter`',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional hourly pay rate or percentage premium applied to this shift (e.g., night shift differential, weekend premium). Used for labor cost calculations.',
    `shift_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the shift in hours, including break time (e.g., 8.00, 8.50, 12.00). Used for labor cost calculations and CPOR (Cost Per Occupied Room) reporting.',
    `shift_end_time` TIMESTAMP COMMENT 'Standard end time for the shift in 24-hour HH:mm format (e.g., 15:00, 23:00, 07:00). Represents the clock-out time. May cross midnight for night shifts.',
    `shift_start_time` TIMESTAMP COMMENT 'Standard start time for the shift in 24-hour HH:mm format (e.g., 07:00, 15:00, 23:00). Represents the clock-in time.',
    `shift_template_status` STRING COMMENT 'Current lifecycle status of the shift template. Active templates are available for scheduling; Draft templates are under review; Inactive/Archived templates are no longer used.. Valid values are `active|inactive|draft|archived`',
    `shift_type` STRING COMMENT 'Classification of the shift pattern by time of day or work arrangement. Morning (AM), Afternoon (PM), Evening, Night (overnight), Split (discontinuous hours), On-Call (standby).. Valid values are `morning|afternoon|evening|night|split|on_call`',
    `skill_requirement_level` STRING COMMENT 'Minimum skill or experience level required for employees assigned to this shift template (e.g., entry-level housekeepers vs. expert front desk supervisors).. Valid values are `entry|intermediate|advanced|expert`',
    `template_code` STRING COMMENT 'Short alphanumeric code for the shift template used in scheduling systems and reports (e.g., FD-AM, HK-PM, FB-SPLIT).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `template_name` STRING COMMENT 'Business-friendly name for the shift template (e.g., Front Desk Morning, Housekeeping Evening, F&B Split Shift).',
    `transportation_allowance_eligible_flag` BOOLEAN COMMENT 'Indicates whether employees working this shift (especially late-night or early-morning shifts) are eligible for transportation reimbursement or shuttle service (True/False).',
    `uniform_code` STRING COMMENT 'Code identifying the required uniform or dress code for this shift template (e.g., FD-FORMAL, HK-STANDARD, FB-BANQUET). Links to uniform inventory and standards.',
    `weekend_shift_flag` BOOLEAN COMMENT 'Indicates whether this shift template is designated for weekend scheduling, which may carry premium pay or differential rates (True/False).',
    CONSTRAINT pk_shift_template PRIMARY KEY(`shift_template_id`)
) COMMENT 'Reusable shift pattern definitions used as building blocks for employee scheduling across hotel departments. Captures shift name, start/end times, duration, break rules, shift type (morning, afternoon, night, split, on-call), applicable department, minimum staffing level, overtime eligibility, and seasonal applicability. Referenced by the schedule product when constructing weekly rosters.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique identifier for the published work schedule. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Reference to the operational department (housekeeping, front desk, food and beverage, etc.) covered by this schedule.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Schedules are built for authorized positions (headcount plan). This links workforce planning (position defines budgeted FTE and salary) to operational scheduling (schedule defines actual shifts). Enab',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property for which this schedule is published.',
    `employee_id` BIGINT COMMENT 'Reference to the senior manager or director who approved this schedule for finalization and payroll processing.',
    `schedule_employee_id` BIGINT COMMENT 'Reference to the manager or scheduler who initially created this schedule.',
    `schedule_published_by_user_employee_id` BIGINT COMMENT 'Reference to the manager who published this schedule, making it visible to employees.',
    `shift_template_id` BIGINT COMMENT 'Reference to the reusable shift template used as the basis for this schedule. Shift templates define standard shift patterns (e.g., morning, evening, overnight) with default start/end times and break rules.',
    `actual_labor_cost` DECIMAL(18,2) COMMENT 'Actual total labor cost incurred during this schedule period, including wages, overtime premiums, and shift differentials. Sourced from payroll system for variance analysis.',
    `compliance_notes` STRING COMMENT 'Notes related to OSHA hours-of-service compliance, ADA accommodation requests, or other regulatory considerations for this schedule.',
    `cpor_labor` DECIMAL(18,2) COMMENT 'Estimated labor cost per occupied room for this schedule period, calculated as estimated_labor_cost divided by forecasted occupied rooms. Used for labor efficiency benchmarking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this schedule (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Forecasted total labor cost for this schedule period, calculated from scheduled hours and average wage rates. Used for budgeting and GOPPAR (Gross Operating Profit Per Available Room) planning.',
    `finalized_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule was locked for payroll processing. After finalization, no further changes are permitted without creating a schedule adjustment record.',
    `forecast_adr` DECIMAL(18,2) COMMENT 'Forecasted Average Daily Rate for this schedule period, used to estimate revenue and align labor investment with revenue expectations.',
    `forecast_occupancy_rate` DECIMAL(18,2) COMMENT 'Forecasted hotel occupancy rate (percentage) for this schedule period, used to align labor scheduling with anticipated guest volume. Sourced from Revenue Management System (RMS).',
    `forecast_revpar` DECIMAL(18,2) COMMENT 'Forecasted Revenue Per Available Room for this schedule period, calculated as forecast_occupancy_rate multiplied by forecast_adr. Used for labor cost as percentage of revenue planning.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this schedule is currently active. True for current and future schedules; false for archived or superseded schedules.',
    `is_overtime_approved` BOOLEAN COMMENT 'Indicates whether overtime hours are pre-approved for this schedule period. True if overtime is authorized; false if all hours must remain within standard limits.',
    `labor_cost_percentage` DECIMAL(18,2) COMMENT 'Estimated labor cost as a percentage of forecasted revenue for this schedule period. Key metric for USALI labor cost reporting and GOP analysis.',
    `labor_variance_hours` DECIMAL(18,2) COMMENT 'Difference between total_actual_hours and total_scheduled_hours. Positive values indicate overtime or unplanned coverage; negative values indicate understaffing or no-shows.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to this schedule record.',
    `notes` STRING COMMENT 'Free-text notes or instructions from the manager regarding this schedule (e.g., High occupancy expected due to conference, Reduced staffing for low season).',
    `period_end_date` DATE COMMENT 'Last calendar date covered by this schedule period.',
    `period_start_date` DATE COMMENT 'First calendar date covered by this schedule period.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule was published and made visible to employees.',
    `schedule_name` STRING COMMENT 'Descriptive name for the schedule (e.g., Front Desk Week 15 2024, Housekeeping Spring Break Schedule).',
    `schedule_number` STRING COMMENT 'Human-readable business identifier for the schedule, typically formatted as property-department-period (e.g., HTL001-HSKP-2024W15).',
    `schedule_status` STRING COMMENT 'Current lifecycle state of the schedule. Draft: under construction by manager. Published: visible to employees. Finalized: locked for payroll processing. Archived: historical record.. Valid values are `draft|published|finalized|archived`',
    `schedule_type` STRING COMMENT 'Classification of the schedule based on operational context: regular (standard weekly/biweekly), seasonal (high/low season adjustments), event (MICE or special events), emergency (unplanned coverage), training (learning and development sessions).. Valid values are `regular|seasonal|event|emergency|training`',
    `total_actual_hours` DECIMAL(18,2) COMMENT 'Sum of actual hours worked by all employees during this schedule period, captured from time and attendance systems. Used for labor variance reporting (actual vs. scheduled).',
    `total_scheduled_fte` DECIMAL(18,2) COMMENT 'Full-time equivalent headcount for this schedule period, calculated as total_scheduled_hours divided by standard full-time hours (typically 40 hours per week). Used for labor productivity analysis and GOP (Gross Operating Profit) reporting.',
    `total_scheduled_hours` DECIMAL(18,2) COMMENT 'Sum of all scheduled shift hours across all employees in this schedule. Used for labor cost forecasting and CPOR (Cost Per Occupied Room) labor planning.',
    `version_number` STRING COMMENT 'Version number of this schedule. Incremented each time the schedule is revised before finalization. Supports schedule change tracking and audit trail.',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Published work schedules and individual shift assignments for hotel employees. Covers schedule period, property, department, total scheduled hours/FTE, schedule status (draft, published, finalized), and individual shift assignments linking employees to specific shifts with assigned date, start/end time, role, and status (scheduled, confirmed, swapped, called-out, no-show). Tracks actual vs. scheduled hours for labor variance reporting. Supports labor cost forecasting, CPOR labor planning, and OSHA hours-of-service compliance monitoring. References shift_template for reusable shift definitions.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique identifier for the time entry record. Primary key for the time entry entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual time entries drive real-time labor cost allocation to departments for daily flash reports, labor cost control dashboards, and manager variance reporting - core operational requirement for h',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Time entries are recorded against organizational units for labor cost allocation and USALI reporting. The time_entry table has an unlinked department_id (BIGINT) which should reference org_unit. This ',
    `payroll_period_id` BIGINT COMMENT 'Identifier of the payroll period to which this time entry is assigned. Used to group time entries for payroll processing in SAP S/4HANA HCM.',
    `payroll_run_id` BIGINT COMMENT 'Identifier of the payroll run in which this time entry was processed. Nullable if not yet processed.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded this time entry. Links to the employee master record in Oracle HCM Cloud or SAP S/4HANA HCM.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the employee worked during this time entry. Used for labor cost allocation by property.',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.schedule. Business justification: Time entries represent actual hours worked against published schedules. This FK links actual time to planned schedules, enabling critical labor variance analysis (schedule.labor_variance_hours = sched',
    `shift_template_id` BIGINT COMMENT 'Foreign key linking to workforce.shift_template. Business justification: Time entries are worked on specific shift templates (AM, PM, overnight, etc.). This FK links actual time to shift definitions, enabling shift differential calculation (shift_template.shift_differentia',
    `tertiary_time_edited_by_employee_id` BIGINT COMMENT 'Identifier of the user who edited or adjusted the time entry. Nullable if never edited.',
    `work_order_id` BIGINT COMMENT 'Identifier of a specific work order or task assignment associated with this time entry. Used for project-based labor tracking and maintenance labor allocation.',
    `approval_status` STRING COMMENT 'Current approval status of the time entry in the workflow. Time entries must be approved before being sent to payroll processing.. Valid values are `pending|approved|rejected|submitted|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry was approved. Nullable if not yet approved.',
    `break_duration_minutes` STRING COMMENT 'Total duration of unpaid breaks taken during the shift, measured in minutes. Deducted from total hours worked for payroll calculation.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'The precise date and time when the employee clocked in or started their shift. Captured from time clock, mobile app, or manager entry.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'The precise date and time when the employee clocked out or ended their shift. Nullable for open shifts not yet completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was first created in the system. Used for audit trail and data lineage.',
    `device_identifier` STRING COMMENT 'Unique identifier of the device or time clock used to record the time entry. Used for audit trail and fraud prevention.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of hours worked that qualify for double-time pay, typically for work on holidays or beyond a certain daily threshold in some jurisdictions.',
    `edited_flag` BOOLEAN COMMENT 'Indicates whether the time entry was manually edited or adjusted after initial capture. True if edited, False if original entry.',
    `edited_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry was last edited. Nullable if never edited.',
    `entry_date` DATE COMMENT 'The calendar date on which the work was performed. Used for daily labor reporting and payroll period assignment.',
    `entry_source` STRING COMMENT 'The system or method through which the time entry was captured. Supports audit trail and data quality analysis. [ENUM-REF-CANDIDATE: time_clock|mobile_app|web_portal|manager_entry|biometric_scanner|telephony|kiosk — 7 candidates stripped; promote to reference product]',
    `entry_type` STRING COMMENT 'Classification of the time entry by work type or absence type. Used for labor cost categorization and compliance reporting. [ENUM-REF-CANDIDATE: regular_shift|overtime|holiday|sick_leave|vacation|training|meeting|on_call — 8 candidates stripped; promote to reference product]',
    `exception_code` STRING COMMENT 'Code indicating any time entry exception or anomaly (e.g., missed punch, late clock-in, early departure, unauthorized overtime). Used for compliance monitoring and manager review.',
    `exception_notes` STRING COMMENT 'Free-text notes explaining any exception or adjustment to the time entry. Entered by manager or HR for audit trail.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate where the clock-in or clock-out occurred, captured from mobile app entries. Used for location verification and compliance with remote work policies.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate where the clock-in or clock-out occurred, captured from mobile app entries. Used for location verification and compliance with remote work policies.',
    `job_code` BIGINT COMMENT 'Identifier of the job code or position classification for this time entry. Supports labor cost analysis by role (front desk agent, housekeeper, chef, etc.).',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost for this time entry, calculated as hours worked multiplied by applicable pay rates including overtime premiums. Used for USALI labor cost reporting and CPOR calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was last modified. Used for audit trail and change tracking.',
    `location_code` STRING COMMENT 'Code identifying the specific work location or outlet within the property where the employee worked (e.g., front desk, restaurant, spa, housekeeping floor). Used for detailed labor allocation.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours worked beyond the regular hours threshold that qualify for overtime pay under FLSA or local labor law. Typically paid at 1.5x or 2x regular rate.',
    `paid_break_duration_minutes` STRING COMMENT 'Total duration of paid breaks or rest periods during the shift, measured in minutes. Included in total hours worked for payroll calculation.',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether this time entry has been processed in a payroll run. True if processed, False if pending.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of hours worked at the regular pay rate, typically up to 40 hours per week or 8 hours per day depending on jurisdiction. Used for payroll calculation.',
    `shift_differential_code` STRING COMMENT 'Code indicating any shift differential pay applicable to this time entry (e.g., night shift, weekend shift). Used for premium pay calculation.',
    `tips_reported_amount` DECIMAL(18,2) COMMENT 'Total amount of tips reported by the employee for this time entry. Relevant for F&B and guest-facing roles. Used for payroll tax calculation and FLSA tip credit compliance.',
    `total_hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours worked during this time entry, calculated as the difference between clock-out and clock-in minus break duration. Used for payroll processing and labor hour reporting per USALI standards.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Raw time and attendance records capturing actual clock-in and clock-out events for hotel employees. Includes entry date, clock-in timestamp, clock-out timestamp, total hours worked, overtime hours, break duration, entry source (time clock, mobile, manager entry), approval status, and payroll period reference. Feeds payroll processing in SAP S/4HANA HCM. Supports FLSA overtime compliance and USALI labor hour reporting.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique identifier for the payroll processing cycle. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payroll runs must allocate labor costs to cost centers for USALI departmental P&L reporting, labor cost variance analysis, and monthly financial close - fundamental to hotel financial operations and r',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this payroll run for processing and payment.',
    `ownership_entity_id` BIGINT COMMENT 'Reference to the legal entity responsible for payroll obligations and tax reporting.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property or resort for which this payroll run is executed.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run was approved for processing.',
    `calculated_timestamp` TIMESTAMP COMMENT 'Date and time when payroll calculations were completed for this run.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this payroll run.. Valid values are `^[A-Z]{3}$`',
    `employee_count` STRING COMMENT 'Total number of employees included in this payroll run.',
    `gl_posting_date` DATE COMMENT 'Date on which payroll expenses and liabilities were posted to the general ledger.',
    `gl_posting_status` STRING COMMENT 'Indicates whether payroll entries have been posted to the general ledger.. Valid values are `not_posted|posted|reversed`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about this payroll run, including special circumstances, corrections, or processing exceptions.',
    `oracle_payroll_run_code` STRING COMMENT 'External reference identifier from Oracle HCM Cloud payroll system for reconciliation and audit trail.',
    `paid_timestamp` TIMESTAMP COMMENT 'Date and time when employee payments were disbursed for this payroll run.',
    `pay_date` DATE COMMENT 'Date on which employees receive payment for this payroll run.',
    `pay_frequency` STRING COMMENT 'Frequency at which employees are paid in this payroll run.. Valid values are `weekly|bi-weekly|semi-monthly|monthly`',
    `payroll_period_end_date` DATE COMMENT 'Last day of the payroll period covered by this run.',
    `payroll_period_start_date` DATE COMMENT 'First day of the payroll period covered by this run.',
    `payroll_run_number` STRING COMMENT 'Business identifier for the payroll run, typically formatted as YYYY-MM-PP where PP is the pay period sequence.',
    `payroll_run_status` STRING COMMENT 'Current lifecycle status of the payroll run indicating its processing stage. [ENUM-REF-CANDIDATE: draft|in_progress|calculated|approved|posted|paid|cancelled — 7 candidates stripped; promote to reference product]',
    `payroll_run_type` STRING COMMENT 'Classification of the payroll run indicating whether it is a regular scheduled run, off-cycle payment, bonus distribution, correction, or final payment.. Valid values are `regular|off-cycle|bonus|correction|final`',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when payroll entries were posted to the general ledger.',
    `sap_payroll_run_code` STRING COMMENT 'External reference identifier from SAP S/4HANA HCM payroll system for reconciliation and audit trail.',
    `total_bonus_pay` DECIMAL(18,2) COMMENT 'Sum of discretionary and non-discretionary bonuses paid to employees in this payroll run.',
    `total_commission_pay` DECIMAL(18,2) COMMENT 'Sum of commission earnings for sales and revenue-generating roles (e.g., event sales, group sales) in this payroll run.',
    `total_employer_taxes` DECIMAL(18,2) COMMENT 'Sum of employer-paid payroll taxes (employer FICA, FUTA, SUTA) for this payroll run.',
    `total_federal_tax` DECIMAL(18,2) COMMENT 'Sum of federal income tax withheld from all employees in this payroll run.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'Sum of all gross earnings for all employees in this payroll run before any deductions.',
    `total_local_tax` DECIMAL(18,2) COMMENT 'Sum of local or municipal income tax withheld from all employees in this payroll run.',
    `total_medicare_tax` DECIMAL(18,2) COMMENT 'Sum of Medicare tax withheld from all employees in this payroll run, including additional Medicare tax for high earners.',
    `total_net_pay` DECIMAL(18,2) COMMENT 'Sum of net pay (take-home pay) for all employees in this payroll run after all taxes and deductions.',
    `total_overtime_pay` DECIMAL(18,2) COMMENT 'Sum of overtime earnings for all employees in this payroll run, typically at 1.5x or 2x regular rate.',
    `total_post_tax_deductions` DECIMAL(18,2) COMMENT 'Sum of all post-tax deductions (garnishments, union dues, Roth 401k) for all employees in this payroll run.',
    `total_pre_tax_deductions` DECIMAL(18,2) COMMENT 'Sum of all pre-tax deductions (401k, health insurance premiums, FSA contributions) for all employees in this payroll run.',
    `total_regular_pay` DECIMAL(18,2) COMMENT 'Sum of regular hourly or salaried earnings for all employees in this payroll run.',
    `total_service_charge` DECIMAL(18,2) COMMENT 'Sum of mandatory service charges distributed to employees in this payroll run, common in banquet and group events.',
    `total_social_security_tax` DECIMAL(18,2) COMMENT 'Sum of Social Security (OASDI) tax withheld from all employees in this payroll run.',
    `total_state_tax` DECIMAL(18,2) COMMENT 'Sum of state income tax withheld from all employees in this payroll run.',
    `total_tax_withholding` DECIMAL(18,2) COMMENT 'Sum of all federal, state, and local income tax withholdings for all employees in this payroll run.',
    `total_tip_allocation` DECIMAL(18,2) COMMENT 'Sum of tip income allocated to tipped employees (servers, bartenders, bellhops) in this payroll run.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Payroll processing cycles and individual earnings/deduction line items for hotel employees. Captures payroll period, pay frequency, property/legal entity, run status, totals (gross, net, taxes, deductions), and SAP S/4HANA payroll reference. Includes line-item detail: pay component type (regular, overtime, tip allocation, service charge, bonus, commission, deduction, tax withholding), hours, rate, amount, USALI department allocation, and GL account code. Supports USALI labor cost reporting, CPOR labor component breakdown, SOX payroll controls, and SAP S/4HANA GL posting.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Benefit costs must be allocated to cost centers for full-burden labor costing in USALI statements, departmental P&L analysis, and accurate calculation of total compensation costs per department - requ',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property or corporate entity offering this benefit plan. Links to property master data for multi-property benefit plan administration.',
    `aca_compliant_flag` BOOLEAN COMMENT 'Indicates whether the benefit plan meets ACA minimum essential coverage and affordability requirements. True if compliant, False otherwise.',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or provider administering the benefit plan (e.g., Blue Cross, Aetna, Fidelity).',
    `carrier_policy_number` STRING COMMENT 'Policy or contract number assigned by the insurance carrier for this benefit plan.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether the benefit plan is eligible for COBRA continuation coverage after employment termination. True if eligible, False otherwise.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of covered costs the employee pays after meeting the deductible (e.g., 20% coinsurance means employee pays 20%, carrier pays 80%).',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are deducted or paid (e.g., biweekly, monthly).. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee pays for specific services (e.g., $25 copay for doctor visit, $10 copay for generic prescription).',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Total coverage or benefit amount provided by the plan (e.g., $50,000 life insurance coverage, $500,000 disability coverage).',
    `coverage_tier` STRING COMMENT 'Level of coverage provided by the plan, indicating who is covered (employee only, employee plus dependents, family).. Valid values are `employee_only|employee_spouse|employee_children|employee_family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit plan record was first created in the system. Audit trail for plan setup.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contribution amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the employee must pay before the insurance carrier begins coverage. Applicable to health, dental, and vision plans.',
    `dependent_coverage_allowed_flag` BOOLEAN COMMENT 'Indicates whether the benefit plan allows coverage for employee dependents (spouse, children). True if dependents can be covered, False otherwise.',
    `effective_end_date` DATE COMMENT 'Date when the benefit plan expires or is terminated. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the benefit plan becomes active and available for employee enrollment. Plan year start date.',
    `eligibility_criteria` STRING COMMENT 'Description of the eligibility requirements for employees to enroll in this benefit plan (e.g., full-time status, 90-day waiting period, job grade).',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employee contributes per pay period toward the benefit plan premium or cost.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employer contributes per pay period toward the benefit plan premium or cost. Used for total compensation cost tracking per USALI.',
    `enrollment_period_end_date` DATE COMMENT 'End date of the open enrollment period. Employees must complete enrollment actions by this date.',
    `enrollment_period_start_date` DATE COMMENT 'Start date of the open enrollment period when employees can elect or change their benefit plan selections.',
    `life_event_enrollment_allowed_flag` BOOLEAN COMMENT 'Indicates whether employees can enroll or make changes to this benefit plan outside of open enrollment due to qualifying life events (marriage, birth, adoption). True if allowed, False otherwise.',
    `maximum_dependent_age` STRING COMMENT 'Maximum age at which a dependent child can remain covered under the benefit plan (e.g., 26 per ACA for health plans).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit plan record was last modified. Audit trail for plan changes and updates.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount the employee will pay out-of-pocket for covered services in a plan year. After this limit, the carrier pays 100%.',
    `plan_code` STRING COMMENT 'Externally-known unique code for the benefit plan used across systems and communications. Business identifier for the plan.. Valid values are `^[A-Z0-9]{4,20}$`',
    `plan_description` STRING COMMENT 'Detailed description of the benefit plan including coverage details, exclusions, and key features provided to employees.',
    `plan_document_url` STRING COMMENT 'URL or file path to the official plan document, summary plan description (SPD), or benefits guide for employee reference.',
    `plan_name` STRING COMMENT 'Full descriptive name of the benefit plan as displayed to employees and in HR systems.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan. Indicates whether the plan is available for enrollment and active for coverage.. Valid values are `active|inactive|pending|suspended|terminated`',
    `plan_type` STRING COMMENT 'Category of benefit plan. Classifies the plan into major benefit types offered to hospitality employees. [ENUM-REF-CANDIDATE: health|dental|vision|life_insurance|disability|retirement_401k|employee_assistance_program|hotel_rate_discount|flexible_spending_account|health_savings_account — 10 candidates stripped; promote to reference product]',
    `plan_year` STRING COMMENT 'Calendar year or fiscal year for which the benefit plan is active (e.g., 2024).',
    `waiting_period_days` STRING COMMENT 'Number of days an employee must wait after hire date before becoming eligible to enroll in the benefit plan.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master catalog of employee benefit plans and individual enrollment records across hotel properties. Covers plan definitions (health, dental, vision, 401k, life insurance, EAP, hotel rate discounts) with carrier, coverage tiers, contribution rates, eligibility criteria, and enrollment periods. Includes employee enrollment records: elected plans, coverage dates, contribution amounts, dependent count, enrollment source (open enrollment, life event, new hire), and enrollment status. Supports ACA compliance reporting, total compensation cost tracking per USALI, and Oracle HCM Cloud Benefits integration.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` (
    `job_requisition_id` BIGINT COMMENT 'Unique identifier for the job requisition record. Primary key for the talent acquisition lifecycle tracking.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or functional area requesting the hire (e.g., Front Desk, Housekeeping, Food and Beverage (F&B), Sales, Revenue Management).',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Job requisitions are opened to fill authorized positions (headcount plan). This links talent acquisition to workforce planning. The job_requisition table has position_title and job_code (STRING) which',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager responsible for the position and final candidate selection.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property or resort location where the position will be based.',
    `tertiary_job_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who approved the requisition (typically department head, general manager, or HR director depending on approval hierarchy).',
    `approval_date` DATE COMMENT 'Date when the requisition received final approval and was authorized to proceed to posting and recruiting.',
    `background_check_required_flag` BOOLEAN COMMENT 'Indicates whether a background check is required for this position. Typically true for all guest-facing roles and positions with financial or security responsibilities.',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary range (e.g., USD, EUR, GBP). Supports multi-country property operations.. Valid values are `^[A-Z]{3}$`',
    `compensation_frequency` STRING COMMENT 'Pay frequency for the position: hourly (most operational roles), annual (salaried management), monthly, or weekly.. Valid values are `hourly|annual|monthly|weekly`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition record was first created in the system. Audit trail for requisition lifecycle tracking.',
    `drug_screening_required_flag` BOOLEAN COMMENT 'Indicates whether pre-employment drug screening is required. Common for safety-sensitive positions and jurisdictions where permitted by law.',
    `eeo_job_category` STRING COMMENT 'Equal Employment Opportunity Commission job category for regulatory reporting (e.g., Executive/Senior Level Officials and Managers, First/Mid-Level Officials and Managers, Professionals, Service Workers). Required for EEO-1 compliance reporting.',
    `employment_type` STRING COMMENT 'Nature of the employment relationship: full-time, part-time, seasonal (high occupancy periods), temporary, contract, or on-call (banquet/event staff).. Valid values are `full_time|part_time|seasonal|temporary|contract|on_call`',
    `external_posting_flag` BOOLEAN COMMENT 'Indicates whether the requisition is posted to external job boards, career sites, and recruiting channels.',
    `flsa_classification` STRING COMMENT 'Fair Labor Standards Act classification determining overtime eligibility: exempt (salaried, not eligible for overtime) or non-exempt (hourly, eligible for overtime). Critical for labor cost management and compliance.. Valid values are `exempt|non_exempt`',
    `headcount_requested` STRING COMMENT 'Number of positions to be filled under this requisition. Typically 1 for individual roles, may be higher for bulk hiring (e.g., seasonal housekeeping staff).',
    `internal_posting_flag` BOOLEAN COMMENT 'Indicates whether the requisition is posted internally for current employees before external candidates. Supports internal mobility and career development programs.',
    `job_description` STRING COMMENT 'Detailed description of the role, responsibilities, qualifications, and expectations. Used for job postings and candidate communication.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition record was last updated. Tracks changes to status, details, or candidate pipeline throughout the hiring process.',
    `minimum_qualifications` STRING COMMENT 'Required education, certifications, experience, and skills for the position (e.g., high school diploma, hospitality degree, PMS system experience, food handler certification).',
    `posting_end_date` DATE COMMENT 'Date when the job posting will close and no longer accept new applications. May be extended if position remains unfilled.',
    `posting_location` STRING COMMENT 'Geographic location description for the job posting (city, state, country). Used for candidate search and location-based job board distribution.',
    `posting_start_date` DATE COMMENT 'Date when the job requisition was or will be posted to internal and external job boards and career sites.',
    `preferred_qualifications` STRING COMMENT 'Desired but not mandatory qualifications that would make a candidate more competitive (e.g., bilingual, luxury hotel experience, revenue management certification).',
    `priority_level` STRING COMMENT 'Urgency of the hiring need. Critical priority typically assigned to key operational roles (e.g., Executive Chef, Director of Revenue Management) or roles impacting guest experience during peak season.. Valid values are `low|medium|high|critical`',
    `requisition_closed_date` DATE COMMENT 'Date when the requisition was closed (filled, cancelled, or otherwise completed). Used to calculate time-to-fill metrics.',
    `requisition_justification` STRING COMMENT 'Business rationale for the hiring request, including operational need, budget impact, and strategic alignment. Used for approval workflow and headcount planning.',
    `requisition_number` STRING COMMENT 'Business identifier for the job requisition, typically system-generated and externally visible to hiring managers and recruiters.. Valid values are `^REQ-[0-9]{6,10}$`',
    `requisition_opened_date` DATE COMMENT 'Date when the requisition was approved and moved to open status, marking the start of active recruiting.',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the requisition: draft (being prepared), pending approval (awaiting manager/HR sign-off), approved (ready to post), open (actively recruiting), on hold (paused), filled (offer accepted), cancelled (no longer needed), closed (completed). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|open|on_hold|filled|cancelled|closed — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the hiring need: new position (headcount growth), replacement (turnover), backfill (internal promotion), seasonal (peak demand), temporary (project-based), or contract (contingent labor).. Valid values are `new_position|replacement|backfill|seasonal|temporary|contract`',
    `salary_range_max` DECIMAL(18,2) COMMENT 'Maximum annual salary or hourly rate for the position, aligned with compensation bands and market benchmarks.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'Minimum annual salary or hourly rate for the position, aligned with compensation bands and market benchmarks.',
    `shift_type` STRING COMMENT 'Primary work shift for the position: day (morning/afternoon), evening, night (overnight), rotating (varies), or flexible. Critical for 24/7 hotel operations.. Valid values are `day|evening|night|rotating|flexible`',
    `target_start_date` DATE COMMENT 'Desired date for the new hire to begin employment. Critical for seasonal hiring and operational planning.',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from requisition opened date to requisition closed date. Key talent acquisition performance metric tracked against industry benchmarks.',
    `travel_requirement` STRING COMMENT 'Expected travel frequency for the role: none (property-based), occasional (less than 25%), frequent (25-50%), extensive (over 50%). Relevant for regional managers, corporate roles, and multi-property positions.. Valid values are `none|occasional|frequent|extensive`',
    `work_authorization_required` STRING COMMENT 'Description of work authorization requirements for the position (e.g., must be authorized to work in the United States, visa sponsorship available, etc.). Critical for international hiring and compliance.',
    `work_location_type` STRING COMMENT 'Physical work arrangement: on-site (property-based, typical for most hospitality roles), hybrid (mix of on-site and remote for corporate roles), or remote (fully remote for select positions).. Valid values are `on_site|hybrid|remote`',
    CONSTRAINT pk_job_requisition PRIMARY KEY(`job_requisition_id`)
) COMMENT 'Talent acquisition lifecycle management covering job requisitions, candidate/applicant tracking, and formal employment offers across hotel properties. Captures requisition details (position, department, property, type, headcount, status, time-to-fill), applicant records (source, pipeline stage, work authorization, EEOC data), and offer details (salary/rate, start date, offer status, background check). Supports the full hiring pipeline from requisition approval through offer acceptance and employee onboarding. Sourced from Oracle HCM Cloud Talent Acquisition and Recruiting modules.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key for the performance review entity.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Performance reviews occur within organizational unit context for departmental performance analytics and manager accountability. The performance_review table has department_code (STRING) which should b',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Performance reviews are conducted for employees in specific positions. Position provides the authoritative job definition context for performance standards and competency frameworks. The performance_r',
    `employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed. Links to the employee master record in the workforce domain.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the employee conducting the performance review, typically the direct manager or supervisor.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the performance review record was first created in the system.',
    `development_areas_summary` STRING COMMENT 'Narrative summary of areas where the employee needs improvement or further development.',
    `development_plan_notes` STRING COMMENT 'Detailed notes on the employee development plan, including recommended training, mentoring, or stretch assignments to support career growth.',
    `employee_acknowledgement_date` DATE COMMENT 'The date when the employee acknowledged receipt and review of their performance evaluation.',
    `employee_comments` STRING COMMENT 'Comments provided by the employee in response to the performance review, including self-assessment and feedback on the review process.',
    `goals_met_count` STRING COMMENT 'The number of performance goals or objectives that the employee successfully met during the review period.',
    `goals_total_count` STRING COMMENT 'The total number of performance goals or objectives assigned to the employee for the review period.',
    `guest_service_rating` STRING COMMENT 'Competency rating for guest service excellence, a critical competency in hospitality operations. Assesses employees ability to deliver exceptional guest experiences.. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the performance review record was last updated or modified.',
    `leadership_rating` STRING COMMENT 'Competency rating for leadership and people management skills. Applicable to supervisory and management roles; marked not-applicable for individual contributors.. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding|not-applicable`',
    `merit_increase_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee is eligible for a merit-based salary increase based on this performance review outcome.',
    `overall_rating` STRING COMMENT 'The overall performance rating assigned to the employee for the review period. Used for merit increase decisions and succession planning.. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall performance rating, typically on a scale (e.g., 1.00 to 5.00). Enables quantitative analysis and compensation modeling.',
    `performance_improvement_plan_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee has been placed on a formal Performance Improvement Plan due to unsatisfactory performance.',
    `promotion_recommended_flag` BOOLEAN COMMENT 'Boolean indicator of whether the reviewer recommends the employee for promotion based on performance and readiness.',
    `property_code` STRING COMMENT 'The code identifying the hotel property or resort where the employee works and where this performance review was conducted.',
    `reliability_rating` STRING COMMENT 'Competency rating for reliability, punctuality, and attendance. Critical for 24/7 hospitality operations.. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding`',
    `review_completion_date` DATE COMMENT 'The date when the reviewer completed and submitted the performance review.',
    `review_due_date` DATE COMMENT 'The target date by which the performance review should be completed, based on organizational policy and review cycle.',
    `review_period_end_date` DATE COMMENT 'The end date of the performance evaluation period being assessed.',
    `review_period_start_date` DATE COMMENT 'The start date of the performance evaluation period being assessed.',
    `review_status` STRING COMMENT 'Current workflow status of the performance review (pending initiation, in-progress, completed by reviewer, acknowledged by employee, or cancelled).. Valid values are `pending|in-progress|completed|acknowledged|cancelled`',
    `review_template_code` STRING COMMENT 'The code identifying the performance review template or form used, which may vary by job level, department, or review type.',
    `review_type` STRING COMMENT 'The type or category of performance review being conducted (annual, mid-year, probationary, 90-day, project-based, or ad-hoc).. Valid values are `annual|mid-year|probationary|90-day|project|ad-hoc`',
    `reviewer_comments` STRING COMMENT 'Additional comments and observations from the reviewer providing context and detail beyond the structured ratings.',
    `strengths_summary` STRING COMMENT 'Narrative summary of the employees key strengths and positive contributions during the review period.',
    `succession_planning_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee has been identified for succession planning and leadership pipeline development.',
    `teamwork_rating` STRING COMMENT 'Competency rating for teamwork and collaboration with colleagues across departments and shifts.. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding`',
    `technical_skills_rating` STRING COMMENT 'Competency rating for job-specific technical skills (e.g., PMS proficiency for front desk, culinary skills for F&B, housekeeping standards).. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding`',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Formal employee performance evaluation records for hotel staff. Captures review period, review type (annual, mid-year, probationary, 90-day), overall performance rating, individual competency ratings (guest service, teamwork, reliability, technical skills), reviewer identity, review completion date, review status (pending, in-progress, completed, acknowledged), and development notes. Supports merit increase decisions and succession planning. Sourced from Oracle HCM Cloud Performance Management.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request record. Primary key.',
    `benefit_plan_id` BIGINT COMMENT 'Identifier of the leave accrual plan governing this leave type for the employee, defining accrual rates, carryover rules, and maximum balances.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor who approved or denied the leave request.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center to which the employees labor costs are allocated, used for payroll liability calculations.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department where the employee works, used for scheduling coverage planning and labor cost allocation.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Leave requests must reference governing policy (FMLA, ADA, PTO) for validation and audit. HR systems validate eligibility against policy rules, track policy basis for regulatory compliance, and provid',
    `primary_leave_employee_id` BIGINT COMMENT 'Identifier of the employee submitting the leave request.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the employee is assigned.',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.schedule. Business justification: Leave requests impact published schedules and require coverage planning. This FK links absence management to scheduling, enabling coverage_status tracking (leave_request.coverage_status, coverage_empl',
    `accrual_period` STRING COMMENT 'Time period for which the accrual balance is calculated, such as calendar year, fiscal year, or rolling 12 months.',
    `approval_date` DATE COMMENT 'Date when the approving manager made the approval or denial decision in yyyy-MM-dd format.',
    `approval_notes` STRING COMMENT 'Comments or notes provided by the approving manager regarding the approval or denial decision.',
    `approval_status` STRING COMMENT 'Current approval state of the leave request: pending, approved, denied, or escalated to higher management.. Valid values are `pending|approved|denied|escalated`',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise date and time when the approving manager made the approval or denial decision in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `balance_as_of_date` DATE COMMENT 'Date as of which the accrual balance figures are calculated in yyyy-MM-dd format.',
    `carryover_hours` DECIMAL(18,2) COMMENT 'Number of unused leave hours carried over from the previous accrual period, subject to plan carryover limits.',
    `certification_received_date` DATE COMMENT 'Date when required medical certification or supporting documentation was received by HR in yyyy-MM-dd format.',
    `coverage_status` STRING COMMENT 'Status of scheduling coverage arrangements for the employees absence: not required, pending, arranged, or confirmed.. Valid values are `not_required|pending|arranged|confirmed`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this leave request record was first created in the system in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `denial_reason` STRING COMMENT 'Explanation provided by the approving manager for denying the leave request, such as staffing constraints, blackout period, or insufficient accrual balance.',
    `end_date` DATE COMMENT 'Last date of the requested leave period in yyyy-MM-dd format.',
    `fmla_case_number` STRING COMMENT 'Unique case identifier for tracking FMLA leave usage and compliance, assigned when FMLA eligibility is established.',
    `hours_accrued` DECIMAL(18,2) COMMENT 'Total leave hours earned or accrued during the accrual period up to the request date.',
    `hours_requested` DECIMAL(18,2) COMMENT 'Number of leave hours being requested in this leave request, which will be deducted from the accrual balance if approved.',
    `hours_taken` DECIMAL(18,2) COMMENT 'Total leave hours used or taken during the accrual period prior to this request.',
    `is_ada_accommodation` BOOLEAN COMMENT 'Indicates whether this leave is granted as a reasonable accommodation under ADA (true) or not (false).',
    `is_fmla_qualifying` BOOLEAN COMMENT 'Indicates whether this leave request qualifies for FMLA protection (true) or not (false), based on reason and employee eligibility.',
    `is_intermittent` BOOLEAN COMMENT 'Indicates whether the leave is intermittent (true) or continuous (false). Intermittent leave is taken in separate blocks of time rather than one continuous period.',
    `is_paid` BOOLEAN COMMENT 'Indicates whether the leave is paid (true) or unpaid (false) based on leave type and accrual balance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this leave request record was last updated in the system in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `leave_subtype` STRING COMMENT 'Detailed classification within the leave type, such as continuous FMLA, intermittent FMLA, maternity, paternity, adoption leave, or COVID-19 sick leave.',
    `leave_type` STRING COMMENT 'Category of leave being requested: vacation, sick, FMLA (Family and Medical Leave Act), personal, bereavement, jury duty, military, unpaid, parental, or sabbatical. [ENUM-REF-CANDIDATE: vacation|sick|fmla|personal|bereavement|jury_duty|military|unpaid|parental|sabbatical — 10 candidates stripped; promote to reference product]',
    `opening_balance_hours` DECIMAL(18,2) COMMENT 'Leave accrual balance in hours at the start of the accrual period before this request.',
    `payroll_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact on payroll for this leave request, including accrued vacation liability or unpaid leave deductions.',
    `reason_description` STRING COMMENT 'Employee-provided explanation or justification for the leave request, such as medical appointment, family emergency, or vacation travel.',
    `remaining_balance_hours` DECIMAL(18,2) COMMENT 'Projected leave accrual balance in hours after this request is approved and hours are deducted.',
    `request_date` DATE COMMENT 'Date when the employee submitted the leave request in yyyy-MM-dd format.',
    `request_number` STRING COMMENT 'Business-facing unique reference number for the leave request, used for tracking and communication.',
    `request_status` STRING COMMENT 'Current workflow state of the leave request: draft, submitted, pending approval, approved, denied, cancelled, or withdrawn. [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|denied|cancelled|withdrawn — 7 candidates stripped; promote to reference product]',
    `request_timestamp` TIMESTAMP COMMENT 'Precise date and time when the employee submitted the leave request in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `requires_medical_certification` BOOLEAN COMMENT 'Indicates whether the leave request requires supporting medical documentation or certification (true) or not (false).',
    `start_date` DATE COMMENT 'First date of the requested leave period in yyyy-MM-dd format.',
    `total_days` DECIMAL(18,2) COMMENT 'Total number of calendar days covered by the leave request, including weekends and holidays if applicable.',
    `total_hours` DECIMAL(18,2) COMMENT 'Total number of work hours covered by the leave request, used for accrual deduction and payroll calculations.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Employee absence management records covering leave requests, approvals, and accrual balances across hotel properties. Captures leave type (vacation, sick, FMLA, personal, bereavement, jury duty, military, unpaid), requested dates, total days, approval status, approving manager, and leave balance impact including accrual period, opening balance, hours accrued, hours taken, carryover, and balance as-of date. Supports FMLA compliance tracking, ADA accommodation leave, scheduling coverage planning, payroll liability calculations for accrued vacation, and compliance with state-mandated paid sick leave laws. Sourced from Oracle HCM Cloud Absence Management.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` (
    `disciplinary_action_id` BIGINT COMMENT 'Unique identifier for the disciplinary action record. Primary key for the disciplinary action entity.',
    `employee_id` BIGINT COMMENT 'User ID of the system user who created this disciplinary action record. Audit field for accountability and data lineage tracking.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the system user who last modified this disciplinary action record. Audit field for accountability and change tracking.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Disciplinary actions occur within an organizational unit context (the employees department at time of incident). This provides organizational context for HR analytics, compliance reporting, and manag',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Disciplinary actions must cite specific policy violations for legal defensibility and consistency. HR and legal teams require direct link to policy violated for grievance defense, arbitration, and ens',
    `primary_disciplinary_employee_id` BIGINT COMMENT 'Unique identifier of the employee subject to the disciplinary action. Links to the employee master record in Oracle HCM Cloud or SAP S/4HANA HCM.',
    `property_id` BIGINT COMMENT 'Unique identifier of the hotel property where the disciplinary action occurred. Links to the property master record.',
    `tertiary_disciplinary_hr_business_partner_employee_id` BIGINT COMMENT 'Unique identifier of the HR business partner involved in reviewing and approving the disciplinary action. Links to the employee master record. Ensures HR oversight and policy compliance.',
    `workforce_safety_incident_id` BIGINT COMMENT 'Unique identifier linking this disciplinary action to an OSHA recordable incident record if applicable. Null if not an OSHA recordable incident. Supports integrated safety and HR compliance reporting.',
    `action_effective_date` DATE COMMENT 'The date on which the disciplinary action officially takes effect. For suspensions, this is the start date. For terminations, this is the last day of employment. May differ from incident date or issuance date.',
    `action_number` STRING COMMENT 'Business-facing unique reference number for the disciplinary action record. Format: DA-YYYYMMDD followed by sequence. Used for tracking and documentation purposes.. Valid values are `^DA-[0-9]{8}$`',
    `action_status` STRING COMMENT 'Current lifecycle status of the disciplinary action record. Statuses include draft (being prepared), issued (formally communicated to employee), active (in effect), completed (action period concluded), overturned (reversed on appeal), or expunged (removed from record per policy or legal requirement).. Valid values are `draft|issued|active|completed|overturned|expunged`',
    `action_type` STRING COMMENT 'The type of disciplinary action taken following progressive discipline policy. Includes verbal warning, written warning, final warning, suspension, termination, or performance improvement plan (PIP). Aligns with progressive discipline framework and union contract requirements where applicable.. Valid values are `verbal_warning|written_warning|final_warning|suspension|termination|performance_improvement_plan`',
    `corrective_action_plan` STRING COMMENT 'Description of the corrective actions required of the employee to address the violation and prevent recurrence. May include training, coaching, behavioral expectations, or performance targets. Part of progressive discipline and performance improvement process.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this disciplinary action record was first created in the system. Audit field for data lineage and compliance tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `employee_acknowledgment_date` DATE COMMENT 'The date on which the employee acknowledged receipt and understanding of the disciplinary action documentation. Null if not yet acknowledged. Critical for documentation completeness and legal defensibility.',
    `employee_acknowledgment_method` STRING COMMENT 'The method by which the employee acknowledged receipt of the disciplinary action. Methods include in-person signature, electronic signature, certified mail, email confirmation, or refused (employee declined to sign). Used for documentation audit trail.. Valid values are `in_person_signature|electronic_signature|certified_mail|email_confirmation|refused`',
    `expiration_date` DATE COMMENT 'The date on which the disciplinary action expires and is no longer considered active in progressive discipline tracking. Per policy, warnings may expire after a clean period (e.g., 12 months). Null for terminations or actions without expiration.',
    `expunged_date` DATE COMMENT 'The date on which the disciplinary action record was expunged from the employees active record. Null if not expunged. Used for data retention and compliance tracking.',
    `expunged_reason` STRING COMMENT 'Explanation of why the disciplinary action record was expunged. Reasons may include policy expiration, grievance settlement, legal requirement, or administrative correction. Null if not expunged.',
    `grievance_filed` BOOLEAN COMMENT 'Indicates whether the employee has filed a formal grievance or appeal against the disciplinary action. True if grievance filed, false otherwise. Critical for union contract compliance and legal risk management.',
    `grievance_outcome_notes` STRING COMMENT 'Detailed notes on the outcome of the grievance or appeal process, including any modifications to the original disciplinary action, settlements, or arbitration decisions. Null if no grievance filed.',
    `grievance_resolution_date` DATE COMMENT 'The date on which the grievance or appeal was formally resolved. Null if no grievance filed or if grievance is still pending. Used for labor relations reporting and compliance tracking.',
    `grievance_status` STRING COMMENT 'Current status of the grievance or appeal process if a grievance has been filed. Statuses include pending, under review, upheld (action stands), overturned (action reversed), settled, or withdrawn. Null if no grievance filed.. Valid values are `pending|under_review|upheld|overturned|settled|withdrawn`',
    `incident_date` DATE COMMENT 'The date on which the policy violation or incident occurred that led to the disciplinary action. This is the business event date, distinct from when the action was formally issued.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the incident or policy violation that led to the disciplinary action. Includes facts, witnesses, and context. Critical for wrongful termination defense and grievance documentation.',
    `is_eligible_for_rehire` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire following termination. True if eligible, false if not. Null for non-termination actions. Used by talent acquisition and background screening processes.',
    `is_expunged` BOOLEAN COMMENT 'Indicates whether the disciplinary action record has been expunged (removed from the employees active record) per policy, legal requirement, or grievance settlement. True if expunged, false otherwise. Expunged records are retained for audit but not used in progressive discipline tracking.',
    `is_paid_suspension` BOOLEAN COMMENT 'Indicates whether the suspension is paid or unpaid. True if paid, false if unpaid. Impacts payroll processing and labor cost allocation. Null for non-suspension actions.',
    `issued_date` DATE COMMENT 'The date on which the disciplinary action was formally issued and communicated to the employee. Distinct from incident date and effective date. Used for timeline tracking and compliance with notification requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this disciplinary action record was last modified in the system. Audit field for change tracking and compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `legal_hold` BOOLEAN COMMENT 'Indicates whether this disciplinary action record is subject to a legal hold due to pending or threatened litigation, regulatory investigation, or other legal proceedings. True if under legal hold, false otherwise. Records under legal hold must not be deleted or modified.',
    `legal_hold_case_number` STRING COMMENT 'Reference number of the legal case or investigation that triggered the legal hold on this record. Null if not under legal hold. Used for legal department tracking and e-discovery management.',
    `osha_recordable_incident` BOOLEAN COMMENT 'Indicates whether the incident that led to the disciplinary action is also an OSHA recordable safety incident. True if OSHA recordable, false otherwise. Links disciplinary actions to workplace safety compliance reporting.',
    `suspension_days` STRING COMMENT 'The total number of days of suspension if the action type is suspension. Null for non-suspension actions. Used for labor cost analysis and CPOR (Cost Per Occupied Room) labor component tracking.',
    `suspension_end_date` DATE COMMENT 'The end date of a suspension period if the action type is suspension. Null for non-suspension actions. Defines when the employee is eligible to return to work.',
    `suspension_start_date` DATE COMMENT 'The start date of a suspension period if the action type is suspension. Null for non-suspension actions. Used for payroll and scheduling system integration.',
    `termination_date` DATE COMMENT 'The effective date of employment termination if the action type is termination. Null for non-termination actions. This is the last day of active employment and triggers final payroll and benefits processing.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for termination if the action type is termination. Categories include voluntary resignation, involuntary for cause, involuntary for performance, involuntary for conduct, layoff, or mutual separation. Used for unemployment claims and compliance reporting.. Valid values are `voluntary|involuntary_cause|involuntary_performance|involuntary_conduct|layoff|mutual_separation`',
    `union_representative_name` STRING COMMENT 'Name of the union representative who was notified or involved in the disciplinary action process. Null if employee is not union-represented or if no representative was involved.',
    `union_representative_notified` BOOLEAN COMMENT 'Indicates whether the employees union representative was notified of the disciplinary action as required by union contract. True if notified, false otherwise. Null if employee is not union-represented. Critical for labor relations compliance.',
    `violation_category` STRING COMMENT 'The category of policy violation that triggered the disciplinary action. Categories include attendance issues, conduct violations, performance deficiencies, safety violations, general policy breaches, guest service failures, or theft/fraud. Used for trend analysis and compliance reporting. [ENUM-REF-CANDIDATE: attendance|conduct|performance|safety|policy_breach|guest_service|theft_fraud — 7 candidates stripped; promote to reference product]',
    `witness_names` STRING COMMENT 'Comma-separated list of names of witnesses to the incident or policy violation. Used for investigation documentation and wrongful termination defense. May be redacted in certain reporting contexts.',
    CONSTRAINT pk_disciplinary_action PRIMARY KEY(`disciplinary_action_id`)
) COMMENT 'Employee disciplinary and corrective action records for hotel staff including grievance tracking. Captures incident date, action type (verbal warning, written warning, final warning, suspension, termination), policy violation category, description of incident, corrective action plan, action effective date, appeal/grievance status, and HR business partner involved. Supports progressive discipline tracking, wrongful termination risk management, union grievance documentation, and OSHA recordable incident linkage.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` (
    `workforce_safety_incident_id` BIGINT COMMENT 'Unique identifier for the workplace safety incident record.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department where the incident occurred.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Safety incidents are analyzed by position/job type for OSHA risk assessment and compliance reporting. This enables OSHA 300 log reporting by job category and identification of high-risk positions. Cri',
    `employee_id` BIGINT COMMENT 'Identifier of the employee involved in the safety incident.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the incident occurred.',
    `body_part_affected` STRING COMMENT 'Specific body part or parts injured in the incident (e.g., lower back, right hand, left knee, head).',
    `corrective_action_date` DATE COMMENT 'Date when corrective actions were completed and implemented.',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective actions implemented to prevent recurrence of similar incidents.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this incident record was first created in the system.',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the employee was unable to work due to the incident.',
    `days_on_restricted_duty` STRING COMMENT 'Number of calendar days the employee was on job transfer or restricted work activity due to the incident.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost of the incident including medical expenses, lost time, and property damage.',
    `incident_date` DATE COMMENT 'Date when the workplace safety incident occurred.',
    `incident_description` STRING COMMENT 'Detailed narrative description of how the incident occurred and the circumstances surrounding it.',
    `incident_location` STRING COMMENT 'Specific location within the property where the incident occurred (e.g., kitchen, guest room 305, loading dock, pool area).',
    `incident_number` STRING COMMENT 'Business-assigned unique incident reference number for tracking and reporting purposes.',
    `incident_time` TIMESTAMP COMMENT 'Precise timestamp when the workplace safety incident occurred.',
    `incident_type` STRING COMMENT 'Classification of the type of workplace safety incident.. Valid values are `slip_fall|chemical_exposure|equipment_injury|ergonomic|near_miss|burn`',
    `injury_severity` STRING COMMENT 'Classification of the severity level of the injury sustained in the incident.. Valid values are `first_aid|medical_treatment|lost_time|restricted_duty|fatality|no_injury`',
    `investigation_completed_date` DATE COMMENT 'Date when the formal investigation of the incident was completed.',
    `investigation_status` STRING COMMENT 'Current status of the incident investigation process.. Valid values are `open|under_investigation|closed|pending_review`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this incident record was last updated in the system.',
    `medical_treatment_facility` STRING COMMENT 'Name and location of the medical facility where the employee received treatment.',
    `osha_300_log_entry_number` STRING COMMENT 'Reference number assigned to this incident in the OSHA 300 log if recordable.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA criteria for recordability on the OSHA 300 log.',
    `physician_name` STRING COMMENT 'Name of the physician or healthcare provider who treated the employee.',
    `preventable_flag` BOOLEAN COMMENT 'Indicates whether the incident was determined to be preventable through proper procedures or training.',
    `privacy_case_flag` BOOLEAN COMMENT 'Indicates whether the incident qualifies as a privacy case under OSHA regulations (e.g., mental health, sexual assault).',
    `reported_by` STRING COMMENT 'Name or identifier of the person who reported the incident (employee, supervisor, witness).',
    `reported_date` DATE COMMENT 'Date when the incident was formally reported to management or human resources.',
    `return_to_work_date` DATE COMMENT 'Date when the employee returned to full or modified work duties following the incident.',
    `root_cause_analysis` STRING COMMENT 'Detailed analysis of the underlying root cause(s) that led to the incident.',
    `witness_names` STRING COMMENT 'Names of any witnesses who observed the incident, separated by semicolons if multiple.',
    `workers_compensation_claim_number` STRING COMMENT 'Claim number assigned by the workers compensation insurance carrier for this incident.',
    CONSTRAINT pk_workforce_safety_incident PRIMARY KEY(`workforce_safety_incident_id`)
) COMMENT 'OSHA-recordable and non-recordable workplace safety incident records for hotel employees. Captures incident date and time, incident location (property, department, specific area), incident type (slip/fall, chemical exposure, equipment injury, ergonomic, near-miss), injury severity, body part affected, days away from work, OSHA recordable flag, OSHA 300 log entry reference, workers compensation claim number, and corrective action taken. Supports OSHA 300/301 regulatory reporting.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Unique identifier for the compensation plan definition. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compensation plans define which cost center absorbs the labor expense for budgeting, headcount planning, and labor cost variance analysis - essential for accurate departmental budget allocation and fu',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Compensation plans are defined for positions (job families, pay grades, FLSA classifications). Position is the authoritative source for job family and pay grade definitions. The compensation_plan tabl',
    `employee_id` BIGINT COMMENT 'Employee ID of the HR or compensation leader who approved this plan. Null if not yet approved.',
    `approval_status` STRING COMMENT 'Approval workflow status for this compensation plan: draft (being created), pending_approval (submitted for review), approved (authorized for use), rejected (not approved).. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this compensation plan was approved. Null if not yet approved.',
    `benefits_package_code` STRING COMMENT 'Code identifying the standard benefits package associated with this compensation plan (health, dental, retirement, etc.).. Valid values are `^[A-Z0-9]{2,8}$`',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether employees under this plan are eligible for discretionary or performance-based bonuses (True/False).',
    `brand_segment` STRING COMMENT 'Hotel brand segment to which this compensation plan applies: luxury, premium, select_service, extended_stay, resort, or all (applicable across all segments).. Valid values are `luxury|premium|select_service|extended_stay|resort|all`',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether employees under this plan are eligible for commission-based compensation (True/False). Typical for sales and revenue-generating roles.',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'Standard commission rate as a percentage of sales or revenue (e.g., 5.00 for 5%). Null if not commission eligible.',
    `compa_ratio_target` DECIMAL(18,2) COMMENT 'Target compa-ratio for employees in this plan (actual pay divided by midpoint). Typically 1.00 (100%) for market-competitive positioning.',
    `compensation_plan_description` STRING COMMENT 'Detailed description of the compensation plan, including eligibility criteria, special provisions, and business rationale.',
    `compensation_plan_status` STRING COMMENT 'Current lifecycle status of the compensation plan: active (in use), inactive (temporarily suspended), pending (awaiting approval), obsolete (retired).. Valid values are `active|inactive|pending|obsolete`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compensation plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this plan (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this compensation plan is no longer effective. Null for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when this compensation plan becomes effective and can be assigned to employees.',
    `flsa_status` STRING COMMENT 'FLSA classification: exempt (not eligible for overtime) or non_exempt (eligible for overtime pay). Critical for compliance and labor cost forecasting.. Valid values are `exempt|non_exempt`',
    `is_unionized` BOOLEAN COMMENT 'Indicates whether this compensation plan is subject to collective bargaining agreements (True/False).',
    `market_pricing_date` DATE COMMENT 'Date of the market pricing data used to establish or update this compensation plan.',
    `market_pricing_source` STRING COMMENT 'External compensation survey or benchmarking source used to establish pay ranges (e.g., Mercer, Willis Towers Watson, Salary.com).',
    `maximum_rate` DECIMAL(18,2) COMMENT 'Maximum pay rate for this plan, representing the ceiling for this grade. Used for pay equity and budget planning.',
    `merit_increase_cycle` STRING COMMENT 'Frequency of merit increase reviews for this plan: annual, biannual, quarterly, or none.. Valid values are `annual|biannual|quarterly|none`',
    `merit_increase_eligible` BOOLEAN COMMENT 'Indicates whether employees under this plan are eligible for annual merit increases based on performance (True/False).',
    `midpoint_rate` DECIMAL(18,2) COMMENT 'Midpoint or target pay rate for this plan, representing the market-competitive rate for fully competent performance.',
    `minimum_rate` DECIMAL(18,2) COMMENT 'Minimum pay rate for this plan (hourly rate for hourly plans, annual salary for salaried plans). Used for pay equity and compliance analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this compensation plan record was last modified.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether employees under this plan are eligible for overtime compensation (True/False). Aligns with FLSA status.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Null if not overtime eligible.',
    `pay_frequency` STRING COMMENT 'Frequency at which employees under this plan are paid (weekly, biweekly, semimonthly, monthly).. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `plan_code` STRING COMMENT 'Business identifier code for the compensation plan, used across HR systems and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `plan_name` STRING COMMENT 'Full descriptive name of the compensation plan (e.g., Hourly Front Desk Associate, Salaried Executive Chef).',
    `plan_type` STRING COMMENT 'Classification of the compensation structure: hourly (paid per hour worked), salaried (fixed annual compensation), tipped (base plus gratuities), commission (performance-based), service_charge_eligible (eligible for service charge distribution), or hybrid (combination).. Valid values are `hourly|salaried|tipped|commission|service_charge_eligible|hybrid`',
    `rate_unit` STRING COMMENT 'Unit of measure for the compensation rate: hour (hourly wage), year (annual salary), month (monthly salary), week (weekly wage), day (daily rate).. Valid values are `hour|year|month|week|day`',
    `service_charge_eligible` BOOLEAN COMMENT 'Indicates whether employees under this plan are eligible to receive a share of service charges (True/False). Common in banquet and group dining operations.',
    `target_bonus_percentage` DECIMAL(18,2) COMMENT 'Target bonus as a percentage of base compensation (e.g., 10.00 for 10% target bonus). Null if not bonus eligible.',
    `tip_credit_eligible` BOOLEAN COMMENT 'Indicates whether this plan is eligible for tip credit under FLSA (True/False). Applicable to tipped positions in Food and Beverage (F&B) operations.',
    `union_affiliation` STRING COMMENT 'Name of the labor union associated with this compensation plan, if applicable. Null if non-union.',
    `usali_department` STRING COMMENT 'USALI department classification for labor cost reporting (e.g., Rooms, Food and Beverage, Administrative and General, Sales and Marketing).',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Compensation structure definitions and individual employee pay change history for hotel positions. Covers pay plan types (hourly, salaried, tipped, commission, service-charge-eligible), pay grades with min/mid/max rates, effective dates, and brand segment applicability. Includes merit increases, promotional adjustments, market adjustments, and off-cycle changes with previous/new rates, change percentage, justification, approval chain, and SAP S/4HANA HR infotype reference. Supports pay equity analysis, merit administration, total compensation cost tracking, and USALI labor cost benchmarking.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor. Primary key for the vendor master record.',
    `address_line1` STRING COMMENT 'First line of the vendors primary business address including street number and name. Used for correspondence and legal documentation.',
    `address_line2` STRING COMMENT 'Second line of the vendors address for suite, floor, building, or other secondary address information.',
    `annual_spend_amount` DECIMAL(18,2) COMMENT 'Total procurement spend with this vendor over the most recent 12-month period. Used for vendor segmentation, negotiation leverage analysis, and spend analytics. Expressed in the companys reporting currency.',
    `bank_account_number` STRING COMMENT 'Vendors bank account number for electronic payment remittance. Highly sensitive financial information requiring restricted access and encryption.',
    `bank_name` STRING COMMENT 'Name of the financial institution holding the vendors primary remittance account. Used for ACH and wire transfer payments.',
    `bank_routing_number` STRING COMMENT 'Nine-digit ABA routing number identifying the vendors bank for ACH and wire transfers in the United States.. Valid values are `^[0-9]{9}$`',
    `city` STRING COMMENT 'City or municipality of the vendors primary business location.',
    `classification` STRING COMMENT 'Primary business classification of the vendor based on goods or services provided. Categories include Food and Beverage (F&B) supplier, housekeeping supplier, Furniture Fixtures and Equipment (FF&E) vendor, maintenance contractor, technology provider, and professional services.. Valid values are `food_beverage_supplier|housekeeping_supplier|ffe_vendor|maintenance_contractor|technology_provider|professional_services`',
    `compliance_status` STRING COMMENT 'Current compliance status indicating whether the vendor meets all required certifications, insurance requirements, and regulatory standards. Non-compliant vendors may be blocked from receiving new purchase orders.. Valid values are `compliant|non_compliant|pending_review|conditional`',
    `contract_end_date` DATE COMMENT 'Expiration date of the current master service agreement or supply contract with the vendor. Null for vendors without formal contracts or with evergreen agreements.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current master service agreement or supply contract with the vendor. Used for contract lifecycle management and renewal tracking.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the vendors primary business location. Examples: USA (United States), CAN (Canada), GBR (United Kingdom).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor master record was first created in the system. Used for audit trail and data lineage tracking.',
    `dba_name` STRING COMMENT 'Trade name or doing business as name if different from legal name. Used for operational communications and invoicing.',
    `diversity_certification` STRING COMMENT 'Diversity certification status of the vendor. Categories include Minority Business Enterprise (MBE), Women Business Enterprise (WBE), Disadvantaged Business Enterprise (DBE), Veteran Business Enterprise (VBE), LGBTQ Business Enterprise (LGBTBE), Service-Disabled Veteran-Owned Small Business (SDVOSB), HUBZone certified, or none. Used for supplier diversity reporting and corporate social responsibility initiatives. [ENUM-REF-CANDIDATE: mbe|wbe|dbe|vbe|lgbtbe|sdvosb|hubzone|none — 8 candidates stripped; promote to reference product]',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet DUNS number providing unique identification for the vendor entity. Used for credit assessment and supplier risk management.. Valid values are `^[0-9]{9}$`',
    `iban` STRING COMMENT 'International Bank Account Number for vendors in countries using the IBAN standard. Required for SEPA payments in Europe and other international transfers.',
    `insurance_certificate_expiry_date` DATE COMMENT 'Expiration date of the vendors current general liability insurance certificate. Vendors must maintain valid insurance coverage to remain in active status.',
    `last_review_date` DATE COMMENT 'Date of the most recent vendor performance review or compliance audit. Strategic and preferred vendors are typically reviewed annually; approved vendors are reviewed every 2-3 years.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order submission to delivery at property receiving dock. Used for inventory planning and procurement scheduling.',
    `minimum_order_amount` DECIMAL(18,2) COMMENT 'Minimum purchase order value required by the vendor for order acceptance. Orders below this threshold may incur additional fees or be rejected. Expressed in the vendors preferred currency.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor master record was last updated. Used for change tracking and audit trail compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next vendor performance review or compliance audit. Used for vendor management workflow and compliance calendar.',
    `onboarding_date` DATE COMMENT 'Date when the vendor was first approved and added to the procurement system. Used for vendor relationship tenure analysis and anniversary tracking.',
    `payment_method` STRING COMMENT 'Preferred payment method for remitting funds to the vendor. Options include Automated Clearing House (ACH) electronic transfer, wire transfer, paper check, credit card, or procurement card.. Valid values are `ach|wire_transfer|check|credit_card|procurement_card`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor. Defines the number of days from invoice date until payment is due. Common terms include Net 30 (payment due in 30 days) and 2/10 Net 30 (2% discount if paid within 10 days, otherwise due in 30 days). [ENUM-REF-CANDIDATE: net_30|net_45|net_60|net_90|due_on_receipt|2_10_net_30|prepayment_required — 7 candidates stripped; promote to reference product]',
    `postal_code` STRING COMMENT 'Postal code or ZIP code of the vendors primary business location. Format varies by country.',
    `preferred_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the vendors preferred invoicing and payment currency. Examples: USD (US Dollar), EUR (Euro), GBP (British Pound).. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary vendor contact for operational communications, purchase orders, and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the vendor organization. Typically the account manager or sales representative assigned to the hospitality business relationship.',
    `primary_contact_phone` STRING COMMENT 'Direct phone number for the primary vendor contact. Used for urgent procurement matters and order expediting.',
    `remittance_email` STRING COMMENT 'Email address for sending electronic remittance advice and payment notifications to the vendor. Used for accounts receivable communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `risk_rating` STRING COMMENT 'Overall risk assessment rating for the vendor based on financial stability, compliance history, delivery performance, and business continuity factors. Critical risk vendors require executive approval for new purchase orders.. Valid values are `low|medium|high|critical`',
    `state_province` STRING COMMENT 'State, province, or region of the vendors primary business location. Use standard postal abbreviations (e.g., CA for California, ON for Ontario).',
    `swift_code` STRING COMMENT 'SWIFT/BIC code for international wire transfers to vendors outside the domestic banking system. Eight or eleven character code identifying the bank and branch.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `tax_number` STRING COMMENT 'Government-issued tax identification number for the vendor. In the US this is the Employer Identification Number (EIN) or Social Security Number (SSN) for sole proprietors. Required for 1099 reporting and tax compliance.',
    `vat_registration_number` STRING COMMENT 'VAT registration number for vendors operating in jurisdictions with value-added tax systems. Required for international procurement and tax reclaim processing.',
    `vendor_code` STRING COMMENT 'External business identifier for the vendor used in procurement documents and SAP S/4HANA MM module. Unique alphanumeric code assigned to each supplier.. Valid values are `^[A-Z0-9]{6,12}$`',
    `vendor_name` STRING COMMENT 'Full legal name of the vendor or supplier organization as registered with tax authorities and used in contracts.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor in the procurement system. Active vendors can receive purchase orders; blocked vendors cannot transact pending resolution of compliance or performance issues.. Valid values are `active|inactive|suspended|pending_approval|blocked|terminated`',
    `vendor_tier` STRING COMMENT 'Vendor relationship tier indicating strategic importance and procurement preference. Strategic vendors receive priority treatment and volume commitments; restricted vendors require special approval for purchases.. Valid values are `strategic|preferred|approved|conditional|restricted`',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all suppliers and vendors providing goods and services to hotel and resort properties. Captures vendor identity, classification (F&B supplier, FF&E vendor, housekeeping supplier, maintenance contractor), tax registration, payment terms, preferred currency, remittance details, diversity certification, contact persons (account managers, sales reps, escalation contacts), and SAP S/4HANA vendor master integration. Serves as the SSOT for vendor identity and vendor contacts across procurement. Includes vendor tier, risk rating, compliance status, bank/payment details, and communication preferences.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` (
    `vendor_performance_id` BIGINT COMMENT 'Unique identifier for the vendor performance evaluation record.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Vendor performance is evaluated by procurement category since performance criteria vary by category (F&B vs. FF&E vs. services). FK enables category-specific scorecards and benchmarking.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who conducted or approved this vendor performance evaluation.',
    `property_id` BIGINT COMMENT 'Reference to the property where vendor performance is being evaluated. Supports property-level vendor scorecarding.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor being evaluated in this performance record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor performance evaluation was approved and published. Marks the official completion of the evaluation cycle.',
    `average_lead_time_days` STRING COMMENT 'Average number of days between purchase order issuance and goods receipt during the evaluation period. Measures vendor fulfillment speed.',
    `contract_compliance_score` DECIMAL(18,2) COMMENT 'Composite score measuring vendor adherence to contract terms including pricing, delivery terms, payment terms, and service level agreements. Scored 0-100.',
    `contract_renewal_recommendation` STRING COMMENT 'Recommendation for contract action based on performance evaluation results. Supports contract lifecycle management decisions.. Valid values are `renew|renegotiate|terminate|extend_trial`',
    `cost_competitiveness_rating` DECIMAL(18,2) COMMENT 'Rating of vendor pricing competitiveness compared to market benchmarks and alternative suppliers. Typically scored 1-5 scale.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor performance evaluation record was first created in the system.',
    `emergency_order_support_rating` DECIMAL(18,2) COMMENT 'Rating of vendor ability to fulfill urgent or emergency purchase orders outside normal lead times. Critical for hospitality operations continuity. Typically scored 1-5 scale.',
    `evaluation_notes` STRING COMMENT 'Free-text notes and comments from the evaluator regarding vendor performance, specific issues, or improvement recommendations.',
    `evaluation_period_end_date` DATE COMMENT 'End date of the performance evaluation period. Defines the window for performance measurement.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the performance evaluation period. Typically monthly or quarterly evaluation cycles.',
    `evaluation_status` STRING COMMENT 'Current lifecycle status of the vendor performance evaluation record.. Valid values are `draft|submitted|approved|published|archived`',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of invoices received without pricing errors, quantity discrepancies, or other billing issues during the evaluation period.',
    `invoice_discrepancies_count` STRING COMMENT 'Number of invoices with pricing errors, quantity mismatches, or other billing issues during the evaluation period.',
    `late_deliveries_count` STRING COMMENT 'Number of purchase orders delivered after the requested delivery date during the evaluation period.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor performance evaluation record was last modified.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on or before the requested delivery date during the evaluation period. Key metric for vendor reliability.',
    `overall_vendor_score` DECIMAL(18,2) COMMENT 'Weighted composite score combining all evaluation criteria (on-time delivery, quality, invoice accuracy, contract compliance, responsiveness). Used for vendor ranking and qualification decisions. Scored 0-100.',
    `payment_terms_compliance_flag` BOOLEAN COMMENT 'Indicates whether vendor adhered to agreed payment terms and did not demand early payment or deviate from contract terms.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor has achieved preferred vendor status based on performance evaluation results. Preferred vendors receive priority consideration for new purchase orders.',
    `qualified_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor meets minimum qualification standards for continued business. Vendors failing qualification may be subject to contract review or termination.',
    `quality_acceptance_rate` DECIMAL(18,2) COMMENT 'Percentage of goods receipts accepted without quality defects or rejections during the evaluation period. Measures product quality consistency.',
    `quality_rejections_count` STRING COMMENT 'Number of goods receipts rejected due to quality defects during the evaluation period.',
    `responsiveness_rating` DECIMAL(18,2) COMMENT 'Subjective rating of vendor responsiveness to inquiries, issues, and urgent requests. Typically scored 1-5 scale.',
    `sustainability_compliance_flag` BOOLEAN COMMENT 'Indicates whether vendor meets sustainability and environmental compliance requirements during the evaluation period. Supports ESG procurement initiatives.',
    `total_purchase_orders` STRING COMMENT 'Total number of purchase orders issued to this vendor during the evaluation period. Provides context for performance metrics.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Total procurement spend with this vendor during the evaluation period in USD. Supports spend concentration analysis.',
    CONSTRAINT pk_vendor_performance PRIMARY KEY(`vendor_performance_id`)
) COMMENT 'Periodic vendor performance evaluation records capturing on-time delivery rate, quality acceptance rate, invoice accuracy, contract compliance score, responsiveness rating, and overall vendor scorecard. Supports vendor qualification, preferred vendor designation, and contract renewal decisions. Aligned with USALI cost management standards and SAP MM vendor evaluation (ME61).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` (
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Procurement contracts are organized by category for contract compliance and category management. FK enables category-specific contract terms, approval workflows, and compliance tracking.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Procurement contracts create compliance obligations that hotels must track: insurance certificate requirements, vendor certifications (food safety, sustainability), regulatory standards (ADA complianc',
    `employee_id` BIGINT COMMENT 'Reference to the procurement or property staff member responsible for managing this contract, monitoring compliance, and coordinating renewals.',
    `primary_procurement_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who provided final approval for this contract. Null if contract is not yet approved.',
    `property_id` BIGINT COMMENT 'Reference to the property or hotel location to which this contract applies. Null if contract is enterprise-wide.',
    `tertiary_procurement_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who last modified this contract record.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor party with whom this contract is established.',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by authorized procurement or finance management. Null if contract is still in draft or pending approval.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at expiry unless explicitly terminated. True if contract has auto-renewal clause, False if manual renewal required.',
    `capex_designation_flag` BOOLEAN COMMENT 'Indicates whether this contract is designated for capital expenditure purchases (CapEx) such as Property Improvement Plan (PIP) projects, FF&E replacements, or major renovations. True for CapEx contracts, False for operating expenditure (OpEx) contracts.',
    `contract_name` STRING COMMENT 'Descriptive name or title of the procurement contract for easy identification by procurement staff.',
    `contract_number` STRING COMMENT 'Externally visible unique business identifier for the procurement contract, used in vendor communications and purchase orders.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the procurement contract. Draft indicates contract is being negotiated, pending approval awaiting internal authorization, active for contracts in force, suspended for temporarily paused agreements, expired for contracts past end date, terminated for contracts ended before expiry, renewed for contracts that have been extended. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the procurement contract structure. Master supply agreement for long-term supplier relationships, blanket PO for recurring purchases, frame contract for pre-negotiated terms, spot contract for one-time purchases, service agreement for ongoing services, CapEx contract for capital expenditure projects including Property Improvement Plan (PIP) initiatives.. Valid values are `master_supply_agreement|blanket_purchase_order|frame_contract|spot_contract|service_agreement|capex_contract`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which contract values, pricing, and payments are denominated.. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Standard number of days from purchase order placement to goods receipt at property, as agreed in the contract Service Level Agreement (SLA).',
    `document_url` STRING COMMENT 'URL or file path to the signed contract document stored in the enterprise document management system for legal reference and audit purposes.',
    `effective_date` DATE COMMENT 'Date when the contract terms become binding and purchasing can commence under the agreed terms.',
    `expiry_date` DATE COMMENT 'Date when the contract terms cease to be valid. Null for open-ended contracts without a defined end date.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last updated in the procurement system.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum order quantity allowed per purchase order or over contract term, if applicable. Used for contract compliance monitoring. Null if no maximum applies.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required per purchase order under this contract to qualify for negotiated pricing. Null if no minimum applies.',
    `negotiated_discount_percent` DECIMAL(18,2) COMMENT 'Overall discount percentage negotiated off standard vendor pricing, applied at contract level. Used for price variance analysis and savings tracking. Null if no blanket discount applies.',
    `notes` STRING COMMENT 'Free-text field for additional contract details, special terms, negotiation history, or operational notes relevant to procurement staff.',
    `payment_terms` STRING COMMENT 'Agreed payment terms and conditions, including net payment days, early payment discounts, and payment method requirements (e.g., Net 30, 2/10 Net 30, Net 60).',
    `pip_project_flag` BOOLEAN COMMENT 'Indicates whether this contract is specifically tied to a Property Improvement Plan (PIP) project for property renovation or upgrade. True if PIP-related, False otherwise.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiry that either party must provide notice to prevent auto-renewal or to initiate renewal discussions. Null if not applicable.',
    `sla_on_time_delivery_percent` DECIMAL(18,2) COMMENT 'Contractually agreed percentage of orders that must be delivered on time to meet SLA performance targets. Used for vendor performance monitoring.',
    `sla_quality_acceptance_percent` DECIMAL(18,2) COMMENT 'Contractually agreed percentage of delivered goods that must pass quality inspection on first receipt to meet SLA performance targets.',
    `termination_date` DATE COMMENT 'Date when the contract was formally terminated before its natural expiry. Null if contract has not been terminated.',
    `termination_reason` STRING COMMENT 'Business reason or justification for early contract termination, such as vendor performance issues, business requirement changes, or cost optimization. Null if contract has not been terminated.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total estimated or committed monetary value of the contract over its full term, in the contract currency. Used for contract compliance monitoring and spend analytics. Null for open-ended contracts without value caps.',
    CONSTRAINT pk_procurement_contract PRIMARY KEY(`procurement_contract_id`)
) COMMENT 'Master procurement contracts and supply agreements with vendors, modeled as header+line. Header captures contract type (master supply agreement, blanket PO, frame contract), vendor, effective/expiry dates, auto-renewal flags, total contract value, negotiated discounts, and SLAs. Lines specify agreed materials/services, unit prices, minimum/maximum order quantities, and validity periods. Supports contract compliance monitoring, price variance analysis, and CapEx/PIP contract designations. Integrates with SAP S/4HANA MM outline agreements (ME31K).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Purchase requisitions are classified by procurement category for routing, approval workflows, and spend tracking. The string column procurement_category should be normalized to FK reference. This enab',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department initiating the purchase request (F&B, Housekeeping, Engineering, Spa, Events, Front Office, etc.).',
    `vendor_id` BIGINT COMMENT 'Identifier of the preferred or suggested vendor for this requisition, if specified by the requestor.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who created the purchase requisition.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property where the requisition originated.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Purchase requisitions are converted to purchase orders during the procurement workflow. The string column purchase_order_number should be normalized to FK for traceability and requisition-to-PO lifecy',
    `quaternary_purchase_buyer_employee_id` BIGINT COMMENT 'Identifier of the procurement specialist or buyer assigned to source and convert this requisition to a purchase order.',
    `tertiary_purchase_final_approver_employee_id` BIGINT COMMENT 'Identifier of the employee who provided the final approval before conversion to purchase order.',
    `approval_chain_level` STRING COMMENT 'Current level in the approval hierarchy. Increments as requisition moves through approval workflow based on amount thresholds and organizational rules.',
    `approval_date` DATE COMMENT 'Date when the requisition received final approval and became eligible for conversion to purchase order.',
    `budget_available_flag` BOOLEAN COMMENT 'Indicates whether sufficient budget is available in the cost center and GL account for this requisition. True if budget check passed, False if insufficient funds.',
    `budget_period` STRING COMMENT 'Specific budget period (quarter or month) for expense allocation. Format: YYYY-Q# or YYYY-M##.. Valid values are `^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$`',
    `budget_year` STRING COMMENT 'Fiscal year against which the requisition is being charged for budget tracking and variance analysis.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition lifecycle was completed (converted to PO, cancelled, or rejected).',
    `contract_reference_number` STRING COMMENT 'Reference to an existing vendor contract or master agreement if this requisition is to be fulfilled under contract terms.',
    `converted_to_po_flag` BOOLEAN COMMENT 'Indicates whether this requisition has been converted to one or more purchase orders. True if converted, False if still pending or cancelled.',
    `cost_center_code` STRING COMMENT 'Cost center to which the requisition expense will be charged. Aligns with USALI departmental cost accounting.. Valid values are `^[0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase requisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated amount.. Valid values are `^[A-Z]{3}$`',
    `delivery_location_code` STRING COMMENT 'Code identifying the specific receiving location within the property (central receiving, F&B storage, housekeeping, engineering shop, etc.).',
    `estimated_total_amount` DECIMAL(18,2) COMMENT 'Estimated total value of the requisition in the propertys functional currency. Used for budget checking and approval routing.',
    `gl_account_code` STRING COMMENT 'General ledger account code for expense classification per USALI chart of accounts.. Valid values are `^[0-9]{6,10}$`',
    `item_count` STRING COMMENT 'Number of line items (distinct materials or services) included in this requisition.',
    `justification_text` STRING COMMENT 'Business justification provided by the requestor explaining the need for this procurement. Required for approval workflow.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase requisition record was last updated.',
    `priority_level` STRING COMMENT 'Urgency classification of the requisition. Critical for guest-impacting or safety issues, High for operational needs, Medium for planned procurement, Low for non-urgent requests.. Valid values are `Critical|High|Medium|Low`',
    `rejection_reason` STRING COMMENT 'Explanation provided by approver if the requisition was rejected. Null if not rejected.',
    `requested_delivery_date` DATE COMMENT 'Date by which the requesting department needs the goods or services delivered.',
    `requisition_number` STRING COMMENT 'Business-facing unique requisition number assigned by SAP MM module. Format: PR followed by 10 digits.. Valid values are `^PR[0-9]{10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the approval and procurement workflow. [ENUM-REF-CANDIDATE: Draft|Submitted|Pending Approval|Approved|Rejected|Cancelled|Converted to PO|Closed — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of requisition by financial treatment: OpEx (Operating Expenditure), CapEx (Capital Expenditure), PIP (Property Improvement Plan), Emergency, Stock Replenishment, or Service procurement.. Valid values are `OpEx|CapEx|PIP|Emergency|Stock Replenishment|Service`',
    `source_system` STRING COMMENT 'Identifier of the source system from which this requisition record originated (e.g., SAP S/4HANA MM, legacy PMS).',
    `source_system_key` STRING COMMENT 'Natural key or unique identifier from the source system for reconciliation and lineage tracking.',
    `sourcing_strategy` STRING COMMENT 'Procurement approach to be used for fulfilling this requisition based on value, category, and policy.. Valid values are `Direct PO|RFQ Required|Competitive Bid|Sole Source|Corporate Contract|Emergency Purchase`',
    `special_instructions` STRING COMMENT 'Additional instructions or requirements for procurement, delivery, or handling of the requested items.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition was submitted for approval workflow.',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal purchase request initiated by hotel departments (F&B, Housekeeping, Engineering, Spa, Events) to procure goods or services. Captures requesting department, requestor, cost center, GL account, required delivery date, estimated value, procurement category, priority, justification, and approval status with approval chain. Supports OpEx and CapEx (PIP) procurement initiation, budget checking, and routing to appropriate buyer or sourcing workflow. Sourced from SAP S/4HANA MM purchase requisition (ME51N).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Purchase orders are classified by procurement category for spend analytics, compliance tracking, and category management reporting. Normalizing the string column to FK enables hierarchical category ro',
    `cost_center_id` BIGINT COMMENT 'Reference to the departmental cost center that will bear the expense. Used for OpEx budget tracking and USALI departmental expense allocation (e.g., F&B, Housekeeping, Maintenance).',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: POs create financial commitments posted to specific GL accounts for encumbrance accounting and budget consumption tracking; required for commitment reporting and period-end accruals in hospitality fin',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: POs for multi-property portfolios require profit center attribution for property-level budget control and spend allocation; critical for property-level financial performance tracking and owner reporti',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or property location where goods or services will be delivered. Represents the ship-to address and the operational unit responsible for the purchase.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor from whom goods or services are being procured. Links to vendor master data in SAP MM.',
    `actual_delivery_date` DATE COMMENT 'The date goods were actually received or services were completed. Populated upon goods receipt posting (MIGO transaction). Used for vendor performance analysis and on-time delivery metrics.',
    `approval_date` DATE COMMENT 'The date the purchase order was approved and the financial commitment was authorized. Represents the encumbrance date for budget tracking.',
    `approver_name` STRING COMMENT 'Name of the manager or authorized signatory who approved the purchase order. Used for financial controls and SOX compliance.',
    `blanket_release_number` STRING COMMENT 'Sequential release number for blanket purchase orders. Tracks individual call-offs against a master blanket PO. Null for non-blanket orders.',
    `buyer_email` STRING COMMENT 'Email address of the buyer for vendor communication and order clarification.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `buyer_name` STRING COMMENT 'Name of the procurement specialist or property staff member who created the purchase order. Used for accountability and audit trail.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time the purchase order was closed after complete fulfillment and financial settlement. Null for open orders.',
    `commitment_released_amount` DECIMAL(18,2) COMMENT 'For blanket orders, the cumulative amount released to date against the total blanket commitment. Used for spend tracking and remaining commitment calculation.',
    `contract_reference_number` STRING COMMENT 'Reference to a master contract or blanket purchase agreement under which this PO is issued. Used for contract compliance tracking and release order management.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time the purchase order record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase order monetary values. Typically matches the vendors billing currency or propertys local currency.. Valid values are `^[A-Z]{3}$`',
    `goods_receipt_completed_flag` BOOLEAN COMMENT 'Boolean indicator whether all goods or services have been received and posted. True indicates receiving is complete, false indicates partial or no receipt. Used to trigger invoice matching and payment processing.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for shipping, insurance, and risk transfer. Examples: EXW (Ex Works), FOB (Free On Board), DDP (Delivered Duty Paid). Critical for international procurement and FF&E imports. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_receipt_completed_flag` BOOLEAN COMMENT 'Boolean indicator whether vendor invoice has been received and matched to the purchase order. Used for three-way match validation (PO, goods receipt, invoice) and accounts payable processing.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time the purchase order record was last modified. Used for change tracking and audit compliance.',
    `payment_terms` STRING COMMENT 'The agreed payment terms code defining when payment is due to the vendor. Examples include Net 30, Net 60, 2/10 Net 30 (2% discount if paid within 10 days, otherwise net 30). Maps to SAP payment terms master data.. Valid values are `^[A-Z0-9]{0,10}$`',
    `po_date` DATE COMMENT 'The date the purchase order was created and issued. Represents the business event timestamp for the procurement transaction.',
    `po_number` STRING COMMENT 'Externally-known business identifier for the purchase order. Unique document number assigned by SAP MM module (transaction ME21N). Used for vendor communication and cross-system reference.. Valid values are `^[A-Z0-9]{10,20}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the approval and fulfillment workflow. Draft indicates initial creation, pending approval indicates routing through approval chain, approved indicates financial commitment authorized, released indicates transmitted to vendor, partially received indicates goods/services partially delivered, fully received indicates complete delivery, closed indicates financial settlement complete, cancelled indicates order voided. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|released|partially_received|fully_received|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order. Standard for one-time purchases, blanket for recurring releases against a master agreement, framework for multi-property contracts, CapEx for capital expenditure projects (FF&E, PIP), OpEx for operating expenditure (F&B supplies, housekeeping consumables), service for contracted services.. Valid values are `standard|blanket|framework|capex|opex|service`',
    `promised_delivery_date` DATE COMMENT 'The date the vendor committed to deliver goods or complete services. Used for vendor SLA tracking and receiving schedule planning.',
    `requested_delivery_date` DATE COMMENT 'The date by which the property requires delivery of goods or completion of services. Used for supply chain planning and vendor performance tracking.',
    `requisition_number` STRING COMMENT 'Reference to the internal purchase requisition that originated this purchase order. Links operational need to procurement fulfillment.',
    `ship_to_address_line1` STRING COMMENT 'First line of the delivery address for the property or receiving location. Typically the property name and street address.',
    `ship_to_address_line2` STRING COMMENT 'Second line of the delivery address. May include building name, department, or additional location details.',
    `ship_to_city` STRING COMMENT 'City name for the delivery address.',
    `ship_to_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the delivery address. Used for international shipping, customs, and tax compliance.. Valid values are `^[A-Z]{3}$`',
    `ship_to_postal_code` STRING COMMENT 'Postal code or ZIP code for the delivery address. Used for shipping logistics and tax calculation.',
    `ship_to_state_province` STRING COMMENT 'State, province, or region for the delivery address. Used for tax jurisdiction determination.',
    `shipping_method` STRING COMMENT 'The mode of transportation for goods delivery. Ground for truck freight, air for expedited air freight, ocean for container shipping (FF&E imports), courier for small package delivery, vendor delivery for supplier-managed logistics, pickup for property collection from vendor location.. Valid values are `ground|air|ocean|courier|vendor_delivery|pickup`',
    `special_instructions` STRING COMMENT 'Free-text field for additional delivery instructions, handling requirements, or vendor-specific notes. Examples: Deliver to loading dock, Refrigerated transport required, Contact receiving manager upon arrival.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applicable to the purchase order. Includes sales tax, VAT, GST, or other jurisdiction-specific taxes based on property location and vendor tax classification.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total gross value of the purchase order including all line items, before taxes and fees. Represents the financial commitment or encumbrance against the budget upon approval.',
    `total_amount_with_tax` DECIMAL(18,2) COMMENT 'The total purchase order value including all taxes and fees. Represents the final financial obligation to the vendor.',
    `vendor_quote_number` STRING COMMENT 'Reference number of the vendors quotation or proposal that this purchase order is based on. Used for price verification and audit trail.',
    `wbs_element` STRING COMMENT 'Project WBS element for CapEx and PIP (Property Improvement Plan) procurement. Used to track capital expenditure against specific renovation or development projects. Null for OpEx purchases.. Valid values are `^[A-Z0-9-.]{0,24}$`',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Formal purchase orders issued to vendors for goods and services required by hotel and resort operations. Captures PO type (standard, blanket, framework, CapEx/PIP), vendor, delivery address (property), payment terms, incoterms, total PO value, currency, approval status, WBS element for CapEx/PIP projects, and SAP document number. Represents the financial commitment/encumbrance against departmental or project budgets upon approval. Supports both OpEx purchasing (F&B supplies, housekeeping consumables) and CapEx procurement (FF&E, renovation materials). Includes delivery schedule attributes, approval workflow status, and commitment release tracking for blanket orders. Core transactional entity in SAP S/4HANA MM (ME21N).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: PO line items are classified by procurement category for detailed spend analytics and line-level category tracking. FK enables accurate category spend reporting at the most granular level.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the item being procured. Links to the material catalog for goods such as Food and Beverage (F&B) supplies, housekeeping items, or Furniture Fixtures and Equipment (FF&E).',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the master vendor contract or blanket purchase agreement from which this line item is released. Links to negotiated terms and pricing agreements.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `requisition_line_id` BIGINT COMMENT 'Reference to the originating purchase requisition line item that triggered this purchase order line. Provides traceability from demand to procurement.',
    `service_material_master_id` BIGINT COMMENT 'Reference to the service master record for service-based procurement. Used when the line item represents a service rather than a physical material.',
    `cost_center` STRING COMMENT 'The cost center to which this line item expenditure will be charged for Operating Expenditure (OpEx) purchases. Used for departmental cost allocation and Gross Operating Profit (GOP) analysis per Uniform System of Accounts for the Lodging Industry (USALI).',
    `created_by_user` STRING COMMENT 'The user ID of the procurement professional or system user who created this purchase order line item. Used for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was originally created in the system. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line item pricing. Indicates the currency in which unit price and net order value are denominated. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|AUD|CAD|CHF|INR|MXN|BRL|AED|SGD|HKD|THB — 15 candidates stripped; promote to reference product]',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item has been marked for deletion. When true, the line is logically deleted but retained for audit trail purposes.',
    `delivery_date` DATE COMMENT 'The requested or confirmed delivery date for this line item. Represents when the vendor is expected to deliver the goods or complete the service.',
    `final_invoice_indicator` BOOLEAN COMMENT 'Flag indicating that the final invoice has been received for this line item and no further invoices are expected. Triggers line closure and prevents additional invoice postings.',
    `general_ledger_account` STRING COMMENT 'The General Ledger account code to which this line item will be posted. Determines the financial statement classification per USALI chart of accounts.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether goods receipt processing is required for this line item. When true, physical receipt must be posted before invoice can be processed.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity of goods that have been physically received and posted against this purchase order line. Used for three-way match validation between PO, goods receipt, and invoice.',
    `incoterms` STRING COMMENT 'The Incoterms code defining the delivery terms and transfer of risk between buyer and seller. Determines shipping responsibility and cost allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether invoice verification is required for this line item. When true, vendor invoice must be matched and verified before payment.',
    `invoice_receipt_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity that has been invoiced by the vendor against this purchase order line. Used for three-way match validation and to track invoicing completeness.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order. Determines the ordering and display sequence of line items.',
    `line_status` STRING COMMENT 'The current lifecycle status of this purchase order line item. Tracks progression from order placement through goods receipt, invoicing, and final closure.. Valid values are `Open|Partially Received|Fully Received|Invoiced|Closed|Cancelled`',
    `manufacturer_part_number` STRING COMMENT 'The original manufacturers part number or model number for the item being procured. Ensures correct item specification and quality standards.',
    `modified_by_user` STRING COMMENT 'The user ID of the person who last modified this purchase order line item. Provides audit trail for changes to procurement terms or quantities.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was last modified. Tracks changes to quantities, pricing, delivery dates, or other line attributes.',
    `net_order_value` DECIMAL(18,2) COMMENT 'The total net value of this line item calculated as order quantity multiplied by unit price. Excludes taxes and represents the base procurement cost.',
    `open_quantity` DECIMAL(18,2) COMMENT 'The remaining quantity still outstanding on this purchase order line, calculated as order quantity minus goods receipt quantity. Represents unfulfilled procurement commitment.',
    `order_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service units ordered on this line item. Represents the total amount requested from the vendor.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage by which the vendor may over-deliver beyond the ordered quantity without requiring approval. Used for goods receipt validation.',
    `plant_code` STRING COMMENT 'The property or facility code where the material will be received or the service will be performed. Represents the destination location within the hotel or resort portfolio.',
    `price_unit` STRING COMMENT 'The quantity of units to which the unit price applies. For example, if price is stated per 100 units, this field would contain 100.',
    `short_text` STRING COMMENT 'Brief description of the material or service being ordered on this line item. Provides human-readable context for the procurement item.',
    `storage_location` STRING COMMENT 'The specific storage location or warehouse within the plant where goods will be received and stored. Examples include main warehouse, F&B storage, housekeeping supply room, or FF&E storage.',
    `tax_code` STRING COMMENT 'Tax classification code that determines the applicable tax rate and tax jurisdiction for this line item. Used for tax calculation and compliance reporting.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage by which the vendor may under-deliver below the ordered quantity without penalty. Used for goods receipt validation and automatic PO closure.',
    `unit_of_measure` STRING COMMENT 'The unit in which the ordered quantity is measured. Examples include Each (EA), Case (CS), Kilogram (KG), Liter (LT), Hour (HR) for services, or Day (DA) for rental equipment. [ENUM-REF-CANDIDATE: EA|CS|BX|KG|LB|LT|GL|M|FT|HR|DA|PC|PK|RL|ST — 15 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The agreed price per unit of measure for this line item. Represents the negotiated rate with the vendor before any discounts or surcharges.',
    `vendor_material_number` STRING COMMENT 'The vendors own catalog or SKU number for the material or service. Used for cross-referencing with vendor invoices and facilitating three-way match processing.',
    `wbs_element` STRING COMMENT 'The project Work Breakdown Structure element for Capital Expenditure (CapEx) procurement tied to Property Improvement Plan (PIP) projects or renovation initiatives. Used for project-based cost tracking.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items within a purchase order specifying the material or service ordered, quantity, unit of measure, agreed unit price, delivery date, storage location, and account assignment (cost center, WBS element for CapEx/PIP projects). Tracks goods receipt quantity, invoice quantity, and open quantity for three-way match processing. Sourced from SAP S/4HANA MM PO line item (EKPO).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Goods receipts are classified by procurement category for inventory management and receiving workflow routing. Normalizing enables category-specific receiving rules and quality inspection requirements',
    `pip_plan_id` BIGINT COMMENT 'Reference to the PIP project if this goods receipt is part of a capital improvement initiative. Links FF&E procurement to renovation projects.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or authorized person who approved the goods receipt for posting. Required for segregation of duties and SOX compliance.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property where goods are being received. Enables property-level inventory tracking.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods are being received. Links to the originating procurement document.',
    `receiving_employee_id` BIGINT COMMENT 'Identifier of the staff member who physically received and inspected the goods. Used for accountability and training purposes.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor delivering the goods. Used for vendor performance tracking and three-way match.',
    `batch_managed_flag` BOOLEAN COMMENT 'Indicates whether the received materials are tracked by batch or lot number. Essential for F&B traceability and recall management.',
    `bill_of_lading_number` STRING COMMENT 'Shipping document number for freight shipments. Used for tracking and freight audit, especially for FF&E deliveries.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods receipt was cancelled or reversed. Used for exception tracking and process improvement analysis.',
    `capex_opex_indicator` STRING COMMENT 'Classification of the procurement as capital expenditure (FF&E, PIP projects) or operating expenditure (supplies, consumables). Drives accounting treatment and financial reporting.. Valid values are `capex|opex`',
    `condition_on_receipt` STRING COMMENT 'Physical condition assessment of goods upon delivery. Drives acceptance decisions, vendor performance scoring, and claims processing.. Valid values are `good|damaged|expired|incorrect_item|short_shipment|overage`',
    `cost_center_code` STRING COMMENT 'Accounting cost center to which the received goods are charged. Enables departmental expense tracking per USALI standards.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods receipt record was first created in the system. Used for audit trail and process timing analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction value. Supports multi-currency operations for international property portfolios.. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'The vendors delivery note or packing slip reference number. Critical for three-way match and vendor reconciliation.',
    `document_date` DATE COMMENT 'The date printed on the delivery note or packing slip from the vendor. Used for reconciliation and dispute resolution.',
    `freight_charges_amount` DECIMAL(18,2) COMMENT 'Shipping and freight costs associated with this delivery. May be capitalized into inventory cost or expensed depending on accounting policy.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting the inventory or expense transaction. Aligns with USALI chart of accounts.',
    `gr_document_number` STRING COMMENT 'External business identifier for the goods receipt document. Unique alphanumeric code used in SAP MM for tracking and audit purposes.. Valid values are `^[A-Z0-9]{10}$`',
    `gr_status` STRING COMMENT 'Current lifecycle status of the goods receipt transaction. Tracks progression from draft through posting to potential reversal.. Valid values are `draft|posted|cancelled|reversed`',
    `inspection_status` STRING COMMENT 'Quality inspection outcome for the received goods. Determines whether goods are accepted into inventory or flagged for return/credit.. Valid values are `not_inspected|passed|failed|partial_acceptance|pending_qa`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods receipt record was last updated. Tracks changes for audit and compliance purposes.',
    `movement_type` STRING COMMENT 'SAP MM movement type code indicating the nature of the inventory transaction. 101=GR for PO, 102=GR reversal, 161=GR for returns, 501=GR without PO, etc. [ENUM-REF-CANDIDATE: 101|102|103|105|161|501|502 — 7 candidates stripped; promote to reference product]',
    `posted_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods receipt was posted to inventory and financial accounts. Marks the completion of the receiving transaction.',
    `posting_date` DATE COMMENT 'The accounting date when the goods receipt is posted to the general ledger and inventory accounts. May differ from physical receipt date.',
    `quality_rejection_flag` BOOLEAN COMMENT 'Indicates whether any portion of the goods receipt was rejected due to quality issues. Triggers vendor notification and return processing.',
    `receipt_date` DATE COMMENT 'The actual date when goods were physically received at the property. Used for inventory valuation and lead time analysis.',
    `receiving_notes` STRING COMMENT 'Free-text comments from the receiving staff regarding delivery conditions, discrepancies, or other observations. Used for dispute resolution and vendor feedback.',
    `return_delivery_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt represents a return to vendor rather than an inbound delivery. Used for reverse logistics tracking.',
    `serial_number_managed_flag` BOOLEAN COMMENT 'Indicates whether the received items are tracked by individual serial numbers. Typical for FF&E assets and high-value equipment.',
    `special_handling_instructions` STRING COMMENT 'Notes regarding special handling requirements for the received goods, such as refrigeration, fragile items, hazardous materials, or security protocols.',
    `storage_location_code` STRING COMMENT 'Code identifying the specific storeroom, warehouse, or storage area within the property where goods are placed. Examples: main kitchen, housekeeping storage, central warehouse.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the goods require temperature-controlled storage. Critical for F&B inventory compliance with food safety regulations.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match process comparing purchase order, goods receipt, and vendor invoice. Critical for accounts payable processing and internal controls.. Valid values are `not_started|matched|variance_detected|blocked|approved`',
    `total_quantity_received` DECIMAL(18,2) COMMENT 'Aggregate quantity of all line items received in this goods receipt transaction. Used for high-level receiving volume tracking.',
    `total_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all goods received in this transaction, in the propertys local currency. Used for inventory valuation and financial reporting.',
    `unloading_point` STRING COMMENT 'Physical location at the property where goods were delivered and unloaded. Examples: loading dock, main entrance, kitchen entrance.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary difference between expected value (from PO) and actual received value. Triggers investigation when exceeds tolerance thresholds.',
    `variance_reason_code` STRING COMMENT 'Standardized code explaining the cause of any variance between PO and GR. Used for root cause analysis and process improvement.. Valid values are `price_change|quantity_short|quantity_over|damaged_goods|substitution|freight_variance`',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt of goods and materials at hotel and resort properties against purchase orders, modeled as header+line. Header captures receiving date, location (property, storeroom), posting date, and GR document number. Lines capture material received, quantity, unit of measure, batch number, storage location, movement type, condition on receipt, and PO line reference. Triggers inventory update and initiates three-way match for invoice verification. Sourced from SAP S/4HANA MM (MIGO). Critical for F&B inventory, housekeeping supplies, and FF&E receiving.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Vendor invoices are classified by procurement category for AP analytics, accrual tracking, and category spend reporting. FK enables category-level invoice approval workflows and spend variance analysi',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who approved this invoice for payment. Null if not yet approved.',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document for three-way match validation. Null if no GR exists.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Multi-property management companies track vendor invoices by profit center (property) for property-level P&L and owner reporting; required for management fee calculations and owner distribution statem',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property that received the goods or services.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is matched. Null for non-PO invoices.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who issued this invoice.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice was approved for payment. Null if not yet approved.',
    `cost_center_code` STRING COMMENT 'The cost center code for allocating the invoice expense to a specific department or operational unit within the property.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice (e.g., early payment discount, volume discount), in the invoice currency.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the invoice is currently under dispute. True if disputed, False otherwise.',
    `dispute_reason` STRING COMMENT 'The reason code or description for the invoice dispute (e.g., pricing discrepancy, quantity mismatch, quality issue, unauthorized charges). Null if not disputed.',
    `dispute_resolution_date` DATE COMMENT 'The date the dispute was resolved. Null if dispute is still open or if no dispute exists.',
    `dispute_resolution_notes` STRING COMMENT 'Free-text notes describing the resolution of the dispute. Null if not applicable.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The amount in dispute, in the invoice currency. Null if not disputed.',
    `document_date` DATE COMMENT 'The document date used for accounting period assignment and reporting.',
    `early_payment_discount_date` DATE COMMENT 'The last date by which payment must be made to qualify for the early payment discount. Null if not applicable.',
    `early_payment_discount_eligible_flag` BOOLEAN COMMENT 'Indicates whether this invoice is eligible for an early payment discount per the payment terms. True if eligible, False otherwise.',
    `early_payment_discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount available if the invoice is paid within the early payment discount period (e.g., 2.00 for 2%). Null if not applicable.',
    `expense_type` STRING COMMENT 'Classification of the invoice as Operating Expenditure (OpEx) or Capital Expenditure (CapEx). CapEx typically relates to Property Improvement Plan (PIP) projects and Furniture Fixtures and Equipment (FF&E).. Valid values are `opex|capex`',
    `gl_account_code` STRING COMMENT 'The primary General Ledger (GL) account code for posting this invoice. Used for Uniform System of Accounts for the Lodging Industry (USALI)-compliant cost allocation.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before tax, in the invoice currency. Sum of all line item amounts.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. Principal business event timestamp for the invoice.',
    `invoice_description` STRING COMMENT 'Free-text description or notes about the invoice, typically provided by the vendor or added by Accounts Payable (AP) staff.',
    `invoice_number` STRING COMMENT 'The externally-known invoice number assigned by the vendor. Business identifier for the invoice document.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the Accounts Payable (AP) workflow. [ENUM-REF-CANDIDATE: draft|posted|approved|paid|disputed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type (standard invoice, credit memo, debit memo, prepayment, or recurring).. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring`',
    `match_variance_amount` DECIMAL(18,2) COMMENT 'The variance amount between the invoice and the PO/GR during three-way match, in the invoice currency. Null if matched.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total invoice amount payable after tax and discounts, in the invoice currency. Gross + Tax - Discount.',
    `payment_date` DATE COMMENT 'The actual date the invoice was paid. Null if not yet paid.',
    `payment_due_date` DATE COMMENT 'The date by which payment is due to the vendor per the payment terms.',
    `payment_method` STRING COMMENT 'The payment instrument or method used or planned for paying this invoice (e.g., Automated Clearing House (ACH), wire transfer, check, credit card, virtual card).. Valid values are `ach|wire_transfer|check|credit_card|virtual_card`',
    `payment_reference_number` STRING COMMENT 'The reference number or transaction ID of the payment made against this invoice. Null if not yet paid.',
    `payment_terms_code` STRING COMMENT 'The payment terms code defining the due date calculation and early payment discount eligibility (e.g., Net 30, 2/10 Net 30).',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the financial ledger in the accounting system.',
    `project_code` STRING COMMENT 'The project code for CapEx invoices related to Property Improvement Plan (PIP) projects, renovations, or capital investments. Null for OpEx invoices.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice, in the invoice currency.',
    `tax_code` STRING COMMENT 'The tax code used for calculating tax on this invoice (e.g., sales tax, VAT, GST). Determines tax rate and jurisdiction.',
    `tax_jurisdiction` STRING COMMENT 'The tax jurisdiction or authority under which the tax is calculated (e.g., state, province, country).',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation between Purchase Order (PO), Goods Receipt (GR), and invoice. Indicates whether the invoice matches the PO and GR within tolerance.. Valid values are `matched|variance|no_po|no_gr|blocked`',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Vendor invoices received for goods and services procured by hotel and resort properties, modeled as header+line. Header captures invoice number, date, vendor, gross amount, tax amount, currency, payment due date, payment terms, three-way match status, and dispute details (reason, disputed amount, resolution). Lines capture material/service, quantity billed, unit price, line amount, tax code, GL account, cost center, and PO line/GR references. Supports AP processing, early payment discount capture, dispute management, and USALI-compliant cost allocation. Sourced from SAP S/4HANA MM (MIRO/MIR7).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`material_master` (
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record. Primary key for the material catalog.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Materials are classified by procurement category for catalog management, sourcing strategy, and spend classification. FK enables hierarchical category navigation and category-specific procurement rule',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the material master record. Supports accountability and audit compliance.',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and usage frequency. A items are high-value/high-usage requiring tight control; C items are low-value/low-usage with relaxed management. Drives inventory policy and cycle count frequency.. Valid values are `A|B|C`',
    `allergen_information` STRING COMMENT 'List of allergens present in the material, critical for Food and Beverage (F&B) ingredients. Examples include dairy, gluten, nuts, shellfish, soy. Required for menu labeling and guest safety.',
    `base_unit_of_measure` STRING COMMENT 'Standard unit in which the material is stocked, issued, and valued. Examples include EA (each), CS (case), BX (box), KG (kilogram), LT (liter), GL (gallon), DZ (dozen). Aligns with inventory and procurement transactions.. Valid values are `^[A-Z]{2,3}$`',
    `brand_name` STRING COMMENT 'Commercial brand or trademark under which the material is marketed. Important for guest-facing amenities and Food and Beverage (F&B) ingredients where brand consistency impacts guest experience.',
    `capex_opex_indicator` STRING COMMENT 'Indicates whether the material is capitalized as a fixed asset (CapEx) or expensed as an operating cost (OpEx). Furniture Fixtures and Equipment (FF&E) for Property Improvement Plan (PIP) projects are typically CapEx; consumables and supplies are OpEx.. Valid values are `capex|opex`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166 country code indicating where the material is manufactured or sourced. Required for customs, trade compliance, and sustainability reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the material master record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard price. Enables multi-currency procurement and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date after which the material is no longer available for procurement. Used for planned discontinuation and phase-out of materials.',
    `effective_start_date` DATE COMMENT 'Date from which the material master record is valid and available for procurement transactions. Supports phased rollout of new materials.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous and requires special handling, storage, and disposal procedures per Occupational Safety and Health Administration (OSHA) regulations.',
    `lead_time_days` STRING COMMENT 'Average number of days from purchase order placement to goods receipt. Used for Material Requirements Planning (MRP) calculations and reorder point determination.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactures or produces the material. Used for quality tracking, warranty management, and vendor performance evaluation.',
    `manufacturer_part_number` STRING COMMENT 'Unique part number assigned by the manufacturer. Enables precise identification for ordering, quality control, and warranty claims.',
    `material_description` STRING COMMENT 'Full descriptive name of the material, supply, or good. Provides human-readable identification for procurement, receiving, and inventory management.',
    `material_group` STRING COMMENT 'Detailed grouping of materials within a procurement category for granular spend analysis, vendor specialization, and contract management. Enables category-level reporting and sourcing strategy.',
    `material_number` STRING COMMENT 'Unique alphanumeric code assigned to the material in the procurement system. External business identifier used across purchase orders, goods receipts, and inventory transactions.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material in the catalog. Active materials are available for procurement; inactive or discontinued materials are phased out; blocked materials cannot be ordered due to quality or compliance issues.. Valid values are `active|inactive|discontinued|pending_approval|blocked`',
    `material_type` STRING COMMENT 'Classification of the material based on its procurement and usage purpose. Determines procurement rules, valuation methods, and inventory management policies.. Valid values are `raw_material|trading_goods|finished_goods|spare_parts|consumables|services`',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Upper limit for inventory holding to prevent overstocking, minimize carrying costs, and reduce waste for perishable items.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from vendors. Driven by vendor terms, packaging constraints, or economic order quantity calculations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the material master record was last updated. Tracks changes to pricing, status, vendor assignments, and other attributes.',
    `perishable_flag` BOOLEAN COMMENT 'Indicates whether the material has a limited shelf life and requires expiration date tracking. True for Food and Beverage (F&B) ingredients, fresh produce, and time-sensitive supplies.',
    `procurement_type` STRING COMMENT 'Method by which the material is procured. Standard is direct purchase; consignment is vendor-owned inventory; subcontracting involves external processing; stock transfer is inter-property movement.. Valid values are `standard|consignment|subcontracting|stock_transfer`',
    `purchase_unit_of_measure` STRING COMMENT 'Unit in which the material is ordered from vendors. May differ from base unit (e.g., purchased in cases but stocked in each). Conversion factor to base unit is maintained separately.. Valid values are `^[A-Z]{2,3}$`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming goods must undergo quality inspection before acceptance. True for critical materials, Food and Beverage (F&B) ingredients, and items with quality history issues.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level at which a replenishment order should be triggered. Calculated based on lead time demand and safety stock requirements to prevent stockouts.',
    `safety_stock_level` DECIMAL(18,2) COMMENT 'Buffer inventory maintained to protect against demand variability and supply disruptions. Critical for high-usage items and materials with long lead times.',
    `shelf_life_days` STRING COMMENT 'Number of days the material remains usable after receipt or production. Critical for Food and Beverage (F&B) ingredients, guest amenities, and pharmaceutical supplies. Drives First-Expired-First-Out (FEFO) inventory rotation.',
    `short_description` STRING COMMENT 'Abbreviated description of the material for use in reports, purchase orders, and mobile applications where space is limited.',
    `standard_price` DECIMAL(18,2) COMMENT 'Standard cost or valuation price of the material in the base currency. Used for inventory valuation, budgeting, and variance analysis. Updated periodically based on procurement trends.',
    `storage_condition` STRING COMMENT 'Required environmental conditions for storing the material to maintain quality and safety. Determines warehouse zone assignment and handling procedures.. Valid values are `ambient|refrigerated|frozen|climate_controlled|dry|secure`',
    `sustainability_certified_flag` BOOLEAN COMMENT 'Indicates whether the material meets sustainability or environmental certification standards such as Fair Trade, Rainforest Alliance, organic, or eco-label certifications. Supports corporate social responsibility and guest experience programs.',
    `tax_classification` STRING COMMENT 'Tax category code for the material determining applicable sales tax, value-added tax (VAT), or goods and services tax (GST) rates. Varies by jurisdiction and material type.',
    `temperature_range_max` DECIMAL(18,2) COMMENT 'Maximum temperature in Celsius allowed for proper storage of temperature-sensitive materials. Exceeding this threshold may compromise quality or safety.',
    `temperature_range_min` DECIMAL(18,2) COMMENT 'Minimum temperature in Celsius required for proper storage of temperature-sensitive materials. Used for cold chain compliance and quality assurance.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Master catalog of all materials, supplies, and goods procured for hotel and resort operations. Covers procurement categories including F&B ingredients, housekeeping consumables, FF&E items, engineering spare parts, and guest amenities. Captures material number, description, base unit of measure, procurement category, storage conditions, shelf life, minimum stock level, reorder point, and SAP material type. Serves as the SSOT for procurable items across all properties.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`category` (
    `category_id` BIGINT COMMENT 'Unique identifier for the procurement category. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that created this procurement category record. Supports audit trail and accountability.',
    `category_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last modified this procurement category record. Supports change tracking and audit compliance.',
    `parent_category_id` BIGINT COMMENT 'Reference to the parent category in the hierarchical taxonomy. Null for top-level (L1) categories. Enables multi-level category drill-down for spend analytics.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Procurement categories enforce category-specific policies: ethical sourcing policies for food/beverage, sustainability policies for supplies, diversity vendor policies for services, data privacy polic',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this procurement category is currently active and available for purchase order creation. False for deprecated or discontinued categories.',
    `annual_spend_budget_amount` DECIMAL(18,2) COMMENT 'Planned annual procurement spend budget (in USD) for this category across all properties or at corporate level. Used for budget variance analysis and spend forecasting.',
    `approval_authority_level` STRING COMMENT 'Organizational level required to approve purchase orders in this category: property (hotel GM), regional (area VP), corporate (CPO), or executive (CFO/CEO for high-value CapEx).. Valid values are `property|regional|corporate|executive`',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum purchase order value (in USD) that can be approved at the defined authority level. Orders exceeding this amount require escalation to higher approval authority.',
    `benchmarking_enabled_flag` BOOLEAN COMMENT 'Indicates whether spend in this category is benchmarked against industry standards (STR reports) or peer properties for cost optimization and competitive analysis.',
    `bid_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum purchase order value (in USD) that triggers mandatory competitive bidding for this category. Null if no threshold applies or competitive bidding is always required.',
    `budget_tracking_flag` BOOLEAN COMMENT 'Indicates whether spend in this category is tracked against annual budgets with variance reporting and budget consumption alerts. True for budget-controlled categories.',
    `category_code` STRING COMMENT 'Unique alphanumeric code identifying the procurement category for external reference and system integration. Used in SAP S/4HANA MM module for material group classification.. Valid values are `^[A-Z0-9]{4,12}$`',
    `category_description` STRING COMMENT 'Detailed description of the procurement category scope, including types of goods and services covered, typical use cases, and business context.',
    `category_level` STRING COMMENT 'Hierarchical level of the category in the taxonomy (1=top level such as F&B or FF&E, 2=sub-category, 3=detailed sub-category). Supports hierarchical spend rollup and analysis.',
    `category_name` STRING COMMENT 'Full business name of the procurement category (e.g., Food and Beverage Supplies, Housekeeping Linens, Furniture Fixtures and Equipment).',
    `category_type` STRING COMMENT 'Classification of procurement category by spend type: direct (guest-facing goods), indirect (operational supplies), capital (FF&E and CapEx), or services (contracted labor and professional services).. Valid values are `direct|indirect|capital|services`',
    `competitive_bid_required_flag` BOOLEAN COMMENT 'Indicates whether purchases in this category require competitive bidding process (RFP/RFQ) per procurement policy. True if competitive bidding is mandatory.',
    `compliance_framework` STRING COMMENT 'Specific regulatory or industry compliance framework applicable to this category (e.g., ISO 22000 for food safety, OSHA for workplace safety equipment, ADA for accessibility fixtures, PCI DSS for payment systems).',
    `contract_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether purchases in this category must comply with master service agreements or corporate contracts. True if contract compliance tracking is mandatory.',
    `cost_allocation_method` STRING COMMENT 'Method for allocating procurement spend in this category to financial reporting structures: direct_charge (to specific department), allocated (distributed across properties), cost_center, or profit_center per USALI standards.. Valid values are `direct_charge|allocated|cost_center|profit_center`',
    `cpor_tracking_flag` BOOLEAN COMMENT 'Indicates whether this category is included in CPOR (Cost Per Occupied Room) analysis for operational efficiency benchmarking. True for categories that scale with occupancy (housekeeping, guest amenities).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement category record was first created in the system. Supports audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date when this procurement category was retired or discontinued. Null for currently active categories. Used for historical spend analysis and category lifecycle tracking.',
    `effective_start_date` DATE COMMENT 'Date when this procurement category became active and available for use in the procurement system. Supports category lifecycle management and historical analysis.',
    `emergency_procurement_allowed_flag` BOOLEAN COMMENT 'Indicates whether expedited emergency procurement procedures (bypassing standard approval workflows) are permitted for this category in urgent operational situations.',
    `inventory_managed_flag` BOOLEAN COMMENT 'Indicates whether items in this category are tracked in property inventory systems with stock levels, reorder points, and inventory valuation. True for stocked items (F&B, housekeeping supplies).',
    `lead_time_days` STRING COMMENT 'Typical lead time in days from purchase order placement to goods receipt for this category. Used for inventory planning and procurement scheduling.',
    `minimum_vendor_count` STRING COMMENT 'Minimum number of qualified vendors that must be maintained for this category to ensure supply continuity and competitive pricing. Null if no minimum is defined.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement category record was last modified. Updated whenever any attribute changes. Supports change tracking and audit compliance.',
    `preferred_vendor_program_flag` BOOLEAN COMMENT 'Indicates whether this category participates in a preferred vendor program with pre-negotiated pricing, terms, and service level agreements. True if preferred vendor relationships are established.',
    `quality_certification_required_flag` BOOLEAN COMMENT 'Indicates whether vendors supplying this category must hold specific quality certifications (e.g., ISO 22000 for food safety, industry-specific quality standards).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this category is subject to specific regulatory compliance requirements (e.g., food safety regulations, fire safety codes, ADA accessibility standards for FF&E).',
    `risk_classification` STRING COMMENT 'Procurement risk level for this category based on supply chain volatility, vendor concentration, regulatory exposure, and business impact: low (commodity items), medium (standard supplies), high (specialized equipment), critical (guest-facing or safety-critical).. Valid values are `low|medium|high|critical`',
    `sourcing_strategy` STRING COMMENT 'Procurement approach defined for this category: strategic (long-term partnerships), preferred_vendor (pre-qualified suppliers), competitive_bid (RFP/RFQ process), spot_buy (ad-hoc purchases), or contract (master service agreements).. Valid values are `strategic|preferred_vendor|competitive_bid|spot_buy|contract`',
    `spend_classification` STRING COMMENT 'Financial classification indicating whether spend in this category is treated as operating expenditure (OpEx) or capital expenditure (CapEx) for accounting and budgeting purposes.. Valid values are `opex|capex`',
    `sustainability_criteria_flag` BOOLEAN COMMENT 'Indicates whether this category has defined sustainability or environmental compliance requirements for vendor selection and product sourcing (e.g., eco-friendly cleaning supplies, sustainable seafood).',
    `tax_treatment_code` STRING COMMENT 'Tax classification for purchases in this category: taxable (standard VAT/sales tax), exempt (tax-exempt goods), zero_rated (0% tax rate), or reverse_charge (buyer remits tax). Varies by jurisdiction.. Valid values are `taxable|exempt|zero_rated|reverse_charge`',
    `usali_department_code` STRING COMMENT 'USALI standard department code for financial reporting and cost allocation (e.g., ROOMS for rooms division, F&B for food and beverage, A&G for administrative and general).. Valid values are `^[A-Z0-9]{2,6}$`',
    `vendor_diversification_required_flag` BOOLEAN COMMENT 'Indicates whether procurement policy requires multiple qualified vendors for this category to mitigate supply chain risk and ensure competitive pricing. True for high-risk or high-spend categories.',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Hierarchical classification taxonomy for procurement spend categories across hotel and resort operations. Defines category hierarchy (L1: F&B, Housekeeping, FF&E, Engineering, IT; L2+ sub-categories), category manager assignment, preferred vendor associations, sourcing strategy, and competitive bidding thresholds. Supports spend analytics, category management, strategic sourcing decisions, and CPOR (Cost Per Occupied Room) analysis by category.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` (
    `request_for_quotation_id` BIGINT COMMENT 'Primary key for request_for_quotation',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or executive who approved the issuance of this RFQ.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor selected as the winner of this RFQ, if award decision has been made.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: RFQs are organized by procurement category for strategic sourcing and category management. FK enables category-specific sourcing strategies, bid thresholds, and vendor qualification rules.',
    `primary_request_employee_id` BIGINT COMMENT 'Identifier of the procurement professional or buyer responsible for managing this RFQ.',
    `property_id` BIGINT COMMENT 'Identifier of the property or corporate entity issuing the RFQ.',
    `award_criteria` STRING COMMENT 'Primary basis for vendor selection and contract award. Lowest price awards to the vendor with the lowest compliant bid, best value considers price and non-price factors, technical merit prioritizes quality and capability, multi-vendor award splits the business among multiple qualified vendors.. Valid values are `lowest_price|best_value|technical_merit|multi_vendor_award`',
    `award_decision_date` DATE COMMENT 'Date when the final vendor selection and award decision was made.',
    `awarded_contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the contract awarded as a result of this RFQ.',
    `awarded_timestamp` TIMESTAMP COMMENT 'Timestamp when the award decision was finalized and the winning vendor was officially notified.',
    `capex_opex_flag` STRING COMMENT 'Indicates whether this procurement is classified as Capital Expenditure (CapEx) for long-term assets and Property Improvement Plan (PIP) projects, or Operating Expenditure (OpEx) for day-to-day operational supplies and services.. Valid values are `capex|opex`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the RFQ response period officially closed and no further vendor submissions are accepted.',
    `contract_term_months` STRING COMMENT 'Duration of the resulting contract in months, if the RFQ leads to a long-term supply agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RFQ record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this RFQ (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_end_date` DATE COMMENT 'Latest date by which delivery or service completion must occur.',
    `delivery_location` STRING COMMENT 'Physical address or property location where goods or services must be delivered.',
    `delivery_start_date` DATE COMMENT 'Earliest date when delivery or service commencement is required.',
    `estimated_annual_spend_amount` DECIMAL(18,2) COMMENT 'Projected total annual expenditure for the goods or services covered by this RFQ, used for vendor evaluation and contract sizing.',
    `estimated_quantity` DECIMAL(18,2) COMMENT 'Anticipated volume or quantity of goods or services to be procured, expressed in the unit of measure specified.',
    `evaluation_criteria` STRING COMMENT 'Detailed description of the criteria and methodology used to evaluate vendor responses, including weighting of price, quality, delivery, service, and other factors.',
    `event_type` STRING COMMENT 'Type of strategic sourcing event. RFQ (Request for Quotation) for price-focused procurement, RFP (Request for Proposal) for complex service procurement, reverse auction for competitive bidding, negotiation for direct vendor engagement, sealed bid for formal competitive procurement.. Valid values are `rfq|rfp|reverse_auction|negotiation|sealed_bid`',
    `issue_date` DATE COMMENT 'Date when the RFQ was officially issued to participating vendors.',
    `issued_timestamp` TIMESTAMP COMMENT 'Timestamp when the RFQ was officially issued to vendors, marking the start of the response period.',
    `minority_vendor_preference_flag` BOOLEAN COMMENT 'Indicates whether this RFQ includes preference or set-aside provisions for minority-owned, women-owned, or disadvantaged business enterprises.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this RFQ record was last modified.',
    `participating_vendor_count` STRING COMMENT 'Number of vendors invited to participate in this RFQ event.',
    `payment_terms` STRING COMMENT 'Specified payment terms for the resulting contract, such as Net 30, Net 60, or early payment discount terms (e.g., 2/10 Net 30).',
    `pip_project_flag` BOOLEAN COMMENT 'Indicates whether this RFQ is associated with a Property Improvement Plan (PIP) project for capital improvements, renovations, or major upgrades.',
    `response_deadline_date` DATE COMMENT 'Final date by which vendors must submit their quotations or proposals.',
    `response_deadline_time` TIMESTAMP COMMENT 'Precise timestamp by which vendor responses must be received, including time zone.',
    `response_received_count` STRING COMMENT 'Number of vendor responses actually received by the response deadline.',
    `rfq_description` STRING COMMENT 'Detailed narrative description of the goods or services being sourced, including specifications, quality requirements, and any special conditions.',
    `rfq_number` STRING COMMENT 'Business-facing unique identifier for the RFQ event, typically generated by the procurement system and shared with vendors.',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ. Draft indicates preparation phase, issued means sent to vendors, open indicates active response period, closed means response deadline passed, awarded indicates vendor selection completed, cancelled indicates RFQ withdrawn.. Valid values are `draft|issued|open|closed|awarded|cancelled`',
    `sustainability_requirement_flag` BOOLEAN COMMENT 'Indicates whether this RFQ includes mandatory sustainability, environmental, or green procurement requirements that vendors must meet.',
    `terms_and_conditions` STRING COMMENT 'Legal and commercial terms and conditions that will govern the resulting contract, including payment terms, warranties, liability, and dispute resolution.',
    `unit_of_measure` STRING COMMENT 'Standard unit used to quantify the goods or services (e.g., each, case, kilogram, liter, hour, room night).',
    CONSTRAINT pk_request_for_quotation PRIMARY KEY(`request_for_quotation_id`)
) COMMENT 'Request for Quotation and strategic sourcing events issued to multiple vendors to solicit competitive pricing for goods and services. Captures RFQ/event number, issue date, response deadline, event type (RFQ, RFP, reverse auction, negotiation), procurement category, estimated quantity/annual spend, delivery requirements, evaluation criteria and methodology, award criteria, participating vendor list, and outcome/award decision. Supports competitive sourcing, vendor selection, category management, strategic sourcing governance, and contract negotiation workflows. Sourced from SAP S/4HANA MM RFQ (ME41).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` (
    `vendor_quotation_id` BIGINT COMMENT 'Unique identifier for the vendor quotation record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Vendor quotations are classified by procurement category for evaluation and comparison. FK enables category-specific evaluation criteria and price benchmarking.',
    `employee_id` BIGINT COMMENT 'Identifier of the procurement professional or buyer responsible for evaluating this quotation. Links to employee or user master data.',
    `property_id` BIGINT COMMENT 'Identifier of the property or hotel location for which this quotation applies. Supports multi-property procurement operations.',
    `request_for_quotation_id` BIGINT COMMENT 'Reference to the RFQ document that this quotation responds to. Links quotation to the originating procurement request.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor submitting this quotation. Links to vendor master data for supplier information.',
    `award_decision_date` DATE COMMENT 'Date when the final award decision was made for this quotation. Null if quotation is still under evaluation or was not awarded.',
    `award_recommendation_flag` BOOLEAN COMMENT 'Indicates whether the procurement team recommends awarding the purchase order to this vendor based on quotation evaluation. True signals recommended vendor for award.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quotation record was first created in the system. Audit trail for data lineage and record creation tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quoted prices. Supports multi-currency procurement operations across global properties.. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Number of days required by the vendor to deliver the goods or services after purchase order placement. Critical factor in vendor selection for time-sensitive procurement.',
    `delivery_location` STRING COMMENT 'Specified delivery location or address for the quoted goods. May reference property receiving dock, central warehouse, or other designated delivery point.',
    `evaluated_timestamp` TIMESTAMP COMMENT 'Timestamp when the quotation evaluation was completed and vendor score was finalized. Key milestone in the procurement decision timeline.',
    `evaluation_notes` STRING COMMENT 'Free-text notes and comments from the procurement evaluator regarding this quotation. Captures qualitative assessment factors and decision rationale.',
    `incoterms` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk between vendor and buyer. Examples: FOB, CIF, DDP, EXW.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the vendor to honor the quoted price. Important constraint for procurement planning and vendor selection.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this quotation record was last modified. Tracks updates to evaluation status, scores, or other quotation attributes.',
    `payment_terms` STRING COMMENT 'Payment terms offered by the vendor. Includes net payment period, early payment discounts, and other financial conditions. Examples: Net 30, 2/10 Net 30, Net 60.',
    `price_competitiveness_rating` STRING COMMENT 'Qualitative assessment of how competitive the quoted price is compared to market benchmarks and other vendor quotations for the same RFQ.. Valid values are `excellent|good|fair|poor`',
    `quotation_document_url` STRING COMMENT 'URL or file path to the original quotation document submitted by the vendor. Links to document management system for audit trail and reference.',
    `quotation_number` STRING COMMENT 'Business identifier for the vendor quotation. Externally visible reference number used in vendor communications and procurement documentation.',
    `quotation_received_date` DATE COMMENT 'Date when the vendor quotation was received by the procurement team. Key timestamp for tracking vendor responsiveness and evaluation timelines.',
    `quotation_status` STRING COMMENT 'Current lifecycle status of the vendor quotation in the procurement evaluation workflow. Tracks progression from receipt through award or rejection decision.. Valid values are `received|under_evaluation|awarded|rejected|expired|withdrawn`',
    `quotation_valid_from_date` DATE COMMENT 'Start date of the quotation validity period. Defines when the quoted prices and terms become effective.',
    `quotation_valid_to_date` DATE COMMENT 'End date of the quotation validity period. After this date, the vendor is not obligated to honor the quoted prices and terms.',
    `quoted_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods or services that the vendor is quoting for. May differ from the RFQ requested quantity if vendor proposes alternative volumes.',
    `quoted_total_amount` DECIMAL(18,2) COMMENT 'Total amount quoted by the vendor for the entire order quantity. Calculated as unit price multiplied by quantity, may include volume discounts.',
    `quoted_unit_price` DECIMAL(18,2) COMMENT 'Price per unit quoted by the vendor for the requested item or service. Base price before taxes, discounts, or additional charges.',
    `rejection_reason` STRING COMMENT 'Explanation for why the quotation was rejected if status is rejected. Includes reasons such as non-competitive pricing, specification non-compliance, unacceptable terms, or vendor performance concerns.',
    `specification_compliance_flag` BOOLEAN COMMENT 'Indicates whether the vendor quotation fully complies with the RFQ specifications. False indicates deviations or exceptions that require evaluation.',
    `specification_deviation_notes` STRING COMMENT 'Detailed description of any deviations from the RFQ specifications proposed by the vendor. Includes alternative materials, quality grades, packaging, or service levels.',
    `sustainability_compliance_flag` BOOLEAN COMMENT 'Indicates whether the quoted products or vendor practices meet the organizations sustainability and environmental standards. Increasingly important factor in vendor selection.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quoted quantity and pricing. Examples include each, case, kilogram, liter, square meter, hour.',
    `vendor_contact_email` STRING COMMENT 'Email address of the vendor contact for this quotation. Used for quotation clarifications and award notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the vendor representative who submitted or is responsible for this quotation. Business contact information for quotation clarifications.',
    `vendor_contact_phone` STRING COMMENT 'Phone number of the vendor contact for this quotation. Business contact information for urgent procurement communications.',
    `vendor_score` DECIMAL(18,2) COMMENT 'Composite evaluation score assigned to this quotation based on price, quality, delivery terms, vendor performance history, and other selection criteria. Used for vendor comparison and award decisions.',
    `warranty_terms` STRING COMMENT 'Warranty or guarantee terms offered by the vendor for the quoted goods or services. Particularly relevant for FF&E and equipment procurement.',
    CONSTRAINT pk_vendor_quotation PRIMARY KEY(`vendor_quotation_id`)
) COMMENT 'Vendor responses to RFQs capturing quoted unit prices, delivery lead times, validity period, payment terms, and any deviations from specifications. Supports price comparison, vendor selection scoring, and award decisions. Tracks quotation status (received, under evaluation, awarded, rejected). Sourced from SAP S/4HANA MM quotation (ME47/ME48).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` (
    `purchase_return_id` BIGINT COMMENT 'Unique identifier for the purchase return record. Primary key for the purchase return entity.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Purchase returns are tracked by procurement category for quality analytics and vendor performance. FK enables category-specific return rate KPIs and root cause analysis.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Purchase returns reference the original goods receipt being returned. The string column goods_receipt_document_number should be normalized to FK for return-to-receipt traceability and three-way match ',
    `employee_id` BIGINT COMMENT 'Identifier of the quality inspector who performed the inspection that resulted in the return decision.',
    `primary_purchase_employee_id` BIGINT COMMENT 'Identifier of the property staff member who initiated the return (e.g., receiving clerk, F&B manager, housekeeping supervisor).',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property initiating the return.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the original purchase order from which goods are being returned.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor to whom goods are being returned.',
    `ap_credit_posted_flag` BOOLEAN COMMENT 'Indicates whether the vendor credit has been posted to accounts payable, reducing the amount owed to vendor.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier handling the return shipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase return record was first created in the system.',
    `credit_memo_amount` DECIMAL(18,2) COMMENT 'Actual credit amount issued by vendor, which may differ from return value due to restocking fees, return shipping charges, or partial credit decisions.',
    `credit_memo_date` DATE COMMENT 'Date when vendor issued the credit memo for the returned goods.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the return value amount.. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'Expiration or best-before date of the returned material, particularly relevant for F&B perishable goods returns.',
    `inspection_date` DATE COMMENT 'Date when quality inspection was performed that identified the defect or issue requiring return.',
    `inventory_adjustment_posted_flag` BOOLEAN COMMENT 'Indicates whether the inventory adjustment for the return has been posted in SAP MM, reducing on-hand stock.',
    `material_code` STRING COMMENT 'SAP material master code for the item being returned. Identifies the specific product, supply, or FF&E item.. Valid values are `^[A-Z0-9]{6,18}$`',
    `material_description` STRING COMMENT 'Human-readable description of the material being returned.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase return record was last modified.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, special handling instructions, or communication history related to the return.',
    `perishable_item_flag` BOOLEAN COMMENT 'Indicates whether the returned item is a perishable good (critical for F&B operations). Perishable returns require expedited processing and food safety compliance documentation.',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether returned goods were placed on quality hold status prior to return, preventing use in operations.',
    `quality_inspection_result` STRING COMMENT 'Outcome of quality inspection that triggered the return. Documents the specific quality failure or defect identified during receiving inspection.. Valid values are `failed|rejected|non_conforming|damaged|expired|not_inspected`',
    `resolution_status` STRING COMMENT 'Status of the return resolution process with vendor, tracking whether credit has been received and case is closed.. Valid values are `pending|resolved|partial_credit|disputed|closed`',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by vendor for processing the return, deducted from credit memo amount.',
    `return_authorization_number` STRING COMMENT 'Return Merchandise Authorization (RMA) number or similar authorization code provided by vendor to approve the return.',
    `return_date` DATE COMMENT 'Date when the return was initiated or goods were shipped back to vendor. Principal business event timestamp for the return transaction.',
    `return_document_number` STRING COMMENT 'Business document number for the return delivery in SAP MM (movement type 122). Externally visible identifier for tracking and audit.. Valid values are `^[A-Z0-9]{10,20}$`',
    `return_quantity` DECIMAL(18,2) COMMENT 'Quantity of material being returned to vendor, expressed in the materials base unit of measure.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for returning goods to vendor. Critical for vendor performance tracking and quality management.. Valid values are `quality_defect|damaged_goods|incorrect_item|over_delivery|expired_perishable|specification_mismatch`',
    `return_reason_description` STRING COMMENT 'Detailed explanation of why goods are being returned, including specific quality issues, damage details, or discrepancies identified during receiving inspection.',
    `return_shipment_tracking_number` STRING COMMENT 'Carrier tracking number for the return shipment to vendor. Enables logistics tracking and proof of delivery to vendor.',
    `return_shipping_cost` DECIMAL(18,2) COMMENT 'Cost incurred for shipping goods back to vendor. May be absorbed by property or charged back to vendor depending on return reason and contract terms.',
    `return_status` STRING COMMENT 'Current lifecycle status of the purchase return. Tracks workflow from initiation through vendor credit processing. [ENUM-REF-CANDIDATE: draft|submitted|approved|shipped|received_by_vendor|credited|cancelled — 7 candidates stripped; promote to reference product]',
    `return_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the returned goods in the propertys local currency. Basis for vendor credit memo and AP adjustment.',
    `shipped_date` DATE COMMENT 'Date when returned goods were shipped back to vendor.',
    `storage_location_code` STRING COMMENT 'SAP storage location code from which goods were returned (e.g., main warehouse, F&B storeroom, housekeeping storage).. Valid values are `^[A-Z0-9]{4,10}$`',
    `unit_of_measure` STRING COMMENT 'Unit in which return quantity is expressed (e.g., EA for each, KG for kilogram, CS for case). ISO standard unit codes.. Valid values are `^[A-Z]{2,3}$`',
    `vendor_acknowledgement_date` DATE COMMENT 'Date when vendor acknowledged receipt of the return request and agreed to accept returned goods.',
    `vendor_credit_memo_number` STRING COMMENT 'Reference number of the credit memo issued by vendor acknowledging the return and credit to be applied. Links return to AP credit processing.',
    CONSTRAINT pk_purchase_return PRIMARY KEY(`purchase_return_id`)
) COMMENT 'Records of goods returned to vendors due to quality rejection, over-delivery, damaged items, incorrect shipments, or perishable goods expiry (critical for F&B operations) at hotel and resort properties. Captures return reason, material, quantity returned, return value, vendor credit memo reference, return shipment tracking, inspection results, quality hold status, and resolution status. Supports quality management, vendor performance tracking (defect rates), AP credit processing, inventory adjustment, and food safety compliance for perishable returns. Sourced from SAP S/4HANA MM return delivery (MIGO movement type 122).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` (
    `vendor_certification_id` BIGINT COMMENT 'Unique identifier for the vendor certification record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Vendor certifications are scoped to specific procurement categories (e.g., food safety for F&B, sustainability for housekeeping supplies). FK enables category-specific compliance gates and certificati',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the most recent verification of this certification. Supports accountability and audit trail.',
    `property_id` BIGINT COMMENT 'Identifier of the property for which this vendor certification applies. Null if certification is enterprise-wide across all properties.',
    `tertiary_vendor_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who last modified this certification record. Supports accountability and audit trail.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor holding this certification. Links to the vendor master record in the procurement system.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the certification automatically renews upon expiration. True if the issuing body or vendor has set up automatic renewal.',
    `brand_standard_flag` BOOLEAN COMMENT 'Indicates whether this certification is required by brand standards or corporate policy. True if mandated by the hotel brand or corporate procurement policy.',
    `certification_name` STRING COMMENT 'Full name or title of the certification, license, or qualification (e.g., ISO 22000 Food Safety Management, HACCP Certification, MBE Minority Business Enterprise).',
    `certification_number` STRING COMMENT 'Unique certificate or license number issued by the certifying body. This is the externally-known identifier for the certification.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Indicates whether the certification is valid and in good standing.. Valid values are `active|expired|suspended|pending_verification|revoked|renewed`',
    `certification_subtype` STRING COMMENT 'Detailed subtype or specific standard within the certification type (e.g., ISO 22000, HACCP, Green Key, EarthCheck, MBE, WBE, LGBTBE). Provides granular classification.',
    `certification_type` STRING COMMENT 'Category of certification. Classifies the certification into major compliance domains relevant to hotel and resort procurement. [ENUM-REF-CANDIDATE: food_safety|insurance|business_license|diversity|sustainability|pci_compliance|quality_management|other — 8 candidates stripped; promote to reference product]',
    `compliance_gate_flag` BOOLEAN COMMENT 'Indicates whether this certification is a mandatory qualification gate for vendor approval. True if the vendor cannot be approved or transact without this certification.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Monetary coverage amount for insurance-related certifications (e.g., general liability coverage limit, workers compensation coverage). Null for non-insurance certifications.',
    `coverage_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the coverage amount (e.g., USD, CAD, EUR). Null for non-insurance certifications.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Supports audit trail and data lineage.',
    `document_url` STRING COMMENT 'URL or file path to the stored certification document, certificate image, or supporting documentation. Links to the document management system.',
    `esg_reporting_flag` BOOLEAN COMMENT 'Indicates whether this certification contributes to Environmental, Social, and Governance (ESG) reporting metrics. True for sustainability and diversity certifications.',
    `expiry_date` DATE COMMENT 'Date on which the certification expires and is no longer valid. Null for certifications with no expiration (perpetual licenses).',
    `issue_date` DATE COMMENT 'Date on which the certification was originally issued to the vendor. Represents the effective start of the certification validity.',
    `issuing_body` STRING COMMENT 'Name of the organization, agency, or authority that issued the certification (e.g., ISO, local health department, insurance carrier, diversity certification council).',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the jurisdiction where the certification was issued (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last modified. Tracks the most recent update to any field in the record.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next internal review or audit of this certification by procurement or compliance teams. Used for proactive monitoring.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the certification, including special conditions, exceptions, or additional context provided by the vendor or procurement team.',
    `renewal_date` DATE COMMENT 'Date on which the certification was last renewed. Tracks the most recent renewal event for multi-year certifications.',
    `renewal_notice_days` STRING COMMENT 'Number of days before expiration that a renewal notice or alert should be triggered. Used for proactive compliance monitoring.',
    `risk_level` STRING COMMENT 'Risk level associated with the absence or expiration of this certification. Critical for food safety and insurance; low for optional sustainability certifications.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Detailed description of the scope of the certification, including specific products, services, or activities covered. Clarifies what the certification qualifies the vendor to supply.',
    `verification_date` DATE COMMENT 'Date on which the certification was last verified by the procurement or compliance team. Tracks the most recent validation event.',
    `verification_method` STRING COMMENT 'Method used to verify the authenticity and validity of the certification. Supports audit trail and compliance documentation.. Valid values are `document_upload|third_party_verification|issuer_portal_check|manual_inspection|self_attestation`',
    CONSTRAINT pk_vendor_certification PRIMARY KEY(`vendor_certification_id`)
) COMMENT 'Compliance certifications and qualification records for vendors supplying hotel and resort properties. Includes food safety certifications (ISO 22000, HACCP, local health department permits), insurance certificates (general liability, workers comp), business licenses, diversity certifications (MBE, WBE, LGBTBE), sustainability certifications (Green Key, EarthCheck supplier), and PCI DSS compliance for payment-related vendors. Tracks certification type, issuing body, issue date, expiry date, renewal status, and verification method. Supports vendor qualification gates, compliance monitoring, risk management, brand standards enforcement, and ESG reporting requirements.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` (
    `procurement_enrollment_id` BIGINT COMMENT 'Primary key for procurement_enrollment',
    `benefit_plan_id` BIGINT COMMENT 'Foreign key linking to the benefit plan in which the employee is enrolling',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who is enrolling in the benefit plan',
    `beneficiary_name` STRING COMMENT 'Name of the primary beneficiary designated for this enrollment (applicable for life insurance and similar plans). Captured from detection phase relationship data.',
    `confirmation_number` STRING COMMENT 'Confirmation or transaction number issued when the enrollment was processed.',
    `coverage_tier` STRING COMMENT 'Level of coverage elected by the employee for this enrollment (employee only, employee + spouse, employee + children, family). Captured from detection phase relationship data.',
    `dependent_count` STRING COMMENT 'Number of dependents covered under this enrollment. Captured from detection phase relationship data.',
    `effective_end_date` DATE COMMENT 'Date when the benefit coverage ends for this enrollment. Null for active enrollments. Captured from detection phase relationship data.',
    `effective_start_date` DATE COMMENT 'Date when the benefit coverage begins for this enrollment. Captured from detection phase relationship data.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employee contributes per pay period for this specific enrollment. May differ from plan default based on coverage tier elected. Captured from detection phase relationship data.',
    `enrollment_code` BIGINT COMMENT 'Unique identifier for this enrollment record. Primary key for the enrollment association.',
    `enrollment_source` STRING COMMENT 'Classification of the event that triggered this enrollment (open enrollment, new hire, qualifying life event, annual renewal).',
    `life_event_date` DATE COMMENT 'Date of the qualifying life event. Null if not a life event enrollment.',
    `life_event_type` STRING COMMENT 'Type of qualifying life event that allowed mid-year enrollment change (marriage, birth, adoption, loss of other coverage). Null if not a life event enrollment.',
    `oracle_hcm_enrollment_code` STRING COMMENT 'External enrollment identifier from Oracle HCM Cloud Benefits module. Used for integration and reconciliation.',
    `procurement_enrollment_date` DATE COMMENT 'Date when the employee elected or enrolled in this benefit plan. Captured from detection phase relationship data.',
    `procurement_enrollment_status` STRING COMMENT 'Current lifecycle status of this enrollment record (pending, active, terminated, waived). Captured from detection phase relationship data.',
    `waived_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee explicitly waived this benefit plan. Captured from detection phase relationship data.',
    `waiver_reason` STRING COMMENT 'Reason code or description for why the employee waived this benefit plan (e.g., covered under spouse plan, cost, not needed). Captured from detection phase relationship data.',
    CONSTRAINT pk_procurement_enrollment PRIMARY KEY(`procurement_enrollment_id`)
) COMMENT 'This association product represents the enrollment event between employee and benefit_plan. It captures the employees election of a specific benefit plan, including coverage details, contribution amounts, dependent information, and enrollment lifecycle status. Each record links one employee to one benefit_plan with attributes that exist only in the context of this enrollment relationship. Supports ACA compliance reporting, open enrollment processing, life event changes, and total compensation analysis per USALI standards.. Existence Justification: Benefit enrollment is a core HR operational process where employees actively elect multiple benefit plans (health, dental, vision, 401k, life insurance) and each plan is elected by multiple employees. HR benefits teams manage enrollment campaigns, process elections, track coverage periods, calculate contributions, and produce regulatory reports (ACA 1095-C). The enrollment relationship has its own lifecycle (pending → active → terminated), business rules (eligibility, waiting periods, enrollment windows), and dedicated systems (Oracle HCM Cloud Benefits).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` (
    `procurement_supply_agreement_id` BIGINT COMMENT 'Primary key for procurement_supply_agreement',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material being supplied under this agreement',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor who supplies this material under this agreement',
    `agreement_end_date` DATE COMMENT 'Expiration or renewal date of this supply agreement. Null for evergreen agreements. Used to trigger contract renegotiation workflows.',
    `agreement_start_date` DATE COMMENT 'Effective start date of this supply agreement. Supports time-based pricing and contract lifecycle management.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of this supply agreement. Active agreements are available for procurement; Inactive/Expired agreements are historical.',
    `contract_reference_number` STRING COMMENT 'External reference to the master supply contract or purchase agreement governing this vendor-material relationship. Links to legal contract repository.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the negotiated unit price. May differ from vendors preferred currency or materials standard price currency.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order placed with this vendor for this material. Used to identify inactive supply relationships and trigger vendor performance reviews.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from this vendor for this material. Vendor-specific term that affects procurement batch sizing.',
    `negotiated_unit_price` DECIMAL(18,2) COMMENT 'The per-unit price negotiated with this specific vendor for this material. Varies by vendor-material combination and is central to sourcing decisions.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred source for this material based on price, quality, reliability, or strategic relationship. Used in automated sourcing logic.',
    `supply_agreement_code` BIGINT COMMENT 'Unique identifier for this vendor-material supply agreement record. Primary key.',
    `vendor_lead_time_days` STRING COMMENT 'Number of days from purchase order placement to goods receipt for this vendor-material combination. Vendor-specific and critical for inventory planning.',
    `vendor_material_number` STRING COMMENT 'The vendors own part number or SKU for this material. Used in purchase orders and receiving to ensure correct material identification in vendor systems.',
    CONSTRAINT pk_procurement_supply_agreement PRIMARY KEY(`procurement_supply_agreement_id`)
) COMMENT 'This association product represents the contractual supply relationship between a vendor and a material in the procurement catalog. It captures vendor-specific pricing, lead times, minimum order quantities, and sourcing preferences that exist only in the context of this vendor-material pairing. Each record links one vendor to one material with negotiated commercial terms.. Existence Justification: In hotel and resort procurement operations, materials are routinely multi-sourced from multiple vendors to mitigate supply risk, leverage competitive pricing, and ensure continuity of operations. Each vendor-material pairing has distinct commercial terms including negotiated unit prices, lead times, minimum order quantities, and contract references. The current models single vendor_id FK in material_master cannot represent this multi-sourcing reality.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` (
    `vendor_category_qualification_id` BIGINT COMMENT 'Unique identifier for this vendor-category qualification record. Primary key for the association.',
    `category_id` BIGINT COMMENT 'Foreign key linking to the procurement category. Identifies which category this vendor is qualified to supply.',
    `employee_id` BIGINT COMMENT 'Identifier of the procurement professional who created this vendor-category qualification record. Supports accountability and audit requirements.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor master record. Identifies which vendor holds this category qualification.',
    `annual_spend_actual` DECIMAL(18,2) COMMENT 'Actual annual procurement spend (in USD) with this vendor in this category. Used for vendor performance analysis and spend allocation optimization.',
    `category_performance_score` DECIMAL(18,2) COMMENT 'Vendor performance score specific to this procurement category, typically on a 0-100 scale. Reflects quality, delivery timeliness, pricing competitiveness, and compliance specific to this category. Performance varies by category for multi-category vendors. Identified in detection phase relationship data.',
    `certification_expiry_date` DATE COMMENT 'Expiration date of required certifications for this vendor-category qualification. Used to trigger recertification processes and maintain compliance.',
    `certification_required` STRING COMMENT 'Specific certifications or quality standards required for this vendor to supply this category (e.g., HACCP for food suppliers, LEED for sustainable FF&E vendors, ISO certifications for engineering contractors).',
    `contract_terms` STRING COMMENT 'Category-specific contract terms and conditions negotiated for this vendor-category pairing. May include volume commitments, pricing structures, delivery terms, or quality standards specific to this category. Identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor-category qualification record was created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this vendor-category qualification record. Supports change tracking and audit trail.',
    `last_review_date` DATE COMMENT 'Date of the most recent qualification review or performance assessment for this vendor-category pairing. Used to track periodic reassessment cycles. Identified in detection phase relationship data.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order placement to delivery for this vendor in this specific category. Lead times vary by category based on product complexity and supply chain characteristics.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum purchase order value (in USD) required by this vendor for orders in this category. Category-specific minimums may differ from vendor-wide terms.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next qualification review or performance assessment. Supports proactive vendor management and compliance with periodic review requirements.',
    `payment_terms_override` STRING COMMENT 'Category-specific payment terms that override the vendor master payment terms. Some categories may negotiate extended terms or early payment discounts based on category strategy.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor has preferred vendor status for this specific category. Preferred vendors receive priority consideration in sourcing decisions and may have streamlined approval processes. Identified in detection phase relationship data.',
    `qualification_date` DATE COMMENT 'Date when the vendor was initially qualified to supply goods or services in this procurement category. Identified in detection phase relationship data.',
    `qualification_notes` STRING COMMENT 'Free-text notes documenting qualification decisions, performance issues, or special considerations for this vendor-category relationship. Supports audit trail and knowledge transfer.',
    `qualification_status` STRING COMMENT 'Current qualification status of the vendor for this specific category. Values: qualified (approved to supply), pending (under evaluation), suspended (temporarily not approved), disqualified (rejected), under_review (periodic reassessment in progress). Identified in detection phase relationship data.',
    `spend_allocation_percentage` DECIMAL(18,2) COMMENT 'Target percentage of category spend allocated to this vendor as part of vendor panel optimization strategy. Used in multi-sourcing strategies to balance risk and leverage competition. Identified in detection phase relationship data.',
    CONSTRAINT pk_vendor_category_qualification PRIMARY KEY(`vendor_category_qualification_id`)
) COMMENT 'This association product represents the qualification and performance relationship between vendors and procurement categories in hotel and resort operations. It captures category-specific vendor qualifications, performance metrics, preferred vendor status, and contract terms that exist only in the context of a specific vendor-category pairing. Each record links one vendor to one procurement category with attributes that track qualification status, performance history, and category-specific commercial terms. This enables category management best practices including vendor panel optimization, category-specific sourcing strategies, and spend allocation decisions.. Existence Justification: In hotel and resort procurement operations, vendor category qualification is a genuine many-to-many operational relationship. A single vendor (e.g., Sysco) is qualified to supply multiple procurement categories (F&B supplies, housekeeping supplies, paper goods), and each procurement category has multiple qualified vendors forming a vendor panel. The business actively manages these qualifications with category-specific performance scores, preferred vendor designations, contract terms, and spend allocation strategies. This is not an analytical correlation but an operational business process where procurement teams create, review, and update vendor-category qualifications as part of strategic sourcing and category management.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` (
    `vendor_program_participation_id` BIGINT COMMENT 'Unique identifier for this vendor-program participation record. Primary key.',
    `experience_program_id` BIGINT COMMENT 'Foreign key to experience.experience_program.experience_program_id',
    `program_id` BIGINT COMMENT 'Foreign key linking to the experience program in which the vendor participates',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing services for this experience program',
    `capacity_limit` STRING COMMENT 'Maximum number of concurrent guests or service instances this vendor can support for this program. Null indicates no defined limit. Used for program enrollment capacity planning.',
    `contract_reference_number` STRING COMMENT 'Reference number of the legal contract or service agreement governing this vendors participation in this program. Links operational participation to legal agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor-program participation record was created in the system.',
    `fulfillment_responsibility_flag` BOOLEAN COMMENT 'Indicates whether this vendor has primary fulfillment responsibility for their service component within this program. True means the vendor is accountable for end-to-end delivery; false means they provide support services only.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review for this vendor-program participation. Used to track review cadence and ensure regular vendor performance management.',
    `minimum_notice_hours` STRING COMMENT 'Minimum number of hours advance notice required for this vendor to fulfill service requests under this program. Varies by program complexity and vendor capacity.',
    `participation_end_date` DATE COMMENT 'Date when the vendors participation in this experience program ends or ended. Null indicates ongoing participation. Critical for tracking vendor contract lifecycles per program.',
    `participation_start_date` DATE COMMENT 'Date when the vendor began participating in this experience program. Tracks the effective start of the vendors service delivery commitment for this specific program.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Current performance rating (0.00 to 5.00) for this vendors delivery of services within this specific program. Based on guest feedback, SLA compliance, and quality audits. Tracked per program because vendor performance may vary across different service types.',
    `pricing_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the program-specific pricing.',
    `program_specific_pricing` DECIMAL(18,2) COMMENT 'The negotiated price or rate for this vendors services within this specific experience program. Pricing varies by program based on volume, exclusivity, and service scope. Different from the vendors standard pricing.',
    `property_scope` STRING COMMENT 'Comma-separated list of property codes where this vendor provides services for this specific program. A vendor may serve different property sets for different programs based on geographic coverage and capacity.',
    `service_delivery_sla` STRING COMMENT 'Service level agreement terms specific to this vendor-program combination. Defines response times, quality standards, availability requirements, and performance metrics the vendor must meet for this program.',
    `updated_by` STRING COMMENT 'User ID or system identifier of who last updated this participation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor-program participation record was last updated.',
    `vendor_program_status` STRING COMMENT 'Current operational status of the vendors participation in this specific program. Tracks whether the vendor is actively delivering services, temporarily suspended, or no longer participating. Status is program-specific; a vendor may be active in some programs and suspended in others.',
    `vendor_role_in_program` STRING COMMENT 'The specific role or service type the vendor provides within this experience program. A vendor may have different roles across different programs (e.g., spa operator for wellness programs, transportation for adventure programs).',
    `created_by` STRING COMMENT 'User ID or system identifier of who created this participation record.',
    CONSTRAINT pk_vendor_program_participation PRIMARY KEY(`vendor_program_participation_id`)
) COMMENT 'This association product represents the Contract between vendor and experience_program. It captures the operational relationship where vendors deliver specific services as part of curated guest experience programs across hotel and resort properties. Each record links one vendor to one experience_program with attributes that define the vendors role, service delivery commitments, program-specific pricing, and fulfillment responsibilities that exist only in the context of this relationship.. Existence Justification: In travel hospitality operations, experience programs (spa packages, culinary experiences, adventure programs, wellness journeys) require coordination of multiple specialized vendors to deliver the complete guest experience. A single experience program involves multiple vendors (spa operator, restaurant partner, transportation provider, activity vendors), and each vendor participates in multiple programs across different properties and guest segments. The business actively manages these vendor-program relationships with program-specific pricing, SLAs, fulfillment responsibilities, and performance tracking.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` (
    `vendor_touchpoint_service_id` BIGINT COMMENT 'Unique identifier for this vendor-touchpoint service relationship. Primary key.',
    `touchpoint_id` BIGINT COMMENT 'Foreign key linking to the guest journey touchpoint being serviced',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing services at this touchpoint',
    `contract_reference_number` STRING COMMENT 'Reference to the master contract governing this vendor-touchpoint service relationship.',
    `cost_per_touchpoint_interaction` DECIMAL(18,2) COMMENT 'The negotiated cost per guest interaction at this touchpoint. Used for cost allocation and vendor performance analysis. Identified in detection phase.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review for this vendor at this touchpoint.',
    `quality_threshold_score` DECIMAL(18,2) COMMENT 'Minimum quality score the vendor must maintain for this touchpoint to remain in compliance. Identified in detection phase.',
    `response_time_minutes` STRING COMMENT 'Maximum response time in minutes the vendor must meet for this touchpoint (e.g., valet retrieval time, concierge callback time). Identified in detection phase.',
    `service_level_agreement` STRING COMMENT 'The SLA tier or contract terms governing vendor performance at this touchpoint. Identified in detection phase.',
    `service_status` STRING COMMENT 'Current operational status of this vendor-touchpoint service relationship.',
    `touchpoint_activation_date` DATE COMMENT 'The date this vendor began servicing this touchpoint. Used to track vendor tenure and historical performance. Identified in detection phase.',
    `touchpoint_deactivation_date` DATE COMMENT 'The date this vendor stopped servicing this touchpoint, if applicable. Supports historical tracking of vendor-touchpoint relationships.',
    `vendor_staff_certification_required_flag` BOOLEAN COMMENT 'Indicates whether vendor staff must hold specific certifications to deliver this touchpoint (e.g., sommelier certification for wine service touchpoint). Identified in detection phase.',
    `vendor_touchpoint_role` STRING COMMENT 'The role this vendor plays in delivering this touchpoint (e.g., primary valet provider, backup spa operator, seasonal transportation partner). Identified in detection phase.',
    CONSTRAINT pk_vendor_touchpoint_service PRIMARY KEY(`vendor_touchpoint_service_id`)
) COMMENT 'This association product represents the service contract between vendors and guest journey touchpoints. It captures vendor accountability for specific touchpoint delivery, including SLAs, quality thresholds, cost allocation, and certification requirements. Each record links one vendor to one touchpoint with attributes that exist only in the context of this service relationship.. Existence Justification: In hospitality operations, vendors provide services at multiple guest journey touchpoints (e.g., a valet vendor services arrival, departure, and concierge-requested retrieval touchpoints), and each touchpoint is typically supported by multiple vendors (e.g., check-in touchpoint involves housekeeping suppliers, technology vendors, and amenity providers). The business actively manages these vendor-touchpoint service relationships with specific SLAs, quality thresholds, cost structures, and certification requirements that vary by vendor-touchpoint combination.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` (
    `category_buyer_assignment_id` BIGINT COMMENT 'Unique identifier for the category buyer assignment record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to the procurement category being managed by the employee',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee (buyer/category manager) assigned to the procurement category',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment. Active assignments drive requisition routing. Inactive assignments are historical. Suspended assignments are temporarily paused (e.g., during leave).',
    `assignment_type` STRING COMMENT 'Classification of the buyers role in managing this category. Indicates whether the employee is the primary category manager, backup/secondary manager, specialist consultant, or temporary coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the buyers responsibility for this category ends. Null for currently active assignments. Used for tracking assignment history and transitions.',
    `effective_start_date` DATE COMMENT 'Date when the buyers responsibility for this category begins. Used for historical tracking of category ownership and determining active assignments.',
    `primary_backup_flag` BOOLEAN COMMENT 'Boolean indicator of whether this is a primary (true) or backup (false) assignment. Used for requisition routing logic to determine first-line responsibility.',
    `spend_authority_limit` DECIMAL(18,2) COMMENT 'Maximum purchase order value (in USD) that this buyer can approve for this category without escalation. Authority limits vary by buyer experience level and category risk profile.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was last modified.',
    `workload_percentage` DECIMAL(18,2) COMMENT 'Percentage of the buyers time allocated to managing this category. Used for workload balancing and capacity planning across the procurement team.',
    CONSTRAINT pk_category_buyer_assignment PRIMARY KEY(`category_buyer_assignment_id`)
) COMMENT 'This association product represents the assignment of procurement professionals (buyers/category managers) to procurement categories. It captures the buyer-category responsibility matrix that drives requisition routing, vendor relationship ownership, and spend authority. Each record links one employee to one procurement category with assignment-specific attributes including role type (primary/backup), effective dates, and spend authority limits.. Existence Justification: In hospitality procurement operations, category management follows a buyer assignment matrix where procurement professionals (buyers/category managers) are assigned responsibility for specific procurement categories. Each buyer manages multiple categories (e.g., one buyer handles Linens, Uniforms, and Housekeeping Supplies), and each category has both primary and backup buyers to ensure coverage. The business actively manages these assignments with effective dates, authority limits, and role types (primary/backup/specialist).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` (
    `procurement_therapist_certification_id` BIGINT COMMENT 'Primary key for procurement_therapist_certification',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the therapist employee record',
    `spa_therapist_certification_id` BIGINT COMMENT 'Unique identifier for this therapist-treatment certification record. Primary key for the association.',
    `treatment_id` BIGINT COMMENT 'Foreign key linking to the spa treatment record',
    `certification_date` DATE COMMENT 'Date when the therapist was certified to perform this specific treatment. Used for compliance tracking and recertification scheduling.',
    `certification_status` STRING COMMENT 'Current lifecycle status of this certification. Controls whether the therapist can be scheduled for this treatment. Values: ACTIVE, EXPIRED, SUSPENDED, PENDING_RENEWAL.',
    `expiration_date` DATE COMMENT 'Date when this certification expires and requires renewal. Null for certifications without expiration. Used for proactive recertification scheduling.',
    `last_performed_date` DATE COMMENT 'Most recent date the therapist performed this treatment on a guest. Used to identify skill currency and trigger refresher training requirements.',
    `notes` STRING COMMENT 'Free-text notes about this therapists certification for this treatment, including special techniques, limitations, or guest feedback themes.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Average guest satisfaction or quality rating for this therapist performing this specific treatment. Used for scheduling premium treatments to top-rated therapists and identifying coaching opportunities.',
    `preferred_for_treatment_flag` BOOLEAN COMMENT 'Indicates whether this therapist is designated as a preferred or specialist provider for this treatment. Used for VIP guest scheduling and premium service delivery.',
    `proficiency_level` STRING COMMENT 'Current skill proficiency level of the therapist for this specific treatment. Used for scheduling optimization, quality assurance, and identifying training needs. Values: TRAINEE, COMPETENT, PROFICIENT, EXPERT.',
    `training_hours` DECIMAL(18,2) COMMENT 'Total hours of training completed by the therapist for this specific treatment. Used for compliance documentation and professional development tracking.',
    `treatments_performed_count` STRING COMMENT 'Total number of times this therapist has performed this specific treatment. Used for experience tracking and proficiency assessment.',
    CONSTRAINT pk_procurement_therapist_certification PRIMARY KEY(`procurement_therapist_certification_id`)
) COMMENT 'This association product represents the certification and competency relationship between spa therapists (employees) and treatments they are qualified to perform. It captures the operational reality that therapists must be certified for specific treatments, and the business actively manages certification status, proficiency levels, training requirements, and performance quality for scheduling, compliance, and quality assurance. Each record links one therapist to one treatment with attributes that exist only in the context of this certification relationship.. Existence Justification: In spa operations, therapists must be certified to perform specific treatments, and each treatment can be performed by multiple certified therapists. The business actively manages this many-to-many relationship through certification programs, proficiency assessments, and performance tracking. Spa managers use this data for scheduling optimization (matching guest requests to qualified therapists), compliance verification (ensuring minimum certification requirements are met), and quality assurance (tracking performance ratings per therapist-treatment combination).';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` (
    `program_assignment_id` BIGINT COMMENT 'Unique identifier for this employee-program assignment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to deliver this experience program',
    `program_id` BIGINT COMMENT 'Foreign key linking to the experience program being delivered',
    `assignment_end_date` DATE COMMENT 'Date when the employees assignment to this experience program ended. Null indicates an active ongoing assignment. This attribute was explicitly identified in the detection phase as relationship data.',
    `assignment_start_date` DATE COMMENT 'Date when the employee began their assignment to this experience program. This attribute was explicitly identified in the detection phase as relationship data.',
    `assignment_status` STRING COMMENT 'Current status of this assignment indicating whether the employee is actively delivering this program or temporarily unavailable.',
    `certification_required` STRING COMMENT 'Specific certification or qualification required for the employee to fulfill this role in this program (e.g., Certified Sommelier for culinary programs, Certified Yoga Instructor for wellness programs). This attribute was explicitly identified in the detection phase as relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was created in the system.',
    `responsibility_level` STRING COMMENT 'Level of responsibility the employee has for this program (e.g., primary, secondary, backup, trainee). This attribute was explicitly identified in the detection phase as relationship data.',
    `role_in_program` STRING COMMENT 'The specific role the employee performs within this experience program (e.g., coordinator, instructor, concierge, specialist). This attribute was explicitly identified in the detection phase as relationship data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last updated.',
    CONSTRAINT pk_program_assignment PRIMARY KEY(`program_assignment_id`)
) COMMENT 'This association product represents the Assignment between employee and experience_program. It captures the operational assignment of hotel staff to curated guest experience programs in specific roles. Each record links one employee to one experience_program with attributes that exist only in the context of this assignment relationship, including role, assignment dates, responsibility level, and required certifications.. Existence Justification: In hotel and resort operations, experience programs (wellness retreats, culinary experiences, spa packages) require multiple staff members in different roles to deliver the guest experience - a wellness program needs coordinators, instructors, and concierges working together. Simultaneously, employees participate in multiple programs across their tenure based on their skills and certifications. The business actively manages these assignments with specific roles, dates, responsibility levels, and certification requirements for scheduling, compliance, and quality delivery.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` (
    `requisition_line_id` BIGINT COMMENT 'Primary key for requisition_line',
    `approved_by_employee_id` BIGINT COMMENT 'Reference to the employee or manager who approved this requisition line. Used for audit trail and accountability.',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the supplier contract or purchasing agreement governing this requisition line. Used for contract compliance tracking and pricing validation.',
    `delivery_address_id` BIGINT COMMENT 'Reference to the specific delivery address or receiving location within the property. May differ from the property main address for large resorts with multiple receiving points.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who created this requisition line item. Used for accountability and communication.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or product being requisitioned. Links to master material catalog for F&B supplies, housekeeping items, FF&E (Furniture, Fixtures, and Equipment), or other procurement categories.',
    `project_id` BIGINT COMMENT 'Reference to the capital project or Property Improvement Plan (PIP) project if this requisition line is part of a specific project initiative. Applicable primarily for CapEx procurement.',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or vacation property location where the requisitioned items will be delivered and used.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that was created from this requisition line. Populated after the requisition is converted to a purchase order.',
    `purchase_requisition_id` BIGINT COMMENT 'Reference to the parent purchase requisition header that contains this line item.',
    `vendor_id` BIGINT COMMENT 'Reference to the preferred or suggested vendor/supplier for this requisition line. May be pre-populated from contract or sourcing agreements.',
    `split_from_requisition_line_id` BIGINT COMMENT 'Self-referencing FK on requisition_line (split_from_requisition_line_id)',
    `approval_status` STRING COMMENT 'Current approval workflow status for this requisition line. Tracks whether the line has been reviewed and approved by authorized approvers.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this requisition line was approved. Used for approval cycle time analytics and audit compliance.',
    `cost_center_code` STRING COMMENT 'Financial accounting cost center code to which this requisition line expenditure will be charged. Used for departmental budget tracking and spend allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this requisition line record was first created in the system. Used for audit trail and requisition cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line item pricing and amounts.',
    `delivery_date` DATE COMMENT 'Date by which the requisitioned material or service is needed at the delivery location. Critical for operational planning and vendor performance tracking.',
    `department_code` STRING COMMENT 'Organizational department code of the requesting unit (e.g., Front Office, Housekeeping, F&B, Engineering). Used for departmental spend analysis.',
    `expenditure_type` STRING COMMENT 'Classification of the expenditure as Operating Expense (OpEx) for day-to-day operations or Capital Expenditure (CapEx) for Property Improvement Plan (PIP) projects and long-term assets.',
    `external_reference_number` STRING COMMENT 'External reference or tracking number from the source system or vendor. Used for cross-system reconciliation and vendor communication.',
    `general_ledger_account` STRING COMMENT 'General ledger account code for financial posting of this requisition line. Determines the expense category (OpEx vs CapEx) and financial statement classification.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of goods received against this requisition line. Used to track fulfillment progress and identify partial deliveries.',
    `is_deleted` BOOLEAN COMMENT 'Logical deletion flag indicating whether this requisition line has been soft-deleted. Used for data retention and audit compliance without physical deletion.',
    `line_number` STRING COMMENT 'Sequential line item number within the parent requisition, used for ordering and reference.',
    `line_status` STRING COMMENT 'Current lifecycle status of the requisition line item. Tracks progression from creation through approval, ordering, and receipt.',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value for this requisition line, calculated as quantity multiplied by unit price. Represents the estimated spend for this line item.',
    `material_description` STRING COMMENT 'Textual description of the material or service being requisitioned. Provides human-readable context for the line item.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this requisition line record was last updated. Used for change tracking and data quality monitoring.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity yet to be received for this requisition line. Calculated as requisitioned quantity minus goods receipt quantity.',
    `priority_level` STRING COMMENT 'Business priority classification for this requisition line. Urgent and high-priority items may receive expedited approval and processing.',
    `procurement_category` STRING COMMENT 'High-level classification of the procurement spend category. Used for spend analytics, category management, and strategic sourcing initiatives.',
    `purchase_order_line_number` STRING COMMENT 'Line number on the purchase order that corresponds to this requisition line. Used for traceability between requisition and purchase order.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service units being requested in this line item.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver if this requisition line was rejected. Used for feedback to requester and process improvement.',
    `source_system_code` STRING COMMENT 'Identifier of the originating system that created this requisition line (e.g., SAP, Oracle, property management system). Used for data lineage and integration tracking.',
    `special_instructions` STRING COMMENT 'Free-text field for additional delivery instructions, handling requirements, or special notes for the vendor or receiving department.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Estimated tax amount for this requisition line based on the applicable tax code and line total amount.',
    `tax_code` STRING COMMENT 'Tax jurisdiction code applicable to this requisition line. Determines sales tax, VAT, or GST calculation based on delivery location and material type.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the requisitioned quantity (e.g., Each, Case, Box, Pound, Kilogram, Gallon, Liter, Dozen, Pair, Set, Hour, Day, Week, Month).',
    `unit_price` DECIMAL(18,2) COMMENT 'Estimated or contracted price per unit of measure for the material or service. Used for budget estimation and spend analytics.',
    CONSTRAINT pk_requisition_line PRIMARY KEY(`requisition_line_id`)
) COMMENT 'Master reference table for requisition_line. Referenced by requisition_line_id.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`payroll_period` (
    `payroll_period_id` BIGINT COMMENT 'Primary key for payroll_period',
    `ownership_entity_id` BIGINT COMMENT 'Reference to the legal entity or company for which this payroll period applies.',
    `prior_payroll_period_id` BIGINT COMMENT 'Self-referencing FK on payroll_period (prior_payroll_period_id)',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this payroll period requires managerial or executive approval before payment processing (true/false).',
    `approved_by_user_code` STRING COMMENT 'Identifier of the user who approved this payroll period for payment.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period was approved for payment.',
    `calendar_month` STRING COMMENT 'The calendar month number (1-12) in which this payroll period starts.',
    `calendar_year` STRING COMMENT 'The calendar year in which this payroll period starts (e.g., 2024).',
    `check_date` DATE COMMENT 'The date printed on payroll checks or used for electronic payment transactions for this period.',
    `closed_by_user_code` STRING COMMENT 'Identifier of the user or system account that closed this payroll period.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period was officially closed and locked from further changes.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the jurisdiction in which this payroll period applies (e.g., USA, CAN, GBR).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for payments in this payroll period (e.g., USD, CAD, GBP, EUR).',
    `cutoff_date` DATE COMMENT 'The deadline date by which time and attendance data must be submitted for processing in this payroll period.',
    `end_date` DATE COMMENT 'The last calendar date included in this payroll period.',
    `fiscal_month` STRING COMMENT 'The fiscal month number within the fiscal year (1-12).',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the fiscal year (1, 2, 3, or 4).',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this payroll period belongs (e.g., 2024).',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether this is a special adjustment or correction period (true) or a regular payroll period (false).',
    `is_year_end_period` BOOLEAN COMMENT 'Indicates whether this payroll period is the final period of the fiscal or calendar year (true/false).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about this payroll period, such as special processing instructions, holidays, or adjustments.',
    `pay_date` DATE COMMENT 'The date on which employees are paid for this payroll period.',
    `payroll_group_code` STRING COMMENT 'Code identifying the payroll group or employee segment (e.g., hourly, salaried, executive, union) to which this period applies.',
    `period_code` STRING COMMENT 'Business identifier code for the payroll period, typically used in payroll systems and reporting (e.g., PP202401, 2024-W01).',
    `period_name` STRING COMMENT 'Human-readable name or label for the payroll period (e.g., January 2024 - Period 1, Week Ending 2024-01-07).',
    `period_number` STRING COMMENT 'Sequential number of this payroll period within the fiscal or calendar year (e.g., 1-52 for weekly, 1-26 for bi-weekly, 1-12 for monthly).',
    `period_type` STRING COMMENT 'Classification of the payroll period frequency (weekly, bi-weekly, semi-monthly, monthly, quarterly, annual).',
    `processing_end_timestamp` TIMESTAMP COMMENT 'The date and time when payroll processing was completed for this period.',
    `processing_start_timestamp` TIMESTAMP COMMENT 'The date and time when payroll processing began for this period.',
    `start_date` DATE COMMENT 'The first calendar date included in this payroll period.',
    `payroll_period_status` STRING COMMENT 'Current lifecycle status of the payroll period (draft, open, processing, closed, locked, archived).',
    `tax_year` STRING COMMENT 'The tax year to which this payroll period belongs for tax reporting purposes.',
    `total_days_count` STRING COMMENT 'Total number of calendar days in this payroll period.',
    `working_days_count` STRING COMMENT 'Number of standard working days (typically Monday-Friday) within this payroll period, excluding holidays.',
    CONSTRAINT pk_payroll_period PRIMARY KEY(`payroll_period_id`)
) COMMENT 'Master reference table for payroll_period. Referenced by payroll_period_id.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Primary key for work_order',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the specific asset or equipment that is the subject of the work order.',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the vendor contract governing pricing, terms, and service levels for this work order.',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or property where the work order is executed.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the associated purchase order that authorizes procurement for this work order.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor assigned to fulfill this work order.',
    `actual_completion_date` DATE COMMENT 'Actual date when the work order was completed and closed.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred for the work order upon completion, including all charges.',
    `actual_start_date` DATE COMMENT 'Actual date when work commenced on the work order.',
    `approval_date` DATE COMMENT 'Date when the work order was formally approved.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether the work order requires formal approval before execution.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the work order.',
    `assigned_to` STRING COMMENT 'Name or identifier of the person, team, or vendor responsible for executing the work order.',
    `budget_code` STRING COMMENT 'Budget or cost center code against which the work order costs are charged.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order was formally closed and marked as complete.',
    `completion_notes` STRING COMMENT 'Free-text notes documenting work performed, issues encountered, and final outcomes upon completion.',
    `contract_compliance_flag` BOOLEAN COMMENT 'Indicates whether the work order adheres to the terms, pricing, and service levels defined in the vendor contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this work order.',
    `department` STRING COMMENT 'Property department or cost center responsible for the work order (e.g., Engineering, Housekeeping, Food & Beverage).',
    `work_order_description` STRING COMMENT 'Detailed narrative describing the scope, purpose, and requirements of the work order.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected total cost for completing the work order, including labor, materials, and services.',
    `expenditure_type` STRING COMMENT 'Classification of spend as Capital Expenditure (CapEx) for PIP projects or Operating Expenditure (OpEx) for routine operations.',
    `general_ledger_account` STRING COMMENT 'General ledger account code for financial posting and accounting integration.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this work order is part of a recurring maintenance or service schedule.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total cost of labor hours expended on the work order.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order record was last updated or modified.',
    `location` STRING COMMENT 'Specific location within the property where work is to be performed (e.g., Room 305, Lobby, Kitchen).',
    `material_cost` DECIMAL(18,2) COMMENT 'Total cost of materials, parts, and supplies consumed in executing the work order.',
    `priority` STRING COMMENT 'Business priority level indicating urgency and resource allocation: critical, high, medium, or low.',
    `procurement_category` STRING COMMENT 'High-level procurement category for spend classification: F&B supplies, housekeeping, FF&E, MRO, CapEx, or services.',
    `recurrence_frequency` STRING COMMENT 'Frequency of recurrence for scheduled recurring work orders: daily, weekly, monthly, quarterly, or annually.',
    `requested_by` STRING COMMENT 'Name or identifier of the person or department who initiated the work order request.',
    `requested_date` DATE COMMENT 'Date when the work order was originally requested or initiated.',
    `sap_document_number` STRING COMMENT 'SAP S/4HANA MM module document number for integration and traceability with the ERP system.',
    `scheduled_completion_date` DATE COMMENT 'Target date by which the work order is expected to be completed.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work is scheduled to begin.',
    `service_cost` DECIMAL(18,2) COMMENT 'Total cost of external services or contractor fees associated with the work order.',
    `warranty_applicable` BOOLEAN COMMENT 'Indicates whether the work performed is covered under an existing warranty or service agreement.',
    `work_order_number` STRING COMMENT 'Externally-known business identifier for the work order, typically displayed on documents and used for tracking.',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order: draft, submitted, approved, in progress, on hold, completed, or cancelled.',
    `work_order_type` STRING COMMENT 'Classification of the work order by nature of work: maintenance, repair, installation, inspection, project, or emergency.',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Master reference table for work_order. Referenced by work_order_id.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `parent_project_id` BIGINT COMMENT 'Self-referencing FK on project (parent_project_id)',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred on the project to date, including all purchase orders, invoices, and expenses.',
    `actual_end_date` DATE COMMENT 'Actual date when project execution was completed or closed.',
    `actual_start_date` DATE COMMENT 'Actual date when project execution commenced.',
    `approval_date` DATE COMMENT 'Date when the project was formally approved by the sponsoring authority or governance board.',
    `approved_by_id` BIGINT COMMENT 'Reference to the employee or executive who granted final approval for the project.',
    `brand_standard_compliance` BOOLEAN COMMENT 'Flag indicating whether the project deliverables must comply with specific brand or franchise standards.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget allocated for the project in the propertys operating currency.',
    `business_justification` STRING COMMENT 'Business case and rationale explaining why the project is being undertaken and the expected benefits.',
    `committed_cost` DECIMAL(18,2) COMMENT 'Total amount committed through approved purchase orders and contracts that have not yet been invoiced or paid.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of project completion based on milestones, deliverables, or earned value, ranging from 0.00 to 100.00.',
    `contract_id` BIGINT COMMENT 'Reference to the master vendor contract or agreement governing procurement for this project, if applicable.',
    `cost_center_code` STRING COMMENT 'Financial accounting cost center code to which project expenses are charged for budgeting and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the project record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this project.',
    `project_description` STRING COMMENT 'Detailed narrative description of the project scope, objectives, and deliverables.',
    `is_pip_project` BOOLEAN COMMENT 'Flag indicating whether this project is part of a Property Improvement Plan mandated by brand standards or franchise agreements.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, observations, or special instructions related to the project.',
    `planned_end_date` DATE COMMENT 'Scheduled date when project execution is planned to be completed.',
    `planned_start_date` DATE COMMENT 'Scheduled date when project execution is planned to begin.',
    `priority` STRING COMMENT 'Business priority level assigned to the project for resource allocation and scheduling decisions.',
    `project_category` STRING COMMENT 'Procurement category classification for the project. F&B for food and beverage supplies, housekeeping for cleaning and linen supplies, FF&E for furniture fixtures and equipment, technology for IT and systems, facility for building and infrastructure, guest experience for amenities and services.',
    `project_code` STRING COMMENT 'Business-assigned unique alphanumeric code for the project, used for external reference and reporting.',
    `project_manager_id` BIGINT COMMENT 'Reference to the employee responsible for managing and overseeing the project execution.',
    `project_name` STRING COMMENT 'Full descriptive name of the project.',
    `project_status` STRING COMMENT 'Current lifecycle status of the project indicating its stage in the project management workflow.',
    `project_type` STRING COMMENT 'Classification of the project by financial and operational category. CapEx for capital expenditure projects, OpEx for operational expenditure, PIP for Property Improvement Plan projects, renovation for property upgrades, new build for new construction, maintenance for ongoing upkeep.',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or vacation property where this project is being executed.',
    `risk_level` STRING COMMENT 'Overall risk assessment level for the project based on complexity, dependencies, and potential impact.',
    `sponsor_id` BIGINT COMMENT 'Reference to the executive or business unit sponsoring and funding the project.',
    `sustainability_rating` STRING COMMENT 'Environmental sustainability rating or certification target for the project, such as LEED or Green Key levels.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the project record was last modified in the system.',
    `wbs_element` STRING COMMENT 'Hierarchical work breakdown structure element code used for project planning, tracking, and cost allocation in SAP Project System.',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master reference table for project. Referenced by project_id.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` (
    `delivery_address_id` BIGINT COMMENT 'Primary key for delivery_address',
    `parent_delivery_address_id` BIGINT COMMENT 'Self-referencing FK on delivery_address (parent_delivery_address_id)',
    `address_code` STRING COMMENT 'Unique business identifier or code for the delivery address, used for procurement and logistics operations.',
    `address_line_1` STRING COMMENT 'Primary street address line including street number, street name, and building identifier for the delivery location.',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details such as suite, floor, room, loading dock, or department.',
    `address_line_3` STRING COMMENT 'Tertiary address line for additional location details or special delivery instructions.',
    `address_name` STRING COMMENT 'Business-friendly name or label for the delivery address (e.g., Main Kitchen Loading Dock, Housekeeping Storage Entrance).',
    `address_type` STRING COMMENT 'Classification of the delivery address type indicating the nature of the location.',
    `city` STRING COMMENT 'City or municipality name where the delivery address is located.',
    `contact_email` STRING COMMENT 'Email address for the delivery address contact person or receiving department for delivery notifications and coordination.',
    `contact_name` STRING COMMENT 'Name of the primary contact person at the delivery address for receiving shipments and coordinating deliveries.',
    `contact_phone` STRING COMMENT 'Primary phone number for the delivery address contact person or receiving department.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the delivery address is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery address record was first created in the system.',
    `default_shipping_method` STRING COMMENT 'Preferred or default shipping method for deliveries to this address.',
    `effective_from_date` DATE COMMENT 'Date from which this delivery address becomes active and available for use in procurement operations.',
    `effective_to_date` DATE COMMENT 'Date until which this delivery address remains active. Null indicates no planned end date.',
    `forklift_required` BOOLEAN COMMENT 'Indicates whether forklift equipment is required for unloading deliveries at this address.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the primary or default delivery address for the associated property or entity.',
    `is_verified` BOOLEAN COMMENT 'Indicates whether the delivery address has been verified through postal validation services or successful delivery confirmation.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the delivery address for mapping and route optimization.',
    `loading_dock_available` BOOLEAN COMMENT 'Indicates whether a loading dock is available at this delivery address for freight deliveries.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the delivery address for mapping and route optimization.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the delivery address record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery address record was last modified or updated.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the delivery address used for mail and package routing.',
    `procurement_category` STRING COMMENT 'Primary procurement category or material group typically delivered to this address (e.g., Food & Beverage, Housekeeping Supplies, Furniture Fixtures & Equipment).',
    `property_id` BIGINT COMMENT 'Reference to the property or facility associated with this delivery address.',
    `receiving_days` STRING COMMENT 'Days of the week when deliveries are accepted at this address (e.g., Monday-Friday, Monday,Wednesday,Friday).',
    `receiving_hours_end` STRING COMMENT 'End time for receiving deliveries at this address in HH:MM format (24-hour clock).',
    `receiving_hours_start` STRING COMMENT 'Start time for receiving deliveries at this address in HH:MM format (24-hour clock).',
    `sap_plant_code` STRING COMMENT 'SAP S/4HANA Materials Management (MM) plant code associated with this delivery address for procurement integration.',
    `sap_storage_location` STRING COMMENT 'SAP S/4HANA storage location code within the plant for goods receipt and inventory management.',
    `special_delivery_instructions` STRING COMMENT 'Additional instructions or notes for delivery personnel regarding access, parking, unloading procedures, or security requirements.',
    `state_province` STRING COMMENT 'State, province, or region where the delivery address is located.',
    `delivery_address_status` STRING COMMENT 'Current lifecycle status of the delivery address indicating whether it is available for use in procurement operations.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the delivery address location, used for scheduling deliveries and coordinating logistics.',
    `verification_date` DATE COMMENT 'Date when the delivery address was last verified or validated.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the delivery address record.',
    CONSTRAINT pk_delivery_address PRIMARY KEY(`delivery_address_id`)
) COMMENT 'Master reference table for delivery_address. Referenced by delivery_address_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ADD CONSTRAINT `fk_procurement_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ADD CONSTRAINT `fk_procurement_employee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`org_unit`(`org_unit_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ADD CONSTRAINT `fk_procurement_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`position`(`position_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ADD CONSTRAINT `fk_procurement_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`org_unit`(`org_unit_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ADD CONSTRAINT `fk_procurement_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`position`(`position_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ADD CONSTRAINT `fk_procurement_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`org_unit`(`org_unit_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ADD CONSTRAINT `fk_procurement_shift_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`org_unit`(`org_unit_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ADD CONSTRAINT `fk_procurement_shift_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ADD CONSTRAINT `fk_procurement_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`org_unit`(`org_unit_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ADD CONSTRAINT `fk_procurement_schedule_position_id` FOREIGN KEY (`position_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`position`(`position_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ADD CONSTRAINT `fk_procurement_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ADD CONSTRAINT `fk_procurement_schedule_schedule_employee_id` FOREIGN KEY (`schedule_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ADD CONSTRAINT `fk_procurement_schedule_schedule_published_by_user_employee_id` FOREIGN KEY (`schedule_published_by_user_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ADD CONSTRAINT `fk_procurement_schedule_shift_template_id` FOREIGN KEY (`shift_template_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`shift_template`(`shift_template_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ADD CONSTRAINT `fk_procurement_time_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`org_unit`(`org_unit_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ADD CONSTRAINT `fk_procurement_time_entry_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ADD CONSTRAINT `fk_procurement_time_entry_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ADD CONSTRAINT `fk_procurement_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ADD CONSTRAINT `fk_procurement_time_entry_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`schedule`(`schedule_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ADD CONSTRAINT `fk_procurement_time_entry_shift_template_id` FOREIGN KEY (`shift_template_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`shift_template`(`shift_template_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ADD CONSTRAINT `fk_procurement_time_entry_tertiary_time_edited_by_employee_id` FOREIGN KEY (`tertiary_time_edited_by_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ADD CONSTRAINT `fk_procurement_time_entry_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`work_order`(`work_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ADD CONSTRAINT `fk_procurement_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ADD CONSTRAINT `fk_procurement_job_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`org_unit`(`org_unit_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ADD CONSTRAINT `fk_procurement_job_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`position`(`position_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ADD CONSTRAINT `fk_procurement_job_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ADD CONSTRAINT `fk_procurement_job_requisition_tertiary_job_approved_by_employee_id` FOREIGN KEY (`tertiary_job_approved_by_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ADD CONSTRAINT `fk_procurement_performance_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`org_unit`(`org_unit_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ADD CONSTRAINT `fk_procurement_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`position`(`position_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ADD CONSTRAINT `fk_procurement_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ADD CONSTRAINT `fk_procurement_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ADD CONSTRAINT `fk_procurement_leave_request_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ADD CONSTRAINT `fk_procurement_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ADD CONSTRAINT `fk_procurement_leave_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`org_unit`(`org_unit_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ADD CONSTRAINT `fk_procurement_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ADD CONSTRAINT `fk_procurement_leave_request_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`schedule`(`schedule_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ADD CONSTRAINT `fk_procurement_disciplinary_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ADD CONSTRAINT `fk_procurement_disciplinary_action_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ADD CONSTRAINT `fk_procurement_disciplinary_action_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`org_unit`(`org_unit_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ADD CONSTRAINT `fk_procurement_disciplinary_action_primary_disciplinary_employee_id` FOREIGN KEY (`primary_disciplinary_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ADD CONSTRAINT `fk_procurement_disciplinary_action_tertiary_disciplinary_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_disciplinary_hr_business_partner_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ADD CONSTRAINT `fk_procurement_disciplinary_action_workforce_safety_incident_id` FOREIGN KEY (`workforce_safety_incident_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident`(`workforce_safety_incident_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ADD CONSTRAINT `fk_procurement_workforce_safety_incident_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`org_unit`(`org_unit_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ADD CONSTRAINT `fk_procurement_workforce_safety_incident_position_id` FOREIGN KEY (`position_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`position`(`position_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ADD CONSTRAINT `fk_procurement_workforce_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ADD CONSTRAINT `fk_procurement_compensation_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`position`(`position_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ADD CONSTRAINT `fk_procurement_compensation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_primary_procurement_approved_by_employee_id` FOREIGN KEY (`primary_procurement_approved_by_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_tertiary_procurement_last_modified_by_employee_id` FOREIGN KEY (`tertiary_procurement_last_modified_by_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`org_unit`(`org_unit_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_quaternary_purchase_buyer_employee_id` FOREIGN KEY (`quaternary_purchase_buyer_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_tertiary_purchase_final_approver_employee_id` FOREIGN KEY (`tertiary_purchase_final_approver_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_requisition_line_id` FOREIGN KEY (`requisition_line_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`requisition_line`(`requisition_line_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_service_material_master_id` FOREIGN KEY (`service_material_master_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_receiving_employee_id` FOREIGN KEY (`receiving_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ADD CONSTRAINT `fk_procurement_material_master_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ADD CONSTRAINT `fk_procurement_material_master_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ADD CONSTRAINT `fk_procurement_category_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ADD CONSTRAINT `fk_procurement_category_category_modified_by_user_employee_id` FOREIGN KEY (`category_modified_by_user_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ADD CONSTRAINT `fk_procurement_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ADD CONSTRAINT `fk_procurement_request_for_quotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ADD CONSTRAINT `fk_procurement_request_for_quotation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ADD CONSTRAINT `fk_procurement_request_for_quotation_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ADD CONSTRAINT `fk_procurement_request_for_quotation_primary_request_employee_id` FOREIGN KEY (`primary_request_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_request_for_quotation_id` FOREIGN KEY (`request_for_quotation_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`request_for_quotation`(`request_for_quotation_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_primary_purchase_employee_id` FOREIGN KEY (`primary_purchase_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ADD CONSTRAINT `fk_procurement_purchase_return_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_tertiary_vendor_last_modified_by_employee_id` FOREIGN KEY (`tertiary_vendor_last_modified_by_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ADD CONSTRAINT `fk_procurement_procurement_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ADD CONSTRAINT `fk_procurement_procurement_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ADD CONSTRAINT `fk_procurement_procurement_supply_agreement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ADD CONSTRAINT `fk_procurement_procurement_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ADD CONSTRAINT `fk_procurement_vendor_category_qualification_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ADD CONSTRAINT `fk_procurement_vendor_category_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ADD CONSTRAINT `fk_procurement_vendor_category_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ADD CONSTRAINT `fk_procurement_vendor_program_participation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ADD CONSTRAINT `fk_procurement_vendor_touchpoint_service_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ADD CONSTRAINT `fk_procurement_category_buyer_assignment_category_id` FOREIGN KEY (`category_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`category`(`category_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ADD CONSTRAINT `fk_procurement_category_buyer_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ADD CONSTRAINT `fk_procurement_procurement_therapist_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ADD CONSTRAINT `fk_procurement_program_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_delivery_address_id` FOREIGN KEY (`delivery_address_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`delivery_address`(`delivery_address_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`employee`(`employee_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`project`(`project_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` ADD CONSTRAINT `fk_procurement_requisition_line_split_from_requisition_line_id` FOREIGN KEY (`split_from_requisition_line_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`requisition_line`(`requisition_line_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_period` ADD CONSTRAINT `fk_procurement_payroll_period_prior_payroll_period_id` FOREIGN KEY (`prior_payroll_period_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`work_order` ADD CONSTRAINT `fk_procurement_work_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`work_order` ADD CONSTRAINT `fk_procurement_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`work_order` ADD CONSTRAINT `fk_procurement_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`project` ADD CONSTRAINT `fk_procurement_project_parent_project_id` FOREIGN KEY (`parent_project_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`project`(`project_id`);
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ADD CONSTRAINT `fk_procurement_delivery_address_parent_delivery_address_id` FOREIGN KEY (`parent_delivery_address_id`) REFERENCES `travel_hospitality_ecm`.`procurement`.`delivery_address`(`delivery_address_id`);

-- ========= TAGS =========
ALTER SCHEMA `travel_hospitality_ecm`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `travel_hospitality_ecm`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `ada_accommodation_description` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accommodation Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `ada_accommodation_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `ada_accommodation_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `ada_accommodation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accommodation Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `ada_accommodation_required_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on-leave|suspended|terminated|retired|deceased');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full-time|part-time|seasonal|contract|temporary|intern');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `food_safety_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `food_safety_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `oracle_hcm_employee_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle Human Capital Management (HCM) Employee Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `oracle_hcm_employee_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `oracle_hcm_employee_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `osha_training_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Training Current Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `osha_training_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Training Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_value_regex' = 'hourly|salaried|commission|contract');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Preferred Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `work_authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent-resident|work-visa|pending-verification|expired|not-authorized');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`employee` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on-property|remote|hybrid|corporate-office|multi-property');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `ada_accommodation_required` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accommodation Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Annual Salary');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `is_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Is Budgeted Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `is_exempt` SET TAGS ('dbx_business_glossary_term' = 'Is Exempt Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `is_supervisory` SET TAGS ('dbx_business_glossary_term' = 'Is Supervisory Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `is_union` SET TAGS ('dbx_business_glossary_term' = 'Is Union Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|none');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `minimum_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `physical_requirements` SET TAGS ('dbx_business_glossary_term' = 'Physical Requirements');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|frozen|eliminated|proposed');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'regular|seasonal|temporary|contract|on_call');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `shift_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Shift Eligibility');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `shift_eligibility` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|any');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform System of Accounts for the Lodging Industry (USALI) Department Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_property|remote|hybrid|field');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`position` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `actual_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `budgeted_headcount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Email Address');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `is_guest_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Guest Facing');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Is Revenue Generating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `is_unionized` SET TAGS ('dbx_business_glossary_term' = 'Is Unionized');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `labor_cost_percentage_target` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Percentage Target');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `labor_productivity_standard` SET TAGS ('dbx_business_glossary_term' = 'Labor Productivity Standard');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|closed');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_value_regex' = 'division|department|team|cost_center|work_group');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Phone Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `productivity_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Productivity Target Percentage');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `productivity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Productivity Unit of Measure');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `productivity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'rooms_per_hour|covers_per_hour|check_ins_per_hour|setups_per_hour|minutes_per_unit|units_per_shift');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `requires_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires Certification');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = '24x7|am_pm_night|am_pm|business_hours|on_call|variable');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `standard_time_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Time Per Unit');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`org_unit` ALTER COLUMN `usali_classification` SET TAGS ('dbx_business_glossary_term' = 'USALI (Uniform System of Accounts for the Lodging Industry) Classification');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `shift_template_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Template ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Center ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `consecutive_days_limit` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Days Limit');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `holiday_shift_flag` SET TAGS ('dbx_business_glossary_term' = 'Holiday Shift Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `maximum_staffing_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Staffing Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `meal_allowance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Meal Allowance Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `minimum_staffing_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Staffing Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `paid_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Paid Break Minutes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `paid_hours` SET TAGS ('dbx_business_glossary_term' = 'Paid Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `rest_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Rest Hours Required');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_business_glossary_term' = 'Rotation Pattern');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `seasonal_applicability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Applicability');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `seasonal_applicability` SET TAGS ('dbx_value_regex' = 'year_round|peak_season|off_season|summer|winter');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `shift_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `shift_template_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `shift_template_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|night|split|on_call');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `skill_requirement_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Requirement Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `skill_requirement_level` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|expert');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `transportation_allowance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Allowance Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `uniform_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`shift_template` ALTER COLUMN `weekend_shift_flag` SET TAGS ('dbx_business_glossary_term' = 'Weekend Shift Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_published_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Published By User ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_published_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_published_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `shift_template_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Template ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `cpor_labor` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Occupied Room (CPOR) Labor');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finalized Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `forecast_adr` SET TAGS ('dbx_business_glossary_term' = 'Forecast Average Daily Rate (ADR)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `forecast_occupancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Forecast Occupancy Rate (OCC)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `forecast_revpar` SET TAGS ('dbx_business_glossary_term' = 'Forecast Revenue Per Available Room (RevPAR)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `is_overtime_approved` SET TAGS ('dbx_business_glossary_term' = 'Is Overtime Approved');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `labor_cost_percentage` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Percentage');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `labor_variance_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Variance Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|finalized|archived');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'regular|seasonal|event|emergency|training');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `total_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `total_scheduled_fte` SET TAGS ('dbx_business_glossary_term' = 'Total Scheduled Full-Time Equivalent (FTE)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `total_scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Scheduled Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `shift_template_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `tertiary_time_edited_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Edited By Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `tertiary_time_edited_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `tertiary_time_edited_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|submitted|auto_approved');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Minutes)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-In Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-Out Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `edited_flag` SET TAGS ('dbx_business_glossary_term' = 'Edited Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `edited_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Edited Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `entry_source` SET TAGS ('dbx_business_glossary_term' = 'Entry Source');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Entry Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `paid_break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Paid Break Duration (Minutes)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `shift_differential_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `tips_reported_amount` SET TAGS ('dbx_business_glossary_term' = 'Tips Reported Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `tips_reported_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `tips_reported_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`time_entry` ALTER COLUMN `total_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `calculated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_value_regex' = 'not_posted|posted|reversed');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `oracle_payroll_run_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle Payroll Run ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi-weekly|semi-monthly|monthly');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `payroll_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `payroll_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `payroll_run_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `payroll_run_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `payroll_run_type` SET TAGS ('dbx_value_regex' = 'regular|off-cycle|bonus|correction|final');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `sap_payroll_run_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Payroll Run ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_bonus_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Bonus Pay');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_commission_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Commission Pay');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_employer_taxes` SET TAGS ('dbx_business_glossary_term' = 'Total Employer Payroll Taxes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_federal_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Federal Income Tax');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Pay');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_local_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Local Income Tax');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_medicare_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Medicare Tax (FICA)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Net Pay');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_overtime_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Overtime (OT) Pay');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_post_tax_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Post-Tax Deductions');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_pre_tax_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Pre-Tax Deductions');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_regular_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Regular Pay');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_service_charge` SET TAGS ('dbx_business_glossary_term' = 'Total Service Charge');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_social_security_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Social Security Tax (FICA)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_social_security_tax` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_social_security_tax` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_state_tax` SET TAGS ('dbx_business_glossary_term' = 'Total State Income Tax');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_tax_withholding` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Withholding');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_run` ALTER COLUMN `total_tip_allocation` SET TAGS ('dbx_business_glossary_term' = 'Total Tip Allocation');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `aca_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Compliant Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Policy Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `cobra_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `dependent_coverage_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Dependent Coverage Allowed Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `enrollment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `enrollment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `life_event_enrollment_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Life Event Enrollment Allowed Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `maximum_dependent_age` SET TAGS ('dbx_business_glossary_term' = 'Maximum Dependent Age');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Uniform Resource Locator (URL)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`benefit_plan` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Waiting Period Days');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `job_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `tertiary_job_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `tertiary_job_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `tertiary_job_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `background_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Frequency');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_value_regex' = 'hourly|annual|monthly|weekly');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `drug_screening_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Screening Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `eeo_job_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Job Category');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|temporary|contract|on_call');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `external_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'External Posting Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `headcount_requested` SET TAGS ('dbx_business_glossary_term' = 'Headcount Requested');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `internal_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Posting Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `minimum_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Minimum Qualifications');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `posting_end_date` SET TAGS ('dbx_business_glossary_term' = 'Posting End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `posting_location` SET TAGS ('dbx_business_glossary_term' = 'Posting Location');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `posting_start_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `preferred_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Qualifications');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `requisition_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Closed Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `requisition_justification` SET TAGS ('dbx_business_glossary_term' = 'Requisition Justification');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `requisition_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Opened Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'new_position|replacement|backfill|seasonal|temporary|contract');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|flexible');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `travel_requirement` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `travel_requirement` SET TAGS ('dbx_value_regex' = 'none|occasional|frequent|extensive');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `work_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Required');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`job_requisition` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_site|hybrid|remote');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `development_areas_summary` SET TAGS ('dbx_business_glossary_term' = 'Development Areas Summary');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `development_plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `goals_met_count` SET TAGS ('dbx_business_glossary_term' = 'Goals Met Count');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `goals_total_count` SET TAGS ('dbx_business_glossary_term' = 'Total Goals Count');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `guest_service_rating` SET TAGS ('dbx_business_glossary_term' = 'Guest Service Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `guest_service_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding|not-applicable');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `merit_increase_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `performance_improvement_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `promotion_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommended Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `property_code` SET TAGS ('dbx_business_glossary_term' = 'Property Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `reliability_rating` SET TAGS ('dbx_business_glossary_term' = 'Reliability Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `reliability_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in-progress|completed|acknowledged|cancelled');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `review_template_code` SET TAGS ('dbx_business_glossary_term' = 'Review Template Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid-year|probationary|90-day|project|ad-hoc');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Strengths Summary');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `succession_planning_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `teamwork_rating` SET TAGS ('dbx_business_glossary_term' = 'Teamwork Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `teamwork_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `technical_skills_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`performance_review` ALTER COLUMN `technical_skills_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Plan ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `accrual_period` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|escalated');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `balance_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Balance As-Of Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `carryover_hours` SET TAGS ('dbx_business_glossary_term' = 'Carryover Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `certification_received_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|arranged|confirmed');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Case Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `hours_accrued` SET TAGS ('dbx_business_glossary_term' = 'Hours Accrued');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `hours_requested` SET TAGS ('dbx_business_glossary_term' = 'Hours Requested');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `hours_taken` SET TAGS ('dbx_business_glossary_term' = 'Hours Taken');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `is_ada_accommodation` SET TAGS ('dbx_business_glossary_term' = 'Is ADA (Americans with Disabilities Act) Accommodation');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `is_fmla_qualifying` SET TAGS ('dbx_business_glossary_term' = 'Is FMLA (Family and Medical Leave Act) Qualifying');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `is_intermittent` SET TAGS ('dbx_business_glossary_term' = 'Is Intermittent Leave');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Is Paid Leave');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `leave_subtype` SET TAGS ('dbx_business_glossary_term' = 'Leave Subtype');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `opening_balance_hours` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `payroll_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Payroll Impact Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `payroll_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `remaining_balance_hours` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submission Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submission Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `requires_medical_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires Medical Certification');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `requires_medical_certification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `requires_medical_certification` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `total_days` SET TAGS ('dbx_business_glossary_term' = 'Total Leave Days');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`leave_request` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Leave Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `disciplinary_action_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `primary_disciplinary_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `primary_disciplinary_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `primary_disciplinary_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `workforce_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Incident ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `action_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Action Effective Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^DA-[0-9]{8}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'draft|issued|active|completed|overturned|expunged');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'verbal_warning|written_warning|final_warning|suspension|termination|performance_improvement_plan');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_method` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Method');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_method` SET TAGS ('dbx_value_regex' = 'in_person_signature|electronic_signature|certified_mail|email_confirmation|refused');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Action Expiration Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `expunged_date` SET TAGS ('dbx_business_glossary_term' = 'Expunged Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `expunged_reason` SET TAGS ('dbx_business_glossary_term' = 'Expunged Reason');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `grievance_filed` SET TAGS ('dbx_business_glossary_term' = 'Grievance Filed Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `grievance_outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Grievance Outcome Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `grievance_outcome_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `grievance_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Resolution Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `grievance_status` SET TAGS ('dbx_business_glossary_term' = 'Grievance Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `grievance_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|upheld|overturned|settled|withdrawn');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `incident_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `is_eligible_for_rehire` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Rehire Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `is_expunged` SET TAGS ('dbx_business_glossary_term' = 'Is Expunged Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `is_paid_suspension` SET TAGS ('dbx_business_glossary_term' = 'Is Paid Suspension Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Action Issued Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `legal_hold` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `legal_hold_case_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Case Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `legal_hold_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `osha_recordable_incident` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Incident Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `suspension_days` SET TAGS ('dbx_business_glossary_term' = 'Suspension Days');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary_cause|involuntary_performance|involuntary_conduct|layoff|mutual_separation');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `union_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Union Representative Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `union_representative_notified` SET TAGS ('dbx_business_glossary_term' = 'Union Representative Notified Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Violation Category');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `witness_names` SET TAGS ('dbx_business_glossary_term' = 'Witness Names');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`disciplinary_action` ALTER COLUMN `witness_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `workforce_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Safety Incident ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `corrective_action_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `days_on_restricted_duty` SET TAGS ('dbx_business_glossary_term' = 'Days on Restricted Duty');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Time');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'slip_fall|chemical_exposure|equipment_injury|ergonomic|near_miss|burn');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_value_regex' = 'first_aid|medical_treatment|lost_time|restricted_duty|fatality|no_injury');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|closed|pending_review');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `medical_treatment_facility` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Facility');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `medical_treatment_facility` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `medical_treatment_facility` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `osha_300_log_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) 300 Log Entry Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `physician_name` SET TAGS ('dbx_business_glossary_term' = 'Physician Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `physician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `preventable_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventable Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `privacy_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Case Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_business_glossary_term' = 'Witness Names');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `workers_compensation_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`workforce_safety_incident` ALTER COLUMN `workers_compensation_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `benefits_package_code` SET TAGS ('dbx_business_glossary_term' = 'Benefits Package Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `benefits_package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `brand_segment` SET TAGS ('dbx_business_glossary_term' = 'Brand Segment Applicability');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `brand_segment` SET TAGS ('dbx_value_regex' = 'luxury|premium|select_service|extended_stay|resort|all');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `compa_ratio_target` SET TAGS ('dbx_business_glossary_term' = 'Comparative Ratio (Compa-Ratio) Target');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `compensation_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `compensation_plan_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `compensation_plan_description` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|obsolete');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `is_unionized` SET TAGS ('dbx_business_glossary_term' = 'Unionized Position Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `market_pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Market Pricing Effective Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `market_pricing_source` SET TAGS ('dbx_business_glossary_term' = 'Market Pricing Data Source');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `maximum_rate` SET TAGS ('dbx_business_glossary_term' = 'Maximum Compensation Rate');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `merit_increase_cycle` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Cycle');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `merit_increase_cycle` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|none');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `merit_increase_eligible` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `midpoint_rate` SET TAGS ('dbx_business_glossary_term' = 'Midpoint Compensation Rate');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `minimum_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Compensation Rate');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Multiplier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'hourly|salaried|tipped|commission|service_charge_eligible|hybrid');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit of Measure');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'hour|year|month|week|day');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `service_charge_eligible` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Bonus Percentage');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `tip_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tip Credit Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`compensation_plan` ALTER COLUMN `usali_department` SET TAGS ('dbx_business_glossary_term' = 'Uniform System of Accounts for the Lodging Industry (USALI) Department');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address Line 1');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address Line 2');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `annual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `annual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Vendor City');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Classification');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'food_beverage_supplier|housekeeping_supplier|ffe_vendor|maintenance_contractor|technology_provider|professional_services');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|conditional');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Country Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Doing Business As (DBA) Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `diversity_certification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Certification');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `iban` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `insurance_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `minimum_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Onboarding Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|procurement_card');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Postal Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_business_glossary_term' = 'Remittance Email Address');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Vendor State or Province');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `swift_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blocked|terminated');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional|restricted');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time Days');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `contract_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Contract Compliance Score');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `contract_renewal_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Recommendation');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `contract_renewal_recommendation` SET TAGS ('dbx_value_regex' = 'renew|renegotiate|terminate|extend_trial');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `cost_competitiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Cost Competitiveness Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `emergency_order_support_rating` SET TAGS ('dbx_business_glossary_term' = 'Emergency Order Support Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|published|archived');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `invoice_discrepancies_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Discrepancies Count');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `late_deliveries_count` SET TAGS ('dbx_business_glossary_term' = 'Late Deliveries Count');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `overall_vendor_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Vendor Score');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `payment_terms_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Compliance Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `qualified_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Qualified Vendor Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `quality_acceptance_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Acceptance Rate');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `quality_rejections_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Rejections Count');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `responsiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `sustainability_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Compliance Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `total_purchase_orders` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Orders');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `primary_procurement_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `primary_procurement_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `primary_procurement_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `tertiary_procurement_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `tertiary_procurement_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `tertiary_procurement_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `capex_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Designation Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'master_supply_agreement|blanket_purchase_order|frame_contract|spot_contract|service_agreement|capex_contract');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time Days');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `negotiated_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Discount Percent');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `pip_project_flag` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Project Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `sla_on_time_delivery_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) On-Time Delivery Percent');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `sla_quality_acceptance_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Quality Acceptance Percent');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quaternary_purchase_buyer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quaternary_purchase_buyer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quaternary_purchase_buyer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `tertiary_purchase_final_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Final Approver ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `tertiary_purchase_final_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `tertiary_purchase_final_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_chain_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Chain Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Available Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `converted_to_po_flag` SET TAGS ('dbx_business_glossary_term' = 'Converted to Purchase Order (PO) Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_location_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `justification_text` SET TAGS ('dbx_business_glossary_term' = 'Justification Text');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^PR[0-9]{10}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'OpEx|CapEx|PIP|Emergency|Stock Replenishment|Service');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `source_system_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Key');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_value_regex' = 'Direct PO|RFQ Required|Competitive Bid|Sole Source|Corporate Contract|Emergency Purchase');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `blanket_release_number` SET TAGS ('dbx_business_glossary_term' = 'Blanket Release Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_business_glossary_term' = 'Buyer Email Address');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `commitment_released_amount` SET TAGS ('dbx_business_glossary_term' = 'Commitment Released Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `goods_receipt_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Completed Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `invoice_receipt_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Completed Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,10}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|framework|capex|opex|service');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address Line 1');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address Line 2');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_business_glossary_term' = 'Ship-To City');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Postal Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_business_glossary_term' = 'Ship-To State or Province');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|ocean|courier|vendor_delivery|pickup');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_amount_with_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Amount with Tax');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_quote_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quote Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{0,24}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `requisition_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Line ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `service_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Service ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `final_invoice_indicator` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Indicator');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Quantity');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `invoice_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Quantity');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'Open|Partially Received|Fully Received|Invoiced|Closed|Cancelled');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `open_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Quantity');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Percentage');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Short Text');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Percentage');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`po_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `pip_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Project ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) or Operating Expenditure (OpEx) Indicator');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_value_regex' = 'capex|opex');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('dbx_business_glossary_term' = 'Condition on Receipt');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('dbx_value_regex' = 'good|damaged|expired|incorrect_item|short_shipment|overage');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `freight_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charges Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'draft|posted|cancelled|reversed');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'not_inspected|passed|failed|partial_acceptance|pending_qa');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quality_rejection_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Rejection Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_notes` SET TAGS ('dbx_business_glossary_term' = 'Receiving Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `return_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Delivery Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `serial_number_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Managed Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'not_started|matched|variance_detected|blocked|approved');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `total_quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity Received');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `total_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Value Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = 'price_change|quantity_short|quantity_over|damaged_goods|substitution|freight_variance');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `early_payment_discount_date` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `early_payment_discount_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `early_payment_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percentage');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `expense_type` SET TAGS ('dbx_business_glossary_term' = 'Expense Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `expense_type` SET TAGS ('dbx_value_regex' = 'opex|capex');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `match_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Match Variance Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|virtual_card');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|variance|no_po|no_gr|blocked');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `allergen_information` SET TAGS ('dbx_business_glossary_term' = 'Allergen Information');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) or Operating Expenditure (OpEx) Indicator');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_value_regex' = 'capex|opex');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_approval|blocked');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'raw_material|trading_goods|finished_goods|spare_parts|consumables|services');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `perishable_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|stock_transfer');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `purchase_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Purchase Unit of Measure (UOM)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `purchase_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Material Short Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|climate_controlled|dry|secure');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `sustainability_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `temperature_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`material_master` ALTER COLUMN `temperature_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `category_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `category_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `category_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Category Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `annual_spend_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Budget Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'property|regional|corporate|executive');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `benchmarking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Benchmarking Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `bid_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bid Threshold Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `budget_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Tracking Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Hierarchy Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Category Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|capital|services');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `competitive_bid_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bid Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `contract_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Compliance Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct_charge|allocated|cost_center|profit_center');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `cpor_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Occupied Room (CPOR) Tracking Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `emergency_procurement_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Procurement Allowed Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `inventory_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Managed Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time Days');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `minimum_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Qualified Vendor Count');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `preferred_vendor_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Program Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `quality_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_value_regex' = 'strategic|preferred_vendor|competitive_bid|spot_buy|contract');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `spend_classification` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OpEx) vs Capital Expenditure (CapEx) Classification');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `spend_classification` SET TAGS ('dbx_value_regex' = 'opex|capex');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `sustainability_criteria_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Criteria Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_value_regex' = 'taxable|exempt|zero_rated|reverse_charge');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform System of Accounts for the Lodging Industry (USALI) Department Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category` ALTER COLUMN `vendor_diversification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Diversification Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `request_for_quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Request For Quotation Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Vendor ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `primary_request_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `primary_request_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `primary_request_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `award_criteria` SET TAGS ('dbx_business_glossary_term' = 'Award Criteria');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `award_criteria` SET TAGS ('dbx_value_regex' = 'lowest_price|best_value|technical_merit|multi_vendor_award');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `award_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Award Decision Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `awarded_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Awarded Contract Value');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `awarded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Awarded Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `capex_opex_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) or Operating Expenditure (OpEx) Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `capex_opex_flag` SET TAGS ('dbx_value_regex' = 'capex|opex');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `estimated_annual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Spend Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `estimated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Quantity');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'rfq|rfp|reverse_auction|negotiation|sealed_bid');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'RFQ Issue Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issued Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `minority_vendor_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority Vendor Preference Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `participating_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Participating Vendor Count');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `pip_project_flag` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Project Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Deadline Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `response_deadline_time` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Deadline Time');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `response_received_count` SET TAGS ('dbx_business_glossary_term' = 'Response Received Count');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `rfq_description` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `rfq_status` SET TAGS ('dbx_value_regex' = 'draft|issued|open|closed|awarded|cancelled');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `sustainability_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Requirement Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`request_for_quotation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quotation ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `request_for_quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `award_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Award Decision Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `award_recommendation_flag` SET TAGS ('dbx_business_glossary_term' = 'Award Recommendation Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time Days');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `evaluated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evaluated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `price_competitiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Price Competitiveness Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `price_competitiveness_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_document_url` SET TAGS ('dbx_business_glossary_term' = 'Quotation Document URL');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_number` SET TAGS ('dbx_business_glossary_term' = 'Quotation Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_received_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Received Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_status` SET TAGS ('dbx_business_glossary_term' = 'Quotation Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_status` SET TAGS ('dbx_value_regex' = 'received|under_evaluation|awarded|rejected|expired|withdrawn');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Valid From Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `quotation_valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Valid To Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `quoted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quoted Quantity');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `quoted_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Quoted Total Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `quoted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Unit Price');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `specification_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Specification Compliance Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `specification_deviation_notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Deviation Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `sustainability_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Compliance Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `vendor_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Score');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_quotation` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `purchase_return_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Return ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector User ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `primary_purchase_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `primary_purchase_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `primary_purchase_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `ap_credit_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Credit Posted Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `credit_memo_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `inventory_adjustment_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment Posted Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,18}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Return Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `perishable_item_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Item Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_value_regex' = 'failed|rejected|non_conforming|damaged|expired|not_inspected');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|resolved|partial_credit|disputed|closed');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `return_document_number` SET TAGS ('dbx_business_glossary_term' = 'Return Document Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `return_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `return_quantity` SET TAGS ('dbx_business_glossary_term' = 'Return Quantity');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'quality_defect|damaged_goods|incorrect_item|over_delivery|expired_perishable|specification_mismatch');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `return_shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Tracking Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `return_shipping_cost` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Cost');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `return_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Return Value Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `shipped_date` SET TAGS ('dbx_business_glossary_term' = 'Shipped Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `vendor_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Acknowledgement Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`purchase_return` ALTER COLUMN `vendor_credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Credit Memo Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `vendor_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Certification ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `tertiary_vendor_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `tertiary_vendor_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `tertiary_vendor_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `brand_standard_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_verification|revoked|renewed');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `certification_subtype` SET TAGS ('dbx_business_glossary_term' = 'Certification Subtype');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `compliance_gate_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gate Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `coverage_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `coverage_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `esg_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Reporting Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document_upload|third_party_verification|issuer_portal_check|manual_inspection|self_attestation');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` SET TAGS ('dbx_association_edges' = 'workforce.employee,workforce.benefit_plan');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `procurement_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'procurement_enrollment Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Benefit Plan Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Employee Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `enrollment_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `life_event_date` SET TAGS ('dbx_business_glossary_term' = 'Life Event Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `life_event_type` SET TAGS ('dbx_business_glossary_term' = 'Life Event Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `oracle_hcm_enrollment_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle HCM Enrollment Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `procurement_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `procurement_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Waived Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_association_edges' = 'procurement.vendor,procurement.material_master');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `procurement_supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'procurement_supply_agreement Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Material Master Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Vendor Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `negotiated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Unit Price');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `supply_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `vendor_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lead Time');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` SET TAGS ('dbx_association_edges' = 'procurement.vendor,procurement.procurement_category');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `vendor_category_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category Qualification ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category Qualification - Procurement Category Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category Qualification - Vendor Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `annual_spend_actual` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Actual');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `category_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Category Performance Score');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `contract_terms` SET TAGS ('dbx_business_glossary_term' = 'Contract Terms');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `payment_terms_override` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Override');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `spend_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Spend Allocation Percentage');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` SET TAGS ('dbx_association_edges' = 'procurement.vendor,experience.experience_program');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `vendor_program_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Program Participation ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `experience_program_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Program ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Program Participation - Experience Program Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Program Participation - Vendor Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `capacity_limit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Limit');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `fulfillment_responsibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Responsibility Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `minimum_notice_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Notice Hours');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `participation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Participation End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `participation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Participation Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `pricing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `program_specific_pricing` SET TAGS ('dbx_business_glossary_term' = 'Program Specific Pricing');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `property_scope` SET TAGS ('dbx_business_glossary_term' = 'Property Scope');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `service_delivery_sla` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery SLA');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `vendor_program_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Program Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `vendor_role_in_program` SET TAGS ('dbx_business_glossary_term' = 'Vendor Role in Program');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_program_participation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` SET TAGS ('dbx_association_edges' = 'procurement.vendor,experience.touchpoint');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `vendor_touchpoint_service_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Touchpoint Service ID');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Touchpoint Service - Touchpoint Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Touchpoint Service - Vendor Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `cost_per_touchpoint_interaction` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Touchpoint Interaction');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `cost_per_touchpoint_interaction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `quality_threshold_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Threshold Score');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Time Minutes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `touchpoint_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Activation Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `touchpoint_deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Deactivation Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `vendor_staff_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Staff Certification Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`vendor_touchpoint_service` ALTER COLUMN `vendor_touchpoint_role` SET TAGS ('dbx_business_glossary_term' = 'Vendor Touchpoint Role');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` SET TAGS ('dbx_association_edges' = 'workforce.employee,procurement.procurement_category');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `category_buyer_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Category Buyer Assignment Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Buyer Assignment - Procurement Category Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Category Buyer Assignment - Employee Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Buyer Assignment Type');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `primary_backup_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Backup Indicator');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `spend_authority_limit` SET TAGS ('dbx_business_glossary_term' = 'Spend Authority Limit');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`category_buyer_assignment` ALTER COLUMN `workload_percentage` SET TAGS ('dbx_business_glossary_term' = 'Category Workload Percentage');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` SET TAGS ('dbx_association_edges' = 'workforce.employee,spa.treatment');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `procurement_therapist_certification_id` SET TAGS ('dbx_business_glossary_term' = 'procurement_therapist_certification Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Certification - Employee Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `spa_therapist_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Certification Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Certification - Treatment Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `last_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performed Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `preferred_for_treatment_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Therapist Flag');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `preferred_for_treatment_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `preferred_for_treatment_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Completed');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`procurement_therapist_certification` ALTER COLUMN `treatments_performed_count` SET TAGS ('dbx_business_glossary_term' = 'Treatments Performed Count');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` SET TAGS ('dbx_association_edges' = 'workforce.employee,experience.experience_program');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `program_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Assignment Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Assignment - Employee Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Assignment - Experience Program Id');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Required Certification');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `responsibility_level` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Level');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `role_in_program` SET TAGS ('dbx_business_glossary_term' = 'Program Role');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`program_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` ALTER COLUMN `requisition_line_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Line Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`requisition_line` ALTER COLUMN `split_from_requisition_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_period` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_period` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`payroll_period` ALTER COLUMN `prior_payroll_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`work_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`work_order` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`project` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`project` ALTER COLUMN `parent_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` SET TAGS ('dbx_subdomain' = 'supplier_operations');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `delivery_address_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Identifier');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `parent_delivery_address_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`procurement`.`delivery_address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
