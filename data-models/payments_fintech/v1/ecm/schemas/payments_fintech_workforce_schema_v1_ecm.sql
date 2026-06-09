-- Schema for Domain: workforce | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`workforce` COMMENT 'Employee identity, role assignments, organizational structure, and HR compliance records for the payments fintech enterprise.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique system-generated identifier for the employee.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Employee payroll expenses are allocated to cost centers; cost_center_id on employee enables accurate expense tracking.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Required for tax residency and AML compliance reporting; payroll must know employees country of tax residence.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Ensures payroll currency aligns with master currency list for exchange rate calculations and reporting.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Employees belong to a legal entity for tax and compliance reporting; legal_entity_id creates the required link.',
    `manager_employee_id` BIGINT COMMENT 'Identifier of the employees direct manager.',
    `work_schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.work_schedule. Business justification: Employees are assigned a work schedule; many employees can share the same schedule, so employee gets a foreign key to work_schedule.',
    `workforce_location_id` BIGINT COMMENT 'Foreign key linking to workforce.workforce_location. Business justification: Replace free‑text work_location on employee with a foreign key to the authoritative workforce_location table.',
    `address_full` STRING COMMENT 'Full mailing address of the employees primary residence.',
    `background_check_status` STRING COMMENT 'Result of pre-employment background screening.. Valid values are `cleared|pending|failed|exempt`',
    `bonus_eligibility` BOOLEAN COMMENT 'Indicates if employee is eligible for performance bonus.',
    `date_of_birth` DATE COMMENT 'Birth date of the employee.',
    `department_code` STRING COMMENT 'Code representing the department to which the employee belongs.',
    `effective_start_date` DATE COMMENT 'Date when employment became effective (may differ from hire date for retroactive hires).',
    `email_address` STRING COMMENT 'Primary corporate email address.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Name of emergency contact person.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of emergency contact.',
    `employment_status` STRING COMMENT 'Current employment lifecycle status.. Valid values are `active|on_leave|terminated|retired|pending`',
    `employment_type` STRING COMMENT 'Classification of employment contract.. Valid values are `full_time|part_time|contractor|intern|temporary`',
    `equity_grant_flag` BOOLEAN COMMENT 'Indicates if employee has equity compensation.',
    `first_name` STRING COMMENT 'Given name of the employee.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'FTE proportion (e.g., 1.00 for full-time).',
    `hire_date` DATE COMMENT 'Date the employee was hired.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Hourly compensation rate for hourly employees.',
    `job_grade` STRING COMMENT 'Grade or band associated with the position for compensation.',
    `job_title` STRING COMMENT 'Official title of the employees position.',
    `last_name` STRING COMMENT 'Family name of the employee.',
    `legal_name` STRING COMMENT 'Full legal name as on official documents.',
    `middle_name` STRING COMMENT 'Middle name of the employee, if any.',
    `national_id_number` STRING COMMENT 'Government-issued personal identifier (e.g., SSN, SIN).',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates if employee can accrue overtime.',
    `phone_number` STRING COMMENT 'Primary corporate phone number.',
    `preferred_name` STRING COMMENT 'Preferred name or nickname used by the employee.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the employee record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employee record.',
    `remote_status` STRING COMMENT 'Indicates if employee works on-site, remotely, or hybrid.. Valid values are `on_site|remote|hybrid`',
    `reports_to_position` STRING COMMENT 'Title of the position the employee reports to.',
    `salary_amount` DECIMAL(18,2) COMMENT 'Annual base salary in USD.',
    `tax_id_number` STRING COMMENT 'Tax identifier for payroll and reporting.',
    `termination_date` DATE COMMENT 'Date the employment ended, if applicable.',
    `visa_status` STRING COMMENT 'Immigration status for employment eligibility.. Valid values are `citizen|permanent_resident|work_visa|none`',
    `work_permit_number` STRING COMMENT 'Number of work permit or visa, if applicable.',
    `work_shift` STRING COMMENT 'Scheduled shift pattern.. Valid values are `day|night|flex|rotating`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Core SSOT master record for every employee of the Payments Fintech enterprise. Captures full identity, employment classification, hire date, employment type (full-time, part-time, contractor, intern), legal entity assignment, cost center, work location, employment status (active, on-leave, terminated), job title, grade band, and regulatory identifiers (national ID, tax ID). This is the authoritative golden record for workforce identity across all HR, compliance, and operational systems.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the position record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Cost allocation of salaries uses the cost center linked to each position; cost_center_id enables accurate budgeting.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Positions must be tied to a legal entity for payroll tax and reporting; legal_entity_id creates that association.',
    `reporting_manager_position_id` BIGINT COMMENT 'Identifier of the managers position to which this position reports.',
    `reports_to_position_id` BIGINT COMMENT 'Self-referencing FK on position (reports_to_position_id)',
    `budgeted_headcount` STRING COMMENT 'Number of headcount budgeted for this position (typically 1).',
    `compensation_band` STRING COMMENT 'Compensation band or range category for the position.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for salary amounts.. Valid values are `^[A-Z]{3}$`',
    `department` STRING COMMENT 'Department name or code where the position resides.',
    `effective_end_date` DATE COMMENT 'Date when the position is no longer effective (end of budget period), nullable if open-ended.',
    `effective_start_date` DATE COMMENT 'Date when the position becomes effective (start of budget period).',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Proportion of a full-time workload allocated to the position (e.g., 1.0 for full-time).',
    `grade_level` STRING COMMENT 'Organizational grade or level assigned to the position.',
    `is_remote_allowed` BOOLEAN COMMENT 'Indicates if the position can be performed remotely.',
    `job_family` STRING COMMENT 'Broad classification of the job grouping similar roles.',
    `job_function` STRING COMMENT 'Specific functional area of the job.',
    `location_code` STRING COMMENT 'Geographic location code (e.g., office site) for the position.',
    `position_code` STRING COMMENT 'Human readable code for the position used in HR systems.',
    `position_description` STRING COMMENT 'Free-text description of the position responsibilities and scope.',
    `position_status` STRING COMMENT 'Current status of the position within the workforce planning lifecycle.. Valid values are `open|filled|frozen|eliminated|pending`',
    `position_type` STRING COMMENT 'Employment type for the position.. Valid values are `full_time|part_time|contractor|temporary`',
    `recruitment_source` STRING COMMENT 'Source channel through which the position was originally opened (e.g., internal, external, referral).',
    `required_education_level` STRING COMMENT 'Minimum education level required (e.g., bachelors, masters).',
    `required_experience_years` DECIMAL(18,2) COMMENT 'Number of years of experience required for the position.',
    `salary_max` DECIMAL(18,2) COMMENT 'Maximum salary for the positions compensation band, in local currency.',
    `salary_min` DECIMAL(18,2) COMMENT 'Minimum salary for the positions compensation band, in local currency.',
    `skill_set` STRING COMMENT 'Comma-separated list of key skills required for the position.',
    `title` STRING COMMENT 'Official job title for the position.',
    `updated_by` STRING COMMENT 'User identifier who last updated the position record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the position record.',
    `created_by` STRING COMMENT 'User identifier who created the position record.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized headcount position master defining each approved role slot within the organizational structure. Captures position code, job family, job function, grade level, FTE allocation, budgeted headcount, position status (open, filled, frozen, eliminated), reporting line, and the legal entity and cost center to which the position is budgeted. Distinct from the employee record — a position can be vacant or filled by multiple employees over time.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each organizational unit.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Headcount and budgeting reports aggregate by country; linking to reference country provides standardized codes.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Budget allocations use reference currency for consistency across entities.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns the unit.',
    `parent_unit_org_unit_id` BIGINT COMMENT 'Reference to the immediate parent unit in the hierarchy.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who heads the unit.',
    `parent_org_unit_id` BIGINT COMMENT 'Self-referencing FK on org_unit (parent_org_unit_id)',
    `address_line1` STRING COMMENT 'First line of the units physical address.',
    `address_line2` STRING COMMENT 'Second line of the units physical address (optional).',
    `audit_status` STRING COMMENT 'Result of the latest audit.. Valid values are `passed|failed|pending`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated to the unit, expressed in the units functional currency.',
    `city` STRING COMMENT 'City component of the units address.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the unit with regulatory requirements.. Valid values are `compliant|non_compliant|under_review`',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier used for budgeting and expense allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the organizational unit record was first created in the system.',
    `data_retention_policy` STRING COMMENT 'Policy description governing how long data associated with the unit is retained.',
    `effective_end_date` DATE COMMENT 'Date when the unit ceased operation (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the unit became operational.',
    `headcount` STRING COMMENT 'Current number of full‑time equivalent employees assigned to the unit.',
    `is_cost_allocation_enabled` BOOLEAN COMMENT 'Indicates whether the unit participates in cost‑allocation calculations.',
    `is_financial_reporting_unit` BOOLEAN COMMENT 'True if the unit is a reporting entity for financial statements.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or financial audit for the unit.',
    `org_unit_code` STRING COMMENT 'Business identifier or code used in internal systems to reference the unit.',
    `org_unit_description` STRING COMMENT 'Free‑form description providing additional context about the units purpose and scope.',
    `org_unit_name` STRING COMMENT 'Human‑readable name of the unit (e.g., "Consumer Payments Division").',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the unit.. Valid values are `active|inactive|planned|closed`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the units address.',
    `primary_contact_email` STRING COMMENT 'Primary email address for the units administrative contact.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the units administrative contact.',
    `region_code` STRING COMMENT 'Three‑letter ISO 3166‑1 country code representing the primary region of the unit. [ENUM-REF-CANDIDATE: USA|CAN|GBR|FRA|DEU|JPN|AUS|CHN|IND|BRA — promote to reference product]',
    `risk_score` STRING COMMENT 'Numerical risk rating assigned to the unit based on internal risk models.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the units primary location (e.g., "America/New_York").',
    `unit_type` STRING COMMENT 'Category of the unit within the enterprise hierarchy.. Valid values are `division|department|team|squad|cost_center|function`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the organizational unit record.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit master representing the hierarchical structure of the enterprise — divisions, departments, teams, and cost centers. Captures unit name, unit type (division, department, team, squad), parent unit reference for hierarchy traversal, effective date range, owning legal entity, geographic region, and unit head employee reference. Supports org chart rendering, headcount reporting, and cost allocation across the payments fintech enterprise.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique surrogate key for the job profile record.',
    `reports_to_job_profile_id` BIGINT COMMENT 'Identifier of the parent job profile in the reporting hierarchy.',
    `parent_job_profile_id` BIGINT COMMENT 'Self-referencing FK on job_profile (parent_job_profile_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the job profile record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the pay grade (e.g., USD, EUR).',
    `department_code` STRING COMMENT 'Code of the department to which the role belongs.',
    `effective_from` DATE COMMENT 'Date when the job profile becomes active for new hires.',
    `effective_until` DATE COMMENT 'Date when the job profile is retired; null if open‑ended.',
    `flsa_classification` STRING COMMENT 'Classification under the Fair Labor Standards Act indicating exempt or non‑exempt status.. Valid values are `exempt|non_exempt`',
    `is_manager_role` BOOLEAN COMMENT 'Flag indicating whether the role includes managerial responsibilities.',
    `job_code` STRING COMMENT 'Business identifier code for the job profile, used in HR and payroll systems.',
    `job_description` STRING COMMENT 'Detailed narrative of responsibilities, duties, and expectations for the role.',
    `job_family` STRING COMMENT 'High‑level grouping of related roles (e.g., Risk Management, Engineering).',
    `job_function` STRING COMMENT 'Specific functional area within the family (e.g., AML Monitoring, Data Engineering).',
    `job_profile_level` STRING COMMENT 'Organizational seniority level (e.g., Analyst, Manager, Director).',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of the job profile definition.. Valid values are `active|inactive|deprecated`',
    `job_title` STRING COMMENT 'Human‑readable title of the role (e.g., Senior Fraud Analyst).',
    `location_scope` STRING COMMENT 'Geographic scope of the role (global, regional, local).',
    `pay_grade_max` DECIMAL(18,2) COMMENT 'Upper bound of the salary range for the role, expressed in the local currency.',
    `pay_grade_min` DECIMAL(18,2) COMMENT 'Lower bound of the salary range for the role, expressed in the local currency.',
    `position_type` STRING COMMENT 'Employment arrangement for the role.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `regulatory_license_required` BOOLEAN COMMENT 'Indicates whether the role must hold a regulatory license (e.g., AML compliance officer).',
    `regulatory_license_type` STRING COMMENT 'Name of the specific regulatory license required, if any (e.g., MSB License).',
    `required_certifications` STRING COMMENT 'Comma‑separated list of professional certifications required (e.g., CISA, CAMS).',
    `required_competencies` STRING COMMENT 'Comma‑separated list of core competencies needed for the role (e.g., analytical thinking, communication).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the job profile record.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Job profile catalog defining standardized role definitions used across the enterprise. Captures job code, job title, job family, job function, FLSA classification (exempt/non-exempt), pay grade range, required competencies, required certifications, and whether the role requires regulatory licensing (e.g., MSB compliance officer, AML analyst). Serves as the template from which positions and employee assignments are derived.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` (
    `employment_contract_id` BIGINT COMMENT 'System‑generated unique identifier for the employment contract record.',
    `department_org_unit_id` BIGINT COMMENT 'Identifier of the department to which the employee is assigned.',
    `employee_id` BIGINT COMMENT 'Identifier of the employees direct manager.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department to which the employee is assigned.',
    `primary_employment_employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom the contract applies.',
    `renewed_employment_contract_id` BIGINT COMMENT 'Self-referencing FK on employment_contract (renewed_employment_contract_id)',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment applied to the contract.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract was approved.',
    `approved_by` BIGINT COMMENT 'Identifier of the HR or legal representative who approved the contract.',
    `benefits_enrollment_flag` BOOLEAN COMMENT 'True if the employee is enrolled in company benefit programs.',
    `collective_bargaining_agreement` STRING COMMENT 'Reference to any applicable collective bargaining agreement.',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether a confidentiality clause is present in the contract.',
    `contract_amendment_flag` BOOLEAN COMMENT 'True if the contract has been amended after initial execution.',
    `contract_document_url` STRING COMMENT 'Link to the stored electronic copy of the signed contract.',
    `contract_expiry_notice_sent_date` DATE COMMENT 'Date when notice of upcoming contract expiry was sent.',
    `contract_number` STRING COMMENT 'External reference number assigned to the contract for tracking and legal purposes.',
    `contract_review_date` DATE COMMENT 'Scheduled date for the next contract review.',
    `contract_review_status` STRING COMMENT 'Current status of the scheduled contract review.. Valid values are `pending|completed|overdue`',
    `contract_signed_date` DATE COMMENT 'Date on which the contract was signed by all parties.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the contract.. Valid values are `draft|active|suspended|terminated|expired`',
    `contract_type` STRING COMMENT 'Classification of the employment relationship (e.g., permanent, fixed‑term, zero‑hours, contractor).. Valid values are `permanent|fixed_term|zero_hours|contractor`',
    `contract_version` STRING COMMENT 'Version number of the contract for change tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level indicating the sensitivity of the contract data.. Valid values are `restricted|confidential|internal|public`',
    `effective_end_date` DATE COMMENT 'Date on which the contract terminates or expires; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date on which the contract becomes legally binding.',
    `employee_classification` STRING COMMENT 'Classification such as exempt, non‑exempt, contractor, etc.',
    `employee_grade` STRING COMMENT 'Organizational grade or level assigned to the employee.',
    `full_time_indicator` BOOLEAN COMMENT 'True if the contract is for a full‑time position; false otherwise.',
    `governing_jurisdiction` STRING COMMENT 'Country or legal jurisdiction whose labor laws govern the contract.',
    `non_compete_clause_flag` BOOLEAN COMMENT 'Indicates whether a non‑compete clause is included.',
    `notice_period_days` STRING COMMENT 'Number of calendar days the employee or employer must give to terminate the contract.',
    `overtime_eligible` BOOLEAN COMMENT 'True if the employee is eligible for overtime compensation.',
    `payment_frequency` STRING COMMENT 'How often salary payments are made to the employee.. Valid values are `monthly|biweekly|weekly|quarterly|annually`',
    `payroll_group_code` STRING COMMENT 'Code identifying the payroll group to which the employee belongs.',
    `probation_period_days` STRING COMMENT 'Length of the initial probationary period measured in days.',
    `remote_work_flag` BOOLEAN COMMENT 'Indicates whether the employee is authorized to work remotely.',
    `salary_amount` DECIMAL(18,2) COMMENT 'Base salary or compensation amount agreed in the contract.',
    `salary_currency` STRING COMMENT 'ISO 4217 currency code for the salary amount.. Valid values are `USD|EUR|GBP|JPY|AUD|CAD`',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the employee is exempt from certain tax withholdings.',
    `termination_date` DATE COMMENT 'Date on which the contract was terminated.',
    `termination_reason` STRING COMMENT 'Reason for contract termination, if applicable.. Valid values are `resignation|termination|layoff|mutual_agreement`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `work_location` STRING COMMENT 'Primary physical location or office where the employee performs duties.',
    CONSTRAINT pk_employment_contract PRIMARY KEY(`employment_contract_id`)
) COMMENT 'Employment contract master record capturing the formal terms of engagement between the enterprise and an employee or contractor. Stores contract type (permanent, fixed-term, zero-hours, contractor SOW), start date, end date, notice period, probation period, governing jurisdiction, applicable collective bargaining agreement, and contract status. Critical for workforce compliance in the 200+ country footprint of the payments fintech enterprise.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Unique surrogate key for each compensation plan record.',
    `approved_by_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the compensation plan.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the compensation plan.',
    `superseded_compensation_plan_id` BIGINT COMMENT 'Self-referencing FK on compensation_plan (superseded_compensation_plan_id)',
    `allowance_amount` DECIMAL(18,2) COMMENT 'Monetary amount for any additional allowances (e.g., housing, transport).',
    `allowance_type` STRING COMMENT 'Category of the allowance provided.. Valid values are `housing|transport|meal|other`',
    `approval_date` DATE COMMENT 'Date when the compensation plan received formal approval.',
    `base_salary` DECIMAL(18,2) COMMENT 'Fixed base salary amount for salaried employees.',
    `bonus_cap_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount that can be awarded as a bonus.',
    `bonus_target_percentage` DECIMAL(18,2) COMMENT 'Target bonus expressed as a percentage of base salary.',
    `compensation_component` STRING COMMENT 'Classification of the compensation element represented by this record.. Valid values are `base|bonus|equity|allowance|overtime`',
    `compensation_plan_description` STRING COMMENT 'Narrative description of the compensation plan purpose and scope.',
    `compensation_plan_status` STRING COMMENT 'Current lifecycle status of the plan.. Valid values are `active|inactive|pending|retired`',
    `compliance_equal_pay` BOOLEAN COMMENT 'Flag indicating compliance with equal‑pay regulations for the plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compensation plan record was first created.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `effective_from` DATE COMMENT 'Date when the compensation plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the compensation plan expires or is superseded; null for open‑ended.',
    `equity_grant_eligibility` BOOLEAN COMMENT 'Indicates eligibility for equity‑based compensation.',
    `equity_grant_type` STRING COMMENT 'Type of equity award provided under the plan.. Valid values are `stock_option|restricted_stock|rsu|phantom`',
    `equity_units` DECIMAL(18,2) COMMENT 'Number of equity units (e.g., shares, RSUs) granted.',
    `grade_step` STRING COMMENT 'Specific step within a pay grade, often reflecting seniority or performance.',
    `jurisdiction` STRING COMMENT 'Three‑letter country code where the compensation plan is applied.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the plan.',
    `pay_frequency` STRING COMMENT 'Regular interval at which base compensation is paid.. Valid values are `monthly|biweekly|weekly|quarterly|annually`',
    `pay_grade` STRING COMMENT 'Organizational pay grade associated with the plan.',
    `plan_code` STRING COMMENT 'Business identifier code assigned to the compensation plan.',
    `plan_name` STRING COMMENT 'Human‑readable name of the compensation plan.',
    `plan_type` STRING COMMENT 'Category of the plan indicating the primary compensation model.. Valid values are `salary|commission|bonus|equity|mixed`',
    `tax_status` STRING COMMENT 'Indicates whether compensation is subject to tax withholding.. Valid values are `taxable|non_taxable|exempt`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compensation plan record.',
    `variable_pay_eligibility` BOOLEAN COMMENT 'Indicates whether the employee is eligible for variable compensation such as bonuses or commissions.',
    `vesting_schedule` STRING COMMENT 'Textual description of the vesting timeline and conditions for equity awards.',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Compensation plan master defining the pay structure assigned to an employee or position. Captures base salary, pay frequency (monthly, bi-weekly, weekly), currency, pay grade, step within grade, variable pay eligibility, bonus target percentage, equity grant eligibility, and effective date range. Supports payroll processing, compensation benchmarking, and regulatory pay equity reporting across all jurisdictions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Surrogate primary key for the payroll record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Payroll reporting uses reference currency for audit trails and multi‑currency handling.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee receiving the payroll.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Tax withholding and regulatory filing require linking payroll to master jurisdiction data.',
    `reversal_payroll_record_id` BIGINT COMMENT 'Self-referencing FK on payroll_record (reversal_payroll_record_id)',
    `bank_account_number` STRING COMMENT 'Employees bank account number for direct deposit.',
    `bank_routing_number` STRING COMMENT 'Routing number identifying the employees financial institution.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Additional bonus compensation paid in the period.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission earnings paid to the employee for the period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll record was first created in the system.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total earnings before any deductions for the pay period.',
    `health_insurance_contribution_amount` DECIMAL(18,2) COMMENT 'Employer‑paid health insurance contribution for the pay period.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Final amount paid to the employee after deductions.',
    `notes` STRING COMMENT 'Free‑form text field for any additional comments or remarks about the payroll record.',
    `other_employer_contributions_amount` DECIMAL(18,2) COMMENT 'Sum of any additional employer contributions (e.g., bonuses, allowances).',
    `overtime_amount` DECIMAL(18,2) COMMENT 'Monetary compensation for overtime hours.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked in the pay period.',
    `pay_cycle` STRING COMMENT 'Regular frequency at which the employee is paid.. Valid values are `weekly|biweekly|semimonthly|monthly|quarterly|annually`',
    `pay_period_end_date` DATE COMMENT 'Last calendar date of the payroll period.',
    `pay_period_start_date` DATE COMMENT 'First calendar date of the payroll period.',
    `pay_run_timestamp` TIMESTAMP COMMENT 'Date and time when the payroll run was executed.',
    `payment_method` STRING COMMENT 'Method used to disburse the payroll to the employee.. Valid values are `direct_deposit|check|wire`',
    `payment_status_date` DATE COMMENT 'Date on which the payroll payment was successfully posted.',
    `payroll_number` STRING COMMENT 'Business identifier for the payroll run, unique per employee and pay period.',
    `payroll_record_status` STRING COMMENT 'Current lifecycle status of the payroll record.. Valid values are `calculated|approved|paid|reversed|failed`',
    `payroll_type` STRING COMMENT 'Classification of the payroll component (e.g., salary, hourly, bonus).. Valid values are `salary|hourly|bonus|commission|overtime`',
    `pension_contribution_amount` DECIMAL(18,2) COMMENT 'Employer‑paid pension contribution for the pay period.',
    `reversal_reason` STRING COMMENT 'Reason provided when a payroll record is reversed or voided.',
    `social_security_contribution_amount` DECIMAL(18,2) COMMENT 'Employer‑paid social security contribution for the pay period.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the employee is exempt from tax withholding for this period.',
    `tax_withholding_amount` DECIMAL(18,2) COMMENT 'Total tax withheld from the employees earnings for the period.',
    `total_deductions_amount` DECIMAL(18,2) COMMENT 'Aggregate amount of all deductions applied to the gross pay.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll record.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Payroll processing record capturing each pay run result for an employee. Stores pay period start and end dates, gross pay, net pay, total deductions, tax withholding amounts by jurisdiction, employer contributions (pension, social security, health), pay run status (calculated, approved, paid, reversed), payment method (direct deposit, check, wire), and bank account reference. The authoritative transactional record for each payroll disbursement event.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` (
    `payroll_deduction_id` BIGINT COMMENT 'System‑generated unique identifier for each payroll deduction line.',
    `benefit_plan_id` BIGINT COMMENT 'Identifier of the benefit plan or legal order governing the deduction.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom the deduction applies.',
    `payroll_record_id` BIGINT COMMENT 'Identifier of the payroll processing batch (header) that contains this deduction.',
    `payroll_run_id` BIGINT COMMENT 'Identifier of the payroll processing batch (header) that contains this deduction.',
    `adjusted_payroll_deduction_id` BIGINT COMMENT 'Self-referencing FK on payroll_deduction (adjusted_payroll_deduction_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the deduction line was initially recorded.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the deduction amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Amount deducted from gross pay, expressed in the payroll currency.',
    `deduction_basis` STRING COMMENT 'Indicates whether the deduction is a fixed amount (flat) or a percentage of gross pay.. Valid values are `flat|percentage`',
    `deduction_code` STRING COMMENT 'Short alphanumeric code representing the deduction in payroll configuration.. Valid values are `^[A-Z0-9]{3,5}$`',
    `deduction_description` STRING COMMENT 'Full description of the deduction for reporting and employee communication.',
    `deduction_quantity` STRING COMMENT 'Numeric count that drives the deduction amount when applicable.',
    `deduction_rate` DECIMAL(18,2) COMMENT 'Percentage rate used to compute the deduction when basis = percentage.',
    `deduction_type` STRING COMMENT 'Categorizes the deduction (e.g., federal tax, pension contribution, health insurance premium).. Valid values are `federal_tax|state_tax|pension|health_insurance|garnishment|other`',
    `effective_date` DATE COMMENT 'Calendar date on which the deduction starts to apply.',
    `employer_match_amount` DECIMAL(18,2) COMMENT 'Amount contributed by the employer for matching benefit plans.',
    `end_date` DATE COMMENT 'Calendar date on which the deduction ceases; null for ongoing deductions.',
    `is_post_tax` BOOLEAN COMMENT 'True if the deduction is applied after tax calculation.',
    `is_pre_tax` BOOLEAN COMMENT 'True if the deduction reduces taxable income (pre‑tax).',
    `is_voluntary` BOOLEAN COMMENT 'True for employee‑initiated, voluntary deductions (e.g., 401(k) elective).',
    `legal_order_reference` STRING COMMENT 'Reference number of the legal order (e.g., garnishment, child support) that mandates the deduction.',
    `line_sequence` STRING COMMENT 'Ordinal position of the deduction line in the payroll run.',
    `notes` STRING COMMENT 'Additional remarks or explanations for the deduction line.',
    `payroll_deduction_status` STRING COMMENT 'Operational status of the deduction (e.g., active, reversed due to correction).. Valid values are `active|inactive|reversed|voided`',
    `tax_withheld_amount` DECIMAL(18,2) COMMENT 'Portion of the deduction that represents tax withheld.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the deduction line.',
    CONSTRAINT pk_payroll_deduction PRIMARY KEY(`payroll_deduction_id`)
) COMMENT 'Individual deduction line item within a payroll record capturing each pre-tax and post-tax deduction applied to an employees gross pay. Stores deduction type (federal tax, state tax, pension contribution, health insurance premium, garnishment, union dues, FSA/HSA contribution), deduction amount, deduction basis (flat, percentage), and the governing benefit plan or legal order reference. Enables granular payroll audit and regulatory tax reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique system-generated identifier for the benefit enrollment record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who is enrolled in the benefit plan.',
    `prior_benefit_enrollment_id` BIGINT COMMENT 'Self-referencing FK on benefit_enrollment (prior_benefit_enrollment_id)',
    `benefit_category` STRING COMMENT 'High‑level category grouping of the benefit (e.g., health, wellness, financial).. Valid values are `health|wellness|financial`',
    `contribution_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for contribution amounts (e.g., USD, EUR).',
    `coverage_end_date` DATE COMMENT 'Date when the employees benefit coverage ends (may differ from termination_date).',
    `coverage_start_date` DATE COMMENT 'Date when the employees benefit coverage actually begins (may differ from effective_date).',
    `coverage_tier` STRING COMMENT 'Level of coverage selected for the employee (employee only, employee + spouse, or family).. Valid values are `employee_only|employee_spouse|family`',
    `created_by_user` STRING COMMENT 'User identifier of the person who created the enrollment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the enrollment record was first created in the system.',
    `dependent_count` STRING COMMENT 'Number of dependents covered under the enrollment.',
    `effective_date` DATE COMMENT 'Date on which the benefit enrollment becomes effective.',
    `eligibility_status` STRING COMMENT 'Current eligibility determination for the employee.. Valid values are `eligible|ineligible|pending`',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Monetary amount the employee contributes toward the benefit each pay period.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Monetary amount the employer contributes toward the benefit each pay period.',
    `enrollment_action` STRING COMMENT 'Action taken for this enrollment record.. Valid values are `new|change|cancel|reactivate`',
    `enrollment_method` STRING COMMENT 'Channel used to submit the enrollment.. Valid values are `online|offline|mobile`',
    `enrollment_notes` STRING COMMENT 'Additional comments or remarks related to the enrollment.',
    `enrollment_reason` STRING COMMENT 'Free‑text explanation for why the enrollment was created or changed.',
    `enrollment_source` STRING COMMENT 'Origin of the enrollment request.. Valid values are `hr_portal|paper|broker|self_service`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment record.. Valid values are `active|inactive|terminated|pending|canceled`',
    `is_current` BOOLEAN COMMENT 'True if this record represents the employees current active enrollment for the plan.',
    `last_updated_by_user` STRING COMMENT 'User identifier of the person who last modified the enrollment record.',
    `payroll_cycle` STRING COMMENT 'Frequency with which contributions are deducted from payroll.. Valid values are `monthly|biweekly|weekly|semi_monthly`',
    `payroll_deduction_code` STRING COMMENT 'Code used in payroll system to map the contribution to the correct deduction line.',
    `plan_code` STRING COMMENT 'Internal code that uniquely identifies the benefit plan within the benefits catalog.',
    `plan_name` STRING COMMENT 'Human‑readable name of the benefit plan.',
    `plan_type` STRING COMMENT 'Category of the benefit plan (e.g., medical, dental, vision, life insurance, disability, pension/401k, FSA, HSA, EAP). [ENUM-REF-CANDIDATE: medical|dental|vision|life|disability|pension|fsa|hsa|eap — promote to reference product]',
    `plan_version` STRING COMMENT 'Version identifier of the benefit plan, useful for tracking plan changes over time.',
    `post_tax_flag` BOOLEAN COMMENT 'True if the contribution is taken from post‑tax earnings.',
    `pre_tax_flag` BOOLEAN COMMENT 'True if the contribution is taken from pre‑tax earnings.',
    `taxability_flag` BOOLEAN COMMENT 'Indicates whether the employee contribution is tax‑deductible (true) or not (false).',
    `termination_date` DATE COMMENT 'Date on which the benefit enrollment ends or is scheduled to end (null if open‑ended).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the enrollment record.',
    `waiver_flag` BOOLEAN COMMENT 'True if the employee has waived participation in the benefit.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Employee benefit enrollment record capturing active enrollment in employer-sponsored benefit plans. Stores benefit plan type (medical, dental, vision, life insurance, disability, pension/401k, FSA, HSA, EAP), plan name, coverage tier (employee only, employee + spouse, family), enrollment effective date, termination date, employee contribution amount, employer contribution amount, and enrollment status. Supports benefits administration and ACA/regulatory compliance reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique system-generated identifier for the leave request record.',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the manager or HR representative who approved or rejected the request.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or HR representative who approved or rejected the request.',
    `primary_leave_employee_id` BIGINT COMMENT 'Identifier of the employee who submitted the leave request.',
    `original_leave_request_id` BIGINT COMMENT 'Self-referencing FK on leave_request (original_leave_request_id)',
    `accrual_policy_code` STRING COMMENT 'Code referencing the specific accrual rule set governing this leave type.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the request was approved, rejected, or otherwise acted upon.',
    `approved_days` STRING COMMENT 'Number of days approved by the manager or HR after review.',
    `attachment_flag` BOOLEAN COMMENT 'True if supporting documentation (e.g., medical certificate) is attached to the request.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the leave request record was first created in the system.',
    `end_date` DATE COMMENT 'Last calendar day of the requested leave period.',
    `entitlement_balance_at_approval` STRING COMMENT 'Accrued leave balance remaining after the request has been approved.',
    `entitlement_balance_at_request` STRING COMMENT 'Accrued leave balance available to the employee when the request was submitted.',
    `extended_until_date` DATE COMMENT 'New end date when a leave request is extended.',
    `is_accrual` BOOLEAN COMMENT 'True if the leave consumes accrued entitlement; false if it is granted without accrual (e.g., discretionary).',
    `is_confidential` BOOLEAN COMMENT 'True if the leave request is marked confidential (e.g., medical or legal leave).',
    `is_eligible` BOOLEAN COMMENT 'True if the employee meets eligibility criteria for the requested leave type at the time of request.',
    `is_extended` BOOLEAN COMMENT 'True if the leave period was extended beyond the originally requested dates.',
    `is_paid_leave` BOOLEAN COMMENT 'True if the leave is paid according to company policy; false for unpaid leave.',
    `is_partial_day` BOOLEAN COMMENT 'True if the request includes a partial (half‑day) leave.',
    `jurisdiction_code` STRING COMMENT 'Three‑letter ISO country or region code indicating the legal jurisdiction governing the leave entitlement.',
    `leave_request_status` STRING COMMENT 'Current lifecycle status of the leave request.. Valid values are `pending|approved|rejected|cancelled|in_progress`',
    `leave_type` STRING COMMENT 'Category of leave requested (e.g., annual, sick, parental, FMLA, sabbatical, bereavement, jury duty, unpaid). [ENUM-REF-CANDIDATE: annual|sick|parental|fmla|sabbatical|bereavement|jury_duty|unpaid — promote to reference product]',
    `notes` STRING COMMENT 'Additional free‑form comments entered by the employee or approver.',
    `partial_day_type` STRING COMMENT 'Specifies whether the partial day is taken in the morning or afternoon.. Valid values are `morning|afternoon`',
    `rejection_reason` STRING COMMENT 'Free‑text explanation provided when a leave request is rejected.',
    `remaining_balance_days` STRING COMMENT 'Employees leave balance remaining after this request is accounted for.',
    `request_number` STRING COMMENT 'Human‑readable business identifier for the leave request, often used in HR workflows and reporting.',
    `request_source` STRING COMMENT 'Origin of the leave request submission.. Valid values are `portal|mobile|hr_system`',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the employee submitted the leave request.',
    `start_date` DATE COMMENT 'First calendar day of the requested leave period.',
    `total_requested_days` STRING COMMENT 'Number of calendar days (including partial days) the employee initially requested.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the leave request record.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Employee leave request and entitlement record capturing all absence management events. Stores leave type (annual leave, sick leave, parental leave, FMLA, sabbatical, bereavement, jury duty, unpaid leave), requested start date, end date, total days requested, approved days, leave status (pending, approved, rejected, cancelled, in-progress), approver reference, and jurisdiction-specific leave entitlement balance. Supports statutory leave compliance across all operating jurisdictions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` (
    `leave_balance_id` BIGINT COMMENT 'Unique surrogate key for each leave balance record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom the leave balance applies.',
    `carryover_leave_balance_id` BIGINT COMMENT 'Self-referencing FK on leave_balance (carryover_leave_balance_id)',
    `accrual_method` STRING COMMENT 'Method used to calculate leave accruals.. Valid values are `monthly|annual|hourly|custom`',
    `accrual_rate_per_month` DECIMAL(18,2) COMMENT 'Standard accrual rate of leave days per month.',
    `accrued_days` DECIMAL(18,2) COMMENT 'Total leave days accrued during the policy year.',
    `adjusted_days` DECIMAL(18,2) COMMENT 'Manual adjustments to leave balance (additions or deductions).',
    `audit_trail_reference` BIGINT COMMENT 'Reference to audit trail record for changes to this leave balance.',
    `balance_unit` STRING COMMENT 'Unit of measurement for leave balances.. Valid values are `days|hours`',
    `carried_forward_days` DECIMAL(18,2) COMMENT 'Leave days carried forward from previous policy year.',
    `carryover_limit` DECIMAL(18,2) COMMENT 'Maximum number of days that can be carried over per policy.',
    `closing_balance` DECIMAL(18,2) COMMENT 'Leave balance remaining at end of policy year.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the leave balance record was created.',
    `effective_from` DATE COMMENT 'Date when this leave balance period becomes effective.',
    `effective_until` DATE COMMENT 'Date when this leave balance period ends (nullable if open-ended).',
    `forfeited_days` DECIMAL(18,2) COMMENT 'Leave days forfeited at end of policy year per policy.',
    `is_eligible_for_carryover` BOOLEAN COMMENT 'Indicates if the employee is eligible to carry over unused leave to next year.',
    `is_paid_leave` BOOLEAN COMMENT 'Indicates whether the leave type is paid.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the leave payout is taxable.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the jurisdiction governing leave policy.. Valid values are `^[A-Z]{3}$`',
    `last_accrual_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent accrual event for this balance.',
    `last_taken_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent leave taken event.',
    `leave_balance_status` STRING COMMENT 'Current lifecycle status of the leave balance record.. Valid values are `active|inactive|suspended|closed`',
    `leave_type` STRING COMMENT 'Category of leave entitlement.. Valid values are `vacation|sick|personal|parental|bereavement|unpaid`',
    `notes` STRING COMMENT 'Free-text notes regarding adjustments or special conditions.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Leave balance at the start of the policy year.',
    `policy_year` STRING COMMENT 'Fiscal year for which the leave policy is applicable.',
    `source_system` STRING COMMENT 'Originating system that supplied the leave balance data.',
    `statutory_minimum` DECIMAL(18,2) COMMENT 'Minimum leave days required by law for the employees jurisdiction.',
    `taken_days` DECIMAL(18,2) COMMENT 'Leave days taken (used) during the policy year.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the leave balance record.',
    CONSTRAINT pk_leave_balance PRIMARY KEY(`leave_balance_id`)
) COMMENT 'Employee leave balance master tracking accrued, used, and remaining leave entitlements by leave type and policy year. Captures leave type, policy year, opening balance (days), accrued days, taken days, adjusted days, carried-forward days, forfeited days, and closing balance. Supports leave liability reporting for financial provisioning and ensures compliance with statutory minimum leave entitlements across 200+ jurisdictions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Primary key for performance review record. _canonical_skip_reason: Entity does not fit predefined role categories, treated as OTHER.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee being reviewed.',
    `reviewer_employee_id` BIGINT COMMENT 'Unique identifier of the employee who performed the review.',
    `prior_performance_review_id` BIGINT COMMENT 'Self-referencing FK on performance_review (prior_performance_review_id)',
    `calibration_group` STRING COMMENT 'Identifier of the calibration group to which this review belongs.',
    `calibration_score` DECIMAL(18,2) COMMENT 'Aggregated score from the calibration process.',
    `calibration_status` STRING COMMENT 'Status of the calibration process for this review.. Valid values are `pending|in_progress|completed`',
    `comments` STRING COMMENT 'Additional comments provided by the reviewer.',
    `compensation_action_flag` BOOLEAN COMMENT 'Indicates whether the review resulted in a compensation change (e.g., raise, bonus).',
    `compensation_change_amount` DECIMAL(18,2) COMMENT 'Monetary amount of compensation change resulting from the review.',
    `compensation_change_type` STRING COMMENT 'Type of compensation adjustment (raise, bonus, or none).. Valid values are `raise|bonus|none`',
    `confidentiality_level` STRING COMMENT 'Data classification level for the review record.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was created.',
    `development_areas` STRING COMMENT 'Areas for development or improvement identified for the employee.',
    `employee_department` STRING COMMENT 'Department to which the employee belongs during the review period.',
    `employee_location` STRING COMMENT 'Geographic location or office of the employee during the review.',
    `employee_position` STRING COMMENT 'Job title or position of the employee at the time of review.',
    `goals_achieved` STRING COMMENT 'Summary of goals the employee achieved during the review period.',
    `goals_set` STRING COMMENT 'Performance goals established for the employee at the start of the review period.',
    `is_finalized` BOOLEAN COMMENT 'Indicates whether the review has been finalized and locked.',
    `overall_rating` DECIMAL(18,2) COMMENT 'Numeric overall rating assigned to the employee for the review period.',
    `performance_improvement_plan_flag` BOOLEAN COMMENT 'Indicates whether a performance improvement plan was initiated as a result of the review.',
    `performance_review_status` STRING COMMENT 'Current lifecycle status of the performance review.',
    `promotion_effective_date` DATE COMMENT 'Date when the promotion, if any, becomes effective.',
    `promotion_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for promotion based on this review.',
    `rating_explanation` STRING COMMENT 'Narrative explanation supporting the overall rating.',
    `rating_scale` STRING COMMENT 'Scale used for the overall performance rating (e.g., 1-5, 1-10, custom).. Valid values are `1-5|1-10|custom`',
    `review_completion_date` DATE COMMENT 'Date when the performance review was finalized.',
    `review_cycle` STRING COMMENT 'The appraisal cycle type (e.g., annual, mid-year, probation, performance improvement plan).. Valid values are `annual|mid_year|probation|pip`',
    `review_document_url` STRING COMMENT 'Link to the stored performance review document.',
    `review_period_end_date` DATE COMMENT 'Last day of the performance review period.',
    `review_period_start_date` DATE COMMENT 'First day of the performance review period.',
    `review_version` STRING COMMENT 'Version number of the review record to support revisions.',
    `strengths` STRING COMMENT 'Key strengths identified for the employee during the review.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the performance review record.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Employee performance review record capturing formal appraisal cycles. Stores review cycle (annual, mid-year, probation, pip), review period start and end dates, overall performance rating, rating scale used, reviewer employee reference, calibration status, review completion date, and whether the review triggered a compensation action or performance improvement plan. Supports talent management, promotion decisions, and regulatory documentation for employment actions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`goal` (
    `goal_id` BIGINT COMMENT 'System-generated unique identifier for the performance goal.',
    `objective_id` BIGINT COMMENT 'Reference to the company‑wide strategic objective that the goal supports.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the team to which the goal is assigned, if applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who owns or is responsible for the goal.',
    `team_id` BIGINT COMMENT 'Identifier of the team to which the goal is assigned, if applicable.',
    `parent_goal_id` BIGINT COMMENT 'Self-referencing FK on goal (parent_goal_id)',
    `actual_value` DECIMAL(18,2) COMMENT 'Quantitative value captured during or after the review period representing realized performance.',
    `comments` STRING COMMENT 'Free‑form notes entered by the owner or manager regarding the goal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goal record was first created in the system.',
    `end_date` DATE COMMENT 'Planned completion or expiration date for the goal.',
    `goal_category` STRING COMMENT 'Classification of the goal indicating whether it is an individual, team, or company‑wide OKR.. Valid values are `individual|team|company_okr`',
    `goal_description` STRING COMMENT 'Detailed narrative explaining the purpose, scope, and expected outcome of the goal.',
    `goal_status` STRING COMMENT 'Current lifecycle state of the goal.. Valid values are `draft|active|completed|cancelled`',
    `is_calibrated` BOOLEAN COMMENT 'Indicates whether the goals weight and target have been calibrated across the organization.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the goal is required for the employees role or compensation eligibility.',
    `last_calibrated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent calibration activity for the goal.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the target and actual values (e.g., count, percentage, USD, hours, points).. Valid values are `count|percentage|currency|hours|points`',
    `priority_level` STRING COMMENT 'Business priority assigned to the goal.. Valid values are `low|medium|high|critical`',
    `start_date` DATE COMMENT 'Date when the goal becomes effective for the employee or team.',
    `target_metric` STRING COMMENT 'Name of the key performance indicator or metric that the goal is measured against.',
    `target_value` DECIMAL(18,2) COMMENT 'Quantitative value that defines the goals intended achievement level.',
    `title` STRING COMMENT 'Human‑readable title of the goal as defined by the employee or manager.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the goal record.',
    `visibility` STRING COMMENT 'Scope of audience that can view the goal within the organization.. Valid values are `internal|public|restricted`',
    `weight_percentage` DECIMAL(18,2) COMMENT 'Portion of the overall performance rating that this goal contributes, expressed as a percentage.',
    CONSTRAINT pk_goal PRIMARY KEY(`goal_id`)
) COMMENT 'Individual and team goal record linked to a performance review cycle. Captures goal title, goal description, goal category (individual, team, company OKR), target metric, measurement unit, target value, actual value, goal weight (percentage of overall rating), goal status (draft, active, completed, cancelled), and alignment to company strategic objective. Supports OKR frameworks and performance calibration in the payments fintech enterprise.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`headcount` (
    `headcount_id` BIGINT COMMENT 'Unique surrogate identifier for each headcount snapshot record. _canonical_skip_reason: Snapshot entity representing headcount per org unit and date, not a persistent master or transaction.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity (company) under which the workforce is employed.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit (e.g., department, division) to which the headcount applies.',
    `prior_period_headcount_id` BIGINT COMMENT 'Self-referencing FK on headcount (prior_period_headcount_id)',
    `attrition_count` STRING COMMENT 'Number of employees who left the organization (voluntary or involuntary) during the reporting period.',
    `authorized_fte` DECIMAL(18,2) COMMENT 'Number of FTE positions authorized for the org unit for the reporting period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the headcount snapshot record was first created in the data lake.',
    `filled_fte` DECIMAL(18,2) COMMENT 'Number of FTEs actually filled (employees working) in the org unit for the reporting period.',
    `headcount_status` STRING COMMENT 'Current lifecycle status of the snapshot record (active = current, inactive = archived).. Valid values are `active|inactive`',
    `headcount_type` STRING COMMENT 'Classification of headcount: permanent employees, contractors, interns, or temporary staff.. Valid values are `permanent|contractor|intern|temporary`',
    `new_hire_count` STRING COMMENT 'Number of new employees hired into the org unit during the reporting period.',
    `period_end_date` DATE COMMENT 'End date of the reporting period for which headcount changes are measured.',
    `period_start_date` DATE COMMENT 'Start date of the reporting period for which headcount changes are measured.',
    `reporting_date` DATE COMMENT 'The calendar date for which the headcount snapshot is reported.',
    `source_system` STRING COMMENT 'Name of the source system that supplied the headcount data (e.g., Workday, SAP SuccessFactors).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the headcount snapshot record.',
    `vacant_fte` DECIMAL(18,2) COMMENT 'Number of authorized FTE positions that remain unfilled (vacant) for the reporting period.',
    CONSTRAINT pk_headcount PRIMARY KEY(`headcount_id`)
) COMMENT 'Point-in-time headcount snapshot record capturing the authorized and actual headcount position for each org unit at a given reporting date. Stores reporting date, org unit, legal entity, headcount type (permanent, contractor, intern), authorized FTE count, filled FTE count, vacant FTE count, attrition count for the period, and new hire count for the period. Supports workforce planning, budget variance analysis, and regulatory headcount disclosures.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` (
    `role_assignment_id` BIGINT COMMENT 'System-generated unique identifier for each role assignment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employees direct manager for this assignment.',
    `job_profile_id` BIGINT COMMENT 'Identifier of the job profile that defines responsibilities, competencies, and qualifications for the assignment.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit (department, division, etc.) where the assignment resides.',
    `position_id` BIGINT COMMENT 'Unique identifier of the position or job title to which the employee is assigned.',
    `primary_role_employee_id` BIGINT COMMENT 'Unique identifier of the employee who is assigned to a role.',
    `superseded_role_assignment_id` BIGINT COMMENT 'Self-referencing FK on role_assignment (superseded_role_assignment_id)',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment.. Valid values are `active|inactive|pending|terminated|suspended`',
    `assignment_type` STRING COMMENT 'Classification of the assignment indicating its nature (e.g., primary, acting, secondment).. Valid values are `primary|acting|secondment|interim|temporary|contract`',
    `business_unit_code` STRING COMMENT 'Code representing the broader business unit overseeing the assignment.',
    `compensation_flag` BOOLEAN COMMENT 'Indicates whether the assignment includes compensation elements (e.g., bonus eligibility).',
    `compliance_training_completed` BOOLEAN COMMENT 'True if the employee has completed mandatory compliance training for the assignment.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the assignments expenses are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the role assignment record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the assignment ends or is scheduled to end (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the assignment becomes effective.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'Proportion of a full‑time workload represented by the assignment (e.g., 100.00 for full‑time).',
    `is_acting` BOOLEAN COMMENT 'True if the employee is temporarily acting in the role.',
    `is_primary` BOOLEAN COMMENT 'True if this assignment is the employees primary role; otherwise false.',
    `last_review_date` DATE COMMENT 'Date of the most recent performance or role review.',
    `next_review_date` DATE COMMENT 'Planned date for the upcoming performance or role review.',
    `notes` STRING COMMENT 'Free‑form text for additional context or remarks about the assignment.',
    `salary_grade` STRING COMMENT 'Internal salary band or grade associated with the assignment.',
    `segregation_of_duties_flag` BOOLEAN COMMENT 'Indicates whether the assignment satisfies SOX segregation‑of‑duties controls.',
    `termination_reason` STRING COMMENT 'Reason provided for ending the assignment, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the role assignment record.',
    `work_location_address` STRING COMMENT 'Street address of the work location; used for compliance and travel expense calculations.',
    `work_location_code` STRING COMMENT 'Internal code representing the physical or virtual location where the employee performs the assignment.',
    CONSTRAINT pk_role_assignment PRIMARY KEY(`role_assignment_id`)
) COMMENT 'Employee role and position assignment record capturing the active and historical mapping of employees to positions, org units, and job profiles. Stores assignment type (primary, acting, secondment, interim), effective start date, effective end date, position reference, org unit reference, job profile reference, FTE percentage, work location, and assignment status. Enables point-in-time org chart reconstruction and supports SOX segregation-of-duties controls for payments fintech.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`employment_event` (
    `employment_event_id` BIGINT COMMENT 'System‑generated unique identifier for each immutable employment lifecycle event.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager who initiated or approved the employment event.',
    `hr_business_partner_employee_id` BIGINT COMMENT 'Identifier of the HR business partner responsible for the event.',
    `primary_employment_employee_id` BIGINT COMMENT 'Unique identifier of the employee whose employment record is affected.',
    `tertiary_employment_hr_business_partner_employee_id` BIGINT COMMENT 'Identifier of the HR business partner responsible for the event.',
    `corrected_employment_event_id` BIGINT COMMENT 'Self-referencing FK on employment_event (corrected_employment_event_id)',
    `approval_chain` STRING COMMENT 'Ordered, delimiter‑separated list of approver identifiers that reviewed the event.',
    `comments` STRING COMMENT 'Free‑form notes or remarks associated with the event.',
    `confidentiality_level` STRING COMMENT 'Data classification for the event record as defined by corporate policy.. Valid values are `restricted|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employment event record was first created in the lakehouse.',
    `effective_date` DATE COMMENT 'Date on which the employment event becomes legally effective for the employee.',
    `event_status` STRING COMMENT 'Current processing status of the employment event.. Valid values are `pending|approved|rejected|completed`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the employment event was recorded in the source system.',
    `event_type` STRING COMMENT 'Category of the employment lifecycle change (e.g., hire, promotion, termination, etc.). [ENUM-REF-CANDIDATE: hire|rehire|promotion|demotion|transfer|compensation_change|leave_of_absence|return_from_leave|termination|retirement|contract_renewal — promote to reference product]',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the event is considered critical for regulatory or compliance reporting.',
    `new_state_snapshot` STRING COMMENT 'JSON‑encoded snapshot of the employees relevant attributes after the event.',
    `previous_state_snapshot` STRING COMMENT 'JSON‑encoded snapshot of the employees relevant attributes before the event.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for the employment event.',
    `source_system` STRING COMMENT 'Name of the upstream system that originated the employment event (e.g., HRIS, payroll).',
    `updated_by` STRING COMMENT 'System user or service that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the employment event record.',
    `created_by` STRING COMMENT 'System user or service that created the employment event record.',
    CONSTRAINT pk_employment_event PRIMARY KEY(`employment_event_id`)
) COMMENT 'Immutable audit log of all significant employment lifecycle events for an employee. Captures event type (hire, rehire, promotion, demotion, lateral transfer, compensation change, leave of absence, return from leave, termination, retirement, contract renewal), event effective date, previous state snapshot, new state snapshot, initiating manager reference, HR business partner reference, and approval chain. Provides the authoritative employment history for compliance, litigation support, and regulatory reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` (
    `workforce_certification_id` BIGINT COMMENT 'System-generated unique identifier for each certification record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who holds the certification.',
    `renewed_workforce_certification_id` BIGINT COMMENT 'Self-referencing FK on workforce_certification (renewed_workforce_certification_id)',
    `certification_number` STRING COMMENT 'Unique number assigned by the issuing body to the certification; used for verification and audit.',
    `certification_type` STRING COMMENT 'Type of professional certification or regulatory license (e.g., PCI DSS Awareness, AML Compliance, Series 65, CISA, PMP, Data Privacy DPO).',
    `compliance_requirement` STRING COMMENT 'Regulatory or internal policy that mandates this certification (e.g., PCI DSS, AML, BSA).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `document_url` STRING COMMENT 'Link to the digital copy of the certification document stored in the document repository.',
    `expiry_date` DATE COMMENT 'Date the certification expires and must be renewed to remain valid.',
    `issue_date` DATE COMMENT 'Date the certification was originally issued to the employee.',
    `issuing_body` STRING COMMENT 'Organization that issued the certification, such as PCI Security Standards Council, FinCEN, or a recognized professional institute.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification was last validated against the issuing body.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the certification is mandatory for the employees role under regulatory requirements.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the certification (e.g., special conditions, audit findings).',
    `renewal_status` STRING COMMENT 'Current renewal state of the certification.. Valid values are `pending|renewed|expired|not_required`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    `workforce_certification_status` STRING COMMENT 'Lifecycle status of the certification record.. Valid values are `active|inactive|revoked|suspended|pending`',
    CONSTRAINT pk_workforce_certification PRIMARY KEY(`workforce_certification_id`)
) COMMENT 'Employee professional certification and regulatory license record. Captures certification type (PCI DSS awareness, AML compliance, Series 65, MSB license, CAMS, CISA, PMP, data privacy DPO), issuing body, certification number, issue date, expiry date, renewal status, and whether the certification is mandatory for the employees role under regulatory requirements. Critical for payments fintech regulatory compliance — tracks mandatory AML, BSA, and PCI training certifications.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` (
    `training_enrollment_id` BIGINT COMMENT 'Unique surrogate key for each training enrollment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the trainer or instructor.',
    `primary_training_employee_id` BIGINT COMMENT 'Identifier of the employee enrolled in the training.',
    `retake_training_enrollment_id` BIGINT COMMENT 'Self-referencing FK on training_enrollment (retake_training_enrollment_id)',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score achieved in the training assessment (0-100).',
    `completion_date` DATE COMMENT 'Date when the employee completed the training (if applicable).',
    `cpe_credits` DECIMAL(18,2) COMMENT 'Continuing Professional Education credits earned.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was created.',
    `delivery_method` STRING COMMENT 'Method used to deliver the training.. Valid values are `e_learning|instructor_led|virtual|on_the_job`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training in hours.',
    `enrollment_date` DATE COMMENT 'Date when the employee enrolled in the training.',
    `enrollment_number` STRING COMMENT 'Unique enrollment reference number assigned by the HR system.',
    `expiration_date` DATE COMMENT 'Date when the training certification expires, if applicable.',
    `location` STRING COMMENT 'Physical location where the training was delivered (if applicable).',
    `notes` STRING COMMENT 'Additional free-text notes regarding the enrollment.',
    `pass_fail_status` STRING COMMENT 'Result of the training assessment.. Valid values are `pass|fail|not_applicable`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates if the training satisfies a regulatory compliance requirement.',
    `regulatory_requirement_name` STRING COMMENT 'Name of the regulatory requirement satisfied (e.g., AML Awareness).',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the training needs periodic renewal.',
    `training_category` STRING COMMENT 'Category of the training program.. Valid values are `mandatory|compliance|technical|leadership|onboarding`',
    `training_enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment.. Valid values are `enrolled|in_progress|completed|withdrawn|failed`',
    `training_program_code` STRING COMMENT 'Code identifying the training program.',
    `training_program_name` STRING COMMENT 'Descriptive name of the training program.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    `virtual_meeting_link` STRING COMMENT 'URL for virtual training session (if applicable).',
    CONSTRAINT pk_training_enrollment PRIMARY KEY(`training_enrollment_id`)
) COMMENT 'Employee training enrollment and completion record for mandatory and elective learning programs. Captures training program name, training type (mandatory regulatory, compliance, technical, leadership, onboarding), delivery method (e-learning, instructor-led, virtual, on-the-job), enrollment date, completion date, pass/fail status, assessment score, CPE credits earned, and whether the training satisfies a regulatory compliance requirement (AML awareness, PCI DSS, GDPR, BSA). Distinct from compliance.training_completion which tracks enterprise-wide compliance training — this record is the HR system of record for all workforce learning.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` (
    `disciplinary_action_id` BIGINT COMMENT 'System-generated unique identifier for the disciplinary action record.',
    `employee_id` BIGINT COMMENT 'Identifier of the HR business partner responsible for the case.',
    `legal_counsel_employee_id` BIGINT COMMENT 'Identifier of the legal counsel consulted for the disciplinary action.',
    `primary_disciplinary_employee_id` BIGINT COMMENT 'Unique identifier of the employee subject to the disciplinary action.',
    `tertiary_disciplinary_legal_counsel_employee_id` BIGINT COMMENT 'Identifier of the legal counsel consulted for the disciplinary action.',
    `escalated_from_disciplinary_action_id` BIGINT COMMENT 'Self-referencing FK on disciplinary_action (escalated_from_disciplinary_action_id)',
    `action_date` DATE COMMENT 'Date on which the disciplinary action was formally recorded.',
    `action_status` STRING COMMENT 'Current lifecycle status of the disciplinary action record.. Valid values are `pending|in_review|approved|appealed|closed|reversed`',
    `action_type` STRING COMMENT 'Category of disciplinary action taken (e.g., verbal warning, suspension, termination).. Valid values are `verbal_warning|written_warning|final_written_warning|suspension|demotion|termination`',
    `appeal_outcome` STRING COMMENT 'Result of the appeal process, if applicable.. Valid values are `none|upheld|reversed|modified`',
    `appeal_status` STRING COMMENT 'Current status of any appeal filed against the disciplinary action.. Valid values are `not_applicable|filed|under_review|rejected|upheld`',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the disciplinary action against internal policies and external regulations.. Valid values are `compliant|non_compliant|pending_review`',
    `confidentiality_level` STRING COMMENT 'Data classification for the disciplinary record as defined by corporate policy.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disciplinary action record was first created in the system.',
    `disciplinary_action_code` STRING COMMENT 'External reference code used in regulatory filings and audit reports.. Valid values are `^DA-[0-9]{6}$`',
    `duration_days` STRING COMMENT 'Number of calendar days the action lasts; applicable to suspensions or temporary demotions.',
    `effective_date` DATE COMMENT 'Date when the disciplinary action becomes effective for the employee.',
    `end_date` DATE COMMENT 'Date when a time‑bound action (e.g., suspension) ends; null for indefinite actions.',
    `incident_description` STRING COMMENT 'Narrative description of the incident that triggered the disciplinary action.',
    `investigation_reference` STRING COMMENT 'Identifier of the internal investigation case linked to this disciplinary action.',
    `is_appealable` BOOLEAN COMMENT 'Indicates whether the employee is entitled to appeal the disciplinary action.',
    `is_suspended` BOOLEAN COMMENT 'True if the disciplinary action includes a suspension component.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code indicating the legal jurisdiction governing the action.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free‑form notes added by HR or management regarding the action.',
    `regulatory_filing_required` BOOLEAN COMMENT 'True if the disciplinary action must be reported to a regulator (e.g., for senior‑level employees).',
    `severity_level` STRING COMMENT 'Risk severity assigned to the disciplinary action based on impact and recurrence.. Valid values are `low|medium|high|critical`',
    `supporting_document_url` STRING COMMENT 'Link to any external document (e.g., written warning letter) stored in the document repository.',
    `termination_effective_date` DATE COMMENT 'Date when the termination takes effect, if applicable.',
    `termination_reason` STRING COMMENT 'Reason provided for termination when action_type is termination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the disciplinary action record.',
    CONSTRAINT pk_disciplinary_action PRIMARY KEY(`disciplinary_action_id`)
) COMMENT 'Employee disciplinary action record capturing formal HR disciplinary proceedings. Stores action type (verbal warning, written warning, final written warning, suspension, demotion, termination for cause), incident description, investigation reference, action date, effective date, duration (for suspensions), appeal status, appeal outcome, and the HR business partner and legal counsel involved. Supports employment law compliance, litigation defense, and regulatory fitness-and-propriety assessments for licensed roles.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`background_check` (
    `background_check_id` BIGINT COMMENT 'Unique identifier for the background check record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the screening service provider.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor subject to the background check.',
    `recheck_background_check_id` BIGINT COMMENT 'Self-referencing FK on background_check (recheck_background_check_id)',
    `adjudication_outcome` STRING COMMENT 'Final adjudication outcome after review of the background check.. Valid values are `clear|flagged|failed|pending|escalated`',
    `background_check_status` STRING COMMENT 'Current lifecycle status of the background check.. Valid values are `pending|in_progress|completed|closed|rejected`',
    `check_name` STRING COMMENT 'Human readable label for the background check instance.',
    `check_number` STRING COMMENT 'Unique business identifier for the background check.',
    `check_type` STRING COMMENT 'Category of the background check performed.. Valid values are `criminal|credit|employment|education|sanctions|reference`',
    `completion_date` DATE COMMENT 'Date when the background check was completed.',
    `component_results` STRING COMMENT 'Detailed results of individual check components, stored as JSON or delimited string.',
    `confidentiality_level` STRING COMMENT 'Data confidentiality classification for the background check record.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the background check record was created.',
    `expiration_date` DATE COMMENT 'Date when the background check result expires and must be refreshed.',
    `flagged_issues` STRING COMMENT 'Textual description of any issues flagged during the background check.',
    `initiation_date` DATE COMMENT 'Date when the background check was initiated.',
    `is_periodic` BOOLEAN COMMENT 'Indicates whether the background check is recurring (periodic).',
    `next_scheduled_date` DATE COMMENT 'Scheduled date for the next periodic background check.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the background check.',
    `overall_result` STRING COMMENT 'Overall outcome of the background check.. Valid values are `clear|flagged|failed|pending`',
    `provider_code` STRING COMMENT 'Identifier of the screening service provider.',
    `provider_name` STRING COMMENT 'Name of the screening service provider.',
    `result_date` DATE COMMENT 'Date when the result of the background check was determined.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned based on the check results.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the background check record.',
    CONSTRAINT pk_background_check PRIMARY KEY(`background_check_id`)
) COMMENT 'Pre-employment and periodic background screening record for employees and contractors. Captures check type (criminal record, credit history, employment verification, education verification, sanctions/watchlist screening, reference check), screening provider, initiation date, completion date, overall result (clear, flagged, failed, pending), individual check component results, and adjudication outcome. Mandatory for payments fintech roles with access to financial systems, cardholder data, or regulated activities.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` (
    `work_schedule_id` BIGINT COMMENT 'Unique identifier for the work schedule record.',
    `superseded_work_schedule_id` BIGINT COMMENT 'Self-referencing FK on work_schedule (superseded_work_schedule_id)',
    `break_duration_minutes` STRING COMMENT 'Standard unpaid break duration per shift.',
    `compliance_overtime_threshold_hours` DECIMAL(18,2) COMMENT 'Weekly hour threshold after which overtime rules apply, per jurisdiction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for labor cost calculations.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the schedule ceases to be effective; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the schedule becomes effective.',
    `flexible_flag` BOOLEAN COMMENT 'True if the schedule allows flexible start/end times.',
    `jurisdiction_code` STRING COMMENT 'Three‑letter country code indicating the legal jurisdiction governing labor rules for the schedule.',
    `labor_cost_rate_per_hour` DECIMAL(18,2) COMMENT 'Default labor cost rate applied for budgeting and cost allocation.',
    `notes` STRING COMMENT 'Additional notes or comments entered by HR administrators.',
    `on_call_flag` BOOLEAN COMMENT 'True if the schedule includes on‑call duties.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether employees on this schedule are eligible for overtime pay.',
    `rest_period_minutes` STRING COMMENT 'Minimum mandatory rest period between shifts, expressed in minutes.',
    `schedule_code` STRING COMMENT 'Business code used to reference the schedule in HR and payroll systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name of the schedule (e.g., Standard 9‑5, Night Shift A).',
    `schedule_type` STRING COMMENT 'Classification of the schedule pattern.. Valid values are `standard|shift|compressed|flexible|on_call|rotating`',
    `schedule_version` STRING COMMENT 'Version number for change management of the schedule definition.',
    `shift_pattern` STRING COMMENT 'Textual description of the shift rotation (e.g., Mon‑Wed‑Fri 08:00‑16:00).',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the schedule (e.g., America/New_York).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    `weekly_hours` DECIMAL(18,2) COMMENT 'Total number of hours an employee is expected to work per week under this schedule.',
    `work_location_type` STRING COMMENT 'Category of work location associated with the schedule.. Valid values are `office|remote|hybrid|field`',
    `work_schedule_description` STRING COMMENT 'Free‑form description providing additional context about the schedule.',
    `work_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.. Valid values are `active|inactive|pending|retired`',
    CONSTRAINT pk_work_schedule PRIMARY KEY(`work_schedule_id`)
) COMMENT 'Employee work schedule master defining the standard working pattern assigned to an employee or position. Captures schedule type (standard 9-5, shift rotation, compressed week, flexible, on-call), total weekly hours, shift pattern details, time zone, work location type (office, remote, hybrid), effective date range, and applicable jurisdiction for labor law compliance (overtime thresholds, rest period requirements). Supports time and attendance management and labor cost allocation.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique surrogate key for each time entry record.',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor who approved the time entry.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor who approved the time entry.',
    `payroll_period_id` BIGINT COMMENT 'Identifier of the payroll cycle used for compensation processing.',
    `primary_time_employee_id` BIGINT COMMENT 'Unique identifier of the employee who logged the time.',
    `timesheet_id` BIGINT COMMENT 'Identifier of the parent timesheet containing this entry.',
    `adjusted_time_entry_id` BIGINT COMMENT 'Self-referencing FK on time_entry (adjusted_time_entry_id)',
    `approval_status` STRING COMMENT 'Workflow status indicating whether the entry has been reviewed and approved.. Valid values are `pending|approved|rejected|escalated`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the entry received its final approval.',
    `billable_rate_amount` DECIMAL(18,2) COMMENT 'Monetary amount per hour charged for billable time.',
    `billable_rate_currency` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the billable rate.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `break_duration_minutes` STRING COMMENT 'Total minutes of break time deducted from payable hours.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Exact moment the employee started work for this entry.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Exact moment the employee finished work for this entry.',
    `cost_center_code` STRING COMMENT 'Code representing the organizational cost center for financial allocation.',
    `created_by_user` STRING COMMENT 'Username of the employee or system that created the record.',
    `entry_date` DATE COMMENT 'Calendar date on which the work was performed.',
    `is_billable` BOOLEAN COMMENT 'True if the hours are chargeable to a client or project; otherwise false.',
    `jurisdiction_code` STRING COMMENT 'Three‑letter country code indicating the legal jurisdiction for labor compliance.',
    `labor_category` STRING COMMENT 'Broad classification of the work performed (e.g., engineering, support, sales).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the record.',
    `line_sequence` STRING COMMENT 'Ordinal position of the entry within the timesheet.',
    `notes` STRING COMMENT 'Optional textual remarks provided by the employee for this entry.',
    `overtime_eligible` BOOLEAN COMMENT 'True if the employee may accrue overtime hours according to applicable regulations.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Portion of total hours that are compensated at an overtime rate.',
    `project_code` STRING COMMENT 'Identifier of the project or cost center charged for this time entry.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Portion of total hours that are compensated at the standard rate.',
    `shift_code` STRING COMMENT 'Code representing the work shift (e.g., day, night, swing).. Valid values are `day|night|swing`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time the employee submitted the time entry.',
    `time_entry_type` STRING COMMENT 'Category describing the nature of the work logged.. Valid values are `regular|overtime|holiday|on_call|travel`',
    `total_billable_amount` DECIMAL(18,2) COMMENT 'Calculated as billable_rate_amount multiplied by billable hours.',
    `total_hours_worked` DECIMAL(18,2) COMMENT 'Sum of all worked hours for the entry, expressed in decimal hours.',
    `updated_by_user` STRING COMMENT 'Username of the person or process that last modified the record.',
    `work_location_code` STRING COMMENT 'Identifier of the location or remote setting for the time entry.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Employee time and attendance entry record capturing actual hours worked per day or pay period. Stores entry date, clock-in time, clock-out time, total regular hours, overtime hours, break duration, project or cost center allocation, time entry type (regular, overtime, holiday, on-call, travel), approval status, and approver reference. Supports payroll calculation, labor cost allocation to payment processing projects, and compliance with jurisdiction-specific overtime regulations.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` (
    `workforce_location_id` BIGINT COMMENT 'Unique system-generated identifier for each workforce location record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Facility cost reporting requires each location to be assigned a cost center; cost_center_id provides that mapping.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Location compliance and jurisdictional risk assessments require linking to reference country data.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity that owns or operates the location.',
    `parent_location_workforce_location_id` BIGINT COMMENT 'Identifier of the parent location in the organizational hierarchy (null if top‑level).',
    `timezone_id` BIGINT COMMENT 'Foreign key linking to reference.timezone. Business justification: Shift scheduling and labor law compliance depend on accurate timezone reference from master timezone table.',
    `parent_workforce_location_id` BIGINT COMMENT 'Self-referencing FK on workforce_location (parent_workforce_location_id)',
    `address_line1` STRING COMMENT 'Primary street address of the location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `audit_status` STRING COMMENT 'Current status of the most recent audit.. Valid values are `pending|completed|failed`',
    `capacity_people` STRING COMMENT 'Maximum number of personnel that can be accommodated at the location.',
    `city` STRING COMMENT 'City where the location is situated.',
    `compliance_status` STRING COMMENT 'Overall compliance posture of the location with applicable regulations.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the system.',
    `data_retention_policy` STRING COMMENT 'Policy identifier governing how long records associated with this location are retained.',
    `effective_from` DATE COMMENT 'Date when the location became active for workforce assignments.',
    `effective_until` DATE COMMENT 'Date when the location is scheduled to be de‑commissioned or become inactive (null if open‑ended).',
    `email_address` STRING COMMENT 'Primary email address for the location.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `floor_area_sqft` DECIMAL(18,2) COMMENT 'Total usable floor area of the location in square feet.',
    `is_remote_work_allowed` BOOLEAN COMMENT 'Indicates whether employees may be assigned to work remotely from this location.',
    `is_virtual_location` BOOLEAN COMMENT 'True if the location represents a virtual/remote/home office rather than a physical site.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or internal audit performed on the location.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the location in decimal degrees.',
    `location_code` STRING COMMENT 'Business‑assigned unique code used to reference the location in internal systems.',
    `location_type` STRING COMMENT 'Category describing the nature of the location.. Valid values are `headquarters|regional_office|branch|data_center|remote_home`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the location in decimal degrees.',
    `payroll_tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether payroll taxes are exempt for employees assigned to this location.',
    `phone_number` STRING COMMENT 'Primary telephone number for the location.. Valid values are `^[+]?d{1,15}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the location.. Valid values are `^[A-Z0-9 -]{3,10}$`',
    `region_code` STRING COMMENT 'Internal code representing the broader geographic region (e.g., "EMEA", "APAC").',
    `regulated_premises_flag` BOOLEAN COMMENT 'Indicates whether the location is a regulated financial‑services premises subject to PCI DSS or other financial regulations.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating assigned to the location based on security, compliance, and operational factors.',
    `state_province` STRING COMMENT 'State or province of the location.',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the tax jurisdiction applicable to the location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the location record.',
    `workforce_location_description` STRING COMMENT 'Free‑form description providing additional context about the location.',
    `workforce_location_name` STRING COMMENT 'Human‑readable name of the work location (e.g., "London Headquarters").',
    `workforce_location_status` STRING COMMENT 'Current operational status of the location.. Valid values are `active|inactive|closed|pending`',
    CONSTRAINT pk_workforce_location PRIMARY KEY(`workforce_location_id`)
) COMMENT 'Employee work location master capturing the physical and virtual work locations assigned to employees. Stores location name, location type (headquarters, regional office, branch, data center, remote/home), address, country, city, time zone, legal entity, and whether the location is a regulated financial services premises. Supports multi-jurisdiction payroll tax calculations, real estate planning, and regulatory reporting of employee distribution across the 200+ country footprint.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`hr_case` (
    `hr_case_id` BIGINT COMMENT 'Unique surrogate key for the HR case record.',
    `employee_id` BIGINT COMMENT 'Identifier of the HR business partner responsible for managing the case.',
    `primary_assigned_hr_partner_employee_id` BIGINT COMMENT 'Identifier of the HR business partner responsible for managing the case.',
    `related_hr_case_id` BIGINT COMMENT 'Self-referencing FK on hr_case (related_hr_case_id)',
    `case_description` STRING COMMENT 'Narrative description of the issue, including relevant facts and context.',
    `case_number` STRING COMMENT 'Human‑readable business identifier for the case, used in communications and reporting.',
    `case_status` STRING COMMENT 'Current lifecycle state of the case.. Valid values are `open|under_investigation|resolved|escalated|closed`',
    `case_type` STRING COMMENT 'Category of the HR case indicating the nature of the employee relations issue.. Valid values are `grievance|harassment|whistleblower|accommodation|policy_violation|investigation`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the case reached a terminal state (closed or resolved).',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the case triggers regulatory or compliance reporting obligations.',
    `confidentiality_classification` STRING COMMENT 'Data classification level governing access to the case details.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the record was first persisted.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the resolution amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the case has been escalated beyond the initial HR partner.',
    `escalation_level` STRING COMMENT 'Level of escalation applied to the case, if any.. Valid values are `level1|level2|level3|level4`',
    `investigation_notes` STRING COMMENT 'Free‑form notes recorded by investigators during case handling.',
    `legal_counsel_involved_flag` BOOLEAN COMMENT 'Indicates whether legal counsel is participating in the case.',
    `opened_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was initially created in the system.',
    `priority` STRING COMMENT 'Business‑defined priority level for handling the case.. Valid values are `low|medium|high|critical`',
    `related_policy_code` STRING COMMENT 'Reference code of the internal policy implicated by the case.',
    `resolution_amount` DECIMAL(18,2) COMMENT 'Monetary value associated with the case resolution (e.g., compensation, penalty).',
    `resolution_date` DATE COMMENT 'Date on which the case resolution was finalized.',
    `resolution_type` STRING COMMENT 'Outcome category applied when the case is resolved.. Valid values are `dismissal|reinstatement|disciplinary_action|training|policy_change|no_action`',
    `source_channel` STRING COMMENT 'Channel through which the case was initially reported.. Valid values are `email|phone|portal|in_person|hr_system`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the record.',
    CONSTRAINT pk_hr_case PRIMARY KEY(`hr_case_id`)
) COMMENT 'HR case management record for employee relations inquiries, grievances, and investigations. Captures case type (grievance, harassment complaint, whistleblower report, accommodation request, policy violation, workplace investigation), case status (open, under investigation, resolved, escalated, closed), case priority, assigned HR business partner, legal counsel involvement flag, resolution type, resolution date, and confidentiality classification. Supports employee relations governance and regulatory reporting obligations.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` (
    `succession_plan_id` BIGINT COMMENT 'System-generated unique identifier for the succession plan record.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager responsible for maintaining the succession plan.',
    `job_profile_id` BIGINT COMMENT 'Identifier of the critical role for which a successor is being planned.',
    `position_id` BIGINT COMMENT 'Identifier of the critical role for which a successor is being planned.',
    `primary_succession_successor_employee_id` BIGINT COMMENT 'Unique identifier of the employee designated as the successor.',
    `target_role_position_id` BIGINT COMMENT 'FK to workforce.position',
    `superseded_succession_plan_id` BIGINT COMMENT 'Self-referencing FK on succession_plan (superseded_succession_plan_id)',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating how the succession plan should be handled.. Valid values are `restricted|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the succession plan record was first created.',
    `development_actions` STRING COMMENT 'Planned development activities, training, or experiences required for the successor.',
    `effective_from` DATE COMMENT 'Date when the succession plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the succession plan expires or is superseded (null if open‑ended).',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the succession plan.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the succession plan.',
    `plan_code` STRING COMMENT 'External business identifier or code used to reference the succession plan.',
    `plan_name` STRING COMMENT 'Human‑readable name of the succession plan.',
    `plan_review_date` DATE COMMENT 'Date on which the succession plan is scheduled for formal review.',
    `readiness_timeline` STRING COMMENT 'Estimated time horizon for the successor to be ready to assume the role.. Valid values are `ready_now|1-2_years|3-5_years`',
    `risk_rating` STRING COMMENT 'Risk rating indicating the likelihood of losing the successor or the role (high, medium, low).. Valid values are `high|medium|low`',
    `succession_plan_status` STRING COMMENT 'Current lifecycle status of the succession plan.. Valid values are `active|inactive|archived`',
    `successor_name` STRING COMMENT 'Full legal name of the designated successor.',
    `target_role_title` STRING COMMENT 'Descriptive title of the critical role (e.g., Head of Payments Operations).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the succession plan record.',
    CONSTRAINT pk_succession_plan PRIMARY KEY(`succession_plan_id`)
) COMMENT 'Succession planning record identifying critical roles and their designated successors within the payments fintech enterprise. Captures the target position or role, readiness timeline (ready now, 1-2 years, 3-5 years), successor employee reference, development actions required, risk rating (high/medium/low retention risk), and plan review date. Supports talent pipeline management for key payments operations, compliance, and technology leadership roles.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` (
    `equity_grant_id` BIGINT COMMENT 'System-generated unique identifier for the equity grant record.',
    `compensation_plan_id` BIGINT COMMENT 'Reference to the equity compensation plan under which the grant was issued.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Equity grant is awarded to a specific employee; linking provides ownership, enables reporting and compliance, and eliminates orphaned grant records. No existing FK from employee to equity_grant, so no',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity (company) that issued the grant.',
    `superseded_equity_grant_id` BIGINT COMMENT 'Self-referencing FK on equity_grant (superseded_equity_grant_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the grant received final approval.',
    `cliff_months` STRING COMMENT 'Number of months before any units become vested under a cliff schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the equity grant record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for monetary values (e.g., USD, EUR).',
    `exercise_price` DECIMAL(18,2) COMMENT 'Price per share or unit that the holder must pay to exercise the option.',
    `expiry_date` DATE COMMENT 'Date after which the grant can no longer be exercised or vested.',
    `fully_vested_date` DATE COMMENT 'Date when all granted units become fully vested.',
    `graded_vesting_months` STRING COMMENT 'Total months over which units vest incrementally under a graded schedule.',
    `grant_date` DATE COMMENT 'Date the equity award was granted to the employee.',
    `grant_number` STRING COMMENT 'External reference number or code assigned to the grant for tracking and reporting.',
    `grant_price` DECIMAL(18,2) COMMENT 'Fair market value of the underlying security on the grant date.',
    `grant_status` STRING COMMENT 'Current lifecycle status of the equity grant.. Valid values are `outstanding|partially_vested|fully_vested|exercised|forfeited|expired`',
    `grant_type` STRING COMMENT 'Category of equity award: Incentive Stock Option (ISO), Non-Qualified Stock Option (NSO), Restricted Stock Unit (RSU), Employee Stock Purchase Plan (ESPP), or Phantom Equity.. Valid values are `ISO|NSO|RSU|ESPP|Phantom`',
    `is_approved` BOOLEAN COMMENT 'Indicates whether the grant has been formally approved by the compensation committee.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the grant is subject to tax withholding at vesting or exercise.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the grant.',
    `performance_actual` DECIMAL(18,2) COMMENT 'Actual measured performance metric value at evaluation.',
    `performance_metric` STRING COMMENT 'Key performance indicator used for performance‑based vesting (e.g., revenue target, EPS).',
    `performance_target` DECIMAL(18,2) COMMENT 'Target value for the performance metric that must be achieved for vesting.',
    `tax_withholding_rate` DECIMAL(18,2) COMMENT 'Percentage of taxable value withheld for tax purposes.',
    `units_granted` STRING COMMENT 'Number of shares, units, or options awarded.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the equity grant record.',
    `vesting_schedule_type` STRING COMMENT 'Method by which the grant vests: cliff, graded, or performance‑based.. Valid values are `cliff|graded|performance`',
    `vesting_start_date` DATE COMMENT 'Date when the vesting period begins.',
    CONSTRAINT pk_equity_grant PRIMARY KEY(`equity_grant_id`)
) COMMENT 'Employee equity compensation grant record capturing stock option, RSU, and ESPP awards. Stores grant type (ISO, NSO, RSU, ESPP, phantom equity), grant date, grant price, number of units granted, vesting schedule type (cliff, graded, performance-based), vesting start date, fully vested date, expiry date, grant status (outstanding, partially vested, fully vested, exercised, forfeited, expired), and the legal entity issuing the grant. Supports equity plan administration and SEC/regulatory reporting for publicly traded fintech entities.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` (
    `compliance_record_id` BIGINT COMMENT 'Unique surrogate key for the workforce compliance record.',
    `employee_id` BIGINT COMMENT 'Identifier of the HR employee responsible for the obligation.',
    `responsible_owner_employee_id` BIGINT COMMENT 'Identifier of the HR employee responsible for the obligation.',
    `superseded_compliance_record_id` BIGINT COMMENT 'Self-referencing FK on compliance_record (superseded_compliance_record_id)',
    `audit_findings_summary` STRING COMMENT 'Summary of findings from the latest audit.',
    `audit_trail_reference` BIGINT COMMENT 'Identifier linking to the detailed audit trail for changes.',
    `completion_date` DATE COMMENT 'Date when the compliance obligation was fulfilled.',
    `compliance_record_status` STRING COMMENT 'Current lifecycle status of the compliance obligation.. Valid values are `pending|in_progress|completed|failed|cancelled`',
    `compliance_status` STRING COMMENT 'Result of compliance assessment for the obligation.. Valid values are `compliant|non_compliant|exempt|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance record was first created.',
    `data_retention_policy` STRING COMMENT 'Policy governing how long the compliance record is retained.. Valid values are `retain_5_years|retain_7_years|retain_indefinite`',
    `due_date` DATE COMMENT 'Deadline by which the compliance obligation must be satisfied.',
    `effective_from` DATE COMMENT 'Date when the compliance obligation starts being applicable.',
    `effective_until` DATE COMMENT 'Date when the compliance obligation ends or expires, if applicable.',
    `evidence_document_url` STRING COMMENT 'Link to supporting documentation or evidence for compliance.',
    `is_external_regulation` BOOLEAN COMMENT 'True if the obligation originates from external regulator, false if internal policy.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the compliance obligation is mandatory (true) or optional (false).',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO code of the jurisdiction governing the obligation.. Valid values are `[A-Z]{3}`',
    `last_audit_status` STRING COMMENT 'Result of the most recent audit related to this compliance obligation.. Valid values are `passed|failed|pending`',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance review.',
    `notes` STRING COMMENT 'Additional comments or notes regarding the compliance record.',
    `obligation_number` STRING COMMENT 'External reference number for the compliance obligation.',
    `obligation_type` STRING COMMENT 'Category of the compliance obligation.. Valid values are `right_to_work|i9_verification|license_reporting|fit_and_proper|pay_equity_audit|eeo1_filing`',
    `regulatory_framework` STRING COMMENT 'Regulatory jurisdiction or framework governing the obligation.. Valid values are `US|EU|UK|AU|CA|SG`',
    `remediation_action_required` BOOLEAN COMMENT 'Indicates if remediation actions are required due to non-compliance.',
    `remediation_due_date` DATE COMMENT 'Deadline for completing remediation actions.',
    `remediation_status` STRING COMMENT 'Current status of remediation actions.. Valid values are `not_started|in_progress|completed`',
    `reporting_frequency` STRING COMMENT 'How often the compliance obligation must be reported.. Valid values are `annual|quarterly|monthly|ad_hoc`',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk rating associated with non-compliance of this obligation.',
    `source_system` STRING COMMENT 'System of record where the compliance data originated.. Valid values are `HRIS|CompliancePlatform|Manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compliance record.',
    `version_number` STRING COMMENT 'Version of the compliance record for change tracking.',
    CONSTRAINT pk_compliance_record PRIMARY KEY(`compliance_record_id`)
) COMMENT 'HR compliance record tracking mandatory regulatory obligations specific to the workforce domain — distinct from the enterprise compliance domain. Captures compliance obligation type (right-to-work verification, I-9/work authorization, mandatory reporting of licensed personnel to regulators, fit-and-proper assessments for senior managers under SM&CR/MiFID II, pay equity audit, EEO-1 filing), obligation status, due date, completion date, responsible HR owner, and jurisdiction. Ensures the payments fintech enterprise meets workforce-specific regulatory requirements across all operating jurisdictions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`objective` (
    `objective_id` BIGINT COMMENT 'Primary key for objective',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department responsible for the objective.',
    `strategy_id` BIGINT COMMENT 'Identifier of the strategic plan that this objective supports.',
    `parent_objective_id` BIGINT COMMENT 'Self-referencing FK on objective (parent_objective_id)',
    `actual_value` DECIMAL(18,2) COMMENT 'Current actual measured value towards the target.',
    `alignment_level` STRING COMMENT 'Organizational level at which the objective is aligned.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for initiatives related to the objective.',
    `objective_category` STRING COMMENT 'High-level classification of the objective.',
    `compliance_requirement` STRING COMMENT 'Regulatory compliance requirement associated with the objective, if any.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the objective record was created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the budget amount.',
    `objective_description` STRING COMMENT 'Detailed description of the objective, including purpose and scope.',
    `effective_end_date` DATE COMMENT 'Date when the objective is expected to be completed or expires. Null if open-ended.',
    `effective_start_date` DATE COMMENT 'Date when the objective becomes effective.',
    `is_key_result` BOOLEAN COMMENT 'Indicates whether the objective is a key result in an OKR framework.',
    `last_review_date` DATE COMMENT 'Date when the objective was last reviewed by governance.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the target value.',
    `objective_name` STRING COMMENT 'Human readable name of the strategic objective.',
    `notes` STRING COMMENT 'Additional free-form notes or comments about the objective.',
    `owner_role` STRING COMMENT 'Job role of the primary owner of the objective.',
    `priority` STRING COMMENT 'Priority level assigned to the objective.',
    `progress_percentage` DECIMAL(18,2) COMMENT 'Percentage progress towards the target value (0-100).',
    `review_frequency` STRING COMMENT 'How often the objective is reviewed.',
    `risk_level` STRING COMMENT 'Risk level associated with achieving the objective.',
    `objective_status` STRING COMMENT 'Current lifecycle status of the objective.',
    `target_date` DATE COMMENT 'Planned date by which the target value should be achieved.',
    `target_value` DECIMAL(18,2) COMMENT 'Quantitative target associated with the objective (e.g., revenue increase amount).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the objective record.',
    CONSTRAINT pk_objective PRIMARY KEY(`objective_id`)
) COMMENT 'Master reference table for objective. Referenced by alignment_objective_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Primary key for benefit_plan',
    `superseded_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (superseded_benefit_plan_id)',
    `compliance_status` STRING COMMENT 'Current compliance standing of the plan with regulatory requirements.',
    `contribution_employee_amount` DECIMAL(18,2) COMMENT 'Monetary amount contributed by the employee per pay period.',
    `contribution_employee_percent` DECIMAL(18,2) COMMENT 'Percentage of the benefit cost contributed by the employee.',
    `contribution_employer_amount` DECIMAL(18,2) COMMENT 'Monetary amount contributed by the employer per pay period.',
    `contribution_employer_percent` DECIMAL(18,2) COMMENT 'Percentage of the benefit cost contributed by the employer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit plan record was first created.',
    `benefit_plan_description` STRING COMMENT 'Detailed description of the benefit plan offering.',
    `effective_end_date` DATE COMMENT 'Date when the benefit plan ceases to be active (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the benefit plan becomes active for enrolled employees.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining employee eligibility for the plan.',
    `enrollment_end_date` DATE COMMENT 'Date after which enrollment in the plan is closed.',
    `enrollment_start_date` DATE COMMENT 'Date when employees may begin enrolling in the plan.',
    `is_default_plan` BOOLEAN COMMENT 'True if this plan is the default option for eligible employees.',
    `last_review_date` DATE COMMENT 'Date when the benefit plan was last reviewed for compliance or renewal.',
    `last_review_user` STRING COMMENT 'Identifier of the user who performed the last review.',
    `payroll_deduction_flag` BOOLEAN COMMENT 'Indicates whether contributions are deducted via payroll.',
    `plan_category` STRING COMMENT 'Higher‑level grouping of the plan (e.g., health, retirement, wellness).',
    `plan_code` STRING COMMENT 'External code used to reference the benefit plan.',
    `plan_cost_per_employee` DECIMAL(18,2) COMMENT 'Average cost of the plan per enrolled employee.',
    `plan_cost_total` DECIMAL(18,2) COMMENT 'Aggregate cost of the plan for all enrolled employees.',
    `plan_coverage_details` STRING COMMENT 'Specific benefits and limits included in the plan.',
    `plan_coverage_level` STRING COMMENT 'Level of coverage provided (e.g., basic, premium).',
    `plan_currency` STRING COMMENT 'ISO 4217 currency code for monetary values of the plan.',
    `plan_eligible_employee_type` STRING COMMENT 'Employee employment type(s) eligible for the plan.',
    `plan_frequency` STRING COMMENT 'How often contributions are collected (e.g., monthly).',
    `plan_maximum_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary benefit payable under the plan.',
    `plan_name` STRING COMMENT 'Human‑readable name of the benefit plan.',
    `plan_region` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code indicating the primary geographic region of the plan.',
    `plan_taxable` BOOLEAN COMMENT 'True if the benefit amount is subject to tax.',
    `plan_termination_date` DATE COMMENT 'Date the plan was terminated or will be terminated.',
    `plan_termination_reason` STRING COMMENT 'Reason for plan termination (e.g., merger, policy change).',
    `plan_type` STRING COMMENT 'Category of the benefit plan indicating its primary purpose.',
    `plan_version` STRING COMMENT 'Version number of the benefit plan definition.',
    `plan_waiting_period_days` STRING COMMENT 'Number of days after enrollment before benefits become active.',
    `provider_contact_email` STRING COMMENT 'Email address for contacting the benefit provider.',
    `provider_contact_phone` STRING COMMENT 'Phone number for contacting the benefit provider.',
    `provider_name` STRING COMMENT 'Name of the external provider delivering the benefit.',
    `regulatory_filing_required` STRING COMMENT 'Indicates if the plan requires periodic regulatory filing.',
    `benefit_plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan.',
    `tax_qualified_flag` BOOLEAN COMMENT 'True if the benefit is tax‑qualified under applicable regulations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the benefit plan record.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by benefit_plan_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`timesheet` (
    `timesheet_id` BIGINT COMMENT 'Primary key for timesheet',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who logged the timesheet.',
    `amended_timesheet_id` BIGINT COMMENT 'Self-referencing FK on timesheet (amended_timesheet_id)',
    `approval_status` STRING COMMENT 'Current approval workflow status.',
    `approved_by` BIGINT COMMENT 'Identifier of the manager or supervisor who approved the timesheet.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet was approved.',
    `billable_rate` DECIMAL(18,2) COMMENT 'Rate applied for billable hours when invoicing a client.',
    `comments` STRING COMMENT 'Free-text notes entered by the employee.',
    `cost_center_code` STRING COMMENT 'Internal cost center to which the labor costs are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the timesheet record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount.',
    `expense_amount` DECIMAL(18,2) COMMENT 'Total reimbursable expense amount reported on the timesheet.',
    `expense_currency` STRING COMMENT 'Currency of the expense amount.',
    `expense_type` STRING COMMENT 'Category of expense claimed.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Base compensation rate per regular hour for the employee.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the logged hours are billable to a client.',
    `last_modified_by` BIGINT COMMENT 'Identifier of the employee who last edited the timesheet.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the last edit.',
    `location_code` STRING COMMENT 'Code representing the physical or virtual location where work was performed.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Hours worked beyond standard schedule, eligible for overtime rate.',
    `overtime_rate` DECIMAL(18,2) COMMENT 'Compensation rate per overtime hour.',
    `period_end_date` DATE COMMENT 'Last calendar date of the timesheet reporting period.',
    `period_start_date` DATE COMMENT 'First calendar date of the timesheet reporting period.',
    `project_code` STRING COMMENT 'Identifier of the project associated with the work, if applicable.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Hours worked at standard rate.',
    `timesheet_status` STRING COMMENT 'Current lifecycle status of the timesheet.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet was submitted.',
    `submitted_via` STRING COMMENT 'Interface used to submit the timesheet.',
    `timesheet_number` STRING COMMENT 'Business identifier assigned to the timesheet (e.g., TS-2023-00123).',
    `total_amount` DECIMAL(18,2) COMMENT 'Total monetary amount payable for the timesheet (regular + overtime).',
    `total_hours` DECIMAL(18,2) COMMENT 'Aggregate number of hours logged in the period, including regular and overtime.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the timesheet record.',
    `work_type` STRING COMMENT 'Category of work performed during the period.',
    CONSTRAINT pk_timesheet PRIMARY KEY(`timesheet_id`)
) COMMENT 'Master reference table for timesheet. Referenced by timesheet_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`payroll_period` (
    `payroll_period_id` BIGINT COMMENT 'Primary key for payroll_period',
    `prior_payroll_period_id` BIGINT COMMENT 'Self-referencing FK on payroll_period (prior_payroll_period_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll period record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for payroll amounts in this period.',
    `cut_off_date` DATE COMMENT 'Date by which all time‑cards must be submitted for this period.',
    `payroll_period_description` STRING COMMENT 'Optional free‑text description providing additional context for the period.',
    `end_date` DATE COMMENT 'Last calendar date of the payroll period.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1‑4) for the payroll period.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the payroll period belongs.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether tax calculations are applied for this payroll period.',
    `pay_date` DATE COMMENT 'Date on which employees are paid for this period.',
    `payroll_cycle_type` STRING COMMENT 'Frequency with which payroll is processed for this period.',
    `period_code` STRING COMMENT 'Compact alphanumeric code used to reference the payroll period in downstream systems.',
    `period_name` STRING COMMENT 'Human‑readable name of the payroll period, e.g., "2023‑09 Bi‑weekly 1".',
    `period_number` STRING COMMENT 'Sequential number of the period within its cycle (e.g., week number).',
    `processing_status` STRING COMMENT 'Current processing state of payroll calculations for the period.',
    `start_date` DATE COMMENT 'First calendar date of the payroll period.',
    `payroll_period_status` STRING COMMENT 'Current lifecycle state of the payroll period.',
    `total_employee_count` STRING COMMENT 'Number of employees included in this payroll period.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Aggregate gross compensation before deductions for the period.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Aggregate net compensation after deductions for the period.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total tax withheld across all employees for the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll period record.',
    CONSTRAINT pk_payroll_period PRIMARY KEY(`payroll_period_id`)
) COMMENT 'Master reference table for payroll_period. Referenced by payroll_period_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`team` (
    `team_id` BIGINT COMMENT 'Primary key for team',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who manages the team.',
    `workforce_location_id` BIGINT COMMENT 'Reference to the physical location or office where the team is based.',
    `parent_team_id` BIGINT COMMENT 'Identifier of the parent team in the organizational hierarchy.',
    `average_tenure_months` DECIMAL(18,2) COMMENT 'Average tenure of team members expressed in months.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated to the team.',
    `team_code` STRING COMMENT 'Unique business code assigned to the team.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the team.',
    `cost_center_code` STRING COMMENT 'Financial cost center associated with the team.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the team record was first created in the system.',
    `data_classification` STRING COMMENT 'Data classification level applied to the teams data assets.',
    `team_description` STRING COMMENT 'Detailed description of the teams purpose, responsibilities and scope.',
    `effective_from` DATE COMMENT 'Date when the team became operational.',
    `effective_until` DATE COMMENT 'Date when the team ceased operation, if applicable.',
    `headcount` STRING COMMENT 'Number of active members in the team.',
    `is_cross_functional` BOOLEAN COMMENT 'Indicates whether the team works across multiple functional areas.',
    `is_remote` BOOLEAN COMMENT 'Indicates if the team operates primarily remotely.',
    `team_name` STRING COMMENT 'Human‑readable name of the team.',
    `notes` STRING COMMENT 'Additional free‑text notes about the team.',
    `team_status` STRING COMMENT 'Current lifecycle status of the team.',
    `team_level` STRING COMMENT 'Organizational level of the team within the hierarchy.',
    `team_type` STRING COMMENT 'Category indicating the functional role of the team within the organization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the team record.',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'Master reference table for team. Referenced by team_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Primary key for payroll_run',
    `employee_id` BIGINT COMMENT 'Identifier of the organizational unit responsible for the payroll run.',
    `rerun_payroll_run_id` BIGINT COMMENT 'Self-referencing FK on payroll_run (rerun_payroll_run_id)',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payroll amounts.',
    `employee_count` STRING COMMENT 'Number of employees included in this payroll run.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross payroll amount before deductions.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net payroll amount after deductions.',
    `pay_cycle` STRING COMMENT 'Frequency of the payroll run.',
    `payroll_period_end` DATE COMMENT 'End date of the payroll period covered by this run.',
    `payroll_period_start` DATE COMMENT 'Start date of the payroll period covered by this run.',
    `payroll_type` STRING COMMENT 'Category of payroll run indicating the nature of payments.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the payroll run record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll run record.',
    `run_code` STRING COMMENT 'External reference code for the payroll run, used in reporting and integration.',
    `run_date` DATE COMMENT 'Date on which the payroll was executed.',
    `run_notes` STRING COMMENT 'Free-text notes or comments about the payroll run.',
    `payroll_run_status` STRING COMMENT 'Current lifecycle status of the payroll run.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount deducted from the payroll.',
    `total_hours` DECIMAL(18,2) COMMENT 'Aggregate number of hours paid across all employees in this payroll run.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master reference table for payroll_run. Referenced by payroll_run_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`workforce`.`strategy` (
    `strategy_id` BIGINT COMMENT 'Primary key for strategy',
    `actual_value` DECIMAL(18,2) COMMENT 'Measured actual metric value achieved by the strategy.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the strategy was approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the strategy.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Financial budget allocated to the strategy.',
    `strategy_code` STRING COMMENT 'Business identifier or code used to reference the strategy in external systems.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the strategy is subject to regulatory compliance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the strategy record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the budget.',
    `strategy_description` STRING COMMENT 'Detailed narrative describing the purpose and scope of the strategy.',
    `effective_from` DATE COMMENT 'Date when the strategy becomes effective.',
    `effective_until` DATE COMMENT 'Date when the strategy expires or is superseded; null if open‑ended.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the strategy.',
    `measurement_unit` STRING COMMENT 'Unit of measure used for target and actual values.',
    `strategy_name` STRING COMMENT 'Human‑readable name of the strategy.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the strategy.',
    `owner_employee_id` BIGINT COMMENT 'Identifier of the employee who owns or sponsors the strategy.',
    `performance_status` STRING COMMENT 'Current performance assessment of the strategy.',
    `priority` STRING COMMENT 'Business‑defined priority of the strategy.',
    `related_strategy_id` BIGINT COMMENT 'Identifier of a parent or linked strategy.',
    `review_date` DATE COMMENT 'Scheduled date for the next strategic review.',
    `risk_level` STRING COMMENT 'Risk classification associated with the strategy.',
    `strategy_status` STRING COMMENT 'Current lifecycle state of the strategy.',
    `strategic_goal` STRING COMMENT 'High‑level goal that the strategy aims to achieve.',
    `target_value` DECIMAL(18,2) COMMENT 'Planned target metric value for the strategy.',
    `strategy_type` STRING COMMENT 'Category of the strategy, such as growth, cost reduction, innovation, or compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the strategy record.',
    `version_number` STRING COMMENT 'Incremental version number for change tracking.',
    `created_by` STRING COMMENT 'User name or identifier that created the strategy record.',
    CONSTRAINT pk_strategy PRIMARY KEY(`strategy_id`)
) COMMENT 'Master reference table for strategy. Referenced by related_strategy_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_work_schedule_id` FOREIGN KEY (`work_schedule_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`work_schedule`(`work_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_workforce_location_id` FOREIGN KEY (`workforce_location_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`workforce_location`(`workforce_location_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reporting_manager_position_id` FOREIGN KEY (`reporting_manager_position_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_unit_org_unit_id` FOREIGN KEY (`parent_unit_org_unit_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_reports_to_job_profile_id` FOREIGN KEY (`reports_to_job_profile_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_parent_job_profile_id` FOREIGN KEY (`parent_job_profile_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_department_org_unit_id` FOREIGN KEY (`department_org_unit_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_primary_employment_employee_id` FOREIGN KEY (`primary_employment_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_renewed_employment_contract_id` FOREIGN KEY (`renewed_employment_contract_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employment_contract`(`employment_contract_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_superseded_compensation_plan_id` FOREIGN KEY (`superseded_compensation_plan_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_reversal_payroll_record_id` FOREIGN KEY (`reversal_payroll_record_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ADD CONSTRAINT `fk_workforce_payroll_deduction_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ADD CONSTRAINT `fk_workforce_payroll_deduction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ADD CONSTRAINT `fk_workforce_payroll_deduction_payroll_record_id` FOREIGN KEY (`payroll_record_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ADD CONSTRAINT `fk_workforce_payroll_deduction_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ADD CONSTRAINT `fk_workforce_payroll_deduction_adjusted_payroll_deduction_id` FOREIGN KEY (`adjusted_payroll_deduction_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`payroll_deduction`(`payroll_deduction_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_prior_benefit_enrollment_id` FOREIGN KEY (`prior_benefit_enrollment_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`benefit_enrollment`(`benefit_enrollment_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_original_leave_request_id` FOREIGN KEY (`original_leave_request_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`leave_request`(`leave_request_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ADD CONSTRAINT `fk_workforce_leave_balance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ADD CONSTRAINT `fk_workforce_leave_balance_carryover_leave_balance_id` FOREIGN KEY (`carryover_leave_balance_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`leave_balance`(`leave_balance_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_prior_performance_review_id` FOREIGN KEY (`prior_performance_review_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`performance_review`(`performance_review_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_objective_id` FOREIGN KEY (`objective_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`objective`(`objective_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_team_id` FOREIGN KEY (`team_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_parent_goal_id` FOREIGN KEY (`parent_goal_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`goal`(`goal_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ADD CONSTRAINT `fk_workforce_headcount_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ADD CONSTRAINT `fk_workforce_headcount_prior_period_headcount_id` FOREIGN KEY (`prior_period_headcount_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`headcount`(`headcount_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ADD CONSTRAINT `fk_workforce_role_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ADD CONSTRAINT `fk_workforce_role_assignment_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ADD CONSTRAINT `fk_workforce_role_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ADD CONSTRAINT `fk_workforce_role_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ADD CONSTRAINT `fk_workforce_role_assignment_primary_role_employee_id` FOREIGN KEY (`primary_role_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ADD CONSTRAINT `fk_workforce_role_assignment_superseded_role_assignment_id` FOREIGN KEY (`superseded_role_assignment_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`role_assignment`(`role_assignment_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_hr_business_partner_employee_id` FOREIGN KEY (`hr_business_partner_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_primary_employment_employee_id` FOREIGN KEY (`primary_employment_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_tertiary_employment_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_employment_hr_business_partner_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_corrected_employment_event_id` FOREIGN KEY (`corrected_employment_event_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employment_event`(`employment_event_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_renewed_workforce_certification_id` FOREIGN KEY (`renewed_workforce_certification_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_primary_training_employee_id` FOREIGN KEY (`primary_training_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_retake_training_enrollment_id` FOREIGN KEY (`retake_training_enrollment_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`training_enrollment`(`training_enrollment_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_legal_counsel_employee_id` FOREIGN KEY (`legal_counsel_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_primary_disciplinary_employee_id` FOREIGN KEY (`primary_disciplinary_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_tertiary_disciplinary_legal_counsel_employee_id` FOREIGN KEY (`tertiary_disciplinary_legal_counsel_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_escalated_from_disciplinary_action_id` FOREIGN KEY (`escalated_from_disciplinary_action_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`disciplinary_action`(`disciplinary_action_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_recheck_background_check_id` FOREIGN KEY (`recheck_background_check_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`background_check`(`background_check_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ADD CONSTRAINT `fk_workforce_work_schedule_superseded_work_schedule_id` FOREIGN KEY (`superseded_work_schedule_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`work_schedule`(`work_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_primary_time_employee_id` FOREIGN KEY (`primary_time_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`timesheet`(`timesheet_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_adjusted_time_entry_id` FOREIGN KEY (`adjusted_time_entry_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`time_entry`(`time_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ADD CONSTRAINT `fk_workforce_workforce_location_parent_location_workforce_location_id` FOREIGN KEY (`parent_location_workforce_location_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`workforce_location`(`workforce_location_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ADD CONSTRAINT `fk_workforce_workforce_location_parent_workforce_location_id` FOREIGN KEY (`parent_workforce_location_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`workforce_location`(`workforce_location_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ADD CONSTRAINT `fk_workforce_hr_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ADD CONSTRAINT `fk_workforce_hr_case_primary_assigned_hr_partner_employee_id` FOREIGN KEY (`primary_assigned_hr_partner_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ADD CONSTRAINT `fk_workforce_hr_case_related_hr_case_id` FOREIGN KEY (`related_hr_case_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`hr_case`(`hr_case_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_primary_succession_successor_employee_id` FOREIGN KEY (`primary_succession_successor_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_target_role_position_id` FOREIGN KEY (`target_role_position_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_superseded_succession_plan_id` FOREIGN KEY (`superseded_succession_plan_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`succession_plan`(`succession_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ADD CONSTRAINT `fk_workforce_equity_grant_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ADD CONSTRAINT `fk_workforce_equity_grant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ADD CONSTRAINT `fk_workforce_equity_grant_superseded_equity_grant_id` FOREIGN KEY (`superseded_equity_grant_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`equity_grant`(`equity_grant_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ADD CONSTRAINT `fk_workforce_compliance_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ADD CONSTRAINT `fk_workforce_compliance_record_responsible_owner_employee_id` FOREIGN KEY (`responsible_owner_employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ADD CONSTRAINT `fk_workforce_compliance_record_superseded_compliance_record_id` FOREIGN KEY (`superseded_compliance_record_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`compliance_record`(`compliance_record_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`objective` ADD CONSTRAINT `fk_workforce_objective_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`objective` ADD CONSTRAINT `fk_workforce_objective_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`strategy`(`strategy_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`objective` ADD CONSTRAINT `fk_workforce_objective_parent_objective_id` FOREIGN KEY (`parent_objective_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`objective`(`objective_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_amended_timesheet_id` FOREIGN KEY (`amended_timesheet_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`timesheet`(`timesheet_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_prior_payroll_period_id` FOREIGN KEY (`prior_payroll_period_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`team` ADD CONSTRAINT `fk_workforce_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`team` ADD CONSTRAINT `fk_workforce_team_workforce_location_id` FOREIGN KEY (`workforce_location_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`workforce_location`(`workforce_location_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`team` ADD CONSTRAINT `fk_workforce_team_parent_team_id` FOREIGN KEY (`parent_team_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_rerun_payroll_run_id` FOREIGN KEY (`rerun_payroll_run_id`) REFERENCES `payments_fintech_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `payments_fintech_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `work_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `workforce_location_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Location Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `address_full` SET TAGS ('dbx_business_glossary_term' = 'Employee Primary Residence Address');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `address_full` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `address_full` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|failed|exempt');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `bonus_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth (DOB)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Employment Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Work Email Address');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|terminated|retired|pending');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|intern|temporary');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `equity_grant_flag` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name (FN)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent Percentage');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Hire Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate (USD)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `job_grade` SET TAGS ('dbx_business_glossary_term' = 'Job Grade Band');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name (LN)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Legal Name');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name (MN)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number (NIN)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Work Phone Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Preferred Name');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `remote_status` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `remote_status` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `reports_to_position` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount (USD)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Termination Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `visa_status` SET TAGS ('dbx_business_glossary_term' = 'Visa/Work Authorization Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `visa_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|work_visa|none');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `work_shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employee` ALTER COLUMN `work_shift` SET TAGS ('dbx_value_regex' = 'day|night|flex|rotating');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `reporting_manager_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Manager Position ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `budgeted_headcount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `compensation_band` SET TAGS ('dbx_business_glossary_term' = 'Compensation Band');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `compensation_band` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `compensation_band` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent Allocation');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `grade_level` SET TAGS ('dbx_business_glossary_term' = 'Grade Level');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `is_remote_allowed` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Allowed');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `job_function` SET TAGS ('dbx_business_glossary_term' = 'Job Function');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|filled|frozen|eliminated|pending');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `recruitment_source` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Source');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `required_education_level` SET TAGS ('dbx_business_glossary_term' = 'Required Education Level');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `required_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Required Experience (Years)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `salary_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Salary');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `salary_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `salary_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Salary');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `salary_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `skill_set` SET TAGS ('dbx_business_glossary_term' = 'Skill Set');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`position` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_unit_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Head Employee Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (Currency)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount` SET TAGS ('dbx_business_glossary_term' = 'Headcount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_cost_allocation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_financial_reporting_unit` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Unit Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'division|department|team|squad|cost_center|function');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `reports_to_job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Job Profile Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `parent_job_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'FLSA Classification');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `is_manager_role` SET TAGS ('dbx_business_glossary_term' = 'Is Manager Role');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_function` SET TAGS ('dbx_business_glossary_term' = 'Job Function');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `location_scope` SET TAGS ('dbx_business_glossary_term' = 'Location Scope');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pay Grade');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pay Grade');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `regulatory_license_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory License Required');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `regulatory_license_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory License Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `required_competencies` SET TAGS ('dbx_business_glossary_term' = 'Required Competencies');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`job_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `department_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `renewed_employment_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `benefits_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Benefits Enrollment Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `collective_bargaining_agreement` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_expiry_notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Notice Sent Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_review_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Review Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_review_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Review Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_review_status` SET TAGS ('dbx_value_regex' = 'pending|completed|overdue');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed_term|zero_hours|contractor');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employee_classification` SET TAGS ('dbx_business_glossary_term' = 'Employee Classification');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employee_grade` SET TAGS ('dbx_business_glossary_term' = 'Employee Grade');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `full_time_indicator` SET TAGS ('dbx_business_glossary_term' = 'Full‑Time Indicator');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `governing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `non_compete_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Non‑Compete Clause Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (Days)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|biweekly|weekly|quarterly|annually');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `payroll_group_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `probation_period_days` SET TAGS ('dbx_business_glossary_term' = 'Probation Period (Days)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `remote_work_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Salary Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|AUD|CAD');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'resignation|termination|layoff|mutual_agreement');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_contract` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'compensation_payroll');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Identifier (CPI)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (AEI)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (AEI)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowance Amount (AA)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Allowance Type (AT)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'housing|transport|meal|other');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (AD)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount (BSA)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Cap Amount (BCA)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Percentage (BTP)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_component` SET TAGS ('dbx_business_glossary_term' = 'Compensation Component Category (CCC)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_component` SET TAGS ('dbx_value_regex' = 'base|bonus|equity|allowance|overtime');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_component` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_component` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Description (CPD)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_description` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Status (CPS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compliance_equal_pay` SET TAGS ('dbx_business_glossary_term' = 'Equal Pay Compliance Flag (EPCF)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `equity_grant_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Eligibility (EGE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `equity_grant_type` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Type (EGT)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `equity_grant_type` SET TAGS ('dbx_value_regex' = 'stock_option|restricted_stock|rsu|phantom');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `equity_units` SET TAGS ('dbx_business_glossary_term' = 'Equity Units Granted (EUG)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `grade_step` SET TAGS ('dbx_business_glossary_term' = 'Grade Step (GS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (Country) (JUR)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Notes (CPNTS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency (PF)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'monthly|biweekly|weekly|quarterly|annually');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade (PG)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Code (CPC)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Name (CPN)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Type (CPT)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'salary|commission|bonus|equity|mixed');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `tax_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Status (TS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `tax_status` SET TAGS ('dbx_value_regex' = 'taxable|non_taxable|exempt');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `variable_pay_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Variable Pay Eligibility (VPE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `vesting_schedule` SET TAGS ('dbx_business_glossary_term' = 'Vesting Schedule Description (VSD)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'compensation_payroll');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `reversal_payroll_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Contribution Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_contribution_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_contribution_amount` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `other_employer_contributions_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Employer Contributions Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_cycle` SET TAGS ('dbx_business_glossary_term' = 'Pay Cycle');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_cycle` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|quarterly|annually');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pay Run Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|wire');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_status_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Status Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Number (PAYROLL_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_status` SET TAGS ('dbx_value_regex' = 'calculated|approved|paid|reversed|failed');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|bonus|commission|overtime');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pension_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Pension Contribution Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Social Security Contribution Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_contribution_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_contribution_amount` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` SET TAGS ('dbx_subdomain' = 'compensation_payroll');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `payroll_deduction_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Deduction ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `adjusted_payroll_deduction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount (USD)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `deduction_basis` SET TAGS ('dbx_business_glossary_term' = 'Deduction Basis');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `deduction_basis` SET TAGS ('dbx_value_regex' = 'flat|percentage');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `deduction_code` SET TAGS ('dbx_business_glossary_term' = 'Deduction Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `deduction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,5}$');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `deduction_description` SET TAGS ('dbx_business_glossary_term' = 'Deduction Description');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `deduction_quantity` SET TAGS ('dbx_business_glossary_term' = 'Deduction Quantity');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `deduction_rate` SET TAGS ('dbx_business_glossary_term' = 'Deduction Rate');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `deduction_type` SET TAGS ('dbx_business_glossary_term' = 'Deduction Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `deduction_type` SET TAGS ('dbx_value_regex' = 'federal_tax|state_tax|pension|health_insurance|garnishment|other');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `employer_match_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Match Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `is_post_tax` SET TAGS ('dbx_business_glossary_term' = 'Post‑Tax Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `is_pre_tax` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Tax Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `is_voluntary` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Deduction Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `legal_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Order Reference');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deduction Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `payroll_deduction_status` SET TAGS ('dbx_business_glossary_term' = 'Deduction Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `payroll_deduction_status` SET TAGS ('dbx_value_regex' = 'active|inactive|reversed|voided');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withheld Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_deduction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `prior_benefit_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_category` SET TAGS ('dbx_value_regex' = 'health|wellness|financial');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_currency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Currency');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|family');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_action` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Action');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_action` SET TAGS ('dbx_value_regex' = 'new|change|cancel|reactivate');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online|offline|mobile');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Reason');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'hr_portal|paper|broker|self_service');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending|canceled');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Enrollment Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `last_updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `payroll_cycle` SET TAGS ('dbx_business_glossary_term' = 'Payroll Cycle');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `payroll_cycle` SET TAGS ('dbx_value_regex' = 'monthly|biweekly|weekly|semi_monthly');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `payroll_deduction_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Deduction Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `post_tax_flag` SET TAGS ('dbx_business_glossary_term' = 'Post‑Tax Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `pre_tax_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Tax Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `taxability_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxability Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `original_leave_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `accrual_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Accrual Policy Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `approved_days` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Days');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Presence Indicator');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `entitlement_balance_at_approval` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Balance at Approval (Days)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `entitlement_balance_at_request` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Balance at Request (Days)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `extended_until_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Until Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_accrual` SET TAGS ('dbx_business_glossary_term' = 'Accrual Applied Indicator');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Leave Indicator');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_eligible` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Indicator');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_extended` SET TAGS ('dbx_business_glossary_term' = 'Extended Leave Indicator');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_paid_leave` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Indicator');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_partial_day` SET TAGS ('dbx_business_glossary_term' = 'Partial Day Indicator');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|in_progress');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `partial_day_type` SET TAGS ('dbx_business_glossary_term' = 'Partial Day Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `partial_day_type` SET TAGS ('dbx_value_regex' = 'morning|afternoon');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `remaining_balance_days` SET TAGS ('dbx_business_glossary_term' = 'Remaining Leave Balance (Days)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_source` SET TAGS ('dbx_value_regex' = 'portal|mobile|hr_system');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `total_requested_days` SET TAGS ('dbx_business_glossary_term' = 'Total Requested Leave Days');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `leave_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `carryover_leave_balance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'monthly|annual|hourly|custom');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `accrual_rate_per_month` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rate Per Month (Days)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `accrued_days` SET TAGS ('dbx_business_glossary_term' = 'Accrued Days');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `adjusted_days` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Days');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `balance_unit` SET TAGS ('dbx_business_glossary_term' = 'Balance Unit');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `balance_unit` SET TAGS ('dbx_value_regex' = 'days|hours');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `carried_forward_days` SET TAGS ('dbx_business_glossary_term' = 'Carried Forward Days');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `carryover_limit` SET TAGS ('dbx_business_glossary_term' = 'Carryover Limit (Days)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance (Days)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `forfeited_days` SET TAGS ('dbx_business_glossary_term' = 'Forfeited Days');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `is_eligible_for_carryover` SET TAGS ('dbx_business_glossary_term' = 'Carryover Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `is_paid_leave` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Taxable Leave Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `last_accrual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accrual Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `last_taken_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Taken Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `leave_balance_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `leave_balance_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'vacation|sick|personal|parental|bereavement|unpaid');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance (Days)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `policy_year` SET TAGS ('dbx_business_glossary_term' = 'Policy Year');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `statutory_minimum` SET TAGS ('dbx_business_glossary_term' = 'Statutory Minimum (Days)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `taken_days` SET TAGS ('dbx_business_glossary_term' = 'Taken Days');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`leave_balance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `prior_performance_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_group` SET TAGS ('dbx_business_glossary_term' = 'Calibration Group');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_score` SET TAGS ('dbx_business_glossary_term' = 'Calibration Score');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Action Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_action_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_action_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_change_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_change_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_change_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_change_type` SET TAGS ('dbx_value_regex' = 'raise|bonus|none');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_change_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_change_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_areas` SET TAGS ('dbx_business_glossary_term' = 'Employee Development Areas');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_department` SET TAGS ('dbx_business_glossary_term' = 'Employee Department');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_location` SET TAGS ('dbx_business_glossary_term' = 'Employee Location');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_position` SET TAGS ('dbx_business_glossary_term' = 'Employee Position');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `goals_achieved` SET TAGS ('dbx_business_glossary_term' = 'Goals Achieved');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `goals_set` SET TAGS ('dbx_business_glossary_term' = 'Goals Set');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `is_finalized` SET TAGS ('dbx_business_glossary_term' = 'Is Finalized Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_improvement_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_status` SET TAGS ('dbx_active' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_status` SET TAGS ('dbx_draft' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_status` SET TAGS ('dbx_submitted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_status` SET TAGS ('dbx_approved' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_status` SET TAGS ('dbx_rejected' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `rating_explanation` SET TAGS ('dbx_business_glossary_term' = 'Rating Explanation');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `rating_scale` SET TAGS ('dbx_value_regex' = '1-5|1-10|custom');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probation|pip');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_document_url` SET TAGS ('dbx_business_glossary_term' = 'Review Document URL');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_version` SET TAGS ('dbx_business_glossary_term' = 'Review Version');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `strengths` SET TAGS ('dbx_business_glossary_term' = 'Employee Strengths');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`performance_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_id` SET TAGS ('dbx_business_glossary_term' = 'Goal Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `objective_id` SET TAGS ('dbx_business_glossary_term' = 'Strategic Objective ID (SOID)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID (TID)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee ID (OEID)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID (TID)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `parent_goal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value (AV)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Goal Comments (GC)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Goal End Date (GED)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_business_glossary_term' = 'Goal Category (GC)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_value_regex' = 'individual|team|company_okr');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_description` SET TAGS ('dbx_business_glossary_term' = 'Goal Description (GD)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Status (GS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `is_calibrated` SET TAGS ('dbx_business_glossary_term' = 'Calibration Flag (CF)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag (MF)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `last_calibrated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Timestamp (LCT)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit (MU)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'count|percentage|currency|hours|points');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PL)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Goal Start Date (GSD)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `target_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Metric (TM)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value (TV)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Goal Title (GT)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `visibility` SET TAGS ('dbx_business_glossary_term' = 'Goal Visibility (GV)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `visibility` SET TAGS ('dbx_value_regex' = 'internal|public|restricted');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`goal` ALTER COLUMN `weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Goal Weight Percentage (GWP)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` SET TAGS ('dbx_subdomain' = 'compensation_payroll');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `headcount_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Headcount Record ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `prior_period_headcount_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `attrition_count` SET TAGS ('dbx_business_glossary_term' = 'Attrition Count');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `authorized_fte` SET TAGS ('dbx_business_glossary_term' = 'Authorized Full‑Time Equivalent (FTE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `filled_fte` SET TAGS ('dbx_business_glossary_term' = 'Filled Full‑Time Equivalent (FTE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `headcount_status` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `headcount_status` SET TAGS ('dbx_value_regex' = 'active|inactive');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `headcount_type` SET TAGS ('dbx_business_glossary_term' = 'Headcount Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `headcount_type` SET TAGS ('dbx_value_regex' = 'permanent|contractor|intern|temporary');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `new_hire_count` SET TAGS ('dbx_business_glossary_term' = 'New Hire Count');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`headcount` ALTER COLUMN `vacant_fte` SET TAGS ('dbx_business_glossary_term' = 'Vacant Full‑Time Equivalent (FTE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `role_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Role Assignment Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Manager Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `primary_role_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `primary_role_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `primary_role_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `superseded_role_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|acting|secondment|interim|temporary|contract');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `compensation_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `compensation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `compensation_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `compliance_training_completed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Completion Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'FTE Percentage');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `is_acting` SET TAGS ('dbx_business_glossary_term' = 'Acting Assignment Indicator');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Indicator');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `salary_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `salary_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `segregation_of_duties_flag` SET TAGS ('dbx_business_glossary_term' = 'Segregation of Duties Indicator');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `work_location_address` SET TAGS ('dbx_business_glossary_term' = 'Work Location Address');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `work_location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `work_location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`role_assignment` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `employment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Manager Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'HR Business Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `hr_business_partner_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `hr_business_partner_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `tertiary_employment_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'HR Business Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `tertiary_employment_hr_business_partner_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `tertiary_employment_hr_business_partner_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `corrected_employment_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `approval_chain` SET TAGS ('dbx_business_glossary_term' = 'Approval Chain');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Event Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `new_state_snapshot` SET TAGS ('dbx_business_glossary_term' = 'New State Snapshot');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `previous_state_snapshot` SET TAGS ('dbx_business_glossary_term' = 'Previous State Snapshot');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`employment_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `workforce_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Certification ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `renewed_workforce_certification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number (CERT_NUM)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type (CERT_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement (COMPLIANCE_REQ)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL (DOC_URL)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXPIRY_DATE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date (ISSUE_DATE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body (ISSUING_BODY)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp (VERIFIED_TS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag (MANDATORY_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status (RENEWAL_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'pending|renewed|expired|not_required');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `workforce_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `workforce_certification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked|suspended|pending');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainer ID (TRAINER_ID)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `primary_training_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID (EMPLOYEE_ID)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `primary_training_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `primary_training_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `retake_training_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score (ASSESSMENT_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date (COMPLETION_DATE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `cpe_credits` SET TAGS ('dbx_business_glossary_term' = 'CPE Credits Earned (CPE_CREDITS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method (DELIVERY_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'e_learning|instructor_led|virtual|on_the_job');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours (DURATION_HOURS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date (ENROLLMENT_DATE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number (ENROLLMENT_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRATION_DATE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location (LOCATION)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status (PASS_FAIL_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (REGULATORY_COMPLIANCE_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `regulatory_requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Name (REGULATORY_REQUIREMENT_NAME)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required (RENEWAL_REQUIRED)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category (TRAINING_CATEGORY)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'mandatory|compliance|technical|leadership|onboarding');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ENROLLMENT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|in_progress|completed|withdrawn|failed');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_program_code` SET TAGS ('dbx_business_glossary_term' = 'Training Program Code (TRAINING_PROGRAM_CODE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_program_name` SET TAGS ('dbx_business_glossary_term' = 'Training Program Name (TRAINING_PROGRAM_NAME)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `virtual_meeting_link` SET TAGS ('dbx_business_glossary_term' = 'Virtual Meeting Link (VIRTUAL_MEETING_LINK)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'HR Business Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `legal_counsel_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `primary_disciplinary_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `primary_disciplinary_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `primary_disciplinary_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_legal_counsel_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_legal_counsel_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_legal_counsel_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `escalated_from_disciplinary_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|appealed|closed|reversed');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'verbal_warning|written_warning|final_written_warning|suspension|demotion|termination');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'none|upheld|reversed|modified');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_applicable|filed|under_review|rejected|upheld');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_code` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_code` SET TAGS ('dbx_value_regex' = '^DA-[0-9]{6}$');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Action Duration (Days)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date of Action');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date of Action');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `investigation_reference` SET TAGS ('dbx_business_glossary_term' = 'Investigation Reference');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `is_appealable` SET TAGS ('dbx_business_glossary_term' = 'Is Appealable Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `is_suspended` SET TAGS ('dbx_business_glossary_term' = 'Is Suspended Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `supporting_document_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document URL');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `termination_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Effective Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `background_check_id` SET TAGS ('dbx_business_glossary_term' = 'Background Check ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Screening Provider Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `recheck_background_check_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `adjudication_outcome` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Outcome');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `adjudication_outcome` SET TAGS ('dbx_value_regex' = 'clear|flagged|failed|pending|escalated');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed|rejected');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `check_name` SET TAGS ('dbx_business_glossary_term' = 'Background Check Name');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Background Check Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `check_type` SET TAGS ('dbx_business_glossary_term' = 'Background Check Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `check_type` SET TAGS ('dbx_value_regex' = 'criminal|credit|employment|education|sanctions|reference');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `component_results` SET TAGS ('dbx_business_glossary_term' = 'Component Results');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `flagged_issues` SET TAGS ('dbx_business_glossary_term' = 'Flagged Issues');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Initiation Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `is_periodic` SET TAGS ('dbx_business_glossary_term' = 'Periodic Check Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Background Check Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Result');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'clear|flagged|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `provider_code` SET TAGS ('dbx_business_glossary_term' = 'Screening Provider Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Screening Provider Name');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `result_date` SET TAGS ('dbx_business_glossary_term' = 'Result Determination Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`background_check` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `work_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `superseded_work_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Minutes)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `compliance_overtime_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Threshold Hours per Week');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (yyyy‑MM‑dd)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (yyyy‑MM‑dd)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `flexible_flag` SET TAGS ('dbx_business_glossary_term' = 'Flexibility Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code (ISO 3166‑1 alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `labor_cost_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Rate per Hour (Currency)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `on_call_flag` SET TAGS ('dbx_business_glossary_term' = 'On‑Call Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `rest_period_minutes` SET TAGS ('dbx_business_glossary_term' = 'Rest Period (Minutes)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Name');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Type (Standard, Shift, Compressed, Flexible, On‑Call, Rotating)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'standard|shift|compressed|flexible|on_call|rotating');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern Description');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone (IANA Identifier)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `weekly_hours` SET TAGS ('dbx_business_glossary_term' = 'Weekly Working Hours (Hours)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type (Office, Remote, Hybrid, Field)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'office|remote|hybrid|field');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `work_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `work_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `work_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'compensation_payroll');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `adjusted_time_entry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `billable_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Billable Rate Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `billable_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Billable Rate Currency');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `billable_rate_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Minutes)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock‑In Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock‑Out Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Entry Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|holiday|on_call|travel');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `total_billable_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Billable Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `total_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `workforce_location_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Location Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `parent_location_workforce_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Location Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `timezone_id` SET TAGS ('dbx_business_glossary_term' = 'Timezone Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `parent_workforce_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `capacity_people` SET TAGS ('dbx_business_glossary_term' = 'People Capacity');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Location Email Address');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `floor_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Floor Area (sq ft)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `is_remote_work_allowed` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Allowed Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `is_virtual_location` SET TAGS ('dbx_business_glossary_term' = 'Virtual Location Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Degrees)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'headquarters|regional_office|branch|data_center|remote_home');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Degrees)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `payroll_tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Tax Exempt Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Location Phone Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^[+]?d{1,15}$');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9 -]{3,10}$');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `regulated_premises_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulated Premises Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `workforce_location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `workforce_location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `workforce_location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`workforce_location` ALTER COLUMN `workforce_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `hr_case_id` SET TAGS ('dbx_business_glossary_term' = 'HR Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned HR Business Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `primary_assigned_hr_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned HR Business Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `primary_assigned_hr_partner_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `primary_assigned_hr_partner_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `related_hr_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|resolved|escalated|closed');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'grievance|harassment|whistleblower|accommodation|policy_violation|investigation');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'level1|level2|level3|level4');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `legal_counsel_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Involvement Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Opened Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `related_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Related Policy Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_business_glossary_term' = 'Resolution Monetary Amount');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'dismissal|reinstatement|disciplinary_action|training|policy_change|no_action');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'email|phone|portal|in_person|hr_system');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`hr_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `succession_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Manager Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Target Role Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Target Role Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_succession_successor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Successor Employee Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_succession_successor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_succession_successor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `target_role_position_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `superseded_succession_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `development_actions` SET TAGS ('dbx_business_glossary_term' = 'Development Actions');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Name');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_review_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `readiness_timeline` SET TAGS ('dbx_business_glossary_term' = 'Readiness Timeline');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `readiness_timeline` SET TAGS ('dbx_value_regex' = 'ready_now|1-2_years|3-5_years');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Retention Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `succession_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `succession_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `successor_name` SET TAGS ('dbx_business_glossary_term' = 'Successor Employee Name');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `successor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `successor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `target_role_title` SET TAGS ('dbx_business_glossary_term' = 'Target Role Title');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`succession_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` SET TAGS ('dbx_subdomain' = 'compensation_payroll');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `equity_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Equity Plan Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `superseded_equity_grant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `cliff_months` SET TAGS ('dbx_business_glossary_term' = 'Cliff Vesting Period (Months)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `exercise_price` SET TAGS ('dbx_business_glossary_term' = 'Exercise Price');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `fully_vested_date` SET TAGS ('dbx_business_glossary_term' = 'Fully Vested Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `graded_vesting_months` SET TAGS ('dbx_business_glossary_term' = 'Graded Vesting Period (Months)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `grant_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Number');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `grant_price` SET TAGS ('dbx_business_glossary_term' = 'Grant Fair Market Value (FMV)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_value_regex' = 'outstanding|partially_vested|fully_vested|exercised|forfeited|expired');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `grant_type` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `grant_type` SET TAGS ('dbx_value_regex' = 'ISO|NSO|RSU|ESPP|Phantom');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `is_approved` SET TAGS ('dbx_business_glossary_term' = 'Approval Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grant Notes');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `performance_actual` SET TAGS ('dbx_business_glossary_term' = 'Performance Actual Value');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `performance_target` SET TAGS ('dbx_business_glossary_term' = 'Performance Target Value');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Rate');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `units_granted` SET TAGS ('dbx_business_glossary_term' = 'Units Granted');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `vesting_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Vesting Schedule Type');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `vesting_schedule_type` SET TAGS ('dbx_value_regex' = 'cliff|graded|performance');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`equity_grant` ALTER COLUMN `vesting_start_date` SET TAGS ('dbx_business_glossary_term' = 'Vesting Start Date');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Compliance Record ID');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Employee ID (RESPONSIBLE_OWNER_ID)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `responsible_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Employee ID (RESPONSIBLE_OWNER_ID)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `superseded_compliance_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `audit_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary (AUDIT_FINDINGS_SUMMARY)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID (AUDIT_TRAIL_ID)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date (COMPLETION_DATE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `compliance_record_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `compliance_record_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|pending_review');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy (DATA_RETENTION_POLICY)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_value_regex' = 'retain_5_years|retain_7_years|retain_indefinite');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date (DUE_DATE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `evidence_document_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document URL (EVIDENCE_DOCUMENT_URL)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `is_external_regulation` SET TAGS ('dbx_business_glossary_term' = 'Is External Regulation Flag (IS_EXTERNAL_REGULATION)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag (IS_MANDATORY)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code (JURISDICTION_CODE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `last_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Status (LAST_AUDIT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `last_audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LAST_REVIEW_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Number (OBLIGATION_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Type (OBLIGATION_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'right_to_work|i9_verification|license_reporting|fit_and_proper|pay_equity_audit|eeo1_filing');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework (REGULATORY_FRAMEWORK)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'US|EU|UK|AU|CA|SG');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `remediation_action_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Required (REMEDIATION_ACTION_REQUIRED)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date (REMEDIATION_DUE_DATE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status (REMEDIATION_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency (REPORTING_FREQUENCY)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|ad_hoc');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'HRIS|CompliancePlatform|Manual');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`compliance_record` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`objective` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`objective` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`objective` ALTER COLUMN `objective_id` SET TAGS ('dbx_business_glossary_term' = 'Objective Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`objective` ALTER COLUMN `parent_objective_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `provider_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `provider_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `provider_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `provider_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`timesheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`timesheet` SET TAGS ('dbx_subdomain' = 'compensation_payroll');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`timesheet` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`timesheet` ALTER COLUMN `amended_timesheet_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_period` SET TAGS ('dbx_subdomain' = 'compensation_payroll');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_period` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_period` ALTER COLUMN `prior_payroll_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`team` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`team` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`team` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'compensation_payroll');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`payroll_run` ALTER COLUMN `rerun_payroll_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`strategy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`strategy` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`strategy` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Strategy Identifier');
ALTER TABLE `payments_fintech_ecm`.`workforce`.`strategy` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
