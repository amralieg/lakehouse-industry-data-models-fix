-- Schema for Domain: workforce | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`workforce` COMMENT 'Human resources and workforce management domain for employee master data, organizational structure, staffing, training, and labor management. Includes employee records, job roles, certifications, safety training records (OSHA PSM), GMP personnel qualification, shift schedules, labor hours, competency tracking, and workforce planning. Supports compliance with OSHA training requirements and operator certification.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique system-generated identifier for each employee.',
    `job_role_id` BIGINT COMMENT 'Foreign key linking to workforce.job_role. Business justification: Employees belong to a job role; linking via employee.job_role_id enables normalization of role attributes and removes redundant job_role_code.',
    `manager_employee_id` BIGINT COMMENT 'Employee identifier of the direct manager.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Each employee holds a specific authorized position; adding employee.position_id creates a direct relationship to position.',
    `rough_cut_capacity_id` BIGINT COMMENT 'Foreign key linking to planning.rough_cut_capacity. Business justification: Rough‑cut capacity studies must record the employee author for governance and traceability.',
    `access_level` STRING COMMENT 'Security clearance level for plant and system access.. Valid values are `level1|level2|level3|level4`',
    `address` STRING COMMENT 'Full residential address used for emergency contact and tax purposes.',
    `annual_salary` DECIMAL(18,2) COMMENT 'Base yearly salary amount for salaried employees.',
    `badge_expiration_date` DATE COMMENT 'Date when the employees access badge expires.',
    `badge_number` STRING COMMENT 'Physical access badge identifier.',
    `benefits_eligible_flag` BOOLEAN COMMENT 'Indicates if the employee is eligible for company benefits.',
    `compensation_type` STRING COMMENT 'Method of compensation for the employee.. Valid values are `salary|hourly|contract`',
    `contract_end_date` DATE COMMENT 'Date the contractor agreement expires.',
    `contract_start_date` DATE COMMENT 'Date the contractor agreement becomes effective.',
    `contractor_company_name` STRING COMMENT 'Name of the external contractor organization.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which labor costs are charged.',
    `date_of_birth` DATE COMMENT 'Employees birth date, used for age verification and benefits eligibility.',
    `department_code` STRING COMMENT 'Organizational department identifier.',
    `email` STRING COMMENT 'Primary work email address for the employee.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the employees emergency contact.',
    `employee_type` STRING COMMENT 'Classification of employment relationship.. Valid values are `full_time|part_time|contractor|temporary|service_provider`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee.. Valid values are `active|inactive|terminated|leave_of_absence`',
    `first_name` STRING COMMENT 'Legal first name of the employee.',
    `gmp_qualification_flag` BOOLEAN COMMENT 'Indicates if the employee is qualified under Good Manufacturing Practice.',
    `hire_date` DATE COMMENT 'Date the employee officially started employment.',
    `insurance_expiration_date` DATE COMMENT 'Date when the contractors insurance coverage expires.',
    `insurance_verification_status` STRING COMMENT 'Current status of contractors insurance verification.. Valid values are `verified|pending|expired`',
    `job_code` STRING COMMENT 'Internal code representing the job classification.',
    `job_title` STRING COMMENT 'Official title of the employees position.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the employee.',
    `osha_training_date` DATE COMMENT 'Date of OSHA Process Safety Management training.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee.',
    `ppe_required_flag` BOOLEAN COMMENT 'True if personal protective equipment is required for the employees role.',
    `psm_training_date` DATE COMMENT 'Date of PSM-specific training.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in the system.',
    `safety_training_completed_flag` BOOLEAN COMMENT 'True if required safety training has been completed.',
    `safety_training_completion_date` DATE COMMENT 'Date when safety training was completed.',
    `salary_grade` STRING COMMENT 'Compensation grade used for salary banding.',
    `sap_personnel_number` STRING COMMENT 'Employee number as stored in SAP HR.',
    `site_access_authorization_level` STRING COMMENT 'Level of authorization for site access.. Valid values are `basic|elevated|admin`',
    `social_security_number` STRING COMMENT 'Government-issued identifier for payroll and tax reporting.',
    `sponsoring_department` STRING COMMENT 'Internal department that sponsors the contractor.',
    `termination_date` DATE COMMENT 'Date the employees employment ended, if applicable.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Core master record for ALL workers performing work at Chemical Mfg plant sites — full-time employees, part-time staff, contract/temporary workers, and service provider personnel. Single source of truth for worker identity regardless of employment relationship. Captures personal identity, employment status, hire date, job classification, plant assignment, cost center, employment type discriminator (full-time, part-time, contractor, temporary, service-provider), union membership, badge number, site access authorization level, SAP HR personnel number. For contractors and service providers: contractor company name, contract start/end dates, sponsoring department, safety induction completion status, OSHA training verification date, site-specific PPE requirements, and contractor insurance verification. Provides unified worker identity for all downstream systems including MES operator login, DCS access control, training compliance, safety qualification tracking, and OSHA recordkeeping. All qualification, training, and site access management flows through this single worker identity regardless of payroll relationship.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'System-generated unique identifier for the position record.',
    `budget` DECIMAL(18,2) COMMENT 'Annual budget allocated for this position (salary, benefits, overhead).',
    `budgeted_headcount` STRING COMMENT 'Number of headcount slots budgeted for this position.',
    `creation_source` STRING COMMENT 'Origin of the position record (e.g., SAP OM, manual entry, external HR system).',
    `effective_end_date` DATE COMMENT 'Date when the position is retired or expires (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the position becomes active for staffing.',
    `ehs_training_required` BOOLEAN COMMENT 'True if the position requires mandatory Environment, Health & Safety training.',
    `filled_flag` BOOLEAN COMMENT 'True if the position is currently filled, otherwise False.',
    `fte` DECIMAL(18,2) COMMENT 'Standardized FTE value representing the workload of the position.',
    `grade_band` STRING COMMENT 'Compensation grade band (e.g., G1, G2) that determines salary range and benefits.',
    `is_safety_critical` BOOLEAN COMMENT 'Indicates whether the position is safety‑critical (e.g., PSM operator, EHS officer).',
    `job_family` STRING COMMENT 'Broad functional family grouping (e.g., Production, R&D, Quality).',
    `job_level` STRING COMMENT 'Numeric level within the job family indicating seniority.',
    `last_filled_date` DATE COMMENT 'Date when the position was most recently filled.',
    `location_code` STRING COMMENT 'Identifier of the plant or facility where the position is based.',
    `position_category` STRING COMMENT 'High‑level functional category of the position. [ENUM-REF-CANDIDATE: production|research|admin|logistics|sales|quality|maintenance — 7 candidates stripped; promote to reference product]',
    `position_code` STRING COMMENT 'Business identifier used to reference the position in HR and payroll systems.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position.. Valid values are `open|filled|on_hold|closed|inactive`',
    `position_type` STRING COMMENT 'Classification of employment type for the position.. Valid values are `full_time|temporary|contract|intern`',
    `psm_operator_required` BOOLEAN COMMENT 'True if the position must hold a Process Safety Management certification.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the position record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the position record.',
    `reports_to_position_code` STRING COMMENT 'Position code of the immediate supervisory role.',
    `required_certifications` STRING COMMENT 'Comma‑separated list of mandatory certifications (e.g., OSHA PSM, GMP).',
    `required_education` STRING COMMENT 'Minimum education level required for the position (e.g., Bachelors in Chemical Engineering).',
    `required_experience_years` STRING COMMENT 'Minimum years of relevant experience needed.',
    `salary_range_max` DECIMAL(18,2) COMMENT 'Upper bound of the salary range for the position.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'Lower bound of the salary range for the position.',
    `shift` STRING COMMENT 'Standard shift pattern for the position.. Valid values are `day|swing|night|flex`',
    `title` STRING COMMENT 'Official job title associated with the position (e.g., Process Engineer, Safety Officer).',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized position master record within the organizational structure of Chemical Mfg. Defines budgeted headcount slots, job title, grade band, plant or department assignment, required qualifications, and whether the position is safety-critical (PSM operator, EHS officer). Supports workforce planning and org chart management. Linked to SAP OM Position object.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique surrogate key for the organizational unit.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who manages the unit.',
    `parent_org_unit_id` BIGINT COMMENT 'Identifier of the immediate parent unit in the hierarchy.',
    `address_line1` STRING COMMENT 'First line of the units street address.',
    `address_line2` STRING COMMENT 'Second line of the units street address (optional).',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated to the unit.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `city` STRING COMMENT 'City of the units primary location.',
    `compliance_certification` STRING COMMENT 'Key compliance certifications held by the unit.. Valid values are `ISO9001|ISO14001|ISO45001|GHS|REACH`',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the units primary location.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the unit ceased operations, if applicable.',
    `effective_start_date` DATE COMMENT 'Date when the unit became operational.',
    `email_address` STRING COMMENT 'Primary email address for the unit.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Annual energy consumption of the unit in megawatt-hours.',
    `environmental_permit_number` STRING COMMENT 'Regulatory permit identifier for environmental compliance.',
    `facility_area_sqm` DECIMAL(18,2) COMMENT 'Physical area of the units facilities in square meters.',
    `headcount_actual` STRING COMMENT 'Current number of employees assigned to the unit.',
    `headcount_planned` STRING COMMENT 'Planned number of employees for the unit.',
    `operating_hours_per_week` STRING COMMENT 'Standard weekly operating hours for the unit.',
    `org_hierarchy_path` STRING COMMENT 'Full hierarchical path of the unit for reporting (e.g., /Company/Plant/Dept).',
    `org_level` STRING COMMENT 'Depth level of the unit within the hierarchy (root=0).',
    `org_unit_code` STRING COMMENT 'Unique business code for the unit, used in ERP and reporting.',
    `org_unit_name` STRING COMMENT 'Descriptive name of the organizational unit (e.g., Production, Quality Control).',
    `org_unit_status` STRING COMMENT 'Current operational status of the unit.. Valid values are `active|inactive|planned|closed`',
    `org_unit_type` STRING COMMENT 'Category of the unit indicating its functional classification.. Valid values are `department|plant|cost_center|function|division`',
    `phone_number` STRING COMMENT 'Contact phone number for the unit.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the units address.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the organizational unit record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the organizational unit record.',
    `region` STRING COMMENT 'Region where the unit is located (e.g., North America).',
    `safety_training_required` BOOLEAN COMMENT 'Indicates whether the unit requires OSHA/PSM safety training for its staff.',
    `shift_pattern` STRING COMMENT 'Typical shift schedule used by the unit.. Valid values are `day|night|rotating|flex`',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit master representing departments, cost centers, plants, and functional groups within Chemical Mfg (e.g., Reaction Processing, QC Laboratory, EHS, R&D, Logistics). Defines the hierarchical reporting structure used for workforce planning, labor cost allocation, and regulatory headcount reporting. Corresponds to SAP OM Organizational Unit object.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`job_role` (
    `job_role_id` BIGINT COMMENT 'Unique surrogate key for each job role record.',
    `competency_profile_id` BIGINT COMMENT 'Reference to the competency profile that defines required skills and certifications for the role.',
    `training_course_id` BIGINT COMMENT 'Foreign key linking to workforce.training_course. Business justification: Job roles may require a specific training course; required_training_course_id captures this relationship.',
    `average_experience_years` DECIMAL(18,2) COMMENT 'Typical years of experience required for incumbents of this role.',
    `certification_required` STRING COMMENT 'Professional certifications required for the role (e.g., Certified Process Engineer).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the job role record was first created in the system.',
    `department` STRING COMMENT 'Primary business department that owns the role (e.g., Production, Maintenance, Quality).',
    `effective_from` DATE COMMENT 'Date when the role definition becomes effective for staffing.',
    `effective_until` DATE COMMENT 'Date when the role definition is retired or superseded (null if open‑ended).',
    `flsa_classification` STRING COMMENT 'Fair Labor Standards Act classification for overtime eligibility.. Valid values are `exempt|non_exempt|unknown`',
    `gmp_qualification_required` BOOLEAN COMMENT 'Specifies if the role must hold GMP‑qualified personnel status.',
    `is_unionized` BOOLEAN COMMENT 'True if the role is covered by a labor union agreement.',
    `job_role_description` STRING COMMENT 'Detailed textual description of duties, responsibilities, and scope of the role.',
    `job_role_status` STRING COMMENT 'Current lifecycle status of the role definition.. Valid values are `active|inactive|deprecated`',
    `location_scope` STRING COMMENT 'Geographic scope where the role is applicable.. Valid values are `plant|site|global`',
    `pay_grade_max` STRING COMMENT 'Highest pay‑grade level applicable to the role.',
    `pay_grade_min` STRING COMMENT 'Lowest pay‑grade level applicable to the role.',
    `psm_critical_flag` BOOLEAN COMMENT 'Indicates whether the role is critical for PSM compliance (True/False).',
    `regulatory_training_required` BOOLEAN COMMENT 'Specifies if role holders must complete regulatory compliance training (e.g., REACH, GHS).',
    `role_code` STRING COMMENT 'External code used to reference the role in HR systems and payroll.',
    `role_family` STRING COMMENT 'Broad classification grouping similar roles (e.g., Operator, Engineer, Technician).',
    `role_name` STRING COMMENT 'Human‑readable name of the job role (e.g., Chemical Operator I).',
    `safety_training_required` BOOLEAN COMMENT 'Indicates if OSHA or other safety training is mandatory (True/False).',
    `training_required` STRING COMMENT 'Comma‑separated list of mandatory training modules (e.g., OSHA PSM, GMP).',
    `typical_shift` STRING COMMENT 'Standard shift pattern associated with the role.. Valid values are `day|night|rotating`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the job role record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the job role record.',
    CONSTRAINT pk_job_role PRIMARY KEY(`job_role_id`)
) COMMENT 'Reference catalog of standardized job roles and job families used across Chemical Mfg plants (e.g., Chemical Operator I/II/III, Process Engineer, QC Analyst, EHS Specialist, Maintenance Technician, Shift Supervisor). Defines role family, pay grade range, FLSA classification, PSM-critical flag, GMP qualification requirement, and required competency profile. Used as the template for position creation.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Unique system-generated identifier for the shift schedule record.',
    `functional_location_id` BIGINT COMMENT 'Identifier of the plant or facility where the schedule is applied.',
    `break_duration_minutes` STRING COMMENT 'Total minutes of scheduled breaks within the shift.',
    `compliance_notes` STRING COMMENT 'Notes related to regulatory or safety compliance for the schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created.',
    `effective_from` DATE COMMENT 'Date on which the schedule becomes valid.',
    `effective_until` DATE COMMENT 'Date on which the schedule expires; null if open‑ended.',
    `employee_qualification_required` STRING COMMENT 'Qualification or certification required for personnel assigned to this shift (e.g., "Operator", "Engineer").',
    `end_time` TIMESTAMP COMMENT 'Scheduled end time of the shift (HH:MM, 24‑hour clock).',
    `is_flexible` BOOLEAN COMMENT 'Indicates whether the schedule can be adjusted on short notice (True/False).',
    `is_gmp_covered` BOOLEAN COMMENT 'Indicates whether the schedule is subject to GMP requirements (True/False).',
    `is_psm_covered` BOOLEAN COMMENT 'Indicates whether the schedule applies to PSM‑covered processes (True/False).',
    `last_review_date` DATE COMMENT 'Date when the schedule was last reviewed for compliance or operational relevance.',
    `max_consecutive_days` STRING COMMENT 'Maximum number of days an employee may work consecutively under this schedule.',
    `min_rest_hours_between_shifts` DECIMAL(18,2) COMMENT 'Minimum required rest period (in hours) between the end of one shift and the start of the next.',
    `overtime_allowed` BOOLEAN COMMENT 'Indicates whether overtime can be scheduled for this shift (True/False).',
    `reviewed_by` STRING COMMENT 'Name or identifier of the person who performed the last review.',
    `rotation_cycle_days` STRING COMMENT 'Number of days that constitute one full rotation of the schedule.',
    `schedule_code` STRING COMMENT 'Business code used to reference the schedule in operational systems and planning tools.',
    `schedule_name` STRING COMMENT 'Human‑readable name of the shift schedule (e.g., "12‑Hour Continental").',
    `schedule_type` STRING COMMENT 'Classification of the schedule pattern: rotating, fixed, or flexible.. Valid values are `rotating|fixed|flex`',
    `schedule_version` STRING COMMENT 'Version number incremented when the schedule definition changes.',
    `shift_category` STRING COMMENT 'Broad category of the shift (e.g., day, swing, night).. Valid values are `day|swing|night|weekend|holiday`',
    `shift_group` STRING COMMENT 'Logical grouping of shifts based on functional area.. Valid values are `operations|maintenance|lab|admin`',
    `shift_pattern_details` STRING COMMENT 'Detailed textual representation of the rotation pattern (e.g., "3 days on, 2 days off").',
    `shift_schedule_description` STRING COMMENT 'Free‑form description providing additional context about the shift schedule.',
    `shift_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.. Valid values are `active|inactive|planned|retired`',
    `start_time` TIMESTAMP COMMENT 'Scheduled start time of the shift (HH:MM, 24‑hour clock).',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the schedule (e.g., "America/Chicago").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    `work_hours_per_day` DECIMAL(18,2) COMMENT 'Planned productive work hours for the shift.',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Master record defining shift rotation patterns and work schedules for plant operations at Chemical Mfg (e.g., 12-hour continental rotating shifts, 8-hour day/swing/night, DCS operator schedules). Captures shift name, start/end times, rotation cycle, plant applicability, and whether the schedule applies to PSM-covered processes. Used for labor planning, overtime calculation, and MES integration.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` (
    `shift_assignment_id` BIGINT COMMENT 'Unique surrogate key for each shift assignment record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Assigns a shift to a specific product batch; needed for production scheduling and batch traceability reports.',
    `crew_id` BIGINT COMMENT 'Identifier of the crew/team designated for the shift.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee assigned to the shift.',
    `functional_location_id` BIGINT COMMENT 'Identifier of the plant or production unit where the shift occurs.',
    `shift_schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.shift_schedule. Business justification: Shift assignments should reference a defined schedule; shift_assignment.shift_schedule_id links to shift_schedule and removes the free‑form code.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or production line associated with the shift.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Recorded actual end date and time when the employee completed work.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Recorded actual start date and time when the employee began work.',
    `assignment_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift assignment record was first created in the system.',
    `assignment_effective_date` DATE COMMENT 'Date on which the shift assignment becomes effective.',
    `assignment_expiry_date` DATE COMMENT 'Date on which the shift assignment ends or expires; null if open‑ended.',
    `assignment_number` STRING COMMENT 'Business identifier used by operations to reference the shift assignment.',
    `assignment_type` STRING COMMENT 'Nature of the assignment (e.g., regular, temporary, overtime, training).. Valid values are `regular|temporary|overtime|training`',
    `assignment_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shift assignment record.',
    `break_duration_minutes` STRING COMMENT 'Total scheduled break time within the shift, in minutes.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether a specific certification is required for this shift.',
    `change_reason` STRING COMMENT 'Reason provided when the shift assignment is modified after initial creation.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual labor cost incurred for the shift after completion.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Projected labor cost for the shift based on standard rates.',
    `crew_designation` STRING COMMENT 'Name or label of the crew/team assigned to the shift.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for labor cost values.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free‑form text field for additional information or comments about the assignment.',
    `overtime_authorized_flag` BOOLEAN COMMENT 'Indicates whether overtime was pre‑approved for this shift (True/False).',
    `overtime_reason` STRING COMMENT 'Explanation for why overtime was authorized for this shift.',
    `plant_location_code` STRING COMMENT 'Standard code representing the physical location of the plant.. Valid values are `^PL[0-9]{3}$`',
    `relief_coverage_flag` BOOLEAN COMMENT 'True if the assignment includes relief/coverage duties for another employee.',
    `safety_training_completed_flag` BOOLEAN COMMENT 'True if the employee has completed required safety training before the shift.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end date and time of the shift.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date and time of the shift.',
    `shift_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the shift in hours, calculated from scheduled times.',
    `shift_pattern_description` STRING COMMENT 'Human‑readable description of the shift pattern (e.g., "8‑hour rotating day/night").',
    `shift_status` STRING COMMENT 'Current lifecycle status of the shift assignment.. Valid values are `planned|active|completed|cancelled|on_hold`',
    `shift_type` STRING COMMENT 'Classification of the shift based on time of day.. Valid values are `day|night|swing|weekend`',
    `source_system` STRING COMMENT 'System that originated the shift assignment record.. Valid values are `MES|Manual|HRIS`',
    CONSTRAINT pk_shift_assignment PRIMARY KEY(`shift_assignment_id`)
) COMMENT 'Transactional record assigning a specific employee to a shift schedule for a defined period at a plant or production unit. Captures effective dates, assigned shift pattern, crew/team designation, relief coverage flag, and overtime authorization. Supports MES operator login validation, DCS access control, and labor cost allocation by shift.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` (
    `labor_time_entry_id` BIGINT COMMENT 'Primary key uniquely identifying the labor time entry record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Tracks labor hours per chemical product for cost accounting and product profitability analysis.',
    `employee_id` BIGINT COMMENT 'Unique internal identifier for the employee who performed the labor.',
    `functional_location_id` BIGINT COMMENT 'Plant or facility location where the labor was performed.',
    `org_unit_id` BIGINT COMMENT 'Organizational department responsible for the employee.',
    `timesheet_id` BIGINT COMMENT 'Identifier of the parent timesheet record grouping multiple labor entries.',
    `absence_type` STRING COMMENT 'Reason for non‑working time if the entry represents an absence.. Valid values are `none|vacation|sick|personal|unpaid`',
    `activity_type` STRING COMMENT 'Classification of the labor activity performed.. Valid values are `production|maintenance|training|downtime|admin`',
    `approval_status` STRING COMMENT 'Current approval state of the labor entry.. Valid values are `pending|approved|rejected`',
    `approved_by` BIGINT COMMENT 'User who approved the labor entry.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the entry was approved.',
    `cost_object_code` BIGINT COMMENT 'Identifier of the cost object (e.g., production order, work order, cost center) charged to.',
    `cost_object_type` STRING COMMENT 'Category of the cost object linked to the entry.. Valid values are `production_order|maintenance_work_order|cost_center|project`',
    `end_timestamp` TIMESTAMP COMMENT 'Exact end time of the labor activity.',
    `entered_by` BIGINT COMMENT 'User who originally entered the labor record.',
    `entry_timestamp` TIMESTAMP COMMENT 'Date‑time when the entry was created in the system.',
    `job_code` STRING COMMENT 'Standard code representing the employees job role.',
    `labor_category` STRING COMMENT 'Business classification of the labor (e.g., direct production, indirect support).. Valid values are `direct|indirect|support|training`',
    `labor_cost` DECIMAL(18,2) COMMENT 'Calculated cost (total_hours × labor_rate) for the entry.',
    `labor_cost_center` STRING COMMENT 'Cost center code to which the labor cost is allocated.',
    `labor_entry_source` STRING COMMENT 'Origin of the entry record (e.g., manual entry, system import, mobile app).. Valid values are `manual|system|mobile`',
    `labor_project_code` STRING COMMENT 'Project identifier if labor is charged to a specific project.',
    `labor_rate` DECIMAL(18,2) COMMENT 'Hourly rate applicable to the labor entry before taxes.',
    `labor_rate_currency` STRING COMMENT 'Three‑letter ISO currency code for the labor rate.',
    `labor_time_entry_status` STRING COMMENT 'Indicates whether the entry is currently active or has been soft‑deleted.. Valid values are `active|deleted`',
    `line_sequence` STRING COMMENT 'Sequential order of the entry within its timesheet.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the labor entry.',
    `overtime_approval_required` BOOLEAN COMMENT 'True if overtime hours need separate managerial approval.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates whether any overtime was recorded for this entry.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Hours worked beyond regular schedule and eligible for overtime pay.',
    `ppe_required` BOOLEAN COMMENT 'Specifies whether PPE was mandatory for the activity.',
    `record_audit_created` TIMESTAMP COMMENT 'System timestamp when the record was first persisted.',
    `record_audit_updated` TIMESTAMP COMMENT 'System timestamp of the most recent update to the record.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Hours worked at standard rate.',
    `safety_training_completed` BOOLEAN COMMENT 'Indicates if required safety training was completed before the work.',
    `shift` STRING COMMENT 'Designated work shift for the entry.. Valid values are `day|night|swing`',
    `skill_level` STRING COMMENT 'Competency tier of the employee for the performed activity.. Valid values are `junior|mid|senior|expert`',
    `start_timestamp` TIMESTAMP COMMENT 'Exact start time of the labor activity.',
    `total_hours` DECIMAL(18,2) COMMENT 'Total number of hours recorded for the entry (including regular and overtime).',
    `work_date` DATE COMMENT 'Calendar date on which the labor was performed.',
    CONSTRAINT pk_labor_time_entry PRIMARY KEY(`labor_time_entry_id`)
) COMMENT 'Transactional record of actual hours worked by an employee for a given date, shift, and cost object (production order, maintenance work order, cost center). Captures regular hours, overtime hours, absence type, activity type (direct production, indirect, training, downtime), and approval status. Source data for payroll, COGS labor allocation, and OEE labor efficiency calculations. Integrates with SAP CATS (Cross-Application Time Sheet).';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` (
    `absence_record_id` BIGINT COMMENT 'Unique identifier for the absence record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee to whom the absence applies.',
    `absence_number` STRING COMMENT 'Human‑readable sequential number assigned to the absence record.',
    `absence_record_status` STRING COMMENT 'Current processing status of the absence request.. Valid values are `pending|approved|rejected|cancelled|completed`',
    `absence_type` STRING COMMENT 'Category of the absence.. Valid values are `vacation|sick|injury|maternity|paternity|other`',
    `approval_date` DATE COMMENT 'Date when the absence request was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the absence record was initially created in the system.',
    `end_date` DATE COMMENT 'Last calendar date of the approved absence period.',
    `end_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the absence ended (used for partial‑day absences).',
    `is_fmla_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for Family and Medical Leave Act coverage for this absence.',
    `is_osha_recordable` BOOLEAN COMMENT 'Flag indicating if the absence is a recordable OSHA lost‑time incident.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'Employees leave balance (in days) after this absence is applied.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'Employees leave balance (in days) before this absence is applied.',
    `medical_certification_status` STRING COMMENT 'Status of any required medical certification for the absence.. Valid values are `required|provided|exempt|pending`',
    `paid_leave_flag` BOOLEAN COMMENT 'Indicates whether the absence is paid under company policy.',
    `reason_description` STRING COMMENT 'Free‑text description provided by the employee for the absence.',
    `request_date` DATE COMMENT 'Date when the employee submitted the absence request.',
    `request_source` STRING COMMENT 'Origin of the absence request submission.. Valid values are `self_service|hr_portal|manager|hr_rep`',
    `return_to_work_date` DATE COMMENT 'Date the employee is expected or actually returned to work after the absence.',
    `start_date` DATE COMMENT 'First calendar date of the approved absence period.',
    `start_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the absence began (used for partial‑day absences).',
    `total_days` DECIMAL(18,2) COMMENT 'Total duration of the absence expressed in days, including fractions.',
    `total_hours` DECIMAL(18,2) COMMENT 'Total duration of the absence expressed in hours.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the absence record.',
    CONSTRAINT pk_absence_record PRIMARY KEY(`absence_record_id`)
) COMMENT 'Transactional record of employee absences including planned leave (vacation, FMLA, parental leave), unplanned absences (sick leave, injury leave), and OSHA recordable lost-time incidents. Captures absence type, start/end dates, duration in hours/days, FMLA eligibility flag, OSHA recordable flag, return-to-work date, and medical certification status. Critical for OSHA 300 log compliance and workforce availability planning.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`competency` (
    `competency_id` BIGINT COMMENT 'System-generated unique identifier for each competency record.',
    `competency_category` STRING COMMENT 'High‑level classification of the competency (e.g., technical, safety, regulatory, leadership, license, certification).. Valid values are `technical|safety|regulatory|leadership|license|certification`',
    `competency_code` STRING COMMENT 'Business identifier or code used to reference the competency in HR and compliance systems.',
    `competency_description` STRING COMMENT 'Detailed description of the competency, including scope and applicability.',
    `competency_group` STRING COMMENT 'Higher‑level grouping of related competencies (e.g., Process Operations, Safety Management).',
    `competency_name` STRING COMMENT 'Human‑readable name of the competency, skill, certification, or license.',
    `competency_status` STRING COMMENT 'Current lifecycle status of the competency definition.. Valid values are `active|inactive|retired|pending`',
    `competency_type` STRING COMMENT 'Specific type of competency entity: skill, certification, or license.. Valid values are `skill|certification|license`',
    `effective_date` DATE COMMENT 'Date when the competency definition becomes effective for use.',
    `expiration_date` DATE COMMENT 'Date when the competency definition is retired or no longer valid.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the competency is mandatory for a specific job role or regulatory scope.',
    `issuing_body` STRING COMMENT 'Organization or authority that issues the certification or license (e.g., OSHA, API, ISO).',
    `proficiency_level` STRING COMMENT 'Standardized proficiency level label for the competency.. Valid values are `novice|intermediate|advanced|expert`',
    `proficiency_scale` DECIMAL(18,2) COMMENT 'Numeric scale (e.g., 0.00‑5.00) indicating the level of proficiency required or achieved.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the competency record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the competency record.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation or standard that mandates the competency (e.g., OSHA 1910.119, FDA 21 CFR 211).',
    `renewal_interval_months` STRING COMMENT 'Number of months before expiration when renewal actions should be initiated.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the competency must be renewed after the validity period expires.',
    `subgroup` STRING COMMENT 'More granular subgroup within a competency group (e.g., Reactor Operation, Confined Space Entry).',
    `validity_period_months` STRING COMMENT 'Standard validity period for the competency or certification, expressed in months.',
    `version` STRING COMMENT 'Version identifier for the competency definition to support change management.',
    CONSTRAINT pk_competency PRIMARY KEY(`competency_id`)
) COMMENT 'Authoritative reference catalog of ALL competencies, skills, certifications, licenses, and technical capabilities tracked for Chemical Mfg workforce. Includes technical skills (DCS operation, HAZOP facilitation, GC/HPLC analysis, reactor operation), safety competencies (confined space entry, LOTO/LOTOTO procedures, hot work), regulatory qualifications (PSM operator authorization, GMP personnel qualification), and formal certifications/licenses (OSHA 30-Hour, Certified Industrial Hygienist (CIH), Certified Safety Professional (CSP), CDL for hazmat transport, Forklift Operator License, HAZWOPER 40-Hour, API Inspector Certification, Confined Space Rescue). Defines competency/certification name, category (technical, safety, regulatory, leadership, certification, license), proficiency scale or pass/fail indicator, certification/issuing body, standard validity period, renewal/recertification requirements, regulatory mandate reference (OSHA 1910.119, FDA 21 CFR 211, DOT 49 CFR), whether mandatory for PSM-covered roles or GMP-qualified positions, and whether it is a regulatory prerequisite for specific job roles. Single source of truth for the definition of what competencies and certifications exist — employee_competency records reference this catalog.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` (
    `employee_competency_id` BIGINT COMMENT 'System-generated unique identifier for the employee competency record.',
    `competency_id` BIGINT COMMENT 'Unique identifier of the competency definition from the competency catalog.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom the competency applies.',
    `assessment_date` DATE COMMENT 'Date the competency assessment or qualification was performed.',
    `assessor_name` STRING COMMENT 'Name of the person or authority that performed the assessment.',
    `certificate_number` STRING COMMENT 'Unique identifier of the issued certificate or license.',
    `competency_validity_years` STRING COMMENT 'Number of years the competency remains valid after issue.',
    `current_status` STRING COMMENT 'Overall status of the competency record.. Valid values are `active|expired|suspended|revoked`',
    `expiration_policy` STRING COMMENT 'Policy governing how the competency expires (fixed date vs. rolling based on issue date).. Valid values are `fixed|rolling`',
    `expiry_date` DATE COMMENT 'Date the certificate or license expires.',
    `issue_date` DATE COMMENT 'Date the certificate or license was issued.',
    `issuing_body` STRING COMMENT 'Organization that issued the certification or license.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the competency.',
    `practical_evaluation_result` STRING COMMENT 'Outcome of the hands‑on practical assessment.. Valid values are `pass|fail|not_applicable`',
    `process_unit` STRING COMMENT 'Specific plant unit or process the competency applies to (e.g., "HF Alkylation").',
    `proficiency_level` STRING COMMENT 'Assessed level of competence for the employee.. Valid values are `beginner|intermediate|advanced|expert|pass|fail`',
    `qualification_type` STRING COMMENT 'Nature of the qualification event (e.g., initial, periodic).. Valid values are `initial|periodic|requalification|recertification`',
    `record_created` TIMESTAMP COMMENT 'Timestamp when the competency record was first created in the system.',
    `record_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the competency record.',
    `regulatory_reference` STRING COMMENT 'Regulation or standard that mandates the competency (e.g., "29 CFR 1910.119").',
    `renewal_due_date` DATE COMMENT 'Date by which renewal actions must be completed.',
    `renewal_status` STRING COMMENT 'Current renewal state of the competency.. Valid values are `due|not_due|overdue`',
    `source_system` STRING COMMENT 'Originating operational system that supplied the competency data (e.g., SAP HR, LIMS).',
    `verification_document_ref` STRING COMMENT 'Reference (e.g., URL or document ID) to the scanned verification document.',
    `written_test_score` DECIMAL(18,2) COMMENT 'Score achieved on any written examination, expressed as a percentage.',
    CONSTRAINT pk_employee_competency PRIMARY KEY(`employee_competency_id`)
) COMMENT 'Unified transactional record linking employees to ALL assessed competencies, regulatory qualifications, process-specific authorizations, and formal certifications held. This is the SINGLE SOURCE OF TRUTH for answering what is this worker qualified to do? Covers: technical competencies (DCS operation proficiency, HAZOP facilitation, GC/HPLC analysis), safety qualifications (confined space entry authorization, LOTO certification), OSHA PSM operator qualifications for specific covered processes (HF alkylation, chlorine handling, ammonia refrigeration — per 29 CFR 1910.119), GMP personnel qualifications (initial qualification, periodic requalification, hygiene assessment, documentation practice evaluation), and formal certifications/licenses (OSHA 30-Hour card, CIH, CSP, CDL, HAZWOPER 40-Hour, API Inspector, Forklift Operator). Captures: referenced competency from catalog, proficiency level or pass/fail, assessment/qualification date, assessor/qualified-by name, qualification type discriminator (PSM, GMP, certification, license, general skill), regulatory mandate reference, process unit (for PSM), written test score, practical evaluation result, issuing/certifying body, certificate number, issue date, expiry date, renewal/refresher due date, renewal status, verification document reference, and current qualification status (active, expired, suspended, revoked). Triggers automated renewal alerts, blocks MES/DCS login for lapsed qualifications, and supports single-query compliance reporting for OSHA PSM audits, GMP inspections, FDA reviews, ISO 9001 assessments, and insurance audits.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Unique surrogate key for each training course record.',
    `assessment_type` STRING COMMENT 'Method used to evaluate participant competence.. Valid values are `exam|practical|simulation|none`',
    `certification_name` STRING COMMENT 'Name of the certification granted upon passing, if applicable.',
    `certification_required` BOOLEAN COMMENT 'True if successful completion awards a formal certification.',
    `compliance_status` STRING COMMENT 'Current compliance verification status of the course.. Valid values are `compliant|non-compliant|pending`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost associated with delivering the course (if any).',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the cost amount (e.g., USD).',
    `course_code` STRING COMMENT 'Business identifier used to reference the course across systems.',
    `course_type` STRING COMMENT 'High‑level classification of the course purpose or domain.. Valid values are `safety|technical|compliance|orientation|leadership`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the course record was first created in the system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Accredited credit hours or CEUs awarded upon successful completion.',
    `delivery_method` STRING COMMENT 'Method by which the training is delivered to participants.. Valid values are `classroom|online|hands-on|blended`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Planned total instructional time for the course.',
    `effective_end_date` DATE COMMENT 'Date after which the course is no longer offered (nullable if indefinite).',
    `effective_start_date` DATE COMMENT 'Date when the course becomes available for enrollment.',
    `instructor_name` STRING COMMENT 'Name of the primary instructor or facilitator for the course.',
    `is_external_provider` BOOLEAN COMMENT 'True if the course is delivered by a third‑party vendor.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the course is required for all applicable employees.',
    `language` STRING COMMENT 'Primary language in which the course is delivered.. Valid values are `EN|ES|FR|DE|ZH|JA`',
    `last_review_date` DATE COMMENT 'Date when the course content was last reviewed for relevance and compliance.',
    `max_enrollment` STRING COMMENT 'Maximum number of participants allowed in a single session.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or remarks.',
    `pass_fail_threshold` DECIMAL(18,2) COMMENT 'Minimum score (percentage) required to pass the assessment.',
    `prerequisite_course_codes` STRING COMMENT 'Comma‑separated list of course codes that must be completed before enrolling.',
    `regulatory_mandate` STRING COMMENT 'Regulation or standard that requires the training (e.g., OSHA 1910.119).',
    `requalification_interval_days` STRING COMMENT 'Number of days after which the course must be retaken to remain compliant.',
    `review_interval_days` STRING COMMENT 'Number of days between mandatory content reviews.',
    `title` STRING COMMENT 'Descriptive name of the training course as shown in the catalog.',
    `training_category` STRING COMMENT 'Broad compliance or functional category the course belongs to.. Valid values are `OSHA|GMP|HAZMAT|DOT|EHS|General`',
    `training_course_description` STRING COMMENT 'Full textual description of the course content, objectives, and scope.',
    `training_course_status` STRING COMMENT 'Current lifecycle state of the course record.. Valid values are `draft|active|inactive|retired`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the course record.',
    `version_number` STRING COMMENT 'Version identifier for the course content (e.g., v1.2).',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Unified training management product covering the COMPLETE training lifecycle as a single source of truth: course catalog definition, scheduled/completed training sessions, and individual employee training completion records. COURSE CATALOG: Manages OSHA PSM initial and refresher training, GMP qualification courses, HAZMAT/DOT training, GHS/SDS awareness, confined space entry, LOTO/LOTOTO, process safety management, emergency response, and site-specific orientation courses. Captures course code, title, delivery method (classroom, hands-on, online, blended), regulatory mandate (OSHA 1910.119, EPA RMP, DOT 49 CFR, FDA 21 CFR 211), requalification interval, pass/fail threshold, and prerequisite courses. SESSIONS: Captures scheduled date, location (plant, training room, online platform), instructor/facilitator name, maximum enrollment, actual attendance roster, session status (scheduled, in-progress, completed, cancelled), and materials used. COMPLETION RECORDS: Captures individual employee results including completion date, assessment score, pass/fail result, certificate number issued, expiry/requalification date, trainer/assessor name, regulatory mandate satisfied, and CEU/contact hours earned. Supports training calendar management, compliance gap analysis, automated retraining notifications, and audit-ready reporting for OSHA PSM reviews, GMP inspections, and DOT compliance verification.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'Unique system-generated identifier for each headcount planning record.',
    `job_role_id` BIGINT COMMENT 'Foreign key linking to workforce.job_role. Business justification: Headcount plans target specific job roles; headcount_plan.job_role_id creates a proper FK and removes the redundant code.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Headcount plans are scoped to an org unit; linking via headcount_plan.org_unit_id replaces the code field with a proper FK.',
    `actual_headcount` STRING COMMENT 'Number of positions that have been filled as of the latest update.',
    `approval_status` STRING COMMENT 'Current status of the plans approval process.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who granted final approval.',
    `approved_date` DATE COMMENT 'Calendar date on which the plan received approval.',
    `approved_fte` DECIMAL(18,2) COMMENT 'FTE count that has been formally approved by governance.',
    `budgeted_headcount` STRING COMMENT 'Number of positions budgeted for the planning period.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the headcount plan record was first created.',
    `effective_from` DATE COMMENT 'Date when the headcount plan becomes operationally effective.',
    `effective_until` DATE COMMENT 'Date when the headcount plan ceases to be effective; null for open‑ended plans.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year associated with the headcount plan.',
    `headcount_plan_status` STRING COMMENT 'Lifecycle state of the headcount plan.. Valid values are `draft|active|closed|cancelled`',
    `is_contractor_allowed` BOOLEAN COMMENT 'True if the headcount can be satisfied with contractor labor.',
    `is_filled` BOOLEAN COMMENT 'True when the required headcount for the role is fully staffed.',
    `is_gmp_required` BOOLEAN COMMENT 'True if the role must meet Good Manufacturing Practice qualification.',
    `is_psm_critical` BOOLEAN COMMENT 'True if the position requires Process Safety Management certification.',
    `last_review_by` STRING COMMENT 'Identifier of the person who performed the most recent review.',
    `last_review_date` DATE COMMENT 'Date when the headcount plan was last examined or updated by governance.',
    `notes` STRING COMMENT 'Additional remarks, assumptions, or explanations related to the plan.',
    `plan_description` STRING COMMENT 'Narrative explaining the objectives, scope, and assumptions of the headcount plan.',
    `plan_name` STRING COMMENT 'Descriptive name given to the headcount plan for easy identification.',
    `plan_type` STRING COMMENT 'Classification of the plan indicating whether it is strategic, operational, or tactical.. Valid values are `strategic|operational|tactical`',
    `planning_category` STRING COMMENT 'Business driver for the headcount request.. Valid values are `new_hire|backfill|contractor_conversion|reallocation`',
    `planning_period_end` DATE COMMENT 'Last calendar date of the period covered by the headcount plan.',
    `planning_period_start` DATE COMMENT 'First calendar date of the period covered by the headcount plan.',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant or location associated with the headcount plan.',
    `target_fte` DECIMAL(18,2) COMMENT 'Planned total FTEs to be staffed for the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the headcount plan.',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'Workforce planning and talent acquisition product managing strategic headcount targets and the full staffing requisition lifecycle. Captures approved FTE targets by org unit, job role, and planning period for CapEx/OpEx workforce budgeting. Manages active staffing requisitions including requisition number, position title, org unit, plant, hiring manager, required start date, requisition type (new hire, backfill, contractor conversion), required certifications, PSM-critical flag, GMP qualification requirement, approval workflow status, recruiter assignment, candidate pipeline tracking, and fulfillment status (open, interviewing, offered, filled, cancelled). Supports plant staffing adequacy reviews for PSM compliance (minimum operator coverage per shift), drives the talent acquisition workflow from planning through requisition approval, recruiting, offer acceptance, and onboarding handoff. Single source of truth for all workforce demand planning and position fulfillment activity.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` (
    `employee_action_id` BIGINT COMMENT 'System-generated unique identifier for the employee action record.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or HR representative who approved the action.',
    `primary_employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom the action applies.',
    `position_id` BIGINT COMMENT 'Identifier of the employees position before the action.',
    `action_number` STRING COMMENT 'Human‑readable identifier or code for the personnel action (e.g., ACT‑2024‑00123).',
    `action_status` STRING COMMENT 'Current processing state of the personnel action.. Valid values are `pending|approved|rejected|completed|cancelled`',
    `action_type` STRING COMMENT 'Category of personnel change. [ENUM-REF-CANDIDATE: return_from_leave — promote to reference product]. Valid values are `hire|transfer|promotion|demotion|termination|leave_of_absence`',
    `approval_status` STRING COMMENT 'Current status of the approval workflow.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the action was approved or rejected.',
    `comments` STRING COMMENT 'Additional free‑form notes captured by HR during processing.',
    `effective_date` DATE COMMENT 'Date on which the personnel action becomes effective for payroll and benefits.',
    `effective_timestamp` TIMESTAMP COMMENT 'Exact moment (date and time) the action takes effect.',
    `hr_action_code` STRING COMMENT 'SAP HR module code representing the specific action type.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the action is considered critical for operations or compliance.',
    `is_gmp_required` BOOLEAN COMMENT 'True if the role is subject to Good Manufacturing Practice qualification.',
    `is_osh_training_required` BOOLEAN COMMENT 'True if the employee must complete OSHA PSM or related safety training for the new role.',
    `is_safety_critical` BOOLEAN COMMENT 'True if the action impacts safety‑critical roles or equipment.',
    `new_org_unit_code` STRING COMMENT 'Code of the org unit the employee belongs to after the action.',
    `new_pay_grade` STRING COMMENT 'Pay grade of the employee after the action.',
    `previous_org_unit_code` STRING COMMENT 'Code of the org unit the employee belonged to before the action.',
    `previous_pay_grade` STRING COMMENT 'Pay grade of the employee prior to the action.',
    `reason_code` STRING COMMENT 'Standardized code describing why the personnel action was initiated.',
    `reason_description` STRING COMMENT 'Free‑text explanation of the reason for the action.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the employee action record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employee action record.',
    `request_date` DATE COMMENT 'Date the personnel action request was entered into the system.',
    CONSTRAINT pk_employee_action PRIMARY KEY(`employee_action_id`)
) COMMENT 'Transactional record of a personnel action event in the employee lifecycle at Chemical Mfg, including hire, transfer, promotion, demotion, role change, plant reassignment, leave of absence, return from leave, and termination. Captures action type, effective date, previous and new position/org unit/pay grade, reason code, approver, and SAP HR action code. Provides the complete employment history audit trail required for labor law compliance and OSHA recordkeeping.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` (
    `labor_agreement_id` BIGINT COMMENT 'Unique system-generated identifier for the collective bargaining agreement.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Labor agreements are often scoped to a particular org unit; adding org_unit_id creates this association.',
    `agreement_document_url` STRING COMMENT 'Link to the stored digital copy of the agreement.',
    `agreement_number` STRING COMMENT 'External reference number or code assigned to the agreement by the union or company.',
    `agreement_type` STRING COMMENT 'Category of the labor agreement, e.g., collective bargaining agreement.. Valid values are `CBA|Collective_Bargaining_Agreement|Union_Contract`',
    `amendment_count` STRING COMMENT 'Number of times the agreement has been amended.',
    `approval_authority` STRING COMMENT 'Name or role of the individual/committee that approved the agreement.',
    `benefits_included` STRING COMMENT 'List of employee benefits covered (e.g., health, pension, paid leave).',
    `coverage_scope` STRING COMMENT 'Geographic or operational scope covered by the agreement (e.g., specific plant, region, or company‑wide).. Valid values are `plant|region|global`',
    `document_version` STRING COMMENT 'Version identifier of the agreement document.',
    `effective_end_date` DATE COMMENT 'Date on which the agreement expires or terminates (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the agreement becomes binding.',
    `grievance_procedure` STRING COMMENT 'Outline of the process for filing and resolving employee grievances.',
    `hazard_classifications` STRING COMMENT 'Any hazard‑related provisions (e.g., GHS, OSHA) included in the agreement.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the agreement applies exclusively to the covered workforce.',
    `is_mandatory_training` BOOLEAN COMMENT 'True if the agreement requires specific safety or certification training.',
    `job_classifications_covered` STRING COMMENT 'Comma‑separated list of job families or classifications that the agreement applies to.',
    `labor_agreement_status` STRING COMMENT 'Current lifecycle state of the agreement.. Valid values are `active|inactive|pending|terminated|draft`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the agreement.',
    `last_review_date` DATE COMMENT 'Date when the agreement was last reviewed for compliance or renewal.',
    `minimum_wage_rate` DECIMAL(18,2) COMMENT 'Base hourly wage floor stipulated by the agreement.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the agreement.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Factor applied to base wage for overtime hours.',
    `overtime_rule_description` STRING COMMENT 'Narrative of overtime eligibility and calculation method.',
    `ratification_status` STRING COMMENT 'Whether the agreement has been formally ratified by the union and management.. Valid values are `ratified|pending|rejected`',
    `ratified_date` DATE COMMENT 'Date on which the agreement was officially ratified.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `renewal_option` STRING COMMENT 'Mechanism for renewing the agreement after expiry.. Valid values are `auto|manual|none`',
    `seniority_rule_description` STRING COMMENT 'Explanation of seniority‑based assignment or promotion rules.',
    `seniority_years_required` STRING COMMENT 'Minimum years of service required for certain benefits or assignments.',
    `shift_differential_details` STRING COMMENT 'Description of any shift‑differential pay rules (e.g., night shift premium).',
    `shift_differential_percent` DECIMAL(18,2) COMMENT 'Percentage premium for non‑standard shifts.',
    `training_requirements` STRING COMMENT 'Description of training or certification requirements mandated by the agreement.',
    `union_contact_email` STRING COMMENT 'Email address for the union contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `union_contact_name` STRING COMMENT 'Primary contact person at the union for this agreement.',
    `union_contact_phone` STRING COMMENT 'Phone number for the union contact.',
    `union_name` STRING COMMENT 'Legal name of the labor union that negotiated the agreement.',
    CONSTRAINT pk_labor_agreement PRIMARY KEY(`labor_agreement_id`)
) COMMENT 'Master record of collective bargaining agreements (CBAs) and labor union contracts governing employment terms for unionized Chemical Mfg plant workers. Captures union name, agreement effective and expiry dates, covered job classifications, plant scope, key provisions (shift differentials, overtime rules, seniority-based assignment, grievance procedures), and ratification status. Drives shift scheduling rules, overtime eligibility, and labor cost modeling for unionized facilities.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` (
    `disciplinary_action_id` BIGINT COMMENT 'System-generated unique identifier for the disciplinary action record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee subject to the disciplinary action.',
    `tertiary_disciplinary_hr_business_partner_employee_id` BIGINT COMMENT 'Identifier of the HR business partner responsible for handling the disciplinary case.',
    `acknowledgment_date` DATE COMMENT 'Date on which the employee acknowledged the disciplinary action.',
    `acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the employee has formally acknowledged receipt of the disciplinary action.',
    `action_number` STRING COMMENT 'External reference number assigned to the disciplinary action for tracking and audit purposes.',
    `action_type` STRING COMMENT 'Category of the disciplinary action taken against the employee.. Valid values are `verbal_warning|written_warning|suspension|performance_improvement_plan|termination`',
    `appeal_deadline` DATE COMMENT 'Last date by which the employee may file an appeal.',
    `appeal_status` STRING COMMENT 'Current status of any appeal filed against the disciplinary action.. Valid values are `none|filed|under_review|upheld|overturned`',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which any required corrective action must be completed.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether a corrective action plan must be completed as part of the disciplinary process.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disciplinary action record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the penalty amount.. Valid values are `^[A-Z]{3}$`',
    `disciplinary_action_status` STRING COMMENT 'Current lifecycle status of the disciplinary action.. Valid values are `open|under_review|resolved|closed|appealed|expunged`',
    `effective_date` DATE COMMENT 'Date on which the disciplinary action becomes effective.',
    `expungement_date` DATE COMMENT 'Date on which the disciplinary record is scheduled to be removed from the employees permanent record, if applicable.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments related to the disciplinary action.',
    `outcome` STRING COMMENT 'Resulting outcome after the disciplinary process is completed.. Valid values are `warning_issued|suspension_imposed|termination_executed|pip_completed`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty associated with the disciplinary action, such as salary deduction or fine.',
    `policy_reference` STRING COMMENT 'Identifier or code of the specific policy that was violated.',
    `policy_violation_flag` BOOLEAN COMMENT 'Indicates whether the action was triggered by a violation of a specific company policy.',
    `reason_code` STRING COMMENT 'Standardized code representing the reason for the disciplinary action (e.g., safety_violation, attendance, conduct).',
    `reason_description` STRING COMMENT 'Free‑text description providing details of why the disciplinary action was taken.',
    `review_date` DATE COMMENT 'Date scheduled for a post‑action review to assess effectiveness and compliance.',
    `severity_level` STRING COMMENT 'Severity rating of the disciplinary action based on impact and policy.. Valid values are `low|medium|high|critical`',
    `suspension_end_date` DATE COMMENT 'End date of a suspension period.',
    `suspension_start_date` DATE COMMENT 'Start date of a suspension period, if the action type is suspension.',
    `termination_date` DATE COMMENT 'Effective date of employment termination, if the action type is termination.',
    `training_completion_deadline` DATE COMMENT 'Deadline for completing any required remedial training.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates if the employee must complete remedial training as part of the disciplinary action.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the disciplinary action record.',
    CONSTRAINT pk_disciplinary_action PRIMARY KEY(`disciplinary_action_id`)
) COMMENT 'Transactional record of a formal disciplinary action taken against a Chemical Mfg employee, including verbal warning, written warning, suspension, performance improvement plan (PIP), and termination for cause. Captures action type, effective date, reason (safety violation, GMP deviation, attendance, conduct), issuing supervisor, HR business partner, employee acknowledgment, appeal status, and expungement date. Supports progressive discipline management and OSHA recordkeeping for safety-related violations.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`competency_profile` (
    `competency_profile_id` BIGINT COMMENT 'Primary key for competency_profile',
    `superseded_competency_profile_id` BIGINT COMMENT 'Self-referencing FK on competency_profile (superseded_competency_profile_id)',
    `competency_category` STRING COMMENT 'High‑level classification of the competency (e.g., core, support, leadership).',
    `competency_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall competency level (0.00‑100.00).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the competency profile record was first created.',
    `competency_profile_description` STRING COMMENT 'Detailed textual description of the competency profile and its purpose.',
    `effective_end_date` DATE COMMENT 'Date when the competency profile expires or is retired (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the competency profile becomes effective.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the competency profile is mandatory for the associated job roles.',
    `last_review_date` DATE COMMENT 'Date when the competency profile was last reviewed.',
    `next_review_date` DATE COMMENT 'Planned date for the next review of the competency profile.',
    `owner_role` STRING COMMENT 'Job role of the owner within the organization.',
    `proficiency_level` STRING COMMENT 'Target proficiency level for the competency.',
    `profile_code` STRING COMMENT 'External business code used to reference the competency profile in HR systems.',
    `profile_name` STRING COMMENT 'Human‑readable name of the competency profile.',
    `profile_type` STRING COMMENT 'Category indicating the nature of the competency profile.',
    `required_training_hours` STRING COMMENT 'Total number of training hours required to achieve the competency.',
    `competency_profile_status` STRING COMMENT 'Current lifecycle status of the competency profile.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the competency profile record.',
    `version_number` STRING COMMENT 'Version of the competency profile for change management.',
    CONSTRAINT pk_competency_profile PRIMARY KEY(`competency_profile_id`)
) COMMENT 'Master reference table for competency_profile. Referenced by competency_profile_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`timesheet` (
    `timesheet_id` BIGINT COMMENT 'Primary key for timesheet',
    `approved_by_employee_id` BIGINT COMMENT 'Employee who approved the timesheet.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who logged the work.',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the physical site where the work was performed.',
    `corrected_timesheet_id` BIGINT COMMENT 'Self-referencing FK on timesheet (corrected_timesheet_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the timesheet was approved.',
    `bill_rate_per_hour` DECIMAL(18,2) COMMENT 'Hourly billing rate applied to billable hours.',
    `comments` STRING COMMENT 'Free‑form text entered by the employee or approver.',
    `cost_center_code` STRING COMMENT 'Accounting cost center to which labor costs are charged.',
    `created_by_system` STRING COMMENT 'Name of the source system that created the record (e.g., Workday, SAP).',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `department_code` STRING COMMENT 'Organizational department responsible for the work.',
    `external_reference` STRING COMMENT 'Identifier used by an external time‑tracking or payroll system.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the recorded hours are billable to a customer or internal cost.',
    `labor_category` STRING COMMENT 'Functional category of the labor performed.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Hours worked beyond the regular schedule that are compensated at an overtime rate.',
    `period_end_date` DATE COMMENT 'Last calendar date covered by the timesheet.',
    `period_start_date` DATE COMMENT 'First calendar date covered by the timesheet.',
    `project_code` STRING COMMENT 'Identifier of the project or work order linked to the timesheet.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the timesheet record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the timesheet record.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Hours worked at the standard rate, excluding overtime.',
    `shift_type` STRING COMMENT 'Classification of the work shift for the period.',
    `timesheet_status` STRING COMMENT 'Current lifecycle state of the timesheet.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date‑time when the employee submitted the completed timesheet.',
    `timesheet_number` STRING COMMENT 'Human‑readable identifier assigned to the timesheet, often used in reports and communications.',
    `total_hours` DECIMAL(18,2) COMMENT 'Aggregate number of hours (regular + overtime) recorded for the period.',
    `work_type` STRING COMMENT 'Classification of the work for labor accounting purposes.',
    CONSTRAINT pk_timesheet PRIMARY KEY(`timesheet_id`)
) COMMENT 'Master reference table for timesheet. Referenced by timesheet_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`workforce`.`crew` (
    `crew_id` BIGINT COMMENT 'Primary key for crew',
    `functional_location_id` BIGINT COMMENT 'Identifier of the primary work location for the crew.',
    `parent_crew_id` BIGINT COMMENT 'Self-referencing FK on crew (parent_crew_id)',
    `average_experience_years` DECIMAL(18,2) COMMENT 'Average years of experience among crew members.',
    `compliance_status` STRING COMMENT 'Current compliance status of the crew with OSHA and GMP requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the crew record was first created in the system.',
    `crew_code` STRING COMMENT 'External code used to reference the crew in operational systems.',
    `crew_size` STRING COMMENT 'Number of personnel assigned to the crew.',
    `crew_type` STRING COMMENT 'Category of crew based on functional role.',
    `effective_end_date` DATE COMMENT 'Date when the crews effectiveness ends or is retired; null if ongoing.',
    `effective_start_date` DATE COMMENT 'Date when the crew became effective for assignments.',
    `last_training_date` DATE COMMENT 'Date of the most recent mandatory training completed by the crew.',
    `crew_name` STRING COMMENT 'Human-readable name of the crew.',
    `notes` STRING COMMENT 'Additional free-text notes about the crew.',
    `safety_certification_required` BOOLEAN COMMENT 'Indicates whether crew members must hold safety certifications.',
    `shift` STRING COMMENT 'Standard shift pattern assigned to the crew.',
    `crew_status` STRING COMMENT 'Current lifecycle status of the crew.',
    `supervisor_name` STRING COMMENT 'Full legal name of the crews supervising manager.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the crew record.',
    CONSTRAINT pk_crew PRIMARY KEY(`crew_id`)
) COMMENT 'Master reference table for crew. Referenced by crew_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ADD CONSTRAINT `fk_workforce_job_role_competency_profile_id` FOREIGN KEY (`competency_profile_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`competency_profile`(`competency_profile_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ADD CONSTRAINT `fk_workforce_job_role_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ADD CONSTRAINT `fk_workforce_labor_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ADD CONSTRAINT `fk_workforce_labor_time_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ADD CONSTRAINT `fk_workforce_labor_time_entry_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`timesheet`(`timesheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ADD CONSTRAINT `fk_workforce_employee_competency_competency_id` FOREIGN KEY (`competency_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`competency`(`competency_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ADD CONSTRAINT `fk_workforce_employee_competency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ADD CONSTRAINT `fk_workforce_employee_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ADD CONSTRAINT `fk_workforce_employee_action_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ADD CONSTRAINT `fk_workforce_employee_action_position_id` FOREIGN KEY (`position_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ADD CONSTRAINT `fk_workforce_labor_agreement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_tertiary_disciplinary_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_disciplinary_hr_business_partner_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency_profile` ADD CONSTRAINT `fk_workforce_competency_profile_superseded_competency_profile_id` FOREIGN KEY (`superseded_competency_profile_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`competency_profile`(`competency_profile_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_corrected_timesheet_id` FOREIGN KEY (`corrected_timesheet_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`timesheet`(`timesheet_id`);
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_parent_crew_id` FOREIGN KEY (`parent_crew_id`) REFERENCES `chemical_mfg_ecm`.`workforce`.`crew`(`crew_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `chemical_mfg_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'workforce_records');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier (MGRID)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `rough_cut_capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level (ACCESSLVL)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'level1|level2|level3|level4');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Home Address (ADDRESS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Annual Salary (ANNSAL)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `annual_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `annual_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `badge_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Badge Expiration Date (BADGEEXP)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `badge_number` SET TAGS ('dbx_business_glossary_term' = 'Badge Number (BADGE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `benefits_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Benefits Eligible Flag (BENEFELIG)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type (COMPTYPE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|contract');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date (CONEND)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date (CONSTART)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `contractor_company_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Company Name (CONTRACTCO)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CCODE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code (DEPTCODE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone (EMERGPHONE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `employee_type` SET TAGS ('dbx_business_glossary_term' = 'Employee Type (EMPTYPE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `employee_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|service_provider');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status (EMPSTATUS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|leave_of_absence');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name (FN)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `gmp_qualification_flag` SET TAGS ('dbx_business_glossary_term' = 'GMP Qualification Flag (GMPQUAL)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date (HIREDATE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date (INSEXPD)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `insurance_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Status (INSVERSTAT)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `insurance_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|expired');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code (JOBCODE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title (JOBTITLE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (LN)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `osha_training_date` SET TAGS ('dbx_business_glossary_term' = 'OSHA Training Date (OSHATRNG)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PHONE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `ppe_required_flag` SET TAGS ('dbx_business_glossary_term' = 'PPE Required Flag (PPEFLAG)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `psm_training_date` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management Training Date (PSMTRNG)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATEDTS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `safety_training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Completed Flag (SAFETRNG)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `safety_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Completion Date (SAFETRNGDATE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade (SALGRADE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `salary_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `salary_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `sap_personnel_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Personnel Number (SAPPN)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `site_access_authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Site Access Authorization Level (SITEACC)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `site_access_authorization_level` SET TAGS ('dbx_value_regex' = 'basic|elevated|admin');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `sponsoring_department` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Department (SPONDEPT)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TERMDATE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'workforce_records');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `budget` SET TAGS ('dbx_business_glossary_term' = 'Position Budget');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `budgeted_headcount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `creation_source` SET TAGS ('dbx_business_glossary_term' = 'Position Creation Source');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `ehs_training_required` SET TAGS ('dbx_business_glossary_term' = 'EHS Training Required');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `filled_flag` SET TAGS ('dbx_business_glossary_term' = 'Filled Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `fte` SET TAGS ('dbx_business_glossary_term' = 'Full‑Time Equivalent (FTE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `grade_band` SET TAGS ('dbx_business_glossary_term' = 'Grade Band');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `is_safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety‑Critical Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `last_filled_date` SET TAGS ('dbx_business_glossary_term' = 'Last Filled Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `position_category` SET TAGS ('dbx_business_glossary_term' = 'Position Category');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|filled|on_hold|closed|inactive');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'full_time|temporary|contract|intern');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `psm_operator_required` SET TAGS ('dbx_business_glossary_term' = 'PSM Operator Required');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `reports_to_position_code` SET TAGS ('dbx_business_glossary_term' = 'Reports‑To Position Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `required_education` SET TAGS ('dbx_business_glossary_term' = 'Required Education');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `required_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Required Experience (Years)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Salary Range');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Salary Range');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|swing|night|flex');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'workforce_records');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_value_regex' = 'ISO9001|ISO14001|ISO45001|GHS|REACH');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 alpha-3)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (MWh)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `facility_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Facility Area (sqm)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_planned` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `operating_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Per Week');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Path');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Level');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_value_regex' = 'department|plant|cost_center|function|division');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `safety_training_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Required');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`org_unit` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'day|night|rotating|flex');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` SET TAGS ('dbx_subdomain' = 'workforce_records');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Identifier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `competency_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Profile Identifier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Required Training Course Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `average_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Average Experience (Years)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Owning Department');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'FLSA Classification');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt|unknown');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `gmp_qualification_required` SET TAGS ('dbx_business_glossary_term' = 'GMP Qualification Required');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `is_unionized` SET TAGS ('dbx_business_glossary_term' = 'Unionized Position Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `job_role_description` SET TAGS ('dbx_business_glossary_term' = 'Job Role Description');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `job_role_status` SET TAGS ('dbx_business_glossary_term' = 'Job Role Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `job_role_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `location_scope` SET TAGS ('dbx_business_glossary_term' = 'Location Scope');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `location_scope` SET TAGS ('dbx_value_regex' = 'plant|site|global');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `pay_grade_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pay Grade');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `pay_grade_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pay Grade');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `psm_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management Critical Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `regulatory_training_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Training Required');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Job Role Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `role_family` SET TAGS ('dbx_business_glossary_term' = 'Job Role Family');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Job Role Name');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `safety_training_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Required');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Required Training Modules');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `typical_shift` SET TAGS ('dbx_business_glossary_term' = 'Typical Shift Pattern');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `typical_shift` SET TAGS ('dbx_value_regex' = 'day|night|rotating');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`job_role` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'shift_operations');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Identifier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Minutes)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `employee_qualification_required` SET TAGS ('dbx_business_glossary_term' = 'Required Employee Qualification');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `is_flexible` SET TAGS ('dbx_business_glossary_term' = 'Flexibility Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `is_gmp_covered` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice Coverage Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `is_psm_covered` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management Coverage Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `max_consecutive_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Consecutive Working Days');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `min_rest_hours_between_shifts` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rest Hours Between Shifts');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `overtime_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overtime Allowed Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `rotation_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Rotation Cycle (Days)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Name');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Type');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'rotating|fixed|flex');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_category` SET TAGS ('dbx_business_glossary_term' = 'Shift Category');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_category` SET TAGS ('dbx_value_regex' = 'day|swing|night|weekend|holiday');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_group` SET TAGS ('dbx_business_glossary_term' = 'Shift Group');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_group` SET TAGS ('dbx_value_regex' = 'operations|maintenance|lab|admin');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_pattern_details` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern Details');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|retired');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `work_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Work Hours Per Day');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` SET TAGS ('dbx_subdomain' = 'shift_operations');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Shift End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Shift Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Number (ASSIGN_NUM)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'regular|temporary|overtime|training');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Minutes)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Change Reason');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `crew_designation` SET TAGS ('dbx_business_glossary_term' = 'Crew Designation');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Notes');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `overtime_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Authorized Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `overtime_reason` SET TAGS ('dbx_business_glossary_term' = 'Overtime Reason');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `plant_location_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Location Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `plant_location_code` SET TAGS ('dbx_value_regex' = '^PL[0-9]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `relief_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Relief Coverage Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `safety_training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Completed Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration (Hours)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_pattern_description` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern Description');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|on_hold');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|weekend');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System for Assignment');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'MES|Manual|HRIS');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` SET TAGS ('dbx_subdomain' = 'shift_operations');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `labor_time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Time Entry Identifier (LABOR_TIME_ENTRY_ID)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (EMP_ID)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOC_ID)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (DEPT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Identifier (TIMESHEET_ID)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `absence_type` SET TAGS ('dbx_business_glossary_term' = 'Absence Type (ABSENCE_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `absence_type` SET TAGS ('dbx_value_regex' = 'none|vacation|sick|personal|unpaid');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type (ACTIVITY_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'production|maintenance|training|downtime|admin');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (APPROVED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `cost_object_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Identifier (COST_OBJ_ID)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `cost_object_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Type (COST_OBJ_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `cost_object_type` SET TAGS ('dbx_value_regex' = 'production_order|maintenance_work_order|cost_center|project');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift End Timestamp (SHIFT_END_TS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `entered_by` SET TAGS ('dbx_business_glossary_term' = 'Entered By User Identifier (ENTERED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp (ENTRY_TS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code (JOB_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category (LABOR_CAT)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `labor_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|support|training');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost (LABOR_COST)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `labor_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Center Code (LABOR_COST_CENTER)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `labor_entry_source` SET TAGS ('dbx_business_glossary_term' = 'Labor Entry Source (LABOR_ENTRY_SRC)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `labor_entry_source` SET TAGS ('dbx_value_regex' = 'manual|system|mobile');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `labor_project_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Project Code (LABOR_PROJECT_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `labor_rate` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate (LABOR_RATE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `labor_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Currency (LABOR_RATE_CURR)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `labor_time_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `labor_time_entry_status` SET TAGS ('dbx_value_regex' = 'active|deleted');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number (LINE_SEQ)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Entry Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `overtime_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Overtime Approval Required Flag (OT_APPROVAL_REQUIRED)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag (OT_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked (OT_HRS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment Required Flag (PPE_REQUIRED)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked (REG_HRS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `safety_training_completed` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Completed Flag (SAFETY_TRAINING_COMPLETED)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift (SHIFT)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level (SKILL_LEVEL)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'junior|mid|senior|expert');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Timestamp (SHIFT_START_TS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked (TOTAL_HRS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_time_entry` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date (WORK_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` SET TAGS ('dbx_subdomain' = 'shift_operations');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Record ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_number` SET TAGS ('dbx_business_glossary_term' = 'Absence Record Number (ABSENCE_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_record_status` SET TAGS ('dbx_business_glossary_term' = 'Absence Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_record_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|completed');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_type` SET TAGS ('dbx_business_glossary_term' = 'Absence Type (ABSENCE_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_type` SET TAGS ('dbx_value_regex' = 'vacation|sick|injury|maternity|paternity|other');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Absence End Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Absence End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `is_fmla_eligible` SET TAGS ('dbx_business_glossary_term' = 'FMLA Eligibility Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `is_osha_recordable` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `leave_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance After Absence');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `leave_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Before Absence');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_status` SET TAGS ('dbx_value_regex' = 'required|provided|exempt|pending');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `paid_leave_flag` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Indicator');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason Description');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Request Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Absence Request Source');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `request_source` SET TAGS ('dbx_value_regex' = 'self_service|hr_portal|manager|hr_rep');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return‑to‑Work Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Start Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Absence Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `total_days` SET TAGS ('dbx_business_glossary_term' = 'Total Absence Days (TOTAL_DAYS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Absence Hours (TOTAL_HOURS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`absence_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Identifier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `competency_category` SET TAGS ('dbx_business_glossary_term' = 'Competency Category');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `competency_category` SET TAGS ('dbx_value_regex' = 'technical|safety|regulatory|leadership|license|certification');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `competency_code` SET TAGS ('dbx_business_glossary_term' = 'Competency Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `competency_description` SET TAGS ('dbx_business_glossary_term' = 'Competency Description');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `competency_group` SET TAGS ('dbx_business_glossary_term' = 'Competency Group');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `competency_name` SET TAGS ('dbx_business_glossary_term' = 'Competency Name');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `competency_status` SET TAGS ('dbx_business_glossary_term' = 'Competency Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `competency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `competency_type` SET TAGS ('dbx_business_glossary_term' = 'Competency Type');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `competency_type` SET TAGS ('dbx_value_regex' = 'skill|certification|license');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_value_regex' = 'novice|intermediate|advanced|expert');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `proficiency_scale` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Scale');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `renewal_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Interval (Months)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `subgroup` SET TAGS ('dbx_business_glossary_term' = 'Competency Subgroup');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period (Months)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Competency Version');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `employee_competency_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Competency Record ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Catalog ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `competency_validity_years` SET TAGS ('dbx_business_glossary_term' = 'Competency Validity (Years)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `current_status` SET TAGS ('dbx_business_glossary_term' = 'Current Competency Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `current_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `expiration_policy` SET TAGS ('dbx_business_glossary_term' = 'Expiration Policy');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `expiration_policy` SET TAGS ('dbx_value_regex' = 'fixed|rolling');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `practical_evaluation_result` SET TAGS ('dbx_business_glossary_term' = 'Practical Evaluation Result');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `practical_evaluation_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `process_unit` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_value_regex' = 'beginner|intermediate|advanced|expert|pass|fail');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'initial|periodic|requalification|recertification');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `record_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `record_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'due|not_due|overdue');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `verification_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Reference');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_competency` ALTER COLUMN `written_test_score` SET TAGS ('dbx_business_glossary_term' = 'Written Test Score');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type (ASMT_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'exam|practical|simulation|none');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name (CERT_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag (CERT_REQ)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMP_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Course Cost Amount (COST_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Course Cost Currency (COST_CURR)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code (CODE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type (TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `course_type` SET TAGS ('dbx_value_regex' = 'safety|technical|compliance|orientation|leadership');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Units (CEU)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method (DM)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|online|hands-on|blended');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Course Duration (HRS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name (INSTR)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `is_external_provider` SET TAGS ('dbx_business_glossary_term' = 'External Provider Flag (EXTERNAL)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag (MANDATORY)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Course Language (LANG)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'EN|ES|FR|DE|ZH|JA');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (REVIEW_DT)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `max_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment (MAX_ENR)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `pass_fail_threshold` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Threshold (THRESH)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `prerequisite_course_codes` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Course Codes (PREREQ)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `regulatory_mandate` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate (RM)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `requalification_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Requalification Interval (DAYS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `review_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Review Interval (REVIEW_INT)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Course Title (TITLE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category (CAT)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'OSHA|GMP|HAZMAT|DOT|EHS|General');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description (DESC)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|retired');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`training_course` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VER)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_subdomain' = 'planning_governance');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Identifier (HPID)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `actual_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount (AHC)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (AS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (AB)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (AD)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte` SET TAGS ('dbx_business_glossary_term' = 'Approved Full‑Time Equivalent (Approved FTE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budgeted_headcount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount (BHC)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Status (HPS)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `is_contractor_allowed` SET TAGS ('dbx_business_glossary_term' = 'Contractor Allowed Flag (CAF)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `is_filled` SET TAGS ('dbx_business_glossary_term' = 'Filled Flag (FF)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `is_gmp_required` SET TAGS ('dbx_business_glossary_term' = 'GMP Requirement Flag (GMPRF)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `is_psm_critical` SET TAGS ('dbx_business_glossary_term' = 'PSM Critical Flag (PSMCF)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `last_review_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By (LRB)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LRD)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Description (HPD)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Name (HPN)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Type (HPT)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'strategic|operational|tactical');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_category` SET TAGS ('dbx_business_glossary_term' = 'Planning Category (PC)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_category` SET TAGS ('dbx_value_regex' = 'new_hire|backfill|contractor_conversion|reallocation');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period_end` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date (PPED)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period_start` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date (PPSD)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PC)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `target_fte` SET TAGS ('dbx_business_glossary_term' = 'Target Full‑Time Equivalent (Target FTE)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` SET TAGS ('dbx_subdomain' = 'workforce_records');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `employee_action_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Action ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Position ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Action Number');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'hire|transfer|promotion|demotion|termination|leave_of_absence');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `hr_action_code` SET TAGS ('dbx_business_glossary_term' = 'HR Action Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `is_gmp_required` SET TAGS ('dbx_business_glossary_term' = 'Is GMP Required');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `is_osh_training_required` SET TAGS ('dbx_business_glossary_term' = 'Is OSHA Training Required');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `is_safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Safety Critical');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'New Organizational Unit Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_pay_grade` SET TAGS ('dbx_business_glossary_term' = 'New Pay Grade');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Organizational Unit Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Previous Pay Grade');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`employee_action` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` SET TAGS ('dbx_subdomain' = 'planning_governance');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `labor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Agreement Identifier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_document_url` SET TAGS ('dbx_business_glossary_term' = 'Agreement Document URL');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'CBA|Collective_Bargaining_Agreement|Union_Contract');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `benefits_included` SET TAGS ('dbx_business_glossary_term' = 'Benefits Included');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Coverage Scope');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_value_regex' = 'plant|region|global');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `grievance_procedure` SET TAGS ('dbx_business_glossary_term' = 'Grievance Procedure');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `hazard_classifications` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classifications');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Agreement Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `is_mandatory_training` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `job_classifications_covered` SET TAGS ('dbx_business_glossary_term' = 'Job Classifications Covered');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `labor_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `labor_agreement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|draft');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `minimum_wage_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Wage Rate');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `minimum_wage_rate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `minimum_wage_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `overtime_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rule Description');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `ratification_status` SET TAGS ('dbx_business_glossary_term' = 'Ratification Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `ratification_status` SET TAGS ('dbx_value_regex' = 'ratified|pending|rejected');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `ratified_date` SET TAGS ('dbx_business_glossary_term' = 'Ratified Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `seniority_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Seniority Rule Description');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `seniority_years_required` SET TAGS ('dbx_business_glossary_term' = 'Seniority Years Required');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `shift_differential_details` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Details');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `shift_differential_percent` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Percent');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `training_requirements` SET TAGS ('dbx_business_glossary_term' = 'Training Requirements');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `union_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Union Contact Email');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `union_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `union_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `union_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `union_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Union Contact Name');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `union_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `union_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `union_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Union Contact Phone');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `union_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `union_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`labor_agreement` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` SET TAGS ('dbx_subdomain' = 'workforce_records');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'HR Business Partner ID');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Number');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Type');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'verbal_warning|written_warning|suspension|performance_improvement_plan|termination');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'none|filed|under_review|upheld|overturned');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_status` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Status');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_status` SET TAGS ('dbx_value_regex' = 'open|under_review|resolved|closed|appealed|expunged');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `expungement_date` SET TAGS ('dbx_business_glossary_term' = 'Expungement Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Notes');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Outcome');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'warning_issued|suspension_imposed|termination_executed|pip_completed');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Policy Reference');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `policy_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Policy Violation Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Review Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `training_completion_deadline` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Deadline');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency_profile` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency_profile` ALTER COLUMN `competency_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Profile Identifier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`competency_profile` ALTER COLUMN `superseded_competency_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`timesheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`timesheet` SET TAGS ('dbx_subdomain' = 'shift_operations');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`timesheet` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Identifier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`timesheet` ALTER COLUMN `corrected_timesheet_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`crew` SET TAGS ('dbx_subdomain' = 'shift_operations');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`crew` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`crew` ALTER COLUMN `parent_crew_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`crew` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`workforce`.`crew` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_pii_name' = 'true');
