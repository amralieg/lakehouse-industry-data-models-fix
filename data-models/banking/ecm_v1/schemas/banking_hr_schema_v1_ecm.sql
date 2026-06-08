-- Schema for Domain: hr | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`hr` COMMENT 'Human capital management covering employee master data, payroll, benefits administration, talent acquisition, performance management, compensation, workforce planning, and regulatory headcount reporting. Supports SOX HR controls and labor compliance. Primary system of record aligned with Workday / SAP SuccessFactors.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique system identifier for the employee record. Primary key for the employee entity.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Employee base compensation denominated in specific currency. Required for multi-currency payroll processing, FX exposure management, compensation expense reporting, and expatriate compensation trackin',
    `hr_position_id` BIGINT COMMENT 'Foreign key linking to hr.hr_position. Business justification: Employees are assigned to authorized positions. The hr_position table is the SSOT for position title, job code, job family, job level, and organizational placement. Adding this FK allows normalization',
    `manager_employee_id` BIGINT COMMENT 'Employee ID of the individuals direct manager or supervisor. Establishes reporting hierarchy for organizational structure and approval workflows.',
    `background_check_completion_date` DATE COMMENT 'Date the most recent background check was completed. Required for regulatory compliance and SOX critical roles.',
    `background_check_status` STRING COMMENT 'Current status of the employees background check. Cleared status is required before granting system access for SOX-critical roles.. Valid values are `cleared|pending|failed|not_required`',
    `contract_end_date` DATE COMMENT 'Scheduled end date for fixed-term contracts. Null for permanent employees. Triggers contract renewal or termination workflows.',
    `contract_governing_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the employment contract (e.g., State of New York, England and Wales). Determines applicable labor regulations and dispute resolution venue.',
    `contract_notice_period_days` STRING COMMENT 'Number of days of notice required by either party to terminate the employment contract. Varies by jurisdiction and seniority level.',
    `contracted_hours_per_week` DECIMAL(18,2) COMMENT 'Standard number of hours per week the employee is contracted to work. Used for FTE (Full-Time Equivalent) calculations and overtime determination.',
    `cost_center_code` STRING COMMENT 'Financial accounting cost center to which the employees compensation and benefits are charged. Used for budgeting and financial reporting.',
    `department_name` STRING COMMENT 'Name of the organizational department or unit to which the employee is assigned.',
    `division_name` STRING COMMENT 'Name of the business division or line of business (LOB) to which the employee belongs (e.g., Retail Banking, Investment Banking, Wealth Management).',
    `email_address` STRING COMMENT 'Primary corporate email address assigned to the employee for business communication and system access.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employee_number` STRING COMMENT 'Human-readable unique employee identifier assigned by HR system. Used for payroll, timekeeping, and external reporting. Aligned with Workday/SAP SuccessFactors Employee ID field.. Valid values are `^[A-Z0-9]{6,12}$`',
    `employment_basis` STRING COMMENT 'Full-time or part-time classification of the employee. Impacts benefit eligibility, FMLA qualification, and regulatory headcount calculations.. Valid values are `full_time|part_time|casual|seasonal`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee within the organization. Drives access provisioning, payroll processing, and regulatory headcount reporting.. Valid values are `active|leave_of_absence|suspended|terminated|retired|deceased`',
    `employment_type` STRING COMMENT 'Classification of the employment contract type. Determines benefit eligibility, regulatory reporting treatment, and labor law compliance requirements.. Valid values are `permanent|fixed_term|contractor|secondment|intern|temporary`',
    `flsa_classification` STRING COMMENT 'Classification under FLSA determining overtime eligibility. Exempt employees are not eligible for overtime pay; non-exempt employees are.. Valid values are `exempt|non_exempt`',
    `fmla_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee meets FMLA eligibility criteria (12 months tenure, 1,250 hours worked, worksite with 50+ employees within 75 miles).',
    `hire_date` DATE COMMENT 'Date the employee commenced employment with the organization. Used for tenure calculations, vesting schedules, and FMLA eligibility determination.',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles (e.g., Technology, Risk Management, Investment Banking). Used for talent management and succession planning.',
    `job_level` STRING COMMENT 'Hierarchical level or grade of the position within the organizations job architecture (e.g., Analyst, Associate, Vice President, Managing Director).',
    `legal_entity_code` STRING COMMENT 'Code identifying the legal entity that employs the individual. Critical for regulatory reporting, tax compliance, and legal liability determination.',
    `legal_first_name` STRING COMMENT 'Employees legal first name as it appears on government-issued identification. Used for regulatory reporting, payroll tax forms, and compliance documentation.',
    `legal_last_name` STRING COMMENT 'Employees legal last name (surname) as it appears on government-issued identification. Used for regulatory reporting and payroll compliance.',
    `legal_middle_name` STRING COMMENT 'Employees legal middle name or initial as it appears on government-issued identification.',
    `mobile_phone_number` STRING COMMENT 'Personal or corporate mobile phone number for emergency contact and business communication.',
    `original_hire_date` DATE COMMENT 'Original date of hire if employee was rehired after a break in service. Used for benefit vesting and seniority calculations that recognize prior service.',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in day-to-day business interactions. May differ from legal name.',
    `pto_accrual_rate_hours_per_month` DECIMAL(18,2) COMMENT 'Rate at which the employee accrues PTO hours each month. Typically varies by tenure and job level.',
    `pto_balance_hours` DECIMAL(18,2) COMMENT 'Current balance of accrued but unused paid time off hours available to the employee. Updated with each accrual and usage transaction.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the HR system. Used for audit trail and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last modified. Used for audit trail and change tracking.',
    `regulatory_headcount_flag` BOOLEAN COMMENT 'Indicates whether this employee is included in regulatory headcount reporting to FDIC, Federal Reserve, and other banking regulators. Excludes contractors and certain temporary workers.',
    `rehire_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire based on termination circumstances and performance history.',
    `sox_critical_role_flag` BOOLEAN COMMENT 'Indicates whether the employee holds a role subject to SOX HR control requirements (e.g., financial reporting, IT general controls, access provisioning). Triggers enhanced background checks and segregation of duties reviews.',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Null for active employees. Triggers final payroll processing, benefit termination, and access revocation.',
    `termination_reason` STRING COMMENT 'Primary reason for employment termination. Used for turnover analysis, unemployment claims, and regulatory reporting.. Valid values are `voluntary_resignation|involuntary_termination|retirement|end_of_contract|layoff|death`',
    `work_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the employee primarily works. Determines applicable labor laws and tax jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `work_location_code` STRING COMMENT 'Code identifying the primary physical work location or office where the employee is based. Used for space planning and emergency response.',
    `work_phone_number` STRING COMMENT 'Primary business phone number for the employee, including extension if applicable.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Core master entity representing all bank employees, contractors, and contingent workers. Captures full employment profile including personal details, employment status, job classification, cost center assignment, legal entity, work location, hire date, termination date, and regulatory headcount attributes. Also captures employment contract terms including contract type (permanent, fixed-term, contractor, secondment), notice period, governing jurisdiction, employment basis (full-time, part-time, casual), contracted hours, regulatory disclosures, and absence/leave entitlements (FMLA eligibility, PTO balance, leave history). Serves as the SSOT for workforce identity, employment terms, and leave management across all HR sub-domains. Aligned with Workday/SAP SuccessFactors Employee Central module. Supports SOX HR controls, FDIC headcount reporting, FMLA compliance tracking, labor law compliance, and audit trail for workforce agreements.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`hr_position` (
    `hr_position_id` BIGINT COMMENT 'Unique identifier for the authorized headcount position within the organizational hierarchy.',
    `job_profile_id` BIGINT COMMENT 'Reference to the standardized job profile that defines the role template, competencies, and classification for this position.',
    `work_location_id` BIGINT COMMENT 'Reference to the primary work location or office where this position is based.',
    `org_unit_id` BIGINT COMMENT 'Reference to the business unit or division to which this position is assigned, used for organizational hierarchy and reporting.',
    `reporting_position_hr_position_id` BIGINT COMMENT 'Reference to the supervisory position to which this position reports, establishing the organizational reporting line.',
    `budget_approval_date` DATE COMMENT 'The date on which the budget for this position was approved by the Asset-Liability Committee (ALCO) or finance leadership.',
    `ccar_stress_scenario_flag` BOOLEAN COMMENT 'Indicates whether this position is included in CCAR/DFAST headcount stress testing scenarios for regulatory capital planning.',
    `competency_profile` STRING COMMENT 'Reference to the competency framework or skill profile associated with this position, defining required technical and behavioral competencies.',
    `cost_center_code` STRING COMMENT 'The cost center to which this positions compensation and benefits expenses are allocated for financial reporting and budgeting.. Valid values are `^[0-9]{4,10}$`',
    `created_by_user` STRING COMMENT 'The user identifier of the HR professional or system administrator who created this position record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this position record was first created in the Human Capital Management (HCM) system.',
    `critical_role_flag` BOOLEAN COMMENT 'Indicates whether this position is designated as business-critical for operational resilience and succession planning purposes.',
    `effective_date` DATE COMMENT 'The date on which this position was officially authorized and became active in the organizational structure.',
    `end_date` DATE COMMENT 'The date on which this position is scheduled to be closed or eliminated, if applicable. Null for ongoing positions.',
    `filled_date` DATE COMMENT 'The date on which this position was most recently filled by an employee assignment. Null if currently vacant.',
    `flsa_classification` STRING COMMENT 'Classification under the Fair Labor Standards Act indicating whether the position is exempt or non-exempt from overtime pay requirements.. Valid values are `exempt|non_exempt`',
    `fte_authorization` DECIMAL(18,2) COMMENT 'The authorized full-time equivalent allocation for this position, typically 1.00 for full-time, 0.50 for half-time, etc. Used in workforce planning and headcount reporting.',
    `grade_band` STRING COMMENT 'The compensation grade or band assigned to this position, determining the salary range and benefits eligibility.. Valid values are `^[A-Z0-9]{1,5}$`',
    `job_family` STRING COMMENT 'The broad occupational category or job family to which this position belongs, used for talent management and career pathing.',
    `job_level` STRING COMMENT 'The hierarchical level of the position within the job family, indicating seniority and scope of responsibility.',
    `justification` STRING COMMENT 'Business rationale or justification for the creation or continuation of this position, used for budget approval and workforce planning.',
    `last_modified_by_user` STRING COMMENT 'The user identifier of the HR professional or system administrator who most recently modified this position record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this position record was most recently updated in the Human Capital Management (HCM) system.',
    `material_risk_taker_flag` BOOLEAN COMMENT 'Indicates whether this position is classified as a Material Risk Taker under CRD IV/EBA guidelines, requiring enhanced regulatory oversight and compensation controls.',
    `minimum_education_level` STRING COMMENT 'The minimum educational qualification required for this position as defined in the job profile.. Valid values are `high_school|associate|bachelor|master|doctorate|professional`',
    `position_code` STRING COMMENT 'Business identifier for the position, typically used in workforce planning and organizational charts. Unique across the enterprise.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_status` STRING COMMENT 'Current lifecycle status of the position indicating whether it is available for hiring, currently occupied, temporarily frozen, or permanently closed.. Valid values are `open|filled|frozen|closed`',
    `regulatory_role_flag` BOOLEAN COMMENT 'Indicates whether this position has regulatory significance requiring special reporting, such as senior management functions under Federal Reserve or OCC oversight.',
    `remote_eligible_flag` BOOLEAN COMMENT 'Indicates whether this position is eligible for remote or hybrid work arrangements per organizational policy.',
    `required_certifications` STRING COMMENT 'List of professional certifications or licenses required for this position, such as CFA, CPA, Series 7, or other industry-specific credentials.',
    `source_system` STRING COMMENT 'The operational system of record from which this position data originated, typically Workday or SAP SuccessFactors.. Valid values are `workday|sap_successfactors|oracle_hcm|manual`',
    `source_system_code` STRING COMMENT 'The unique identifier for this position in the source Human Capital Management (HCM) system, used for data lineage and reconciliation.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this position is subject to SOX HR controls due to access to financial systems or involvement in financial reporting processes.',
    `succession_plan_flag` BOOLEAN COMMENT 'Indicates whether this position has an active succession plan in place, identifying potential internal candidates for future filling.',
    `target_fill_date` DATE COMMENT 'The planned or target date by which this open position should be filled, used for workforce planning and recruitment tracking.',
    `title` STRING COMMENT 'The official title of the position as it appears in organizational documentation and workforce planning systems.',
    `travel_requirement_pct` DECIMAL(18,2) COMMENT 'The expected percentage of time this position requires business travel, used for workforce planning and candidate expectations.',
    `union_eligible_flag` BOOLEAN COMMENT 'Indicates whether this position is eligible for union membership or covered by collective bargaining agreements.',
    `vacancy_posted_date` DATE COMMENT 'The date on which this position was posted as a vacancy for recruitment, if currently open.',
    `years_experience_required` STRING COMMENT 'The minimum number of years of relevant professional experience required for this position.',
    CONSTRAINT pk_hr_position PRIMARY KEY(`hr_position_id`)
) COMMENT 'Authorized headcount position and job profile master representing approved roles within the organizational hierarchy and the banks standardized job catalog. On the position side, captures position title, grade band, FTE authorization, business unit, cost center, reporting line, open/filled status, and workforce planning attributes. On the job profile side, captures job code, job family, job level, FLSA classification (exempt/non-exempt), regulatory role flag (e.g., Material Risk Taker under CRD IV/EBA guidelines), required qualifications, competency framework linkage, and compensation grade band. A position may be vacant, filled, or frozen. Supports CCAR/DFAST headcount stress testing, regulatory workforce reporting, and serves as the template from which employee assignments are derived.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Org unit operates in specific country. Required for regulatory reporting (country-by-country), tax compliance, labor law application, jurisdictional risk aggregation, and Basel Pillar 3 disclosures in',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy. Null for top-level entities. Enables multi-level org hierarchy traversal for management reporting and cost allocation.',
    `alco_reporting` BOOLEAN COMMENT 'Indicates whether this unit is included in ALCO reporting for asset-liability management and liquidity risk monitoring.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual operating budget allocated to the organizational unit in the base currency. Used for financial planning and variance analysis.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget amount.. Valid values are `^[A-Z]{3}$`',
    `closure_date` DATE COMMENT 'Date when the organizational unit was closed or dissolved. Null for active units.',
    `closure_reason` STRING COMMENT 'Business reason or justification for closing the organizational unit. Used for audit trail and governance.',
    `contact_email` STRING COMMENT 'Primary email address for organizational unit inquiries and official communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for organizational unit contact.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system. Used for audit trail and data lineage.',
    `effective_from_date` DATE COMMENT 'Date from which this organizational unit configuration becomes effective. Supports temporal hierarchy queries.',
    `effective_to_date` DATE COMMENT 'Date until which this organizational unit configuration remains effective. Null for currently active units. Supports temporal hierarchy queries and historical analysis.',
    `establishment_date` DATE COMMENT 'Date when the organizational unit was originally established or incorporated.',
    `gl_cost_center_code` STRING COMMENT 'General Ledger cost center code for financial accounting and Funds Transfer Pricing (FTP) allocation. Links organizational unit to GL hierarchy.. Valid values are `^[A-Z0-9]{4,12}$`',
    `headcount_fte` DECIMAL(18,2) COMMENT 'Current full-time equivalent headcount allocated to this organizational unit. Used for workforce planning and regulatory headcount reporting.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this unit in the organizational hierarchy tree. Level 1 represents top-level entities. Used for hierarchy traversal optimization.',
    `hierarchy_path` STRING COMMENT 'Materialized path representing the full lineage from root to this unit (e.g., /1/5/23/). Enables efficient ancestor and descendant queries.',
    `is_profit_center` BOOLEAN COMMENT 'Indicates whether this organizational unit is designated as a profit center for financial performance measurement and P&L attribution.',
    `is_regulatory_entity` BOOLEAN COMMENT 'Indicates whether this unit is a separately regulated legal entity requiring independent regulatory reporting (CCAR, DFAST, Basel III).',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the primary legal jurisdiction of the organizational unit. Used for regulatory reporting and compliance segmentation.. Valid values are `^[A-Z]{3}$`',
    `lei` STRING COMMENT 'ISO 17442 Legal Entity Identifier for regulatory reporting. Required for legal entities engaged in financial transactions. Used in CCAR, DFAST, and Basel III reporting.. Valid values are `^[A-Z0-9]{20}$`',
    `lob` STRING COMMENT 'Primary line of business classification for regulatory capital allocation and RAROC calculation. Used in CCAR and stress testing.. Valid values are `retail_banking|investment_banking|wealth_management|treasury|risk_management|operations`',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units purpose, responsibilities, and scope of operations.',
    `physical_address` STRING COMMENT 'Physical location address of the organizational units primary office or headquarters.',
    `region` STRING COMMENT 'Geographic region classification for management reporting and regional performance analysis.',
    `regulatory_segment` STRING COMMENT 'Regulatory classification for capital adequacy and risk-weighted asset (RWA) calculation under Basel III framework.. Valid values are `banking_book|trading_book|off_balance_sheet|other`',
    `sox_scope` BOOLEAN COMMENT 'Indicates whether this organizational unit is within the scope of SOX 404 internal controls testing and certification.',
    `unit_code` STRING COMMENT 'Business identifier code for the organizational unit. Used in external reporting and system integrations.. Valid values are `^[A-Z0-9]{2,20}$`',
    `unit_name` STRING COMMENT 'Full legal or business name of the organizational unit.',
    `unit_short_name` STRING COMMENT 'Abbreviated name or acronym for the organizational unit used in reports and displays.',
    `unit_status` STRING COMMENT 'Current operational status of the organizational unit in its lifecycle.. Valid values are `active|inactive|pending|closed`',
    `unit_type` STRING COMMENT 'Classification of the organizational unit within the hierarchy structure. Determines reporting and governance requirements.. Valid values are `legal_entity|division|department|cost_center|team|branch`',
    `updated_by_user` STRING COMMENT 'User identifier or system account that last modified this organizational unit record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit hierarchy master representing the banks legal entities, divisions, departments, cost centers, and teams. Captures unit name, unit type (legal entity, division, department, team), parent unit, effective dates, GL cost center code, regulatory entity identifier (LEI), and active status. Supports multi-level org hierarchy traversal for management reporting, FTP allocation, and regulatory headcount segmentation.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Unique identifier for the payroll record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee for whom this payroll record was generated. Links to the employee master data in the HR system.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the GL journal entry generated from this payroll record for financial accounting integration.',
    `payroll_run_id` BIGINT COMMENT 'Reference to the payroll batch run that generated this record. Used for grouping all payroll records processed in the same cycle.',
    `allowance_amount` DECIMAL(18,2) COMMENT 'Total allowances paid during this pay period, such as housing, transportation, or meal allowances.',
    `bank_account_number` STRING COMMENT 'Employee bank account number for direct deposit. Encrypted and restricted access for payroll processing only.',
    `bank_account_type` STRING COMMENT 'Type of bank account for direct deposit (checking or savings).. Valid values are `checking|savings`',
    `bank_routing_number` STRING COMMENT 'Nine-digit ABA routing number identifying the financial institution for direct deposit.. Valid values are `^[0-9]{9}$`',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The base salary or regular wages earned during the pay period, excluding overtime, bonuses, and other supplemental pay.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Discretionary or performance-based bonus paid during this pay period.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Sales commission or incentive compensation earned during this pay period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payroll record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dental_insurance_premium` DECIMAL(18,2) COMMENT 'Employee portion of dental insurance premium deducted from gross pay.',
    `federal_income_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of federal income tax withheld from gross pay based on employee W-4 elections.',
    `fsa_contribution` DECIMAL(18,2) COMMENT 'Employee pre-tax contribution to Flexible Spending Account (FSA) for healthcare or dependent care expenses.',
    `garnishment_amount` DECIMAL(18,2) COMMENT 'Court-ordered wage garnishment deducted from net pay for child support, tax levies, or other legal obligations.',
    `gl_posting_date` DATE COMMENT 'The date on which this payroll record was posted to the General Ledger for financial reporting.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total gross pay before any deductions, including base salary, overtime, bonuses, commissions, and allowances.',
    `health_insurance_premium` DECIMAL(18,2) COMMENT 'Employee portion of health insurance premium deducted from gross pay, typically pre-tax under Section 125 cafeteria plan.',
    `hsa_contribution` DECIMAL(18,2) COMMENT 'Employee pre-tax contribution to Health Savings Account (HSA) deducted from gross pay.',
    `loan_repayment_amount` DECIMAL(18,2) COMMENT 'Employee loan repayment deducted from net pay for company-issued loans or advances.',
    `local_income_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of local or municipal income tax withheld from gross pay, if applicable.',
    `medicare_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of Medicare tax (FICA) withheld from gross pay, calculated as 1.45% of all wages, plus additional 0.9% for high earners.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Final take-home pay after all pre-tax deductions, tax withholdings, and post-tax deductions. This is the amount disbursed to the employee.',
    `other_posttax_deductions` DECIMAL(18,2) COMMENT 'Sum of all other post-tax deductions not otherwise categorized, such as union dues, charitable contributions, or Roth 401k.',
    `other_pretax_deductions` DECIMAL(18,2) COMMENT 'Sum of all other pre-tax deductions not otherwise categorized, such as commuter benefits or supplemental insurance.',
    `overtime_amount` DECIMAL(18,2) COMMENT 'Total overtime pay earned during the pay period, typically calculated at 1.5x or 2x the regular hourly rate.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total number of overtime hours worked during the pay period.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid (weekly, bi-weekly, semi-monthly, monthly).. Valid values are `weekly|bi-weekly|semi-monthly|monthly`',
    `pay_period_end_date` DATE COMMENT 'The last day of the pay period covered by this payroll record.',
    `pay_period_start_date` DATE COMMENT 'The first day of the pay period covered by this payroll record.',
    `payment_date` DATE COMMENT 'The date on which the net pay was or will be disbursed to the employee.',
    `payment_method` STRING COMMENT 'Method by which net pay is disbursed to the employee (direct deposit, physical check, cash, or payroll card).. Valid values are `direct_deposit|check|cash|payroll_card`',
    `payroll_status` STRING COMMENT 'Current processing status of this payroll record in the payroll lifecycle.. Valid values are `draft|approved|processed|paid|voided|reversed`',
    `retirement_contribution_pretax` DECIMAL(18,2) COMMENT 'Employee pre-tax contribution to retirement plan (401k, 403b) deducted from gross pay before tax calculation.',
    `social_security_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of Social Security tax (FICA) withheld from gross pay, calculated as 6.2% of wages up to the annual wage base limit.',
    `state_income_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of state income tax withheld from gross pay based on state tax regulations and employee elections.',
    `total_posttax_deductions` DECIMAL(18,2) COMMENT 'Sum of all post-tax deductions including garnishments, loan repayments, and other voluntary deductions.',
    `total_pretax_deductions` DECIMAL(18,2) COMMENT 'Sum of all pre-tax deductions including retirement, health insurance, HSA, FSA, and other pre-tax benefits.',
    `total_tax_withheld` DECIMAL(18,2) COMMENT 'Sum of all tax withholdings including federal, state, local, Social Security, and Medicare taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll record was last modified.',
    `vision_insurance_premium` DECIMAL(18,2) COMMENT 'Employee portion of vision insurance premium deducted from gross pay.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Payroll processing record capturing the periodic gross-to-net pay calculation for each employee. Includes pay period, gross pay, base salary, overtime, allowances, pre-tax deductions (401k, HSA, FSA), tax withholdings (federal, state, FICA), net pay, payment method, bank account details for direct deposit, and payroll run identifier. Supports SOX payroll controls, IRS Form W-2 preparation, and GL payroll journal entry generation.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`compensation_event` (
    `compensation_event_id` BIGINT COMMENT 'Unique identifier for the compensation event record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this compensation event.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Stock-based compensation (options, RSUs, performance shares) is core to banking compensation, especially for material risk takers. Links compensation events to specific equity instruments (typically b',
    `primary_compensation_employee_id` BIGINT COMMENT 'Reference to the employee receiving the compensation change.',
    `annual_review_cycle_year` STRING COMMENT 'The calendar year of the annual compensation review cycle to which this event belongs.',
    `approval_level` STRING COMMENT 'The organizational level required to approve this compensation event based on materiality and policy thresholds.. Valid values are `manager|director|vp|svp|ceo|board`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the compensation event was approved by the designated approver.',
    `bonus_award_amount` DECIMAL(18,2) COMMENT 'The monetary value of a discretionary or performance-based bonus awarded in this event, in the specified currency.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the compensation change (e.g., annual review, market adjustment, role change).',
    `change_reason_description` STRING COMMENT 'Detailed narrative explanation of the business rationale for the compensation change.',
    `comments` STRING COMMENT 'Free-text field for additional notes, context, or special instructions related to the compensation event.',
    `compa_ratio` DECIMAL(18,2) COMMENT 'The ratio of the employees new base salary to the pay range midpoint, expressed as a percentage, indicating position within the salary band.',
    `cost_center_code` STRING COMMENT 'The cost center to which the compensation expense for this event is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compensation event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this compensation event.. Valid values are `^[A-Z]{3}$`',
    `deferred_compensation_amount` DECIMAL(18,2) COMMENT 'The amount of compensation deferred to future periods as part of this event, in the specified currency.',
    `event_effective_date` DATE COMMENT 'The date on which the compensation change becomes effective for payroll and financial reporting purposes.',
    `event_number` STRING COMMENT 'Business-facing unique identifier for the compensation event, used for tracking and audit purposes.',
    `event_status` STRING COMMENT 'Current lifecycle status of the compensation event in the approval and processing workflow.. Valid values are `draft|pending_approval|approved|rejected|processed|cancelled`',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when the compensation event was initiated or recorded in the system.',
    `event_type` STRING COMMENT 'Classification of the compensation change event. [ENUM-REF-CANDIDATE: merit_increase|promotion|equity_adjustment|off_cycle_adjustment|bonus_award|stock_option_grant|deferred_compensation|base_salary_change|incentive_award|retention_bonus|long_term_incentive|sign_on_bonus|severance|allowance — promote to reference product]',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which the compensation expense is posted.',
    `lob` STRING COMMENT 'The business unit or line of business to which the employee belongs at the time of this compensation event.',
    `material_risk_taker_flag` BOOLEAN COMMENT 'Indicates whether the employee is classified as a Material Risk Taker under EBA/PRA remuneration regulations, requiring enhanced disclosure and deferral rules.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compensation event record was last modified.',
    `new_base_salary` DECIMAL(18,2) COMMENT 'The employees base salary amount after this compensation event, in the specified currency.',
    `new_lti_value` DECIMAL(18,2) COMMENT 'The value of the employees long-term incentive award after this event, in the specified currency.',
    `new_target_bonus_pct` DECIMAL(18,2) COMMENT 'The employees target short-term incentive bonus as a percentage of base salary after this event.',
    `pay_range_maximum` DECIMAL(18,2) COMMENT 'The maximum salary value for the assigned salary grade, in the specified currency.',
    `pay_range_midpoint` DECIMAL(18,2) COMMENT 'The midpoint salary value for the assigned salary grade, in the specified currency.',
    `pay_range_minimum` DECIMAL(18,2) COMMENT 'The minimum salary value for the assigned salary grade, in the specified currency.',
    `performance_rating` STRING COMMENT 'The employees performance rating that influenced this compensation event, typically from the annual review cycle.. Valid values are `exceeds|meets|below|unsatisfactory`',
    `prior_base_salary` DECIMAL(18,2) COMMENT 'The employees base salary amount before this compensation event, in the specified currency.',
    `prior_lti_value` DECIMAL(18,2) COMMENT 'The value of the employees long-term incentive award before this event, in the specified currency.',
    `prior_target_bonus_pct` DECIMAL(18,2) COMMENT 'The employees target short-term incentive bonus as a percentage of base salary before this event.',
    `processed_timestamp` TIMESTAMP COMMENT 'The date and time when the compensation event was processed into payroll and financial systems.',
    `raroc_linked_flag` BOOLEAN COMMENT 'Indicates whether this compensation event is linked to RAROC-based performance metrics for incentive calculation.',
    `regulatory_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether this compensation event must be included in regulatory remuneration disclosures (EBA/PRA Material Risk Taker reporting, CRD IV).',
    `salary_grade_code` STRING COMMENT 'The salary grade or band assigned to the employee after this compensation event.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this compensation event is subject to SOX internal controls for financial reporting and audit trail requirements.',
    `stock_option_grant_quantity` STRING COMMENT 'The number of stock options granted to the employee in this compensation event.',
    `stock_option_strike_price` DECIMAL(18,2) COMMENT 'The exercise price per share for stock options granted in this event, in the specified currency.',
    CONSTRAINT pk_compensation_event PRIMARY KEY(`compensation_event_id`)
) COMMENT 'Compensation management master and transactional record serving as the SSOT for all compensation data. On the master side, captures plan-level structures including salary grade bands, pay ranges, incentive plan frameworks, plan types (base salary, short-term incentive, long-term incentive, deferred compensation), eligibility criteria, currency, and effective dates. On the transactional side, captures individual compensation change events including merit increases, promotions, equity adjustments, off-cycle adjustments, bonus awards, stock option grants, prior/new compensation values, effective dates, change reasons, and approvers. Supports annual compensation review cycles, EBA Material Risk Taker remuneration policy compliance, RAROC-linked incentive design, SOX compensation controls, audit trail, and regulatory remuneration disclosure (EBA/PRA Material Risk Taker reporting, CRD IV remuneration disclosure).';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Benefit plan costs and contributions tracked in currencies. Needed for benefit expense accounting, multi-currency benefit administration, financial reporting, and expatriate benefit management in glob',
    `annual_contribution_limit` DECIMAL(18,2) COMMENT 'Maximum amount an employee can contribute to this plan in a calendar year. Applicable to FSA, HSA, 401k, and other contribution-based plans.',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or third-party administrator providing the benefit plan (e.g., Aetna, Blue Cross Blue Shield, Fidelity).',
    `carrier_policy_number` STRING COMMENT 'Policy or contract number assigned by the carrier to this benefit plan. Used for claims processing and carrier communication.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of covered service costs the employee pays after meeting the deductible (e.g., 20.00 for 20% coinsurance). Null if plan uses copays.',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are deducted and paid: weekly, biweekly (every two weeks), semimonthly (twice per month), monthly, or annual.. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee pays for covered services (e.g., doctor visit, prescription). Null if plan uses coinsurance instead.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Benefit coverage amount for life insurance or disability plans (e.g., $50,000 life insurance, 60% salary replacement for disability). Null for non-insurance plans.',
    `coverage_multiple_of_salary` DECIMAL(18,2) COMMENT 'Coverage amount expressed as a multiple of employee annual salary (e.g., 2.00 for 2x salary life insurance). Null if coverage is fixed amount.',
    `coverage_tier_structure` STRING COMMENT 'Defines how coverage levels are structured: employee only, employee plus spouse, employee plus children, employee plus family, tiered (multiple levels), or composite (single rate for all).. Valid values are `employee_only|employee_spouse|employee_children|employee_family|tiered|composite`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was first created in the system.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the employee must pay before insurance coverage begins for applicable plan types (health, dental, vision). Null for non-insurance plans.',
    `effective_end_date` DATE COMMENT 'Date when this benefit plan is no longer available for new enrollments or coverage ends. Null for ongoing plans.',
    `effective_start_date` DATE COMMENT 'Date when this benefit plan becomes available for employee enrollment and coverage begins. Plan activation date.',
    `eligibility_rule_description` STRING COMMENT 'Textual description of eligibility criteria for this plan (e.g., Full-time employees with 90 days of service, All regular employees, Executive level and above).',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee contributes per pay period for this benefit plan. Null if contribution is percentage-based or varies by tier.',
    `employee_contribution_percentage` DECIMAL(18,2) COMMENT 'Percentage of total premium cost the employee contributes (e.g., 20.00 for 20%). Null if contribution is fixed dollar amount.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employer contributes per pay period for this benefit plan. Null if contribution is percentage-based or varies by tier.',
    `employer_contribution_percentage` DECIMAL(18,2) COMMENT 'Percentage of total premium cost the employer contributes (e.g., 80.00 for 80%). Null if contribution is fixed dollar amount.',
    `employer_match_limit` DECIMAL(18,2) COMMENT 'Maximum dollar amount or percentage of salary the employer will match for retirement plan contributions. Null if no match or non-retirement plan.',
    `employer_match_percentage` DECIMAL(18,2) COMMENT 'Percentage of employee contributions the employer matches for retirement plans (e.g., 50.00 for 50% match up to a limit). Null for non-retirement plans.',
    `erisa_plan_number` STRING COMMENT 'Three-digit plan number assigned for ERISA reporting purposes. Required for Form 5500 filing for qualifying benefit plans.. Valid values are `^[0-9]{3}$`',
    `is_aca_compliant` BOOLEAN COMMENT 'Indicates whether this health plan meets Affordable Care Act (ACA) minimum essential coverage and affordability requirements.',
    `is_cobra_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan is eligible for COBRA continuation coverage after employment termination. True for most health, dental, and vision plans.',
    `open_enrollment_end_date` DATE COMMENT 'Date when the annual open enrollment period ends for this benefit plan. Last day employees can make benefit elections for the upcoming plan year.',
    `open_enrollment_start_date` DATE COMMENT 'Date when the annual open enrollment period begins for this benefit plan. Employees can enroll, change, or cancel coverage during this window.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount an employee pays in a plan year for covered services before insurance pays 100%. Applicable to health insurance plans.',
    `plan_administrator_contact` STRING COMMENT 'Contact information (email or phone) for the plan administrator. Used for employee inquiries and regulatory communication.',
    `plan_administrator_name` STRING COMMENT 'Name of the individual or department responsible for administering this benefit plan within the organization.',
    `plan_code` STRING COMMENT 'Unique alphanumeric code identifying the benefit plan in external systems and communications. Used for plan enrollment and payroll integration.. Valid values are `^[A-Z0-9]{6,12}$`',
    `plan_document_url` STRING COMMENT 'URL or file path to the official plan document, summary plan description (SPD), or benefits guide for employee reference.',
    `plan_name` STRING COMMENT 'Full descriptive name of the benefit plan as presented to employees (e.g., Comprehensive Health Plan - PPO Gold, Basic Dental Coverage).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan: active (available for enrollment), inactive (not currently offered), pending (awaiting approval or activation), suspended (temporarily unavailable), or terminated (permanently closed).. Valid values are `active|inactive|pending|suspended|terminated`',
    `plan_subtype` STRING COMMENT 'Detailed classification within the plan type (e.g., for health: PPO, HMO, EPO, HDHP; for retirement: 401k Traditional, 401k Roth, Defined Benefit Pension).',
    `plan_type` STRING COMMENT 'Category of benefit plan: health insurance, dental, vision, life insurance, short-term or long-term disability, retirement (401k, pension), flexible spending account (FSA), health reimbursement arrangement (HRA), health savings account (HSA), or employee assistance program (EAP). [ENUM-REF-CANDIDATE: health|dental|vision|life|disability|retirement|fsa|hra|hsa|eap — 10 candidates stripped; promote to reference product]',
    `plan_year_end_date` DATE COMMENT 'Last day of the plan year for this benefit. After this date, a new plan year begins with reset deductibles and limits.',
    `plan_year_start_date` DATE COMMENT 'First day of the plan year for this benefit. Defines the 12-month period for coverage, deductibles, and out-of-pocket maximums.',
    `summary_plan_description_url` STRING COMMENT 'URL or file path to the Summary Plan Description (SPD) document required by ERISA for employee benefit plans.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Total premium cost per pay period for the base coverage tier (typically employee-only). Combined employee and employer contributions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was last modified. Used for audit trail and change tracking.',
    `vesting_schedule_description` STRING COMMENT 'Description of the vesting schedule for employer contributions to retirement plans (e.g., Immediate, 3-year cliff, 5-year graded). Null for non-retirement plans.',
    `waiting_period_days` STRING COMMENT 'Number of days an employee must wait after hire date before becoming eligible for this benefit plan. Zero indicates immediate eligibility.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Benefits plan master defining the banks employee benefit offerings including health insurance, dental, vision, life insurance, disability, retirement plans (401k, pension), employee assistance programs, and flexible spending accounts. Captures plan name, plan type, carrier, coverage tiers, employee/employer contribution rates, eligibility rules, open enrollment windows, and regulatory plan identifiers (ERISA plan number).';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment record. Primary key for this entity.',
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier of the benefit plan in which the employee is enrolled. Links to the benefit plan master record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Individual enrollment premiums may be currency-specific. Supports expatriate benefit management, multi-currency payroll deduction processing, and benefit cost tracking for employees in different juris',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who enrolled in the benefit plan. Links to the employee master record in the Human Capital Management (HCM) system.',
    `aca_reporting_flag` BOOLEAN COMMENT 'Indicates whether this enrollment must be included in ACA Form 1095-C reporting. True if the enrollment is subject to ACA reporting requirements (e.g., health insurance coverage), False otherwise.',
    `approval_status` STRING COMMENT 'Indicates whether the enrollment has been approved by the benefits administrator or HR. Some enrollments (e.g., life events) require manual approval before becoming effective.. Valid values are `approved|pending_approval|rejected|not_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the enrollment was approved. Null if approval is not required or still pending.',
    `approved_by` STRING COMMENT 'The name or identifier of the benefits administrator or HR representative who approved the enrollment, if approval was required. Null if approval is not required or still pending.',
    `beneficiary_designation_flag` BOOLEAN COMMENT 'Indicates whether the employee has designated beneficiaries for this benefit enrollment (applicable for life insurance, retirement plans, etc.). True if beneficiaries have been designated, False otherwise.',
    `carrier_member_number` STRING COMMENT 'The unique member identifier assigned by the insurance carrier to the employee for this benefit enrollment. Used for claims processing and coordination with the carrier.',
    `carrier_policy_number` STRING COMMENT 'The insurance carriers policy or contract number under which this enrollment is covered. Used for coordination with external insurance carriers and claims processing.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether this enrollment is eligible for COBRA continuation coverage in the event of a qualifying event (e.g., termination of employment, reduction in hours). True if COBRA-eligible, False otherwise.',
    `contribution_frequency` STRING COMMENT 'The frequency at which employee and employer contributions are deducted and paid. Aligns with the organizations payroll cycle.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `cost_center_code` STRING COMMENT 'The General Ledger (GL) cost center code to which the employer contribution for this enrollment is allocated. Used for financial reporting and cost allocation.',
    `coverage_tier` STRING COMMENT 'The level of coverage elected by the employee, indicating who is covered under the benefit plan. Employee only covers the employee; employee and spouse covers employee and spouse/domestic partner; employee and children covers employee and dependent children; employee and family covers employee, spouse, and children.. Valid values are `employee_only|employee_spouse|employee_children|employee_family`',
    `dependent_count` STRING COMMENT 'The number of dependents (spouse, children, or other qualified dependents) covered under this enrollment. Zero if coverage tier is employee only.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'The per-pay-period dollar amount deducted from the employees paycheck to fund this benefit enrollment. Represents the employees share of the premium or cost.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The per-pay-period dollar amount contributed by the employer toward this benefit enrollment. Represents the employers share of the premium or cost.',
    `enrollment_confirmation_sent_date` DATE COMMENT 'The date on which the enrollment confirmation notice was sent to the employee. Null if confirmation has not yet been sent.',
    `enrollment_confirmation_sent_flag` BOOLEAN COMMENT 'Indicates whether an enrollment confirmation notice has been sent to the employee. True if confirmation has been sent, False otherwise. Used for tracking communication compliance.',
    `enrollment_effective_date` DATE COMMENT 'The date on which the benefit coverage begins for the employee. This is the start date of the enrollment period and determines when benefits become available.',
    `enrollment_end_date` DATE COMMENT 'The date on which the benefit coverage ends for the employee. Null if the enrollment is currently active and has no scheduled termination date.',
    `enrollment_method` STRING COMMENT 'The channel or method through which the employee completed the enrollment. Online portal indicates self-service web enrollment; paper form indicates manual form submission; phone indicates enrollment via call center; benefits counselor indicates in-person or virtual counselor-assisted enrollment; automatic indicates system-generated enrollment (e.g., auto-enrollment in retirement plans).. Valid values are `online_portal|paper_form|phone|benefits_counselor|automatic`',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment confirmation number provided to the employee upon successful enrollment. Used for reference in benefits inquiries and claims.',
    `enrollment_source` STRING COMMENT 'The triggering event or process that initiated this enrollment. Open enrollment refers to the annual enrollment period; new hire refers to initial enrollment upon joining; life event refers to qualifying life events (marriage, birth, adoption); qualifying event refers to COBRA or other special enrollment rights; administrative correction refers to employer-initiated adjustments.. Valid values are `open_enrollment|new_hire|life_event|annual_reenrollment|qualifying_event|administrative_correction`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the benefit enrollment. Active indicates the enrollment is in force; pending indicates awaiting approval or effective date; terminated indicates coverage has ended; waived indicates employee declined coverage; suspended indicates temporary hold; cancelled indicates enrollment was voided before becoming active.. Valid values are `active|pending|terminated|waived|suspended|cancelled`',
    `enrollment_timestamp` TIMESTAMP COMMENT 'The date and time when the employee submitted the enrollment election. Represents the business event timestamp of the enrollment action.',
    `evidence_of_insurability_required_flag` BOOLEAN COMMENT 'Indicates whether the employee is required to provide Evidence of Insurability (EOI) for this enrollment, typically for supplemental life insurance or disability coverage above guaranteed issue limits. True if EOI is required, False otherwise.',
    `evidence_of_insurability_status` STRING COMMENT 'The status of the Evidence of Insurability (EOI) review process, if required. Not required if EOI is not needed; pending if awaiting carrier review; approved if carrier approved coverage; denied if carrier denied coverage.. Valid values are `not_required|pending|approved|denied`',
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code to which the benefit expense is posted. Used for financial accounting and reporting.',
    `notes` STRING COMMENT 'Free-text field for capturing additional notes, comments, or special instructions related to this enrollment. Used by benefits administrators for case management and audit trail purposes.',
    `qualifying_event_date` DATE COMMENT 'The date of the qualifying life event that triggered this enrollment or change, if applicable. Examples include marriage, birth, adoption, divorce, or loss of other coverage. Null if the enrollment was not triggered by a qualifying event.',
    `qualifying_event_type` STRING COMMENT 'The type of qualifying life event that triggered this enrollment or change, if applicable. Null if the enrollment was not triggered by a qualifying event. [ENUM-REF-CANDIDATE: marriage|birth|adoption|divorce|death|loss_of_coverage|employment_change — 7 candidates stripped; promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this enrollment record was first created in the system. Used for audit trail and data lineage purposes.',
    `record_updated_by` STRING COMMENT 'The user identifier or system process that last modified this enrollment record. Used for audit trail and SOX compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this enrollment record was last modified in the system. Used for audit trail and data lineage purposes.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'The total per-pay-period cost of the benefit enrollment, equal to the sum of employee and employer contributions. Used for benefits cost allocation and General Ledger (GL) posting.',
    `waiver_reason` STRING COMMENT 'The reason provided by the employee for waiving coverage, if applicable. Coverage elsewhere indicates the employee has coverage through another source (spouse, parent, etc.); cost indicates the employee declined due to affordability; not needed indicates the employee does not require the benefit; other indicates a reason not captured by standard categories.. Valid values are `coverage_elsewhere|cost|not_needed|other`',
    `waiver_status` BOOLEAN COMMENT 'Indicates whether the employee has explicitly waived (declined) coverage for this benefit plan. True if waived, False if enrolled. Required for ACA reporting and ERISA compliance.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Employee benefit enrollment record capturing an employees active elections across benefit plans. Includes enrollment effective date, coverage tier selected, dependent coverage, employee contribution amount, employer contribution amount, waiver status, and enrollment source (open enrollment, life event, new hire). Supports ERISA compliance, ACA reporting (Form 1095-C), and benefits cost allocation to GL cost centers.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`candidate` (
    `candidate_id` BIGINT COMMENT 'Unique identifier for the candidate record. Primary key for the candidate entity.',
    `employee_id` BIGINT COMMENT 'Reference to the recruiter or talent acquisition specialist assigned to manage this candidates application.',
    `candidate_hiring_manager_employee_id` BIGINT COMMENT 'Reference to the hiring manager responsible for the final hiring decision for this candidate.',
    `candidate_referral_employee_id` BIGINT COMMENT 'Reference to the employee who referred this candidate, if applicable, for employee referral program tracking.',
    `job_requisition_id` BIGINT COMMENT 'Reference to the job requisition for which this candidate applied.',
    `actual_hire_date` DATE COMMENT 'The actual date on which the candidate was hired and became an employee.',
    `application_date` DATE COMMENT 'The date on which the candidate submitted their application for the requisition.',
    `application_stage` STRING COMMENT 'The specific stage or phase within the recruiting process that the candidate has reached. [ENUM-REF-CANDIDATE: applied|phone_screen|first_interview|second_interview|final_interview|offer_extended|offer_accepted|onboarding — 8 candidates stripped; promote to reference product]',
    `application_status` STRING COMMENT 'Current status of the candidates application in the recruiting workflow lifecycle. [ENUM-REF-CANDIDATE: new|screening|interview|assessment|offer|hired|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    `background_check_completion_date` DATE COMMENT 'The date on which the background check process was completed.',
    `background_check_status` STRING COMMENT 'Current status of the regulatory background check process including criminal history, employment verification, and education verification.. Valid values are `not_initiated|in_progress|clear|conditional|failed`',
    `candidate_number` STRING COMMENT 'Human-readable business identifier assigned to the candidate for tracking and reference purposes across recruiting systems.',
    `consent_to_contact` BOOLEAN COMMENT 'Indicates whether the candidate has provided consent to be contacted for future opportunities, supporting GDPR and privacy compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was first created in the system.',
    `current_employer` STRING COMMENT 'Name of the organization where the candidate is currently employed, if applicable.',
    `current_job_title` STRING COMMENT 'The candidates current job title or role at their present employer.',
    `degree_field` STRING COMMENT 'The primary field or major of the candidates highest degree.',
    `disability_status` STRING COMMENT 'Self-identified disability status of the candidate for Section 503 compliance and diversity hiring tracking.. Valid values are `no_disability|has_disability|prefer_not_to_disclose`',
    `disposition_reason` STRING COMMENT 'The reason for the candidates final disposition if rejected or withdrawn, used for adverse impact analysis and process improvement.',
    `eeo_ethnicity` STRING COMMENT 'Self-identified ethnicity or race of the candidate for EEO and OFCCP compliance reporting and adverse impact analysis.',
    `eeo_gender` STRING COMMENT 'Self-identified gender of the candidate for EEO and OFCCP compliance reporting purposes.. Valid values are `male|female|non_binary|prefer_not_to_disclose`',
    `email_address` STRING COMMENT 'Primary email address used for candidate communication throughout the recruiting lifecycle.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Legal first name of the candidate as provided in the application.',
    `highest_education_level` STRING COMMENT 'The highest level of formal education attained by the candidate.. Valid values are `high_school|associate|bachelor|master|doctorate|professional`',
    `is_internal_candidate` BOOLEAN COMMENT 'Indicates whether the candidate is a current employee applying for an internal transfer or promotion.',
    `last_name` STRING COMMENT 'Legal last name of the candidate as provided in the application.',
    `ofac_screening_date` DATE COMMENT 'The date on which OFAC sanctions screening was performed for the candidate.',
    `ofac_screening_status` STRING COMMENT 'Status of OFAC sanctions screening to ensure compliance with anti-money laundering and counter-terrorism financing regulations.. Valid values are `not_screened|clear|flagged|under_review`',
    `offer_accepted_date` DATE COMMENT 'The date on which the candidate formally accepted the employment offer.',
    `offer_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the offer salary amount.. Valid values are `^[A-Z]{3}$`',
    `offer_extended_date` DATE COMMENT 'The date on which a formal employment offer was extended to the candidate.',
    `offer_salary_amount` DECIMAL(18,2) COMMENT 'The base salary amount offered to the candidate in the employment offer.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the candidate.',
    `rejection_date` DATE COMMENT 'The date on which the candidate was formally rejected or removed from consideration for the requisition.',
    `resume_document_url` STRING COMMENT 'Storage location or URL reference to the candidates resume or curriculum vitae document.',
    `source_channel` STRING COMMENT 'The sourcing channel through which the candidate was identified or applied, used for recruiting effectiveness analysis and cost-per-hire tracking.. Valid values are `employee_referral|job_board|company_website|recruiter_outreach|social_media|campus_recruiting`',
    `target_start_date` DATE COMMENT 'The anticipated or agreed-upon start date for the candidate if hired.',
    `time_to_fill_days` STRING COMMENT 'Number of days from application date to hire date, used for recruiting efficiency metrics and service level agreement (SLA) tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was last modified.',
    `veteran_status` STRING COMMENT 'Self-identified veteran status of the candidate for OFCCP compliance and diversity hiring tracking.. Valid values are `not_veteran|protected_veteran|prefer_not_to_disclose`',
    `withdrawal_date` DATE COMMENT 'The date on which the candidate voluntarily withdrew their application from consideration.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of relevant professional work experience as declared by the candidate.',
    CONSTRAINT pk_candidate PRIMARY KEY(`candidate_id`)
) COMMENT 'Talent acquisition master and transactional record representing the full recruiting lifecycle from headcount demand through candidate hire. On the demand side, captures requisition details including requisition number, linked position, hiring manager, recruiter assigned, requisition type (backfill, new headcount, replacement), target start date, approved salary range, sourcing channels, requisition status (open, on-hold, filled, cancelled), and time-to-fill tracking. On the candidate side, captures candidate name, contact information, source channel, application date, current employer, education, experience, application status and stage progression (screening, interview, offer, hire, reject), disposition reason, offer details, and regulatory background check status including OFAC/sanctions screening. Serves as the SSOT for all recruiting activity including requisition management, pipeline tracking, EEO/OFCCP compliance, adverse impact analysis, diversity hiring tracking, and headcount budget control.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who last modified the performance review record.',
    `primary_performance_employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed.',
    `review_cycle_id` BIGINT COMMENT 'Identifier of the review cycle or period (e.g., annual, mid-year, quarterly).',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor conducting the review.',
    `balanced_scorecard_alignment` STRING COMMENT 'Primary balanced scorecard perspective that this reviews goals align with.. Valid values are `financial|customer|internal_process|learning_growth|risk_compliance|not_applicable`',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for a performance-based bonus.',
    `bonus_percentage` DECIMAL(18,2) COMMENT 'Recommended or approved bonus percentage based on performance rating and goal achievement.',
    `calibration_date` DATE COMMENT 'Date when the calibration session was completed for this review.',
    `calibration_status` STRING COMMENT 'Status of the calibration process to ensure rating consistency across the organization.. Valid values are `not_required|pending|in_progress|completed|adjusted`',
    `competency_rating_score` DECIMAL(18,2) COMMENT 'Weighted average score of all competency assessments for the review period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was first created in the system.',
    `development_plan_created` BOOLEAN COMMENT 'Indicates whether a development plan was created as part of this review.',
    `employee_acknowledgement_date` DATE COMMENT 'Date when the employee acknowledged receipt and review of their performance evaluation.',
    `employee_self_assessment` STRING COMMENT 'Self-assessment narrative provided by the employee regarding their performance.',
    `goal_achievement_score` DECIMAL(18,2) COMMENT 'Weighted average score of all individual goal achievements for the review period.',
    `high_potential_flag` BOOLEAN COMMENT 'Indicates whether the employee has been identified as high potential talent.',
    `hr_approval_date` DATE COMMENT 'Date when the Human Resources department approved the performance review.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was last updated.',
    `manager_comments` STRING COMMENT 'Narrative comments and feedback provided by the reviewing manager.',
    `material_risk_taker_flag` BOOLEAN COMMENT 'Indicates whether the employee is classified as a Material Risk Taker under European Banking Authority (EBA) or Prudential Regulation Authority (PRA) guidelines, requiring enhanced performance assessment and compensation oversight.',
    `merit_increase_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for a merit-based salary increase based on this review.',
    `merit_increase_percentage` DECIMAL(18,2) COMMENT 'Recommended or approved merit increase percentage based on performance rating.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next performance review.',
    `organizational_objective_linkage` STRING COMMENT 'Description of how the employees goals cascade from and support organizational strategic objectives.',
    `overall_rating` STRING COMMENT 'Final overall performance rating assigned to the employee for the review period.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score corresponding to the overall performance rating (e.g., 1.0 to 5.0 scale).',
    `pip_initiated` BOOLEAN COMMENT 'Indicates whether a Performance Improvement Plan was initiated as a result of this review.',
    `pre_calibration_rating` STRING COMMENT 'Initial performance rating assigned before calibration adjustments.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `raroc_linked_goal_flag` BOOLEAN COMMENT 'Indicates whether any of the employees performance goals are linked to Risk-Adjusted Return on Capital (RAROC) metrics for incentive alignment.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether this review must be included in regulatory reporting (e.g., Material Risk Taker disclosures).',
    `review_completion_date` DATE COMMENT 'Date when the performance review was finalized and approved.',
    `review_period_end_date` DATE COMMENT 'End date of the performance period being evaluated.',
    `review_period_start_date` DATE COMMENT 'Start date of the performance period being evaluated.',
    `review_status` STRING COMMENT 'Current workflow status of the performance review. [ENUM-REF-CANDIDATE: draft|self_assessment_pending|manager_review_pending|calibration_pending|approved|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `review_type` STRING COMMENT 'Type of performance review being conducted.. Valid values are `annual|mid_year|quarterly|probationary|ad_hoc|pip`',
    `reviewer_signature_date` DATE COMMENT 'Date when the reviewing manager signed off on the performance review.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this review is subject to Sarbanes-Oxley Act (SOX) Human Resources controls for key financial personnel.',
    `succession_planning_flag` BOOLEAN COMMENT 'Indicates whether the employee has been identified for succession planning based on this review.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Employee performance review record capturing formal annual, mid-year, and ad-hoc performance evaluations. Includes review cycle, review period, overall rating, goal achievement scores (individual goals captured as nested attributes), competency ratings, manager comments, employee self-assessment, calibration status, and final approved rating. Goals include title, category (financial, operational, risk, compliance, development), target metric, target value, actual value, weight, and cascading linkage to organizational objectives. Supports merit increase linkage, succession planning, PIP initiation, balanced scorecard alignment, RAROC-linked incentive goal setting, and regulatory requirements for Material Risk Taker performance assessment under EBA/PRA guidelines.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`learning_enrollment` (
    `learning_enrollment_id` BIGINT COMMENT 'Unique identifier for the learning enrollment record. Primary key for the learning enrollment entity.',
    `learning_course_id` BIGINT COMMENT 'Unique identifier of the training course or learning program. Links to the course catalog in the learning management system.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee enrolled in the training program. Links to the employee master record in the Human Capital Management (HCM) system.',
    `tertiary_learning_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last modified the learning enrollment record. Used for audit trail and accountability.',
    `actual_completion_date` DATE COMMENT 'Actual date on which the employee completed the training course. Used for compliance reporting and to calculate training completion rates.',
    `actual_start_date` DATE COMMENT 'Actual date on which the employee began the training course. May differ from scheduled start date if the employee started early or late.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved by the employee on the course assessment or examination, typically expressed as a percentage (0.00 to 100.00). Used to determine pass/fail status and measure learning effectiveness.',
    `attempts_count` STRING COMMENT 'Number of times the employee has attempted the course assessment or examination. Used to track retake activity and identify employees requiring additional support.',
    `business_unit` STRING COMMENT 'Business unit or division to which the employee belongs at the time of enrollment. Used for organizational reporting and training analytics.',
    `certification_earned` STRING COMMENT 'Name or title of the certification, credential, or designation earned upon successful completion of the training course. Null if no certification is awarded.',
    `certification_expiration_date` DATE COMMENT 'Date on which the certification or credential expires and must be renewed. Used for compliance tracking and to trigger renewal notifications.',
    `certification_number` STRING COMMENT 'Unique identifier or certificate number issued for the certification earned. Used for verification and audit purposes.',
    `completion_status` STRING COMMENT 'Outcome status indicating whether the employee successfully completed the training course. Pass indicates successful completion, fail indicates unsuccessful attempt, and incomplete indicates partial completion.. Valid values are `pass|fail|incomplete|in_progress|not_started`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for the employees enrollment in the training course, including tuition, materials, and any associated fees. Used for training budget management and cost allocation.',
    `cost_center_code` STRING COMMENT 'Code identifying the cost center or department to which the training cost is allocated. Used for financial reporting and budget tracking.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `course_code` STRING COMMENT 'Business-readable code or identifier for the training course, used for reporting and reference purposes.',
    `course_name` STRING COMMENT 'Full name or title of the training course or learning program.',
    `course_type` STRING COMMENT 'Classification of the training course by its primary purpose. Regulatory/mandatory courses include Anti-Money Laundering (AML), Bank Secrecy Act (BSA), Know Your Customer (KYC), Sarbanes-Oxley Act (SOX), and Financial Industry Regulatory Authority (FINRA) continuing education requirements.. Valid values are `regulatory_mandatory|professional_development|leadership|product_knowledge|technical_skills|compliance`',
    `cpe_credits_awarded` DECIMAL(18,2) COMMENT 'Number of Continuing Professional Education (CPE) or Continuing Education (CE) credits awarded upon successful completion of the training course. Used for professional licensing and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the learning enrollment record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_type` STRING COMMENT 'Type of continuing education credit awarded. CPE refers to Continuing Professional Education, CE to Continuing Education, CLE to Continuing Legal Education, CME to Continuing Medical Education, FINRA Regulatory to FINRA Regulatory Element, and FINRA Firm to FINRA Firm Element. [ENUM-REF-CANDIDATE: cpe|ce|cle|cme|finra_regulatory|finra_firm|other — 7 candidates stripped; promote to reference product]',
    `delivery_method` STRING COMMENT 'Method by which the training content is delivered to the employee. E-learning refers to online self-paced modules, instructor-led refers to in-person classroom training, virtual refers to live online sessions, and blended refers to a combination of methods.. Valid values are `e_learning|instructor_led|virtual|blended|on_the_job|self_paced`',
    `enrollment_date` DATE COMMENT 'Date on which the employee was enrolled in the training course. Represents the official registration date for the learning program.',
    `enrollment_source` STRING COMMENT 'Source or method by which the employee was enrolled in the training course. Self-service indicates employee-initiated enrollment, manager-assigned indicates manager-initiated enrollment, HR-assigned indicates human resources-initiated enrollment, system-auto-assigned indicates automated enrollment based on rules, and compliance-triggered indicates enrollment triggered by regulatory or compliance requirements.. Valid values are `self_service|manager_assigned|hr_assigned|system_auto_assigned|compliance_triggered`',
    `enrollment_status` STRING COMMENT 'Current status of the employees enrollment in the training course. Tracks progression through the learning lifecycle from initial enrollment to completion or withdrawal. [ENUM-REF-CANDIDATE: enrolled|in_progress|completed|failed|withdrawn|expired|waived — 7 candidates stripped; promote to reference product]',
    `job_role` STRING COMMENT 'Job role or position title of the employee at the time of enrollment. Used to analyze training participation by role and ensure role-specific training requirements are met.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the learning enrollment record was last updated or modified. Used for audit trail and change tracking.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the training course is mandatory for the employee based on their role, regulatory requirements, or organizational policy. True indicates mandatory training, False indicates elective training.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the course assessment, expressed as a percentage (0.00 to 100.00). Used to determine whether the employee successfully completed the training.',
    `provider_name` STRING COMMENT 'Name of the organization or vendor providing the training course. May be internal (bank learning and development department) or external (third-party training provider).',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether the training course is required to meet specific regulatory or compliance obligations such as Anti-Money Laundering (AML), Bank Secrecy Act (BSA), Financial Industry Regulatory Authority (FINRA) continuing education, or Sarbanes-Oxley Act (SOX) training controls. True indicates regulatory requirement, False indicates non-regulatory training.',
    `renewal_due_date` DATE COMMENT 'Date by which the employee must complete renewal training or recertification to maintain compliance. Used for proactive compliance management.',
    `scheduled_completion_date` DATE COMMENT 'Target or expected date by which the employee should complete the training course. Used for compliance tracking and deadline management.',
    `scheduled_start_date` DATE COMMENT 'Planned or scheduled date for the employee to begin the training course. May differ from enrollment date for courses with future start dates.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether the training enrollment is subject to Sarbanes-Oxley Act (SOX) internal control requirements. True indicates the training is part of SOX-mandated controls, False indicates non-SOX training.',
    `waiver_approval_date` DATE COMMENT 'Date on which the training waiver or exemption was approved. Used for audit trail and compliance documentation.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the individual who approved the training waiver or exemption. Used for audit trail and accountability.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a waiver or exemption was granted for the training requirement. True indicates waiver granted, False indicates no waiver. Used for compliance exception tracking.',
    `waiver_reason` STRING COMMENT 'Business justification or reason for granting a training waiver or exemption. Used for audit and compliance documentation.',
    CONSTRAINT pk_learning_enrollment PRIMARY KEY(`learning_enrollment_id`)
) COMMENT 'Employee learning and training enrollment record capturing participation in mandatory and elective training programs. Includes course identifier, course name, course type (regulatory/mandatory, professional development, leadership, product knowledge), delivery method (e-learning, instructor-led, virtual, blended), provider/vendor, enrollment date, completion date, pass/fail status, score, certification earned, CPE/CE credits awarded, and expiration/renewal date. Supports mandatory AML/BSA training compliance, FINRA continuing education requirements (Regulatory Element and Firm Element), SOX training controls, and OCC/Fed safety and soundness training mandates.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`regulatory_disclosure` (
    `regulatory_disclosure_id` BIGINT COMMENT 'Unique identifier for the regulatory disclosure record. Primary key.',
    `compliance_sox_control_id` BIGINT COMMENT 'The unique identifier of the SOX control that governs this disclosure process. Used for audit trail and control testing purposes.',
    `employee_id` BIGINT COMMENT 'The user ID or system account that last modified this record. Used for audit trail and accountability.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity on behalf of which this disclosure is filed. Supports multi-entity banking organizations with separate regulatory reporting obligations.',
    `org_unit_id` BIGINT COMMENT 'Reference to the business unit or line of business (LOB) associated with this disclosure, if applicable. Relevant for disclosures that are segmented by organizational division.',
    `original_disclosure_regulatory_disclosure_id` BIGINT COMMENT 'Reference to the original regulatory disclosure record that this submission amends or corrects. Null if this is an original filing.',
    `primary_regulatory_employee_id` BIGINT COMMENT 'Reference to the employee subject of this regulatory disclosure, if applicable to individual-level disclosures such as Material Risk Taker remuneration or FINRA U4/U5 filings.',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Disclosures follow specific regulatory taxonomies (XBRL schemas, reporting frameworks). Required for structured data submission, validation, regulatory reporting automation, and compliance with jurisd',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the employee who reviewed and approved the disclosure prior to submission. Typically a senior HR manager, compliance manager, or legal counsel.',
    `tertiary_regulatory_preparer_employee_id` BIGINT COMMENT 'Reference to the employee who prepared or compiled the regulatory disclosure. Typically a Human Resources (HR) analyst, compliance officer, or regulatory reporting specialist.',
    `amendment_flag` BOOLEAN COMMENT 'Indicates whether this disclosure is an amendment or correction to a previously submitted disclosure. True if amendment, False if original filing.',
    `amendment_reason` STRING COMMENT 'Explanation of why an amendment was filed, including the nature of the correction or additional information provided. Required when amendment_flag is True.',
    `attestation_date` DATE COMMENT 'The date on which the attesting officer signed or certified the disclosure. Format: yyyy-MM-dd.',
    `attestation_required_flag` BOOLEAN COMMENT 'Indicates whether this disclosure requires formal attestation or certification by a senior officer or authorized signatory. True if attestation is required, False otherwise.',
    `attestation_statement` STRING COMMENT 'The formal attestation or certification statement provided by the attesting officer, affirming the accuracy and completeness of the disclosure.',
    `confidentiality_classification` STRING COMMENT 'The data classification level assigned to this disclosure record. Determines access controls and handling procedures. Aligns with organizational data classification policy.. Valid values are `Public|Internal|Confidential|Restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory disclosure record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `data_extraction_date` DATE COMMENT 'The date on which the underlying data for this disclosure was extracted from the source system. Format: yyyy-MM-dd. Used for data lineage and audit purposes.',
    `data_source_system` STRING COMMENT 'The name of the source system from which the disclosure data was extracted. Typically the Human Capital Management System (e.g., Workday, SAP SuccessFactors) or Regulatory Reporting Platform.',
    `disclosure_category` STRING COMMENT 'High-level categorization of the disclosure subject matter. Groups disclosures by thematic area for reporting and compliance tracking purposes.. Valid values are `Workforce Demographics|Compensation and Benefits|Regulatory Certification|Licensing and Registration|Risk Management Personnel`',
    `disclosure_document_url` STRING COMMENT 'Reference URL or file path to the formal disclosure document or report submitted to the regulatory body. May point to document management system or secure file repository.',
    `disclosure_type` STRING COMMENT 'Type of regulatory disclosure being filed. Includes Equal Employment Opportunity (EEO-1), Veterans Employment (VETS-4212), Affordable Care Act (ACA) 1095-C, Material Risk Taker remuneration under CRD IV/EBA guidelines, Senior Manager Certification under regulatory regimes, and Financial Industry Regulatory Authority (FINRA) U4/U5 filings.. Valid values are `EEO-1|VETS-4212|ACA 1095-C|Material Risk Taker Remuneration|Senior Manager Certification|FINRA U4/U5`',
    `disposal_eligible_date` DATE COMMENT 'The date on which this disclosure record becomes eligible for disposal or archival per records retention policy. Format: yyyy-MM-dd. Calculated as submission_date plus retention_period_years.',
    `due_date` DATE COMMENT 'The regulatory deadline by which this disclosure must be submitted. Format: yyyy-MM-dd. Used for compliance monitoring and Service Level Agreement (SLA) tracking.',
    `filing_reference_number` STRING COMMENT 'The unique reference or confirmation number assigned by the regulatory body upon submission of the disclosure. Used for tracking and correspondence with the regulator.',
    `internal_control_test_date` DATE COMMENT 'The date on which internal controls over the disclosure process were last tested. Format: yyyy-MM-dd. Relevant for SOX compliance and internal audit.',
    `internal_control_test_result` STRING COMMENT 'The outcome of the most recent internal control test over the disclosure process. Used for SOX compliance and audit reporting.. Valid values are `Passed|Failed|Not Tested|Remediation Required`',
    `jurisdiction` STRING COMMENT 'The regulatory jurisdiction or country under whose laws this disclosure is required. Uses ISO 3166-1 alpha-3 country codes. [ENUM-REF-CANDIDATE: USA|GBR|DEU|FRA|CHE|SGP|HKG|JPN|AUS|CAN — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory disclosure record was last modified or updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `late_filing_flag` BOOLEAN COMMENT 'Indicates whether the disclosure was submitted after the regulatory due date. True if late, False if on time. Used for compliance risk tracking and Key Risk Indicator (KRI) reporting.',
    `regulator_comments` STRING COMMENT 'Comments, feedback, or findings provided by the regulatory body in response to the disclosure. May include requests for clarification, additional information, or corrective actions.',
    `regulator_response_date` DATE COMMENT 'The date on which the regulatory body provided a formal response, acceptance, or rejection of the disclosure. Format: yyyy-MM-dd.',
    `regulatory_body` STRING COMMENT 'The regulatory authority or governing body to which this disclosure is submitted. Includes Office of the Comptroller of the Currency (OCC), Federal Reserve (Fed), Federal Deposit Insurance Corporation (FDIC), Securities and Exchange Commission (SEC), Financial Industry Regulatory Authority (FINRA), European Banking Authority (EBA), Prudential Regulation Authority (PRA), Equal Employment Opportunity Commission (EEOC), Department of Labor (DOL), and Internal Revenue Service (IRS). [ENUM-REF-CANDIDATE: OCC|Fed|FDIC|SEC|FINRA|EBA|PRA|EEOC|DOL|IRS — 10 candidates stripped; promote to reference product]',
    `reporting_period_end_date` DATE COMMENT 'The end date of the reporting period covered by this regulatory disclosure. Format: yyyy-MM-dd.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the reporting period covered by this regulatory disclosure. Format: yyyy-MM-dd.',
    `retention_period_years` STRING COMMENT 'The number of years this disclosure record must be retained per regulatory requirements and internal records retention policies. Varies by disclosure type and jurisdiction.',
    `review_date` DATE COMMENT 'The date on which the disclosure was reviewed and approved for submission. Format: yyyy-MM-dd.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this disclosure is subject to Sarbanes-Oxley Act (SOX) internal controls over financial reporting. True if SOX-controlled, False otherwise.',
    `submission_date` DATE COMMENT 'The date on which the regulatory disclosure was submitted to the regulatory body. Format: yyyy-MM-dd.',
    `submission_method` STRING COMMENT 'The method or channel through which the disclosure was submitted to the regulatory body. Includes electronic portals, email, postal mail, and regulator-specific systems such as EDGAR (SEC), FINRA Gateway, or EBA Portal.. Valid values are `Electronic Portal|Email|Postal Mail|EDGAR|FINRA Gateway|EBA Portal`',
    `submission_status` STRING COMMENT 'Current lifecycle status of the regulatory disclosure submission. Tracks progression from draft through regulatory acceptance or rejection. [ENUM-REF-CANDIDATE: Draft|Pending Review|Submitted|Accepted|Rejected|Amended|Withdrawn — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_regulatory_disclosure PRIMARY KEY(`regulatory_disclosure_id`)
) COMMENT 'HR regulatory disclosure record capturing mandatory workforce disclosures required by banking regulators and labor authorities. Includes disclosure type (EEO-1, VETS-4212, ACA 1095-C, Material Risk Taker remuneration, Senior Manager certification, FINRA U4/U5 filing, CRD IV remuneration disclosure), reporting period, regulatory body, submission date, submission status, and attestation details. Supports OCC, Fed, FDIC, FINRA, EBA, and PRA regulatory reporting obligations.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`license_certification` (
    `license_certification_id` BIGINT COMMENT 'Unique identifier for the employee professional license or regulatory certification record. Primary key for the license_certification product.',
    `created_by_user_employee_id` BIGINT COMMENT 'User identifier of the HR system user or automated process that created this license or certification record. Used for audit trail and data governance.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who holds this license or certification. Links to the employee master record in the HR system.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the HR system user or automated process that most recently modified this license or certification record. Used for audit trail and data governance.',
    `org_unit_id` BIGINT COMMENT 'Reference to the business unit or line of business (LOB) for which this license or certification is relevant. Used for workforce planning and regulatory reporting by business segment.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special conditions, or contextual information related to this license or certification. May include details about exemptions, waivers, or unique circumstances.',
    `continuing_education_compliance_status` STRING COMMENT 'Assessment of whether the employee is on track to meet continuing education requirements for this license or certification. Compliant indicates requirements are met or on track. At Risk indicates the employee is behind schedule but still within the renewal window. Non-Compliant indicates requirements are not met and the credential is at risk. Not Applicable indicates no CE requirements exist for this credential.. Valid values are `compliant|at_risk|non_compliant|not_applicable`',
    `continuing_education_hours_completed` DECIMAL(18,2) COMMENT 'Number of continuing education or professional development hours the employee has completed toward the current renewal cycle requirement. Expressed as decimal hours (e.g., 18.50 hours).',
    `continuing_education_hours_required` DECIMAL(18,2) COMMENT 'Total number of continuing education or professional development hours required by the issuing authority to maintain or renew this license or certification during the current renewal cycle. Expressed as decimal hours (e.g., 24.00 hours).',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which any licensing fees, examination costs, or continuing education expenses for this credential are charged. Used for budgeting and expense allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this license or certification record was first created in the HR system. Follows yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `expiration_date` DATE COMMENT 'Date on which the license or certification expires and requires renewal or recertification. Nullable for credentials with no expiration (lifetime certifications). Follows yyyy-MM-dd format.',
    `fitness_propriety_review_date` DATE COMMENT 'Most recent date on which the employees fitness and propriety assessment was conducted in relation to this license or certification, as required by OCC, PRA, or other banking regulators. Nullable if no review has been conducted. Follows yyyy-MM-dd format.',
    `fitness_propriety_status` STRING COMMENT 'Outcome of the most recent fitness and propriety assessment for the employee in relation to this license or certification. Approved indicates the employee meets all regulatory fitness standards. Pending indicates review is in progress. Conditional indicates approval with restrictions or monitoring requirements. Denied indicates the employee does not meet fitness standards. Not Applicable indicates no fitness review is required for this credential.. Valid values are `approved|pending|conditional|denied|not_applicable`',
    `issue_date` DATE COMMENT 'Date on which the license or certification was originally issued or granted to the employee by the issuing authority. Follows yyyy-MM-dd format.',
    `issuing_authority` STRING COMMENT 'Name of the regulatory body, professional association, or governmental agency that issued and governs this license or certification. Examples include FINRA, state securities regulators, CFA Institute, AICPA, GARP, PMI, or other recognized credentialing organizations.',
    `jurisdiction_code` STRING COMMENT 'Geographic or regulatory jurisdiction in which this license or certification is valid. May be a state code (e.g., NY, CA), country code (e.g., USA, GBR), or regulatory region code. Important for multi-state or international licensing compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this license or certification record was most recently updated in the HR system. Follows yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `license_number` STRING COMMENT 'Unique alphanumeric identifier assigned by the issuing authority or regulatory body for this license or certification. May include FINRA CRD number, state license number, or professional certification ID.',
    `license_status` STRING COMMENT 'Current lifecycle status of the license or certification. Active indicates the credential is valid and in good standing. Expired indicates the credential has passed its expiration date and requires renewal. Suspended indicates temporary restriction by the issuing authority. Revoked indicates permanent cancellation. Pending indicates application or renewal is in process. Inactive indicates the employee is not currently using this credential in their role.. Valid values are `active|expired|suspended|revoked|pending|inactive`',
    `license_type` STRING COMMENT 'Classification of the professional license or regulatory certification. Common types include FINRA Series 7 (General Securities Representative), Series 63 (Uniform Securities Agent State Law), Series 65 (Investment Adviser Representative), CFA (Chartered Financial Analyst), CPA (Certified Public Accountant), FRM (Financial Risk Manager), PMP (Project Management Professional), CAIA (Chartered Alternative Investment Analyst), CIPM (Certificate in Investment Performance Measurement). [ENUM-REF-CANDIDATE: finra_series_7|finra_series_63|finra_series_65|finra_series_24|finra_series_66|finra_series_79|finra_series_82|cfa_level_1|cfa_level_2|cfa_level_3|cpa|frm_part_1|frm_part_2|pmp|caia|cipm|cams|cfp|cima — promote to reference product]',
    `lob` STRING COMMENT 'Line of business classification for which this license or certification is applicable. Examples include Investment Banking, Wealth Management, Retail Banking, Trading, Risk Management, Compliance. Used for regulatory headcount reporting and talent analytics.',
    `material_risk_taker_flag` BOOLEAN COMMENT 'Boolean indicator of whether this license or certification is associated with a Material Risk Taker designation under regulatory capital and compensation frameworks. True indicates the employee holding this credential is classified as an MRT under Basel III, CRD IV, or similar frameworks. False indicates no MRT designation.',
    `next_renewal_due_date` DATE COMMENT 'Target date by which the employee must complete renewal requirements to maintain active status. Used for proactive compliance monitoring and workforce planning. Follows yyyy-MM-dd format.',
    `professional_development_plan_flag` BOOLEAN COMMENT 'Boolean indicator of whether this license or certification is part of a formal professional development or career progression plan for the employee. True indicates the credential is linked to a development plan. False indicates it is not part of a formal plan.',
    `regulatory_body_notification_date` DATE COMMENT 'Date on which the regulatory body or internal compliance department was notified of this license or certification status. Nullable if notification has not occurred or is not required. Follows yyyy-MM-dd format.',
    `regulatory_body_notification_status` STRING COMMENT 'Indicates whether the appropriate regulatory body or compliance department has been notified of this license or certification status. Notified indicates successful notification. Pending Notification indicates notification is required but not yet completed. Not Required indicates no notification obligation exists. Failed indicates notification attempt was unsuccessful and requires follow-up.. Valid values are `notified|pending_notification|not_required|failed`',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this license or certification must be included in regulatory headcount, licensing, or fitness and propriety reports submitted to banking regulators. True indicates the credential is reportable. False indicates it is not subject to regulatory reporting.',
    `renewal_date` DATE COMMENT 'Most recent date on which the license or certification was renewed or recertified. Nullable if the credential has never been renewed. Follows yyyy-MM-dd format.',
    `renewal_status` STRING COMMENT 'Current state of the renewal process for this license or certification. Current indicates no renewal action is required at this time. Renewal Required indicates the credential is approaching expiration and renewal must be initiated. Renewal In Progress indicates the employee has started the renewal process. Overdue indicates the renewal deadline has passed. Not Applicable indicates the credential does not require periodic renewal.. Valid values are `current|renewal_required|renewal_in_progress|overdue|not_applicable`',
    `required_for_role_flag` BOOLEAN COMMENT 'Boolean indicator of whether this license or certification is mandatory for the employees current job role or position. True indicates the credential is a regulatory or business requirement for the role. False indicates the credential is elective or supplementary.',
    `source_system` STRING COMMENT 'Name of the source system from which this license or certification record originated. Typically the Human Capital Management System (e.g., Workday, SAP SuccessFactors) or a specialized licensing management platform.',
    `source_system_code` STRING COMMENT 'Unique identifier for this license or certification record in the source system. Used for data lineage, reconciliation, and troubleshooting.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator of whether this license or certification is subject to Sarbanes-Oxley Act internal control requirements. True indicates the credential is part of SOX HR control testing (e.g., for roles with financial reporting responsibilities). False indicates no SOX control applicability.',
    `succession_planning_flag` BOOLEAN COMMENT 'Boolean indicator of whether this license or certification is a requirement or consideration for succession planning and talent pipeline development. True indicates the credential is relevant to succession planning. False indicates it is not a succession planning factor.',
    `verification_date` DATE COMMENT 'Date on which the license or certification was last verified by HR or a third-party service. Used to track the currency of credential validation. Follows yyyy-MM-dd format.',
    `verification_method` STRING COMMENT 'Method by which the license or certification was verified and recorded in the HR system. Self Reported indicates employee-provided information. HR Verified indicates manual verification by HR staff. Third Party Verified indicates validation through an external credentialing service or regulatory database. System Integrated indicates automated verification through API integration with the issuing authority.. Valid values are `self_reported|hr_verified|third_party_verified|system_integrated`',
    CONSTRAINT pk_license_certification PRIMARY KEY(`license_certification_id`)
) COMMENT 'Employee professional license and regulatory certification master record tracking all required and elective credentials. Includes license type (FINRA Series 7, Series 63, Series 65, CFA, CPA, FRM, PMP), issuing authority, license number, issue date, expiration date, renewal status, continuing education hours completed, and regulatory body notification status. Supports FINRA licensing compliance, OCC fitness and propriety requirements, and professional development tracking.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`workforce_plan` (
    `workforce_plan_id` BIGINT COMMENT 'Unique identifier for the workforce and succession planning record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this workforce plan.',
    `hr_position_id` BIGINT COMMENT 'Reference to the critical position being planned for succession or workforce capacity.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit for which this workforce plan applies.',
    `owner_employee_id` BIGINT COMMENT 'Reference to the employee responsible for maintaining and executing this workforce plan.',
    `primary_workforce_successor_employee_id` BIGINT COMMENT 'Reference to the designated successor candidate employee for succession planning.',
    `alco_reporting_flag` BOOLEAN COMMENT 'Indicates whether this workforce plan is included in Asset-Liability Committee (ALCO) workforce cost planning and reporting.',
    `approval_date` DATE COMMENT 'Date when the workforce plan was formally approved by the appropriate authority.',
    `assumed_attrition_count` STRING COMMENT 'Assumed number of employee departures (voluntary and involuntary) during the planning period.',
    `assumed_attrition_rate_pct` DECIMAL(18,2) COMMENT 'Assumed voluntary and involuntary attrition rate as a percentage for the planning period.',
    `board_reporting_flag` BOOLEAN COMMENT 'Indicates whether this workforce plan is subject to board-level talent strategy and talent risk reporting.',
    `budget_currency_code` STRING COMMENT 'Three-letter International Organization for Standardization (ISO) 4217 currency code for the budget envelope amount.. Valid values are `^[A-Z]{3}$`',
    `budget_envelope_amount` DECIMAL(18,2) COMMENT 'Total budget allocation for workforce costs (salaries, benefits, hiring) for this plan in the specified currency.',
    `ccar_stress_scenario_flag` BOOLEAN COMMENT 'Indicates whether this workforce plan is part of Comprehensive Capital Analysis and Review (CCAR) or Dodd-Frank Act Stress Testing (DFAST) stress testing workforce cost projections.',
    `comments` STRING COMMENT 'Free-text comments, notes, or justifications related to the workforce plan assumptions, decisions, or special circumstances.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the workforce plan record was first created in the system.',
    `critical_position_flag` BOOLEAN COMMENT 'Indicates whether the position is designated as critical for business continuity and succession planning per Office of the Comptroller of the Currency (OCC) and Federal Reserve (Fed) senior management succession guidance.',
    `current_headcount_supply` DECIMAL(18,2) COMMENT 'Current available headcount supply in Full-Time Equivalent (FTE) at the start of the planning period.',
    `development_action_plan` STRING COMMENT 'Summary of planned development actions, training, rotations, or experiences required to prepare the successor for the role.',
    `headcount_gap` DECIMAL(18,2) COMMENT 'Calculated gap between projected demand and current supply (demand minus supply) in Full-Time Equivalent (FTE).',
    `job_family` STRING COMMENT 'Job family or functional category for which workforce demand and supply are being planned.',
    `job_level` STRING COMMENT 'Organizational level or grade band for the planned workforce capacity.',
    `key_person_risk_flag` BOOLEAN COMMENT 'Indicates whether the position represents a key person risk requiring board-level oversight and mitigation planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the workforce plan record was last modified or updated.',
    `last_review_date` DATE COMMENT 'Date when the workforce plan was last reviewed and validated for accuracy and relevance.',
    `material_risk_taker_flag` BOOLEAN COMMENT 'Indicates whether the position is designated as a Material Risk Taker (MRT) role subject to enhanced compensation and succession oversight per regulatory requirements.',
    `next_review_due_date` DATE COMMENT 'Date when the next scheduled review of the workforce plan is due.',
    `plan_code` STRING COMMENT 'Business identifier for the workforce plan record, used for external reference and reporting.. Valid values are `^WFP-[A-Z0-9]{6,12}$`',
    `plan_effective_date` DATE COMMENT 'Date when the workforce plan becomes effective and operational.',
    `plan_end_date` DATE COMMENT 'Date when the workforce plan period concludes or expires.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the workforce plan.. Valid values are `draft|submitted|approved|active|archived|cancelled`',
    `plan_type` STRING COMMENT 'Type of planning record: workforce capacity planning, succession planning, or combined strategic plan.. Valid values are `workforce_capacity|succession_planning|combined`',
    `planned_hiring_actions` STRING COMMENT 'Number of planned external hiring actions to address the workforce gap.',
    `planned_internal_moves` STRING COMMENT 'Number of planned internal transfers or promotions to address the workforce gap.',
    `planning_horizon` STRING COMMENT 'Time horizon for the workforce plan: short-term (0-1 year), medium-term (1-3 years), or long-term (3-5 years).. Valid values are `short_term|medium_term|long_term`',
    `projected_headcount_demand` DECIMAL(18,2) COMMENT 'Forecasted headcount demand in Full-Time Equivalent (FTE) for the planning period and scenario.',
    `readiness_horizon` STRING COMMENT 'Time horizon for successor readiness: ready now, ready in 1-2 years, ready in 3-5 years, or not ready.. Valid values are `ready_now|1_2_years|3_5_years|not_ready`',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this workforce plan must be included in regulatory headcount or senior management succession reporting to Office of the Comptroller of the Currency (OCC), Federal Reserve (Fed), or other governing bodies.',
    `retention_risk_rating` STRING COMMENT 'Assessment of flight risk for the successor candidate or current incumbent: low, medium, high, or critical retention risk.. Valid values are `low|medium|high|critical`',
    `scenario_type` STRING COMMENT 'Planning scenario type aligned with stress testing frameworks: base case, stress scenario, growth scenario, adverse, or severely adverse per Comprehensive Capital Analysis and Review (CCAR) and Dodd-Frank Act Stress Testing (DFAST) requirements.. Valid values are `base|stress|growth|adverse|severely_adverse`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this workforce plan is subject to Sarbanes-Oxley Act (SOX) Human Resources (HR) controls for financial reporting integrity.',
    `succession_pool_tier` STRING COMMENT 'Tier classification of the successor candidate within the succession pool: tier 1 (immediate successor), tier 2 (near-term), tier 3 (development pool), or not in pool.. Valid values are `tier_1|tier_2|tier_3|not_in_pool`',
    CONSTRAINT pk_workforce_plan PRIMARY KEY(`workforce_plan_id`)
) COMMENT 'Strategic workforce and succession planning record capturing forward-looking headcount demand/supply projections and leadership continuity plans by business unit. On the workforce planning side, captures planning horizon, scenario type (base, stress, growth), org unit, job family, projected headcount demand, current supply, gap analysis, planned hiring actions, planned attrition assumptions, and budget envelope. On the succession planning side, captures critical positions, designated successor candidates, readiness horizon (ready now, 1-2 years, 3-5 years), succession pool tier, retention risk rating, and development action plans. Supports CCAR/DFAST stress testing workforce cost projections, key person risk assessment, ALCO workforce cost planning, board-level talent strategy and talent risk reporting, and regulatory requirements for senior management succession under OCC/Fed guidance.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`employee_relation_case` (
    `employee_relation_case_id` BIGINT COMMENT 'Unique identifier for the employee relations case record. Primary key for the employee relation case entity.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit or business division where the employee subject to the case is assigned.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who is the subject of this employee relations case.',
    `tertiary_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who last modified this case record, supporting audit trail and accountability requirements.',
    `allegation_summary` STRING COMMENT 'Detailed narrative summary of the allegations, complaints, or issues that triggered the employee relations case, including key facts and circumstances reported.',
    `appeal_filed_date` DATE COMMENT 'Date when the employee formally filed an appeal challenging the case findings or disciplinary action.',
    `appeal_resolution_date` DATE COMMENT 'Date when the appeal was formally resolved with a final decision rendered.',
    `appeal_status` STRING COMMENT 'Status of any employee appeal filed against the investigation findings or disciplinary action taken.. Valid values are `no_appeal|appeal_pending|appeal_granted|appeal_denied|appeal_withdrawn`',
    `case_close_date` DATE COMMENT 'Date when the employee relations case was formally closed after investigation and resolution actions were completed.',
    `case_number` STRING COMMENT 'Externally-known unique business identifier for the employee relations case, typically formatted with prefix and sequential number for tracking and reference purposes.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `case_open_date` DATE COMMENT 'Date when the employee relations case was formally opened and investigation commenced.',
    `case_priority` STRING COMMENT 'Priority level assigned to the case based on severity, regulatory implications, and potential business impact.. Valid values are `low|medium|high|critical`',
    `case_status` STRING COMMENT 'Current lifecycle status of the employee relations case indicating its position in the investigation and resolution workflow.. Valid values are `open|under_investigation|pending_review|closed|escalated|suspended`',
    `case_type` STRING COMMENT 'Classification of the employee relations case indicating the nature of the issue being investigated or addressed. [ENUM-REF-CANDIDATE: grievance|harassment|discrimination|ethics_violation|whistleblower|retaliation|disciplinary|performance|conduct — 9 candidates stripped; promote to reference product]',
    `confidentiality_level` STRING COMMENT 'Classification level indicating the sensitivity and access restrictions for case documentation and investigation details.. Valid values are `standard|restricted|highly_restricted`',
    `cost_center_code` STRING COMMENT 'General Ledger (GL) cost center code associated with the employees organizational assignment for financial tracking and reporting purposes.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee relations case record was first created in the system.',
    `employee_acknowledgement_date` DATE COMMENT 'Date when the employee formally acknowledged the case findings and resolution actions through signature or electronic confirmation.',
    `employee_acknowledgement_status` STRING COMMENT 'Status indicating whether the employee has formally acknowledged receipt and understanding of the investigation findings and resolution actions.. Valid values are `pending|acknowledged|refused|not_required`',
    `ethics_hotline_flag` BOOLEAN COMMENT 'Indicator of whether this case was reported through the corporate ethics hotline or anonymous reporting channel.',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation was completed and findings were documented, prior to resolution action implementation.',
    `investigation_findings` STRING COMMENT 'Comprehensive summary of the investigation findings, conclusions, and determinations made by the investigator based on evidence gathered and interviews conducted.',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation activities commenced following case intake and assignment.',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO country code representing the legal jurisdiction governing employment law compliance for this case.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee relations case record was most recently updated or modified.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicator of whether case documentation and related records are subject to legal hold for preservation due to pending or anticipated litigation.',
    `litigation_risk_flag` BOOLEAN COMMENT 'Indicator of whether this case presents potential employment litigation risk requiring legal department involvement and special handling.',
    `lob` STRING COMMENT 'Line of Business (LOB) designation for the organizational unit where the case originated, used for segment reporting and risk aggregation.',
    `material_risk_taker_flag` BOOLEAN COMMENT 'Indicator of whether the employee subject to this case is classified as a material risk taker under regulatory capital and compensation rules, requiring enhanced oversight and reporting.',
    `pip_initiated_flag` BOOLEAN COMMENT 'Indicator of whether a formal Performance Improvement Plan was initiated as part of the case resolution.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicator of whether this case must be reported to regulatory authorities such as Financial Conduct Authority (FCA), Prudential Regulation Authority (PRA), or Consumer Financial Protection Bureau (CFPB) due to the nature of the violation or employee role.',
    `resolution_action` STRING COMMENT 'Type of disciplinary or corrective action taken as a result of the investigation findings, ranging from no action to termination for cause. [ENUM-REF-CANDIDATE: no_action|verbal_warning|written_warning|pip|suspension|termination|training|mediation|policy_change — 9 candidates stripped; promote to reference product]',
    `resolution_date` DATE COMMENT 'Date when the resolution action was formally communicated to the employee and implemented.',
    `resolution_description` STRING COMMENT 'Detailed description of the resolution actions taken, including specific terms of warnings, Performance Improvement Plan (PIP) requirements, suspension duration, or termination rationale.',
    `retaliation_claim_flag` BOOLEAN COMMENT 'Indicator of whether the case involves allegations of retaliation against an employee for protected activity such as whistleblowing or filing a complaint.',
    `senior_manager_regime_flag` BOOLEAN COMMENT 'Indicator of whether this case involves a senior manager subject to Financial Conduct Authority (FCA) and Prudential Regulation Authority (PRA) Senior Managers and Certification Regime (SMCR) fitness and propriety requirements.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicator of whether this case is subject to Sarbanes-Oxley Act (SOX) internal control requirements, particularly for whistleblower protections and financial reporting integrity.',
    `suspension_end_date` DATE COMMENT 'Date when employee suspension concluded and the employee was eligible to return to work.',
    `suspension_start_date` DATE COMMENT 'Date when employee suspension commenced as a disciplinary action resulting from the case investigation.',
    `termination_for_cause_flag` BOOLEAN COMMENT 'Indicator of whether the case resulted in termination of employment for cause, which has implications for severance, unemployment benefits, and regulatory reporting.',
    `whistleblower_flag` BOOLEAN COMMENT 'Indicator of whether this case originated from a whistleblower complaint, requiring special protections under Sarbanes-Oxley (SOX) Act and Dodd-Frank whistleblower provisions.',
    CONSTRAINT pk_employee_relation_case PRIMARY KEY(`employee_relation_case_id`)
) COMMENT 'Employee relations and disciplinary case management record tracking formal HR investigations, grievances, ethics hotline reports, whistleblower complaints, workplace disputes, and all disciplinary actions. Captures case type (grievance, harassment, discrimination, ethics violation, whistleblower, retaliation, disciplinary), case open date, case status, assigned HR investigator, allegation summary, investigation findings, and resolution actions including verbal warnings, written warnings, performance improvement plans (PIPs), suspensions, terminations for cause, employee acknowledgment status, appeal status, and resolution outcome. Supports SOX whistleblower protections, Dodd-Frank whistleblower provisions, CFPB fair employment compliance, FCA/PRA conduct rule breach investigations, employment law compliance, regulatory fitness and propriety assessments (FCA/PRA Senior Managers Regime), and employment litigation risk management.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`onboarding_event` (
    `onboarding_event_id` BIGINT COMMENT 'Unique identifier for the onboarding or offboarding event record. Primary key for the onboarding event entity.',
    `employee_id` BIGINT COMMENT 'User identifier of the person or system account that last modified the onboarding or offboarding event record. Used for audit trails and accountability.',
    `hr_position_id` BIGINT COMMENT 'Identifier of the HR position being filled (for onboarding) or vacated (for offboarding). Links to the HR position master record for workforce planning and headcount tracking.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Onboarding compliance requirements vary by jurisdiction (I-9 verification, FINRA registration, fitness & propriety reviews). Required for regulatory clearance tracking, compliance workflow management,',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit (department, division, business unit) to which the employee is being onboarded or from which they are offboarding. Links to the organizational unit master record.',
    `primary_onboarding_employee_id` BIGINT COMMENT 'Identifier of the employee undergoing onboarding or offboarding. Links to the employee master record.',
    `previous_onboarding_event_id` BIGINT COMMENT 'Self-referencing FK on onboarding_event (previous_onboarding_event_id)',
    `access_revocation_date` DATE COMMENT 'Date when all system access and entitlements were revoked for the departing employee. Must occur on or before separation date per SOX controls. Null for onboarding events.',
    `access_revocation_status` STRING COMMENT 'Status of access revocation milestone (offboarding only): not applicable (onboarding event), in progress (revocation underway), revoked (access removed), or verified (revocation confirmed by security team). Critical for SOX ITGC and information security compliance.. Valid values are `not_applicable|in_progress|revoked|verified`',
    `actual_completion_date` DATE COMMENT 'Actual date when all onboarding or offboarding milestones were completed and the event was closed. Null if event is still in progress.',
    `background_check_completion_date` DATE COMMENT 'Date when the background check was completed and results were received. Required for regulatory audit trails and Sarbanes-Oxley Act (SOX) Day-1 controls.',
    `background_check_status` STRING COMMENT 'Status of the background check milestone: not started, in progress, cleared (passed), flagged (requires review), or failed (disqualifying findings). Critical for banking regulatory compliance and Office of the Comptroller of the Currency (OCC) fitness and propriety requirements.. Valid values are `not_started|in_progress|cleared|flagged|failed`',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or context related to the onboarding or offboarding event. May include escalation notes, exception approvals, or coordination details.',
    `compliance_training_completion_date` DATE COMMENT 'Date when all mandatory compliance training courses were completed. Required for regulatory reporting and audit evidence.',
    `compliance_training_status` STRING COMMENT 'Status of mandatory compliance training completion milestone: not started, in progress, completed (all required courses finished), or overdue (past due date). Includes Anti-Money Laundering (AML), Know Your Customer (KYC), Bank Secrecy Act (BSA), and ethics training required for banking employees.. Valid values are `not_started|in_progress|completed|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the onboarding or offboarding event record was first created in the system. Used for audit trails and data lineage.',
    `employee_start_date` DATE COMMENT 'Official start date or hire date for the employee (for onboarding events) or the effective date of transfer (for transfer onboarding). Represents the date the employee begins their role.',
    `entitlement_access_review_date` DATE COMMENT 'Date when the entitlement access review was completed and documented. Required for SOX audit evidence and quarterly access certification.',
    `entitlement_access_review_status` STRING COMMENT 'Status of entitlement access review milestone: not started, in progress, completed (access validated and approved), or failed (access violations identified). Required for SOX user access reviews and segregation of duties testing.. Valid values are `not_started|in_progress|completed|failed`',
    `equipment_issuance_date` DATE COMMENT 'Date when equipment was issued to the employee (for onboarding) or returned by the employee (for offboarding). Used for asset tracking and inventory management.',
    `equipment_issuance_status` STRING COMMENT 'Status of equipment issuance or return milestone: not started, in progress, issued (equipment provided to employee), or returned (equipment collected during offboarding). Includes laptops, mobile devices, access badges, and other company property.. Valid values are `not_started|in_progress|issued|returned`',
    `event_number` STRING COMMENT 'Business-facing unique identifier or case number for the onboarding or offboarding event, used for tracking and reference in HR systems and communications.',
    `event_start_date` DATE COMMENT 'Date when the onboarding or offboarding event was initiated or formally commenced. Represents the beginning of the lifecycle process.',
    `event_status` STRING COMMENT 'Current lifecycle status of the onboarding or offboarding event: initiated (event created), in progress (tasks underway), completed (all milestones finished), cancelled (event aborted), or on hold (temporarily paused).. Valid values are `initiated|in_progress|completed|cancelled|on_hold`',
    `event_type` STRING COMMENT 'Type of lifecycle event: new hire onboarding (external hire), transfer onboarding (internal move requiring new access/setup), offboarding (voluntary or involuntary separation), or separation (termination).. Valid values are `new_hire_onboarding|transfer_onboarding|offboarding|separation`',
    `exit_interview_date` DATE COMMENT 'Date when the exit interview was conducted. Null for onboarding events or if exit interview was not completed.',
    `exit_interview_status` STRING COMMENT 'Status of exit interview milestone (offboarding only): not applicable (onboarding event), scheduled, completed, declined (employee refused), or waived (not required). Used for retention analytics and organizational feedback.. Valid values are `not_applicable|scheduled|completed|declined|waived`',
    `finra_registration_date` DATE COMMENT 'Date when FINRA registration was approved or submitted. Null if not applicable to the employee role.',
    `finra_registration_status` STRING COMMENT 'Status of FINRA registration initiation milestone (for registered representatives and broker-dealer employees): not applicable (non-registered role), initiated, submitted (application filed), approved (registration granted), or rejected. Required for investment banking and securities trading roles.. Valid values are `not_applicable|initiated|submitted|approved|rejected`',
    `i9_verification_date` DATE COMMENT 'Date when the I-9 employment eligibility verification was completed. Must be within three business days of hire date per USCIS regulations.',
    `i9_verification_status` STRING COMMENT 'Status of the I-9 employment eligibility verification milestone (U.S. only): not started, in progress, verified (compliant), expired (requires reverification), or failed (ineligible). Required for U.S. labor law compliance.. Valid values are `not_started|in_progress|verified|expired|failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the onboarding or offboarding event record was last updated. Used for audit trails, change tracking, and data quality monitoring.',
    `material_risk_taker_flag` BOOLEAN COMMENT 'Indicates whether the employee is classified as a material risk taker under Basel III and Dodd-Frank compensation rules. Material risk takers are subject to enhanced compensation controls, deferral requirements, and regulatory reporting. True if material risk taker, false otherwise.',
    `occ_fitness_propriety_review_date` DATE COMMENT 'Date when the OCC fitness and propriety review was completed. Null if not applicable to the employee role.',
    `occ_fitness_propriety_status` STRING COMMENT 'Status of OCC fitness and propriety onboarding check (for senior management and material risk taker roles): not applicable (non-covered role), in progress, cleared (approved), or flagged (requires additional review). Required for executive officers, directors, and key control function roles in federally chartered banks.. Valid values are `not_applicable|in_progress|cleared|flagged`',
    `regulatory_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether the role requires regulatory clearance or approval before the employee can begin work (e.g., FINRA registration, OCC fitness and propriety approval, Federal Reserve Board approval for bank holding company officers). True if regulatory clearance required, false otherwise.',
    `separation_date` DATE COMMENT 'Official last working day or termination date for the employee (for offboarding events). Null for onboarding events.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this onboarding or offboarding event is subject to SOX internal control testing and documentation requirements. True if SOX controls apply (e.g., roles with financial reporting access, IT privileged access, or segregation of duties requirements), false otherwise.',
    `sox_day1_control_status` STRING COMMENT 'Status of SOX Day-1 control testing for new hire onboarding: not applicable (offboarding or non-SOX role), passed (controls effective), failed (control deficiency identified), or pending (testing in progress). Validates that access provisioning, segregation of duties, and background checks were completed before system access was granted.. Valid values are `not_applicable|passed|failed|pending`',
    `sox_day1_control_test_date` DATE COMMENT 'Date when SOX Day-1 control testing was performed and documented. Required for SOX compliance audit trails.',
    `system_access_provisioning_date` DATE COMMENT 'Date when system access and entitlements were provisioned or revoked. Used for SOX Day-1 control testing and access review audit trails.',
    `system_access_provisioning_status` STRING COMMENT 'Status of system access and entitlement provisioning milestone: not started, in progress, provisioned (access granted), or revoked (access removed for offboarding). Critical for SOX IT General Controls (ITGC) and segregation of duties.. Valid values are `not_started|in_progress|provisioned|revoked`',
    `target_completion_date` DATE COMMENT 'Planned or target date by which all onboarding or offboarding milestones should be completed. Used for Service Level Agreement (SLA) tracking and workforce planning.',
    CONSTRAINT pk_onboarding_event PRIMARY KEY(`onboarding_event_id`)
) COMMENT 'Employee onboarding and offboarding lifecycle event record tracking the end-to-end process of integrating new hires and separating departing employees. Captures event type (new hire onboarding, transfer onboarding, offboarding/separation), milestone checklist (background check completion, I-9 verification, system access provisioning, compliance training completion, equipment issuance/return, exit interview, access revocation), milestone status, target date, actual completion date, responsible party, and regulatory clearance flags. Supports banking-specific requirements including FINRA registration initiation, entitlement access reviews, SOX Day-1 controls, and OCC fitness and propriety onboarding checks.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`time_attendance` (
    `time_attendance_id` BIGINT COMMENT 'Unique identifier for the time and attendance record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved this time entry, establishing accountability in the approval workflow.',
    `payroll_record_id` BIGINT COMMENT 'Identifier of the payroll run in which this time entry was processed and paid, linking time data to compensation.',
    `primary_time_employee_id` BIGINT COMMENT 'Identifier of the employee to whom this time and attendance record belongs. Links to the employee master data.',
    `parent_time_attendance_id` BIGINT COMMENT 'Self-referencing FK on time_attendance (parent_time_attendance_id)',
    `absence_hours` DECIMAL(18,2) COMMENT 'Number of hours recorded as absence or leave for this time entry, deducted from available leave balances.',
    `absence_type_code` STRING COMMENT 'Code identifying the type of absence when the time entry represents leave or absence (e.g., sick leave, vacation, personal leave, FMLA).',
    `activity_code` STRING COMMENT 'Code identifying the specific activity or task performed during the work period, used for detailed labor analytics and productivity tracking.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry was approved by the authorized approver (typically manager or supervisor).',
    `break_hours` DECIMAL(18,2) COMMENT 'Total duration of breaks taken during the work period, which may be paid or unpaid depending on policy and jurisdiction.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Precise date and time when the employee clocked in or started their work period, captured from time clock or system entry.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Precise date and time when the employee clocked out or ended their work period, captured from time clock or system entry.',
    `comments` STRING COMMENT 'Free-text comments or notes provided by the employee, manager, or timekeeper regarding this time entry.',
    `cost_center_code` STRING COMMENT 'Cost center to which the time and associated labor costs should be allocated for financial reporting and budgeting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this time and attendance record was first created in the system.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of hours worked that qualify for double-time premium pay, typically for work on holidays or beyond a certain overtime threshold.',
    `early_departure_flag` BOOLEAN COMMENT 'Indicator of whether the employee departed early relative to their scheduled end time, used for attendance policy enforcement.',
    `exception_code` STRING COMMENT 'Code identifying any time and attendance exception or policy violation associated with this entry (e.g., missing punch, excessive overtime).',
    `flsa_overtime_eligible_flag` BOOLEAN COMMENT 'Indicator of whether the employee is eligible for FLSA overtime premium pay for hours worked beyond the standard threshold.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this time and attendance record was last updated or modified.',
    `late_arrival_flag` BOOLEAN COMMENT 'Indicator of whether the employee arrived late relative to their scheduled start time, used for attendance policy enforcement.',
    `no_show_flag` BOOLEAN COMMENT 'Indicator of whether the employee failed to report for a scheduled shift without prior notification or approved absence.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked beyond regular hours, typically subject to premium pay rates as defined by labor regulations and employment contracts.',
    `paid_time_off_hours` DECIMAL(18,2) COMMENT 'Number of paid time off hours used for this time entry, drawn from the employees PTO balance.',
    `payroll_processing_date` DATE COMMENT 'Date when this time entry was processed through payroll and included in employee compensation calculations.',
    `project_code` STRING COMMENT 'Project or work order code to which the time should be charged, enabling project-based time tracking and cost allocation.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular work hours recorded for this time entry, typically within standard contracted hours and not subject to overtime premium.',
    `rejection_reason` STRING COMMENT 'Explanation or reason code provided when a time entry is rejected by the approver, requiring correction and resubmission.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Planned or scheduled end time for the work period based on the employees work schedule or shift assignment.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned or scheduled start time for the work period based on the employees work schedule or shift assignment.',
    `shift_code` STRING COMMENT 'Code identifying the scheduled shift or work schedule pattern for this time entry (e.g., day shift, night shift, rotating schedule).',
    `sox_control_flag` BOOLEAN COMMENT 'Indicator of whether this time entry is subject to SOX internal controls for financial reporting accuracy and audit trail requirements.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the employee or timekeeper submitted the time entry for approval.',
    `time_entry_number` STRING COMMENT 'Business identifier for the time entry record, typically system-generated or user-assigned for tracking and reference purposes.',
    `time_entry_source` STRING COMMENT 'Source system or method through which the time entry was captured (time clock, manual entry, mobile app, etc.).. Valid values are `time_clock|manual_entry|mobile_app|web_portal|system_generated|import`',
    `time_entry_status` STRING COMMENT 'Current lifecycle status of the time entry record indicating its position in the approval and processing workflow.. Valid values are `draft|submitted|approved|rejected|processed|cancelled`',
    `time_entry_type` STRING COMMENT 'Classification of the time entry indicating the nature of hours worked or absence recorded (regular hours, overtime, leave, etc.).. Valid values are `regular|overtime|double_time|leave|absence|holiday`',
    `total_hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours worked for this time entry, calculated as the sum of regular, overtime, and double-time hours.',
    `unpaid_leave_hours` DECIMAL(18,2) COMMENT 'Number of unpaid leave hours recorded for this time entry, not compensated and not deducted from paid leave balances.',
    `work_date` DATE COMMENT 'The calendar date on which the work hours or attendance event occurred. Primary business event date for time tracking.',
    `work_location_code` STRING COMMENT 'Code identifying the physical or virtual location where the work was performed (office, branch, remote, client site).',
    CONSTRAINT pk_time_attendance PRIMARY KEY(`time_attendance_id`)
) COMMENT 'Employee time and attendance record capturing work hours, overtime, leave balances, and absence tracking. Includes time entry, approval workflow, and integration with payroll processing.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`succession_plan` (
    `succession_plan_id` BIGINT COMMENT 'Unique identifier for the succession planning record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the executive or board member who approved the succession plan.',
    `hr_position_id` BIGINT COMMENT 'Reference to the critical role or key position being planned for succession.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit or business division where the succession plan applies.',
    `owner_employee_id` BIGINT COMMENT 'Reference to the senior leader or HR business partner responsible for overseeing and maintaining the succession plan.',
    `primary_succession_successor_employee_id` BIGINT COMMENT 'Reference to the primary identified successor employee for the target position.',
    `quaternary_succession_employee_id` BIGINT COMMENT 'Identifier of the system user or HR professional who originally created the succession plan record.',
    `quinary_succession_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who most recently modified the succession plan record.',
    `tertiary_succession_incumbent_employee_id` BIGINT COMMENT 'Reference to the current employee occupying the target position for which succession is being planned.',
    `parent_succession_plan_id` BIGINT COMMENT 'Self-referencing FK on succession_plan (parent_succession_plan_id)',
    `alco_reporting_flag` BOOLEAN COMMENT 'Indicator whether this succession plan is reported to the Asset-Liability Committee due to the positions impact on balance sheet management or liquidity risk.',
    `approval_date` DATE COMMENT 'Date when the succession plan received formal approval from the designated authority.',
    `approval_status` STRING COMMENT 'Current approval state of the succession plan within the governance workflow, indicating whether it has received required management or board endorsement.. Valid values are `pending|approved|rejected|conditional`',
    `board_reporting_flag` BOOLEAN COMMENT 'Indicator whether this succession plan is subject to board-level reporting and oversight, typically for executive or critical roles.',
    `ccar_stress_scenario_flag` BOOLEAN COMMENT 'Indicator whether the succession plan is considered in CCAR stress testing scenarios, particularly for roles critical to capital planning and risk management.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context regarding the succession plan, development progress, or special considerations.',
    `cost_center_code` STRING COMMENT 'Financial accounting cost center code associated with the target position, used for budgeting and expense allocation.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when the succession plan record was first created in the system.',
    `critical_position_flag` BOOLEAN COMMENT 'Indicator whether the target position is classified as business-critical, requiring heightened succession planning rigor and board oversight.',
    `development_plan_description` STRING COMMENT 'Detailed narrative describing the development actions, training programs, stretch assignments, and experiences required to prepare the successor for the target role.',
    `development_plan_status` STRING COMMENT 'Current execution status of the development plan activities for the identified successor.. Valid values are `not_started|in_progress|on_track|delayed|completed`',
    `incumbent_expected_departure_date` DATE COMMENT 'Anticipated date when the current incumbent is expected to vacate the position due to retirement, promotion, or other transition.',
    `key_person_risk_flag` BOOLEAN COMMENT 'Indicator whether the position represents a key person risk where departure or unavailability would materially impact business operations or strategic objectives.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when the succession plan record was most recently updated or modified.',
    `last_review_date` DATE COMMENT 'Date when the succession plan was most recently reviewed for accuracy, relevance, and progress against development milestones.',
    `lob` STRING COMMENT 'Business line or segment to which the target position and succession plan are aligned, such as Retail Banking, Investment Banking, or Wealth Management.',
    `material_risk_taker_flag` BOOLEAN COMMENT 'Indicator whether the target position is designated as a Material Risk Taker role under regulatory frameworks such as CRD IV, requiring enhanced governance and compensation controls.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next mandatory review of the succession plan, ensuring ongoing alignment with business needs and talent availability.',
    `plan_code` STRING COMMENT 'Business identifier or reference code for the succession plan, used for tracking and reporting purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `plan_effective_date` DATE COMMENT 'Date when the succession plan becomes active and enters into force for governance and reporting purposes.',
    `plan_end_date` DATE COMMENT 'Date when the succession plan is scheduled to conclude or be superseded, typically aligned with the transition completion or plan refresh cycle.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the succession plan indicating its stage in the planning and approval workflow. [ENUM-REF-CANDIDATE: draft|active|under_review|approved|on_hold|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `plan_type` STRING COMMENT 'Classification of the succession plan based on urgency, horizon, and strategic importance.. Valid values are `emergency|short_term|long_term|strategic|critical_role|key_talent`',
    `readiness_assessment_date` DATE COMMENT 'Date when the successor readiness level was last assessed or reviewed by management.',
    `readiness_level` STRING COMMENT 'Assessment of how soon the identified successor will be ready to assume the target role, based on skills, experience, and development progress.. Valid values are `ready_now|ready_1_year|ready_2_years|ready_3_plus_years|not_ready`',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicator whether the succession plan must be disclosed to regulatory authorities such as the Federal Reserve, OCC, or EBA under governance or risk management reporting requirements.',
    `retention_risk_rating` STRING COMMENT 'Assessment of the risk that the current incumbent or identified successor may leave the organization, requiring accelerated succession planning.. Valid values are `low|moderate|high|critical`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicator whether the succession plan is subject to SOX internal control requirements, typically for roles with financial reporting or audit responsibilities.',
    `succession_pool_tier` STRING COMMENT 'Classification tier indicating the successors position within the broader talent pool and their priority for development investment.. Valid values are `tier_1|tier_2|tier_3|high_potential|emerging_leader`',
    `target_transition_date` DATE COMMENT 'Planned date by which the successor should be ready to assume the target role, aligning with business continuity requirements.',
    CONSTRAINT pk_succession_plan PRIMARY KEY(`succession_plan_id`)
) COMMENT 'Succession planning record for critical roles and key positions. Captures target position, identified successors, readiness assessment, development actions, and timeline.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`job_requisition` (
    `job_requisition_id` BIGINT COMMENT 'Primary key for job_requisition',
    `approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who provided final approval for the requisition to proceed.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that will bear the financial responsibility for this positions compensation and benefits.',
    `created_by_employee_id` BIGINT COMMENT 'Reference to the employee who initially created the requisition record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager responsible for this requisition and will supervise the hired candidate.',
    `job_profile_id` BIGINT COMMENT 'Reference to the standardized job profile that defines the roles responsibilities, competencies, and requirements.',
    `last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who most recently modified the requisition record.',
    `work_location_id` BIGINT COMMENT 'Reference to the primary work location where the hired employee will be based.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department where the position will be located.',
    `recruiter_employee_id` BIGINT COMMENT 'Reference to the human resources recruiter assigned to manage the recruitment process for this requisition.',
    `replacement_for_employee_id` BIGINT COMMENT 'Reference to the employee being replaced, if this is a backfill or replacement requisition.',
    `parent_job_requisition_id` BIGINT COMMENT 'Self-referencing FK on job_requisition (parent_job_requisition_id)',
    `approval_date` DATE COMMENT 'The date when the requisition received final approval to proceed with recruitment activities.',
    `approval_status` STRING COMMENT 'The current approval state of the requisition within the organizations hiring approval workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the requisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary range (e.g., USD, GBP, EUR).',
    `employment_type` STRING COMMENT 'The type of employment arrangement being offered for this position.',
    `job_description` STRING COMMENT 'Comprehensive narrative describing the roles responsibilities, duties, and expectations.',
    `job_family` STRING COMMENT 'The broad occupational category or functional area to which this position belongs (e.g., Technology, Finance, Operations).',
    `job_level` STRING COMMENT 'The hierarchical level or seniority grade of the position within the organizations job architecture.',
    `job_title` STRING COMMENT 'The official title of the position being recruited for, as it will appear in job postings and employment contracts.',
    `justification` STRING COMMENT 'Business rationale and justification for creating this requisition, including strategic need and budget impact.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the requisition record was most recently updated.',
    `number_of_openings` STRING COMMENT 'The total number of positions to be filled under this requisition.',
    `positions_filled` STRING COMMENT 'The count of positions that have been successfully filled and closed under this requisition.',
    `posting_end_date` DATE COMMENT 'The date when the job posting was removed from public visibility and applications were no longer accepted.',
    `posting_start_date` DATE COMMENT 'The date when the job posting became publicly visible on internal and external job boards.',
    `posting_visibility` STRING COMMENT 'Defines whether the job posting is visible only to internal employees, external candidates, or both.',
    `preferred_qualifications` STRING COMMENT 'Desirable but not mandatory qualifications, skills, or experience that would make a candidate more competitive.',
    `priority_level` STRING COMMENT 'The urgency or business priority assigned to filling this requisition.',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether the position allows for remote or work-from-home arrangements.',
    `required_qualifications` STRING COMMENT 'Mandatory education, certifications, experience, and skills that candidates must possess to be considered for the role.',
    `requisition_closed_date` DATE COMMENT 'The date when the requisition was closed, either due to being filled, cancelled, or withdrawn.',
    `requisition_number` STRING COMMENT 'Externally-visible unique business identifier for the job requisition, typically used in communications and applicant tracking systems.',
    `requisition_opened_date` DATE COMMENT 'The date when the requisition was officially opened and made available for candidate applications.',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the job requisition in the recruitment workflow.',
    `requisition_type` STRING COMMENT 'Classification of the requisition based on the nature of the hiring need.',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'The maximum annual base salary offered for this position in the organizations base currency.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'The minimum annual base salary offered for this position in the organizations base currency.',
    `security_clearance_required` BOOLEAN COMMENT 'Indicates whether the position requires a government or organizational security clearance.',
    `target_start_date` DATE COMMENT 'The desired or planned date by which the hired candidate should commence employment.',
    `travel_requirement_percentage` STRING COMMENT 'The estimated percentage of time the role requires business travel, expressed as an integer from 0 to 100.',
    CONSTRAINT pk_job_requisition PRIMARY KEY(`job_requisition_id`)
) COMMENT 'Master reference table for job_requisition. Referenced by requisition_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Primary key for job_profile',
    `org_unit_id` BIGINT COMMENT 'Identifier of the primary business unit or division where this job profile is typically used.',
    `parent_job_profile_id` BIGINT COMMENT 'Self-referencing FK on job_profile (parent_job_profile_id)',
    `background_check_level` STRING COMMENT 'Level of pre-employment background screening required for this job profile based on risk and regulatory requirements.',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether positions under this job profile are eligible for annual performance bonuses.',
    `compensation_grade` STRING COMMENT 'Salary grade or pay band assigned to this job profile for compensation planning and equity analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this job profile record was first created in the system.',
    `critical_role` BOOLEAN COMMENT 'Indicates whether this job profile is designated as business-critical for succession planning and talent retention.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for salary amounts (e.g., USD, GBP, EUR).',
    `job_profile_description` STRING COMMENT 'Comprehensive narrative describing the purpose, scope, and key responsibilities of the job profile.',
    `eeo_category` STRING COMMENT 'Standard EEO-1 job category used for regulatory reporting and workforce diversity analysis.',
    `effective_end_date` DATE COMMENT 'Date when this job profile was or will be retired from active use. Null for currently active profiles.',
    `effective_start_date` DATE COMMENT 'Date when this job profile became or will become active and available for use in HR processes.',
    `equity_eligible` BOOLEAN COMMENT 'Indicates whether positions under this job profile are eligible for equity compensation (stock options, RSUs).',
    `flsa_classification` STRING COMMENT 'Classification under the Fair Labor Standards Act determining overtime eligibility and wage requirements.',
    `job_function` STRING COMMENT 'Primary functional area or business domain where this job profile operates (e.g., Retail Banking, Investment Banking, Compliance, Treasury).',
    `last_review_date` DATE COMMENT 'Date when this job profile was last reviewed and validated by HR and business leadership.',
    `maximum_salary` DECIMAL(18,2) COMMENT 'Maximum annual base salary for this job profile in the organizations primary currency.',
    `midpoint_salary` DECIMAL(18,2) COMMENT 'Target midpoint annual base salary for fully competent performance in this job profile.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for this job profile (e.g., High School, Bachelors Degree, Masters Degree, Professional Certification).',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for this job profile.',
    `minimum_salary` DECIMAL(18,2) COMMENT 'Minimum annual base salary for this job profile in the organizations primary currency.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this job profile record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this job profile record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review and update of this job profile.',
    `profile_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the job profile in HR systems and organizational documentation.',
    `profile_family` STRING COMMENT 'Broad occupational family or category grouping related job profiles (e.g., Technology, Finance, Operations, Risk Management).',
    `profile_level` STRING COMMENT 'Hierarchical level or seniority tier of the job profile within the organization.',
    `profile_title` STRING COMMENT 'Official title of the job profile as used in organizational charts, job postings, and HR documentation.',
    `regulatory_reporting_role` BOOLEAN COMMENT 'Indicates whether this job profile has responsibilities for regulatory reporting to banking authorities (e.g., Federal Reserve, OCC, FDIC).',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether this job profile is eligible for remote or hybrid work arrangements.',
    `required_certifications` STRING COMMENT 'Professional certifications or licenses required or preferred for this job profile (e.g., CFA, CPA, Series 7, PMP).',
    `soc_code` STRING COMMENT 'US Bureau of Labor Statistics Standard Occupational Classification code for labor market analysis and regulatory reporting.',
    `sox_control_role` BOOLEAN COMMENT 'Indicates whether this job profile has responsibilities for SOX internal controls and financial reporting.',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of the job profile indicating whether it is actively used for hiring and workforce planning.',
    `supervisory_role` BOOLEAN COMMENT 'Indicates whether this job profile includes direct supervisory or people management responsibilities.',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of work time requiring business travel for this job profile.',
    `typical_span_of_control` STRING COMMENT 'Typical number of direct reports for supervisory positions under this job profile.',
    `created_by` STRING COMMENT 'User identifier of the person who created this job profile record.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Master reference table for job_profile. Referenced by job_profile_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`work_location` (
    `work_location_id` BIGINT COMMENT 'Primary key for work_location',
    `parent_work_location_id` BIGINT COMMENT 'Self-referencing FK on work_location (parent_work_location_id)',
    `accessibility_compliant_flag` BOOLEAN COMMENT 'Indicates whether the work location meets accessibility standards for individuals with disabilities.',
    `address_line_1` STRING COMMENT 'Primary street address line for the work location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, floor, or building details. Organizational contact data classified as confidential.',
    `building_name` STRING COMMENT 'Name of the building or complex where the work location is housed.',
    `business_unit_code` STRING COMMENT 'Code identifying the primary business unit or division operating at this location.',
    `city` STRING COMMENT 'City or municipality where the work location is situated. Organizational contact data classified as confidential.',
    `cost_center_code` STRING COMMENT 'Financial cost center code associated with this work location for expense allocation.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the work location is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work location record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this work location ceased operations or was closed, if applicable.',
    `effective_start_date` DATE COMMENT 'Date when this work location became operational and available for employee assignment.',
    `email_address` STRING COMMENT 'General contact email address for the work location. Organizational contact data classified as confidential.',
    `emergency_contact_name` STRING COMMENT 'Name of the primary emergency contact person for this work location.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact person for this work location. Organizational contact data classified as confidential.',
    `fax_number` STRING COMMENT 'Fax number for the work location if applicable. Organizational contact data classified as confidential.',
    `floor_number` STRING COMMENT 'Floor or level identifier within the building (e.g., 5, Ground, Mezzanine).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work location record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the work location in decimal degrees.',
    `lease_expiration_date` DATE COMMENT 'Date when the lease agreement for this work location expires, if applicable.',
    `lease_owned_indicator` STRING COMMENT 'Indicates whether the work location is owned by the bank or leased from a third party.',
    `location_code` STRING COMMENT 'Business identifier code for the work location used in HR systems and reporting. Externally-known unique code.',
    `location_name` STRING COMMENT 'Human-readable name of the work location (e.g., New York Headquarters, London Trading Floor).',
    `location_status` STRING COMMENT 'Current operational status of the work location in its lifecycle.',
    `location_type` STRING COMMENT 'Classification of the work location by its primary business function.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the work location in decimal degrees.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the work location. Organizational contact data classified as confidential.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the work location address. Organizational contact data classified as confidential.',
    `region_code` STRING COMMENT 'Business region or geographic division code to which this work location belongs.',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Indicates whether employees assigned to this location are eligible for remote work arrangements.',
    `seating_capacity` STRING COMMENT 'Maximum number of employees that can be seated at this work location.',
    `security_level` STRING COMMENT 'Physical security classification level required for access to this work location.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the work location measured in square feet.',
    `state_province` STRING COMMENT 'State, province, or administrative region of the work location. Organizational contact data classified as confidential.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the work location (e.g., America/New_York, Europe/London).',
    CONSTRAINT pk_work_location PRIMARY KEY(`work_location_id`)
) COMMENT 'Master reference table for work_location. Referenced by location_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`learning_course` (
    `learning_course_id` BIGINT COMMENT 'Primary key for learning_course',
    `employee_id` BIGINT COMMENT 'Employee identifier of the subject matter expert or business owner responsible for the course content.',
    `replacement_course_id` BIGINT COMMENT 'Identifier of the successor course that replaces this course when it is retired or superseded.',
    `parent_learning_course_id` BIGINT COMMENT 'Self-referencing FK on learning_course (parent_learning_course_id)',
    `accreditation_body` STRING COMMENT 'Name of the external professional or regulatory body that has accredited or approved this course.',
    `accreditation_number` STRING COMMENT 'Unique identifier or reference number assigned by the accreditation body for this course.',
    `assessment_method` STRING COMMENT 'The type of evaluation or testing mechanism used to measure learner comprehension and course completion.',
    `business_unit` STRING COMMENT 'The organizational business unit or division that sponsors or owns this learning course.',
    `certification_awarded` STRING COMMENT 'Name of the professional certification or credential awarded upon successful course completion, if applicable.',
    `competency_framework` STRING COMMENT 'The competency model or skills framework this course aligns with and contributes to.',
    `compliance_category` STRING COMMENT 'The regulatory or compliance domain this course addresses (e.g., Anti-Money Laundering, SOX, GDPR, Fair Lending).',
    `cost_per_learner` DECIMAL(18,2) COMMENT 'The cost incurred per individual learner enrollment in the course, including licensing and delivery costs.',
    `course_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the course in the learning management system and course catalog.',
    `course_description` STRING COMMENT 'Detailed description of the course content, learning objectives, and outcomes.',
    `course_title` STRING COMMENT 'Full official title of the learning course as displayed in catalogs and transcripts.',
    `course_type` STRING COMMENT 'Classification of the course by its primary purpose and content category.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the course record was first created in the learning management system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of continuing education or professional development credits awarded upon successful course completion.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per learner amount.',
    `delivery_method` STRING COMMENT 'The instructional delivery format through which the course content is provided to learners.',
    `difficulty_level` STRING COMMENT 'The complexity and prerequisite knowledge level required for the course.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total instructional time required to complete the course, measured in hours.',
    `effective_end_date` DATE COMMENT 'The date after which the course is no longer available for new enrollments, if applicable.',
    `effective_start_date` DATE COMMENT 'The date from which the course becomes available for enrollment and delivery.',
    `is_externally_available` BOOLEAN COMMENT 'Indicates whether the course is available to external clients, partners, or the public, or restricted to internal employees only.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the course is required for specific employee populations or job roles.',
    `is_regulatory_required` BOOLEAN COMMENT 'Indicates whether the course is mandated by regulatory bodies or compliance frameworks.',
    `language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language of instruction.',
    `last_content_review_date` DATE COMMENT 'The most recent date when the course content was reviewed for accuracy, relevance, and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the course record was most recently updated or modified.',
    `learning_objectives` STRING COMMENT 'Structured list of measurable learning outcomes and competencies learners will achieve upon course completion.',
    `maximum_enrollment` STRING COMMENT 'Maximum number of learners that can be enrolled in a single course offering or session.',
    `next_review_due_date` DATE COMMENT 'The scheduled date by which the course content must undergo its next review cycle.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required to successfully complete and pass the course assessment.',
    `prerequisite_courses` STRING COMMENT 'Comma-separated list of course codes that must be completed before enrolling in this course.',
    `recertification_period_months` STRING COMMENT 'Number of months after which learners must retake or renew the course to maintain compliance or certification.',
    `retired_date` DATE COMMENT 'The date when the course was officially retired or withdrawn from the active course catalog.',
    `learning_course_status` STRING COMMENT 'Current lifecycle status of the course indicating its availability and operational state.',
    `target_audience` STRING COMMENT 'Description of the intended learner population, job families, or organizational levels for whom this course is designed.',
    `vendor_name` STRING COMMENT 'Name of the external training provider or content vendor if the course is sourced externally.',
    `version_number` STRING COMMENT 'Version identifier for the course content, incremented when significant updates or revisions are made.',
    CONSTRAINT pk_learning_course PRIMARY KEY(`learning_course_id`)
) COMMENT 'Master reference table for learning_course. Referenced by course_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Primary key for payroll_run',
    `created_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who created this payroll run record.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who approved this payroll run for posting.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this payroll run record.',
    `previous_payroll_run_id` BIGINT COMMENT 'Self-referencing FK on payroll_run (previous_payroll_run_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll run was approved for posting.',
    `calculation_end_timestamp` TIMESTAMP COMMENT 'Timestamp when payroll calculation processing completed for this run.',
    `calculation_start_timestamp` TIMESTAMP COMMENT 'Timestamp when payroll calculation processing began for this run.',
    `company_code` STRING COMMENT 'Legal entity or company code for which this payroll run is being processed.',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the jurisdiction for this payroll run.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this payroll run.',
    `employee_count` STRING COMMENT 'Total number of employees included in this payroll run.',
    `error_count` STRING COMMENT 'Number of errors encountered during payroll calculation for this run.',
    `fiscal_period` STRING COMMENT 'Fiscal period within the fiscal year for this payroll run.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this payroll run is recorded for financial reporting purposes.',
    `gl_posting_date` DATE COMMENT 'The accounting date on which this payroll run was posted to the general ledger.',
    `is_final_run` BOOLEAN COMMENT 'Indicates whether this is the final payroll run for the pay period, after which no further adjustments are allowed.',
    `is_retroactive` BOOLEAN COMMENT 'Indicates whether this payroll run includes retroactive pay adjustments for prior periods.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll run record was last modified.',
    `pay_frequency` STRING COMMENT 'The frequency at which employees are paid in this payroll run cycle.',
    `pay_group_code` STRING COMMENT 'Code identifying the pay group or employee segment processed in this payroll run, used for organizing employees with similar pay characteristics.',
    `pay_period_end_date` DATE COMMENT 'The last date of the pay period covered by this payroll run.',
    `pay_period_start_date` DATE COMMENT 'The first date of the pay period covered by this payroll run.',
    `payment_date` DATE COMMENT 'The date on which employees will receive payment for this payroll run.',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll run was posted to the general ledger and finalized.',
    `processing_notes` STRING COMMENT 'Free-text notes documenting special circumstances, exceptions, or instructions related to this payroll run.',
    `run_number` STRING COMMENT 'Business identifier for the payroll run, externally visible and used for reference in communications and reporting.',
    `run_type` STRING COMMENT 'Classification of the payroll run indicating the purpose and nature of the payroll processing cycle.',
    `payroll_run_status` STRING COMMENT 'Current lifecycle status of the payroll run indicating its position in the processing workflow.',
    `total_deductions_amount` DECIMAL(18,2) COMMENT 'Total amount of all deductions (taxes, benefits, garnishments) for this payroll run.',
    `total_employer_benefits_amount` DECIMAL(18,2) COMMENT 'Total employer-paid benefits contributions for this payroll run.',
    `total_employer_taxes_amount` DECIMAL(18,2) COMMENT 'Total employer-paid payroll taxes for this payroll run.',
    `total_gross_pay_amount` DECIMAL(18,2) COMMENT 'Total gross pay amount for all employees included in this payroll run before any deductions.',
    `total_net_pay_amount` DECIMAL(18,2) COMMENT 'Total net pay amount distributed to employees in this payroll run after all deductions.',
    `warning_count` STRING COMMENT 'Number of warnings generated during payroll calculation for this run.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master reference table for payroll_run. Referenced by payroll_run_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`review_cycle` (
    `review_cycle_id` BIGINT COMMENT 'Primary key for review_cycle',
    `employee_id` BIGINT COMMENT 'Reference to the senior leader or executive who approved the launch of this review cycle.',
    `competency_framework_id` BIGINT COMMENT 'Reference to the competency framework applied in this review cycle for evaluating employee capabilities.',
    `created_by_employee_id` BIGINT COMMENT 'Reference to the employee who created this review cycle record.',
    `modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who last modified this review cycle record.',
    `owner_employee_id` BIGINT COMMENT 'Reference to the HR business partner or administrator responsible for managing this review cycle.',
    `rating_scale_id` BIGINT COMMENT 'Reference to the rating scale used for this review cycle (e.g., 1-5 scale, exceeds/meets/below expectations).',
    `previous_review_cycle_id` BIGINT COMMENT 'Self-referencing FK on review_cycle (previous_review_cycle_id)',
    `approval_date` DATE COMMENT 'The date when this review cycle was approved for launch (yyyy-MM-dd).',
    `approval_required` BOOLEAN COMMENT 'Indicates whether senior leadership approval is required before finalizing ratings in this cycle (True/False).',
    `calibration_end_date` DATE COMMENT 'The date by which all calibration activities must be completed (yyyy-MM-dd).',
    `calibration_required` BOOLEAN COMMENT 'Indicates whether calibration sessions are mandatory for this review cycle to ensure rating consistency (True/False).',
    `calibration_start_date` DATE COMMENT 'The date when calibration sessions begin to normalize ratings across the organization (yyyy-MM-dd).',
    `compensation_linked` BOOLEAN COMMENT 'Indicates whether performance ratings from this cycle are directly linked to compensation decisions (True/False).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this review cycle record was first created in the system (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `cycle_close_date` DATE COMMENT 'The date when the review cycle is officially closed and no further changes are permitted (yyyy-MM-dd).',
    `cycle_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the review cycle for external reference and reporting (e.g., RC-2024-ANN, RC-2024-Q2).',
    `cycle_launch_date` DATE COMMENT 'The date when the review cycle is officially launched and made available to participants (yyyy-MM-dd).',
    `cycle_name` STRING COMMENT 'Human-readable name of the review cycle (e.g., FY2024 Annual Performance Review, Q2 2024 Mid-Year Review).',
    `cycle_type` STRING COMMENT 'Classification of the review cycle based on frequency and purpose (annual, mid-year, quarterly, probationary, project-based, ad-hoc).',
    `review_cycle_description` STRING COMMENT 'Detailed description of the review cycle purpose, scope, and any special instructions for participants.',
    `eligible_employee_count` STRING COMMENT 'The total number of employees eligible to participate in this review cycle.',
    `feedback_delivery_due_date` DATE COMMENT 'The deadline by which all performance feedback must be delivered to employees (yyyy-MM-dd).',
    `feedback_delivery_start_date` DATE COMMENT 'The date when managers can begin delivering finalized performance feedback to employees (yyyy-MM-dd).',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this review cycle belongs (e.g., 2024).',
    `goal_setting_enabled` BOOLEAN COMMENT 'Indicates whether goal setting is enabled as part of this review cycle (True/False).',
    `instructions_url` STRING COMMENT 'URL link to detailed instructions, guidelines, or training materials for participants in this review cycle.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this review cycle is currently active and visible in the system (True/False). Used for soft deletion.',
    `manager_review_due_date` DATE COMMENT 'The deadline by which managers must complete performance reviews (yyyy-MM-dd).',
    `manager_review_start_date` DATE COMMENT 'The date when managers can begin conducting performance reviews (yyyy-MM-dd).',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this review cycle record was last modified (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether automated email/system notifications are enabled for this review cycle (True/False).',
    `participation_rate_target_pct` DECIMAL(18,2) COMMENT 'The target participation rate for this review cycle expressed as a percentage (e.g., 95.00 for 95%).',
    `peer_feedback_enabled` BOOLEAN COMMENT 'Indicates whether peer feedback collection is enabled for this review cycle (True/False).',
    `reminder_frequency_days` STRING COMMENT 'The frequency in days at which reminder notifications are sent to participants with pending actions (e.g., 7 for weekly reminders).',
    `review_period_end_date` DATE COMMENT 'The end date of the performance period being evaluated in this review cycle (yyyy-MM-dd).',
    `review_period_start_date` DATE COMMENT 'The start date of the performance period being evaluated in this review cycle (yyyy-MM-dd).',
    `self_assessment_due_date` DATE COMMENT 'The deadline by which employees must complete their self-assessments (yyyy-MM-dd).',
    `self_assessment_required` BOOLEAN COMMENT 'Indicates whether employees are required to complete a self-assessment as part of this review cycle (True/False).',
    `self_assessment_start_date` DATE COMMENT 'The date when employees can begin submitting their self-assessments (yyyy-MM-dd).',
    `review_cycle_status` STRING COMMENT 'Current lifecycle status of the review cycle (draft, scheduled, active, in_progress, completed, closed, cancelled).',
    `succession_planning_linked` BOOLEAN COMMENT 'Indicates whether this review cycle feeds into succession planning and talent pipeline decisions (True/False).',
    `upward_feedback_enabled` BOOLEAN COMMENT 'Indicates whether upward feedback (employee feedback on manager) is enabled for this review cycle (True/False).',
    CONSTRAINT pk_review_cycle PRIMARY KEY(`review_cycle_id`)
) COMMENT 'Master reference table for review_cycle. Referenced by review_cycle_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`rating_scale` (
    `rating_scale_id` BIGINT COMMENT 'Primary key for rating_scale',
    `parent_rating_scale_id` BIGINT COMMENT 'Self-referencing FK on rating_scale (parent_rating_scale_id)',
    `allows_half_points` BOOLEAN COMMENT 'Indicates whether the rating scale permits half-point or fractional ratings (e.g., 3.5 on a 5-point scale).',
    `applicable_employee_types` STRING COMMENT 'Types of employees for whom this rating scale is used (e.g., Full-Time, Part-Time, Contract, Temporary).',
    `applicable_job_levels` STRING COMMENT 'Comma-separated list or description of job levels or grades to which this rating scale applies (e.g., Executive, Manager, Individual Contributor).',
    `approved_by` STRING COMMENT 'Identifier or name of the HR leader or governance authority who approved this rating scale for organizational use.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this rating scale was formally approved for use.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rating scale record was first created in the system.',
    `default_midpoint_value` DECIMAL(18,2) COMMENT 'The neutral or midpoint value on the scale, often representing meets expectations or satisfactory performance.',
    `rating_scale_description` STRING COMMENT 'Detailed description of the rating scale, its purpose, and guidance on when to use it.',
    `display_order` STRING COMMENT 'Numeric value controlling the sort order when displaying multiple rating scales in user interfaces or reports.',
    `effective_end_date` DATE COMMENT 'The date on which this rating scale is retired or replaced. Null indicates the scale is currently in use with no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this rating scale becomes active and available for use in performance evaluations and assessments.',
    `increment_value` DECIMAL(18,2) COMMENT 'The step or increment between rating values (e.g., 0.5 for half-point increments, 1.0 for whole numbers).',
    `is_bidirectional` BOOLEAN COMMENT 'Indicates whether the scale measures in both positive and negative directions (e.g., -2 to +2 for improvement/decline scales).',
    `is_default_scale` BOOLEAN COMMENT 'Indicates whether this rating scale is the default scale used when no specific scale is assigned to an evaluation.',
    `is_numeric` BOOLEAN COMMENT 'Indicates whether the rating scale uses numeric values (true) or qualitative labels only (false).',
    `language_code` STRING COMMENT 'ISO 639-1 language code indicating the primary language for this rating scale definition (e.g., en, en-US, fr).',
    `last_modified_by` STRING COMMENT 'Identifier or name of the user or system that last modified this rating scale record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this rating scale record was last updated.',
    `maximum_value` DECIMAL(18,2) COMMENT 'The highest numeric value on the rating scale (e.g., 5 for a 1-5 scale).',
    `minimum_value` DECIMAL(18,2) COMMENT 'The lowest numeric value on the rating scale (e.g., 1 for a 1-5 scale).',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or guidance related to the rating scale for administrative or training purposes.',
    `number_of_levels` STRING COMMENT 'Total count of distinct rating levels or points on the scale (e.g., 5 for a 5-point scale).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this rating scale is required for regulatory compliance or audit purposes (e.g., SOX HR controls, labor law compliance).',
    `scale_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the rating scale for system integration and reporting (e.g., PERF_5PT, LEAD_COMP).',
    `scale_name` STRING COMMENT 'The business name of the rating scale (e.g., 5-Point Performance Scale, Leadership Competency Scale).',
    `scale_status` STRING COMMENT 'Current lifecycle status of the rating scale indicating whether it is available for use in evaluations.',
    `scale_type` STRING COMMENT 'The category or purpose of the rating scale (e.g., performance evaluation, competency assessment, behavioral rating).',
    `source_system` STRING COMMENT 'The name of the source system from which this rating scale was ingested (e.g., Workday, SAP SuccessFactors).',
    `source_system_id` STRING COMMENT 'The unique identifier for this rating scale in the source system of record.',
    `usage_context` STRING COMMENT 'Description of the business contexts where this rating scale is applied (e.g., annual reviews, 360 feedback, probation assessments).',
    `version_number` STRING COMMENT 'Version identifier for the rating scale definition, supporting change tracking and historical analysis (e.g., 1.0, 2.1).',
    `created_by` STRING COMMENT 'Identifier or name of the user or system that created this rating scale record.',
    CONSTRAINT pk_rating_scale PRIMARY KEY(`rating_scale_id`)
) COMMENT 'Master reference table for rating_scale. Referenced by rating_scale_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`hr`.`competency_framework` (
    `competency_framework_id` BIGINT COMMENT 'Primary key for competency_framework',
    `parent_competency_framework_id` BIGINT COMMENT 'Self-referencing FK on competency_framework (parent_competency_framework_id)',
    `approval_date` DATE COMMENT 'The date on which this competency framework was formally approved for organizational use.',
    `approval_status` STRING COMMENT 'Current approval status of the competency framework within the governance workflow.',
    `approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who approved this competency framework for use.',
    `assessment_method` STRING COMMENT 'Description of the primary method used to assess competencies within this framework (e.g., self-assessment, manager evaluation, 360-degree feedback, skills testing).',
    `business_unit_id` BIGINT COMMENT 'Reference to the business unit or division for which this competency framework is designed. Null if framework is organization-wide.',
    `competencies_count` STRING COMMENT 'The total number of individual competencies defined within this framework.',
    `created_by_employee_id` BIGINT COMMENT 'Reference to the employee who created this competency framework record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this competency framework record was first created in the system.',
    `competency_framework_description` STRING COMMENT 'Detailed description of the competency framework, including its purpose, scope, and intended application within the organization.',
    `effective_end_date` DATE COMMENT 'The date on which this competency framework ceases to be active. Null for frameworks with no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this competency framework becomes active and applicable for assessments, development planning, and performance management.',
    `external_reference_id` STRING COMMENT 'The unique identifier for this competency framework in the source system or external HR platform.',
    `framework_category` STRING COMMENT 'Categorization indicating the scope and application context of the framework within the organization.',
    `framework_code` STRING COMMENT 'Business identifier code for the competency framework, used for external reference and integration with HR systems.',
    `framework_name` STRING COMMENT 'The official name of the competency framework (e.g., Leadership Competencies, Technical Skills Framework, Risk Management Competencies).',
    `framework_type` STRING COMMENT 'Classification of the competency framework by its primary focus area.',
    `geographic_scope` STRING COMMENT 'The geographic regions or countries where this competency framework is applicable, using ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, SGP) or GLOBAL for worldwide application.',
    `industry_standard_alignment` STRING COMMENT 'Reference to external industry standards or professional bodies that this competency framework aligns with (e.g., CFA Institute, GARP, ACCA).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether assessment against this competency framework is mandatory for employees within its scope.',
    `job_family_id` BIGINT COMMENT 'Reference to the job family associated with this competency framework. Null if framework applies across multiple job families.',
    `language_code` STRING COMMENT 'The primary language in which this competency framework is authored, using ISO 639-1 two-letter language codes.',
    `last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who last modified this competency framework record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this competency framework record was last updated.',
    `last_review_date` DATE COMMENT 'The date on which this competency framework was last reviewed for accuracy and relevance.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review of this competency framework.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the competency framework, including implementation guidance or special considerations.',
    `owner_employee_id` BIGINT COMMENT 'Reference to the employee responsible for maintaining and governing this competency framework.',
    `proficiency_levels_count` STRING COMMENT 'The number of proficiency levels defined within this competency framework (e.g., 3-level, 5-level, 7-level scale).',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulatory requirement or compliance framework that mandates this competency framework.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this competency framework is required to meet specific regulatory or compliance obligations (e.g., MiFID II, Dodd-Frank, Basel III).',
    `review_frequency_months` STRING COMMENT 'The number of months between scheduled reviews of this competency framework to ensure continued relevance and alignment with business needs.',
    `source_system` STRING COMMENT 'The name of the system of record from which this competency framework data originates (e.g., Workday, SAP SuccessFactors, custom HRMS).',
    `competency_framework_status` STRING COMMENT 'Current lifecycle status of the competency framework indicating its availability for use in talent management processes.',
    `usage_scope` STRING COMMENT 'The primary HR processes and talent management activities where this competency framework is applied.',
    `version_number` STRING COMMENT 'Version identifier for the competency framework, following semantic versioning to track revisions and updates.',
    CONSTRAINT pk_competency_framework PRIMARY KEY(`competency_framework_id`)
) COMMENT 'Master reference table for competency_framework. Referenced by competency_framework_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`hr`.`employee` ADD CONSTRAINT `fk_hr_employee_hr_position_id` FOREIGN KEY (`hr_position_id`) REFERENCES `banking_ecm`.`hr`.`hr_position`(`hr_position_id`);
ALTER TABLE `banking_ecm`.`hr`.`employee` ADD CONSTRAINT `fk_hr_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ADD CONSTRAINT `fk_hr_hr_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `banking_ecm`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ADD CONSTRAINT `fk_hr_hr_position_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `banking_ecm`.`hr`.`work_location`(`work_location_id`);
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ADD CONSTRAINT `fk_hr_hr_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ADD CONSTRAINT `fk_hr_hr_position_reporting_position_hr_position_id` FOREIGN KEY (`reporting_position_hr_position_id`) REFERENCES `banking_ecm`.`hr`.`hr_position`(`hr_position_id`);
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ADD CONSTRAINT `fk_hr_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ADD CONSTRAINT `fk_hr_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ADD CONSTRAINT `fk_hr_payroll_record_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `banking_ecm`.`hr`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ADD CONSTRAINT `fk_hr_compensation_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ADD CONSTRAINT `fk_hr_compensation_event_primary_compensation_employee_id` FOREIGN KEY (`primary_compensation_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ADD CONSTRAINT `fk_hr_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `banking_ecm`.`hr`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ADD CONSTRAINT `fk_hr_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`candidate` ADD CONSTRAINT `fk_hr_candidate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`candidate` ADD CONSTRAINT `fk_hr_candidate_candidate_hiring_manager_employee_id` FOREIGN KEY (`candidate_hiring_manager_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`candidate` ADD CONSTRAINT `fk_hr_candidate_candidate_referral_employee_id` FOREIGN KEY (`candidate_referral_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`candidate` ADD CONSTRAINT `fk_hr_candidate_job_requisition_id` FOREIGN KEY (`job_requisition_id`) REFERENCES `banking_ecm`.`hr`.`job_requisition`(`job_requisition_id`);
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ADD CONSTRAINT `fk_hr_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ADD CONSTRAINT `fk_hr_performance_review_primary_performance_employee_id` FOREIGN KEY (`primary_performance_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ADD CONSTRAINT `fk_hr_performance_review_review_cycle_id` FOREIGN KEY (`review_cycle_id`) REFERENCES `banking_ecm`.`hr`.`review_cycle`(`review_cycle_id`);
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ADD CONSTRAINT `fk_hr_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ADD CONSTRAINT `fk_hr_learning_enrollment_learning_course_id` FOREIGN KEY (`learning_course_id`) REFERENCES `banking_ecm`.`hr`.`learning_course`(`learning_course_id`);
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ADD CONSTRAINT `fk_hr_learning_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ADD CONSTRAINT `fk_hr_learning_enrollment_tertiary_learning_modified_by_user_employee_id` FOREIGN KEY (`tertiary_learning_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ADD CONSTRAINT `fk_hr_regulatory_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ADD CONSTRAINT `fk_hr_regulatory_disclosure_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ADD CONSTRAINT `fk_hr_regulatory_disclosure_original_disclosure_regulatory_disclosure_id` FOREIGN KEY (`original_disclosure_regulatory_disclosure_id`) REFERENCES `banking_ecm`.`hr`.`regulatory_disclosure`(`regulatory_disclosure_id`);
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ADD CONSTRAINT `fk_hr_regulatory_disclosure_primary_regulatory_employee_id` FOREIGN KEY (`primary_regulatory_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ADD CONSTRAINT `fk_hr_regulatory_disclosure_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ADD CONSTRAINT `fk_hr_regulatory_disclosure_tertiary_regulatory_preparer_employee_id` FOREIGN KEY (`tertiary_regulatory_preparer_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ADD CONSTRAINT `fk_hr_license_certification_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ADD CONSTRAINT `fk_hr_license_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ADD CONSTRAINT `fk_hr_license_certification_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ADD CONSTRAINT `fk_hr_license_certification_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ADD CONSTRAINT `fk_hr_workforce_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ADD CONSTRAINT `fk_hr_workforce_plan_hr_position_id` FOREIGN KEY (`hr_position_id`) REFERENCES `banking_ecm`.`hr`.`hr_position`(`hr_position_id`);
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ADD CONSTRAINT `fk_hr_workforce_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ADD CONSTRAINT `fk_hr_workforce_plan_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ADD CONSTRAINT `fk_hr_workforce_plan_primary_workforce_successor_employee_id` FOREIGN KEY (`primary_workforce_successor_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ADD CONSTRAINT `fk_hr_employee_relation_case_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ADD CONSTRAINT `fk_hr_employee_relation_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ADD CONSTRAINT `fk_hr_employee_relation_case_tertiary_modified_by_user_employee_id` FOREIGN KEY (`tertiary_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ADD CONSTRAINT `fk_hr_onboarding_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ADD CONSTRAINT `fk_hr_onboarding_event_hr_position_id` FOREIGN KEY (`hr_position_id`) REFERENCES `banking_ecm`.`hr`.`hr_position`(`hr_position_id`);
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ADD CONSTRAINT `fk_hr_onboarding_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ADD CONSTRAINT `fk_hr_onboarding_event_primary_onboarding_employee_id` FOREIGN KEY (`primary_onboarding_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ADD CONSTRAINT `fk_hr_onboarding_event_previous_onboarding_event_id` FOREIGN KEY (`previous_onboarding_event_id`) REFERENCES `banking_ecm`.`hr`.`onboarding_event`(`onboarding_event_id`);
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ADD CONSTRAINT `fk_hr_time_attendance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ADD CONSTRAINT `fk_hr_time_attendance_payroll_record_id` FOREIGN KEY (`payroll_record_id`) REFERENCES `banking_ecm`.`hr`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ADD CONSTRAINT `fk_hr_time_attendance_primary_time_employee_id` FOREIGN KEY (`primary_time_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ADD CONSTRAINT `fk_hr_time_attendance_parent_time_attendance_id` FOREIGN KEY (`parent_time_attendance_id`) REFERENCES `banking_ecm`.`hr`.`time_attendance`(`time_attendance_id`);
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ADD CONSTRAINT `fk_hr_succession_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ADD CONSTRAINT `fk_hr_succession_plan_hr_position_id` FOREIGN KEY (`hr_position_id`) REFERENCES `banking_ecm`.`hr`.`hr_position`(`hr_position_id`);
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ADD CONSTRAINT `fk_hr_succession_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ADD CONSTRAINT `fk_hr_succession_plan_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ADD CONSTRAINT `fk_hr_succession_plan_primary_succession_successor_employee_id` FOREIGN KEY (`primary_succession_successor_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ADD CONSTRAINT `fk_hr_succession_plan_quaternary_succession_employee_id` FOREIGN KEY (`quaternary_succession_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ADD CONSTRAINT `fk_hr_succession_plan_quinary_succession_last_modified_by_user_employee_id` FOREIGN KEY (`quinary_succession_last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ADD CONSTRAINT `fk_hr_succession_plan_tertiary_succession_incumbent_employee_id` FOREIGN KEY (`tertiary_succession_incumbent_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ADD CONSTRAINT `fk_hr_succession_plan_parent_succession_plan_id` FOREIGN KEY (`parent_succession_plan_id`) REFERENCES `banking_ecm`.`hr`.`succession_plan`(`succession_plan_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ADD CONSTRAINT `fk_hr_job_requisition_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ADD CONSTRAINT `fk_hr_job_requisition_created_by_employee_id` FOREIGN KEY (`created_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ADD CONSTRAINT `fk_hr_job_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ADD CONSTRAINT `fk_hr_job_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `banking_ecm`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ADD CONSTRAINT `fk_hr_job_requisition_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ADD CONSTRAINT `fk_hr_job_requisition_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `banking_ecm`.`hr`.`work_location`(`work_location_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ADD CONSTRAINT `fk_hr_job_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ADD CONSTRAINT `fk_hr_job_requisition_recruiter_employee_id` FOREIGN KEY (`recruiter_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ADD CONSTRAINT `fk_hr_job_requisition_replacement_for_employee_id` FOREIGN KEY (`replacement_for_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ADD CONSTRAINT `fk_hr_job_requisition_parent_job_requisition_id` FOREIGN KEY (`parent_job_requisition_id`) REFERENCES `banking_ecm`.`hr`.`job_requisition`(`job_requisition_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_profile` ADD CONSTRAINT `fk_hr_job_profile_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `banking_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `banking_ecm`.`hr`.`job_profile` ADD CONSTRAINT `fk_hr_job_profile_parent_job_profile_id` FOREIGN KEY (`parent_job_profile_id`) REFERENCES `banking_ecm`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `banking_ecm`.`hr`.`work_location` ADD CONSTRAINT `fk_hr_work_location_parent_work_location_id` FOREIGN KEY (`parent_work_location_id`) REFERENCES `banking_ecm`.`hr`.`work_location`(`work_location_id`);
ALTER TABLE `banking_ecm`.`hr`.`learning_course` ADD CONSTRAINT `fk_hr_learning_course_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`learning_course` ADD CONSTRAINT `fk_hr_learning_course_replacement_course_id` FOREIGN KEY (`replacement_course_id`) REFERENCES `banking_ecm`.`hr`.`learning_course`(`learning_course_id`);
ALTER TABLE `banking_ecm`.`hr`.`learning_course` ADD CONSTRAINT `fk_hr_learning_course_parent_learning_course_id` FOREIGN KEY (`parent_learning_course_id`) REFERENCES `banking_ecm`.`hr`.`learning_course`(`learning_course_id`);
ALTER TABLE `banking_ecm`.`hr`.`payroll_run` ADD CONSTRAINT `fk_hr_payroll_run_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`payroll_run` ADD CONSTRAINT `fk_hr_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`payroll_run` ADD CONSTRAINT `fk_hr_payroll_run_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`payroll_run` ADD CONSTRAINT `fk_hr_payroll_run_previous_payroll_run_id` FOREIGN KEY (`previous_payroll_run_id`) REFERENCES `banking_ecm`.`hr`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `banking_ecm`.`hr`.`review_cycle` ADD CONSTRAINT `fk_hr_review_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`review_cycle` ADD CONSTRAINT `fk_hr_review_cycle_competency_framework_id` FOREIGN KEY (`competency_framework_id`) REFERENCES `banking_ecm`.`hr`.`competency_framework`(`competency_framework_id`);
ALTER TABLE `banking_ecm`.`hr`.`review_cycle` ADD CONSTRAINT `fk_hr_review_cycle_created_by_employee_id` FOREIGN KEY (`created_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`review_cycle` ADD CONSTRAINT `fk_hr_review_cycle_modified_by_employee_id` FOREIGN KEY (`modified_by_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`review_cycle` ADD CONSTRAINT `fk_hr_review_cycle_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `banking_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `banking_ecm`.`hr`.`review_cycle` ADD CONSTRAINT `fk_hr_review_cycle_rating_scale_id` FOREIGN KEY (`rating_scale_id`) REFERENCES `banking_ecm`.`hr`.`rating_scale`(`rating_scale_id`);
ALTER TABLE `banking_ecm`.`hr`.`review_cycle` ADD CONSTRAINT `fk_hr_review_cycle_previous_review_cycle_id` FOREIGN KEY (`previous_review_cycle_id`) REFERENCES `banking_ecm`.`hr`.`review_cycle`(`review_cycle_id`);
ALTER TABLE `banking_ecm`.`hr`.`rating_scale` ADD CONSTRAINT `fk_hr_rating_scale_parent_rating_scale_id` FOREIGN KEY (`parent_rating_scale_id`) REFERENCES `banking_ecm`.`hr`.`rating_scale`(`rating_scale_id`);
ALTER TABLE `banking_ecm`.`hr`.`competency_framework` ADD CONSTRAINT `fk_hr_competency_framework_parent_competency_framework_id` FOREIGN KEY (`parent_competency_framework_id`) REFERENCES `banking_ecm`.`hr`.`competency_framework`(`competency_framework_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`hr` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `banking_ecm`.`hr` SET TAGS ('dbx_domain' = 'hr');
ALTER TABLE `banking_ecm`.`hr`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`employee` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `hr_position_id` SET TAGS ('dbx_business_glossary_term' = 'Hr Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `background_check_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|failed|not_required');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `contract_governing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Contract Governing Jurisdiction');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `contract_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Contract Notice Period Days');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `contracted_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Contracted Hours Per Week');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `division_name` SET TAGS ('dbx_business_glossary_term' = 'Division Name');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Corporate Email Address');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `employment_basis` SET TAGS ('dbx_business_glossary_term' = 'Employment Basis');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `employment_basis` SET TAGS ('dbx_value_regex' = 'full_time|part_time|casual|seasonal');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|leave_of_absence|suspended|terminated|retired|deceased');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed_term|contractor|secondment|intern|temporary');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `fmla_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Eligible Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `original_hire_date` SET TAGS ('dbx_business_glossary_term' = 'Original Hire Date');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `pto_accrual_rate_hours_per_month` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Accrual Rate Hours Per Month');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `pto_balance_hours` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Balance Hours');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `regulatory_headcount_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Headcount Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `rehire_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `sox_critical_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Critical Role Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary_resignation|involuntary_termination|retirement|end_of_contract|layoff|death');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `work_country_code` SET TAGS ('dbx_business_glossary_term' = 'Work Country Code');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `work_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `hr_position_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Position Identifier');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `reporting_position_hr_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Position Identifier');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `budget_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `ccar_stress_scenario_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) Stress Scenario Flag');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `competency_profile` SET TAGS ('dbx_business_glossary_term' = 'Competency Profile');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `critical_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Role Flag');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Position Effective Date');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Position End Date');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `filled_date` SET TAGS ('dbx_business_glossary_term' = 'Position Filled Date');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `fte_authorization` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Authorization');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `grade_band` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade Band');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `grade_band` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Position Justification');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `material_risk_taker_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Risk Taker (MRT) Flag');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|filled|frozen|closed');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `regulatory_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Role Flag');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `remote_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Professional Certifications');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'workday|sap_successfactors|oracle_hcm|manual');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `succession_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Flag');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `target_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Target Fill Date');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `travel_requirement_pct` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `union_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Eligible Flag');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `vacancy_posted_date` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Posted Date');
ALTER TABLE `banking_ecm`.`hr`.`hr_position` ALTER COLUMN `years_experience_required` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience Required');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `alco_reporting` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Reporting Flag');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Establishment Date');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `gl_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Cost Center Code');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `gl_cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `headcount_fte` SET TAGS ('dbx_business_glossary_term' = 'Headcount Full-Time Equivalent (FTE)');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `is_profit_center` SET TAGS ('dbx_business_glossary_term' = 'Is Profit Center Flag');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `is_regulatory_entity` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Entity Flag');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `lei` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'retail_banking|investment_banking|wealth_management|treasury|risk_management|operations');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `physical_address` SET TAGS ('dbx_business_glossary_term' = 'Physical Address');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `physical_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `physical_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `regulatory_segment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Segment');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `regulatory_segment` SET TAGS ('dbx_value_regex' = 'banking_book|trading_book|off_balance_sheet|other');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `sox_scope` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'legal_entity|division|department|cost_center|team|branch');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `banking_ecm`.`hr`.`org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Journal Entry Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowance Amount');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_value_regex' = 'checking|savings');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number (American Bankers Association - ABA)');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (International Organization for Standardization - ISO 4217)');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `dental_insurance_premium` SET TAGS ('dbx_business_glossary_term' = 'Dental Insurance Premium');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `dental_insurance_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Federal Income Tax Withheld');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `fsa_contribution` SET TAGS ('dbx_business_glossary_term' = 'Flexible Spending Account (FSA) Contribution');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `fsa_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Garnishment Amount');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `health_insurance_premium` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Premium');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `health_insurance_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `hsa_contribution` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Contribution');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `hsa_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `loan_repayment_amount` SET TAGS ('dbx_business_glossary_term' = 'Loan Repayment Amount');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `loan_repayment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Local Income Tax Withheld');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax Withheld (Federal Insurance Contributions Act - FICA)');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `other_posttax_deductions` SET TAGS ('dbx_business_glossary_term' = 'Other Post-Tax Deductions');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `other_posttax_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `other_pretax_deductions` SET TAGS ('dbx_business_glossary_term' = 'Other Pre-Tax Deductions');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `other_pretax_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `overtime_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Amount');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `overtime_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi-weekly|semi-monthly|monthly');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|cash|payroll_card');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Status');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_value_regex' = 'draft|approved|processed|paid|voided|reversed');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `retirement_contribution_pretax` SET TAGS ('dbx_business_glossary_term' = 'Retirement Contribution Pre-Tax (401k / 403b)');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `retirement_contribution_pretax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax Withheld (Federal Insurance Contributions Act - FICA)');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'State Income Tax Withheld');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `total_posttax_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Post-Tax Deductions');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `total_posttax_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `total_pretax_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Pre-Tax Deductions');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `total_pretax_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `total_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Withheld');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `total_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `vision_insurance_premium` SET TAGS ('dbx_business_glossary_term' = 'Vision Insurance Premium');
ALTER TABLE `banking_ecm`.`hr`.`payroll_record` ALTER COLUMN `vision_insurance_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `compensation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Event Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `compensation_event_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `compensation_event_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Equity Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `annual_review_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Annual Review Cycle Year');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'manager|director|vp|svp|ceo|board');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `bonus_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Award Amount');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `bonus_award_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `compa_ratio` SET TAGS ('dbx_business_glossary_term' = 'Compa-Ratio');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `compa_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Compensation Amount');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `event_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Event Effective Date');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Compensation Event Number');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Event Status');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|processed|cancelled');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Event Type');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `material_risk_taker_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Risk Taker Flag');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `new_base_salary` SET TAGS ('dbx_business_glossary_term' = 'New Base Salary');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `new_base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `new_lti_value` SET TAGS ('dbx_business_glossary_term' = 'New Long-Term Incentive (LTI) Value');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `new_lti_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `new_target_bonus_pct` SET TAGS ('dbx_business_glossary_term' = 'New Target Bonus Percentage (Pct)');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `new_target_bonus_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `pay_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Maximum');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `pay_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `pay_range_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Midpoint');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `pay_range_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `pay_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Minimum');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `pay_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|below|unsatisfactory');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `prior_base_salary` SET TAGS ('dbx_business_glossary_term' = 'Prior Base Salary');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `prior_base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `prior_lti_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Long-Term Incentive (LTI) Value');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `prior_lti_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `prior_target_bonus_pct` SET TAGS ('dbx_business_glossary_term' = 'Prior Target Bonus Percentage (Pct)');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `prior_target_bonus_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `raroc_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk-Adjusted Return on Capital (RAROC) Linked Flag');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `regulatory_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure Required Flag');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `salary_grade_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade Code');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `salary_grade_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `salary_grade_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `stock_option_grant_quantity` SET TAGS ('dbx_business_glossary_term' = 'Stock Option Grant Quantity');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `stock_option_grant_quantity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `stock_option_strike_price` SET TAGS ('dbx_business_glossary_term' = 'Stock Option Strike Price');
ALTER TABLE `banking_ecm`.`hr`.`compensation_event` ALTER COLUMN `stock_option_strike_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `annual_contribution_limit` SET TAGS ('dbx_business_glossary_term' = 'Annual Contribution Limit');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Policy Number');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `coverage_multiple_of_salary` SET TAGS ('dbx_business_glossary_term' = 'Coverage Multiple of Salary');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `coverage_multiple_of_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `coverage_multiple_of_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `coverage_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier Structure');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `coverage_tier_structure` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family|tiered|composite');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `eligibility_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Description');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employee_contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Percentage');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employer_contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Percentage');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employer_match_limit` SET TAGS ('dbx_business_glossary_term' = 'Employer Match Limit');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employer_match_percentage` SET TAGS ('dbx_business_glossary_term' = 'Employer Match Percentage');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `erisa_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Retirement Income Security Act (ERISA) Plan Number');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `erisa_plan_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `is_aca_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is Affordable Care Act (ACA) Compliant');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `is_cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment End Date');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Start Date');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_administrator_contact` SET TAGS ('dbx_business_glossary_term' = 'Plan Administrator Contact');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_administrator_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Administrator Name');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_subtype` SET TAGS ('dbx_business_glossary_term' = 'Plan Subtype');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Year End Date');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Start Date');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `summary_plan_description_url` SET TAGS ('dbx_business_glossary_term' = 'Summary Plan Description (SPD) Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `vesting_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Vesting Schedule Description');
ALTER TABLE `banking_ecm`.`hr`.`benefit_plan` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Waiting Period Days');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `aca_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Reporting Flag');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|not_required');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `beneficiary_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation Flag');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Member Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Policy Number');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `cobra_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Flag');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_confirmation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Sent Date');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_confirmation_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Sent Flag');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online_portal|paper_form|phone|benefits_counselor|automatic');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'open_enrollment|new_hire|life_event|annual_reenrollment|qualifying_event|administrative_correction');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|waived|suspended|cancelled');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Required Flag');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Status');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Event Date');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Event Type');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_value_regex' = 'coverage_elsewhere|cost|not_needed|other');
ALTER TABLE `banking_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Waiver Status');
ALTER TABLE `banking_ecm`.`hr`.`candidate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`candidate` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Identifier');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Identifier');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `candidate_hiring_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Identifier');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `candidate_hiring_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `candidate_hiring_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `candidate_referral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Employee Identifier');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `candidate_referral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `candidate_referral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `job_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `actual_hire_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Hire Date');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `application_stage` SET TAGS ('dbx_business_glossary_term' = 'Application Stage');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `background_check_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|in_progress|clear|conditional|failed');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `candidate_number` SET TAGS ('dbx_business_glossary_term' = 'Candidate Number');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `consent_to_contact` SET TAGS ('dbx_business_glossary_term' = 'Consent to Contact Flag');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer Name');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `current_employer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `current_job_title` SET TAGS ('dbx_business_glossary_term' = 'Current Job Title');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `current_job_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `degree_field` SET TAGS ('dbx_business_glossary_term' = 'Degree Field of Study');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'no_disability|has_disability|prefer_not_to_disclose');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `disability_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `eeo_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Ethnicity');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `eeo_ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `eeo_gender` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Gender');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `eeo_gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_disclose');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `eeo_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Candidate Email Address');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate First Name');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `is_internal_candidate` SET TAGS ('dbx_business_glossary_term' = 'Internal Candidate Flag');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Last Name');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `ofac_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Screening Date');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `ofac_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Screening Status');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `ofac_screening_status` SET TAGS ('dbx_value_regex' = 'not_screened|clear|flagged|under_review');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `offer_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Currency Code');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `offer_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `offer_extended_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `offer_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Offer Salary Amount');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `offer_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Candidate Phone Number');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `resume_document_url` SET TAGS ('dbx_business_glossary_term' = 'Resume Document Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `resume_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Candidate Source Channel');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'employee_referral|job_board|company_website|recruiter_outreach|social_media|campus_recruiting');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_value_regex' = 'not_veteran|protected_veteran|prefer_not_to_disclose');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `banking_ecm`.`hr`.`candidate` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Professional Experience');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle ID');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `balanced_scorecard_alignment` SET TAGS ('dbx_business_glossary_term' = 'Balanced Scorecard Alignment');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `balanced_scorecard_alignment` SET TAGS ('dbx_value_regex' = 'financial|customer|internal_process|learning_growth|risk_compliance|not_applicable');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `bonus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bonus Percentage');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `bonus_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|adjusted');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `competency_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating Score');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `development_plan_created` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Created');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `goal_achievement_score` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Score');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `high_potential_flag` SET TAGS ('dbx_business_glossary_term' = 'High Potential Flag');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `hr_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Approval Date');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Comments');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `material_risk_taker_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Risk Taker Flag');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `merit_increase_eligible` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `organizational_objective_linkage` SET TAGS ('dbx_business_glossary_term' = 'Organizational Objective Linkage');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `pip_initiated` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Initiated');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `pre_calibration_rating` SET TAGS ('dbx_business_glossary_term' = 'Pre-Calibration Rating');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `pre_calibration_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `raroc_linked_goal_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk-Adjusted Return on Capital (RAROC) Linked Goal Flag');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|quarterly|probationary|ad_hoc|pip');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `reviewer_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Signature Date');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`hr`.`performance_review` ALTER COLUMN `succession_planning_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Flag');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `learning_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Enrollment Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `tertiary_learning_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `tertiary_learning_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `tertiary_learning_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `attempts_count` SET TAGS ('dbx_business_glossary_term' = 'Attempts Count');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `certification_earned` SET TAGS ('dbx_business_glossary_term' = 'Certification Earned');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'pass|fail|incomplete|in_progress|not_started');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Course Name');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `course_type` SET TAGS ('dbx_value_regex' = 'regulatory_mandatory|professional_development|leadership|product_knowledge|technical_skills|compliance');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `cpe_credits_awarded` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Education (CPE) Credits Awarded');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'e_learning|instructor_led|virtual|blended|on_the_job|self_paced');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'self_service|manager_assigned|hr_assigned|system_auto_assigned|compliance_triggered');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `job_role` SET TAGS ('dbx_business_glossary_term' = 'Job Role');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Name');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `banking_ecm`.`hr`.`learning_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `regulatory_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `original_disclosure_regulatory_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Original Disclosure Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `primary_regulatory_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `primary_regulatory_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `primary_regulatory_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Taxonomy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `tertiary_regulatory_preparer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `tertiary_regulatory_preparer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `tertiary_regulatory_preparer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Date');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `attestation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Attestation Required Flag');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `attestation_statement` SET TAGS ('dbx_business_glossary_term' = 'Attestation Statement');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'Public|Internal|Confidential|Restricted');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `data_extraction_date` SET TAGS ('dbx_business_glossary_term' = 'Data Extraction Date');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `disclosure_category` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Category');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `disclosure_category` SET TAGS ('dbx_value_regex' = 'Workforce Demographics|Compensation and Benefits|Regulatory Certification|Licensing and Registration|Risk Management Personnel');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `disclosure_document_url` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Document Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `disclosure_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `disclosure_type` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Type');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `disclosure_type` SET TAGS ('dbx_value_regex' = 'EEO-1|VETS-4212|ACA 1095-C|Material Risk Taker Remuneration|Senior Manager Certification|FINRA U4/U5');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `disposal_eligible_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Eligible Date');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `internal_control_test_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Control Test Date');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `internal_control_test_result` SET TAGS ('dbx_business_glossary_term' = 'Internal Control Test Result');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `internal_control_test_result` SET TAGS ('dbx_value_regex' = 'Passed|Failed|Not Tested|Remediation Required');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `late_filing_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Filing Flag');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `regulator_comments` SET TAGS ('dbx_business_glossary_term' = 'Regulator Comments');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `regulator_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `regulator_response_date` SET TAGS ('dbx_business_glossary_term' = 'Regulator Response Date');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'Electronic Portal|Email|Postal Mail|EDGAR|FINRA Gateway|EBA Portal');
ALTER TABLE `banking_ecm`.`hr`.`regulatory_disclosure` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `license_certification_id` SET TAGS ('dbx_business_glossary_term' = 'License Certification Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments or Notes');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `continuing_education_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Compliance Status');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `continuing_education_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|at_risk|non_compliant|not_applicable');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `continuing_education_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Completed');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `continuing_education_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Required');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License or Certification Expiration Date');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `fitness_propriety_review_date` SET TAGS ('dbx_business_glossary_term' = 'Fitness and Propriety Review Date');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `fitness_propriety_status` SET TAGS ('dbx_business_glossary_term' = 'Fitness and Propriety Status');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `fitness_propriety_status` SET TAGS ('dbx_value_regex' = 'approved|pending|conditional|denied|not_applicable');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'License or Certification Issue Date');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority or Regulatory Body');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License or Certification Number');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License or Certification Status');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending|inactive');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License or Certification Type');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `material_risk_taker_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Risk Taker (MRT) Flag');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `professional_development_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Development Plan Flag');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `regulatory_body_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Notification Date');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `regulatory_body_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Notification Status');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `regulatory_body_notification_status` SET TAGS ('dbx_value_regex' = 'notified|pending_notification|not_required|failed');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'License or Certification Renewal Date');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'current|renewal_required|renewal_in_progress|overdue|not_applicable');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `required_for_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Required for Role Flag');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `succession_planning_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Flag');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `banking_ecm`.`hr`.`license_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'self_reported|hr_verified|third_party_verified|system_integrated');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `workforce_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Plan Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `hr_position_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Position Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `primary_workforce_successor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Successor Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `primary_workforce_successor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `primary_workforce_successor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `alco_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Reporting Flag');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `assumed_attrition_count` SET TAGS ('dbx_business_glossary_term' = 'Assumed Attrition Count');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `assumed_attrition_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Assumed Attrition Rate Percentage (Pct)');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `board_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Reporting Flag');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `budget_envelope_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Envelope Amount');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `budget_envelope_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `ccar_stress_scenario_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) Stress Scenario Flag');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `critical_position_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Position Flag');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `current_headcount_supply` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount Supply');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `development_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Development Action Plan');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `headcount_gap` SET TAGS ('dbx_business_glossary_term' = 'Headcount Gap');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `key_person_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Person Risk Flag');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `material_risk_taker_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Risk Taker (MRT) Flag');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Workforce Plan Code');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^WFP-[A-Z0-9]{6,12}$');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `plan_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|archived|cancelled');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'workforce_capacity|succession_planning|combined');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `planned_hiring_actions` SET TAGS ('dbx_business_glossary_term' = 'Planned Hiring Actions');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `planned_internal_moves` SET TAGS ('dbx_business_glossary_term' = 'Planned Internal Moves');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_value_regex' = 'short_term|medium_term|long_term');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `projected_headcount_demand` SET TAGS ('dbx_business_glossary_term' = 'Projected Headcount Demand');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `readiness_horizon` SET TAGS ('dbx_business_glossary_term' = 'Readiness Horizon');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `readiness_horizon` SET TAGS ('dbx_value_regex' = 'ready_now|1_2_years|3_5_years|not_ready');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Retention Risk Rating');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Scenario Type');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `scenario_type` SET TAGS ('dbx_value_regex' = 'base|stress|growth|adverse|severely_adverse');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `succession_pool_tier` SET TAGS ('dbx_business_glossary_term' = 'Succession Pool Tier');
ALTER TABLE `banking_ecm`.`hr`.`workforce_plan` ALTER COLUMN `succession_pool_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|not_in_pool');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `employee_relation_case_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Relation Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `tertiary_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `tertiary_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `tertiary_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `allegation_summary` SET TAGS ('dbx_business_glossary_term' = 'Allegation Summary');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `allegation_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'no_appeal|appeal_pending|appeal_granted|appeal_denied|appeal_withdrawn');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `case_close_date` SET TAGS ('dbx_business_glossary_term' = 'Case Close Date');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `case_open_date` SET TAGS ('dbx_business_glossary_term' = 'Case Open Date');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `case_priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `case_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_review|closed|escalated|suspended');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|restricted|highly_restricted');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `employee_acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Status');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `employee_acknowledgement_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|refused|not_required');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `ethics_hotline_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethics Hotline Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `investigation_findings` SET TAGS ('dbx_business_glossary_term' = 'Investigation Findings');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `investigation_findings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `litigation_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Risk Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `material_risk_taker_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Risk Taker Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `pip_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Initiated Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `resolution_action` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `resolution_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `retaliation_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Retaliation Claim Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `senior_manager_regime_flag` SET TAGS ('dbx_business_glossary_term' = 'Senior Manager Regime Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `termination_for_cause_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination For Cause Flag');
ALTER TABLE `banking_ecm`.`hr`.`employee_relation_case` ALTER COLUMN `whistleblower_flag` SET TAGS ('dbx_business_glossary_term' = 'Whistleblower Flag');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `onboarding_event_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Event ID');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `hr_position_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Position ID');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `primary_onboarding_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `primary_onboarding_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `primary_onboarding_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `previous_onboarding_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `access_revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Access Revocation Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `access_revocation_status` SET TAGS ('dbx_business_glossary_term' = 'Access Revocation Status');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `access_revocation_status` SET TAGS ('dbx_value_regex' = 'not_applicable|in_progress|revoked|verified');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `background_check_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|cleared|flagged|failed');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `compliance_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Completion Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `compliance_training_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Status');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `compliance_training_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `employee_start_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Start Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `entitlement_access_review_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Access Review Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `entitlement_access_review_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Access Review Status');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `entitlement_access_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `equipment_issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Issuance Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `equipment_issuance_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Issuance Status');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `equipment_issuance_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|issued|returned');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `event_start_date` SET TAGS ('dbx_business_glossary_term' = 'Event Start Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|completed|cancelled|on_hold');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'new_hire_onboarding|transfer_onboarding|offboarding|separation');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `exit_interview_date` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `exit_interview_status` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Status');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `exit_interview_status` SET TAGS ('dbx_value_regex' = 'not_applicable|scheduled|completed|declined|waived');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `finra_registration_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Registration Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `finra_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Registration Status');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `finra_registration_status` SET TAGS ('dbx_value_regex' = 'not_applicable|initiated|submitted|approved|rejected');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `i9_verification_date` SET TAGS ('dbx_business_glossary_term' = 'I-9 Verification Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `i9_verification_status` SET TAGS ('dbx_business_glossary_term' = 'I-9 Verification Status');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `i9_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|verified|expired|failed');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `material_risk_taker_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Risk Taker Flag');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `occ_fitness_propriety_review_date` SET TAGS ('dbx_business_glossary_term' = 'Office of the Comptroller of the Currency (OCC) Fitness and Propriety Review Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `occ_fitness_propriety_status` SET TAGS ('dbx_business_glossary_term' = 'Office of the Comptroller of the Currency (OCC) Fitness and Propriety Status');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `occ_fitness_propriety_status` SET TAGS ('dbx_value_regex' = 'not_applicable|in_progress|cleared|flagged');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `regulatory_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Clearance Required Flag');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `separation_date` SET TAGS ('dbx_business_glossary_term' = 'Separation Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `sox_day1_control_status` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Day-1 Control Status');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `sox_day1_control_status` SET TAGS ('dbx_value_regex' = 'not_applicable|passed|failed|pending');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `sox_day1_control_test_date` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Day-1 Control Test Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `system_access_provisioning_date` SET TAGS ('dbx_business_glossary_term' = 'System Access Provisioning Date');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `system_access_provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'System Access Provisioning Status');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `system_access_provisioning_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|provisioned|revoked');
ALTER TABLE `banking_ecm`.`hr`.`onboarding_event` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `time_attendance_id` SET TAGS ('dbx_business_glossary_term' = 'Time Attendance ID');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `parent_time_attendance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `absence_hours` SET TAGS ('dbx_business_glossary_term' = 'Absence Hours');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `absence_type_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Type Code');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `break_hours` SET TAGS ('dbx_business_glossary_term' = 'Break Hours');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock In Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock Out Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `early_departure_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Departure Flag');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `flsa_overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Overtime Eligible Flag');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `late_arrival_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Arrival Flag');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No Show Flag');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `paid_time_off_hours` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Hours');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `payroll_processing_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processing Date');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `time_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Number');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `time_entry_source` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Source');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `time_entry_source` SET TAGS ('dbx_value_regex' = 'time_clock|manual_entry|mobile_app|web_portal|system_generated|import');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `time_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Status');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `time_entry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|processed|cancelled');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Type');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|double_time|leave|absence|holiday');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `total_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `unpaid_leave_hours` SET TAGS ('dbx_business_glossary_term' = 'Unpaid Leave Hours');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `banking_ecm`.`hr`.`time_attendance` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `succession_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `hr_position_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Position Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `primary_succession_successor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Successor Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `primary_succession_successor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `primary_succession_successor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `quaternary_succession_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `quaternary_succession_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `quaternary_succession_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `quinary_succession_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `quinary_succession_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `quinary_succession_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `tertiary_succession_incumbent_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `tertiary_succession_incumbent_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `tertiary_succession_incumbent_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `parent_succession_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `alco_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Reporting Flag');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `board_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Reporting Flag');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `ccar_stress_scenario_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) Stress Scenario Flag');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `critical_position_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Position Flag');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `development_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Description');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `development_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Status');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `development_plan_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|on_track|delayed|completed');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `incumbent_expected_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Expected Departure Date');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `key_person_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Person Risk Flag');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `material_risk_taker_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Risk Taker (MRT) Flag');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Code');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `plan_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Status');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Type');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'emergency|short_term|long_term|strategic|critical_role|key_talent');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `readiness_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Readiness Assessment Date');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Successor Readiness Level');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `readiness_level` SET TAGS ('dbx_value_regex' = 'ready_now|ready_1_year|ready_2_years|ready_3_plus_years|not_ready');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Retention Risk Rating');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `succession_pool_tier` SET TAGS ('dbx_business_glossary_term' = 'Succession Pool Tier');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `succession_pool_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|high_potential|emerging_leader');
ALTER TABLE `banking_ecm`.`hr`.`succession_plan` ALTER COLUMN `target_transition_date` SET TAGS ('dbx_business_glossary_term' = 'Target Transition Date');
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ALTER COLUMN `job_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition Identifier');
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ALTER COLUMN `parent_job_requisition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`job_requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`job_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`job_profile` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `banking_ecm`.`hr`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier');
ALTER TABLE `banking_ecm`.`hr`.`job_profile` ALTER COLUMN `parent_job_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`job_profile` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`job_profile` ALTER COLUMN `maximum_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`job_profile` ALTER COLUMN `midpoint_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`job_profile` ALTER COLUMN `minimum_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`work_location` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `work_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `parent_work_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`work_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`learning_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`learning_course` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `banking_ecm`.`hr`.`learning_course` ALTER COLUMN `learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Course Identifier');
ALTER TABLE `banking_ecm`.`hr`.`learning_course` ALTER COLUMN `parent_learning_course_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`learning_course` ALTER COLUMN `cost_per_learner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`payroll_run` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `banking_ecm`.`hr`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier');
ALTER TABLE `banking_ecm`.`hr`.`payroll_run` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_run` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`payroll_run` ALTER COLUMN `previous_payroll_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`review_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`review_cycle` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `banking_ecm`.`hr`.`review_cycle` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Identifier');
ALTER TABLE `banking_ecm`.`hr`.`review_cycle` ALTER COLUMN `previous_review_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`rating_scale` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`rating_scale` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `banking_ecm`.`hr`.`rating_scale` ALTER COLUMN `rating_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Identifier');
ALTER TABLE `banking_ecm`.`hr`.`rating_scale` ALTER COLUMN `parent_rating_scale_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`hr`.`competency_framework` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`hr`.`competency_framework` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `banking_ecm`.`hr`.`competency_framework` ALTER COLUMN `competency_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Identifier');
ALTER TABLE `banking_ecm`.`hr`.`competency_framework` ALTER COLUMN `parent_competency_framework_id` SET TAGS ('dbx_self_ref_fk' = 'true');
