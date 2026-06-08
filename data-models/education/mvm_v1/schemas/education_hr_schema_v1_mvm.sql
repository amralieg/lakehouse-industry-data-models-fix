-- Schema for Domain: hr | Business: Education | Version: v1_mvm
-- Generated on: 2026-05-06 15:14:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`hr` COMMENT 'Manages the full non-faculty employee lifecycle including recruiting, onboarding, compensation, benefits, payroll, performance management, and offboarding. Tracks position control, job classifications, salary administration, leave accruals, FTE workforce data, and CUPA-HR benchmarking. Supports Workday HCM operations and institutional workforce planning.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`hr`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique surrogate identifier for the non-faculty staff employee record in the Databricks Silver Layer. Primary key for the employee master data product sourced from Workday HCM.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to hr.job_profile. Business justification: The employee table stores job_profile_code as a denormalized string, but job_profile is the authoritative catalog of job classifications in the hr domain. Adding a FK employee.job_profile_id → hr.job_',
    `position_id` BIGINT COMMENT 'Foreign key linking to hr.position. Business justification: The employee table stores position_number as a denormalized string referencing the authorized position control record. position is the authoritative budgeted role record in the hr domain. Adding emplo',
    `supervisor_employee_id` BIGINT COMMENT 'The employee_id of the direct supervisor or manager for this employee. Supports org hierarchy traversal, performance management workflows, and approval routing in Workday HCM.',
    `annual_salary` DECIMAL(18,2) COMMENT 'The employees annualized base salary in USD. For part-time employees, this reflects the annualized equivalent of their scheduled hours. Used for budget planning, CUPA-HR benchmarking, and compensation equity analysis.',
    `benefits_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible to enroll in institutional benefit plans (health, dental, vision, retirement). Determined by employment type, FTE percentage, and ACA eligibility rules.',
    `citizenship_status` STRING COMMENT 'The employees citizenship or immigration status relevant to employment eligibility verification. Used for I-9 compliance, visa sponsorship tracking, and export control compliance.. Valid values are `us_citizen|permanent_resident|visa_holder|other`',
    `cost_center_code` STRING COMMENT 'The financial cost center code to which the employees compensation is charged. Used for budget allocation, financial reporting, and Oracle PeopleSoft Financials integration.',
    `department_code` STRING COMMENT 'The institutional department or organizational unit code to which the employee is primarily assigned. Used for cost allocation, org hierarchy reporting, and IPEDS submissions.',
    `disability_status` STRING COMMENT 'The employees self-reported disability status per Section 503 of the Rehabilitation Act. Required for federal contractor affirmative action reporting and ADA accommodation tracking.. Valid values are `has_disability|no_disability|not_disclosed`',
    `eeo_category` STRING COMMENT 'The EEO-6 job category assigned to the employee for federal equal employment opportunity reporting. Categories include Executive/Administrative, Professional, Technical, Clerical, Skilled Crafts, and Service/Maintenance. [ENUM-REF-CANDIDATE: executive_administrative|professional|technical_paraprofessional|clerical_secretarial|skilled_crafts|service_maintenance — promote to reference product]',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employees employment relationship with the institution. Drives access provisioning, payroll processing, and workforce reporting.. Valid values are `active|on_leave|terminated|retired|suspended`',
    `employment_type` STRING COMMENT 'Classification of the employees engagement basis with the institution. Determines benefit eligibility, FTE calculation, and IPEDS workforce reporting categories.. Valid values are `full_time|part_time|temporary|contract`',
    `flsa_classification` STRING COMMENT 'The employees FLSA overtime exemption status. Exempt employees are salaried and not eligible for overtime pay; non-exempt employees are hourly and eligible for overtime. Drives payroll processing rules.. Valid values are `exempt|non_exempt`',
    `fte_percent` DECIMAL(18,2) COMMENT 'The employees FTE percentage expressed as a decimal (e.g., 1.0000 = full-time, 0.5000 = half-time). Used for IPEDS HR Survey reporting, benefit eligibility determination, and workforce planning analytics.',
    `gender` STRING COMMENT 'The employees self-reported gender identity. Required for IPEDS HR Survey federal reporting and EEO-6 compliance. Collected and stored in accordance with FERPA and institutional privacy policies.. Valid values are `male|female|non_binary|prefer_not_to_say`',
    `highest_degree_earned` STRING COMMENT 'The highest academic degree attained by the employee. Used for IPEDS HR Survey reporting, minimum qualification verification, and workforce education analytics.. Valid values are `high_school|associate|bachelor|master|doctoral|professional`',
    `hire_date` DATE COMMENT 'The official date the employee began employment at the institution. Used for benefits eligibility determination, service anniversary calculations, and IPEDS reporting.',
    `institution_employee_number` STRING COMMENT 'The institution-assigned employee badge or personnel number used across campus systems (ERP, badge access, payroll). Serves as the human-readable cross-system identifier for the employee.',
    `institutional_email` STRING COMMENT 'The official institution-issued email address for the employee. Primary contact channel for HR communications, SSO authentication, and directory services.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `job_title` STRING COMMENT 'The official institutional job title for the employees current position as defined in the position control system. Used in directories, org charts, and CUPA-HR salary benchmarking.',
    `legal_first_name` STRING COMMENT 'The employees legal given (first) name as recorded on official government-issued identification. Used for payroll, tax reporting, and FERPA-compliant records.',
    `legal_last_name` STRING COMMENT 'The employees legal surname (family name) as recorded on official government-issued identification. Used for payroll, tax reporting, and FERPA-compliant records.',
    `legal_middle_name` STRING COMMENT 'The employees legal middle name or initial as recorded on official identification. Used for disambiguation and formal legal documents.',
    `mobile_phone` STRING COMMENT 'The employees personal mobile phone number. Used for emergency notifications, two-factor authentication, and urgent HR communications.',
    `original_hire_date` DATE COMMENT 'The employees first-ever hire date at the institution, preserved across rehires and position changes. Used for continuous service calculations, retirement vesting, and long-service recognition.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid. Drives payroll processing schedules and period-to-date compensation calculations in Workday HCM Payroll.. Valid values are `biweekly|semi_monthly|monthly|weekly`',
    `pay_grade` STRING COMMENT 'The compensation grade or band assigned to the employees position, defining the salary range minimum, midpoint, and maximum. Used for salary administration and CUPA-HR benchmarking.',
    `personal_email` STRING COMMENT 'The employees personal (non-institutional) email address. Used for emergency contact, offboarding communications, and benefit enrollment notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preferred_name` STRING COMMENT 'The name the employee prefers to be addressed by in day-to-day institutional communications, directories, and LMS systems. May differ from legal name.',
    `race_ethnicity_code` STRING COMMENT 'The employees self-reported race and ethnicity classification per OMB standards. Required for IPEDS HR Survey and EEO-6 federal reporting. [ENUM-REF-CANDIDATE: hispanic_latino|american_indian_alaska_native|asian|black_african_american|native_hawaiian_pacific_islander|white|two_or_more_races — promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when the employee record was first created in the Workday HCM system of record. Used for data lineage, audit compliance, and onboarding workflow tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to the employee record in the Workday HCM system of record. Used for incremental ETL processing, change detection, and audit compliance.',
    `rehire_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire at the institution following separation. Set during offboarding review and used to screen future applications in Slate CRM and Workday Recruiting.',
    `remote_work_type` STRING COMMENT 'The employees approved work arrangement classification indicating whether they work on-site, in a hybrid arrangement, or fully remote. Used for space planning, tax nexus compliance, and workforce analytics.. Valid values are `on_site|hybrid|fully_remote`',
    `retirement_plan_code` STRING COMMENT 'The code identifying the retirement plan in which the employee participates (e.g., TIAA-CREF 403(b), state pension plan). Used for retirement contribution processing and ERISA compliance reporting.',
    `termination_date` DATE COMMENT 'The date the employees employment with the institution ended. Null for active employees. Used for offboarding workflows, final pay processing, and workforce attrition analytics.',
    `termination_reason` STRING COMMENT 'The coded reason for the employees separation from the institution (e.g., voluntary resignation, retirement, involuntary termination, end of contract). Used for turnover analysis and IPEDS reporting. [ENUM-REF-CANDIDATE: voluntary_resignation|retirement|involuntary_termination|end_of_contract|death|transfer_out — promote to reference product]',
    `union_code` STRING COMMENT 'The code identifying the collective bargaining unit or union to which the employee belongs, if applicable. Drives contract-specific pay rules, leave accruals, and grievance tracking.',
    `veteran_status` STRING COMMENT 'The employees self-reported protected veteran status per VEVRAA requirements. Required for VETS-4212 federal contractor reporting and affirmative action planning.. Valid values are `protected_veteran|not_protected_veteran|not_disclosed`',
    `visa_expiration_date` DATE COMMENT 'The expiration date of the employees work authorization visa. Used to trigger renewal workflows and ensure continuous employment eligibility compliance.',
    `visa_type` STRING COMMENT 'The type of work authorization visa held by the employee if applicable (e.g., H-1B, J-1, O-1, TN). Null for U.S. citizens and permanent residents. Used for visa expiration tracking and compliance.',
    `work_location_code` STRING COMMENT 'The code identifying the primary physical work location or campus building assigned to the employee. Links to the Archibus facilities management system for space planning and emergency management.',
    `work_phone` STRING COMMENT 'The employees primary institutional work telephone number including area code. Used for directory listings and HR communications.',
    `workday_worker_reference` STRING COMMENT 'The native worker identifier assigned by Workday HCM. Used as the operational system-of-record key for cross-system integration and ETL reconciliation with Workday HCM.',
    `worker_type` STRING COMMENT 'Workday HCM worker classification distinguishing regular employees from contingent workers, interns, and graduate assistants. Governs payroll processing rules and benefit eligibility.. Valid values are `employee|contingent_worker|intern|graduate_assistant`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for all non-faculty staff employees at the institution. Captures full identity, demographic, employment classification, job title, department assignment, FTE status, FLSA classification, EEO category, hire date, termination date, and employment type (full-time, part-time, temporary, contract). Serves as the SSOT for non-faculty workforce identity sourced from Workday HCM. Excludes faculty, who are owned by the faculty domain.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`position` (
    `position_id` BIGINT COMMENT 'Unique surrogate identifier for the authorized position control record within the institution. Primary key for the position data product in the HR domain. Sourced from Workday HCM Position Management.',
    `building_id` BIGINT COMMENT 'Reference to the primary physical work location (building, campus, or site) assigned to this position. Used in Archibus space planning, facilities management, and geographic workforce distribution reporting.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to hr.job_profile. Business justification: Position control records must reference the institutional job classification catalog. Position has job_code (STRING) as a denormalized business key, but lacks the formal FK to job_profile. This FK est',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department or cost center to which this position is assigned. Used for workforce planning, budget allocation, and IPEDS FTE reporting by organizational unit.',
    `position_supervisory_org_org_unit_id` BIGINT COMMENT 'Reference to the Workday HCM supervisory organization to which this position belongs. Defines the management hierarchy, reporting structure, and span of control for workforce analytics.',
    `reports_to_position_id` BIGINT COMMENT 'Self-referencing identifier of the position to which this position directly reports in the organizational hierarchy. Enables org chart construction and management chain analysis without requiring an active incumbent.',
    `authorized_date` DATE COMMENT 'The date on which the position was formally authorized and approved by institutional leadership or the budget office. Marks the effective start of the positions existence in the position control system.',
    `available_for_overlap` BOOLEAN COMMENT 'Indicates whether the position allows an overlap period where both an outgoing and incoming incumbent can be simultaneously active. Used in transition planning and headcount management within Workday HCM.',
    `budgeted_annual_salary` DECIMAL(18,2) COMMENT 'The annual salary amount budgeted for this position in the institutional operating budget. Used in position control, budget encumbrance calculations, and financial planning. Expressed in USD. Distinct from the incumbents actual salary.',
    `chartfield_string` STRING COMMENT 'The Oracle PeopleSoft Financials chartfield string (combination of fund, department, program, project, and account codes) used to budget and encumber salary costs for this position. Enables financial reconciliation between HR and Finance systems.',
    `compensation_grade_profile` STRING COMMENT 'The specific compensation grade profile within Workday HCM that defines the salary range steps and progression rules applicable to this position. Supports structured merit and equity review processes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the position record was first created in Workday HCM Position Management. Provides audit trail for position control governance and data lineage in the Silver Layer lakehouse.',
    `cupa_hr_benchmark_code` STRING COMMENT 'The CUPA-HR survey benchmark code assigned to this position for participation in the annual CUPA-HR Staff Salary Survey. Enables peer institution salary comparisons and market pricing for compensation administration.',
    `eeo_category` STRING COMMENT 'EEO-1 job category assigned to the position as required by the Equal Employment Opportunity Commission (EEOC) for federal reporting. Categories include Executive/Senior Level Officials, First/Mid-Level Officials, Professionals, Technicians, Sales Workers, Administrative Support, Craft Workers, Operatives, Laborers/Helpers, and Service Workers. [ENUM-REF-CANDIDATE: exec_senior|first_mid_officials|professionals|technicians|sales|admin_support|craft|operatives|laborers|service — promote to reference product]',
    `effective_date` DATE COMMENT 'The date from which the current position attributes (title, grade, FTE, department) are effective. Supports position history tracking and point-in-time workforce reporting in Workday HCM.',
    `employee_category` STRING COMMENT 'Broad institutional classification of the positions workforce category for IPEDS reporting and HR analytics. Distinguishes staff, administrators, executives, technical/paraprofessional, and service/maintenance roles. [ENUM-REF-CANDIDATE: staff|administrator|executive|technical|service|professional — promote to reference product]. Valid values are `staff|administrator|executive|technical|service`',
    `end_date` DATE COMMENT 'The date on which the position is scheduled to end or was eliminated. Applicable to temporary, grant-funded, and seasonal positions with defined terms. Null for permanent positions with no planned end.',
    `flsa_classification` STRING COMMENT 'Designation of the position under the Fair Labor Standards Act (FLSA) indicating whether the role is exempt from overtime pay requirements (exempt) or entitled to overtime compensation (non_exempt). Critical for payroll compliance and labor law adherence.. Valid values are `exempt|non_exempt`',
    `frozen_date` DATE COMMENT 'The date on which the position was placed in frozen status, suspending active recruitment. Used in budget freeze tracking and workforce planning analysis.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The authorized Full-Time Equivalent (FTE) value for this position, expressed as a decimal fraction of a full-time workload (e.g., 1.0000 for full-time, 0.5000 for half-time). Used in IPEDS FTE workforce reporting and institutional workforce planning.',
    `funding_source` STRING COMMENT 'The primary funding source supporting this positions salary and benefits costs. General fund positions are supported by institutional operating budget; grant positions are funded by sponsored research awards; auxiliary positions are funded by self-supporting units; restricted and designated funds have specific use constraints.. Valid values are `general_fund|grant|auxiliary|restricted|designated`',
    `headcount_type` STRING COMMENT 'Indicates whether the position is designated as full-time or part-time based on the authorized FTE allocation and institutional policy thresholds. Used in IPEDS headcount reporting and workforce analytics.. Valid values are `full_time|part_time`',
    `ipeds_occupation_category` STRING COMMENT 'The IPEDS occupation category code assigned to this position for federal human resources reporting to the U.S. Department of Education. Classifies positions into IPEDS-defined staff categories for annual HR survey submission.',
    `is_benefits_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for institutional employee benefits (health insurance, retirement, tuition remission, etc.) based on FTE allocation and position type. Drives benefits enrollment eligibility in Workday HCM Benefits.',
    `is_critical_position` BOOLEAN COMMENT 'Indicates whether this position has been designated as critical to institutional operations or strategic mission. Critical positions receive priority in succession planning and budget protection during financial constraints.',
    `is_remote_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for remote or hybrid work arrangements per institutional telework policy. Supports workforce planning, facilities space planning, and Archibus space utilization analysis.',
    `job_code` STRING COMMENT 'Standardized job code from the institutions job catalog in Workday HCM that classifies the positions duties and responsibilities. Used in CUPA-HR benchmarking, IPEDS reporting, and compensation equity analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the position record was most recently updated in Workday HCM. Used for incremental ETL processing, change data capture, and audit compliance in the Databricks Silver Layer.',
    `max_incumbents` STRING COMMENT 'The maximum number of employees authorized to hold this position simultaneously. Typically 1 for standard positions; greater than 1 for pooled positions supporting multiple incumbents (e.g., graduate assistant pools).',
    `pay_frequency` STRING COMMENT 'The frequency at which the incumbent of this position is paid (e.g., biweekly, semimonthly, monthly). Drives payroll processing cycles in Workday HCM Payroll.. Valid values are `biweekly|semimonthly|monthly|weekly`',
    `pay_grade` STRING COMMENT 'Compensation pay grade or salary band assigned to the position within the institutions salary administration structure (e.g., Grade 7, Band E). Determines the minimum, midpoint, and maximum salary range applicable to the position.',
    `position_description` STRING COMMENT 'Narrative description of the positions primary duties, responsibilities, required qualifications, and scope of work. Used in recruitment postings, performance management, and accreditation documentation.',
    `position_number` STRING COMMENT 'Externally-known, human-readable unique identifier assigned to the authorized position in Workday HCM (e.g., P-00012345). Used in workforce planning, IPEDS reporting, and budget reconciliation across institutional systems.',
    `position_status` STRING COMMENT 'Current lifecycle state of the authorized position. Open indicates the position is vacant and available for recruitment; filled indicates an active incumbent; frozen indicates the position is budgeted but hiring is suspended; eliminated indicates the position has been abolished; pending_approval indicates the position is awaiting authorization.. Valid values are `open|filled|frozen|eliminated|pending_approval`',
    `position_type` STRING COMMENT 'Categorical classification of the positions funding and employment nature. Regular positions are permanently budgeted; temporary positions are time-limited; grant-funded positions are supported by sponsored research awards; seasonal positions are cyclical; pooled positions support variable staffing needs.. Valid values are `regular|temporary|grant_funded|seasonal|pooled`',
    `requires_background_check` BOOLEAN COMMENT 'Indicates whether the position requires a pre-employment background check as a condition of hire per institutional policy or regulatory requirement (e.g., positions working with minors, financial fiduciary roles, law enforcement).',
    `salary_maximum` DECIMAL(18,2) COMMENT 'The maximum annual salary defined for the positions pay grade or compensation band. Used in salary administration, offer approvals, and CUPA-HR benchmarking. Expressed in USD.',
    `salary_midpoint` DECIMAL(18,2) COMMENT 'The midpoint annual salary for the positions pay grade or compensation band, representing the market reference point. Used in compa-ratio analysis, equity reviews, and CUPA-HR benchmarking. Expressed in USD.',
    `salary_minimum` DECIMAL(18,2) COMMENT 'The minimum annual salary defined for the positions pay grade or compensation band. Used in salary administration, equity analysis, and CUPA-HR benchmarking. Expressed in USD.',
    `soc_code` STRING COMMENT 'The U.S. Bureau of Labor Statistics Standard Occupational Classification (SOC) code assigned to this position. Used in IPEDS reporting, labor market analysis, and H-1B visa sponsorship documentation for international hires.. Valid values are `^[0-9]{2}-[0-9]{4}$`',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'The standard number of scheduled work hours per week for this position as defined in Workday HCM. Used to calculate FTE allocation, benefits eligibility thresholds under the ACA, and overtime liability under FLSA.',
    `title` STRING COMMENT 'Official working title of the position as defined in Workday HCM and used in institutional communications, org charts, and CUPA-HR benchmarking submissions.',
    `union_code` STRING COMMENT 'Code identifying the collective bargaining unit or union affiliation applicable to this position, if any. Determines applicable labor contract terms, grievance procedures, and wage scales. Null for non-unionized positions.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized position control record representing a budgeted staff role within the institution. Tracks position number, title, department, FTE allocation, funding source, FLSA classification, pay grade, position type (regular, temporary, grant-funded), and open/filled/frozen status. Supports institutional workforce planning and IPEDS FTE reporting. Sourced from Workday HCM Position Management.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the job profile record in the institutional catalog. Primary key for the hr.job_profile data product.',
    `cip_code_id` BIGINT COMMENT 'Foreign key linking to curriculum.cip_code. Business justification: Faculty and instructional staff job profiles are classified by CIP code for IPEDS human resources survey reporting (HR component) and Title IV compliance. The existing cip_code is a denormalized text ',
    `ada_essential_functions_documented` BOOLEAN COMMENT 'Indicates whether the essential physical and cognitive functions of this job profile have been formally documented in compliance with ADA requirements, supporting reasonable accommodation determinations and interactive process management.',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a pre-employment background check is required for all incumbents hired into this job profile. Supports compliance with institutional policy, Title IX, and Clery Act obligations for positions with student contact.',
    `bargaining_unit_code` STRING COMMENT 'Code identifying the specific collective bargaining unit or union contract applicable to this job profile when union_eligible is true (e.g., AFSCME, AAUP, SEIU). Used for contract administration and labor cost reporting.',
    `benefits_eligibility_class` STRING COMMENT 'Benefits eligibility classification assigned to this job profile determining which institutional benefit plans (health, dental, retirement, tuition waiver) are available to incumbents. Drives ACA compliance tracking and benefits cost modeling.. Valid values are `Full Benefits|Partial Benefits|No Benefits`',
    `certifications_required` STRING COMMENT 'Free-text description of mandatory professional licenses or certifications required for this job profile (e.g., CPA, PMP, PE License, RN License). Used in applicant screening and compliance verification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was first created in the institutional data catalog. Supports audit trail requirements and data lineage tracking in the Databricks Silver Layer.',
    `critical_job` BOOLEAN COMMENT 'Flags this job profile as mission-critical to institutional operations, triggering enhanced succession planning, targeted retention strategies, and priority position-fill timelines in workforce planning.',
    `cupa_hr_survey_code` STRING COMMENT 'CUPA-HR benchmark survey position code mapped to this job profile, enabling direct salary benchmarking against national higher-education compensation survey data. Critical for compensation equity analysis and market pricing.',
    `driving_required` BOOLEAN COMMENT 'Indicates whether incumbents in this job profile are required to operate institutional or personal vehicles as part of their duties, triggering MVR (Motor Vehicle Record) check requirements and institutional auto liability coverage.',
    `eeo1_category` STRING COMMENT 'EEO-1 occupational category assigned to this job profile as required by the U.S. Equal Employment Opportunity Commission for annual EEO-1 Component 1 workforce demographic reporting. Drives federal compliance reporting and diversity analytics. [ENUM-REF-CANDIDATE: Executive/Senior Officials|First/Mid Officials|Professionals|Technicians|Sales Workers|Administrative Support|Craft Workers|Operatives|Laborers|Service Workers — 10 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date on which this job profile version became effective and available for use in position creation and hiring actions. Supports point-in-time compensation analysis and audit trail requirements.',
    `employee_type` STRING COMMENT 'Classification of the employment arrangement associated with this job profile indicating whether positions are regular (continuing), temporary, seasonal, or casual. Affects benefits eligibility, position control, and FTE workforce reporting.. Valid values are `Regular|Temporary|Seasonal|Casual`',
    `flsa_status` STRING COMMENT 'Classification of the job profile under the Fair Labor Standards Act (FLSA) indicating whether incumbents are exempt from overtime pay requirements. Critical for payroll compliance, overtime liability management, and U.S. Department of Labor regulatory reporting.. Valid values are `Exempt|Non-Exempt|Exempt-Executive|Exempt-Administrative|Exempt-Professional`',
    `fte_capacity` DECIMAL(18,2) COMMENT 'Standard FTE value associated with this job profile (typically 1.00 for full-time, 0.50 for half-time). Used in position control, workforce planning, and IPEDS FTE headcount calculations.',
    `inactive_date` DATE COMMENT 'Date on which this job profile was deactivated or deprecated in the institutional catalog. Null for currently active profiles. Used for historical workforce reporting and position control audits.',
    `ipeds_occupational_category` STRING COMMENT 'IPEDS staff occupational category assigned to this job profile for annual IPEDS Human Resources (HR) survey submission to the U.S. Department of Education. Categories include Instructional Staff, Research Staff, Public Service Staff, Management, Business/Financial Operations, etc. [ENUM-REF-CANDIDATE: Instructional|Research|Public Service|Management|Business/Financial|Computer/Mathematical|Architecture/Engineering|Life/Physical/Social Science|Community Service|Legal|Arts/Design|Healthcare|Service|Sales|Office/Admin|Natural Resources|Construction|Maintenance|Production|Transportation — promote to reference product]',
    `job_code` STRING COMMENT 'Externally-known alphanumeric code that uniquely identifies the job profile within Workday HCM and is referenced in position control, offer letters, and CUPA-HR survey submissions. Serves as the business-facing identifier across HR systems.. Valid values are `^[A-Z0-9]{3,12}$`',
    `job_description` STRING COMMENT 'Full detailed narrative of duties, responsibilities, and essential functions for this job profile. Serves as the authoritative document for ADA essential functions determination, FLSA classification justification, and accreditation staff qualification documentation.',
    `job_family_group` STRING COMMENT 'Higher-level cluster that aggregates multiple job families into a strategic workforce segment (e.g., Administrative and Professional, Technical and Skilled Trades, Executive Leadership). Supports institutional workforce analytics and IPEDS reporting.',
    `job_level` STRING COMMENT 'Granular career level designation within a job family indicating seniority and scope (e.g., Level 1, Level 2, Senior, Principal, Lead). Drives pay grade assignment and career progression frameworks. [ENUM-REF-CANDIDATE: Entry|Associate|Mid|Senior|Principal|Lead|Expert|Fellow — promote to reference product]',
    `job_summary` STRING COMMENT 'Concise narrative description of the primary purpose and scope of the job profile, typically 2-4 sentences. Used in job postings, offer letters, and accreditation documentation.',
    `job_title` STRING COMMENT 'Official human-readable title of the job profile as it appears on offer letters, organizational charts, and institutional directories (e.g., Senior Financial Analyst, Director of Admissions).',
    `last_reviewed_date` DATE COMMENT 'Date on which this job profile was last formally reviewed and validated by HR Compensation or the Classification and Compensation team. Supports cyclical job evaluation programs and accreditation documentation.',
    `management_level` STRING COMMENT 'Hierarchical management tier assigned to the job profile indicating span of control and organizational authority. Used for succession planning, compensation banding, and organizational design analytics.. Valid values are `Individual Contributor|Manager|Senior Manager|Director|Vice President|Executive`',
    `min_education_requirement` STRING COMMENT 'Minimum academic credential required for appointment to this job profile. Used in applicant screening, position posting compliance, and accreditation documentation for staff qualification standards.. Valid values are `High School Diploma/GED|Associate Degree|Bachelor Degree|Master Degree|Doctoral Degree|Professional Degree`',
    `min_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for appointment to this job profile. Used in applicant screening, job posting, and compensation equity analysis.',
    `pay_grade` STRING COMMENT 'Institutional pay grade or salary band code assigned to this job profile (e.g., P3, M5, E2). Determines the applicable salary range minimum, midpoint, and maximum for compensation administration and NACUBO benchmarking.. Valid values are `^[A-Z]{1,3}[0-9]{1,3}$`',
    `pay_grade_max_usd` DECIMAL(18,2) COMMENT 'Maximum annual base salary in US dollars defined for this pay grade and job profile. Caps compensation for incumbents and triggers reclassification review when employees approach or exceed this threshold.',
    `pay_grade_midpoint_usd` DECIMAL(18,2) COMMENT 'Midpoint annual base salary in US dollars for this pay grade, representing the market reference point for a fully competent incumbent. Used in compa-ratio calculations and compensation equity reviews.',
    `pay_grade_min_usd` DECIMAL(18,2) COMMENT 'Minimum annual base salary in US dollars defined for this pay grade and job profile. Used in offer generation, equity analysis, and CUPA-HR compensation benchmarking to ensure pay equity compliance.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the job profile in the institutional catalog. Active profiles are available for position creation and hiring. Inactive or Deprecated profiles are retained for historical position and compensation records but cannot be used for new positions.. Valid values are `Active|Inactive|Pending Review|Deprecated`',
    `retirement_plan_eligible` BOOLEAN COMMENT 'Indicates whether incumbents in this job profile are eligible to participate in institutional retirement plans (e.g., TIAA, state pension). Supports benefits administration and ERISA compliance reporting.',
    `sox_sensitive` BOOLEAN COMMENT 'Indicates whether this job profile is designated as a SOX-sensitive role with access to financial systems or controls, requiring enhanced internal audit oversight and segregation of duties controls. Applicable to institutions subject to SOX or analogous GASB/FASB internal control frameworks.',
    `stem_designated` BOOLEAN COMMENT 'Indicates whether this job profile is classified as a STEM-designated role, relevant for OPT STEM extension eligibility for international employees and for institutional STEM workforce diversity reporting.',
    `union_eligible` BOOLEAN COMMENT 'Indicates whether positions filled under this job profile are eligible for collective bargaining unit membership. Drives labor relations tracking, union dues processing, and contract compliance monitoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was most recently modified in the institutional data catalog. Used for incremental ETL processing, change data capture, and audit trail compliance.',
    `work_location_type` STRING COMMENT 'Designated work arrangement type for this job profile indicating whether the role is performed on-site at an institutional facility, fully remote, or in a hybrid arrangement. Supports workforce planning and facilities space utilization analysis.. Valid values are `On-Site|Remote|Hybrid`',
    `work_shift` STRING COMMENT 'Standard work shift designation associated with this job profile indicating the expected hours of operation. Relevant for facilities, public safety, and healthcare-adjacent roles within the institution.. Valid values are `Day|Evening|Night|Rotating|Variable`',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Institutional catalog of standardized job classifications defining role families, job codes, FLSA exemption status, EEO-1 category, pay grade range, minimum qualifications, and CIP-aligned functional area. Used for compensation benchmarking against CUPA-HR survey data and for position control alignment. Sourced from Workday HCM Job Profile.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique surrogate identifier for the organizational unit record in the institutional hierarchy. Primary key for the org_unit data product sourced from Workday HCM Supervisory Organization.',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Multi-campus IPEDS reporting, accreditation reviews, and space allocation all require knowing which campus an org unit belongs to. Higher-ed domain experts universally expect departments/colleges to b',
    `cip_code_id` BIGINT COMMENT 'Foreign key linking to curriculum.cip_code. Business justification: Academic org units (departments, colleges) are classified by CIP code for IPEDS completions and institutional characteristics reporting, and for accreditation alignment. The existing cip_code is a den',
    `cost_center_id` BIGINT COMMENT 'Reference to the financial cost center associated with this organizational unit. Supports budget alignment, financial reporting rollups, and cross-system reconciliation between Workday HCM and Oracle PeopleSoft Financials.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the immediate parent organizational unit in the institutional hierarchy tree. Null for the root-level institution node. Enables recursive parent-child traversal for workforce rollup reporting and supervisory hierarchy navigation.',
    `accreditation_body` STRING COMMENT 'Name of the primary specialized or programmatic accreditation body governing this organizational units academic programs. Examples: ABET, AACSB, LCME, ABA, HLC. Null for non-academic or non-accredited units. Used for accreditation compliance tracking and self-study documentation. [ENUM-REF-CANDIDATE: ABET|AACSB|LCME|ABA|HLC|SACSCOC|MSCHE|NWCCU|NECHE|WSCUC|ACEN|CCNE — promote to reference product]',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the organizational unit with its primary accreditation body. Accredited units are in good standing; candidate units are pursuing initial accreditation; probation units have conditions to resolve; not_accredited units are unaccredited; exempt units are not subject to specialized accreditation requirements.. Valid values are `accredited|candidate|probation|not_accredited|exempt`',
    `banner_org_code` STRING COMMENT 'Ellucian Banner SIS organization code mapped to this Workday HCM supervisory organization. Used for cross-system reconciliation between HR and student information systems, particularly for academic department alignment in course scheduling and faculty assignment.. Valid values are `^[A-Z0-9]{2,10}$`',
    `building_code` STRING COMMENT 'Archibus building code for the primary building where this organizational units administrative offices are located. Used for facilities management, space planning, and emergency contact routing.. Valid values are `^[A-Z0-9_-]{2,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the Databricks Silver layer data product. Supports audit trail, data lineage tracking, and SCD Type 2 history management.',
    `dissolved_date` DATE COMMENT 'Calendar date on which the organizational unit was formally dissolved, merged, or reorganized out of existence by institutional governance. Null for active units. Retained for accreditation audit trails and IPEDS historical reporting.',
    `effective_end_date` DATE COMMENT 'Date on which the organizational unit ceased or will cease to be operationally effective. Null for currently active units with no planned end date. Used for historical reporting, accreditation documentation, and SCD management in the Silver layer.',
    `effective_start_date` DATE COMMENT 'Date on which the organizational unit became or becomes operationally effective. Used for time-based workforce reporting, budget period alignment, and IPEDS organizational structure snapshots. Supports slowly changing dimension (SCD) tracking in the Silver layer.',
    `email_address` STRING COMMENT 'Official institutional email address for the organizational unit used for external communications, directory listings, and system notifications. Typically a shared mailbox (e.g., engineering@university.edu).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `established_date` DATE COMMENT 'Calendar date on which the organizational unit was formally established or chartered by institutional governance. Distinct from effective_start_date which tracks system activation. Used for accreditation history, institutional research, and anniversary reporting.',
    `fte_actual` DECIMAL(18,2) COMMENT 'Current actual Full-Time Equivalent (FTE) headcount filled within this organizational unit based on active position assignments in Workday HCM. Compared against fte_budget for workforce planning variance reporting and IPEDS Human Resources Survey submissions.',
    `fte_budget` DECIMAL(18,2) COMMENT 'Authorized Full-Time Equivalent (FTE) headcount budget allocated to this organizational unit for workforce planning and position control purposes. Used in CUPA-HR benchmarking, institutional workforce planning, and budget variance analysis. Expressed as a decimal to accommodate fractional FTE allocations.',
    `gl_fund_code` STRING COMMENT 'General Ledger fund code from Oracle PeopleSoft Financials that classifies the primary funding source for this organizational unit (e.g., general fund, restricted fund, auxiliary fund, endowment fund). Supports NACUBO-compliant financial reporting and budget alignment.',
    `hierarchy_depth` STRING COMMENT 'Integer representing the depth level of this unit within the institutional hierarchy tree, where the root institution node is level 1. Used for hierarchy-aware reporting, rollup aggregation logic, and organizational structure analytics.',
    `idc_rate_type` STRING COMMENT 'Facilities and Administrative (F&A) indirect cost rate type applicable to this organizational unit for sponsored research and grant administration. Determines the IDC rate applied to direct costs on federal awards administered through Kuali Research. Governed by OMB Uniform Guidance 2 CFR 200.. Valid values are `on_campus_research|off_campus_research|instruction|other_sponsored|not_applicable`',
    `ipeds_unit_code` STRING COMMENT 'Federal IPEDS unit identifier assigned by the U.S. Department of Education for postsecondary institution reporting. Required for Title IV financial aid administration and federal compliance reporting. Applicable primarily at the institution and campus levels.. Valid values are `^[0-9]{6,9}$`',
    `is_academic_unit` BOOLEAN COMMENT 'Indicates whether this organizational unit is classified as an academic unit that delivers instruction, awards credentials, or conducts academic programs. Used to filter units for IPEDS academic reporting, accreditation submissions, and curriculum governance workflows.',
    `is_degree_granting` BOOLEAN COMMENT 'Indicates whether this organizational unit has authority to award academic degrees or credentials. Used for accreditation scope determination, IPEDS completions reporting, and program review governance.',
    `is_research_active` BOOLEAN COMMENT 'Indicates whether this organizational unit actively administers sponsored research grants, contracts, or IRB protocols through Kuali Research. Used for Facilities and Administrative (F&A) cost allocation, indirect cost rate (IDC) reporting, and research compliance oversight.',
    `mission_statement` STRING COMMENT 'Formal mission statement of the organizational unit as approved by institutional governance. Required for programmatic accreditation submissions (AACSB, ABET, LCME) and institutional self-study documentation.',
    `next_accreditation_review_date` DATE COMMENT 'Scheduled date of the next accreditation review, site visit, or self-study submission for this organizational unit. Used for compliance planning, institutional research scheduling, and accreditation project management.',
    `org_hierarchy_path` STRING COMMENT 'Materialized full path string representing the units position in the institutional hierarchy from root to current node, using unit codes delimited by forward slashes. Example: INST/DIV-ACAD/COLL-ENG/DEPT-CS. Enables efficient hierarchy traversal and rollup queries in the Databricks Silver layer without recursive CTEs.',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. Active units are operational and accept workforce assignments and budget allocations. Inactive units are suspended but retained for historical reporting. Pending units are approved but not yet operational. Dissolved units have been formally closed and are retained for audit and accreditation history.. Valid values are `active|inactive|pending|dissolved`',
    `peoplesoft_deptid` STRING COMMENT 'Oracle PeopleSoft Financials department identifier (DEPTID) mapped to this organizational unit. Enables financial reporting rollups, budget alignment, and cross-system reconciliation between Workday HCM workforce data and PeopleSoft GL transactions.. Valid values are `^[A-Z0-9]{4,10}$`',
    `phone_number` STRING COMMENT 'Primary telephone number for the organizational units main administrative office. Used for institutional directory, emergency communications, and vendor/partner contact routing.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `position_count_authorized` STRING COMMENT 'Total number of authorized positions (filled and vacant) approved for this organizational unit through the institutional position control process. Supports workforce planning, budget justification, and headcount reporting.',
    `position_count_filled` STRING COMMENT 'Number of currently filled (occupied) positions within this organizational unit as tracked in Workday HCM. Used for vacancy analysis, workforce planning, and IPEDS Human Resources Survey reporting.',
    `room_number` STRING COMMENT 'Room number of the primary administrative office for this organizational unit within the designated building. Used for facilities management, directory services, and space utilization reporting in Archibus.',
    `unit_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the organizational unit within institutional systems. Used as the business key in Banner, Workday, and PeopleSoft integrations. Examples: COLL-ENG, DEPT-CS, DIV-ACAD.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `unit_description` STRING COMMENT 'Free-text narrative description of the organizational units mission, scope, and primary functions. Used for institutional directory, accreditation self-study documentation, and onboarding materials.',
    `unit_level` STRING COMMENT 'Hierarchical level of the organizational unit within the institutional structure. Determines the units position in the parent-child tree and governs reporting rollup behavior. Institution is the root; divisions and colleges are mid-tier; departments, programs, offices, and centers are leaf-level units. [ENUM-REF-CANDIDATE: institution|division|college|school|department|program|office|center — 8 candidates stripped; promote to reference product]',
    `unit_name` STRING COMMENT 'Official full name of the organizational unit as recognized in institutional records, accreditation filings, and IPEDS reporting. Examples: College of Engineering, Department of Computer Science, Office of Financial Aid.',
    `unit_short_name` STRING COMMENT 'Abbreviated or shortened display name for the organizational unit used in dashboards, reports, and space-constrained interfaces. Examples: Eng College, CS Dept, Fin Aid Office.',
    `unit_type` STRING COMMENT 'Classification of the organizational unit by its primary institutional function. Academic units deliver instruction and award degrees; administrative units provide institutional support services; auxiliary units are self-supporting enterprises (e.g., housing, dining); research centers conduct sponsored and non-sponsored research; athletics units manage NCAA-governed programs.. Valid values are `academic|administrative|auxiliary|research_center|athletics`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was most recently modified in the Databricks Silver layer data product. Used for incremental ETL processing, change detection, and audit trail compliance.',
    `website_url` STRING COMMENT 'Official public-facing website URL for the organizational unit. Used for institutional directory, accreditation documentation, and alumni/prospective student communications.. Valid values are `^https?://[^s]{3,}$`',
    `workday_org_reference` STRING COMMENT 'Native Workday HCM Supervisory Organization identifier for this unit. Serves as the source system key for ETL reconciliation, API integration, and cross-system lineage tracking between Workday HCM and the Databricks Silver layer.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Institutional organizational hierarchy entity representing departments, divisions, colleges, schools, and administrative units in a parent-child tree structure. Tracks unit name, unit code, parent unit, cost center reference, unit type (academic, administrative, auxiliary, research center), effective dates, responsible manager, and active/inactive status. Supports workforce reporting rollups by organizational level, budget alignment, supervisory hierarchy navigation, and IPEDS organizational structure reporting. Sourced from Workday HCM Supervisory Organization.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`staffing_event` (
    `staffing_event_id` BIGINT COMMENT 'Unique surrogate identifier for each staffing event record in the Workday HCM business process audit trail. Primary key for the staffing_event data product.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile (standardized job definition including title, family, and level) assigned to the employee after this staffing event. Drives compensation grade and CUPA-HR job classification alignment.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department or cost center to which the employee belongs after this staffing event. Used for workforce distribution reporting and CUPA-HR benchmarking.',
    `position_id` BIGINT COMMENT 'Reference to the position (budgeted headcount slot) associated with this staffing event, reflecting the new position after the event. Supports position control and Full-Time Equivalent (FTE) workforce planning.',
    `employee_id` BIGINT COMMENT 'Reference to the employee record for whom this staffing event applies. Links to the canonical employee master in Workday HCM.',
    `background_check_status` STRING COMMENT 'For hire and onboarding events, the status of the pre-employment background check screening. Null for non-hire events. Required for compliance with institutional hiring policies and applicable state regulations.. Valid values are `pending|cleared|adverse_action|not_required`',
    `benefits_enrollment_deadline` DATE COMMENT 'For hire and onboarding events, the deadline by which the new employee must complete benefits enrollment elections in Workday HCM. Null for non-hire events. Typically 30 days from hire date per IRS qualifying event rules.',
    `cobra_notification_date` DATE COMMENT 'For separation events, the date on which the Consolidated Omnibus Budget Reconciliation Act (COBRA) continuation coverage notification was sent to the departing employee. Required within 14 days of qualifying event per federal law. Null for non-separation events.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time this staffing event record was first captured in the data lakehouse Silver layer. Used for data lineage, ETL audit, and record provenance tracking.',
    `effective_date` DATE COMMENT 'The real-world date on which the staffing event takes effect for payroll, benefits, and position control purposes. This is the principal business event date distinct from the record creation timestamp.',
    `employment_type` STRING COMMENT 'Classification of the employees appointment type after this staffing event. Determines benefits eligibility, IPEDS reporting category, and Affordable Care Act (ACA) compliance tracking.. Valid values are `regular_full_time|regular_part_time|temporary|contingent|student_worker`',
    `event_status` STRING COMMENT 'Current workflow status of the staffing event within the Workday HCM business process lifecycle. Indicates whether the event has been fully processed and is authoritative for workforce records.. Valid values are `initiated|in_progress|approved|completed|cancelled|rescinded`',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time the staffing event was submitted or triggered in Workday HCM. Captures the exact moment of business process initiation for audit trail purposes.',
    `event_type` STRING COMMENT 'Categorical classification of the employee lifecycle event. Drives downstream processing logic, reporting segmentation, and IPEDS workforce reporting. [ENUM-REF-CANDIDATE: hire|rehire|transfer|promotion|demotion|reclassification|leave_of_absence|return_from_leave|separation|onboarding_completion — promote to reference product]',
    `exit_interview_status` STRING COMMENT 'For separation events, tracks the completion status of the exit interview process. Supports voluntary turnover analysis and institutional retention strategy. Null for non-separation events.. Valid values are `not_required|scheduled|completed|declined|waived`',
    `final_paycheck_date` DATE COMMENT 'For separation events, the date on which the employees final paycheck was issued, including any accrued vacation payout. Null for non-separation events. Required for state wage payment law compliance.',
    `flsa_status` STRING COMMENT 'The employees Fair Labor Standards Act (FLSA) exemption status after this staffing event, indicating whether the employee is exempt from overtime pay requirements. Critical for payroll compliance and Department of Labor reporting.. Valid values are `exempt|non_exempt`',
    `i9_verification_status` STRING COMMENT 'For hire and onboarding events, the status of the Form I-9 Employment Eligibility Verification process confirming the employees legal authorization to work in the United States. Null for non-hire events.. Valid values are `pending|verified|reverification_required|not_applicable`',
    `it_provisioning_status` STRING COMMENT 'For hire and onboarding events, tracks whether IT system access provisioning (network accounts, email, Single Sign-On (SSO), Learning Management System (LMS) access) has been completed. Null for non-hire events.. Valid values are `pending|completed|not_required`',
    `leave_return_date` DATE COMMENT 'For leave of absence events, the expected or actual date the employee is scheduled to return from leave. Null for non-leave events. Used for workforce planning and FMLA entitlement tracking.',
    `leave_type` STRING COMMENT 'For leave of absence events, classifies the type of leave (e.g., Family and Medical Leave Act (FMLA), medical, personal, military, parental, sabbatical). Null for non-leave events. Drives leave entitlement tracking and compliance reporting.. Valid values are `fmla|medical|personal|military|parental|sabbatical`',
    `new_annual_salary` DECIMAL(18,2) COMMENT 'The employees annualized base salary resulting from this staffing event. Drives payroll processing, benefits calculations, and CUPA-HR benchmarking submissions. Classified as confidential business-sensitive data.',
    `new_department_code` STRING COMMENT 'The organizational department code associated with the employees position after this staffing event. Used for headcount reporting and budget allocation.',
    `new_fte` DECIMAL(18,2) COMMENT 'The employees Full-Time Equivalent (FTE) value after this staffing event. Drives IPEDS FTE headcount reporting, benefits eligibility determination, and institutional workforce planning.',
    `new_job_title` STRING COMMENT 'The employees job title resulting from this staffing event. Used for workforce reporting, organizational charts, and CUPA-HR benchmarking submissions.',
    `new_position_code` STRING COMMENT 'The position code assigned to the employee as a result of this staffing event. Reflects the post-event position for workforce planning and position control reporting.',
    `orientation_completed` BOOLEAN COMMENT 'For hire and onboarding events, indicates whether the new employee has completed the required institutional new employee orientation program. Null for non-hire events. Supports onboarding compliance tracking.',
    `pay_frequency` STRING COMMENT 'The payroll payment frequency for the employee after this staffing event. Determines payroll processing schedule and annualization calculations in Workday HCM.. Valid values are `biweekly|semi_monthly|monthly|weekly`',
    `pay_grade` STRING COMMENT 'The compensation grade or salary band assigned to the employees position after this staffing event. Used for salary administration, equity analysis, and CUPA-HR benchmarking alignment.',
    `policy_acknowledgment_date` DATE COMMENT 'For hire and onboarding events, the date on which the new employee completed required policy acknowledgments (e.g., code of conduct, FERPA training, Title IX, acceptable use policy). Null for non-hire events.',
    `prior_annual_salary` DECIMAL(18,2) COMMENT 'The employees annualized base salary immediately before this staffing event. Used for compensation change analysis, equity reviews, and CUPA-HR salary benchmarking. Classified as confidential business-sensitive data.',
    `prior_department_code` STRING COMMENT 'The organizational department code associated with the employees position before this staffing event. Enables inter-departmental transfer tracking and workforce distribution analysis.',
    `prior_fte` DECIMAL(18,2) COMMENT 'The employees Full-Time Equivalent (FTE) value before this staffing event, expressed as a decimal (e.g., 1.0 for full-time, 0.5 for half-time). Used for IPEDS FTE reporting and workforce planning.',
    `prior_job_title` STRING COMMENT 'The employees job title immediately before this staffing event. Captured for historical record and career progression analysis in CUPA-HR benchmarking.',
    `prior_position_code` STRING COMMENT 'The position code held by the employee immediately before this staffing event. Enables before/after comparison for transfer, promotion, demotion, and reclassification analysis.',
    `reason_code` STRING COMMENT 'Standardized reason code from Workday HCM explaining why the staffing event occurred (e.g., VOLUNTARY_RESIGNATION, INVOLUNTARY_TERMINATION, PROMOTION_MERIT, LATERAL_TRANSFER). Used for turnover analysis and IPEDS reporting. [ENUM-REF-CANDIDATE: voluntary_resignation|involuntary_termination|retirement|promotion_merit|promotion_equity|lateral_transfer|reclassification_upward|reclassification_downward|medical_leave|fmla_leave — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text narrative description providing additional context for the staffing event reason beyond the standardized reason code. May include manager comments or HR notes entered during the Workday business process.',
    `rehire_eligible` BOOLEAN COMMENT 'For separation events, indicates whether the departing employee has been designated as eligible for future rehire by the institution. Null for non-separation events. Used in talent acquisition screening.',
    `salary_change_pct` DECIMAL(18,2) COMMENT 'The percentage change in base salary resulting from this staffing event, calculated as (new_annual_salary - prior_annual_salary) / prior_annual_salary. Supports compensation equity analysis and merit increase reporting.',
    `separation_type` STRING COMMENT 'For separation events, classifies whether the departure was voluntary (resignation), involuntary (termination), retirement, death, or end of contract. Null for non-separation events. Drives turnover analysis and IPEDS reporting.. Valid values are `voluntary|involuntary|retirement|death|end_of_contract`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time this staffing event record was last modified in the data lakehouse Silver layer. Supports incremental load detection and change data capture.',
    CONSTRAINT pk_staffing_event PRIMARY KEY(`staffing_event_id`)
) COMMENT 'Transactional record capturing all employee lifecycle events including hire, rehire, transfer, promotion, demotion, reclassification, leave of absence, return from leave, separation (voluntary/involuntary/retirement), and onboarding process completion. Each event records effective date, event type, prior and new position/job/department/compensation values, reason code, initiating manager, and event-specific attributes. For separations: rehire eligibility, COBRA notification date, exit interview status, final paycheck date. For onboarding: I-9 verification status, background check clearance, benefits enrollment deadline, IT provisioning status, orientation completion, policy acknowledgments. Sourced from Workday HCM business process audit trail. Serves as the single authoritative lifecycle record for all workforce movement, turnover analysis, IPEDS reporting, and CUPA-HR benchmarking.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`employee_compensation` (
    `employee_compensation_id` BIGINT COMMENT 'Unique surrogate identifier for each point-in-time compensation record in the employee compensation history. Primary key for this table.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: In higher-ed, salary budgets are allocated to cost centers for budget vs. actual compensation reporting, effort certification, and IPEDS human resources surveys. Compensation records must link to cost',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Compensation changes must align to fiscal periods for IPEDS salary reporting, year-end compensation accruals, and budget period salary planning. effective_date alone is insufficient for fiscal-period-',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to hr.job_profile. Business justification: Compensation records reference job classifications to determine pay grade alignment and market benchmarking. employee_compensation has job_profile_code (STRING) as a denormalized business key but lack',
    `position_id` BIGINT COMMENT 'Reference to the institutional position (position control record) associated with this compensation record. Supports position-based budgeting and workforce planning.',
    `employee_id` BIGINT COMMENT 'Reference to the employee whose compensation is recorded. Links to the HR employee master record in Workday HCM.',
    `approval_date` DATE COMMENT 'The date on which this compensation change was formally approved in Workday HCM. May differ from the effective_date for retroactive adjustments. Used for audit trail and governance reporting.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The annualized base salary amount for salaried employees expressed in USD. For hourly employees, this field is null and hourly_rate is used instead. Core field for CUPA-HR salary benchmarking and pay equity reporting.',
    `change_reason` STRING COMMENT 'Business reason driving this compensation change event. Supports pay equity analysis, merit cycle reporting, and CUPA-HR benchmarking. [ENUM-REF-CANDIDATE: merit|equity_adjustment|market_adjustment|promotion|demotion|reclassification|initial_hire|contract_renewal — promote to reference product]',
    `compa_ratio` DECIMAL(18,2) COMMENT 'The ratio of the employees base salary to the midpoint of their pay grade range, expressed as a decimal (e.g., 0.95 = 95% of midpoint). A compa-ratio below 1.0 indicates the employee is paid below the market midpoint; above 1.0 indicates above midpoint. Core metric for pay equity analysis and CUPA-HR benchmarking.',
    `compensation_status` STRING COMMENT 'Current lifecycle status of this compensation record. Active indicates the record is the current effective compensation; inactive indicates it has been superseded by a newer record; pending indicates an approved but not yet effective change; cancelled indicates a retracted change.. Valid values are `active|inactive|pending|cancelled`',
    `compensation_type` STRING COMMENT 'Classification of the compensation structure: salary (annualized fixed), hourly (rate-based), stipend (fixed periodic payment for specific roles such as graduate assistants), or supplemental (additional pay on top of base). Drives payroll calculation method.. Valid values are `salary|hourly|stipend|supplemental`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compensation record was first created in the data platform (Silver layer ingestion timestamp). Supports audit trail, data lineage, and incremental load processing.',
    `cupa_hr_survey_category` STRING COMMENT 'The CUPA-HR occupational survey category code assigned to this employees position for external salary benchmarking purposes (e.g., Administrative Compensation Survey, Staff Compensation Survey, Faculty in Higher Education Survey). Enables direct comparison to national higher-education salary data.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this compensation record (e.g., USD). Supports institutions with international campuses or employees paid in foreign currencies.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date on which this compensation record becomes effective. Defines the start of the compensation period for this point-in-time record. Used for retroactive pay calculations and compensation history reporting.',
    `employee_category` STRING COMMENT 'Broad institutional classification of the employee at the time of this compensation record. Drives applicable compensation plan, pay grade structure, and CUPA-HR survey category. Faculty includes tenure-track, tenured, and non-tenure-track instructional staff.. Valid values are `faculty|staff|administrator|graduate_assistant|executive`',
    `end_date` DATE COMMENT 'The date on which this compensation record ceases to be effective. Null indicates the record is currently active (open-ended). Populated when a subsequent compensation change supersedes this record.',
    `flsa_status` STRING COMMENT 'The employees FLSA overtime exemption status at the time of this compensation record. Exempt employees are not entitled to overtime pay; non-exempt employees must receive overtime pay for hours worked beyond 40 per week. Critical for payroll compliance and DOL audit readiness.. Valid values are `exempt|non_exempt`',
    `fte_annualized_salary` DECIMAL(18,2) COMMENT 'The FTE-adjusted annualized salary representing what the employee would earn if working full-time (1.0 FTE) for a full year. Calculated as base_salary_amount divided by fte_percent and normalized to 1.0 FTE. Used for CUPA-HR benchmarking comparisons and pay equity analysis across part-time and full-time employees.',
    `fte_percent` DECIMAL(18,2) COMMENT 'The employees FTE percentage at the time of this compensation record, expressed as a decimal (e.g., 1.0 = full-time, 0.5 = half-time). Used to calculate FTE-adjusted salary and for IPEDS FTE workforce reporting.',
    `funding_source` STRING COMMENT 'The primary funding source for this compensation record. Indicates whether the salary is funded from the general operating budget, a sponsored research grant (subject to F&A cost allocation), auxiliary enterprise revenue, or other restricted/designated funds. Critical for grant effort reporting and F&A cost allocation.. Valid values are `general_fund|grant|auxiliary|restricted|designated`',
    `grant_funded_percent` DECIMAL(18,2) COMMENT 'The percentage of this compensation funded by sponsored research grants or contracts, expressed as a decimal (e.g., 0.50 = 50% grant-funded). Used for effort reporting compliance under OMB Uniform Guidance and F&A (Facilities and Administrative) cost allocation. Null if funding_source is not grant.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'The hourly pay rate for non-exempt hourly employees expressed in USD per hour. Null for salaried employees. Must meet or exceed applicable federal and state minimum wage requirements under FLSA.',
    `ipeds_occupation_category` STRING COMMENT 'The IPEDS occupational activity category assigned to this employee for federal reporting purposes (e.g., Instruction, Research, Public Service, Academic Support, Student Services, Institutional Support, Auxiliary Enterprises). Required for annual IPEDS Human Resources survey submission to the U.S. Department of Education.',
    `is_equity_adjustment` BOOLEAN COMMENT 'Indicates whether this compensation change includes an equity adjustment component intended to address internal pay equity disparities. True when the change reason includes an equity component. Used for pay equity reporting and Title IX/Title VII compliance monitoring.',
    `is_market_adjustment` BOOLEAN COMMENT 'Indicates whether this compensation change includes a market adjustment component driven by external salary benchmarking data (e.g., CUPA-HR survey results). True when the change reason includes a market component. Used for compensation strategy reporting.',
    `job_family` STRING COMMENT 'The job family grouping for the employees role at the time of this compensation record (e.g., Information Technology, Academic Affairs, Finance, Facilities). Used for cross-functional compensation benchmarking and CUPA-HR survey alignment.',
    `merit_increase_amount` DECIMAL(18,2) COMMENT 'The dollar amount of the merit-based salary increase applied in this compensation change event. Null if the change reason is not merit. Used for merit cycle budget tracking and equity analysis.',
    `merit_increase_percent` DECIMAL(18,2) COMMENT 'The percentage merit increase applied in this compensation change event, expressed as a decimal (e.g., 0.03 = 3%). Null if the change reason is not merit. Used for merit budget analysis and CUPA-HR merit survey reporting.',
    `notes` STRING COMMENT 'Free-text notes entered by HR administrators documenting the rationale, context, or special circumstances for this compensation change. May include references to market data, performance review outcomes, or negotiation details. Classified confidential due to sensitive compensation context.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid under this compensation record. Drives payroll cycle processing and per-period gross pay calculations.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_range_maximum` DECIMAL(18,2) COMMENT 'The maximum salary amount of the pay grade range applicable at the time of this compensation record. Captured as a point-in-time snapshot. Used to identify employees at or above the range maximum (red-circled employees) for compensation administration.',
    `pay_range_midpoint` DECIMAL(18,2) COMMENT 'The midpoint salary amount of the pay grade range applicable at the time of this compensation record. The midpoint represents the market-competitive rate for the role. Used as the denominator in compa-ratio calculations for CUPA-HR benchmarking.',
    `pay_range_minimum` DECIMAL(18,2) COMMENT 'The minimum salary amount of the pay grade range applicable at the time of this compensation record. Captured as a point-in-time snapshot to preserve historical accuracy. Used for compa-ratio calculation and pay equity analysis.',
    `previous_salary_amount` DECIMAL(18,2) COMMENT 'The employees base salary or annualized rate immediately prior to this compensation change event. Captured as a point-in-time snapshot to enable change analysis without requiring a self-join on the history table. Used for pay equity and audit reporting.',
    `range_penetration` DECIMAL(18,2) COMMENT 'Measures where the employees salary falls within the pay grade range, expressed as a decimal between 0 and 1 (e.g., 0.0 = at minimum, 0.5 = at midpoint, 1.0 = at maximum). Calculated as (salary - range_minimum) / (range_maximum - range_minimum). Used for salary administration and equity reviews.',
    `salary_change_amount` DECIMAL(18,2) COMMENT 'The net dollar change in base salary resulting from this compensation event (new salary minus previous salary). Positive values indicate increases; negative values indicate decreases. Used for compensation change reporting and budget impact analysis.',
    `salary_change_percent` DECIMAL(18,2) COMMENT 'The percentage change in base salary resulting from this compensation event, expressed as a decimal (e.g., 0.04 = 4% increase). Used for compensation equity analysis, merit cycle reporting, and CUPA-HR benchmarking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this compensation record was last modified in the data platform. Used for incremental data processing, change detection, and audit trail maintenance in the Databricks Silver layer.',
    CONSTRAINT pk_employee_compensation PRIMARY KEY(`employee_compensation_id`)
) COMMENT 'Point-in-time compensation record for each employee capturing base salary or hourly rate, compensation type, pay grade assignment, FTE-adjusted annualized salary, effective date, and reason for change (merit, equity, market adjustment, promotion). Includes reference to institutional compensation structures: salary grades, pay ranges (minimum, midpoint, maximum), pay frequency, and compensation plan effective dates. Tracks full compensation history per employee. Sourced from Workday HCM Compensation. Supports CUPA-HR salary benchmarking, pay equity reporting, and salary administration.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the benefit plan record in the institutional data lakehouse. Primary key for the benefit_plan entity.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Benefit plan employer costs are posted to specific FASB/GASB ledger accounts (e.g., fringe benefit expense accounts) in higher-ed GL systems. This FK supports automated benefit cost accrual journal en',
    `aca_metal_tier` STRING COMMENT 'ACA actuarial value metal tier classification for health plans (Bronze, Silver, Gold, Platinum, Catastrophic). Required for ACA Section 6056 employer reporting (IRS Forms 1094-C/1095-C) and minimum value determination.. Valid values are `bronze|silver|gold|platinum|catastrophic`',
    `annual_deductible_family` DECIMAL(18,2) COMMENT 'Annual deductible amount for family coverage under this health plan. The aggregate amount the family must pay before the plan covers costs. Expressed in USD.',
    `annual_deductible_individual` DECIMAL(18,2) COMMENT 'Annual deductible amount for individual coverage under this health plan. The amount an employee must pay out-of-pocket before the plan begins paying. Used in plan comparison tools and benefits counseling. Expressed in USD.',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier, financial institution, or third-party administrator (TPA) underwriting or administering this benefit plan (e.g., Blue Cross Blue Shield, TIAA, Fidelity Investments, Delta Dental, VSP Vision Care).',
    `carrier_plan_code` STRING COMMENT 'The carriers or administrators own identifier for this plan as used in EDI 834 enrollment transactions, carrier invoices, and claims adjudication. Required for electronic data interchange with benefit carriers.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether this benefit plan is subject to COBRA continuation coverage requirements under 29 USC 1161. Health, dental, and vision plans at institutions with 20+ employees are typically COBRA-eligible.',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are applied. Must align with the institutions payroll cycle configuration in Workday HCM to ensure accurate deduction processing.. Valid values are `per_pay_period|monthly|annually|semi_monthly|bi_weekly`',
    `coverage_tier` STRING COMMENT 'Coverage tier defining the scope of dependents included under this plan enrollment option. Drives premium calculation and payroll deduction amounts. Standard tiers align with IRS dependent coverage rules.. Valid values are `employee_only|employee_spouse|employee_children|employee_family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit plan record was first created in the institutional data lakehouse, sourced from Workday HCM. Used for data lineage, audit trail, and Silver layer ingestion tracking.',
    `effective_date` DATE COMMENT 'Date on which the benefit plan becomes active and available for employee enrollment. Marks the start of the plans binding coverage period. Used in open enrollment processing and ACA compliance reporting.',
    `eligibility_employee_class` STRING COMMENT 'Employee classification(s) eligible to enroll in this benefit plan (e.g., Full-Time Faculty, Staff FTE >= 0.75, Adjunct Faculty, Graduate Assistants). Drives Workday HCM eligibility rule configuration and open enrollment targeting. [ENUM-REF-CANDIDATE: full_time_faculty|part_time_faculty|full_time_staff|part_time_staff|graduate_assistant|adjunct|postdoctoral|executive — promote to reference product]',
    `eligibility_fte_minimum` DECIMAL(18,2) COMMENT 'Minimum Full-Time Equivalent (FTE) percentage required for an employee to be eligible for this benefit plan (e.g., 0.75 = 75% FTE). Aligns with ACA employer shared responsibility rules for applicable large employers and institutional HR policy.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Per-pay-period dollar amount deducted from the employees paycheck for this benefit plan and coverage tier. Used in payroll processing, total compensation statements, and CUPA-HR benchmarking. Expressed in USD.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Per-pay-period dollar amount contributed by the institution toward this benefit plan and coverage tier. Represents the institutional cost of benefits and is used in total compensation reporting, budget planning, and NACUBO benchmarking. Expressed in USD.',
    `employer_match_cap_rate` DECIMAL(18,2) COMMENT 'Maximum percentage of employee compensation up to which the employer will match retirement contributions, expressed as a decimal (e.g., 0.06 = match applies up to 6% of salary). Null for non-retirement plans or plans without a match cap.',
    `employer_match_rate` DECIMAL(18,2) COMMENT 'Employer matching contribution rate for retirement plans (403b/457b), expressed as a decimal (e.g., 0.05 = 5% match). Represents the institutional commitment to employee retirement savings. Used in total compensation modeling and CUPA-HR benchmarking. Null for non-retirement plans.',
    `hsa_eligible_flag` BOOLEAN COMMENT 'Indicates whether this health plan qualifies as a High Deductible Health Plan (HDHP) under IRS Section 223, making enrolled employees eligible to contribute to a Health Savings Account (HSA). Critical for FSA/HSA compatibility rules.',
    `irs_plan_type_code` STRING COMMENT 'IRS-defined plan type code used on Form 5500 and Form 1095-C Line 14 to classify the benefit plan for federal tax and ERISA reporting purposes (e.g., 1A, 1B, 1C, 1D, 1E for ACA offer codes; 3C for self-insured). Required for ACA employer reporting.. Valid values are `^[0-9A-Z]{1,5}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit plan record was most recently updated in the source system (Workday HCM) or the data lakehouse. Supports incremental ETL processing, change data capture, and audit compliance.',
    `minimum_essential_coverage_flag` BOOLEAN COMMENT 'Indicates whether this plan qualifies as Minimum Essential Coverage (MEC) under ACA Section 5000A. Required for IRS Form 1095-C reporting and employer shared responsibility penalty avoidance.',
    `minimum_value_flag` BOOLEAN COMMENT 'Indicates whether this health plan meets the ACA minimum value standard (covers at least 60% of total allowed costs). Required for employer shared responsibility compliance under ACA Section 4980H and IRS Form 1095-C Line 14 coding.',
    `network_type` STRING COMMENT 'Indicates whether this plan provides in-network only, out-of-network, or both in-network and out-of-network coverage. Relevant for health, dental, and vision plans. Drives employee cost-sharing and plan comparison analytics.. Valid values are `in_network|out_of_network|both|not_applicable`',
    `open_enrollment_end_date` DATE COMMENT 'Last date of the annual open enrollment window. Elections not submitted by this date default to prior-year elections or waiver per institutional policy.',
    `open_enrollment_start_date` DATE COMMENT 'First date of the annual open enrollment window during which eligible employees may elect, change, or waive this benefit plan. Drives HR communications, Workday enrollment task activation, and compliance deadlines.',
    `out_of_pocket_max_family` DECIMAL(18,2) COMMENT 'Maximum annual out-of-pocket cost for family coverage under this plan. Expressed in USD. ACA-mandated limit for in-network essential health benefits.',
    `out_of_pocket_max_individual` DECIMAL(18,2) COMMENT 'Maximum annual out-of-pocket cost for an individual enrollee under this plan. After this limit is reached, the plan covers 100% of covered services. ACA-mandated limit applies to in-network essential health benefits. Expressed in USD.',
    `plan_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the benefit plan within Workday HCM and used in IPEDS, CUPA-HR, and institutional reporting. Serves as the business-facing identifier across HR systems and carrier interfaces.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `plan_document_url` STRING COMMENT 'URL to the official Summary Plan Description (SPD) or plan document as required by ERISA Section 102. Provides employees access to plan terms, coverage details, and claims procedures. Must be maintained and distributed within ERISA-mandated timeframes.. Valid values are `^https?://.+$`',
    `plan_name` STRING COMMENT 'Full descriptive name of the benefit plan as displayed to employees during open enrollment and in the employee self-service portal (e.g., Blue Cross PPO Gold, TIAA 403(b) Retirement Plan, Delta Dental Premier).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan. Active plans are available for enrollment; Grandfathered plans are closed to new enrollees but retain existing participants; Discontinued plans have been fully terminated.. Valid values are `active|inactive|pending|discontinued|grandfathered`',
    `plan_subtype` STRING COMMENT 'Granular classification within the plan type (e.g., PPO, HMO, HDHP, EPO for health; 403b, 457b, Roth 403b for retirement; STD, LTD for disability; FSA, HSA, DCFSA for flexible spending). Supports detailed analytics and carrier management. [ENUM-REF-CANDIDATE: PPO|HMO|HDHP|EPO|POS|403b|457b|Roth_403b|STD|LTD|FSA|HSA|DCFSA|term_life|whole_life — promote to reference product]',
    `plan_type` STRING COMMENT 'High-level classification of the benefit plan category. Drives eligibility rules, contribution logic, and regulatory reporting requirements. [ENUM-REF-CANDIDATE: health|dental|vision|life_insurance|disability|retirement|tuition_waiver|flexible_spending|supplemental|other — promote to reference product]',
    `plan_year_end_date` DATE COMMENT 'End date of the current benefit plan year. Marks the close of the coverage period for deductible accumulation, FSA use-or-lose rules, and annual contribution limit resets.',
    `plan_year_start_date` DATE COMMENT 'Start date of the current benefit plan year. Typically January 1 for calendar-year plans or July 1 for fiscal-year plans. Governs FSA/HSA contribution limits, deductible resets, and open enrollment windows.',
    `pretax_flag` BOOLEAN COMMENT 'Indicates whether employee contributions to this plan are made on a pre-tax basis under IRS Section 125 (cafeteria plan) or Section 403(b)/457(b) for retirement plans. Pre-tax status reduces taxable wages and affects W-2 reporting.',
    `retirement_contribution_limit` DECIMAL(18,2) COMMENT 'IRS annual elective deferral limit applicable to this retirement plan (403b or 457b). Updated annually per IRS cost-of-living adjustments. Used to enforce contribution caps in payroll processing. Expressed in USD. Null for non-retirement plans.',
    `self_insured_flag` BOOLEAN COMMENT 'Indicates whether the institution self-insures this benefit plan (True) or purchases fully-insured coverage from a carrier (False). Self-insured plans have different ERISA, ACA, and state insurance regulatory requirements and affect IRS Form 1095-C Line 14 coding.',
    `termination_date` DATE COMMENT 'Date on which the benefit plan is terminated and no longer available. Null for open-ended plans. Used to manage plan lifecycle, COBRA administration, and historical reporting.',
    `tuition_waiver_credit_hours_max` STRING COMMENT 'Maximum number of credit hours (CR) per term or year covered under a tuition waiver benefit plan. Applicable only to tuition waiver plan types. Null for non-tuition-waiver plans. Supports institutional tuition benefit tracking and IRS Section 127 exclusion limits.',
    `vesting_period_years` STRING COMMENT 'Number of years required for full vesting of employer contributions under cliff or graded vesting schedules. Zero for immediate vesting. Null for non-retirement plans.',
    `vesting_schedule_type` STRING COMMENT 'Type of vesting schedule governing when employer retirement contributions become fully owned by the employee. Immediate vesting is common in higher education 403(b) plans. Null for non-retirement plans.. Valid values are `immediate|cliff|graded|none`',
    `waiting_period_days` STRING COMMENT 'Number of calendar days from the employees hire or benefits-eligible date before coverage under this plan becomes effective. ACA limits waiting periods to 90 days for health plans. Zero indicates immediate eligibility.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Catalog of institutional benefit offerings including health insurance plans, dental, vision, life insurance, disability, retirement (403b/457b), tuition waiver, and flexible spending accounts. Tracks plan name, plan type, carrier, coverage tiers, employee/employer contribution rates, eligibility rules, and open enrollment periods. Sourced from Workday HCM Benefit Plan configuration.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique surrogate identifier for each benefit enrollment record in the Silver Layer lakehouse. Primary key for this transactional entity.',
    `benefit_plan_id` BIGINT COMMENT 'Reference to the specific benefit plan in which the employee is enrolled (e.g., medical, dental, vision, life insurance, retirement). Links to the benefit plan reference product.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is enrolled in the benefit plan. Links to the HR employee master record sourced from Workday HCM.',
    `aca_affordability_met` BOOLEAN COMMENT 'Indicates whether the employees required contribution for the lowest-cost self-only coverage does not exceed the ACA affordability threshold percentage of household income. Required for IRS Form 1095-C reporting and employer shared responsibility compliance.',
    `aca_minimum_value_met` BOOLEAN COMMENT 'Indicates whether the enrolled health plan meets the ACA minimum value standard (covers at least 60% of total allowed costs). Required for ACA employer mandate compliance reporting on IRS Forms 1094-C and 1095-C.',
    `annual_employee_premium` DECIMAL(18,2) COMMENT 'The total annualized employee-paid premium for this benefit enrollment, calculated as the per-pay-period employee contribution multiplied by the number of pay periods. Used for total compensation statements and benefits cost benchmarking.',
    `annual_employer_premium` DECIMAL(18,2) COMMENT 'The total annualized employer-paid premium for this benefit enrollment. Used for institutional benefits cost budgeting, GASB 45/75 OPEB liability calculations, and NACUBO financial reporting.',
    `benefit_type` STRING COMMENT 'High-level classification of the benefit category. Used for workforce analytics, cost reporting, and CUPA-HR benchmarking. [ENUM-REF-CANDIDATE: medical|dental|vision|life|disability|retirement|fsa|hsa|tuition|supplemental_life|ad_d|eap|other — promote to reference product]',
    `carrier_group_number` STRING COMMENT 'The group policy number assigned by the insurance carrier to the institutions benefit plan. Used in carrier file transmissions and employee benefit ID cards to identify the institutional group contract.',
    `carrier_member_number` STRING COMMENT 'The member identification number assigned by the insurance carrier or benefit provider for this enrollment. Used for carrier eligibility file transmissions (834 EDI transactions), claims adjudication, and employee ID card generation.',
    `cobra_election_date` DATE COMMENT 'The date on which the employee or qualified beneficiary elected COBRA continuation coverage following a qualifying event. Null if COBRA was not elected. Used for COBRA premium billing and coverage period tracking.',
    `cobra_eligible` BOOLEAN COMMENT 'Indicates whether this benefit enrollment is subject to COBRA continuation coverage rights upon a qualifying event (e.g., termination of employment, reduction in hours). Required for COBRA administration and DOL compliance.',
    `contribution_frequency` STRING COMMENT 'The payroll deduction frequency at which employee and employer contributions are applied for this benefit enrollment. Aligns with the institutions payroll cycle configuration in Workday HCM.. Valid values are `biweekly|semimonthly|monthly|weekly|annual`',
    `coverage_tier` STRING COMMENT 'The coverage tier elected by the employee, indicating which dependents are included under the benefit plan. Drives premium calculation and employer contribution amounts. [ENUM-REF-CANDIDATE: employee_only|employee_spouse|employee_children|family|employee_domestic_partner|employee_spouse_children — promote to reference product if additional tiers are needed]. Valid values are `employee_only|employee_spouse|employee_children|family|employee_domestic_partner`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this benefit enrollment record was first created in the source system (Workday HCM) or ingested into the Silver Layer lakehouse. Used for audit trail, data lineage, and compliance documentation.',
    `dependent_count` STRING COMMENT 'The number of dependents (spouse, domestic partner, children) enrolled under this benefit election. Used to validate coverage tier selection and for carrier eligibility file reconciliation.',
    `effective_date` DATE COMMENT 'The date on which benefit coverage under this enrollment becomes active and the employee and dependents are eligible to use the benefit. Distinct from enrollment_date which is when the election was made.',
    `election_source` STRING COMMENT 'Indicates how the benefit election was initiated — whether by the employee via Workday self-service, by an HR administrator, during open enrollment, as part of new hire onboarding, triggered by a life event, or via automatic enrollment.. Valid values are `self_service|hr_admin|open_enrollment|new_hire|life_event|auto_enrolled`',
    `employee_class` STRING COMMENT 'The employment classification of the employee at the time of enrollment, which determines benefit plan eligibility and contribution rates. Supports CUPA-HR benchmarking segmentation and FTE workforce reporting.. Valid values are `faculty|staff|administrator|part_time|graduate_assistant`',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'The per-pay-period pre-tax or post-tax dollar amount deducted from the employees paycheck for this benefit enrollment. Used in payroll processing, total compensation reporting, and SAP (Satisfactory Academic Progress) financial aid coordination.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The per-pay-period dollar amount contributed by the institution toward this benefit enrollment on behalf of the employee. Represents the employers share of benefit cost and is a key component of total compensation and FTE workforce cost analysis.',
    `employer_match_rate` DECIMAL(18,2) COMMENT 'The institutional employer matching contribution rate as a decimal fraction of the employees contribution for retirement plan enrollment (e.g., 0.0500 = 5% match). Applicable when benefit_type is retirement. Key component of total compensation benchmarking.',
    `end_date` DATE COMMENT 'The date on which benefit coverage under this enrollment terminates. Null for open-ended active enrollments. Populated upon termination of employment, voluntary disenrollment, or end of plan year.',
    `enrollment_date` DATE COMMENT 'The date on which the employee completed and submitted their benefit election. Represents the principal real-world business event timestamp for this enrollment transaction.',
    `enrollment_number` STRING COMMENT 'Externally-known business identifier for this enrollment record, formatted as BE-YYYY-NNNNNN. Used in employee communications, HR service desk tickets, and carrier file transmissions.. Valid values are `^BE-[0-9]{4}-[0-9]{6}$`',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the benefit enrollment record. active indicates current coverage; waived indicates the employee opted out; terminated indicates coverage has ended; pending indicates awaiting approval or evidence of insurability; suspended indicates temporarily paused; draft indicates an in-progress election not yet submitted.. Valid values are `active|waived|terminated|pending|suspended|draft`',
    `evidence_of_insurability_required` BOOLEAN COMMENT 'Indicates whether the employee is required to submit evidence of insurability (EOI) — medical underwriting documentation — for this benefit election due to late enrollment or coverage amounts exceeding guaranteed issue limits.',
    `evidence_of_insurability_status` STRING COMMENT 'The current status of the evidence of insurability review for this enrollment. Null or not_required when EOI is not applicable. pending indicates submitted but awaiting carrier decision; approved or denied reflects the carriers underwriting determination.. Valid values are `not_required|pending|approved|denied|waived`',
    `fsa_election_amount` DECIMAL(18,2) COMMENT 'The annual dollar amount the employee elected to contribute to a Flexible Spending Account (FSA) for the plan year. Applicable only when benefit_type is fsa. Subject to IRS annual contribution limits.',
    `fte_at_enrollment` DECIMAL(18,2) COMMENT 'The employees Full-Time Equivalent (FTE) percentage at the time of benefit enrollment (e.g., 1.00 = full-time, 0.50 = half-time). Used to determine ACA eligibility (30+ hours/week threshold) and benefit eligibility tier.',
    `hsa_election_amount` DECIMAL(18,2) COMMENT 'The annual dollar amount the employee elected to contribute to a Health Savings Account (HSA) for the plan year. Applicable only when benefit_type is hsa. Must be paired with a qualifying High Deductible Health Plan (HDHP) enrollment.',
    `is_pretax` BOOLEAN COMMENT 'Indicates whether the employees contribution for this benefit is deducted on a pre-tax basis under a Section 125 cafeteria plan. True for pre-tax deductions (medical, dental, FSA, HSA); False for post-tax deductions (supplemental life, disability buy-up).',
    `is_waived` BOOLEAN COMMENT 'Indicates whether the employee has affirmatively waived (opted out of) this benefit plan. True when the employee declined coverage; False when actively enrolled. Required for ACA compliance tracking and carrier eligibility file management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this benefit enrollment record was most recently updated in the source system or Silver Layer. Used for change data capture (CDC), incremental ETL processing, and audit compliance.',
    `life_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The elected face value (death benefit) of the life insurance policy under this enrollment. Applicable when benefit_type is life. Used for evidence of insurability (EOI) threshold checks and imputed income calculations for coverage exceeding IRS limits.',
    `open_enrollment_period` STRING COMMENT 'Identifier for the open enrollment period during which this election was made (e.g., OE-2025). Null for mid-year qualifying life event elections. Used for enrollment period analytics and audit trail.. Valid values are `^OE-[0-9]{4}(-[0-9]{2})?$`',
    `plan_year` STRING COMMENT 'The four-digit calendar or fiscal plan year to which this enrollment applies (e.g., 2025). Used for open enrollment period tracking, annual cost reporting, and IPEDS human resources survey submissions.. Valid values are `^[0-9]{4}$`',
    `qualifying_life_event_date` DATE COMMENT 'The date on which the qualifying life event occurred (e.g., date of marriage, date of birth/adoption, date of loss of other coverage). Used to validate the 30/60-day election window compliance per IRS Section 125 rules.',
    `qualifying_life_event_type` STRING COMMENT 'The type of qualifying life event (QLE) that triggered a mid-year benefit election change outside of open enrollment. Null for elections made during standard open enrollment. Required for IRS Section 125 compliance documentation. [ENUM-REF-CANDIDATE: new_hire|marriage|divorce|birth_adoption|loss_of_coverage|death_of_dependent|other — 7 candidates stripped; promote to reference product]',
    `retirement_contribution_rate` DECIMAL(18,2) COMMENT 'The employees elected contribution rate as a decimal fraction of gross salary for retirement plan enrollment (e.g., 0.0500 = 5%). Applicable when benefit_type is retirement. Used for payroll deduction calculation and retirement plan compliance testing.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this benefit enrollment record was sourced. Primarily workday_hcm for HR benefit enrollments. Supports data lineage tracking and Silver Layer provenance documentation.. Valid values are `workday_hcm|banner|manual|other`',
    `waiver_reason` STRING COMMENT 'The stated reason the employee waived coverage for this benefit plan. Null when is_waived is False. Used for ACA employer mandate compliance and workforce benefits analytics.. Valid values are `covered_by_spouse|covered_by_other_employer|covered_by_medicare|covered_by_medicaid|declined_coverage|other`',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Transactional record of an employees active enrollment in a specific benefit plan for a given coverage period. Captures enrollment date, coverage tier (employee only, employee+spouse, family), employee and employer contribution amounts, waiver status, qualifying life event trigger, and benefit election effective and end dates. Sourced from Workday HCM Benefit Enrollment.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`payroll_result` (
    `payroll_result_id` BIGINT COMMENT 'Unique surrogate identifier for each individual payroll result record in the Databricks Silver Layer. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payroll distribution to cost centers is a fundamental higher-ed finance process for budget vs. actual salary reporting, effort certification under 2 CFR 200, and NACUBO functional expense reporting. c',
    `employee_id` BIGINT COMMENT 'Reference to the employee for whom this payroll result was generated. Links to the employee master record in Workday HCM.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Fund-based payroll distribution is required in higher-ed for restricted fund compliance, grant salary charging, and endowment spending rate monitoring. fund_code is a denormalized plain-text field. Th',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Payroll results must be tied to fiscal periods for GL payroll posting, period-end close reconciliation, W-2 reporting alignment, and IPEDS salary expenditure by fiscal year. pay_period dates do not ma',
    `grant_account_id` BIGINT COMMENT 'Reference to the sponsored research grant or contract funding this payroll expense, when applicable. Supports effort reporting, Facilities and Administrative (F&A) cost recovery, and Uniform Guidance compliance for federally-funded positions.',
    `position_id` BIGINT COMMENT 'Reference to the position held by the employee during this pay period, supporting position control and Full-Time Equivalent (FTE) workforce reporting.',
    `benefit_deduction_amount` DECIMAL(18,2) COMMENT 'Total employee deductions for benefits (health insurance, dental, vision, FSA, HSA, life insurance, etc.) withheld from gross pay this period. Supports benefits reconciliation and ACA reporting.',
    `check_amount` DECIMAL(18,2) COMMENT 'Amount disbursed to the employee via physical paper check for this pay period. Zero if the employee is fully enrolled in direct deposit.',
    `check_date` DATE COMMENT 'The date on which payment was issued to the employee, either via direct deposit or physical check. This is the principal business event date for the payroll transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payroll result record was first created in the data platform. Supports audit trail, data lineage, and FERPA/institutional compliance requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payroll result record (e.g., USD). Supports multi-currency payroll for international campuses or foreign national employees.. Valid values are `^[A-Z]{3}$`',
    `direct_deposit_amount` DECIMAL(18,2) COMMENT 'Total net amount disbursed to the employee via direct deposit (ACH) for this pay period. May differ from net_pay_amount if a partial check was also issued.',
    `employer_medicare_tax` DECIMAL(18,2) COMMENT 'Employers matching share of Medicare (HI) tax under FICA for this employee and pay period. Required for payroll tax liability reporting and NACUBO financial reporting.',
    `employer_retirement_contribution` DECIMAL(18,2) COMMENT 'Employers matching or non-elective contribution to the employees retirement plan (e.g., 403(b), TIAA) for this pay period. Supports benefits cost reporting and NACUBO financial reporting.',
    `employer_social_security_tax` DECIMAL(18,2) COMMENT 'Employers matching share of Social Security (OASDI) tax under FICA for this employee and pay period. Required for payroll tax liability reporting and NACUBO financial reporting.',
    `federal_income_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of federal income tax withheld from the employees gross pay for this pay period. Required for IRS W-2 Box 2 reporting and federal tax remittance.',
    `fica_taxable_wages` DECIMAL(18,2) COMMENT 'The portion of gross pay subject to FICA (Social Security and Medicare) taxes. May differ from federal taxable wages due to different pre-tax exclusions. Required for W-2 Boxes 3 and 5.',
    `fte_percent` DECIMAL(18,2) COMMENT 'The employees Full-Time Equivalent percentage for this pay period (e.g., 1.0000 = full-time, 0.5000 = half-time). Used for IPEDS FTE reporting, NACUBO workforce analytics, and ACA full-time employee determination.',
    `garnishment_amount` DECIMAL(18,2) COMMENT 'Total amount withheld from the employees pay this period for court-ordered garnishments, including child support, tax levies, and creditor garnishments. Subject to Consumer Credit Protection Act limits.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total earnings before any deductions or withholdings for the pay period. Includes base salary/wages, overtime, shift differentials, stipends, and other earnings components. Core field for W-2 preparation and NACUBO financial reporting.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total regular hours worked by the employee during the pay period. Used for hourly pay calculations, Full-Time Equivalent (FTE) reporting, and IPEDS workforce data submissions.',
    `is_fica_exempt` BOOLEAN COMMENT 'Indicates whether the employee is exempt from FICA taxes for this pay period (e.g., certain student employees, non-resident alien employees on specific visa types, or employees covered by alternative retirement systems).',
    `is_supplemental_wage` BOOLEAN COMMENT 'Indicates whether this payroll result includes supplemental wages (e.g., bonuses, awards, retroactive pay) subject to the IRS flat supplemental withholding rate rather than the standard withholding method.',
    `local_income_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of local or municipal income tax withheld from the employees gross pay for this pay period, applicable in jurisdictions with local income taxes.',
    `medicare_tax_withheld` DECIMAL(18,2) COMMENT 'Employee share of Medicare (HI) tax withheld under the Federal Insurance Contributions Act (FICA). Required for IRS W-2 Box 6 reporting. Includes Additional Medicare Tax for high earners.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Total take-home pay after all deductions, withholdings, and garnishments have been subtracted from gross pay. Represents the actual amount disbursed to the employee.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours worked by the employee during the pay period, subject to FLSA overtime premium pay requirements. Applicable to non-exempt staff employees.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid (e.g., biweekly, semimonthly). Determines the number of pay periods per year and affects annualized compensation calculations.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_group` STRING COMMENT 'The Workday HCM pay group to which the employee belongs, grouping employees with the same pay frequency, currency, and payroll processing rules (e.g., Faculty-Monthly, Staff-Biweekly).',
    `pay_period_end_date` DATE COMMENT 'The last calendar date of the pay period covered by this payroll result. Together with pay_period_start_date defines the exact earnings window.',
    `pay_period_start_date` DATE COMMENT 'The first calendar date of the pay period covered by this payroll result. Used for period-based payroll reconciliation and financial reporting.',
    `pay_rate` DECIMAL(18,2) COMMENT 'The employees base pay rate for this pay period — hourly rate for non-exempt employees or annualized salary for exempt employees. Used for CUPA-HR benchmarking and compensation administration.',
    `pay_rate_type` STRING COMMENT 'Indicates whether the employee is compensated on an hourly, salaried, stipend, or per diem basis. Determines how pay is calculated and which FLSA exemption rules apply.. Valid values are `hourly|salary|stipend|per_diem`',
    `payment_method` STRING COMMENT 'The method by which net pay was disbursed to the employee (e.g., direct deposit via ACH, paper check, wire transfer, or pay card). Drives disbursement processing and reconciliation.. Valid values are `direct_deposit|check|wire_transfer|pay_card`',
    `retirement_deduction_amount` DECIMAL(18,2) COMMENT 'Total pre-tax employee contribution to retirement plans (e.g., 403(b), 457(b)) deducted from gross pay this period. Required for IRS W-2 Box 12 reporting and retirement plan compliance.',
    `run_status` STRING COMMENT 'Current processing status of this payroll result record within the payroll run lifecycle. Drives reconciliation and exception management workflows.. Valid values are `complete|on_hold|cancelled|error|reversed`',
    `run_type` STRING COMMENT 'Classification of the payroll run that produced this result. Distinguishes regular scheduled payrolls from off-cycle, supplemental, bonus, correction, or final termination runs.. Valid values are `regular|off_cycle|supplemental|bonus|correction|final`',
    `social_security_tax_withheld` DECIMAL(18,2) COMMENT 'Employee share of Social Security (OASDI) tax withheld under the Federal Insurance Contributions Act (FICA). Required for IRS W-2 Box 4 reporting.',
    `state_income_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of state income tax withheld from the employees gross pay for this pay period. Required for state W-2 equivalent reporting and state tax remittance.',
    `tax_withholding_state` STRING COMMENT 'Two-letter US state code for the state in which income tax was withheld for this payroll result. Supports multi-state tax compliance for employees working across state lines.. Valid values are `^[A-Z]{2}$`',
    `taxable_wages` DECIMAL(18,2) COMMENT 'The portion of gross pay subject to federal income tax withholding after pre-tax deductions (retirement, FSA, health premiums). Required for W-2 Box 1 reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this payroll result record was most recently modified in the data platform, such as after a payroll correction or reversal. Supports change tracking and audit compliance.',
    `w2_box12_code` STRING COMMENT 'IRS-defined code(s) for special compensation items reported in W-2 Box 12 (e.g., Code D for 401(k)/403(b) deferrals, Code DD for employer-sponsored health coverage cost). Required for annual W-2 preparation. [ENUM-REF-CANDIDATE: D|E|G|DD|W|AA|BB|EE — promote to reference product]',
    `workday_payroll_result_reference` STRING COMMENT 'The externally-known unique identifier assigned by Workday HCM to this payroll result record. Used for cross-system reconciliation and audit traceability back to the system of record.',
    `ytd_federal_tax_withheld` DECIMAL(18,2) COMMENT 'Cumulative federal income tax withheld from the employee from the start of the calendar year through this pay period. Required for W-2 Box 2 year-end reconciliation.',
    `ytd_gross_pay` DECIMAL(18,2) COMMENT 'Cumulative gross pay earned by the employee from the start of the calendar year through this pay period. Essential for W-2 preparation, Social Security wage base tracking, and annual compensation reporting.',
    `ytd_retirement_deduction` DECIMAL(18,2) COMMENT 'Cumulative employee retirement plan contributions from the start of the calendar year through this pay period. Used to monitor IRS annual contribution limits (e.g., 403(b) elective deferral limit).',
    CONSTRAINT pk_payroll_result PRIMARY KEY(`payroll_result_id`)
) COMMENT 'Transactional record of a processed payroll run result for an individual employee capturing gross pay, net pay, federal and state tax withholdings, FICA, retirement deductions, benefit deductions, garnishments, direct deposit amounts, pay period start/end dates, and payroll run identifier. Sourced from Workday HCM Payroll. Supports payroll reconciliation, W-2 preparation, and NACUBO financial reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`absence_event` (
    `absence_event_id` BIGINT COMMENT 'Primary key for absence_event',
    `cost_center_id` BIGINT COMMENT 'Reference to the financial cost center associated with the employees position. Used for leave liability financial reporting and integration with Oracle PeopleSoft Financials for accrual accounting.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department of the employee at the time of the leave request. Used for departmental leave utilization reporting and workforce scheduling impact analysis.',
    `position_id` BIGINT COMMENT 'Reference to the position held by the employee at the time of the leave request, supporting workforce scheduling and Full-Time Equivalent (FTE) impact analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who submitted the leave request. Links to the HR employee master record in Workday HCM.',
    `academic_year` STRING COMMENT 'The academic year during which the leave event occurs (e.g., 2024-2025). Used for institutional workforce planning, accreditation reporting, and IPEDS (Integrated Postsecondary Education Data System) workforce data submissions.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `accrued_hours_balance` DECIMAL(18,2) COMMENT 'Total leave hours accrued by the employee for the applicable leave type as of the request date. Used for eligibility validation and leave liability reporting.',
    `actual_return_date` DATE COMMENT 'The date the employee actually returned to work, which may differ from the anticipated return-to-work date. Used to reconcile leave duration and update accrual balances.',
    `approval_status` STRING COMMENT 'Current workflow state of the leave request within the Workday HCM approval process. Drives downstream scheduling, payroll processing, and compliance reporting.. Valid values are `pending|approved|denied|cancelled|in_review|withdrawn`',
    `approved_date` DATE COMMENT 'The calendar date on which the approving manager formally approved the leave request in Workday HCM. Used for approval turnaround time reporting and audit compliance.',
    `approved_hours` DECIMAL(18,2) COMMENT 'Total number of leave hours formally approved by the manager. May differ from requested hours if partial approval was granted. Used for payroll processing and accrual deduction.',
    `carried_over_hours` DECIMAL(18,2) COMMENT 'Leave hours carried forward from the prior accrual period into the current period for this leave type. Subject to institutional policy caps and collective bargaining agreement terms.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the absence event record was first created in the Workday HCM system. Used for audit trail, data lineage, and FERPA compliance record-keeping.',
    `current_balance_hours` DECIMAL(18,2) COMMENT 'Remaining leave hours available to the employee for this leave type after accounting for accruals, usage, carryover, and forfeitures. Drives leave eligibility checks and leave liability financial reporting.',
    `denial_reason` STRING COMMENT 'Free-text or coded explanation provided by the approving manager when a leave request is denied. Required for grievance and appeal processes and HR audit documentation.',
    `employee_comments` STRING COMMENT 'Free-text comments entered by the employee when submitting the leave request. May contain health-related or personal information protected under HIPAA and FERPA. Stored in restricted access tier.',
    `fmla_designation_date` DATE COMMENT 'The date on which HR formally designated this leave as FMLA-qualifying. Required for FMLA compliance; the employer must provide designation notice within five business days of having sufficient information.',
    `fmla_hours_remaining` DECIMAL(18,2) COMMENT 'Remaining FMLA-eligible hours available to the employee in the current 12-month entitlement period (maximum 480 hours). Used for FMLA compliance reporting and employee communications.',
    `fmla_hours_used_ytd` DECIMAL(18,2) COMMENT 'Cumulative FMLA-designated leave hours consumed by the employee in the current 12-month FMLA entitlement period. The FMLA entitlement is capped at 480 hours (12 weeks) per year; this field supports entitlement exhaustion monitoring.',
    `forfeited_hours` DECIMAL(18,2) COMMENT 'Leave hours forfeited at the end of the accrual period due to exceeding the maximum carryover cap. Used for leave liability reconciliation and policy compliance reporting.',
    `fte_impact` DECIMAL(18,2) COMMENT 'The fractional Full-Time Equivalent (FTE) workforce capacity lost due to this absence event, calculated based on the employees scheduled FTE and leave duration. Used for workforce planning, IPEDS FTE reporting, and CUPA-HR benchmarking.',
    `is_fmla_designated` BOOLEAN COMMENT 'Indicates whether this leave event has been formally designated as qualifying under the Family and Medical Leave Act (FMLA). Drives FMLA entitlement tracking and regulatory compliance reporting to the U.S. Department of Labor.',
    `is_intermittent` BOOLEAN COMMENT 'Indicates whether the leave is taken intermittently (non-consecutive days or partial days) rather than as a continuous block. Critical for FMLA intermittent leave tracking and scheduling impact analysis.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the absence event record was most recently modified in Workday HCM. Used for incremental ETL (Extract Transform Load) processing in the Databricks Silver Layer and change data capture auditing.',
    `leave_duration_days` DECIMAL(18,2) COMMENT 'Total calendar days spanned by the leave event from leave_start_date to leave_end_date. Stored as a business field from Workday HCM to support scheduling and FMLA week-equivalent calculations without requiring runtime computation.',
    `leave_end_date` DATE COMMENT 'The last calendar date of the approved or requested leave period. Nullable for open-ended leaves such as extended medical or military leave.',
    `leave_pay_type` STRING COMMENT 'Indicates whether the leave is compensated as fully paid, unpaid, or partial pay. Drives payroll processing rules in Workday HCM and affects leave liability calculations.. Valid values are `paid|unpaid|partial_pay`',
    `leave_reason` STRING COMMENT 'Detailed reason or sub-classification for the leave request (e.g., own serious health condition, care for family member, childbirth, military deployment). Contains health-related information protected under FERPA and HIPAA where applicable. [ENUM-REF-CANDIDATE: own_health|family_care|childbirth|adoption|military_deployment|bereavement|personal|other — promote to reference product]',
    `leave_request_number` STRING COMMENT 'Externally visible business identifier for the leave request as assigned by Workday HCM. Used in employee communications, HR correspondence, and audit trails.. Valid values are `^LR-[0-9]{8,12}$`',
    `leave_start_date` DATE COMMENT 'The first calendar date of the approved or requested leave period. Used for scheduling, payroll cutoff, and FMLA entitlement period calculations.',
    `leave_type` STRING COMMENT 'Classification of the leave category as defined in Workday HCM absence plans. Drives eligibility rules, accrual policies, and regulatory compliance tracking. [ENUM-REF-CANDIDATE: FMLA|vacation|sick|personal|medical|military|parental|bereavement|sabbatical|jury_duty|administrative — promote to reference product]',
    `manager_comments` STRING COMMENT 'Free-text comments entered by the approving manager during the review and approval workflow. Used for HR audit trails and dispute resolution.',
    `medical_certification_date` DATE COMMENT 'The date on which the medical certification documentation was received by HR. Used to verify compliance with the 15-calendar-day FMLA certification submission deadline.',
    `medical_certification_received` BOOLEAN COMMENT 'Indicates whether the required medical certification has been received from the employee. Used to track outstanding documentation and enforce FMLA certification deadlines.',
    `medical_certification_required` BOOLEAN COMMENT 'Indicates whether a medical certification form (e.g., WH-380-E or WH-380-F for FMLA) is required for this leave request. Drives HR follow-up workflows and compliance documentation tracking.',
    `request_date` DATE COMMENT 'The calendar date on which the employee submitted the leave request in Workday HCM. Used to measure request lead time and compliance with advance notice requirements.',
    `requested_hours` DECIMAL(18,2) COMMENT 'Total number of leave hours requested by the employee for this absence event. Used for accrual balance validation and scheduling impact assessment.',
    `return_to_work_date` DATE COMMENT 'The actual or anticipated date the employee is expected to return to active duty. Used for workforce scheduling, position backfill planning, and FMLA reinstatement tracking.',
    `used_hours` DECIMAL(18,2) COMMENT 'Total leave hours consumed by the employee for this leave type in the current accrual period, including this event. Supports leave liability reporting and SAP (Satisfactory Academic Progress) monitoring for staff.',
    `workday_absence_reference` STRING COMMENT 'The native system identifier assigned by Workday HCM to this absence event. Used for source system traceability and reconciliation between the Silver Layer lakehouse and the operational Workday HCM system.',
    CONSTRAINT pk_absence_event PRIMARY KEY(`absence_event_id`)
) COMMENT 'Comprehensive absence management record tracking employee leave requests, approvals, and accrual balances. Captures leave type (FMLA, vacation, sick, personal, medical, military, parental, bereavement, sabbatical), requested and approved dates, intermittent leave flag, approval status, approving manager, return-to-work date, accrued hours, used hours, carried-over hours, forfeited hours, and current balance by leave type. Sourced from Workday HCM Absence Management. Supports FMLA compliance tracking, leave liability reporting, and workforce scheduling.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`recruitment_requisition` (
    `recruitment_requisition_id` BIGINT COMMENT 'Unique system-generated identifier for the recruitment requisition record in Workday HCM Recruiting. Serves as the primary key for this entity.',
    `campus_id` BIGINT COMMENT 'Reference to the physical campus or facility location where the position will be based, as defined in the Archibus Facilities Management system. Used for space planning, commuter benefit administration, and multi-campus workforce reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Higher-ed position control requires budget availability verification against a cost center before a requisition is approved. budget_account_code is a denormalized cost center reference. This FK enable',
    `job_profile_id` BIGINT COMMENT 'Reference to the standardized job profile in Workday HCM that defines the job family, job level, competencies, and compensation grade associated with this requisition. Enables CUPA-HR benchmarking and compensation equity analysis.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department or cost center that owns this requisition. Used for workforce planning, budget allocation, and IPEDS reporting on staff headcount by organizational unit.',
    `position_id` BIGINT COMMENT 'Reference to the authorized position in the institutional position control system (Workday HCM Position Management). Links the requisition to the funded, budgeted position slot. Supports headcount reconciliation and FTE tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the employee record of the hiring manager responsible for this requisition. The hiring manager initiates the requisition, participates in interviews, and makes the final selection recommendation.',
    `tertiary_recruitment_recruiter_employee_id` BIGINT COMMENT 'Reference to the talent acquisition staff member (recruiter) in Workday HCM assigned to manage the sourcing, screening, and coordination activities for this requisition.',
    `application_close_date` DATE COMMENT 'The date after which the institution will no longer accept applications for this requisition. Used to manage applicant pools, communicate deadlines to candidates, and comply with equal opportunity posting requirements.',
    `approved_date` DATE COMMENT 'The date on which the requisition received final authorization from the appropriate approving authority (e.g., VP, Provost, Budget Office). Marks the transition from draft to approved status and initiates the posting workflow.',
    `approved_fte` DECIMAL(18,2) COMMENT 'The authorized Full-Time Equivalent (FTE) value for this position as approved through the position control process. A value of 1.00 represents a full-time position; 0.50 represents half-time. Used for workforce planning, IPEDS FTE reporting, and budget modeling.',
    `cancelled_date` DATE COMMENT 'The date on which the requisition was cancelled, if applicable. Captures the point at which the institution decided not to proceed with filling the position. Used for workforce planning analysis and budget release tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the recruitment requisition record was first created in Workday HCM. Serves as the audit trail anchor for the requisition lifecycle and is used in time-to-fill calculations from initiation.',
    `eeo_job_category` STRING COMMENT 'The EEO-6 (Higher Education Staff Information) job category assigned to this position for federal equal employment opportunity reporting. Categories include Executive/Administrative/Managerial, Faculty, Professional Non-Faculty, Secretarial/Clerical, Technical/Paraprofessional, Skilled Crafts, and Service/Maintenance. [ENUM-REF-CANDIDATE: executive_admin_managerial|faculty|professional_non_faculty|secretarial_clerical|technical_paraprofessional|skilled_crafts|service_maintenance — promote to reference product]',
    `employment_type` STRING COMMENT 'Classification of the employment arrangement for the position being recruited. Determines benefits eligibility, payroll processing rules, and IPEDS reporting category.. Valid values are `full_time|part_time|temporary|contract|seasonal`',
    `filled_date` DATE COMMENT 'The date on which the requisition was closed as filled, typically corresponding to the accepted offer date or the new hire start date. Used as the end-point for time-to-fill calculations and workforce planning reconciliation.',
    `flsa_classification` STRING COMMENT 'Indicates whether the position is classified as exempt or non-exempt under the Fair Labor Standards Act (FLSA). Exempt positions are salaried and not eligible for overtime; non-exempt positions are hourly and eligible for overtime pay. Critical for payroll compliance.. Valid values are `exempt|non_exempt`',
    `ipeds_occupation_category` STRING COMMENT 'The IPEDS Human Resources Survey occupation category code assigned to this position for federal reporting to the National Center for Education Statistics (NCES). Enables institutional benchmarking and compliance with Title IV reporting requirements.',
    `is_confidential_search` BOOLEAN COMMENT 'Indicates whether this is a confidential executive or sensitive search where the position details and incumbent identity are restricted from general staff visibility. When True, the requisition is masked in standard reporting and accessible only to authorized HR personnel.',
    `job_grade` STRING COMMENT 'Compensation grade or pay band assigned to this position within the institutional salary structure. Used for salary range determination, equity analysis, and CUPA-HR benchmarking comparisons.',
    `justification` STRING COMMENT 'Free-text narrative provided by the hiring manager explaining the business need for this position. For backfill requisitions, includes the name and departure date of the prior incumbent. Required for budget approval workflows and position control authorization.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when the recruitment requisition record was most recently modified in Workday HCM. Supports data lineage tracking, change auditing, and incremental ETL processing in the Databricks Silver Layer.',
    `minimum_qualifications` STRING COMMENT 'Structured text describing the minimum education, experience, and credential requirements that candidates must meet to be considered for the position. Used in job postings and applicant screening in Workday HCM.',
    `number_of_openings` STRING COMMENT 'The total number of positions to be filled under this single requisition. Most requisitions have one opening, but pooled or cohort hires (e.g., multiple graduate assistants, seasonal staff) may have multiple openings under one requisition number.',
    `position_description_url` STRING COMMENT 'URL or document reference pointing to the full position description stored in the institutional document management system or Workday HCM. The position description details duties, qualifications, and performance expectations.',
    `positions_filled_count` STRING COMMENT 'The number of openings under this requisition that have been successfully filled with an accepted offer. Compared against number_of_openings to determine requisition completion status and track partial fills.',
    `posting_channel` STRING COMMENT 'Indicates whether the position is posted for internal candidates only, external candidates only, or both. Drives routing in Workday HCM and determines which job boards and internal portals receive the posting.. Valid values are `internal_only|external_only|internal_and_external`',
    `posting_date` DATE COMMENT 'The date on which the job requisition was officially posted to external and/or internal job boards. Marks the start of the active recruiting period and is the anchor date for time-to-fill calculations.',
    `preferred_qualifications` STRING COMMENT 'Structured text describing the preferred (but not required) education, experience, skills, and credentials that would distinguish a stronger candidate. Used in job postings and candidate evaluation rubrics.',
    `requires_background_check` BOOLEAN COMMENT 'Indicates whether the position requires a pre-employment background check as a condition of hire. Driven by position type, access to sensitive populations (e.g., minors, financial systems), or regulatory requirements.',
    `requires_degree_verification` BOOLEAN COMMENT 'Indicates whether the position requires formal verification of the candidates educational credentials as part of the pre-employment screening process. Common for positions requiring specific academic qualifications.',
    `requisition_number` STRING COMMENT 'Externally-known, human-readable unique identifier for the requisition as displayed in Workday HCM and communicated to hiring managers and HR business partners (e.g., REQ-2024-00123). Used for cross-system reference and candidate communications.. Valid values are `^REQ-[0-9]{4}-[0-9]{5}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the recruitment requisition within the Workday HCM recruiting workflow. Drives time-to-fill reporting and workforce planning dashboards. [ENUM-REF-CANDIDATE: draft|approved|posted|filled|cancelled|on_hold — promote to reference product if additional states are needed]. Valid values are `draft|approved|posted|filled|cancelled|on_hold`',
    `requisition_type` STRING COMMENT 'Categorizes the nature of the hiring need. New headcount indicates a net-new position; backfill replaces a departing employee; temporary covers a fixed-term or seasonal need; reclassification reflects a job grade change; transfer is an internal move requiring a formal requisition. Drives position control and budget authorization workflows.. Valid values are `new_headcount|backfill|temporary|reclassification|transfer`',
    `salary_range_max` DECIMAL(18,2) COMMENT 'The maximum annual salary (in USD) approved for this position as defined by the institutional compensation structure and job grade. Caps the offer amount and is used for budget forecasting and pay equity analysis.',
    `salary_range_midpoint` DECIMAL(18,2) COMMENT 'The midpoint of the approved salary range for this position, representing the market reference point for a fully qualified incumbent. Used in CUPA-HR benchmarking, compa-ratio analysis, and compensation equity reporting.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'The minimum annual salary (in USD) approved for this position as defined by the institutional compensation structure and job grade. Used for offer letter generation, budget planning, and pay equity compliance reporting.',
    `search_committee_required` BOOLEAN COMMENT 'Indicates whether a formal search committee is required for this requisition per institutional policy. Typically required for senior administrative, faculty-adjacent, or director-level and above positions to ensure shared governance and equitable selection.',
    `target_fill_date` DATE COMMENT 'The desired date by which the hiring manager expects the position to be filled and the new employee to start. Used for time-to-fill reporting, workforce planning, and recruiter performance metrics.',
    `visa_sponsorship_eligible` BOOLEAN COMMENT 'Indicates whether the institution is willing to sponsor an H-1B or other work visa for the selected candidate. Affects international candidate sourcing strategy and legal/immigration compliance workflows.',
    `work_location_type` STRING COMMENT 'Indicates whether the position requires on-campus presence, is fully remote, or follows a hybrid schedule. Affects facilities space planning, IT provisioning, and candidate sourcing strategy.. Valid values are `on_campus|remote|hybrid`',
    CONSTRAINT pk_recruitment_requisition PRIMARY KEY(`recruitment_requisition_id`)
) COMMENT 'Formal staff position requisition record initiating the hiring process for a new or backfill position. Captures requisition number, position title, department, hiring manager, requisition type (new headcount, backfill, temporary), approved FTE, salary range, posting date, target fill date, and requisition status (draft, approved, posted, filled, cancelled). Sourced from Workday HCM Recruiting. Supports time-to-fill reporting and workforce planning.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`hr_applicant` (
    `hr_applicant_id` BIGINT COMMENT 'Unique surrogate identifier for each applicant record in the HR recruiting system. Primary key for the hr_applicant data product. Sourced from Workday HCM Recruiting module.',
    `employee_id` BIGINT COMMENT 'Identifier of the current employee who referred this applicant, when source_channel is employee_referral. Supports employee referral program tracking and incentive administration.',
    `recruitment_requisition_id` BIGINT COMMENT 'Reference to the position requisition for which this applicant has applied. Links the applicant to a specific open staff position in the institutions position control system.',
    `tertiary_hr_recruiter_employee_id` BIGINT COMMENT 'Reference to the HR recruiter assigned to manage this applicants candidacy. Used for recruiter workload analysis, time-to-fill accountability, and sourcing effectiveness reporting.',
    `address_line1` STRING COMMENT 'Primary street address of the applicant. Used for background check initiation, offer letter mailing, and OFCCP geographic compliance analysis.',
    `application_created_timestamp` TIMESTAMP COMMENT 'The date and time when the applicant record was first created in the Workday HCM Recruiting system. Serves as the audit creation timestamp and the anchor for time-to-fill calculations.',
    `application_date` DATE COMMENT 'The date on which the applicant submitted their application for the position. Used as the start point for time-to-fill and time-to-hire calculations.',
    `application_status` STRING COMMENT 'Current stage of the applicants progression through the recruiting workflow for the associated requisition. Drives pipeline reporting and time-to-fill analytics. [ENUM-REF-CANDIDATE: applied|screening|interview|offer|hired|rejected|withdrawn — promote to reference product]',
    `background_check_status` STRING COMMENT 'Current status of the pre-employment background check for the applicant. Required for compliance with institutional hiring policy and federal contractor obligations.. Valid values are `not_initiated|pending|clear|adverse|cancelled`',
    `city` STRING COMMENT 'City of residence for the applicant. Used in geographic sourcing analytics and OFCCP compliance reporting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the applicants country of residence. Supports international applicant tracking and work authorization screening.. Valid values are `^[A-Z]{3}$`',
    `current_employer` STRING COMMENT 'Name of the applicants current or most recent employer. Used for background screening, reference checks, and competitive sourcing intelligence.',
    `current_job_title` STRING COMMENT 'The applicants current or most recent job title. Used for qualification assessment, salary benchmarking, and CUPA-HR position classification alignment.',
    `desired_salary` DECIMAL(18,2) COMMENT 'The annual salary expectation stated by the applicant during the application process. Used for early-stage compensation fit screening and offer negotiation planning.',
    `disability_status` STRING COMMENT 'Applicants self-identified disability status per Section 503 of the Rehabilitation Act. Required for federal contractor OFCCP compliance reporting and disability inclusion benchmarking (7% utilization goal).. Valid values are `has_disability|no_disability|decline_to_state`',
    `disposition_reason` STRING COMMENT 'The documented reason for the final disposition of the applicant (e.g., Not Qualified, Position Filled, Candidate Withdrew, Failed Background Check). Required for OFCCP Internet Applicant recordkeeping and adverse impact analysis. [ENUM-REF-CANDIDATE: not_qualified|position_filled|candidate_withdrew|failed_background_check|better_qualified_candidate|salary_mismatch|no_show — promote to reference product]',
    `eeo_gender` STRING COMMENT 'Applicants self-identified gender as collected on the voluntary EEO self-identification form. Required for OFCCP and EEOC compliance reporting and diversity hiring analytics. Collected separately from the application and stored with restricted access.. Valid values are `male|female|non_binary|decline_to_state`',
    `eeo_race_ethnicity` STRING COMMENT 'Applicants self-identified race and ethnicity category per EEOC EEO-1 classification (e.g., Hispanic or Latino, White, Black or African American, Asian, etc.). Required for OFCCP compliance and institutional diversity reporting. [ENUM-REF-CANDIDATE: hispanic_latino|white|black_african_american|asian|native_hawaiian_pacific_islander|american_indian_alaska_native|two_or_more_races|decline_to_state — promote to reference product]',
    `email` STRING COMMENT 'Primary email address of the applicant used for all recruiting communications, interview scheduling, and offer delivery. Sourced from Workday HCM candidate profile.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expected_start_date` DATE COMMENT 'The anticipated first day of employment for the applicant upon offer acceptance. Used for onboarding planning, position vacancy tracking, and FTE workforce forecasting.',
    `first_name` STRING COMMENT 'Legal given name of the applicant as provided during the application process. Used for identity verification, correspondence, and OFCCP compliance reporting.',
    `highest_education_level` STRING COMMENT 'The highest academic degree or credential attained by the applicant as self-reported on the application. Used for minimum qualification screening and workforce education analytics. [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctoral|professional|other — 7 candidates stripped; promote to reference product]',
    `interview_stage` STRING COMMENT 'The most recent or current interview stage reached by the applicant in the selection process. Supports pipeline funnel analysis and interview-to-offer conversion rate reporting.. Valid values are `phone_screen|hiring_manager|panel|final|none`',
    `is_internal_applicant` BOOLEAN COMMENT 'Indicates whether the applicant is a current employee of the institution applying for a different position (internal transfer or promotion). Distinguishes internal mobility from external hiring for workforce planning analytics.',
    `is_rehire_eligible` BOOLEAN COMMENT 'Indicates whether the applicant is a former employee who has been designated as eligible for rehire by the institution. Sourced from Workday HCM separation records. Prevents inadvertent rehire of ineligible former employees.',
    `last_name` STRING COMMENT 'Legal family name (surname) of the applicant as provided during the application process. Used for identity verification, correspondence, and OFCCP compliance reporting.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when the applicant record was most recently modified in the Workday HCM Recruiting system. Used for incremental data extraction (ETL) and audit trail maintenance.',
    `middle_name` STRING COMMENT 'Middle name or initial of the applicant. Supports full legal name construction for background check and onboarding documentation.',
    `offer_accepted_date` DATE COMMENT 'The date on which the applicant formally accepted the employment offer. Used to calculate offer acceptance rate and time-to-fill KPIs.',
    `offer_amount` DECIMAL(18,2) COMMENT 'The annual base salary amount included in the formal offer extended to the applicant. Populated when application_status reaches offer. Used for compensation equity analysis and CUPA-HR benchmarking.',
    `offer_date` DATE COMMENT 'The date on which a formal employment offer was extended to the applicant. Used to calculate offer-to-acceptance cycle time and time-to-fill metrics.',
    `offer_response` STRING COMMENT 'The applicants response to the formal employment offer. Supports offer acceptance rate analytics and compensation negotiation pattern analysis.. Valid values are `accepted|declined|countered|expired`',
    `phone` STRING COMMENT 'Primary contact phone number for the applicant. Used for interview scheduling and recruiter outreach. Stored in E.164 international format.',
    `postal_code` STRING COMMENT 'ZIP or postal code of the applicants residence. Supports geographic labor market analysis and commute-distance sourcing metrics.',
    `preferred_name` STRING COMMENT 'The name the applicant prefers to be addressed by, which may differ from their legal name. Supports inclusive hiring practices and respectful candidate communication.',
    `source_channel` STRING COMMENT 'The recruitment channel through which the applicant was sourced (e.g., job board, employee referral, direct application, staffing agency). Critical for sourcing effectiveness analytics and cost-per-hire reporting. [ENUM-REF-CANDIDATE: job_board|employee_referral|direct|agency|career_fair|social_media|internal_transfer — promote to reference product]',
    `source_detail` STRING COMMENT 'Specific source name within the source channel (e.g., Indeed, LinkedIn, HigherEdJobs, Chronicle of Higher Education, employee name for referrals). Enables granular sourcing ROI analysis.',
    `state_province` STRING COMMENT 'State or province of residence for the applicant. Used in geographic sourcing analytics, relocation eligibility assessment, and OFCCP compliance reporting.',
    `veteran_status` STRING COMMENT 'Applicants self-identified veteran status per VEVRAA (Vietnam Era Veterans Readjustment Assistance Act) categories. Required for federal contractor OFCCP compliance reporting and veteran hiring benchmarks.. Valid values are `protected_veteran|not_protected_veteran|decline_to_state`',
    `work_authorization_status` STRING COMMENT 'Indicates whether the applicant is legally authorized to work in the country of the position without employer sponsorship. Used for I-9 eligibility screening and visa sponsorship decision tracking.. Valid values are `authorized|requires_sponsorship|not_authorized|not_disclosed`',
    `workday_candidate_reference` STRING COMMENT 'The native candidate identifier assigned by Workday HCM Recruiting. Used to cross-reference records back to the system of record for reconciliation and integration purposes.',
    `years_of_experience` STRING COMMENT 'Total years of relevant professional work experience as self-reported by the applicant. Used for minimum qualification screening and compensation band placement during offer stage.',
    CONSTRAINT pk_hr_applicant PRIMARY KEY(`hr_applicant_id`)
) COMMENT 'Master record for individuals who have applied for non-faculty staff positions at the institution. Captures applicant identity, contact information, source channel (job board, employee referral, direct), EEO self-identification data, veteran status, disability status, and application history per requisition including application status (applied, screening, interview, offer, hired, rejected, withdrawn), disposition reason, offer details, and final hiring decision. Distinct from the admissions domain applicant (prospective students). Sourced from Workday HCM Recruiting. Supports OFCCP compliance reporting, diversity hiring analytics, and time-to-fill metrics.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique surrogate identifier for each performance review record in the Workday HCM Talent and Performance module. Primary key for the performance_review data product.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department to which the employee belongs at the time of the review, used for departmental performance reporting.',
    `position_id` BIGINT COMMENT 'Reference to the position held by the employee at the time of the review, supporting position control and workforce planning analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the staff employee who is the subject of this performance review. Links to the employee master record in Workday HCM.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the manager or supervisor who authored and submitted the performance review. Typically the direct supervisor in the Workday HCM reporting hierarchy.',
    `calibrated_overall_rating` STRING COMMENT 'The overall performance rating after calibration review, which may differ from the managers initial rating. Represents the final agreed-upon rating used for merit decisions and talent planning.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `calibration_status` STRING COMMENT 'Indicates the current state of the rating calibration process for this review. Calibration sessions ensure consistency and fairness of ratings across departments and divisions before final approval.. Valid values are `not_required|pending|in_calibration|calibrated|overridden`',
    `competency_rating` STRING COMMENT 'Aggregate rating reflecting the employees demonstration of institutional core competencies (e.g., collaboration, communication, service excellence, DEI commitment) as evaluated during the review period.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the performance review record was first created in the Workday HCM system and ingested into the Silver Layer of the Databricks Lakehouse. Supports audit trail and data lineage.',
    `development_plan_required` BOOLEAN COMMENT 'Indicates whether a formal individual development plan (IDP) is required as an outcome of this performance review, typically triggered by a needs_improvement or unsatisfactory rating.',
    `due_date` DATE COMMENT 'The institutional deadline by which the performance review must be completed and submitted in Workday HCM. Used for compliance tracking and HR reporting on timely completion rates.',
    `employee_acknowledged_date` DATE COMMENT 'The date on which the employee electronically acknowledged receipt and review of their performance evaluation in Workday HCM. Required for FERPA-adjacent employee record integrity and HR audit trails.',
    `employee_comments` STRING COMMENT 'Free-text narrative provided by the employee in their self-assessment, capturing their own perspective on accomplishments, challenges, and development goals. Confidential HR record.',
    `final_approval_date` DATE COMMENT 'The date on which the performance review received final HR or senior leadership approval, marking the review as officially closed and eligible to inform merit increase decisions.',
    `fte_at_review` DECIMAL(18,2) COMMENT 'The employees Full-Time Equivalent (FTE) value at the time of the performance review. Supports workforce planning analytics and ensures part-time employees are evaluated proportionally.',
    `goal_achievement_rating` STRING COMMENT 'Rating reflecting the degree to which the employee achieved their individual performance goals set at the beginning of the review period. Distinct from competency ratings; focuses on measurable outcomes and KPI attainment.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `goals_count` STRING COMMENT 'The total number of individual performance goals formally documented and evaluated in this review cycle. Supports workforce analytics on goal-setting practices and alignment with institutional KPIs.',
    `goals_met_count` STRING COMMENT 'The number of individual performance goals that the employee fully achieved during the review period. Used in conjunction with goals_count to assess goal attainment rates.',
    `leadership_rating` STRING COMMENT 'Rating specific to leadership behaviors and people management competencies, applicable to employees in supervisory or managerial roles. Marked not_applicable for individual contributors.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|not_applicable`',
    `merit_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for a merit-based salary increase based on their performance review outcome. Eligibility may be restricted by budget, employment type, or rating threshold policies.',
    `merit_increase_pct` DECIMAL(18,2) COMMENT 'The percentage salary increase recommended or approved based on the performance review outcome. Confidential compensation data used in salary administration and CUPA-HR benchmarking analysis.',
    `overall_rating` STRING COMMENT 'The summary performance rating assigned to the employee for the review period, drawn from the institutions standardized rating scale in Workday HCM. Directly informs merit increase eligibility and talent development planning.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `overall_rating_numeric` DECIMAL(18,2) COMMENT 'Numeric representation of the overall performance rating on a standardized scale (e.g., 1.00–5.00) as configured in Workday HCM. Enables quantitative analytics, benchmarking, and merit matrix calculations.',
    `pip_required` BOOLEAN COMMENT 'Indicates whether a formal Performance Improvement Plan (PIP) has been initiated as a result of this review. A PIP is a structured corrective action document for employees rated unsatisfactory.',
    `review_comments` STRING COMMENT 'Free-text narrative comments provided by the reviewing manager summarizing the employees performance, accomplishments, and areas for development during the review period. Confidential HR record.',
    `review_period_end_date` DATE COMMENT 'The last day of the performance evaluation period covered by this review. Together with review_period_start_date, defines the full evaluation window.',
    `review_period_start_date` DATE COMMENT 'The first day of the performance evaluation period covered by this review. Defines the beginning of the window during which the employees performance is assessed.',
    `review_status` STRING COMMENT 'Current workflow state of the performance review in Workday HCM. Tracks progression from initial draft through employee acknowledgment, manager submission, HR approval, and final completion. [ENUM-REF-CANDIDATE: draft|in_progress|employee_acknowledged|manager_submitted|hr_approved|completed|cancelled — promote to reference product]',
    `review_type` STRING COMMENT 'Classification of the performance review cycle. Annual reviews support merit decisions; probationary reviews assess new hires within their introductory period; mid-year reviews provide interim feedback; project and off-cycle reviews address specific circumstances.. Valid values are `annual|mid_year|probationary|project|off_cycle`',
    `self_assessment_completed` BOOLEAN COMMENT 'Indicates whether the employee completed a self-assessment as part of the performance review process in Workday HCM. Self-assessments are a standard component of annual and mid-year review cycles.',
    `self_assessment_date` DATE COMMENT 'The date on which the employee submitted their self-assessment in Workday HCM. Used to track employee engagement in the review process and measure timeliness.',
    `submitted_date` DATE COMMENT 'The date on which the manager formally submitted the completed performance review in Workday HCM. Used to measure on-time submission compliance against the due date.',
    `talent_segment` STRING COMMENT 'Confidential talent classification assigned during calibration, used for succession planning and targeted development investment. Supports the institutions talent development and retention strategy.. Valid values are `high_potential|key_contributor|solid_performer|developing|at_risk`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to the performance review record in the source system or the Silver Layer. Used for incremental ETL processing and change data capture.',
    `workday_review_reference` STRING COMMENT 'The native business identifier assigned by Workday HCM to this performance review event. Used for cross-system traceability and reconciliation with the source system of record.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Annual or mid-cycle performance evaluation and professional development record for a staff employee. Captures review period, review type (annual, probationary, mid-year), overall rating, goal achievement rating, competency ratings, reviewer identity, employee self-assessment flag, calibration status, and final approval date. Also tracks training and professional development completions including training type (mandatory compliance, professional development, safety, DEI), delivery method, completion date, credit hours, pass/fail status, certificate issued flag, and expiration date for recurring compliance trainings (Title IX, FERPA, HIPAA, cybersecurity). Sourced from Workday HCM Talent and Performance. Supports merit increase decisions, talent development planning, and compliance training verification.';

CREATE OR REPLACE TABLE `education_ecm`.`hr`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique identifier for the time entry record. Primary key.',
    `adjusted_time_entry_id` BIGINT COMMENT 'Self-referencing FK on time_entry (adjusted_time_entry_id)',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Effort reporting under 2 CFR 200 requires time entries to be linked to cost centers for federal grant compliance certification. cost_center_code is a denormalized plain-text field. This FK enables eff',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Federal grant effort reporting (2 CFR 200) requires time charged to specific funds for salary cost allocation and grant closeout reporting. fund_code is a denormalized plain-text field. This FK enable',
    `grant_account_id` BIGINT COMMENT 'Reference to the research grant or sponsored project funding this time entry. Required for grant-funded employee time tracking and effort reporting.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department where the work was performed. Used for departmental labor reporting and workforce analytics.',
    `position_id` BIGINT COMMENT 'Reference to the position under which the time was worked. Links to the position master record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who recorded this time entry. Links to the employee master record.',
    `tertiary_time_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who approved this time entry. Provides audit trail for approval authority.',
    `approval_status` STRING COMMENT 'Current approval state of the time entry. Tracks whether the supervisor has reviewed and approved the time for payroll processing.. Valid values are `pending|approved|rejected|returned`',
    `approved_date` DATE COMMENT 'Date when the supervisor approved the time entry. Indicates readiness for payroll processing.',
    `chartfield_string` STRING COMMENT 'Complete financial accounting string combining fund, department, account, program, and project codes. Used for detailed labor cost allocation in the general ledger.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Precise date and time when the employee clocked in or started work. Critical for FLSA compliance and overtime calculation.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Precise date and time when the employee clocked out or ended work. Used to calculate total hours worked.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this time entry record was first created in the system. Used for audit trail and data lineage tracking.',
    `earning_code` STRING COMMENT 'Classification code indicating the type of time worked. Examples include regular hours, overtime, shift differential, on-call, holiday pay, or compensatory time. Drives pay rate calculation in payroll.',
    `earning_description` STRING COMMENT 'Human-readable description of the earning code. Provides context for the type of time worked.',
    `employee_comments` STRING COMMENT 'Free-text notes or explanations provided by the employee regarding this time entry. May include justification for unusual hours or work circumstances.',
    `entry_status` STRING COMMENT 'Current lifecycle status of the time entry in the approval and payroll workflow. Tracks progression from draft through approval to payment.. Valid values are `draft|submitted|approved|rejected|paid|cancelled`',
    `entry_type` STRING COMMENT 'Method by which the time entry was created. Distinguishes between clock-in/out, manual entry, system import, or adjustment/correction entries.. Valid values are `clock|manual|imported|adjusted|correction`',
    `flsa_status` STRING COMMENT 'Classification of the employee position as exempt or non-exempt from FLSA overtime requirements. Determines overtime eligibility and timekeeping requirements.. Valid values are `exempt|non-exempt`',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours worked during this time entry period. Calculated from clock-in/out timestamps or manually entered. Used for payroll calculation.',
    `is_overtime_eligible` BOOLEAN COMMENT 'Flag indicating whether this time entry is eligible for overtime compensation. Typically true for non-exempt employees working over 40 hours per week.',
    `on_call_hours` DECIMAL(18,2) COMMENT 'Number of hours the employee was on-call and available for work. May be compensated at a different rate than active work hours.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours worked beyond the standard workweek threshold (typically 40 hours). Subject to overtime premium pay under FLSA for non-exempt employees.',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicator showing whether this time entry has been processed through payroll and included in a paycheck. Prevents duplicate payment processing.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of hours worked at the standard pay rate. Typically up to 40 hours per week for non-exempt employees under FLSA.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the supervisor when rejecting a time entry. Helps employee understand what corrections are needed.',
    `shift_differential_hours` DECIMAL(18,2) COMMENT 'Number of hours worked during shifts that qualify for differential pay (e.g., evening, night, weekend shifts). Eligible for additional compensation per institutional policy.',
    `submitted_date` DATE COMMENT 'Date when the employee submitted the time entry for supervisor approval. Used to track timeliness of time entry submission.',
    `supervisor_comments` STRING COMMENT 'Free-text notes or feedback provided by the supervisor during the approval process. May include approval rationale or correction instructions.',
    `time_entry_number` STRING COMMENT 'Human-readable business identifier for the time entry. May be used for employee and supervisor reference.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this time entry record was last modified. Tracks the most recent change for audit and reconciliation purposes.',
    `work_date` DATE COMMENT 'The calendar date on which the work was performed. Used for pay period assignment and labor distribution reporting.',
    `work_location_code` STRING COMMENT 'Code identifying the physical location where the work was performed. Used for labor distribution, facilities management, and multi-campus reporting.',
    `work_location_name` STRING COMMENT 'Human-readable name of the work location. Provides context for where the employee performed work.',
    `workday_time_entry_reference` STRING COMMENT 'External unique identifier from Workday HCM Time Tracking system. Used for source system reconciliation and audit trail.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Transactional record of employee time worked including clock-in/clock-out timestamps, hours worked by earning code (regular, overtime, shift differential, on-call), work location, cost center allocation, supervisor approval status, and pay period assignment. Critical for non-exempt/hourly staff FLSA compliance, overtime calculation, and payroll input. Sourced from Workday HCM Time Tracking.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`hr`.`employee` ADD CONSTRAINT `fk_hr_employee_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `education_ecm`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `education_ecm`.`hr`.`employee` ADD CONSTRAINT `fk_hr_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`hr`.`employee` ADD CONSTRAINT `fk_hr_employee_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`position` ADD CONSTRAINT `fk_hr_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `education_ecm`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `education_ecm`.`hr`.`position` ADD CONSTRAINT `fk_hr_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`hr`.`position` ADD CONSTRAINT `fk_hr_position_position_supervisory_org_org_unit_id` FOREIGN KEY (`position_supervisory_org_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`hr`.`position` ADD CONSTRAINT `fk_hr_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`hr`.`org_unit` ADD CONSTRAINT `fk_hr_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ADD CONSTRAINT `fk_hr_staffing_event_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `education_ecm`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ADD CONSTRAINT `fk_hr_staffing_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ADD CONSTRAINT `fk_hr_staffing_event_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ADD CONSTRAINT `fk_hr_staffing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ADD CONSTRAINT `fk_hr_employee_compensation_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `education_ecm`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ADD CONSTRAINT `fk_hr_employee_compensation_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ADD CONSTRAINT `fk_hr_employee_compensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ADD CONSTRAINT `fk_hr_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `education_ecm`.`hr`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ADD CONSTRAINT `fk_hr_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ADD CONSTRAINT `fk_hr_payroll_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ADD CONSTRAINT `fk_hr_payroll_result_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`hr`.`absence_event` ADD CONSTRAINT `fk_hr_absence_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`hr`.`absence_event` ADD CONSTRAINT `fk_hr_absence_event_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`hr`.`absence_event` ADD CONSTRAINT `fk_hr_absence_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `education_ecm`.`hr`.`job_profile`(`job_profile_id`);
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_tertiary_recruitment_recruiter_employee_id` FOREIGN KEY (`tertiary_recruitment_recruiter_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ADD CONSTRAINT `fk_hr_hr_applicant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ADD CONSTRAINT `fk_hr_hr_applicant_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `education_ecm`.`hr`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ADD CONSTRAINT `fk_hr_hr_applicant_tertiary_hr_recruiter_employee_id` FOREIGN KEY (`tertiary_hr_recruiter_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`performance_review` ADD CONSTRAINT `fk_hr_performance_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`hr`.`performance_review` ADD CONSTRAINT `fk_hr_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`hr`.`performance_review` ADD CONSTRAINT `fk_hr_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`performance_review` ADD CONSTRAINT `fk_hr_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`time_entry` ADD CONSTRAINT `fk_hr_time_entry_adjusted_time_entry_id` FOREIGN KEY (`adjusted_time_entry_id`) REFERENCES `education_ecm`.`hr`.`time_entry`(`time_entry_id`);
ALTER TABLE `education_ecm`.`hr`.`time_entry` ADD CONSTRAINT `fk_hr_time_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`hr`.`time_entry` ADD CONSTRAINT `fk_hr_time_entry_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`hr`.`time_entry` ADD CONSTRAINT `fk_hr_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`hr`.`time_entry` ADD CONSTRAINT `fk_hr_time_entry_tertiary_time_approved_by_employee_id` FOREIGN KEY (`tertiary_time_approved_by_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`hr` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `education_ecm`.`hr` SET TAGS ('dbx_domain' = 'hr');
ALTER TABLE `education_ecm`.`hr`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`hr`.`employee` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee ID');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Annual Salary');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `benefits_eligible` SET TAGS ('dbx_business_glossary_term' = 'Benefits Eligible Flag');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Status');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'us_citizen|permanent_resident|visa_holder|other');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'has_disability|no_disability|not_disclosed');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `eeo_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Category');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|terminated|retired|suspended');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|temporary|contract');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `fte_percent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `highest_degree_earned` SET TAGS ('dbx_business_glossary_term' = 'Highest Degree Earned');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `highest_degree_earned` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctoral|professional');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `institution_employee_number` SET TAGS ('dbx_business_glossary_term' = 'Institution Employee Number');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `institution_employee_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `institution_employee_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `institutional_email` SET TAGS ('dbx_business_glossary_term' = 'Institutional Email Address');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `institutional_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `institutional_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `institutional_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `original_hire_date` SET TAGS ('dbx_business_glossary_term' = 'Original Hire Date');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'biweekly|semi_monthly|monthly|weekly');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_business_glossary_term' = 'Personal Email Address');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `race_ethnicity_code` SET TAGS ('dbx_business_glossary_term' = 'Race and Ethnicity Code');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `race_ethnicity_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `race_ethnicity_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible Flag');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `remote_work_type` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Type');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `remote_work_type` SET TAGS ('dbx_value_regex' = 'on_site|hybrid|fully_remote');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `retirement_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Retirement Plan Code');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `retirement_plan_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union / Bargaining Unit Code');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `veteran_status` SET TAGS ('dbx_value_regex' = 'protected_veteran|not_protected_veteran|not_disclosed');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `veteran_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `veteran_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `visa_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Visa Expiration Date');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `visa_expiration_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `visa_expiration_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `visa_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `visa_type` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `workday_worker_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Worker ID');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `workday_worker_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `workday_worker_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type');
ALTER TABLE `education_ecm`.`hr`.`employee` ALTER COLUMN `worker_type` SET TAGS ('dbx_value_regex' = 'employee|contingent_worker|intern|graduate_assistant');
ALTER TABLE `education_ecm`.`hr`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`hr`.`position` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `position_supervisory_org_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Organization ID');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports-To Position ID');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `authorized_date` SET TAGS ('dbx_business_glossary_term' = 'Position Authorization Date');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `available_for_overlap` SET TAGS ('dbx_business_glossary_term' = 'Available for Overlap Flag');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Annual Salary');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `chartfield_string` SET TAGS ('dbx_business_glossary_term' = 'Chartfield String');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `compensation_grade_profile` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade Profile');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `compensation_grade_profile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `compensation_grade_profile` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `cupa_hr_benchmark_code` SET TAGS ('dbx_business_glossary_term' = 'College and University Professional Association for Human Resources (CUPA-HR) Benchmark Code');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `eeo_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Category');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Position Effective Date');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `employee_category` SET TAGS ('dbx_business_glossary_term' = 'Employee Category');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `employee_category` SET TAGS ('dbx_value_regex' = 'staff|administrator|executive|technical|service');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Position End Date');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `frozen_date` SET TAGS ('dbx_business_glossary_term' = 'Position Frozen Date');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'general_fund|grant|auxiliary|restricted|designated');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `headcount_type` SET TAGS ('dbx_business_glossary_term' = 'Headcount Type');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `headcount_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `ipeds_occupation_category` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Occupation Category');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `is_benefits_eligible` SET TAGS ('dbx_business_glossary_term' = 'Benefits Eligibility Flag');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `is_critical_position` SET TAGS ('dbx_business_glossary_term' = 'Critical Position Flag');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `is_remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligibility Flag');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `max_incumbents` SET TAGS ('dbx_business_glossary_term' = 'Maximum Incumbents');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'biweekly|semimonthly|monthly|weekly');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `position_number` SET TAGS ('dbx_business_glossary_term' = 'Position Number');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|filled|frozen|eliminated|pending_approval');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'regular|temporary|grant_funded|seasonal|pooled');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `requires_background_check` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `salary_maximum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `salary_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `salary_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Midpoint');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `salary_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `salary_minimum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `salary_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `soc_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Occupational Classification (SOC) Code');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `soc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `education_ecm`.`hr`.`position` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union / Bargaining Unit Code');
ALTER TABLE `education_ecm`.`hr`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`hr`.`job_profile` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Code Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `ada_essential_functions_documented` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Essential Functions Documented Indicator');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Indicator');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `bargaining_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit Code');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `benefits_eligibility_class` SET TAGS ('dbx_business_glossary_term' = 'Benefits Eligibility Class');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `benefits_eligibility_class` SET TAGS ('dbx_value_regex' = 'Full Benefits|Partial Benefits|No Benefits');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `critical_job` SET TAGS ('dbx_business_glossary_term' = 'Critical Job Indicator');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `cupa_hr_survey_code` SET TAGS ('dbx_business_glossary_term' = 'College and University Professional Association for Human Resources (CUPA-HR) Survey Code');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `driving_required` SET TAGS ('dbx_business_glossary_term' = 'Driving Requirement Indicator');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `eeo1_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO-1) Job Category');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `employee_type` SET TAGS ('dbx_business_glossary_term' = 'Employee Type');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `employee_type` SET TAGS ('dbx_value_regex' = 'Regular|Temporary|Seasonal|Casual');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exemption Status');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'Exempt|Non-Exempt|Exempt-Executive|Exempt-Administrative|Exempt-Professional');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `fte_capacity` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Capacity');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `inactive_date` SET TAGS ('dbx_business_glossary_term' = 'Inactive Date');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `ipeds_occupational_category` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Occupational Category');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `job_family_group` SET TAGS ('dbx_business_glossary_term' = 'Job Family Group');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `job_summary` SET TAGS ('dbx_business_glossary_term' = 'Job Summary');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_business_glossary_term' = 'Management Level');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_value_regex' = 'Individual Contributor|Manager|Senior Manager|Director|Vice President|Executive');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `min_education_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Requirement');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `min_education_requirement` SET TAGS ('dbx_value_regex' = 'High School Diploma/GED|Associate Degree|Bachelor Degree|Master Degree|Doctoral Degree|Professional Degree');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `min_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,3}[0-9]{1,3}$');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `pay_grade_max_usd` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Maximum (USD)');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `pay_grade_max_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `pay_grade_midpoint_usd` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Midpoint (USD)');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `pay_grade_midpoint_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `pay_grade_min_usd` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Minimum (USD)');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `pay_grade_min_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending Review|Deprecated');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `retirement_plan_eligible` SET TAGS ('dbx_business_glossary_term' = 'Retirement Plan Eligibility Indicator');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `sox_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Sensitive Role Indicator');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `stem_designated` SET TAGS ('dbx_business_glossary_term' = 'Science Technology Engineering Mathematics (STEM) Designation Indicator');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Union Eligibility Indicator');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'On-Site|Remote|Hybrid');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `work_shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `education_ecm`.`hr`.`job_profile` ALTER COLUMN `work_shift` SET TAGS ('dbx_value_regex' = 'Day|Evening|Night|Rotating|Variable');
ALTER TABLE `education_ecm`.`hr`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`hr`.`org_unit` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Code Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Primary Accreditation Body');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|candidate|probation|not_accredited|exempt');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `banner_org_code` SET TAGS ('dbx_business_glossary_term' = 'Ellucian Banner Organization Code');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `banner_org_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Building Code');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `building_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,15}$');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `dissolved_date` SET TAGS ('dbx_business_glossary_term' = 'Unit Dissolved Date');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Email Address');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Unit Established Date');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `fte_actual` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Actual');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `fte_budget` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Budget');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `gl_fund_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Fund Code');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `hierarchy_depth` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Depth');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `idc_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost (IDC) Rate Type');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `idc_rate_type` SET TAGS ('dbx_value_regex' = 'on_campus_research|off_campus_research|instruction|other_sponsored|not_applicable');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `ipeds_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Unit ID');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `ipeds_unit_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,9}$');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `is_academic_unit` SET TAGS ('dbx_business_glossary_term' = 'Is Academic Unit Flag');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `is_degree_granting` SET TAGS ('dbx_business_glossary_term' = 'Is Degree-Granting Unit Flag');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `is_research_active` SET TAGS ('dbx_business_glossary_term' = 'Is Research-Active Unit Flag');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `mission_statement` SET TAGS ('dbx_business_glossary_term' = 'Unit Mission Statement');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `next_accreditation_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Accreditation Review Date');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `org_hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Path');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|dissolved');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `peoplesoft_deptid` SET TAGS ('dbx_business_glossary_term' = 'Oracle PeopleSoft Financials Department ID');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `peoplesoft_deptid` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Phone Number');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `position_count_authorized` SET TAGS ('dbx_business_glossary_term' = 'Authorized Position Count');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `position_count_filled` SET TAGS ('dbx_business_glossary_term' = 'Filled Position Count');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Office Room Number');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Hierarchy Level');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'academic|administrative|auxiliary|research_center|athletics');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Website URL');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[^s]{3,}$');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `workday_org_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Supervisory Organization ID');
ALTER TABLE `education_ecm`.`hr`.`org_unit` ALTER COLUMN `workday_org_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `staffing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Staffing Event ID');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Clearance Status');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|adverse_action|not_required');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `benefits_enrollment_deadline` SET TAGS ('dbx_business_glossary_term' = 'Benefits Enrollment Deadline');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `cobra_notification_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Notification Date');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'regular_full_time|regular_part_time|temporary|contingent|student_worker');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Staffing Event Status');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|approved|completed|cancelled|rescinded');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Staffing Event Type');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `exit_interview_status` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Status');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `exit_interview_status` SET TAGS ('dbx_value_regex' = 'not_required|scheduled|completed|declined|waived');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `final_paycheck_date` SET TAGS ('dbx_business_glossary_term' = 'Final Paycheck Date');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `i9_verification_status` SET TAGS ('dbx_business_glossary_term' = 'I-9 Employment Eligibility Verification Status');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `i9_verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|reverification_required|not_applicable');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `it_provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'IT Provisioning Status');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `it_provisioning_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_required');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `leave_return_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Return Date');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'fmla|medical|personal|military|parental|sabbatical');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `new_annual_salary` SET TAGS ('dbx_business_glossary_term' = 'New Annual Salary');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `new_annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `new_department_code` SET TAGS ('dbx_business_glossary_term' = 'New Department Code');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `new_fte` SET TAGS ('dbx_business_glossary_term' = 'New Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `new_job_title` SET TAGS ('dbx_business_glossary_term' = 'New Job Title');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `new_position_code` SET TAGS ('dbx_business_glossary_term' = 'New Position Code');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `orientation_completed` SET TAGS ('dbx_business_glossary_term' = 'New Employee Orientation Completed Flag');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'biweekly|semi_monthly|monthly|weekly');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `policy_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Acknowledgment Date');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `prior_annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Prior Annual Salary');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `prior_annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `prior_department_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Department Code');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `prior_fte` SET TAGS ('dbx_business_glossary_term' = 'Prior Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `prior_job_title` SET TAGS ('dbx_business_glossary_term' = 'Prior Job Title');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `prior_position_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Position Code');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Description');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible Flag');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `salary_change_pct` SET TAGS ('dbx_business_glossary_term' = 'Salary Change Percentage');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `salary_change_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `separation_type` SET TAGS ('dbx_business_glossary_term' = 'Separation Type');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `separation_type` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|retirement|death|end_of_contract');
ALTER TABLE `education_ecm`.`hr`.`staffing_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `employee_compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Compensation ID');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `employee_compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `employee_compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Approval Date');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Reason');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `compa_ratio` SET TAGS ('dbx_business_glossary_term' = 'Compa-Ratio');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `compa_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Status');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|cancelled');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|stipend|supplemental');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `cupa_hr_survey_category` SET TAGS ('dbx_business_glossary_term' = 'College and University Professional Association for Human Resources (CUPA-HR) Survey Category');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Effective Date');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `employee_category` SET TAGS ('dbx_business_glossary_term' = 'Employee Category');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `employee_category` SET TAGS ('dbx_value_regex' = 'faculty|staff|administrator|graduate_assistant|executive');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation End Date');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `fte_annualized_salary` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Annualized Salary');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `fte_annualized_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `fte_percent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percent');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Compensation Funding Source');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'general_fund|grant|auxiliary|restricted|designated');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `grant_funded_percent` SET TAGS ('dbx_business_glossary_term' = 'Grant Funded Percent');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `ipeds_occupation_category` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Occupation Category');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `is_equity_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Is Equity Adjustment Flag');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `is_market_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Is Market Adjustment Flag');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `merit_increase_amount` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Amount');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `merit_increase_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `merit_increase_percent` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percent');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Notes');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `pay_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Maximum');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `pay_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `pay_range_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Midpoint');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `pay_range_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `pay_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Minimum');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `pay_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `previous_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Salary Amount');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `previous_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `range_penetration` SET TAGS ('dbx_business_glossary_term' = 'Range Penetration');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `range_penetration` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `salary_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Salary Change Amount');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `salary_change_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `salary_change_percent` SET TAGS ('dbx_business_glossary_term' = 'Salary Change Percent');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `salary_change_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `salary_change_percent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `aca_metal_tier` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Metal Tier');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `aca_metal_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|catastrophic');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `annual_deductible_family` SET TAGS ('dbx_business_glossary_term' = 'Annual Family Deductible Amount');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `annual_deductible_individual` SET TAGS ('dbx_business_glossary_term' = 'Annual Individual Deductible Amount');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Carrier Name');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `carrier_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Plan ID');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `cobra_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligible Flag');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'per_pay_period|monthly|annually|semi_monthly|bi_weekly');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Benefit Coverage Tier');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Effective Date');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `eligibility_employee_class` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Employee Class');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `eligibility_fte_minimum` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Minimum Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employer_match_cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer Match Cap Rate');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employer_match_cap_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employer_match_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer Retirement Match Rate');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `employer_match_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `hsa_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Eligible Flag');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `irs_plan_type_code` SET TAGS ('dbx_business_glossary_term' = 'IRS Benefit Plan Type Code');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `irs_plan_type_code` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{1,5}$');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `minimum_essential_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Essential Coverage (MEC) Flag');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `minimum_value_flag` SET TAGS ('dbx_business_glossary_term' = 'ACA Minimum Value Flag');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Network Type');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|both|not_applicable');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment End Date');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Start Date');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `out_of_pocket_max_family` SET TAGS ('dbx_business_glossary_term' = 'Annual Family Out-of-Pocket Maximum');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `out_of_pocket_max_individual` SET TAGS ('dbx_business_glossary_term' = 'Annual Individual Out-of-Pocket Maximum');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Code');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Document URL');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Status');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued|grandfathered');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_subtype` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Subtype');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year End Date');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `plan_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year Start Date');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `pretax_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Contribution Flag');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `retirement_contribution_limit` SET TAGS ('dbx_business_glossary_term' = 'Retirement Plan Annual Contribution Limit');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `self_insured_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Insured Plan Flag');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Termination Date');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `tuition_waiver_credit_hours_max` SET TAGS ('dbx_business_glossary_term' = 'Tuition Waiver Maximum Credit Hours');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `vesting_period_years` SET TAGS ('dbx_business_glossary_term' = 'Vesting Period Years');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `vesting_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Vesting Schedule Type');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `vesting_schedule_type` SET TAGS ('dbx_value_regex' = 'immediate|cliff|graded|none');
ALTER TABLE `education_ecm`.`hr`.`benefit_plan` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Benefit Waiting Period Days');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `aca_affordability_met` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Affordability Indicator');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `aca_minimum_value_met` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Minimum Value Indicator');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `annual_employee_premium` SET TAGS ('dbx_business_glossary_term' = 'Annual Employee Premium Amount');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `annual_employee_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `annual_employee_premium` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `annual_employer_premium` SET TAGS ('dbx_business_glossary_term' = 'Annual Employer Premium Amount');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `annual_employer_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `annual_employer_premium` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `carrier_group_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Group Number');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Member ID');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `cobra_election_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Date');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility Indicator');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Benefit Contribution Frequency');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'biweekly|semimonthly|monthly|weekly|annual');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Benefit Coverage Tier');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|family|employee_domestic_partner');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Dependent Count');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Coverage Effective Date');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `election_source` SET TAGS ('dbx_business_glossary_term' = 'Benefit Election Source');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `election_source` SET TAGS ('dbx_value_regex' = 'self_service|hr_admin|open_enrollment|new_hire|life_event|auto_enrolled');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_class` SET TAGS ('dbx_business_glossary_term' = 'Employee Classification');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_class` SET TAGS ('dbx_value_regex' = 'faculty|staff|administrator|part_time|graduate_assistant');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Benefit Contribution Amount');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Benefit Contribution Amount');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `employer_match_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer Retirement Match Rate');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Coverage End Date');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Date');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Number');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^BE-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Status');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|waived|terminated|pending|suspended|draft');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Required Indicator');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Status');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied|waived');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `fsa_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Flexible Spending Account (FSA) Annual Election Amount');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `fsa_election_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `fsa_election_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `fte_at_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) at Enrollment');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `hsa_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Annual Election Amount');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `hsa_election_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `hsa_election_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `is_pretax` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Benefit Indicator');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `is_waived` SET TAGS ('dbx_business_glossary_term' = 'Benefit Waiver Indicator');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Life Insurance Coverage Amount');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `open_enrollment_period` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Identifier');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `open_enrollment_period` SET TAGS ('dbx_value_regex' = '^OE-[0-9]{4}(-[0-9]{2})?$');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Date');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Type');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `retirement_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Retirement Plan Contribution Rate');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `retirement_contribution_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `retirement_contribution_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'workday_hcm|banner|manual|other');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Benefit Waiver Reason');
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_value_regex' = 'covered_by_spouse|covered_by_other_employer|covered_by_medicare|covered_by_medicaid|declined_coverage|other');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `payroll_result_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Result ID');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `benefit_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Deduction Amount');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `benefit_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `benefit_deduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `check_amount` SET TAGS ('dbx_business_glossary_term' = 'Paper Check Amount');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `check_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `check_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `check_date` SET TAGS ('dbx_business_glossary_term' = 'Check Date (Payment Date)');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `direct_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Direct Deposit Amount');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `direct_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `direct_deposit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `employer_medicare_tax` SET TAGS ('dbx_business_glossary_term' = 'Employer Medicare Tax (FICA - HI Employer Share)');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `employer_medicare_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `employer_retirement_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Retirement Contribution Amount');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `employer_retirement_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `employer_social_security_tax` SET TAGS ('dbx_business_glossary_term' = 'Employer Social Security Tax (FICA - OASDI Employer Share)');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `employer_social_security_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Federal Income Tax Withheld');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `fica_taxable_wages` SET TAGS ('dbx_business_glossary_term' = 'Federal Insurance Contributions Act (FICA) Taxable Wages');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `fica_taxable_wages` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `fica_taxable_wages` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `fte_percent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Garnishment Deduction Amount');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `is_fica_exempt` SET TAGS ('dbx_business_glossary_term' = 'Federal Insurance Contributions Act (FICA) Exemption Indicator');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `is_supplemental_wage` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Wage Indicator');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `is_supplemental_wage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `is_supplemental_wage` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Local Income Tax Withheld');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax Withheld (FICA - HI)');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `pay_group` SET TAGS ('dbx_business_glossary_term' = 'Pay Group');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Type');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_value_regex' = 'hourly|salary|stipend|per_diem');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|wire_transfer|pay_card');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `retirement_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Retirement Plan Deduction Amount');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `retirement_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `retirement_deduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'complete|on_hold|cancelled|error|reversed');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Type');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regular|off_cycle|supplemental|bonus|correction|final');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax Withheld (FICA - OASDI)');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'State Income Tax Withheld');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `tax_withholding_state` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding State Code');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `tax_withholding_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `taxable_wages` SET TAGS ('dbx_business_glossary_term' = 'Federal Taxable Wages');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `taxable_wages` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `taxable_wages` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `w2_box12_code` SET TAGS ('dbx_business_glossary_term' = 'W-2 Box 12 Code');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `workday_payroll_result_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Payroll Result Reference ID');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `ytd_federal_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Federal Income Tax Withheld');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `ytd_federal_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `ytd_federal_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `ytd_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Pay');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `ytd_gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `ytd_gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `ytd_retirement_deduction` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Retirement Deduction');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `ytd_retirement_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ALTER COLUMN `ytd_retirement_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`hr`.`absence_event` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `absence_event_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Event Identifier');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `accrued_hours_balance` SET TAGS ('dbx_business_glossary_term' = 'Accrued Leave Hours Balance');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Status');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|cancelled|in_review|withdrawn');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Approved Date');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `approved_hours` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Hours');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `carried_over_hours` SET TAGS ('dbx_business_glossary_term' = 'Carried-Over Leave Hours');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `current_balance_hours` SET TAGS ('dbx_business_glossary_term' = 'Current Leave Balance Hours');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Denial Reason');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Leave Comments');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `employee_comments` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `employee_comments` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `fmla_designation_date` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Designation Date');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `fmla_hours_remaining` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Hours Remaining');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `fmla_hours_used_ytd` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Hours Used Year-to-Date');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `forfeited_hours` SET TAGS ('dbx_business_glossary_term' = 'Forfeited Leave Hours');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `fte_impact` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Impact');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `is_fmla_designated` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Designated Flag');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `is_intermittent` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Flag');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `leave_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Leave Duration Days');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `leave_end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `leave_pay_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Pay Type');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `leave_pay_type` SET TAGS ('dbx_value_regex' = 'paid|unpaid|partial_pay');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `leave_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `leave_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `leave_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `leave_request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `leave_request_number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{8,12}$');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `leave_start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Leave Comments');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Date');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Flag');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required Flag');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Date');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `requested_hours` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Hours');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Work Date');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `used_hours` SET TAGS ('dbx_business_glossary_term' = 'Used Leave Hours');
ALTER TABLE `education_ecm`.`hr`.`absence_event` ALTER COLUMN `workday_absence_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Absence Event ID');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition ID');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Location ID');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `application_close_date` SET TAGS ('dbx_business_glossary_term' = 'Application Close Date');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `approved_fte` SET TAGS ('dbx_business_glossary_term' = 'Approved Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `cancelled_date` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Date');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `eeo_job_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Job Category');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|temporary|contract|seasonal');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `filled_date` SET TAGS ('dbx_business_glossary_term' = 'Filled Date');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `ipeds_occupation_category` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Occupation Category');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `is_confidential_search` SET TAGS ('dbx_business_glossary_term' = 'Confidential Search Indicator');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `is_confidential_search` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `job_grade` SET TAGS ('dbx_business_glossary_term' = 'Job Grade');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Requisition Justification');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `minimum_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Minimum Qualifications');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `number_of_openings` SET TAGS ('dbx_business_glossary_term' = 'Number of Openings');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `position_description_url` SET TAGS ('dbx_business_glossary_term' = 'Position Description URL');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `positions_filled_count` SET TAGS ('dbx_business_glossary_term' = 'Positions Filled Count');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `posting_channel` SET TAGS ('dbx_business_glossary_term' = 'Posting Channel');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `posting_channel` SET TAGS ('dbx_value_regex' = 'internal_only|external_only|internal_and_external');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `preferred_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Qualifications');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `requires_background_check` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Indicator');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `requires_degree_verification` SET TAGS ('dbx_business_glossary_term' = 'Degree Verification Required Indicator');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'draft|approved|posted|filled|cancelled|on_hold');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'new_headcount|backfill|temporary|reclassification|transfer');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `salary_range_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Midpoint');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `salary_range_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `search_committee_required` SET TAGS ('dbx_business_glossary_term' = 'Search Committee Required Indicator');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `target_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Target Fill Date');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `visa_sponsorship_eligible` SET TAGS ('dbx_business_glossary_term' = 'Visa Sponsorship Eligible Indicator');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_campus|remote|hybrid');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `hr_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Applicant ID');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Employee ID');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition ID');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `tertiary_hr_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `tertiary_hr_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `tertiary_hr_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Applicant Address Line 1');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `application_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|pending|clear|adverse|cancelled');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Applicant City');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Applicant Country Code');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer Name');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `current_employer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `current_job_title` SET TAGS ('dbx_business_glossary_term' = 'Current Job Title');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `current_job_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `desired_salary` SET TAGS ('dbx_business_glossary_term' = 'Desired Salary');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `desired_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status Self-Identification');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'has_disability|no_disability|decline_to_state');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `eeo_gender` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Gender Self-Identification');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `eeo_gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|decline_to_state');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `eeo_gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `eeo_gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `eeo_race_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Race and Ethnicity Self-Identification');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `eeo_race_ethnicity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `eeo_race_ethnicity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Email Address');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant First Name');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level Attained');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `interview_stage` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `interview_stage` SET TAGS ('dbx_value_regex' = 'phone_screen|hiring_manager|panel|final|none');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `is_internal_applicant` SET TAGS ('dbx_business_glossary_term' = 'Internal Applicant Indicator');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `is_rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Indicator');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Last Name');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Middle Name');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Offer Amount');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `offer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `offer_response` SET TAGS ('dbx_business_glossary_term' = 'Offer Response');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `offer_response` SET TAGS ('dbx_value_regex' = 'accepted|declined|countered|expired');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Phone Number');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Applicant Postal Code');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Preferred Name');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Applicant Source Channel');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `source_detail` SET TAGS ('dbx_business_glossary_term' = 'Applicant Source Detail');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Applicant State or Province');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status Self-Identification');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_value_regex' = 'protected_veteran|not_protected_veteran|decline_to_state');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'authorized|requires_sponsorship|not_authorized|not_disclosed');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `workday_candidate_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Candidate ID');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `workday_candidate_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `workday_candidate_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`hr`.`hr_applicant` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Relevant Work Experience');
ALTER TABLE `education_ecm`.`hr`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`hr`.`performance_review` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `calibrated_overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Calibrated Overall Performance Rating');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `calibrated_overall_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_calibration|calibrated|overridden');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `development_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Required Flag');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `employee_acknowledged_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment Comments');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `fte_at_review` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) at Review');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `goal_achievement_rating` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Rating');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `goal_achievement_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `goals_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Performance Goals');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `goals_met_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Goals Met');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Competency Rating');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|not_applicable');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `merit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible Flag');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `merit_increase_pct` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `merit_increase_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `overall_rating_numeric` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating Numeric Score');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `pip_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Required Flag');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'Review Narrative Comments');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `review_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|project|off_cycle');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `self_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Self-Assessment Completed Flag');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `self_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Assessment Completion Date');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Review Submitted Date');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `talent_segment` SET TAGS ('dbx_business_glossary_term' = 'Talent Segment');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `talent_segment` SET TAGS ('dbx_value_regex' = 'high_potential|key_contributor|solid_performer|developing|at_risk');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `talent_segment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`hr`.`performance_review` ALTER COLUMN `workday_review_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Review ID');
ALTER TABLE `education_ecm`.`hr`.`time_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`hr`.`time_entry` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Identifier (ID)');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `adjusted_time_entry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `tertiary_time_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `tertiary_time_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `tertiary_time_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|returned');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `chartfield_string` SET TAGS ('dbx_business_glossary_term' = 'Chartfield String');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock In Timestamp');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock Out Timestamp');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `earning_code` SET TAGS ('dbx_business_glossary_term' = 'Earning Code');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `earning_description` SET TAGS ('dbx_business_glossary_term' = 'Earning Description');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Status');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|paid|cancelled');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Type');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'clock|manual|imported|adjusted|correction');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non-exempt');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `is_overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Overtime Eligible');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `on_call_hours` SET TAGS ('dbx_business_glossary_term' = 'On-Call Hours');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `shift_differential_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Hours');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted Date');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `supervisor_comments` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Comments');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `time_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Number');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `work_location_name` SET TAGS ('dbx_business_glossary_term' = 'Work Location Name');
ALTER TABLE `education_ecm`.`hr`.`time_entry` ALTER COLUMN `workday_time_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Time Entry Identifier (ID)');
