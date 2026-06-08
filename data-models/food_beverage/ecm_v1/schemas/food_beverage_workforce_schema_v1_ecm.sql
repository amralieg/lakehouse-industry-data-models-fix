-- Schema for Domain: workforce | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`workforce` COMMENT 'Human capital management including employee master data, organizational structure, payroll, benefits, time and attendance, labor scheduling for production shifts, food handler certifications, GMP/HACCP training compliance, talent management, performance management, and Workday HCM records. Supports OSHA and labor regulatory compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record.',
    `manager_employee_id` BIGINT COMMENT 'Employee ID of the direct manager.',
    `network_node_id` BIGINT COMMENT 'Reference to the primary work site or plant where the employee is assigned.',
    `badge_number` STRING COMMENT 'Physical access badge identifier assigned to the employee.',
    `cba_reference` STRING COMMENT 'Reference to the applicable collective bargaining agreement.',
    `contract_type` STRING COMMENT 'Nature of the employment contract.. Valid values are `permanent|temporary|union|consultant`',
    `cost_center_code` STRING COMMENT 'Cost center to which the employees labor costs are charged.',
    `date_of_birth` DATE COMMENT 'Employees birth date for age verification and benefits eligibility.',
    `eeo_category` STRING COMMENT 'Equal Employment Opportunity classification for reporting.. Valid values are `protected_veteran|disability|race|gender|age|none`',
    `email` STRING COMMENT 'Personal email address of the employee.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employee_status` STRING COMMENT 'Current employment status of the employee.. Valid values are `active|inactive|terminated|on_leave|retired`',
    `employment_type` STRING COMMENT 'Classification of the employment relationship.. Valid values are `full_time|part_time|seasonal|contractor|temp`',
    `flsa_status` STRING COMMENT 'Fair Labor Standards Act classification for overtime eligibility.. Valid values are `exempt|non_exempt`',
    `food_handler_certification_status` STRING COMMENT 'Status of required food safety handling certification.. Valid values are `certified|expired|not_required`',
    `gmp_training_completion_date` DATE COMMENT 'Date when Good Manufacturing Practice training was completed.',
    `haccp_training_completion_date` DATE COMMENT 'Date when HACCP training was completed.',
    `hire_date` DATE COMMENT 'Date the employee was initially hired.',
    `i9_verification_status` STRING COMMENT 'Status of the employees I-9 employment eligibility verification.. Valid values are `verified|pending|not_applicable`',
    `job_classification` STRING COMMENT 'Standard classification of the employees role within the organization.',
    `job_code` STRING COMMENT 'Internal code representing the specific job title.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance evaluation.',
    `legal_name` STRING COMMENT 'Employees legal full name as on official documents.',
    `notice_period_days` STRING COMMENT 'Required notice period for termination in days.',
    `ooo_status` STRING COMMENT 'Current out-of-office or leave status.. Valid values are `active|on_leave|vacation|sick_leave|maternity|paternity`',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates if the employee is eligible for overtime pay.',
    `pay_basis` STRING COMMENT 'Basis on which the employee is compensated.. Valid values are `hourly|salary|piece_rate|commission`',
    `performance_rating` STRING COMMENT 'Overall rating from the latest performance review.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `phone_number` STRING COMMENT 'Personal contact phone number.',
    `preferred_name` STRING COMMENT 'Employees preferred name used for internal communications.',
    `probation_period_days` STRING COMMENT 'Length of the probationary period in days.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the employee record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employee record.',
    `rehire_eligibility` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire after termination.',
    `renewal_term_months` STRING COMMENT 'Contract renewal term length in months, if applicable.',
    `safety_training_completion_date` DATE COMMENT 'Date of completion for general safety training.',
    `shift_schedule` STRING COMMENT 'Assigned work shift schedule (e.g., 1st Shift, 2nd Shift).',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Typical weekly work hours for the employee.',
    `termination_date` DATE COMMENT 'Date the employees employment ended, if applicable.',
    `union_local` STRING COMMENT 'Union local identifier for unionized employees.',
    `work_email` STRING COMMENT 'Corporate email address used for business communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_phone` STRING COMMENT 'Corporate phone number assigned to the employee.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Core master record and single source of truth for all Food Beverage workforce identity, employment agreements, and lifecycle history. Covers full-time, part-time, seasonal, and contract workers across manufacturing plants, DCs, corporate offices, and field sales. Stores Workday HCM employee ID, legal name, preferred name, employment type, hire date, termination date, rehire eligibility, job classification, FLSA status, EEO category, I-9 verification status, badge number, work location, cost center assignment, manager, HR business partner, and full employment contract details (contract type, CBA reference, union local, pay basis, standard hours, probation/notice periods, renewal terms). Captures embedded lifecycle event history (hire, transfer, promotion, termination, LOA). SSOT for workforce identity, employment agreements, and lifecycle audit — no separate contract product exists.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique surrogate key for the authorized headcount position.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Position references a Job Profile; adding position.job_profile_id FK creates parent-child relationship and removes redundant string column.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department that owns the position.',
    `reporting_manager_position_id` BIGINT COMMENT 'Position ID of the manager to whom this role reports.',
    `budgeted_headcount` STRING COMMENT 'Number of employees the organization plans to staff in this position for the budgeting period.',
    `compensation_grade` STRING COMMENT 'Internal grade used for salary banding and compensation planning.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which labor costs for the position are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the position is retired or no longer authorized (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the position becomes active for staffing.',
    `employee_group` STRING COMMENT 'Group classification such as "Hourly", "Salaried", "Contingent".',
    `filled` BOOLEAN COMMENT 'True if the authorized headcount has been assigned to an employee.',
    `filled_date` DATE COMMENT 'Date when the position was filled by an employee.',
    `food_handler_cert_required` BOOLEAN COMMENT 'True if the position requires a valid food‑handler certification.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Proportion of a full‑time workload assigned to the position (e.g., 1.00 for full‑time, 0.50 for half‑time).',
    `gmp_zone_required` BOOLEAN COMMENT 'True if the role must work in a GMP‑controlled area.',
    `is_contract` BOOLEAN COMMENT 'True if the role is filled by a contract worker.',
    `is_exempt` BOOLEAN COMMENT 'True if the position is exempt from overtime regulations.',
    `is_temp` BOOLEAN COMMENT 'True if the position is intended for temporary staffing.',
    `job_family` STRING COMMENT 'Broad classification grouping similar jobs, such as "Manufacturing" or "Quality Assurance".',
    `management_level` STRING COMMENT 'Hierarchy level of the position, e.g., "Supervisor", "Manager", "Director".',
    `overtime_eligible` BOOLEAN COMMENT 'True if employees in this position may accrue overtime.',
    `position_category` STRING COMMENT 'High‑level functional category of the position.. Valid values are `production|logistics|admin|sales|quality|R&D`',
    `position_code` STRING COMMENT 'External business identifier for the position, used in HR and budgeting systems.',
    `position_description` STRING COMMENT 'Narrative description of duties, responsibilities, and scope of the role.',
    `position_level` STRING COMMENT 'Indicates seniority or pay scale level, e.g., "Entry", "Mid", "Senior".',
    `position_status` STRING COMMENT 'Current lifecycle status of the position.. Valid values are `open|filled|closed|on_hold`',
    `position_type` STRING COMMENT 'Classification of employment relationship for the position.. Valid values are `full_time|part_time|temporary|contract`',
    `remote_allowed` BOOLEAN COMMENT 'Indicates whether the position can be performed remotely.',
    `required_certifications` STRING COMMENT 'Comma‑separated list of mandatory certifications (e.g., "GMP, HACCP").',
    `required_training_hours` DECIMAL(18,2) COMMENT 'Minimum training hours a new hire must complete before assuming the role.',
    `safety_sensitive` BOOLEAN COMMENT 'Indicates if the role is classified as safety‑sensitive under OSHA regulations.',
    `salary_range_max` DECIMAL(18,2) COMMENT 'Upper bound of the salary band for the position.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'Lower bound of the salary band for the position.',
    `shift_type` STRING COMMENT 'Scheduled work shift pattern for the position.. Valid values are `day|night|rotating`',
    `title` STRING COMMENT 'Human‑readable name of the role, e.g., "Production Line Supervisor".',
    `travel_required` BOOLEAN COMMENT 'True if any travel is required for the position.',
    `travel_required_percent` DECIMAL(18,2) COMMENT 'Expected proportion of time spent traveling for the role.',
    `union_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for union representation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the position record.',
    `vacancy_reason` STRING COMMENT 'Reason why the position is currently vacant.. Valid values are `new|replaced|reorganization|budget_cut`',
    `work_location` STRING COMMENT 'Physical site or plant where the position is based, identified by plant code or address.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized headcount positions within the organizational structure, representing approved roles that may or may not be filled. Captures position code, job profile, job family, management level, FTE allocation, budgeted headcount, work location, shift type (day/night/rotating), union eligibility, GMP zone requirement, food handler certification requirement, and whether the position is safety-sensitive under OSHA. Sourced from Workday HCM Position Management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique surrogate key for the organizational unit.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the manager responsible for the unit.',
    `network_node_id` BIGINT COMMENT 'Identifier of the physical location (plant, DC, office) associated with the unit.',
    `parent_org_unit_id` BIGINT COMMENT 'Identifier of the immediate parent org unit in the hierarchy.',
    `approval_status` STRING COMMENT 'Approval state of the headcount plan for the unit.. Valid values are `approved|pending|rejected`',
    `attrition_rate` DECIMAL(18,2) COMMENT 'Projected attrition percentage for the unit during the planning horizon.',
    `business_unit` STRING COMMENT 'Higher‑level business unit to which the org unit belongs.',
    `cost_center_code` STRING COMMENT 'Finance cost‑center code linked to the org unit.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the org unit record was first created.',
    `effective_end_date` DATE COMMENT 'Date when the org unit ceased to be effective (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the org unit became effective.',
    `gl_account_code` STRING COMMENT 'Primary GL account associated with the org unit for budgeting.',
    `headcount_actual_fte` DECIMAL(18,2) COMMENT 'Actual FTE count recorded for the fiscal period.',
    `headcount_planned_fte` DECIMAL(18,2) COMMENT 'Approved planned FTE count for the fiscal period.',
    `headcount_target_fte` DECIMAL(18,2) COMMENT 'Target FTE headcount set for strategic planning.',
    `last_headcount_review_date` DATE COMMENT 'Date of the most recent headcount planning review for the unit.',
    `open_requisitions` STRING COMMENT 'Number of open hiring requisitions for the unit.',
    `org_unit_code` STRING COMMENT 'Business identifier code for the org unit (e.g., DEPT001, PLANT12).',
    `org_unit_description` STRING COMMENT 'Free‑form description of the units purpose and scope.',
    `org_unit_level` STRING COMMENT 'Depth level of the unit within the org hierarchy (root = 0).',
    `org_unit_name` STRING COMMENT 'Human‑readable name of the organizational unit.',
    `org_unit_status` STRING COMMENT 'Current operational status of the org unit.. Valid values are `active|inactive|planned|closed`',
    `org_unit_type` STRING COMMENT 'Classification of the org unit within the hierarchy.. Valid values are `department|division|plant|region|distribution_center`',
    `plan_version` STRING COMMENT 'Version identifier of the headcount planning scenario.',
    `region` STRING COMMENT 'Geographic region (e.g., North America, EMEA) where the unit operates.',
    `seasonal_headcount_addition` STRING COMMENT 'Additional headcount planned for seasonal peaks (e.g., holiday, harvest).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the org unit record.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational hierarchy nodes and headcount planning records representing departments, cost centers, business units, plants, and functional groups within Food Beverage. Captures org unit code, name, type (department, division, plant, DC, region), parent org unit, effective date, org level, responsible manager, associated GL cost center, active status, and headcount planning details by fiscal period (approved FTE count, actual FTE count, open requisitions, attrition assumptions, seasonal headcount additions for harvest/holiday peaks, plan version, and approval status). Supports SAP CO cost center hierarchy, Workday HCM supervisory organization structure, and workforce planning integration.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile record.',
    `compensation_currency` STRING COMMENT 'ISO 4217 currency code for the salary amounts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the job profile record was first created.',
    `education_requirements` STRING COMMENT 'Minimum education level or specific degrees/certifications needed.',
    `eeo_category` STRING COMMENT 'EEO reporting category for the role.. Valid values are `white|black|asian|hispanic|native|other`',
    `effective_end_date` DATE COMMENT 'Date when the job profile is retired or superseded; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the job profile becomes active.',
    `experience_years_required` STRING COMMENT 'Minimum years of relevant experience required.',
    `flsa_classification` STRING COMMENT 'Indicates whether the role is exempt or non‑exempt under FLSA.. Valid values are `exempt|non_exempt`',
    `gmp_training_required` BOOLEAN COMMENT 'Indicates if GMP/HACCP training is mandatory for the role.',
    `hazard_pay_eligible` BOOLEAN COMMENT 'Indicates if the role qualifies for hazard pay.',
    `health_and_safety_cert_required` BOOLEAN COMMENT 'Indicates if a health and safety certification is mandatory.',
    `job_family` STRING COMMENT 'Broad functional grouping of the role (e.g., Production, Quality, Finance).',
    `job_level` STRING COMMENT 'Numerical level indicating seniority within the job family.',
    `job_profile_code` STRING COMMENT 'Standardized alphanumeric code used to reference the job profile across systems.',
    `job_profile_description` STRING COMMENT 'Detailed narrative describing the responsibilities and scope of the role.',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of the job profile.. Valid values are `active|inactive|deprecated|pending`',
    `job_summary` STRING COMMENT 'Brief summary of the role for use in listings and internal portals.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates if the role is eligible for overtime pay.',
    `pay_grade` STRING COMMENT 'Compensation grade associated with the job profile.',
    `required_certifications` STRING COMMENT 'Pipe‑separated list of mandatory certifications (e.g., food_handler|forklift|haccp).',
    `role_type` STRING COMMENT 'Specifies whether the role is production‑floor, office, or both.. Valid values are `production|office|both`',
    `salary_max` DECIMAL(18,2) COMMENT 'Upper bound of the salary range for the role.',
    `salary_min` DECIMAL(18,2) COMMENT 'Lower bound of the salary range for the role.',
    `shift_type` STRING COMMENT 'Typical shift pattern for the role.. Valid values are `day|night|flex|rotating|on_call`',
    `skill_requirements` STRING COMMENT 'Comma‑separated list of core skills required for the role.',
    `title` STRING COMMENT 'Official title of the role as displayed to employees and managers.',
    `travel_required` BOOLEAN COMMENT 'Indicates whether the role requires regular travel.',
    `union_code` STRING COMMENT 'Identifier of the labor union representing the role, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the job profile record.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Standardized job definitions used across Food Beverage to classify roles by function, skill requirements, and compensation grade. Includes job profile code, job title, job family, job level, FLSA classification (exempt/non-exempt), EEO-1 category, pay grade range, required certifications (food handler, forklift, HACCP), GMP training requirement flag, union code, and whether the role is production-floor vs. office. Sourced from Workday HCM Job Profile catalog.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Unique surrogate key for the compensation plan.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Compensation Plan is defined per Job Profile; adding compensation_plan.job_profile_id FK links plan to its job definition.',
    `applicable_region` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code where the plan is valid; null if global.. Valid values are `^[A-Z]{3}$`',
    `approved_by` STRING COMMENT 'Identifier of the person who approved the compensation plan.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the compensation plan was approved.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Fixed monetary bonus amount awarded under the plan.',
    `bonus_eligibility` BOOLEAN COMMENT 'Indicates whether an employee qualifies for the bonus component.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission percentage applied to sales revenue for eligible employees.',
    `compensation_plan_status` STRING COMMENT 'Current lifecycle status of the plan.. Valid values are `active|inactive|draft|pending|terminated`',
    `confidentiality_level` STRING COMMENT 'Data classification indicating the sensitivity of the plan details.. Valid values are `restricted|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the compensation plan record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for monetary amounts in the plan.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the compensation plan expires or is superseded; null for open‑ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the compensation plan becomes effective.',
    `eligibility_criteria` STRING COMMENT 'Free‑text description of the business rules that determine employee eligibility for the plan.',
    `eligibility_rule` STRING COMMENT 'Standardized rule code defining the employment type required for eligibility.. Valid values are `full_time|part_time|hourly|salary|contract`',
    `grade_max` STRING COMMENT 'Highest pay grade that can be assigned under this plan.',
    `grade_midpoint` STRING COMMENT 'Midpoint pay grade for the plan, often used for market benchmarking.',
    `grade_min` STRING COMMENT 'Lowest pay grade that can be assigned under this plan.',
    `incentive_rate` DECIMAL(18,2) COMMENT 'Rate used to calculate performance‑based incentives, expressed as a decimal multiplier.',
    `is_global` BOOLEAN COMMENT 'True if the plan applies across all legal entities and regions.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the compensation plan.',
    `last_reviewed_by` STRING COMMENT 'Identifier of the person who performed the last plan review.',
    `merit_increase_percent` DECIMAL(18,2) COMMENT 'Standard merit increase percentage applied to eligible employees each review cycle.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the compensation plan.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base hourly rate for overtime hours.',
    `pay_frequency` STRING COMMENT 'How often compensation under this plan is paid.. Valid values are `monthly|biweekly|weekly|semi_monthly|annual`',
    `plan_category` STRING COMMENT 'High‑level grouping of the plan for reporting purposes.. Valid values are `salary|bonus|commission|incentive|allowance`',
    `plan_code` STRING COMMENT 'External business identifier for the compensation plan, used in payroll and HR systems.',
    `plan_name` STRING COMMENT 'Human‑readable name of the compensation plan.',
    `plan_owner` STRING COMMENT 'Name or identifier of the HR or finance owner responsible for the plan.',
    `plan_type` STRING COMMENT 'Category of the plan indicating its primary purpose (e.g., base salary, merit increase, incentive, commission, bonus).. Valid values are `base|merit|incentive|commission|bonus`',
    `plan_version` STRING COMMENT 'Incremental version number of the plan for change management.',
    `probation_period_days` STRING COMMENT 'Number of days an employee must complete before becoming eligible for the plan.',
    `shift_differential_flag` BOOLEAN COMMENT 'Indicates whether the plan includes a shift differential component.',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to base pay for eligible shift differentials (e.g., night, weekend).',
    `target_achievement_percent` DECIMAL(18,2) COMMENT 'Percentage of the target amount actually achieved, used for payout calculations.',
    `target_amount` DECIMAL(18,2) COMMENT 'Monetary target that must be achieved to earn incentive or bonus payouts.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether compensation under this plan is exempt from payroll taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the compensation plan record.',
    `vesting_schedule` STRING COMMENT 'Description of the vesting timeline for deferred compensation components.',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Compensation structures and pay programs applicable to Food Beverage workforce segments, including base pay grades, merit increase matrices, shift differential rates (night, weekend, holiday), production incentive plans, sales commission structures, and executive compensation tiers. Captures plan code, plan type, effective date, pay frequency, currency, grade minimum/midpoint/maximum, and eligibility criteria. Sourced from Workday HCM Compensation.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'System-generated unique identifier for the payroll record.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Payroll records store cost_center_code; linking to org unit aligns payroll cost center with organizational hierarchy.',
    `plant_id` BIGINT COMMENT 'Identifier of the work location (plant, warehouse, etc.) where the employee is assigned.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee receiving the payroll.',
    `approval_status` STRING COMMENT 'Current approval state of the payroll record.. Valid values are `approved|pending|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payroll record was approved.',
    `bank_account_number` STRING COMMENT 'Employees bank account number for direct deposit.',
    `bank_routing_number` STRING COMMENT 'Routing number of the employees financial institution.',
    `benefit_deductions_amount` DECIMAL(18,2) COMMENT 'Total amount deducted for employee benefits (e.g., health, retirement).',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the payroll amounts.',
    `department_code` STRING COMMENT 'Organizational department responsible for the employee.',
    `employee_ssn` STRING COMMENT 'US Social Security Number for the employee, required for tax reporting.. Valid values are `^d{3}-d{2}-d{4}$`',
    `employee_tax_code` STRING COMMENT 'Tax ID (e.g., SSN) used for payroll tax reporting.',
    `error_code` STRING COMMENT 'System error code if the payroll run failed.',
    `error_description` STRING COMMENT 'Human‑readable description of the payroll processing error.',
    `federal_tax_amount` DECIMAL(18,2) COMMENT 'Amount withheld for federal income tax.',
    `garnishment_amount` DECIMAL(18,2) COMMENT 'Amount deducted for court-ordered garnishments.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total earnings before any deductions or taxes.',
    `is_manual_adjustment` BOOLEAN COMMENT 'Indicates whether the payroll record includes a manual adjustment.',
    `job_code` STRING COMMENT 'Job classification code for the employees role.',
    `local_tax_amount` DECIMAL(18,2) COMMENT 'Amount withheld for local (city/county) taxes.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Final amount paid to the employee after all deductions.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours worked in the pay period, subject to FLSA rules.',
    `overtime_rate` DECIMAL(18,2) COMMENT 'Compensation rate applied to overtime hours.',
    `pay_method` STRING COMMENT 'Method used to deliver net pay to the employee.. Valid values are `direct_deposit|check`',
    `pay_period_end_date` DATE COMMENT 'Last calendar date of the payroll period.',
    `pay_period_start_date` DATE COMMENT 'First calendar date of the payroll period.',
    `payroll_notes` STRING COMMENT 'Free‑form notes entered by payroll administrators.',
    `payroll_number` STRING COMMENT 'Business identifier assigned to the payroll run, used for tracking and reconciliation.',
    `payroll_record_status` STRING COMMENT 'Current lifecycle status of the payroll record.. Valid values are `pending|processed|error|cancelled`',
    `payroll_run_timestamp` TIMESTAMP COMMENT 'Exact date and time when the payroll was processed.',
    `payroll_type` STRING COMMENT 'Classification of the payroll run (e.g., regular salary, bonus, commission).. Valid values are `regular|bonus|commission|overtime|adjustment`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll record.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Total regular (non-overtime) hours worked in the pay period.',
    `regular_rate` DECIMAL(18,2) COMMENT 'Base hourly compensation rate for regular hours.',
    `shift_differential_hours` DECIMAL(18,2) COMMENT 'Hours worked under a shift differential (e.g., night shift) that attract a premium rate.',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Premium rate applied to shift differential hours.',
    `state_tax_amount` DECIMAL(18,2) COMMENT 'Amount withheld for state income tax.',
    `tax_withholdings_amount` DECIMAL(18,2) COMMENT 'Aggregate of all tax withholdings (federal, state, local).',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Periodic payroll processing records capturing gross-to-net pay calculations for each employee pay period at Food Beverage. Includes pay period start/end dates, regular hours, overtime hours (FLSA), shift differential hours, gross pay, federal/state/local tax withholdings, FICA, benefit deductions, garnishments, net pay, pay method (direct deposit/check), and payroll run status. Integrates Workday HCM Payroll with SAP FI for COGS labor allocation.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`total_rewards` (
    `total_rewards_id` BIGINT COMMENT 'Primary key for total_rewards',
    `plan_id` BIGINT COMMENT 'Unique identifier of the benefit plan.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee associated with the enrollment.',
    `open_enrollment_event_id` BIGINT COMMENT 'Identifier of the open enrollment window.',
    `beneficiary_name` STRING COMMENT 'Name of the designated beneficiary.',
    `beneficiary_relationship` STRING COMMENT 'Relationship of beneficiary to employee.. Valid values are `spouse|child|parent|other`',
    `contribution_frequency` STRING COMMENT 'How often contributions are made.. Valid values are `monthly|quarterly|annual`',
    `contribution_type` STRING COMMENT 'Tax treatment of the contribution.. Valid values are `pre_tax|post_tax|roth`',
    `coverage_tier` STRING COMMENT 'Level of coverage selected.. Valid values are `employee_only|employee_spouse|family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was created.',
    `dependent_count` STRING COMMENT 'Number of dependents covered under the plan.',
    `effective_date` DATE COMMENT 'Date the benefits become effective.',
    `eligibility_status` STRING COMMENT 'Eligibility of employee for the benefit.. Valid values are `eligible|ineligible|pending`',
    `employee_address` STRING COMMENT 'Home address of the employee.',
    `employee_age` STRING COMMENT 'Age of the employee at enrollment.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Amount contributed by the employee per pay period.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Amount contributed by the employer per pay period.',
    `employer_match_percent` DECIMAL(18,2) COMMENT 'Percentage of employee contribution matched by employer.',
    `enrollment_date` DATE COMMENT 'Date the employee submitted the enrollment.',
    `enrollment_number` STRING COMMENT 'Business identifier for the enrollment transaction.',
    `enrollment_source` STRING COMMENT 'Origin of the enrollment entry.. Valid values are `self_service|hr_admin`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment.. Valid values are `active|inactive|terminated|pending`',
    `is_401k_eligible` BOOLEAN COMMENT 'Indicates if employee is eligible for 401k.',
    `is_eap_eligible` BOOLEAN COMMENT 'Indicates if employee is eligible for Employee Assistance Program.',
    `is_fsa_eligible` BOOLEAN COMMENT 'Indicates if employee is eligible for FSA.',
    `is_hsa_eligible` BOOLEAN COMMENT 'Indicates if employee is eligible for HSA.',
    `is_life_insurance_eligible` BOOLEAN COMMENT 'Indicates if employee is eligible for life insurance.',
    `notes` STRING COMMENT 'Free-text notes regarding the enrollment.',
    `payroll_deduction_code` STRING COMMENT 'Code used in payroll to deduct contributions.',
    `plan_type` STRING COMMENT 'Category of the benefit plan. [ENUM-REF-CANDIDATE: medical|dental|vision|401k|fsa|hsa|life_insurance|eap — 8 candidates stripped; promote to reference product]',
    `plan_year` STRING COMMENT 'Fiscal year of the benefit plan.',
    `tax_status` STRING COMMENT 'Employees tax filing status for benefit tax calculations.. Valid values are `single|married|head_of_household`',
    `termination_date` DATE COMMENT 'Date the enrollment was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    `vesting_schedule` STRING COMMENT 'Vesting schedule for employer contributions.. Valid values are `immediate|graded|cliff`',
    CONSTRAINT pk_total_rewards PRIMARY KEY(`total_rewards_id`)
) COMMENT 'Employee benefit plan enrollment records tracking active and historical benefit elections at Food Beverage. Captures benefit plan type (medical, dental, vision, 401k, FSA, HSA, life insurance, EAP), coverage tier (employee only, employee+spouse, family), enrollment date, effective date, termination date, employee contribution amount, employer contribution amount, and open enrollment event reference. Sourced from Workday HCM Benefits.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique identifier for the time entry record.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: Labor tracking per asset is needed for cost allocation, overtime analysis, and regulatory reporting on equipment usage.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Time entry records capture cost_center_code redundantly; linking to org unit centralizes cost center information.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the work.',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the scheduled shift template applied to this time entry.',
    `approval_status` STRING COMMENT 'Current approval state of the time entry (e.g., pending manager review, approved, or rejected).. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the time entry was approved.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the employee clocked in.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the employee clocked out.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the time entry record was first created in the system.',
    `department_code` STRING COMMENT 'Organizational department responsible for the work.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of double‑time hours worked, usually for holidays or special circumstances.',
    `hours_type` STRING COMMENT 'Classification of the hours worked (e.g., regular, overtime, holiday, PTO, FMLA).. Valid values are `regular|overtime|double_time|holiday|pto|fmla`',
    `job_code` STRING COMMENT 'Job or position code defining the employees role for the shift.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Monetary value of labor incurred for the recorded hours before any adjustments.',
    `labor_cost_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the labor cost amount (e.g., USD, EUR).',
    `meal_break_minutes` STRING COMMENT 'Length of the unpaid or paid meal break taken during the shift, in minutes.',
    `notes` STRING COMMENT 'Free‑form text for any additional comments or explanations related to the time entry.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked, typically paid at a premium rate.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Factor applied to the base hourly rate for overtime hours (e.g., 1.5).',
    `pto_hours` DECIMAL(18,2) COMMENT 'Hours recorded as paid time off (vacation, personal leave).',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular (non‑overtime) hours worked in the shift.',
    `shift_date` DATE COMMENT 'Calendar date of the work shift.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the time entry record.',
    `work_location_code` STRING COMMENT 'Code identifying the plant, distribution center, or office where the work was performed.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Individual time and attendance records for Food Beverage hourly and salaried non-exempt employees, capturing clock-in/clock-out timestamps, shift date, work location (plant, DC, office), department, job code, hours type (regular, overtime, double-time, holiday, PTO, FMLA), meal break duration, and approval status. Critical for FLSA compliance, COGS labor costing in SAP CO, and production shift OEE calculations in Aveva MES.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`production_shift` (
    `production_shift_id` BIGINT COMMENT 'Unique identifier for the production shift record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee supervising the shift.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant or distribution center where the shift occurs.',
    `production_line_id` BIGINT COMMENT 'Identifier of the production line assigned to the shift.',
    `actual_end` TIMESTAMP COMMENT 'Recorded actual end timestamp when workers completed the shift.',
    `actual_headcount` STRING COMMENT 'Number of workers who actually worked the shift.',
    `actual_start` TIMESTAMP COMMENT 'Recorded actual start timestamp when workers began the shift.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost incurred for the shift (currency‑agnostic).',
    `labor_cost_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the labor cost (e.g., USD, EUR).',
    `location_code` STRING COMMENT 'Alphanumeric code for the specific site or floor within the plant.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates whether overtime was incurred during the shift.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours logged for the shift.',
    `planned_headcount` STRING COMMENT 'Number of workers scheduled for the shift.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the shift record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shift record.',
    `scheduled_end` TIMESTAMP COMMENT 'Planned end timestamp for the shift.',
    `scheduled_start` TIMESTAMP COMMENT 'Planned start timestamp for the shift.',
    `shift_code` STRING COMMENT 'Human‑readable code identifying the shift (e.g., SFT‑2023‑001).',
    `shift_notes` STRING COMMENT 'Free‑form text for any additional information or observations about the shift.',
    `shift_status` STRING COMMENT 'Current lifecycle status of the shift.. Valid values are `scheduled|in_progress|completed|cancelled|open`',
    `shift_type` STRING COMMENT 'Classification of the shift schedule pattern.. Valid values are `day|afternoon|night|rotating`',
    `swap_approved_flag` BOOLEAN COMMENT 'True if a shift‑swap request was approved.',
    `swap_requested_flag` BOOLEAN COMMENT 'True if a shift‑swap request was submitted for this shift.',
    CONSTRAINT pk_production_shift PRIMARY KEY(`production_shift_id`)
) COMMENT 'Scheduled and actual production shift records for manufacturing plant and DC floor workers at Food Beverage, including per-employee crew assignment details. Captures shift code, shift type (day/afternoon/night/rotating), plant or DC location, production line assignment, scheduled start/end time, actual start/end time, shift supervisor, headcount planned vs. actual, shift status, and shift notes. Per-employee assignments include: role on shift (operator, line lead, QA technician, sanitation), assigned line, scheduled vs. actual hours, attendance status, overtime flags, and swap/coverage records. Links workforce scheduling to Aveva MES production orders and OEE tracking. Enables labor scheduling optimization, OTIF workforce coverage analysis, and shift-swap management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'System-generated unique identifier for each leave request record.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or HR representative who approved or rejected the request.',
    `primary_leave_employee_id` BIGINT COMMENT 'Unique identifier of the employee submitting the leave request.',
    `accrual_balance_at_request` DECIMAL(18,2) COMMENT 'Employees leave balance (in days) at the time the request was submitted.',
    `approval_status` STRING COMMENT 'Current approval state of the leave request.. Valid values are `pending|approved|rejected|withdrawn`',
    `attachment_flag` BOOLEAN COMMENT 'True if supporting documents (e.g., medical certificates) are attached to the request.',
    `comments` STRING COMMENT 'Additional comments or notes added by the employee or approver.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the leave request record was first created in the system.',
    `end_date` DATE COMMENT 'Last calendar day the leave is scheduled to end.',
    `fmla_eligible` BOOLEAN COMMENT 'True if the employee meets eligibility criteria for Family and Medical Leave Act coverage.',
    `intermittent_flag` BOOLEAN COMMENT 'True if the leave is to be taken on an intermittent (non‑consecutive) basis.',
    `leave_balance_remaining` DECIMAL(18,2) COMMENT 'Projected leave balance remaining after the requested leave is deducted.',
    `leave_request_status` STRING COMMENT 'Overall lifecycle status of the request as it moves through the approval process.. Valid values are `draft|submitted|in_review|approved|rejected|cancelled`',
    `leave_type` STRING COMMENT 'Category of leave being requested (e.g., FMLA, ADA accommodation, personal, military, parental, other).. Valid values are `fmla|ada|personal|military|parental|other`',
    `medical_certification_reference` STRING COMMENT 'Reference identifier for any medical documentation supporting the leave request.',
    `paid_leave_flag` BOOLEAN COMMENT 'True if the requested leave is paid under the employees leave accrual plan.',
    `reason_description` STRING COMMENT 'Free‑text explanation provided by the employee for the leave request.',
    `request_date` DATE COMMENT 'Date the employee submitted the leave request.',
    `request_number` STRING COMMENT 'Human‑readable business identifier for the leave request, often used in communications and reporting.',
    `return_to_work_date` DATE COMMENT 'Date the employee is expected to resume regular duties after the leave period.',
    `start_date` DATE COMMENT 'First calendar day the leave is scheduled to begin.',
    `total_leave_days` DECIMAL(18,2) COMMENT 'Total number of leave days (or equivalent hours) requested, including fractions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the leave request record.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Employee leave of absence requests and approvals at Food Beverage, covering FMLA, ADA accommodations, personal leave, military leave (USERRA), parental leave, bereavement, and jury duty. Captures leave type, request date, start date, end date, intermittent leave flag, FMLA eligibility determination, approval status, approver, return-to-work date, and any medical certification reference. Supports OSHA and DOL compliance reporting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Primary key for training_record',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who completed the training or holds the certification.',
    `training_course_id` BIGINT COMMENT 'FK to workforce.training_course',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved on the training assessment (e.g., 85.5).',
    `certification_number` STRING COMMENT 'Unique number assigned by the issuing body to the certification.',
    `completion_date` DATE COMMENT 'Date the employee completed the training or passed the assessment.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the training satisfies the specific regulatory requirement (True = compliant).',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours or units awarded for completing the training.',
    `delivery_method` STRING COMMENT 'Mode used to deliver the training (e.g., classroom, e‑learning, on‑the‑job).. Valid values are `classroom|e-learning|on-the-job|virtual`',
    `expiration_date` DATE COMMENT 'Date the certification or training expires and must be renewed.',
    `issue_date` DATE COMMENT 'Date the certification or training was officially issued.',
    `issuing_body` STRING COMMENT 'Organization that issued the certification or conducted the training (e.g., FDA, SQF Institute, State Health Dept.).',
    `location` STRING COMMENT 'Physical or virtual location where the training was delivered (e.g., Plant A, Online Portal).',
    `next_due_date` DATE COMMENT 'Calculated date when the next renewal or recertification is required.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the training event.',
    `pass_fail_status` STRING COMMENT 'Result of the assessment indicating whether the employee passed or failed.. Valid values are `pass|fail`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training record.',
    `training_status` STRING COMMENT 'Current lifecycle status of the training record (e.g., active, expired).. Valid values are `active|expired|revoked|pending`',
    `training_type` STRING COMMENT 'Category of training or certification (e.g., GMP, HACCP, ServSafe).. Valid values are `gmp|haccp|servsafe|pcqi|sqf|allergen`',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Single source of truth for ALL training completions, certifications, and food safety credentials for Food Beverage plant, DC, QA, and foodservice employees. Covers GMP/HACCP training events AND all food safety certifications including ServSafe, PCQI (Preventive Controls Qualified Individual under FSMA), SQF Practitioner, state food handler cards, allergen awareness, and HACCP certification. Captures training course or certification type, issuing body, completion/issue date, expiration date, certification number, delivery method (classroom, e-learning, OJT), assessment score, pass/fail status, trainer or LMS reference, and next due date. No separate food handler certification product exists — all certification data is consolidated here. Sourced from Veeva Vault LMS and Workday HCM Learning. Critical for FDA FSMA compliance, GFSI audit readiness, OSHA training requirements, and state food handler card renewals.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'System-generated unique identifier for the training course.',
    `applicable_job_profiles` STRING COMMENT 'Comma‑separated list of job profile identifiers to which the course applies.',
    `certification_required` BOOLEAN COMMENT 'Indicates whether successful completion grants a formal certification.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Monetary cost associated with delivering the course (e.g., external vendor fees).',
    `course_type` STRING COMMENT 'Classification of the course by functional area (e.g., Safety, Leadership).. Valid values are `Safety|Compliance|Leadership|Technical|Onboarding`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the course record was first created in the system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours awarded upon successful completion.',
    `delivery_method` STRING COMMENT 'Mode through which the training is delivered to employees.. Valid values are `Online|In‑person|Blended|Self‑paced`',
    `duration_minutes` STRING COMMENT 'Total instructional time of the course expressed in minutes.',
    `effective_end_date` DATE COMMENT 'Date after which the course is no longer offered (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the course becomes available for enrollment.',
    `instructor_name` STRING COMMENT 'Name of the primary instructor or facilitator for the course.',
    `language` STRING COMMENT 'Primary language in which the course content is delivered.. Valid values are `en|es|fr|de|zh|ja`',
    `last_review_date` DATE COMMENT 'Date when the course content was last reviewed for relevance and compliance.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether completion of the course is mandatory for the assigned employee group.',
    `passing_score_percent` DECIMAL(18,2) COMMENT 'Minimum score percentage required for a learner to pass the course.',
    `recertification_interval_months` STRING COMMENT 'Number of months after which the course must be retaken to maintain certification.',
    `regulatory_requirement_reference` STRING COMMENT 'Reference to the regulatory framework(s) the course satisfies (e.g., FSMA, OSHA, GFSI).',
    `review_cycle_months` STRING COMMENT 'Planned interval in months between mandatory content reviews.',
    `title` STRING COMMENT 'Human‑readable name of the training course.',
    `training_course_code` STRING COMMENT 'Business identifier or catalog code assigned to the course (e.g., GMP001).',
    `training_course_description` STRING COMMENT 'Detailed narrative of the course content, objectives, and scope.',
    `training_course_status` STRING COMMENT 'Current lifecycle status of the course.. Valid values are `active|inactive|retired|draft`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the course record.',
    `version_number` STRING COMMENT 'Sequential version identifier for the course definition.',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Master catalog of all training courses available to Food Beverage employees, including GMP, HACCP, food safety, allergen awareness, forklift certification, OSHA 10/30, leadership development, and compliance training. Captures course code, title, description, course type, delivery method, duration, passing score threshold, recertification interval (months), mandatory flag, applicable job profiles, and regulatory requirement reference (FSMA, OSHA, GFSI). Managed in Veeva Vault and Workday HCM Learning.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`talent_review` (
    `talent_review_id` BIGINT COMMENT 'Primary key for talent_review',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee being reviewed.',
    `review_document_id` BIGINT COMMENT 'Identifier of the attached review document in the document management system.',
    `reviewer_employee_id` BIGINT COMMENT 'Unique identifier of the manager or reviewer conducting the review.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp when the review was finalized.',
    `calibration_status` STRING COMMENT 'Status of calibration process across reviewers.. Valid values are `not_started|in_progress|completed`',
    `compensation_change_flag` BOOLEAN COMMENT 'Indicates if compensation will change as a result of the review.',
    `competency_rating_communication` DECIMAL(18,2) COMMENT 'Rating for communication competency.',
    `competency_rating_innovation` DECIMAL(18,2) COMMENT 'Rating for innovation competency.',
    `competency_rating_teamwork` DECIMAL(18,2) COMMENT 'Rating for teamwork competency.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates if the review content is confidential.',
    `employee_department` STRING COMMENT 'Department to which the employee belongs.',
    `employee_location` STRING COMMENT 'Geographic location or site of the employee.',
    `employee_role` STRING COMMENT 'Current role or title of the employee.',
    `employee_self_assessment` STRING COMMENT 'Self-assessment narrative from the employee.',
    `employee_tenure_years` DECIMAL(18,2) COMMENT 'Number of years the employee has been with the company at time of review.',
    `final_approved_rating` DECIMAL(18,2) COMMENT 'Rating after calibration and final approval.',
    `goal_rating_1` DECIMAL(18,2) COMMENT 'Rating for the first primary goal.',
    `goal_rating_2` DECIMAL(18,2) COMMENT 'Rating for the second primary goal.',
    `manager_comments` STRING COMMENT 'Comments provided by the reviewer.',
    `merit_increase_percent` DECIMAL(18,2) COMMENT 'Proposed merit increase percentage based on review.',
    `overall_rating` DECIMAL(18,2) COMMENT 'Aggregated overall rating score for the employee (e.g., 4.5).',
    `promotion_recommendation` STRING COMMENT 'Recommendation regarding promotion.. Valid values are `yes|no|consider`',
    `rating_comments` STRING COMMENT 'Narrative comments accompanying the overall rating.',
    `rating_scale_max` STRING COMMENT 'Maximum value of the rating scale (e.g., 5).',
    `rating_scale_min` STRING COMMENT 'Minimum value of the rating scale (e.g., 1).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the review record was created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the review record.',
    `review_cycle` STRING COMMENT 'Fiscal year or cycle in which the review takes place.. Valid values are `2022|2023|2024|2025`',
    `review_end_date` DATE COMMENT 'Date when the review period ended.',
    `review_location` STRING COMMENT 'Physical or virtual location where the review meeting took place.',
    `review_method` STRING COMMENT 'Method used to conduct the review.. Valid values are `in_person|virtual|phone`',
    `review_notes` STRING COMMENT 'Additional notes captured during the review.',
    `review_start_date` DATE COMMENT 'Date when the review period started.',
    `review_status` STRING COMMENT 'Current workflow status of the review.. Valid values are `pending|in_progress|completed|calibrated|approved|rejected`',
    `review_type` STRING COMMENT 'Type of performance review (annual, mid-year, probationary, performance improvement plan).. Valid values are `annual|mid_year|probationary|pip`',
    CONSTRAINT pk_talent_review PRIMARY KEY(`talent_review_id`)
) COMMENT 'Annual and mid-year performance review records for Food Beverage employees, capturing review cycle, review type (annual, mid-year, probationary, PIP), overall rating, individual goal ratings, competency ratings, manager comments, employee self-assessment, calibration status, and final approved rating. Sourced from Workday HCM Performance. Feeds merit increase and promotion decisions in compensation planning.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`succession_plan` (
    `succession_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the succession plan record.',
    `employee_id` BIGINT COMMENT 'HR manager or owner responsible for the succession plan.',
    `primary_succession_incumbent_employee_id` BIGINT COMMENT 'Employee currently holding the target position.',
    `position_id` BIGINT COMMENT 'Identifier of the position for which succession is being planned.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the succession plan record was created.',
    `development_actions` STRING COMMENT 'Planned development activities for the successor candidate.',
    `end_date` DATE COMMENT 'Date when the succession plan expires or is superseded; null if open-ended.',
    `last_reviewed_by` BIGINT COMMENT 'Employee identifier of the person who performed the last review.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the last review was performed.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations.',
    `plan_code` STRING COMMENT 'Human-readable code for the succession plan, used for reference and reporting.',
    `plan_type` STRING COMMENT 'Classification of the plan indicating its strategic importance.. Valid values are `critical|non_critical|strategic`',
    `priority` STRING COMMENT 'Numeric priority indicating the urgency of the succession plan (1=highest).',
    `readiness_level` STRING COMMENT 'Readiness timeframe for the successor candidate to assume the role.. Valid values are `ready_now|1-2_years|3-5_years`',
    `review_date` DATE COMMENT 'Date of the next scheduled review of the succession plan.',
    `risk_of_loss_rating` STRING COMMENT 'Assessment of risk associated with potential loss of the incumbent.. Valid values are `low|medium|high`',
    `start_date` DATE COMMENT 'Date when the succession plan becomes effective.',
    `succession_plan_status` STRING COMMENT 'Current lifecycle status of the succession plan.. Valid values are `active|inactive|draft|archived`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the succession plan record.',
    `version_number` STRING COMMENT 'Incremental version of the succession plan for change tracking.',
    CONSTRAINT pk_succession_plan PRIMARY KEY(`succession_plan_id`)
) COMMENT 'Succession planning records identifying ready-now and future successors for critical positions at Food Beverage, including plant manager, R&D director, supply chain VP, and other key roles. Captures target position, incumbent employee, successor candidate, readiness level (ready now, 1-2 years, 3-5 years), development actions, risk of loss rating, and plan review date. Sourced from Workday HCM Succession.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`osha_incident` (
    `osha_incident_id` BIGINT COMMENT 'System-generated unique identifier for the OSHA incident record.',
    `equipment_master_id` BIGINT COMMENT 'Identifier of equipment involved, if any.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the incident investigation.',
    `body_part` STRING COMMENT 'Body part(s) impacted by the injury. [ENUM-REF-CANDIDATE: hand|arm|leg|head|torso|face|eye|other — 8 candidates stripped; promote to reference product]',
    `case_status` STRING COMMENT 'Current status of the incident case within the investigation workflow.. Valid values are `open|investigating|resolved|closed`',
    `corrective_action` STRING COMMENT 'Planned or implemented actions to prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was first created in the system.',
    `days_away` STRING COMMENT 'Number of workdays the employee was unable to work due to the incident.',
    `department` STRING COMMENT 'Business department or functional area of the employee at time of incident.',
    `equipment_name` STRING COMMENT 'Descriptive name of the equipment involved.',
    `exposure_level` STRING COMMENT 'Level of employee exposure to the hazard.. Valid values are `low|medium|high`',
    `hazard_type` STRING COMMENT 'Primary hazard category associated with the incident.. Valid values are `mechanical|electrical|chemical|ergonomic|environmental|other`',
    `incident_datetime` TIMESTAMP COMMENT 'Exact date and time when the incident occurred.',
    `incident_number` STRING COMMENT 'Business-assigned alphanumeric identifier for the incident, used for tracking and reporting.',
    `incident_type` STRING COMMENT 'Category of the incident as defined by OSHA reporting requirements.. Valid values are `injury|illness|near_miss|property_damage`',
    `injury_type` STRING COMMENT 'Specific type of injury sustained, if applicable.. Valid values are `laceration|fracture|burn|sprain|contusion|other`',
    `investigation_complete` BOOLEAN COMMENT 'Indicates whether the incident investigation has been completed.',
    `location` STRING COMMENT 'Physical location of the incident (plant, production line, distribution center zone, etc.).',
    `lost_time_indicator` BOOLEAN COMMENT 'True if days_away > 0, indicating lost work time.',
    `medical_provider` STRING COMMENT 'Name of the medical provider or facility that treated the employee.',
    `medical_treatment_provided` BOOLEAN COMMENT 'Indicates whether medical treatment was administered on-site or off-site.',
    `notes` STRING COMMENT 'Free-text field for any supplemental information or observations.',
    `recordable_flag` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA recordable criteria (true) or not (false).',
    `reporting_date` DATE COMMENT 'Date the incident was formally reported to OSHA or internal safety team.',
    `restricted_duty_days` STRING COMMENT 'Number of days the employee performed restricted or light duty work.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause (e.g., equipment, human error, process).',
    `root_cause_detail` STRING COMMENT 'Narrative description of the underlying cause of the incident.',
    `severity` STRING COMMENT 'Severity rating of the incident based on impact and risk.. Valid values are `low|medium|high|critical`',
    `shift` STRING COMMENT 'Work shift during which the incident occurred.. Valid values are `day|night|swing|graveyard`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the incident record.',
    CONSTRAINT pk_osha_incident PRIMARY KEY(`osha_incident_id`)
) COMMENT 'OSHA recordable and first-aid incident records for Food Beverage manufacturing plants, DCs, and field operations. Captures incident date/time, location (plant, line, DC zone), incident type (injury, illness, near-miss, property damage), injury type, body part affected, OSHA recordability determination (300 log entry), days away from work, restricted duty days, root cause classification, corrective actions, and case status. Mandatory for OSHA 300/300A annual reporting and workers compensation.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` (
    `labor_grievance_id` BIGINT COMMENT 'System-generated unique identifier for the labor grievance record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who filed the grievance.',
    `cba_article` STRING COMMENT 'Specific CBA article cited in the grievance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grievance record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the settlement amount.',
    `filing_date` DATE COMMENT 'Date the grievance was formally filed.',
    `grievance_number` STRING COMMENT 'External reference number assigned to the grievance by the labor relations system.',
    `grievance_status` STRING COMMENT 'Current status of the grievance record.. Valid values are `open|closed|in_progress|appealed`',
    `grievance_step` STRING COMMENT 'Current step in the grievance resolution process.. Valid values are `step1|step2|step3|step4|arbitration`',
    `grievance_type` STRING COMMENT 'Category of the grievance as defined in the collective bargaining agreement.. Valid values are `discipline|scheduling|pay|safety|seniority`',
    `notes` STRING COMMENT 'Free‑form text notes captured by labor relations staff.',
    `outcome` STRING COMMENT 'Final outcome of the grievance after all steps.. Valid values are `settled|withdrawn|dismissed|upheld|rejected`',
    `plant_location_code` STRING COMMENT 'Identifier of the manufacturing plant or distribution center where the grievance originated.',
    `resolution_date` DATE COMMENT 'Date the grievance was resolved or closed.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Monetary settlement amount paid to the employee, if any.',
    `union_local` STRING COMMENT 'Union local number or name associated with the employee filing the grievance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the grievance record.',
    CONSTRAINT pk_labor_grievance PRIMARY KEY(`labor_grievance_id`)
) COMMENT 'Union labor grievance and arbitration case records for Food Beverage unionized manufacturing and DC facilities. Captures grievance number, filing date, grievance type (discipline, scheduling, pay, safety, seniority), CBA article cited, plant or DC location, union local, grievance step (Step 1 through arbitration), resolution date, resolution outcome, and financial settlement amount if applicable. Supports labor relations management and CBA compliance tracking.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the headcount planning record.',
    `org_unit_id` BIGINT COMMENT 'FK to workforce.org_unit',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person responsible for the plan.',
    `actual_fte` DECIMAL(18,2) COMMENT 'Actual FTE count recorded during the planning period.',
    `approved_fte` DECIMAL(18,2) COMMENT 'Number of FTEs approved in the plan for the org unit and job family.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan was approved by the governing authority.',
    `attrition_rate` DECIMAL(18,2) COMMENT 'Assumed attrition percentage (e.g., 0.0500 for 5%).',
    `budget_fte` DECIMAL(18,2) COMMENT 'FTE amount budgeted for the planning period, used for cost allocation.',
    `cost_center_code` STRING COMMENT 'Financial cost‑center linked to the headcount plan for budgeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the headcount plan record was created.',
    `effective_from` DATE COMMENT 'Date when the headcount plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the headcount plan expires or is superseded; null if open‑ended.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the plan applies.',
    `headcount_plan_status` STRING COMMENT 'Current lifecycle status of the headcount plan.. Valid values are `draft|submitted|approved|rejected`',
    `headcount_target_fte` DECIMAL(18,2) COMMENT 'Target FTE count the organization aims to achieve, may differ from approved.',
    `job_family_code` STRING COMMENT 'Code representing the job family or role category for the headcount plan.',
    `job_family_name` STRING COMMENT 'Human‑readable name of the job family.',
    `notes` STRING COMMENT 'Free‑form comments or rationale associated with the plan.',
    `open_requisitions` STRING COMMENT 'Number of open hiring requisitions associated with the plan.',
    `plan_number` STRING COMMENT 'External business identifier for the headcount plan, used in reporting and approvals.',
    `plan_review_date` DATE COMMENT 'Date of the most recent formal review of the headcount plan.',
    `plan_type` STRING COMMENT 'Classification of the plan indicating its purpose, such as annual, seasonal, or projected.. Valid values are `annual|seasonal|projected`',
    `plan_version` STRING COMMENT 'Version identifier for the plan (e.g., v1.0, v2.1).',
    `planning_period` STRING COMMENT 'Period within the fiscal year covered by the plan (quarter or full year).. Valid values are `Q1|Q2|Q3|Q4|FY`',
    `seasonal_headcount_addition` STRING COMMENT 'Planned additional headcount for seasonal peaks (e.g., holiday, harvest).',
    `source_system` STRING COMMENT 'Originating system that supplied the plan data (e.g., Workday HCM).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the headcount plan.',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'Approved headcount planning records by org unit, job family, and fiscal period for Food Beverage. Captures plan version, fiscal year, planning period, org unit, job family, approved FTE count, actual FTE count, open requisitions, attrition assumption, seasonal headcount additions (harvest season, holiday peak), and plan approval status. Integrates with SAP CO cost center budgeting and Workday HCM workforce planning.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`requisition` (
    `requisition_id` BIGINT COMMENT 'System-generated unique identifier for the job requisition record.',
    `network_node_id` BIGINT COMMENT 'Reference to the physical location (plant, warehouse, office, etc.) for the role.',
    `employee_id` BIGINT COMMENT 'Identifier of the executive or finance officer who approved the requisition.',
    `requisition_employee_id` BIGINT COMMENT 'Identifier of the manager responsible for filling the position.',
    `requisition_recruiter_employee_id` BIGINT COMMENT 'Identifier of the recruiter or recruiting team handling the requisition.',
    `approved_fte` STRING COMMENT 'Number of FTEs approved by finance or leadership.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the requisition received formal approval.',
    `background_check_status` STRING COMMENT 'Progress status of the required background verification.. Valid values are `not_started|in_progress|completed|failed`',
    `budgeted_salary_max` DECIMAL(18,2) COMMENT 'Maximum salary range approved for the position.',
    `budgeted_salary_min` DECIMAL(18,2) COMMENT 'Minimum salary range approved for the position.',
    `closing_date` DATE COMMENT 'Date when the requisition was closed to new applications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the requisition record was first created in the system.',
    `department` STRING COMMENT 'Organizational department or business unit where the position resides.',
    `diversity_flag` BOOLEAN COMMENT 'Indicates whether the requisition is part of a diversity hiring initiative.',
    `drug_screen_status` STRING COMMENT 'Status of the drug screening process for food‑safety‑sensitive roles.. Valid values are `not_required|not_started|passed|failed`',
    `employment_type` STRING COMMENT 'Nature of the employment relationship.. Valid values are `full_time|part_time|contract|temporary|intern`',
    `external_candidate_allowed` BOOLEAN COMMENT 'True if external candidates may apply for the position.',
    `internal_candidate_allowed` BOOLEAN COMMENT 'True if internal employees may apply for the position.',
    `interview_stage` STRING COMMENT 'Current stage of the interview process for the requisition. [ENUM-REF-CANDIDATE: screen|phone|onsite|final|offer|hired|rejected — 7 candidates stripped; promote to reference product]',
    `job_family` STRING COMMENT 'Broad classification of the role (e.g., Production, Quality, Finance).',
    `job_level` STRING COMMENT 'Organizational level of the role (e.g., IC1, M2).',
    `location_type` STRING COMMENT 'Category of the work location for the role.. Valid values are `plant|warehouse|office|store|remote`',
    `offer_amount` DECIMAL(18,2) COMMENT 'Monetary value of the employment offer presented to the candidate.',
    `offer_status` STRING COMMENT 'State of the employment offer for the position.. Valid values are `not_made|made|accepted|declined|withdrawn`',
    `posting_date` DATE COMMENT 'Date when the requisition was first posted to candidates.',
    `posting_status` STRING COMMENT 'Current status of the job posting on internal/external channels.. Valid values are `not_posted|posted|paused|expired`',
    `priority` STRING COMMENT 'Business priority assigned to the hiring request.. Valid values are `low|medium|high|critical`',
    `reason` STRING COMMENT 'Business driver for the hiring request.. Valid values are `growth|replacement|new_product|seasonal`',
    `required_certifications` STRING COMMENT 'Comma‑separated list of mandatory certifications (e.g., Food Handler, GMP).',
    `required_education` STRING COMMENT 'Minimum education level required for the position.. Valid values are `high_school|associate|bachelor|master|phd`',
    `required_experience_years` STRING COMMENT 'Minimum years of relevant experience needed for the role.',
    `requisition_description` STRING COMMENT 'Detailed narrative of duties, responsibilities, and expectations for the role.',
    `requisition_number` STRING COMMENT 'Business-visible identifier assigned to the requisition (e.g., RQ-2024-001).',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the requisition.. Valid values are `draft|open|closed|cancelled|filled|on_hold`',
    `requisition_type` STRING COMMENT 'Classification of the hiring need (e.g., new hire, replacement, temporary).. Valid values are `new_hire|replacement|temp|contract|intern`',
    `shift_schedule` STRING COMMENT 'Typical shift pattern required (e.g., day, night, flex).',
    `source_channel` STRING COMMENT 'Primary channel through which candidates are sourced.. Valid values are `internal|employee_referral|job_board|recruiter|social_media|agency`',
    `target_fte` STRING COMMENT 'Number of full-time equivalents requested for the role.',
    `target_start_date` DATE COMMENT 'Planned date for the new hire to begin work.',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from opening to filling the requisition.',
    `title` STRING COMMENT 'Official title of the position being requested.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the requisition record.',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Job requisition and full candidate pipeline records for approved headcount at Food Beverage. Captures requisition details (requisition number, position, job profile, hiring manager, recruiter, target start date, requisition type, sourcing channels, posting status) and all associated candidate applications (applicant name, source channel, application date, application stage, interview scores, background check status, drug screen status for food safety roles, offer details, disposition reason, hire decision). Incorporates workforce planning context including approved FTE targets, seasonal headcount needs, and time-to-fill metrics. SSOT for all recruiting activity from requisition opening through candidate hire/rejection. Sourced from Workday HCM Recruiting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`review_document` (
    `review_document_id` BIGINT COMMENT 'Primary key for review_document',
    `employee_id` BIGINT COMMENT 'Identifier of employee who approved the document.',
    `author_employee_id` BIGINT COMMENT 'Identifier of the employee who authored the document.',
    `policy_id` BIGINT COMMENT 'Identifier of the related policy document.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the latest review.',
    `superseded_review_document_id` BIGINT COMMENT 'Self-referencing FK on review_document (superseded_review_document_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the document was approved.',
    `approved_by_name` STRING COMMENT 'Name of employee who approved the document.',
    `audit_trail` STRING COMMENT 'Reference identifier for the audit trail log associated with this document.',
    `author_name` STRING COMMENT 'Full name of the document author.',
    `business_unit` STRING COMMENT 'Business unit owning the document.',
    `compliance_area` STRING COMMENT 'Compliance domain the document addresses.',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification of the document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was created in the system.',
    `department_responsible` STRING COMMENT 'Department accountable for the document.',
    `document_type` STRING COMMENT 'Category of the document such as policy, procedure, audit, training, safety, or compliance.',
    `document_url` STRING COMMENT 'Link to the stored location of the document.',
    `effective_date` DATE COMMENT 'Date when the document becomes effective.',
    `expiration_date` DATE COMMENT 'Date when the document expires or is superseded.',
    `external_source_name` STRING COMMENT 'Name of the external source or vendor.',
    `file_format` STRING COMMENT 'File format of the document.',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes.',
    `is_archived` BOOLEAN COMMENT 'Indicates if the document has been archived.',
    `is_external_document` BOOLEAN COMMENT 'Indicates if the document originates from an external source.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates if the document is mandatory for compliance.',
    `language` STRING COMMENT 'Language of the document content.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the document.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    `next_review_date` DATE COMMENT 'Planned date for the next review.',
    `retention_expiry_date` DATE COMMENT 'Date when the document must be disposed per retention policy.',
    `retention_period_months` STRING COMMENT 'Retention period for the document in months.',
    `review_cycle` STRING COMMENT 'Scheduled review frequency for the document.',
    `review_outcome` STRING COMMENT 'Result of the most recent review.',
    `reviewer_name` STRING COMMENT 'Full name of the reviewer.',
    `revision_history` STRING COMMENT 'Summary of revisions made to the document.',
    `review_document_status` STRING COMMENT 'Current lifecycle status of the document.',
    `tags` STRING COMMENT 'Comma-separated tags for categorization.',
    `title` STRING COMMENT 'Title of the review document.',
    `version_number` STRING COMMENT 'Version identifier of the document.',
    CONSTRAINT pk_review_document PRIMARY KEY(`review_document_id`)
) COMMENT 'Master reference table for review_document. Referenced by review_document_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Primary key for shift_schedule',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who created the schedule record.',
    `rotated_from_shift_schedule_id` BIGINT COMMENT 'Self-referencing FK on shift_schedule (rotated_from_shift_schedule_id)',
    `break_duration_minutes` STRING COMMENT 'Standard paid break length allocated within the shift.',
    `certification_required` BOOLEAN COMMENT 'Indicates whether employees must hold a food‑handler or GMP/HACCP certification to work this shift.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift schedule record was first created in the system.',
    `shift_schedule_description` STRING COMMENT 'Detailed free‑text description of the schedule purpose and usage.',
    `effective_from` DATE COMMENT 'Date when the shift schedule becomes active.',
    `effective_until` DATE COMMENT 'Date when the shift schedule is retired or superseded (null if open‑ended).',
    `labor_rule_code` STRING COMMENT 'Reference code to the labor rule or collective bargaining agreement governing this shift.',
    `lifecycle_status` STRING COMMENT 'Lifecycle state of the schedule definition.',
    `max_consecutive_days` STRING COMMENT 'Maximum number of consecutive days an employee may be assigned this shift before a mandatory rest period.',
    `overtime_allowed` BOOLEAN COMMENT 'True if overtime may be scheduled for this shift; false otherwise.',
    `schedule_code` STRING COMMENT 'Business identifier code used to reference the schedule in operational systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name of the shift schedule (e.g., "Morning Production Shift").',
    `schedule_type` STRING COMMENT 'Classification of the schedule pattern (regular, flex, on‑call, seasonal).',
    `shift_duration_hours` DECIMAL(18,2) COMMENT 'Calculated duration of the shift in decimal hours.',
    `shift_end_time` STRING COMMENT 'Planned end time of the shift (HH:mm, 24‑hour clock).',
    `shift_group` STRING COMMENT 'Logical grouping of shifts (e.g., morning, afternoon, night, graveyard).',
    `shift_start_time` STRING COMMENT 'Planned start time of the shift (HH:mm, 24‑hour clock).',
    `shift_schedule_status` STRING COMMENT 'Current operational status of the schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shift schedule record.',
    `weekly_pattern` STRING COMMENT 'Pattern of days the shift recurs within a week (e.g., "Mon‑Wed‑Fri").',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Master reference table for shift_schedule. Referenced by shift_schedule_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`open_enrollment_event` (
    `open_enrollment_event_id` BIGINT COMMENT 'Primary key for open_enrollment_event',
    `previous_open_enrollment_event_id` BIGINT COMMENT 'Self-referencing FK on open_enrollment_event (previous_open_enrollment_event_id)',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance standards applicable to the enrollment (e.g., OSHA, HIPAA).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment event record was first created in the system.',
    `open_enrollment_event_description` STRING COMMENT 'Narrative description of the enrollment event purpose and scope.',
    `effective_from` DATE COMMENT 'Date on which the enrollment event becomes legally effective.',
    `effective_until` DATE COMMENT 'Date on which the enrollment event expires; null if open‑ended.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which employees are eligible for the event (e.g., tenure, employment type).',
    `enrollment_closed_flag` BOOLEAN COMMENT 'True if the enrollment window has ended or the event is cancelled.',
    `enrollment_end_date` DATE COMMENT 'Final date for employees to submit enrollment selections.',
    `enrollment_method` STRING COMMENT 'Channel(s) through which employees may enroll.',
    `enrollment_open_flag` BOOLEAN COMMENT 'True if the current date falls within the enrollment window; otherwise false.',
    `enrollment_start_date` DATE COMMENT 'First date employees may submit enrollment selections.',
    `enrollment_window_days` STRING COMMENT 'Calculated length of the enrollment period in days.',
    `event_code` STRING COMMENT 'Business identifier code used to reference the enrollment event in HR processes.',
    `event_name` STRING COMMENT 'Human‑readable name of the enrollment period (e.g., "2024 Benefits Open Enrollment").',
    `event_type` STRING COMMENT 'Category of the enrollment event indicating the type of benefits or programs offered.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the enrollment event.',
    `participant_actual_count` STRING COMMENT 'Actual number of employees who completed enrollment.',
    `participant_estimated_count` STRING COMMENT 'Projected number of employees expected to enroll.',
    `regulatory_flag` BOOLEAN COMMENT 'Indicates whether the event triggers mandatory regulatory reporting.',
    `open_enrollment_event_status` STRING COMMENT 'Current lifecycle status of the enrollment event.',
    `updated_by` STRING COMMENT 'Identifier of the user or system process that last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the enrollment event record.',
    `created_by` STRING COMMENT 'Identifier of the user or system process that created the record.',
    CONSTRAINT pk_open_enrollment_event PRIMARY KEY(`open_enrollment_event_id`)
) COMMENT 'Master reference table for open_enrollment_event. Referenced by open_enrollment_event_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`workforce`.`policy` (
    `policy_id` BIGINT COMMENT 'Primary key for policy',
    `superseded_policy_id` BIGINT COMMENT 'Self-referencing FK on policy (superseded_policy_id)',
    `approval_date` DATE COMMENT 'Date the policy was approved.',
    `approved_by` STRING COMMENT 'Name of the individual or authority that approved the policy.',
    `compliance_area` STRING COMMENT 'Regulatory or internal compliance domain the policy addresses (e.g., OSHA, HACCP).',
    `compliance_requirements` STRING COMMENT 'Specific requirements or standards the policy enforces.',
    `effective_from` DATE COMMENT 'Date when the policy becomes binding.',
    `effective_until` DATE COMMENT 'Date when the policy ceases to be binding (null for open‑ended).',
    `enforcement_date` DATE COMMENT 'Date when the policy enforcement actions begin.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether adherence to the policy is mandatory (true) or advisory (false).',
    `issued_date` DATE COMMENT 'Date the policy was formally issued to the organization.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next policy review.',
    `policy_category` STRING COMMENT 'Classification of the policy based on its reach or target audience.',
    `policy_description` STRING COMMENT 'Detailed description of the policy purpose, scope, and applicability.',
    `policy_document_format` STRING COMMENT 'File format of the policy document (e.g., PDF, DOCX).',
    `policy_document_url` STRING COMMENT 'Link to the electronic version of the policy document.',
    `policy_name` STRING COMMENT 'Human‑readable title of the policy.',
    `policy_number` STRING COMMENT 'External reference number or code assigned to the policy by the organization.',
    `policy_owner_department` STRING COMMENT 'Organizational department of the policy owner.',
    `policy_owner_name` STRING COMMENT 'Name of the person responsible for the policys upkeep.',
    `policy_tags` STRING COMMENT 'Comma‑separated tags for categorizing the policy (e.g., safety, training).',
    `policy_type` STRING COMMENT 'Category of the policy indicating its functional area.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the policy record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the policy record.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory policy reviews.',
    `revision_number` STRING COMMENT 'Sequential revision count indicating how many times the policy has been updated.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the policy.',
    `version_number` STRING COMMENT 'Version identifier for the policy document (e.g., v1.0, v2.1).',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Master reference table for policy. Referenced by related_policy_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `food_beverage_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `food_beverage_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reporting_manager_position_id` FOREIGN KEY (`reporting_manager_position_id`) REFERENCES `food_beverage_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `food_beverage_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `food_beverage_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `food_beverage_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ADD CONSTRAINT `fk_workforce_total_rewards_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ADD CONSTRAINT `fk_workforce_total_rewards_open_enrollment_event_id` FOREIGN KEY (`open_enrollment_event_id`) REFERENCES `food_beverage_ecm`.`workforce`.`open_enrollment_event`(`open_enrollment_event_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `food_beverage_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `food_beverage_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ADD CONSTRAINT `fk_workforce_production_shift_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `food_beverage_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ADD CONSTRAINT `fk_workforce_talent_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ADD CONSTRAINT `fk_workforce_talent_review_review_document_id` FOREIGN KEY (`review_document_id`) REFERENCES `food_beverage_ecm`.`workforce`.`review_document`(`review_document_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ADD CONSTRAINT `fk_workforce_talent_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_primary_succession_incumbent_employee_id` FOREIGN KEY (`primary_succession_incumbent_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `food_beverage_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ADD CONSTRAINT `fk_workforce_labor_grievance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `food_beverage_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_requisition_employee_id` FOREIGN KEY (`requisition_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_requisition_recruiter_employee_id` FOREIGN KEY (`requisition_recruiter_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ADD CONSTRAINT `fk_workforce_review_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ADD CONSTRAINT `fk_workforce_review_document_author_employee_id` FOREIGN KEY (`author_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ADD CONSTRAINT `fk_workforce_review_document_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `food_beverage_ecm`.`workforce`.`policy`(`policy_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ADD CONSTRAINT `fk_workforce_review_document_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ADD CONSTRAINT `fk_workforce_review_document_superseded_review_document_id` FOREIGN KEY (`superseded_review_document_id`) REFERENCES `food_beverage_ecm`.`workforce`.`review_document`(`review_document_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `food_beverage_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_rotated_from_shift_schedule_id` FOREIGN KEY (`rotated_from_shift_schedule_id`) REFERENCES `food_beverage_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`open_enrollment_event` ADD CONSTRAINT `fk_workforce_open_enrollment_event_previous_open_enrollment_event_id` FOREIGN KEY (`previous_open_enrollment_event_id`) REFERENCES `food_beverage_ecm`.`workforce`.`open_enrollment_event`(`open_enrollment_event_id`);
ALTER TABLE `food_beverage_ecm`.`workforce`.`policy` ADD CONSTRAINT `fk_workforce_policy_superseded_policy_id` FOREIGN KEY (`superseded_policy_id`) REFERENCES `food_beverage_ecm`.`workforce`.`policy`(`policy_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `food_beverage_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID (MEID)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID (WLID)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `badge_number` SET TAGS ('dbx_business_glossary_term' = 'Badge Number (BN)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `badge_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `badge_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `cba_reference` SET TAGS ('dbx_business_glossary_term' = 'CBA Reference (CBA)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type (CT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|union|consultant');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CCC)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `eeo_category` SET TAGS ('dbx_business_glossary_term' = 'EEO Category (EEO)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `eeo_category` SET TAGS ('dbx_value_regex' = 'protected_veteran|disability|race|gender|age|none');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Personal Email Address (PEA)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `employee_status` SET TAGS ('dbx_business_glossary_term' = 'Employee Status (ES)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `employee_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|on_leave|retired');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type (ET)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|contractor|temp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'FLSA Status (FLSA)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `food_handler_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Food Handler Certification Status (FHCS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `food_handler_certification_status` SET TAGS ('dbx_value_regex' = 'certified|expired|not_required');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `gmp_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'GMP Training Completion Date (GMPTD)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `haccp_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'HACCP Training Completion Date (HACCPTD)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date (HD)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `i9_verification_status` SET TAGS ('dbx_business_glossary_term' = 'I-9 Verification Status (I9VS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `i9_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|not_applicable');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `job_classification` SET TAGS ('dbx_business_glossary_term' = 'Job Classification (JC)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code (JCODE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date (LPRD)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Full Name (LFN)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (NP)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `ooo_status` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Office Status (OOO)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `ooo_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|vacation|sick_leave|maternity|paternity');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible (OTEL)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `pay_basis` SET TAGS ('dbx_business_glossary_term' = 'Pay Basis (PB)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `pay_basis` SET TAGS ('dbx_value_regex' = 'hourly|salary|piece_rate|commission');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating (PR)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Personal Phone Number (PPN)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name (PN)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `probation_period_days` SET TAGS ('dbx_business_glossary_term' = 'Probation Period (PP)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (RACT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (RAUT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `rehire_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility (RE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (RT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `safety_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Completion Date (STTD)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `shift_schedule` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule (SS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours per Week (SHW)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TD)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `union_local` SET TAGS ('dbx_business_glossary_term' = 'Union Local (UL)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address (WEA)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number (WPN)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID (DEPT_ID)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `reporting_manager_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Manager Position ID (MGR_POS_ID)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `budgeted_headcount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount (BUDG_HC)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade (COMP_GRADE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CTR)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `employee_group` SET TAGS ('dbx_business_glossary_term' = 'Employee Group (EMP_GRP)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `filled` SET TAGS ('dbx_business_glossary_term' = 'Position Filled Flag (FILLED_FLG)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `filled_date` SET TAGS ('dbx_business_glossary_term' = 'Filled Date (FILLED_DT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `food_handler_cert_required` SET TAGS ('dbx_business_glossary_term' = 'Food Handler Certification Requirement (FH_CERT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full‑Time Equivalent Allocation (FTE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `gmp_zone_required` SET TAGS ('dbx_business_glossary_term' = 'GMP Zone Requirement (GMP_ZONE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `is_contract` SET TAGS ('dbx_business_glossary_term' = 'Contract Position Flag (CONTRACT_FLG)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `is_exempt` SET TAGS ('dbx_business_glossary_term' = 'Exempt Status (EXEMPT_FLG)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `is_temp` SET TAGS ('dbx_business_glossary_term' = 'Temporary Position Flag (TEMP_FLG)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family (JOB_FAM)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `management_level` SET TAGS ('dbx_business_glossary_term' = 'Management Level (MGMT_LVL)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility (OT_ELIG)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `position_category` SET TAGS ('dbx_business_glossary_term' = 'Position Category (POS_CAT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `position_category` SET TAGS ('dbx_value_regex' = 'production|logistics|admin|sales|quality|R&D');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code (POS_CD)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description (POS_DESC)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `position_level` SET TAGS ('dbx_business_glossary_term' = 'Position Level (POS_LVL)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status (POS_STAT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|filled|closed|on_hold');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type (POS_TYPE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|temporary|contract');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `remote_allowed` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Allowed (REMOTE_OK)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications (REQ_CERT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `required_training_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Training Hours (TRAIN_HRS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Safety‑Sensitive Position (SAFE_SENS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Salary Range (SAL_MAX)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Salary Range (SAL_MIN)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type (SHIFT_TP)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|rotating');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title (POS_TITLE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `travel_required` SET TAGS ('dbx_business_glossary_term' = 'Travel Required (TRAVEL_REQ)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `travel_required_percent` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage (TRAVEL_PCT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Union Eligibility (UNION_ELIG)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Reason (VAC_REASON)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('dbx_value_regex' = 'new|replaced|reorganization|budget_cut');
ALTER TABLE `food_beverage_ecm`.`workforce`.`position` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location (WORK_LOC)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `attrition_rate` SET TAGS ('dbx_business_glossary_term' = 'Attrition Rate (%)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CCC)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Code (GL)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_actual_fte` SET TAGS ('dbx_business_glossary_term' = 'Actual Full‑Time Equivalent Headcount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_planned_fte` SET TAGS ('dbx_business_glossary_term' = 'Planned Full‑Time Equivalent Headcount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_target_fte` SET TAGS ('dbx_business_glossary_term' = 'Target Full‑Time Equivalent Headcount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `last_headcount_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Headcount Review Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `open_requisitions` SET TAGS ('dbx_business_glossary_term' = 'Open Requisitions Count');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code (OUC)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Level');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type (OUT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_value_regex' = 'department|division|plant|region|distribution_center');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Version');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `seasonal_headcount_addition` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Headcount Addition');
ALTER TABLE `food_beverage_ecm`.`workforce`.`org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency (CCY)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `education_requirements` SET TAGS ('dbx_business_glossary_term' = 'Education Requirements (EDU_REQ)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `eeo_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Category');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `eeo_category` SET TAGS ('dbx_value_regex' = 'white|black|asian|hispanic|native|other');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END_DT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START_DT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `experience_years_required` SET TAGS ('dbx_business_glossary_term' = 'Required Experience Years (EXP_YRS_REQ)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `gmp_training_required` SET TAGS ('dbx_business_glossary_term' = 'GMP Training Required Flag (GMP_TRAIN_REQ)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `hazard_pay_eligible` SET TAGS ('dbx_business_glossary_term' = 'Hazard Pay Eligibility Flag (HAZARD_PAY_ELIG)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `health_and_safety_cert_required` SET TAGS ('dbx_business_glossary_term' = 'Health and Safety Certification Required Flag (HS_CERT_REQ)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `health_and_safety_cert_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `health_and_safety_cert_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family (JF)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level (JL)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Code (JPC)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_description` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Description (JP_DESC)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status (JP_STATUS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_summary` SET TAGS ('dbx_business_glossary_term' = 'Job Summary (JP_SUM)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility Flag (OT_ELIGIBLE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade (PG)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications (RCERT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Role Type (ROLE_TP)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'production|office|both');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `salary_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Salary (MAX_SAL)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `salary_max` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `salary_max` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `salary_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Salary (MIN_SAL)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `salary_min` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `salary_min` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type (SHIFT_TP)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|flex|rotating|on_call');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `skill_requirements` SET TAGS ('dbx_business_glossary_term' = 'Skill Requirements (SKILL_REQ)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Job Title (JT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `travel_required` SET TAGS ('dbx_business_glossary_term' = 'Travel Required Flag (TRAVEL_REQ)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code (UNION_CD)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`job_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'compensation_management');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `applicable_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `applicable_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligibility Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|pending|terminated');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `eligibility_rule` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `eligibility_rule` SET TAGS ('dbx_value_regex' = 'full_time|part_time|hourly|salary|contract');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `grade_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Grade');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `grade_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Midpoint Grade');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `grade_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `incentive_rate` SET TAGS ('dbx_business_glossary_term' = 'Incentive Rate');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `is_global` SET TAGS ('dbx_business_glossary_term' = 'Global Applicability Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `merit_increase_percent` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percent');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'monthly|biweekly|weekly|semi_monthly|annual');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Category');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_value_regex' = 'salary|bonus|commission|incentive|allowance');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Name');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_owner` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'base|merit|incentive|commission|bonus');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `probation_period_days` SET TAGS ('dbx_business_glossary_term' = 'Probation Period (Days)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `shift_differential_flag` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `target_achievement_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Achievement Percent');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `target_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Amount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `vesting_schedule` SET TAGS ('dbx_business_glossary_term' = 'Vesting Schedule');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'compensation_management');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Approval Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `benefit_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Deductions Amount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_ssn` SET TAGS ('dbx_business_glossary_term' = 'Employee Social Security Number');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_ssn` SET TAGS ('dbx_value_regex' = '^d{3}-d{2}-d{4}$');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Employee Tax Identification Number');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_tax_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_tax_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Error Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Payroll Error Description');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `federal_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Withholding');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Garnishment Amount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `is_manual_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Manual Adjustment Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `local_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Tax Withholding');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hourly Rate');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_method` SET TAGS ('dbx_business_glossary_term' = 'Pay Method');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Notes');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Number');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_status` SET TAGS ('dbx_value_regex' = 'pending|processed|error|cancelled');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_type` SET TAGS ('dbx_value_regex' = 'regular|bonus|commission|overtime|adjustment');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `regular_rate` SET TAGS ('dbx_business_glossary_term' = 'Regular Hourly Rate');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `shift_differential_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Hours');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `state_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'State Tax Withholding');
ALTER TABLE `food_beverage_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tax_withholdings_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Withholdings');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` SET TAGS ('dbx_subdomain' = 'compensation_management');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `total_rewards_id` SET TAGS ('dbx_business_glossary_term' = 'Total Rewards Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `open_enrollment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Event ID (OPEN_ENROLLMENT_EVENT_ID)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name (BENEFICIARY_NAME)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Relationship (BENEFICIARY_RELATIONSHIP)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_value_regex' = 'spouse|child|parent|other');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency (CONTRIBUTION_FREQUENCY)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Contribution Type (CONTRIBUTION_TYPE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `contribution_type` SET TAGS ('dbx_value_regex' = 'pre_tax|post_tax|roth');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier (COVERAGE_TIER)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|family');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count (DEPENDENT_COUNT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status (ELIGIBILITY_STATUS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `employee_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Address (EMPLOYEE_ADDRESS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `employee_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `employee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `employee_age` SET TAGS ('dbx_business_glossary_term' = 'Employee Age (EMPLOYEE_AGE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount (EMPLOYEE_CONTRIBUTION_AMOUNT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount (EMPLOYER_CONTRIBUTION_AMOUNT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `employer_match_percent` SET TAGS ('dbx_business_glossary_term' = 'Employer Match Percent (EMPLOYER_MATCH_PERCENT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date (ENROLLMENT_DATE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number (ENROLLMENT_NUMBER)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source (ENROLLMENT_SOURCE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'self_service|hr_admin');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ENROLLMENT_STATUS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `is_401k_eligible` SET TAGS ('dbx_business_glossary_term' = '401k Eligibility Flag (IS_401K_ELIGIBLE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `is_eap_eligible` SET TAGS ('dbx_business_glossary_term' = 'EAP Eligibility Flag (IS_EAP_ELIGIBLE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `is_fsa_eligible` SET TAGS ('dbx_business_glossary_term' = 'FSA Eligibility Flag (IS_FSA_ELIGIBLE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `is_hsa_eligible` SET TAGS ('dbx_business_glossary_term' = 'HSA Eligibility Flag (IS_HSA_ELIGIBLE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `is_life_insurance_eligible` SET TAGS ('dbx_business_glossary_term' = 'Life Insurance Eligibility Flag (IS_LIFE_INSURANCE_ELIGIBLE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes (ENROLLMENT_NOTES)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `payroll_deduction_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Deduction Code (PAYROLL_DEDUCTION_CODE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type (PLAN_TYPE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year (PLAN_YEAR)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `tax_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Status (TAX_STATUS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `tax_status` SET TAGS ('dbx_value_regex' = 'single|married|head_of_household');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TERMINATION_DATE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `vesting_schedule` SET TAGS ('dbx_business_glossary_term' = 'Vesting Schedule (VESTING_SCHEDULE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`total_rewards` ALTER COLUMN `vesting_schedule` SET TAGS ('dbx_value_regex' = 'immediate|graded|cliff');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'time_attendance');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-In Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-Out Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double‑Time Hours');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `hours_type` SET TAGS ('dbx_business_glossary_term' = 'Hours Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `hours_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|double_time|holiday|pto|fmla');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Currency');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `meal_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Meal Break Duration (Minutes)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Notes');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Multiplier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `pto_hours` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Hours');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` SET TAGS ('dbx_subdomain' = 'time_attendance');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `production_shift_id` SET TAGS ('dbx_business_glossary_term' = 'Production Shift ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Supervisor ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `actual_end` SET TAGS ('dbx_business_glossary_term' = 'Actual Shift End');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `actual_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `actual_start` SET TAGS ('dbx_business_glossary_term' = 'Actual Shift Start');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `labor_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Currency');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `planned_headcount` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `scheduled_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift End');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `scheduled_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift Start');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `shift_notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Notes');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|open');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|afternoon|night|rotating');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `swap_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Swap Approved Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`production_shift` ALTER COLUMN `swap_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Swap Requested Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'time_attendance');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `accrual_balance_at_request` SET TAGS ('dbx_business_glossary_term' = 'Leave Accrual Balance at Request');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|withdrawn');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Presence Indicator');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Comments');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_eligible` SET TAGS ('dbx_business_glossary_term' = 'FMLA Eligibility Indicator');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `intermittent_flag` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Indicator');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_remaining` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Remaining After Approval');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Lifecycle Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|in_review|approved|rejected|cancelled');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'fmla|ada|personal|military|parental|other');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_reference` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Reference');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_reference` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `paid_leave_flag` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Indicator');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason Description');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return‑to‑Work Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `total_leave_days` SET TAGS ('dbx_business_glossary_term' = 'Total Leave Days Requested');
ALTER TABLE `food_beverage_ecm`.`workforce`.`leave_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` SET TAGS ('dbx_subdomain' = 'training_safety');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `training_course_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `certification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `certification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|e-learning|on-the-job|virtual');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'gmp|haccp|servsafe|pcqi|sqf|allergen');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'training_safety');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `applicable_job_profiles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Job Profiles');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Course Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `course_type` SET TAGS ('dbx_value_regex' = 'Safety|Compliance|Leadership|Technical|Onboarding');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'Online|In‑person|Blended|Self‑paced');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Course Duration (Minutes)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Course Language');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ja');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Course Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `passing_score_percent` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `recertification_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Interval (Months)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`training_course` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Course Version Number');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` SET TAGS ('dbx_subdomain' = 'performance_governance');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `talent_review_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Review Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_document_id` SET TAGS ('dbx_business_glossary_term' = 'Review Document Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `business_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `compensation_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `compensation_change_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `compensation_change_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `competency_rating_communication` SET TAGS ('dbx_business_glossary_term' = 'Communication Competency Rating');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `competency_rating_innovation` SET TAGS ('dbx_business_glossary_term' = 'Innovation Competency Rating');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `competency_rating_teamwork` SET TAGS ('dbx_business_glossary_term' = 'Teamwork Competency Rating');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `employee_department` SET TAGS ('dbx_business_glossary_term' = 'Employee Department');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `employee_location` SET TAGS ('dbx_business_glossary_term' = 'Employee Location');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `employee_role` SET TAGS ('dbx_business_glossary_term' = 'Employee Role');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `employee_tenure_years` SET TAGS ('dbx_business_glossary_term' = 'Employee Tenure (Years)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `final_approved_rating` SET TAGS ('dbx_business_glossary_term' = 'Final Approved Rating');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `goal_rating_1` SET TAGS ('dbx_business_glossary_term' = 'Goal Rating 1');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `goal_rating_2` SET TAGS ('dbx_business_glossary_term' = 'Goal Rating 2');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Comments');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `merit_increase_percent` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `promotion_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommendation');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `promotion_recommendation` SET TAGS ('dbx_value_regex' = 'yes|no|consider');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `rating_comments` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Comments');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `rating_scale_max` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Maximum');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `rating_scale_min` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Minimum');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Year');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = '2022|2023|2024|2025');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review End Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_location` SET TAGS ('dbx_business_glossary_term' = 'Review Location');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_method` SET TAGS ('dbx_business_glossary_term' = 'Review Method');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_method` SET TAGS ('dbx_value_regex' = 'in_person|virtual|phone');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|calibrated|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`talent_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|pip');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `succession_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Identifier (SPID)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Identifier (POID)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_succession_incumbent_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Employee Identifier (IEID)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_succession_incumbent_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_succession_incumbent_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Target Position Identifier (TPID)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `development_actions` SET TAGS ('dbx_business_glossary_term' = 'Development Actions (DA)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective End Date (PEED)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By Identifier (LRBI)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LRT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes (PN)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Code (SPC)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Type (SPT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'critical|non_critical|strategic');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Plan Priority (PP)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Readiness Level (RL)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `readiness_level` SET TAGS ('dbx_value_regex' = 'ready_now|1-2_years|3-5_years');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Date (PRD)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `risk_of_loss_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk of Loss Rating (RLR)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `risk_of_loss_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Start Date (PESD)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `succession_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Status (SPS)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `succession_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`succession_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number (PVN)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` SET TAGS ('dbx_subdomain' = 'training_safety');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `osha_incident_id` SET TAGS ('dbx_business_glossary_term' = 'OSHA Incident ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `equipment_master_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `body_part` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|investigating|resolved|closed');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `days_away` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `exposure_level` SET TAGS ('dbx_business_glossary_term' = 'Exposure Level');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `exposure_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `hazard_type` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|chemical|ergonomic|environmental|other');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_datetime` SET TAGS ('dbx_business_glossary_term' = 'Incident Date and Time');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'injury|illness|near_miss|property_damage');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `injury_type` SET TAGS ('dbx_value_regex' = 'laceration|fracture|burn|sprain|contusion|other');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `investigation_complete` SET TAGS ('dbx_business_glossary_term' = 'Investigation Complete Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `lost_time_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Indicator');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `medical_provider` SET TAGS ('dbx_business_glossary_term' = 'Medical Provider');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `medical_provider` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `medical_provider` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `medical_treatment_provided` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Provided');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `medical_treatment_provided` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `medical_treatment_provided` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `restricted_duty_days` SET TAGS ('dbx_business_glossary_term' = 'Restricted Duty Days');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `root_cause_detail` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Detail');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing|graveyard');
ALTER TABLE `food_beverage_ecm`.`workforce`.`osha_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` SET TAGS ('dbx_subdomain' = 'training_safety');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `labor_grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Grievance ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `cba_article` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement Article');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `grievance_number` SET TAGS ('dbx_business_glossary_term' = 'Grievance Number');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `grievance_status` SET TAGS ('dbx_business_glossary_term' = 'Grievance Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `grievance_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|appealed');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `grievance_step` SET TAGS ('dbx_business_glossary_term' = 'Grievance Step');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `grievance_step` SET TAGS ('dbx_value_regex' = 'step1|step2|step3|step4|arbitration');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `grievance_type` SET TAGS ('dbx_business_glossary_term' = 'Grievance Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `grievance_type` SET TAGS ('dbx_value_regex' = 'discipline|scheduling|pay|safety|seniority');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grievance Notes');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Grievance Outcome');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'settled|withdrawn|dismissed|upheld|rejected');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `plant_location_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Location Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `union_local` SET TAGS ('dbx_business_glossary_term' = 'Union Local Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`labor_grievance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Employee Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `actual_fte` SET TAGS ('dbx_business_glossary_term' = 'Actual Full‑Time Equivalent (FTE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte` SET TAGS ('dbx_business_glossary_term' = 'Approved Full‑Time Equivalent (FTE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `attrition_rate` SET TAGS ('dbx_business_glossary_term' = 'Attrition Rate');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budget_fte` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Full‑Time Equivalent (FTE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective End Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_target_fte` SET TAGS ('dbx_business_glossary_term' = 'Target Full‑Time Equivalent (FTE)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `job_family_code` SET TAGS ('dbx_business_glossary_term' = 'Job Family Code');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `job_family_name` SET TAGS ('dbx_business_glossary_term' = 'Job Family Name');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `job_family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `job_family_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `open_requisitions` SET TAGS ('dbx_business_glossary_term' = 'Open Requisitions');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Number');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_review_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|seasonal|projected');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period` SET TAGS ('dbx_business_glossary_term' = 'Planning Period');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4|FY');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `seasonal_headcount_addition` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Headcount Addition');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `approved_fte` SET TAGS ('dbx_business_glossary_term' = 'Approved FTE');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `budgeted_salary_max` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Salary Maximum');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `budgeted_salary_max` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `budgeted_salary_max` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `budgeted_salary_min` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Salary Minimum');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `budgeted_salary_min` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `budgeted_salary_min` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `diversity_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversity Flag');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `drug_screen_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `drug_screen_status` SET TAGS ('dbx_value_regex' = 'not_required|not_started|passed|failed');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|intern');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `external_candidate_allowed` SET TAGS ('dbx_business_glossary_term' = 'External Candidate Allowed');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `internal_candidate_allowed` SET TAGS ('dbx_business_glossary_term' = 'Internal Candidate Allowed');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `interview_stage` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'plant|warehouse|office|store|remote');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Offer Amount');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'not_made|made|accepted|declined|withdrawn');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'not_posted|posted|paused|expired');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Requisition Priority');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Requisition Reason');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `reason` SET TAGS ('dbx_value_regex' = 'growth|replacement|new_product|seasonal');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `required_education` SET TAGS ('dbx_business_glossary_term' = 'Required Education');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `required_education` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|phd');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `required_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Required Experience (Years)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'draft|open|closed|cancelled|filled|on_hold');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'new_hire|replacement|temp|contract|intern');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `shift_schedule` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'internal|employee_referral|job_board|recruiter|social_media|agency');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `target_fte` SET TAGS ('dbx_business_glossary_term' = 'Target FTE');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `food_beverage_ecm`.`workforce`.`requisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` SET TAGS ('dbx_subdomain' = 'performance_governance');
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ALTER COLUMN `review_document_id` SET TAGS ('dbx_business_glossary_term' = 'Review Document Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ALTER COLUMN `superseded_review_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ALTER COLUMN `author_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`review_document` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'time_attendance');
ALTER TABLE `food_beverage_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `rotated_from_shift_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`open_enrollment_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`open_enrollment_event` SET TAGS ('dbx_subdomain' = 'compensation_management');
ALTER TABLE `food_beverage_ecm`.`workforce`.`open_enrollment_event` ALTER COLUMN `open_enrollment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Event Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`open_enrollment_event` ALTER COLUMN `previous_open_enrollment_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`workforce`.`policy` SET TAGS ('dbx_subdomain' = 'performance_governance');
ALTER TABLE `food_beverage_ecm`.`workforce`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `food_beverage_ecm`.`workforce`.`policy` ALTER COLUMN `superseded_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`policy` ALTER COLUMN `policy_owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`workforce`.`policy` ALTER COLUMN `policy_owner_name` SET TAGS ('dbx_pii_name' = 'true');
