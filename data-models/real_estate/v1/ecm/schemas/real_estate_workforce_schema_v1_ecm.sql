-- Schema for Domain: workforce | Business: Real Estate | Version: v1_ecm
-- Generated on: 2026-05-02 01:47:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `real_estate_ecm`.`workforce` COMMENT 'Manages human capital data for property managers, asset managers, brokers, leasing agents, construction staff, and corporate employees. Sourced from ADP Workforce Now. Covers employee profiles, payroll, benefits, time and attendance, licensing/certification tracking (broker licenses, appraiser credentials), talent management, roles, and workforce planning across property management, development, and corporate functions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique surrogate identifier for each employee record in the workforce data product. Primary key for the employee master record sourced from ADP Workforce Now.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Real estate employees are assigned to specific geographic markets for licensing jurisdiction compliance, compensation benchmarking by MSA, and market coverage headcount reporting — standard real estat',
    `manager_employee_id` BIGINT COMMENT 'Self-referencing identifier pointing to the direct line manager of this employee, enabling hierarchical org chart traversal and approval routing.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, or team) to which this employee belongs for reporting and cost allocation purposes.',
    `position_id` BIGINT COMMENT 'Reference to the position record that defines the role, grade, and organizational slot assigned to this employee.',
    `adp_employee_number` STRING COMMENT 'The externally-known, human-readable employee number assigned by ADP Workforce Now. Used as the cross-system identifier for payroll, benefits, and HR transactions.',
    `appraiser_credential` STRING COMMENT 'The Appraisal Qualifications Board (AQB) credential level held by the employee for real estate valuation work. Applicable to appraisers and valuation analysts. Null or none for non-appraisal staff.. Valid values are `trainee|licensed|certified_residential|certified_general|none`',
    `background_check_status` STRING COMMENT 'The outcome of the most recent pre-employment or periodic background screening. Required for employees with access to tenant personal data, financial systems, or secured properties. Supports GDPR and SOX compliance.. Valid values are `passed|pending|failed|not_required`',
    `base_salary` DECIMAL(18,2) COMMENT 'The employees annual base salary in the organizations functional currency (USD). Excludes bonuses, commissions, and benefits. Used for compensation benchmarking, OPEX budgeting, and payroll processing.',
    `benefits_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible to enroll in company-sponsored benefits programs including health insurance, retirement plans, and paid time off. Typically tied to employment type and hours worked.',
    `benefits_enrollment_date` DATE COMMENT 'The date on which the employee enrolled in the companys benefits programs. Used to track open enrollment windows, waiting periods, and benefits cost accruals.',
    `broker_license_expiry_date` DATE COMMENT 'The date on which the employees primary real estate broker or salesperson license expires. Used to trigger renewal workflows and ensure regulatory compliance before license lapse.',
    `broker_license_number` STRING COMMENT 'The state-issued real estate broker or salesperson license number for licensed personnel. Required for MLS access, listing agreements, and regulatory compliance with NAR and state real estate commissions.',
    `broker_license_state` STRING COMMENT 'The U.S. state (two-letter USPS abbreviation) in which the employee holds an active real estate broker or salesperson license. An employee may hold licenses in multiple states; this captures the primary licensing jurisdiction.. Valid values are `^[A-Z]{2}$`',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible to earn sales commissions, applicable to brokers, leasing agents, and investment advisory staff. Drives commission plan assignment in Salesforce CRM.',
    `data_source_system` STRING COMMENT 'Identifies the operational system of record from which this employee record was sourced. Primarily ADP Workforce Now, with potential supplemental records from SAP S/4HANA for corporate employees.. Valid values are `adp_workforce_now|sap_s4hana|manual`',
    `department_name` STRING COMMENT 'The name of the department to which the employee is assigned, such as Property Management, Asset Management, Brokerage, Development, Finance, or Corporate Services.',
    `eeo_category` STRING COMMENT 'The EEO-1 job category assigned to the employee for federal equal employment opportunity reporting. Categories include Executive/Senior Level Officials, Professionals, Technicians, Sales Workers, etc. [ENUM-REF-CANDIDATE: exec_senior|first_mid_mgr|professionals|technicians|sales_workers|admin_support|craft_workers|operatives|laborers|service_workers — promote to reference product]',
    `employment_status` STRING COMMENT 'Current lifecycle state of the employees engagement with the organization. Governs system access, payroll processing, and benefits continuation eligibility.. Valid values are `active|terminated|on_leave|suspended|pending`',
    `employment_type` STRING COMMENT 'Classification of the employees engagement model with the organization. Drives benefits eligibility, payroll processing rules, and FLSA classification applicability.. Valid values are `full_time|part_time|contractor|intern|temporary`',
    `flsa_classification` STRING COMMENT 'Designates whether the employee is exempt or non-exempt under the Fair Labor Standards Act, determining overtime pay eligibility and minimum wage applicability.. Valid values are `exempt|non_exempt`',
    `hire_date` DATE COMMENT 'The official date on which the employee commenced employment with the organization. Used to calculate tenure, benefits vesting schedules, and anniversary-based compensation reviews.',
    `i9_verification_status` STRING COMMENT 'Status of the employees Form I-9 employment eligibility verification as required by U.S. immigration law. Tracks whether identity and work authorization documents have been reviewed and verified.. Valid values are `verified|pending|expired|not_required`',
    `job_title` STRING COMMENT 'The official job title of the employee as defined in the HR system. Examples include Property Manager (PM), Asset Manager (AM), Leasing Agent, Broker, Construction Project Manager, and Facility Operations Coordinator.',
    `leave_type` STRING COMMENT 'The type of leave the employee is currently on, if employment_status is on_leave. Drives payroll continuation rules, benefits continuation, and return-to-work planning.. Valid values are `fmla|personal|medical|parental|military|none`',
    `legal_first_name` STRING COMMENT 'The employees legal given name as recorded on government-issued identification. Used for payroll tax filings, I-9 verification, and regulatory reporting.',
    `legal_last_name` STRING COMMENT 'The employees legal family name as recorded on government-issued identification. Used for payroll tax filings, I-9 verification, and regulatory reporting.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid. Drives payroll processing cycles in ADP Workforce Now and cash flow planning for Accounts Payable (AP).. Valid values are `weekly|bi_weekly|semi_monthly|monthly`',
    `pay_grade` STRING COMMENT 'The compensation band or grade level assigned to the employees position, used for salary benchmarking, merit increase eligibility, and internal equity analysis.',
    `preferred_name` STRING COMMENT 'The name the employee prefers to be addressed by in day-to-day operations, tenant communications, and internal directories. May differ from legal name.',
    `professional_designation` STRING COMMENT 'Industry professional designations held by the employee, such as CCIM (Certified Commercial Investment Member), CPM (Certified Property Manager), MAI (Member Appraisal Institute), LEED AP, or PMP. Supports talent capability mapping.',
    `pto_balance_days` DECIMAL(18,2) COMMENT 'The current accrued and available Paid Time Off (PTO) balance for the employee expressed in days. Sourced from ADP Workforce Now time and attendance module. Used for workforce planning and leave liability reporting.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when the employee record was first created in the data platform, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to the employee record in the data platform, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC) and incremental ETL processing.',
    `rehire_eligible` BOOLEAN COMMENT 'Indicates whether a terminated employee is eligible for rehire based on separation circumstances, performance history, and HR policy review. Used during talent acquisition screening.',
    `salesforce_user_code` STRING COMMENT 'The employees user account identifier in Salesforce CRM, used to link brokerage activity, deal pipeline ownership, tenant relationship management, and commission tracking.',
    `termination_date` DATE COMMENT 'The date on which the employees employment was formally ended, whether through resignation, retirement, or involuntary separation. Null for active employees.',
    `work_email` STRING COMMENT 'The employees corporate email address used for internal communications, system access provisioning, and CRM (Salesforce) user account linkage.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_location_name` STRING COMMENT 'The specific name of the employees primary work location, such as a property address, regional office name, or corporate headquarters designation. Supports workforce planning by location.',
    `work_location_type` STRING COMMENT 'Categorizes the primary work location of the employee: on-site at a managed property, a regional office, corporate headquarters, fully remote, or field-based (e.g., construction inspectors, appraisers).. Valid values are `property_site|regional_office|corporate_hq|remote|field`',
    `work_phone` STRING COMMENT 'The employees primary business telephone number, including country code in E.164 format. Used for tenant service escalations, broker communications, and emergency contact routing.. Valid values are `^+?[1-9]d{1,14}$`',
    `workforce_segment` STRING COMMENT 'The primary business function segment to which the employee belongs within the real estate enterprise. Enables workforce analytics, headcount reporting by business line, and CAPEX vs OPEX labor allocation. [ENUM-REF-CANDIDATE: property_management|asset_management|brokerage|development|facility_ops|corporate|investment_advisory — 7 candidates stripped; promote to reference product]',
    `yardi_user_code` STRING COMMENT 'The employees user account identifier in Yardi Voyager, enabling cross-system linkage for property management, lease administration, and GL transaction attribution.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record and Single Source of Truth (SSOT) for all real estate workforce personnel including property managers, asset managers, brokers, leasing agents, construction staff, facility operations staff, and corporate employees. Sourced from ADP Workforce Now. Captures legal name, preferred name, employee number, employment type (full-time, part-time, contractor), employment status (active, terminated, on-leave), hire date, termination date, rehire eligibility, job title, department, cost center, work location (property, regional office, corporate HQ), manager hierarchy, FLSA classification, EEO category, and HR system identifiers. Links to position for role assignment and org_unit for departmental membership.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique surrogate identifier for an authorized headcount position within the real estate enterprise organizational structure. Primary key for this entity. Sourced from ADP Workforce Now HCM module.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Real estate positions are market-specific (e.g., Southeast Leasing Agent). Linking to geographic_hierarchy enables headcount-by-submarket workforce planning reports, license jurisdiction compliance,',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Positions are instantiations of standardized job profiles within the organizational structure. A position (authorized headcount slot) is based on a job profile (standardized job definition). Adding jo',
    `replaced_position_id` BIGINT COMMENT 'Self-referencing FK on position (replaced_position_id)',
    `adp_position_code` STRING COMMENT 'The native position identifier assigned by ADP Workforce Now HCM system. Used for data lineage, system reconciliation, and integration with payroll and benefits processing. Enables traceability back to the system of record.. Valid values are `^[A-Z0-9-]{3,30}$`',
    `approved_date` DATE COMMENT 'The date on which the position was formally approved by the authorized budget owner or executive sponsor. Required for SOX headcount control documentation and audit trail.',
    `budgeted_fte` DECIMAL(18,2) COMMENT 'The approved number of full-time equivalent headcount units authorized for this position in the current budget cycle. A value of 1.0 represents one full-time position; 0.5 represents a half-time position. Used for headcount budgeting, OPEX planning, and workforce capacity analysis.',
    `comp_band_code` STRING COMMENT 'Reference code linking this position to the enterprise compensation band structure that defines the minimum, midpoint, and maximum salary range. Confidential business data used for pay equity analysis, offer management, and compensation benchmarking. Sourced from ADP Workforce Now compensation module.. Valid values are `^[A-Z0-9-]{2,15}$`',
    `comp_band_max` DECIMAL(18,2) COMMENT 'The maximum annual base salary (in USD) defined for this positions compensation band. Used for offer management, pay equity compliance, and OPEX budgeting. Confidential business data.',
    `comp_band_min` DECIMAL(18,2) COMMENT 'The minimum annual base salary (in USD) defined for this positions compensation band. Used for offer management, pay equity compliance, and OPEX budgeting. Confidential business data.',
    `competency_framework_code` STRING COMMENT 'Reference code linking this position to the enterprise competency framework that defines the behavioral and technical competencies required for success in the role. Supports talent management, performance reviews, and succession planning.. Valid values are `^[A-Z0-9-]{2,20}$`',
    `cost_center_code` STRING COMMENT 'GL cost center code to which the labor costs for this position are allocated. Links workforce data to the financial general ledger for OPEX reporting and budget variance analysis. Aligns with SAP S/4HANA cost center structure.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this position record was first created in the data platform. Supports audit trail, data lineage, and SOX financial controls documentation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the compensation band values for this position (e.g., USD, CAD, GBP). Supports multi-currency workforce reporting for international real estate portfolios.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Alphanumeric code identifying the department in the enterprise HR and GL systems. Enables cross-system reconciliation between ADP Workforce Now and SAP S/4HANA cost center structures.. Valid values are `^[A-Z0-9-]{2,15}$`',
    `department_name` STRING COMMENT 'Name of the organizational department to which this position belongs (e.g., Commercial Leasing, Property Operations, Development, Investment Advisory, Finance). Used for headcount budgeting and org design.',
    `division_name` STRING COMMENT 'Name of the business division or business unit to which the position belongs (e.g., Commercial Real Estate, Residential, Development, Corporate). Supports divisional headcount reporting and P&L attribution.',
    `effective_end_date` DATE COMMENT 'The date on which this position definition ceases to be effective. Null indicates the position is open-ended and currently active. Used for position lifecycle management and historical org structure reporting.',
    `effective_start_date` DATE COMMENT 'The date on which this position definition became or becomes effective within the organizational structure. Supports position history tracking and workforce planning timelines. Aligns with ADP Workforce Now effective-dating conventions.',
    `employment_type` STRING COMMENT 'Classification of the employment arrangement associated with the position. Determines benefits eligibility, payroll processing rules, and headcount counting methodology (e.g., full-time equivalents vs. headcount).. Valid values are `full_time|part_time|contract|temporary|intern`',
    `fill_status` STRING COMMENT 'Indicates whether the position is currently occupied by one or more employees. filled means at least one active employee is assigned; vacant means no active employee is assigned; partially_filled applies to positions with budgeted FTE greater than 1 where only a portion is filled. Drives open requisition and vacancy reporting.. Valid values are `filled|vacant|partially_filled`',
    `flsa_classification` STRING COMMENT 'Classification of the position under the U.S. Fair Labor Standards Act. exempt positions are not eligible for overtime pay; non_exempt positions are eligible for overtime; independent_contractor positions are not direct employees. Critical for payroll compliance and labor law adherence.. Valid values are `exempt|non_exempt|independent_contractor`',
    `headcount_budget_year` STRING COMMENT 'The fiscal year for which the budgeted FTE count for this position was approved. Enables year-over-year headcount budget variance analysis and workforce planning cycle management.',
    `is_revenue_generating` BOOLEAN COMMENT 'Indicates whether the position is directly involved in revenue-generating activities such as brokerage, leasing, or investment advisory. Used to distinguish front-office (revenue) from back-office (support) positions for OPEX allocation and incentive compensation plan eligibility.',
    `is_safety_sensitive` BOOLEAN COMMENT 'Indicates whether the position is classified as safety-sensitive under OSHA regulations, requiring drug testing, safety training, and compliance with building safety protocols. Applies to construction, maintenance, and facilities operations roles.',
    `job_family` STRING COMMENT 'Broad functional grouping that classifies the position into a major workforce segment of the real estate enterprise. Drives compensation benchmarking, workforce planning, and talent analytics. [ENUM-REF-CANDIDATE: Property Management|Brokerage|Development|Finance|Operations|Investment|Corporate|Compliance|Technology — promote to reference product if additional families are needed]',
    `job_function` STRING COMMENT 'Specific functional sub-category within the job family (e.g., Lease Administration, Valuation and Appraisal, Construction Oversight, Portfolio Reporting, Tenant Relations). Provides finer-grained classification for workforce analytics and succession planning.',
    `job_grade` STRING COMMENT 'Alphanumeric grade or level code within the enterprise job architecture that determines the compensation band and career level of the position (e.g., G1 through G15, or L1 through L8). Used for pay equity analysis and promotion eligibility.. Valid values are `^[A-Z0-9-]{1,10}$`',
    `job_level` STRING COMMENT 'Hierarchical career level classification for the position. Determines span of control expectations, decision-making authority, and compensation band eligibility. [ENUM-REF-CANDIDATE: individual_contributor|senior_individual_contributor|manager|senior_manager|director|vice_president|executive|c_suite — promote to reference product]',
    `key_responsibilities` STRING COMMENT 'Narrative description of the primary duties, accountabilities, and deliverables associated with the position. Sourced from the official job description in ADP Workforce Now. Used for job postings, performance management, and competency framework alignment.',
    `position_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the position within the organizational hierarchy. Used for cross-system reference and workforce planning reports. Sourced from ADP Workforce Now.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `position_status` STRING COMMENT 'Current lifecycle state of the authorized position. active indicates the position is approved and may be filled; vacant indicates it is approved but currently unfilled; frozen indicates a hiring freeze is in effect; eliminated indicates the position has been removed from the headcount plan; pending_approval indicates the position is awaiting budget or executive approval.. Valid values are `active|vacant|frozen|eliminated|pending_approval`',
    `primary_work_location` STRING COMMENT 'Name or address of the primary physical work location assigned to this position (e.g., corporate headquarters, regional office, specific property address). Used for facilities planning, tax nexus determination, and emergency contact routing.',
    `required_certifications` STRING COMMENT 'Comma-separated list of additional professional certifications or credentials required for the position beyond broker license, appraiser credential, and LEED (e.g., CPM, CCIM, CFA, PMP, OSHA 30-Hour, BOMA). Used for compliance tracking and job posting.',
    `required_education` STRING COMMENT 'Minimum educational qualification required for the position (e.g., High School Diploma, Associate Degree, Bachelors Degree in Real Estate or Finance, Masters Degree, MBA). Used for candidate screening and job posting compliance.',
    `required_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for the position. Used for candidate screening, job posting, and workforce planning benchmarks.',
    `requires_appraiser_credential` BOOLEAN COMMENT 'Indicates whether a certified or licensed appraiser credential (e.g., Certified General Appraiser, Certified Residential Appraiser) is a mandatory requirement for this position. Applies to valuation and appraisal roles.',
    `requires_broker_license` BOOLEAN COMMENT 'Indicates whether a valid real estate broker or salesperson license is a mandatory requirement for this position. Applies to brokerage, leasing agent, and property management roles subject to state licensing requirements. Drives license compliance tracking.',
    `requires_leed_certification` BOOLEAN COMMENT 'Indicates whether a LEED certification (e.g., LEED AP, LEED Green Associate) is a mandatory requirement for this position. Applies to development, sustainability, and facilities management roles supporting ESG and green building initiatives.',
    `sap_position_code` STRING COMMENT 'The native position identifier assigned by SAP S/4HANA HCM module. Used for cross-system reconciliation between ADP Workforce Now and SAP financial and procurement systems.. Valid values are `^[A-Z0-9-]{3,30}$`',
    `target_fill_date` DATE COMMENT 'The target date by which a vacant position should be filled. Used by talent acquisition teams to prioritize open requisitions and track time-to-fill metrics for workforce planning.',
    `title` STRING COMMENT 'Official job title associated with the position as defined in the enterprise job catalog (e.g., Property Manager, Leasing Agent, Asset Manager, Construction Project Manager, Broker Associate). Displayed on org charts, offer letters, and workforce reports.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this position record was last modified in the data platform. Used for change data capture, incremental ETL processing, and audit trail maintenance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `work_location_type` STRING COMMENT 'Designates the expected physical work arrangement for the position. on_site requires presence at a company property or office; remote is fully off-site; hybrid combines on-site and remote; field applies to property managers, maintenance staff, and brokers who work across multiple property locations.. Valid values are `on_site|remote|hybrid|field`',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized headcount positions and standardized job definitions within the organizational structure of the real estate enterprise. Captures position code, title, department, division, job family (Property Management, Brokerage, Development, Finance, Operations), job level/grade, FLSA classification, budgeted FTE, filled vs vacant status, reporting position, work location type, effective dates, required education, required experience, required licenses/certifications (e.g., broker license, appraiser credential, LEED certification), key responsibilities, compensation band reference, and competency frameworks. Supports workforce planning, headcount budgeting, org design, and serves as the template catalog for all recognized roles. A position may be vacant or filled by multiple employees over time. Sourced from ADP Workforce Now HCM module.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the job profile record in the enterprise data platform. Primary key for the job_profile entity.',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Job profiles for licensed real estate roles (broker, appraiser) are governed by specific regulatory frameworks. Enables compliance-driven job design, ensures licensed position requirements align with ',
    `approval_date` DATE COMMENT 'Date on which the job profile was formally approved by the designated authority. Required for SOX compliance documentation and HR governance audit trails.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the HR or business leader who formally approved this job profile for use. Supports governance and SOX internal control documentation for workforce management processes.',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a pre-employment background check is mandatory for this job profile. Standard for roles with fiduciary responsibility, access to tenant financial data, or property access (e.g., property managers, leasing agents, finance staff).',
    `benefits_eligible` BOOLEAN COMMENT 'Indicates whether positions created from this job profile qualify for the companys standard benefits package (health insurance, retirement plan, PTO). Drives benefits enrollment eligibility in ADP Workforce Now.',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether positions created from this job profile are eligible for performance-based bonus or incentive compensation. Drives bonus plan enrollment in ADP Workforce Now.',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether the job profile is eligible for commission-based compensation, applicable to brokerage, leasing, and sales roles where transaction-based incentives are standard practice in real estate.',
    `compensation_frequency` STRING COMMENT 'Pay frequency basis for the compensation band values (Annual salary, Hourly rate, Monthly, Bi-Weekly). Determines how min/mid/max compensation figures are interpreted in payroll and reporting.. Valid values are `Annual|Hourly|Monthly|Bi-Weekly`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the job profile record was first created in the system. Supports audit trail requirements under SOX Section 302 and data lineage tracking in the Databricks Silver Layer.',
    `drug_test_required` BOOLEAN COMMENT 'Indicates whether pre-employment or periodic drug testing is required for this job profile. Typically applicable to construction, maintenance, and facility operations roles subject to OSHA safety standards.',
    `eeo_job_category` STRING COMMENT 'EEO-1 job category classification assigned to this job profile as required by the U.S. Equal Employment Opportunity Commission for federal reporting (e.g., Officials and Managers, Professionals, Sales Workers, Administrative Support). [ENUM-REF-CANDIDATE: Officials and Managers|Professionals|Technicians|Sales Workers|Administrative Support|Craft Workers|Operatives|Laborers|Service Workers — promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which this job profile version becomes active and available for use in position creation and hiring. Supports point-in-time reporting and compliance with FASB ASC 842 and SOX audit trail requirements.',
    `employment_type` STRING COMMENT 'Classification of the intended employment arrangement for positions created from this job profile. Determines eligibility for benefits, payroll processing rules, and HR policy applicability.. Valid values are `Full-Time|Part-Time|Contract|Temporary|Intern`',
    `expiry_date` DATE COMMENT 'Date on which this job profile version ceases to be active. Null indicates the profile is open-ended with no planned expiration. Used for versioning and historical workforce analytics.',
    `flsa_classification` STRING COMMENT 'Designation of the job profile under the U.S. Fair Labor Standards Act indicating whether the role is exempt or non-exempt from overtime pay requirements. Critical for payroll compliance and labor law adherence. Exempt roles typically include managers, licensed brokers, and professional staff.. Valid values are `Exempt|Non-Exempt|Highly Compensated|Independent Contractor`',
    `flsa_exemption_basis` STRING COMMENT 'Specific FLSA exemption category that justifies the exempt classification for this job profile. Required for compliance documentation and DOL audit defense. Applicable to roles such as licensed brokers (Outside Sales), property managers (Executive/Administrative), and appraisers (Professional). [ENUM-REF-CANDIDATE: Executive|Administrative|Professional|Outside Sales|Computer|Highly Compensated|None — 7 candidates stripped; promote to reference product]',
    `job_code` STRING COMMENT 'Externally-known alphanumeric code that uniquely identifies the job profile across HR systems, payroll, and reporting. Sourced from ADP Workforce Now and used as the cross-system business key (e.g., PM-MGR-001, BRK-AGT-003). Aligns with SAP S/4HANA HCM position coding conventions.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `job_family` STRING COMMENT 'Broad functional grouping that clusters related job profiles sharing common competencies and career pathways within the real estate enterprise (e.g., Property Management, Brokerage, Asset Management, Development, Finance, Operations, Compliance, Corporate). [ENUM-REF-CANDIDATE: Property Management|Brokerage|Asset Management|Development|Finance|Operations|Compliance|Leasing|Construction|Corporate|Investment Advisory|Facility Operations — promote to reference product]',
    `job_family_group` STRING COMMENT 'Higher-level grouping above job family that aligns with major business divisions for workforce planning and reporting (e.g., Revenue-Generating, Property Operations, Corporate & Support, Development & Construction). Enables enterprise-wide headcount and compensation analytics.',
    `job_grade` STRING COMMENT 'Internal compensation grade code assigned to the job profile, used to map the role to a salary band and benefits tier (e.g., G5, M3, E2). Confidential as it directly informs compensation structure. Sourced from ADP Workforce Now compensation module.. Valid values are `^[A-Z]{1,3}[0-9]{1,3}$`',
    `job_level` STRING COMMENT 'Career level designation indicating the seniority and scope of the role within the job family hierarchy. Used for compensation banding, succession planning, and organizational reporting. [ENUM-REF-CANDIDATE: Entry|Associate|Mid|Senior|Lead|Manager|Director|VP|SVP|EVP|C-Suite — promote to reference product if more than 6 levels are actively used]',
    `job_summary` STRING COMMENT 'Concise overview of the job profiles purpose and value within the organization, typically 2-4 sentences. Used as the opening paragraph in job postings and offer letters.',
    `job_title` STRING COMMENT 'Official human-readable title of the job profile as it appears on offer letters, org charts, and business cards (e.g., Senior Property Manager, Commercial Leasing Agent, Asset Manager, Construction Project Manager). Serves as the primary identity label for the role.',
    `key_responsibilities` STRING COMMENT 'Narrative description of the primary duties, accountabilities, and scope of work associated with this job profile. Used in job postings, performance management frameworks, and organizational design. Sourced from ADP Workforce Now job description module.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the job profile record. Used for change data capture (CDC) in the Databricks lakehouse pipeline and SOX audit trail compliance.',
    `license_required` BOOLEAN COMMENT 'Indicates whether a professional license (e.g., real estate broker license, appraiser credential) is a mandatory requirement for this job profile. Enables rapid filtering of regulated roles for compliance audits.',
    `max_compensation_usd` DECIMAL(18,2) COMMENT 'Maximum base salary or hourly rate defined for the compensation band associated with this job profile, expressed in USD. Caps the pay range for positions created from this profile.',
    `mid_compensation_usd` DECIMAL(18,2) COMMENT 'Midpoint of the compensation band for this job profile, representing the market reference point for a fully proficient incumbent. Used in compa-ratio analysis and compensation benchmarking.',
    `min_compensation_usd` DECIMAL(18,2) COMMENT 'Minimum base salary or hourly rate defined for the compensation band associated with this job profile, expressed in USD. Used for offer management, equity analysis, and compliance with pay transparency regulations. Confidential as it contains compensation structure data.',
    `min_education_requirement` STRING COMMENT 'Minimum academic qualification required for candidates to be considered for positions created from this job profile. Used in applicant screening and compliance with equal employment opportunity (EEO) standards.. Valid values are `High School Diploma|Associate Degree|Bachelor Degree|Master Degree|Doctorate|Professional Certification`',
    `min_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for the job profile. Used in talent acquisition screening, succession planning, and workforce analytics.',
    `preferred_certifications` STRING COMMENT 'Pipe-delimited list of professional certifications that are preferred but not required for this job profile (e.g., LEED Green Associate|Six Sigma|CFA). Used in talent acquisition scoring and development planning.',
    `preferred_experience_years` STRING COMMENT 'Preferred number of years of relevant professional experience for the job profile, above the minimum requirement. Used to differentiate candidate quality tiers in talent acquisition.',
    `profile_status` STRING COMMENT 'Current lifecycle state of the job profile record. Active profiles are available for position creation and hiring. Inactive or Archived profiles are retained for historical reference but cannot be used for new positions.. Valid values are `Active|Inactive|Draft|Pending Approval|Archived`',
    `reporting_structure` STRING COMMENT 'Description of the organizational reporting relationship for this job profile, indicating the typical managerial title this role reports to (e.g., Reports to Regional Property Manager). Supports org chart design and succession planning.',
    `required_certifications` STRING COMMENT 'Pipe-delimited list of professional certifications required for this job profile (e.g., LEED AP|CCIM|CPM|MAI|PMP|OSHA 30). Supports compliance tracking for green building, appraisal, and construction roles. Detailed certification records are tracked in workforce certification tables.',
    `required_license_types` STRING COMMENT 'Pipe-delimited list of professional licenses legally or operationally required for this job profile (e.g., Real Estate Broker License|Appraiser License|General Contractor License). Critical for compliance tracking in brokerage, appraisal, and development roles. Detailed license records are managed in the broker_license product.',
    `soc_code` STRING COMMENT 'U.S. Bureau of Labor Statistics Standard Occupational Classification code assigned to this job profile. Used for labor market benchmarking, compensation surveys, and regulatory workforce reporting (e.g., 41-9021 for Real Estate Brokers, 11-9141 for Property Managers).. Valid values are `^[0-9]{2}-[0-9]{4}$`',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this job profile was sourced (ADP Workforce Now, SAP S/4HANA HCM, or manually created). Supports data lineage and reconciliation in the Databricks Silver Layer.. Valid values are `ADP|SAP|MANUAL`',
    `travel_requirement` STRING COMMENT 'Expected level of travel associated with this job profile. Relevant for field-based roles such as property managers, brokers, appraisers, and construction supervisors who regularly visit properties across a portfolio.. Valid values are `None|Minimal|Moderate|Frequent|Extensive`',
    `union_eligible` BOOLEAN COMMENT 'Indicates whether positions created from this job profile are eligible for union membership or covered by a collective bargaining agreement. Relevant for construction, maintenance, and facility operations roles in unionized markets.',
    `work_location_type` STRING COMMENT 'Designates the expected work arrangement for positions created from this job profile. Field-Based is common for property managers, brokers, and maintenance staff who operate across multiple property sites.. Valid values are `On-Site|Remote|Hybrid|Field-Based`',
    `worker_category` STRING COMMENT 'Distinguishes between employees on payroll and non-employee workers (contractors, contingent staff) associated with this job profile. Drives payroll processing, tax treatment, and benefits eligibility rules in ADP Workforce Now.. Valid values are `Employee|Contractor|Contingent Worker|Intern`',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Standardized job definitions and competency frameworks used across the real estate enterprise. Defines job code, job title, job family (e.g., Property Management, Brokerage, Development, Finance, Operations), job level, FLSA classification, required education, required experience, required licenses/certifications (e.g., real estate broker license, appraiser credential, LEED certification), key responsibilities, and compensation band reference. Serves as the catalog of all recognized roles and is the template from which positions are created. Sourced from ADP Workforce Now HCM module.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique surrogate identifier for the organizational unit record in the enterprise data platform. Primary key for the org_unit entity.',
    `unit_id` BIGINT COMMENT 'Native organizational unit identifier from ADP Workforce Now, the system of record for payroll, benefits, and time and attendance. Used for cross-system reconciliation and ETL lineage tracking.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Real estate firms structure property-level org units (on-site management teams) directly tied to specific assets. The is_property_level_unit flag and associated_property_code confirm this pattern. For',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Org unit to cost center mapping is fundamental for real estate labor cost allocation and departmental P&L reporting. gl_cost_center_code is a denormalized string; this FK enables validated cost center',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Real estate org units (regional offices, property management teams) are organized by geographic hierarchy. Enables org structure reporting by market, regional P&L alignment, and market-level headcount',
    `parent_unit_org_unit_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent organizational unit, enabling hierarchical traversal of the enterprise org structure (e.g., a team rolls up to a department, which rolls up to a division). Null for the root/top-level unit.',
    `actual_headcount_fte` DECIMAL(18,2) COMMENT 'Current filled headcount expressed in Full-Time Equivalent (FTE) units as of the most recent payroll cycle. Compared against budgeted FTE to compute headcount variance for workforce planning reporting.',
    `actual_labor_cost` DECIMAL(18,2) COMMENT 'Total actual labor cost incurred (in base currency) for this organizational unit for the current planning period, sourced from ADP Workforce Now payroll and SAP S/4HANA GL. Used for budget vs. actual variance analysis.',
    `budgeted_headcount_fte` DECIMAL(18,2) COMMENT 'Approved budgeted headcount expressed in Full-Time Equivalent (FTE) units for the current workforce planning period. Supports CAPEX/OPEX labor budgeting, property-level staffing models, and headcount variance reporting.',
    `budgeted_labor_cost` DECIMAL(18,2) COMMENT 'Total approved labor cost budget (in base currency) for this organizational unit for the current planning period, encompassing salaries, benefits, and employer taxes. Supports CAPEX/OPEX labor budgeting and financial consolidation in SAP S/4HANA.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary jurisdiction in which this organizational unit operates. Supports multi-jurisdictional regulatory compliance reporting (GDPR, HUD, SEC) and international workforce planning.. Valid values are `^[A-Z]{3}$`',
    `critical_role_count` STRING COMMENT 'Number of roles within this organizational unit designated as critical for business continuity and succession planning purposes (e.g., licensed brokers, certified appraisers, senior asset managers). Drives succession planning prioritization.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts (budgeted and actual labor costs) recorded for this organizational unit (e.g., USD, EUR, GBP). Supports multi-currency financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `development_gaps_summary` STRING COMMENT 'Free-text summary of identified skill and competency development gaps for successor candidates within this organizational unit. Sourced from ADP Workforce Now talent management module. Supports targeted learning and development planning.',
    `effective_end_date` DATE COMMENT 'Date on which this organizational unit ceases to be operationally effective. Null for currently active units. Enables time-variant org structure queries and supports workforce planning cycle comparisons.',
    `effective_start_date` DATE COMMENT 'Date on which this organizational unit became or becomes operationally effective. Supports time-variant org structure modeling and historical headcount reporting aligned with ASC 842 and SOX period-end requirements.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this organizational unit within the enterprise hierarchy tree, where 1 represents the root/enterprise level. Used for hierarchical reporting, roll-up aggregations, and org chart rendering.',
    `hierarchy_path` STRING COMMENT 'Materialized path string representing the full ancestry chain of the org unit from root to current node (e.g., /1/5/12/47). Enables efficient subtree queries and hierarchy traversal without recursive joins.',
    `is_property_level_unit` BOOLEAN COMMENT 'Indicates whether this organizational unit is directly associated with a specific property or portfolio of properties (True) versus a corporate/shared-services unit (False). Enables property-level staffing model analysis and NOI labor cost attribution.',
    `labor_cost_variance` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual labor cost (budgeted minus actual) for the current planning period. Positive value indicates underspend; negative value indicates overspend. Supports financial performance reporting and workforce cost control.',
    `licensed_staff_count` STRING COMMENT 'Number of employees within this organizational unit who hold active professional licenses or certifications required for real estate operations (e.g., broker licenses, appraiser credentials, property manager licenses). Supports regulatory compliance reporting.',
    `notes` STRING COMMENT 'Free-text field for capturing supplementary information about the organizational unit, such as restructuring rationale, special workforce planning considerations, or interim leadership arrangements.',
    `open_requisition_count` STRING COMMENT 'Number of currently open job requisitions (unfilled positions) within this organizational unit. Used for workforce gap analysis, talent acquisition planning, and headcount reporting.',
    `opex_capex_classification` STRING COMMENT 'Indicates whether the labor costs of this organizational unit are classified as Operating Expenditure (OPEX), Capital Expenditure (CAPEX), or a mixed allocation. Drives GL cost allocation treatment in SAP S/4HANA and supports property-level financial reporting.. Valid values are `opex|capex|mixed`',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. active indicates the unit is operational; inactive indicates it is dormant; pending indicates it is approved but not yet effective; dissolved indicates it has been disbanded; restructuring indicates it is undergoing reorganization.. Valid values are `active|inactive|pending|dissolved|restructuring`',
    `physical_location_code` STRING COMMENT 'Code identifying the primary physical office or property location where this organizational unit is based. Supports geographic workforce distribution reporting and property-level staffing model analysis.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `physical_location_name` STRING COMMENT 'Human-readable name of the primary physical office or property location where this organizational unit operates (e.g., Atlanta Regional Office, One Peachtree Center - Property Office).',
    `plan_approval_status` STRING COMMENT 'Current approval workflow status of the workforce plan for this organizational unit. Tracks the plan through the budgeting and approval cycle from draft submission through executive sign-off.. Valid values are `draft|submitted|approved|rejected|revised`',
    `plan_approved_by` STRING COMMENT 'Name or employee identifier of the individual who formally approved the workforce plan for this organizational unit. Supports SOX financial controls and audit trail requirements.',
    `plan_approved_date` DATE COMMENT 'Date on which the workforce plan for this organizational unit was formally approved by the responsible executive or finance committee. Supports SOX audit trails and planning cycle governance.',
    `planned_attrition` STRING COMMENT 'Number of expected departures (voluntary and involuntary) planned for this organizational unit within the current workforce planning period. Used for net headcount change modeling and succession planning.',
    `planned_hires` STRING COMMENT 'Number of new hires planned for this organizational unit within the current workforce planning period. Supports workforce planning cycle analysis and labor cost forecasting.',
    `planning_period` STRING COMMENT 'The workforce planning cycle period to which the budgeted headcount and labor cost figures apply (e.g., 2024-FY, 2024-Q1, 2024-H1). Enables period-over-period workforce planning comparisons.. Valid values are `^[0-9]{4}-(Q[1-4]|H[12]|FY|M(0[1-9]|1[0-2]))$`',
    `primary_business_function` STRING COMMENT 'The primary real estate business function performed by this organizational unit. Aligns with the enterprises core business processes and data domains for workforce planning segmentation and property-level staffing models. [ENUM-REF-CANDIDATE: property_management|asset_management|leasing|brokerage|development|investment_advisory|finance|compliance|workforce|facilities|corporate|valuation|construction — promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the enterprise data platform (Silver Layer). Supports audit trail requirements, SOX financial controls, and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was most recently modified in the enterprise data platform. Supports change data capture, audit trail requirements, and SOX financial controls.',
    `retention_risk_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit has been flagged as having elevated retention risk for critical roles, based on succession planning assessments. True indicates elevated risk requiring proactive retention intervention.',
    `succession_readiness_level` STRING COMMENT 'Aggregate succession readiness assessment for critical roles within this organizational unit. Indicates whether qualified successor candidates are identified and ready. Supports leadership continuity planning and retention risk management.. Valid values are `high|medium|low|critical_gap`',
    `unit_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the organizational unit across source systems (ADP Workforce Now and SAP S/4HANA HCM). Used for cross-system reconciliation and reporting.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `unit_name` STRING COMMENT 'Full human-readable name of the organizational unit (e.g., Property Management - Southeast Division, Asset Management Department, Leasing Operations Team). Used in headcount reports, org charts, and workforce planning dashboards.',
    `unit_short_name` STRING COMMENT 'Abbreviated display name for the organizational unit used in space-constrained reporting, org charts, and system interfaces (e.g., PM-SE, AM-Dept, Leasing-Ops).',
    `unit_type` STRING COMMENT 'Classification of the organizational unit within the enterprise hierarchy. Drives hierarchy traversal logic, reporting roll-ups, and workforce planning segmentation. [ENUM-REF-CANDIDATE: division|department|team|cost_center|business_unit|region|function|sub_team — promote to reference product]. Valid values are `division|department|team|cost_center|business_unit|region`',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational hierarchy units and workforce planning data for the real estate enterprise. Org structure captures org unit code, name, type (division, department, team, cost center), parent org unit (for hierarchy traversal), responsible executive, GL cost center code, physical location, and effective dates. Workforce planning captures budgeted headcount (FTE) by planning period, actual filled headcount, open requisition count, planned hires and attrition, budgeted vs actual labor cost, variance, succession planning data for critical roles (successor candidates, readiness levels, development gaps, retention risk), and plan approval status. Supports headcount reporting, cost allocation, workforce planning cycles, CAPEX/OPEX labor budgeting, property-level staffing models, and leadership continuity planning. Sourced from ADP Workforce Now and SAP S/4HANA HCM.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`employment_event` (
    `employment_event_id` BIGINT COMMENT 'Primary key for employment_event',
    `compensation_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.compensation_plan. Business justification: Employment events such as promotions, merit increases, and role changes are directly tied to a compensation plan being applied or changed. Adding compensation_plan_id to employment_event links the HR ',
    `position_id` BIGINT COMMENT 'Reference to the organizational position associated with this employment event (e.g., the new position for a transfer or promotion).',
    `employee_id` BIGINT COMMENT 'Reference to the employee whose employment lifecycle is affected by this event. Links to the employee master record in the workforce domain.',
    `tertiary_employment_hr_business_partner_employee_id` BIGINT COMMENT 'Reference to the employee record of the HR Business Partner responsible for this employment event. Enables HRBP workload analysis and accountability tracking.',
    `adp_action_reference` STRING COMMENT 'Externally-known transaction reference number assigned by ADP Workforce Now for this personnel action. Used for cross-system reconciliation and audit trail linkage.',
    `appeal_filed_date` DATE COMMENT 'The date on which the employee formally filed an appeal against this employment event. Null if no appeal was filed. Used to track appeal deadlines and compliance with internal grievance procedures.',
    `appeal_status` STRING COMMENT 'Tracks whether the employee has filed an appeal against this employment event and the outcome. Applicable primarily to disciplinary actions and terminations. Supports wrongful termination defense and EEOC complaint management.. Valid values are `not_applicable|pending|upheld|overturned|withdrawn`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the employment event was formally approved by the authorized approving manager or HR business partner. Required for SOX internal control documentation.',
    `approving_manager_name` STRING COMMENT 'Full name of the manager who authorized and approved this employment event. Retained as a denormalized audit field to preserve the approval record even if the managers record changes. Required for SOX internal control documentation.',
    `compensation_type` STRING COMMENT 'Indicates whether the compensation rate represents an annual salary, hourly wage, commission-based, or contract arrangement. Determines how the rate is applied in payroll calculations.. Valid values are `annual_salary|hourly|commission|contract`',
    `effective_date` DATE COMMENT 'The business date on which the employment event takes effect for payroll, benefits, and HR record purposes. Distinct from the date the record was entered into the system. Critical for ASC 842 and SOX compliance timelines.',
    `event_category` STRING COMMENT 'High-level grouping of the employment event type for reporting and analytics. Career progression covers promotions, transfers, and demotions. Disciplinary covers warnings, suspensions, and termination for cause. Supports HR dashboard segmentation.. Valid values are `career_progression|compensation|disciplinary|leave|separation|onboarding`',
    `event_status` STRING COMMENT 'Current workflow state of the employment event record. Pending indicates awaiting approval; approved indicates authorized and ready for processing; completed indicates fully processed in payroll and HR systems.. Valid values are `pending|approved|rejected|cancelled|completed|under_review`',
    `event_type` STRING COMMENT 'Categorizes the nature of the HR personnel action. Drives downstream processing, notifications, and compliance workflows. [ENUM-REF-CANDIDATE: hire|rehire|transfer|promotion|demotion|leave_of_absence|return_from_leave|termination|position_change|compensation_change|verbal_warning|written_warning|final_written_warning|suspension|termination_for_cause — promote to reference product]',
    `hr_business_partner_name` STRING COMMENT 'Full name of the HR Business Partner (HRBP) who processed or oversaw this employment event. Denormalized for audit trail integrity. Supports HR accountability reporting and SOX controls.',
    `initiated_timestamp` TIMESTAMP COMMENT 'The date and time when this employment event was first entered or initiated in ADP Workforce Now. Serves as the system-of-record creation timestamp for audit trail purposes.',
    `investigation_findings` STRING COMMENT 'Summary of findings from any HR or legal investigation conducted prior to a disciplinary action or termination for cause. Documents the factual basis for the employment decision. Critical for wrongful termination defense and EEOC compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this employment event record was most recently modified in the source system or the Silver layer. Supports incremental data loading and audit trail completeness.',
    `leave_expected_return_date` DATE COMMENT 'The anticipated date the employee is expected to return from a leave of absence. Used for workforce planning, temporary backfill decisions, and FMLA compliance tracking. Null for non-leave events.',
    `leave_type` STRING COMMENT 'Specifies the category of leave for leave_of_absence and return_from_leave events. Drives benefits continuation rules, FMLA tracking, and return-to-work planning. Null for non-leave events.. Valid values are `fmla|medical|personal|military|parental|unpaid`',
    `legal_review_completed` BOOLEAN COMMENT 'Indicates whether the required legal review has been completed for this employment event. Paired with legal_review_required to track compliance with internal legal clearance procedures.',
    `legal_review_required` BOOLEAN COMMENT 'Indicates whether this employment event required review by the legal department prior to execution. Typically true for terminations for cause, suspensions, and events involving potential litigation risk. Supports SOX and wrongful termination defense documentation.',
    `new_compensation_rate` DECIMAL(18,2) COMMENT 'The employees base compensation rate (salary or hourly wage) assigned as a result of this employment event. Used for payroll processing, budget forecasting, and compensation equity analysis.',
    `new_department` STRING COMMENT 'The organizational department or cost center the employee is assigned to as a result of this event. Used for headcount allocation, budgeting, and workforce analytics.',
    `new_employment_type` STRING COMMENT 'The employees employment classification following this event. Used for benefits eligibility determination, FLSA compliance, and workforce composition reporting.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `new_flsa_classification` STRING COMMENT 'The employees FLSA exemption status assigned as a result of this employment event. Determines overtime pay eligibility and drives payroll processing rules.. Valid values are `exempt|non_exempt`',
    `new_job_title` STRING COMMENT 'The employees job title assigned as a result of this employment event. Populated for hire, rehire, transfer, promotion, demotion, and position change events.',
    `new_location` STRING COMMENT 'The property, office, or work site where the employee is assigned following this employment event. Supports property-level headcount tracking and facility staffing analytics.',
    `policy_violation_code` STRING COMMENT 'Standardized code identifying the specific company policy or code of conduct provision that was violated, applicable to disciplinary events (verbal warning, written warning, final written warning, suspension, termination for cause). Null for non-disciplinary events. [ENUM-REF-CANDIDATE: CONDUCT|ATTENDANCE|PERFORMANCE|HARASSMENT|SAFETY|FRAUD|CONFLICT_OF_INTEREST|DATA_BREACH — promote to reference product]',
    `policy_violation_description` STRING COMMENT 'Detailed narrative description of the policy violation or misconduct that triggered a disciplinary employment event. Supports wrongful termination defense documentation and HR compliance audits. Null for non-disciplinary events.',
    `prior_compensation_rate` DECIMAL(18,2) COMMENT 'The employees base compensation rate (salary or hourly wage) immediately before this employment event. Captured for compensation change, promotion, and demotion events. Expressed in the companys base currency.',
    `prior_department` STRING COMMENT 'The organizational department or cost center the employee belonged to before this event. Relevant for transfer and reorganization events. Supports workforce planning and headcount reporting.',
    `prior_employment_type` STRING COMMENT 'The employees employment classification (full-time, part-time, contractor, etc.) before this event. Relevant for events that change employment classification, such as converting a contractor to full-time.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `prior_flsa_classification` STRING COMMENT 'The employees FLSA exemption status before this employment event. Relevant for events that change job duties or compensation in ways that affect overtime eligibility. Null for events that do not affect FLSA status.. Valid values are `exempt|non_exempt`',
    `prior_job_title` STRING COMMENT 'The employees job title immediately before this employment event. Captured for transfer, promotion, demotion, and position change events to maintain a complete career history audit trail.',
    `prior_location` STRING COMMENT 'The property, office, or work site where the employee was based before this employment event. Relevant for transfer events across property portfolios, regional offices, or construction sites.',
    `reason_code` STRING COMMENT 'Standardized ADP reason code explaining why the employment event occurred (e.g., VOL-RES for voluntary resignation, INV-TRM for involuntary termination, PROMO for promotion). Used for HR analytics, turnover reporting, and regulatory filings. [ENUM-REF-CANDIDATE: VOL_RES|INV_TRM|PROMO|DEMOTION|TRANSFER|LOA_MED|LOA_PERS|REHIRE|SUSP_PAID|SUSP_UNPAID|COMP_ADJ|PERF_IMP — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text narrative explanation supplementing the reason code. Provides additional context for the employment event, particularly for disciplinary actions, terminations, and leave approvals.',
    `rehire_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for future rehire following a termination event. Set to false for terminations for cause or policy violations. Used by talent acquisition to screen returning candidates.',
    `severance_offered` BOOLEAN COMMENT 'Indicates whether a severance package was offered to the employee as part of a termination or separation event. Supports financial accrual reporting under FASB ASC 420 and SOX disclosure requirements.',
    `source_system` STRING COMMENT 'Identifies the originating operational system from which this employment event record was sourced. Supports data lineage tracking and Silver layer reconciliation in the Databricks Lakehouse.. Valid values are `ADP_Workforce_Now|SAP_S4HANA|Manual`',
    `suspension_duration_days` STRING COMMENT 'Number of calendar days the employee is suspended, applicable to suspension events. Used for payroll deduction calculations and progressive discipline tracking. Null for non-suspension events.',
    CONSTRAINT pk_employment_event PRIMARY KEY(`employment_event_id`)
) COMMENT 'Transactional record of all HR personnel actions and events affecting an employees employment lifecycle, including disciplinary actions. Captures event type (hire, rehire, transfer, promotion, demotion, leave of absence, return from leave, termination, position change, compensation change, verbal warning, written warning, final written warning, suspension, termination for cause), effective date, reason code, prior and new values for changed attributes, policy violation details (for disciplinary events), investigation findings, approving manager, HR business partner, legal review indicator, appeal status, and event status. Sourced from ADP Workforce Now. Provides the complete employment history audit trail — both positive career progression and corrective actions — for each employee across their tenure. Supports wrongful termination defense, SOX internal controls, and HR compliance audits.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`payroll` (
    `payroll_id` BIGINT COMMENT 'Primary key for payroll',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Payroll GL posting in real estate requires mapping payroll runs to the correct chart of accounts for property-level labor expense reporting and NOI calculation. gl_account_code is a denormalized strin',
    `compensation_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.compensation_plan. Business justification: Payroll runs are executed based on the compensation plan in effect for each employee. Adding compensation_plan_id to payroll links the payroll run to the authoritative compensation structure, enabling',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payroll cost allocation to cost centers is fundamental for real estate property-level P&L and NOI reporting. cost_center_code is a denormalized string; this FK enables validated cost center assignment',
    `employee_id` BIGINT COMMENT 'Reference to the employee whose payroll result is captured in this record. Links to the workforce employee master.',
    `adp_run_code` STRING COMMENT 'Externally-known payroll run identifier assigned by ADP Workforce Now. Used for reconciliation between the lakehouse and the source payroll system.',
    `allowance_earnings` DECIMAL(18,2) COMMENT 'Non-salary allowances paid in this pay period, such as vehicle allowances for property managers, mobile phone allowances, or housing allowances for field-based construction staff.',
    `base_salary_earnings` DECIMAL(18,2) COMMENT 'Portion of gross earnings attributable to the employees regular base salary for the pay period. Excludes variable pay components such as overtime, commission, and bonus.',
    `bonus_earnings` DECIMAL(18,2) COMMENT 'Discretionary or performance-based bonus amounts paid in this pay period. Includes signing bonuses, performance bonuses, and retention bonuses for asset managers, property managers, and corporate staff.',
    `commission_earnings` DECIMAL(18,2) COMMENT 'Variable compensation earned from real estate transaction commissions, lease signings, or brokerage deals closed during the pay period. Key earnings component for brokers and leasing agents.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll record was first created in the Silver layer lakehouse. Used for data lineage, audit trail, and incremental load tracking.',
    `employer_tax_liability` DECIMAL(18,2) COMMENT 'Total employer-side payroll tax obligation for this run, including employer FICA (Social Security and Medicare match), FUTA, and SUTA contributions. Used for GL posting to SAP S/4HANA and Yardi.',
    `employment_type` STRING COMMENT 'Classification of the employees engagement type for this payroll record. Determines applicable tax treatment, benefits eligibility, and FLSA overtime rules.. Valid values are `full_time|part_time|contractor|temporary`',
    `federal_income_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of federal income tax withheld from the employees gross pay in this pay period per IRS withholding tables and the employees W-4 elections.',
    `flsa_exempt_flag` BOOLEAN COMMENT 'Indicates whether the employee is classified as exempt from FLSA overtime provisions. Exempt employees (e.g., salaried asset managers, licensed brokers) are not eligible for overtime pay.',
    `gl_posted_flag` BOOLEAN COMMENT 'Indicates whether this payroll run result has been successfully posted to the General Ledger in Yardi Voyager or SAP S/4HANA. Critical for financial period close and payroll reconciliation.',
    `gl_posting_reference` STRING COMMENT 'Document or journal entry reference number generated when payroll expenses are posted to the GL in Yardi or SAP. Used for payroll-to-GL reconciliation and audit trail.',
    `gross_earnings` DECIMAL(18,2) COMMENT 'Total gross compensation earned by the employee in this pay period before any deductions or tax withholdings. Sum of base salary, overtime, commission, bonus, and allowances.',
    `group_code` STRING COMMENT 'ADP-assigned code identifying the payroll group (e.g., corporate staff, property managers, construction crew, brokers). Segments employees by pay schedule and processing batch.',
    `group_name` STRING COMMENT 'Human-readable name of the payroll group associated with this run (e.g., Property Management Staff, Brokerage Commission Earners, Construction Field Crew).',
    `hsa_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax contribution to a Health Savings Account (HSA) deducted in this pay period. Applicable only to employees enrolled in a qualifying high-deductible health plan.',
    `local_income_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of local/municipal income tax withheld in this pay period. Applicable in jurisdictions with local income taxes (e.g., NYC, Philadelphia) where real estate operations are present.',
    `medical_premium_deduction` DECIMAL(18,2) COMMENT 'Employee share of medical insurance premium deducted pre-tax in this pay period under the Section 125 cafeteria plan.',
    `medicare_tax_withheld` DECIMAL(18,2) COMMENT 'Employee share of Medicare (HI) tax withheld in this pay period, including the Additional Medicare Tax for high earners per ACA provisions.',
    `net_pay` DECIMAL(18,2) COMMENT 'Final take-home amount disbursed to the employee after all pre-tax deductions, tax withholdings, and post-tax deductions are subtracted from gross earnings. The amount deposited or paid by check.',
    `overtime_earnings` DECIMAL(18,2) COMMENT 'Gross earnings attributable to overtime hours worked beyond the standard work week, calculated at applicable overtime rates per FLSA requirements. Relevant for property management and construction field staff.',
    `pay_date` DATE COMMENT 'Actual date on which employee net pay is disbursed via direct deposit or check. Used for cash flow planning, GL posting date alignment in Yardi/SAP, and W-2 tax year assignment.',
    `pay_frequency` STRING COMMENT 'Frequency at which this payroll run is processed. Determines annualization factors for tax withholding calculations and compensation analytics.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_period_end_date` DATE COMMENT 'Last calendar date of the pay period covered by this payroll run. Defines the boundary for earnings, deductions, and tax withholding calculations.',
    `pay_period_start_date` DATE COMMENT 'First calendar date of the pay period covered by this payroll run. Used for period-over-period payroll reconciliation and FASB ASC 420/710 accrual alignment.',
    `payment_method` STRING COMMENT 'Method by which net pay is disbursed to the employee. Direct deposit is standard; check or pay card may be used for employees without bank accounts.. Valid values are `direct_deposit|check|wire_transfer|pay_card`',
    `posttax_deductions_total` DECIMAL(18,2) COMMENT 'Total of all post-tax deductions applied in this pay period, such as Roth 401(k) contributions, garnishments, union dues, or voluntary supplemental insurance premiums.',
    `pretax_deductions_total` DECIMAL(18,2) COMMENT 'Total of all pre-tax deductions applied in this pay period, including 401(k) contributions, HSA, FSA, and medical/dental/vision insurance premiums. Reduces taxable gross income.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run was processed and finalized in ADP Workforce Now. Serves as the principal business event timestamp for the payroll run lifecycle.',
    `retirement_401k_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax contribution to the 401(k) retirement savings plan deducted in this pay period. Subject to IRS annual contribution limits.',
    `run_status` STRING COMMENT 'Current lifecycle state of the payroll run. Tracks progression from initial calculation through GL posting or voiding. [ENUM-REF-CANDIDATE: draft|calculated|approved|posted|voided|reversed — promote to reference product if additional states are required]. Valid values are `draft|calculated|approved|posted|voided|reversed`',
    `run_type` STRING COMMENT 'Classification of the payroll run. Regular runs cover standard pay periods; off-cycle runs handle corrections, termination pay, or special bonus/commission disbursements common in real estate brokerage.. Valid values are `regular|off_cycle|bonus|commission|correction|final`',
    `social_security_tax_withheld` DECIMAL(18,2) COMMENT 'Employee share of Social Security (OASDI) tax withheld in this pay period at the applicable IRS rate on wages up to the annual wage base.',
    `state_income_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of state income tax withheld from the employees gross pay in this pay period. Varies by state of employment; relevant for multi-state real estate operations.',
    `tax_year` STRING COMMENT 'Calendar year to which this payroll runs earnings and withholdings are attributed for IRS W-2 reporting and year-end tax reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll record was last modified in the Silver layer lakehouse, such as after a correction run or GL posting status update.',
    `work_state_code` STRING COMMENT 'Two-letter US state code for the state in which the employee performed work during this pay period. Determines state income tax withholding jurisdiction for multi-state real estate operations.. Valid values are `^[A-Z]{2}$`',
    `ytd_federal_tax_withheld` DECIMAL(18,2) COMMENT 'Cumulative federal income tax withheld for the employee from the start of the tax year through this pay period. Used for W-2 Box 2 preparation and tax reconciliation.',
    `ytd_gross_earnings` DECIMAL(18,2) COMMENT 'Cumulative gross earnings for the employee from the start of the tax year through this pay period. Used for W-2 Box 1 preparation and annual compensation analytics.',
    `ytd_net_pay` DECIMAL(18,2) COMMENT 'Cumulative net pay disbursed to the employee from the start of the tax year through this pay period. Supports annual compensation reporting and payroll audit reconciliation.',
    CONSTRAINT pk_payroll PRIMARY KEY(`payroll_id`)
) COMMENT 'Payroll processing records for all real estate employees, covering both run-level headers and individual employee-level results. Run data captures payroll run ID, pay period dates, pay date, frequency, payroll group, run status, total gross/net pay, employer tax liability, and GL posting reference. Employee result data captures gross earnings by component (base salary, overtime, commission, bonus, allowances), pre-tax deductions (401k, HSA, FSA, medical/dental/vision premiums), federal/state/local tax withholdings, post-tax deductions, net pay, payment method, and YTD accumulators. Sourced from ADP Workforce Now Payroll module. Supports payroll reconciliation, GL posting to Yardi/SAP, W-2 preparation, payroll audits, and compensation analytics.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`payroll_result` (
    `payroll_result_id` BIGINT COMMENT 'Unique surrogate identifier for each individual employee payroll calculation result record in the Silver layer lakehouse.',
    `bank_account_id` BIGINT COMMENT 'Reference to the employees designated bank account for direct deposit of net pay. Null when payment method is check.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Individual payroll result GL posting in real estate requires validated chart of accounts mapping for accurate labor cost classification (opex vs. capex, CAM-recoverable). gl_account_code is a denormal',
    `compensation_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.compensation_plan. Business justification: Individual payroll results are calculated based on the employees active compensation plan. Adding compensation_plan_id to payroll_result links each employees pay calculation to the specific compensa',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual payroll result cost center allocation is required for real estate property-level labor cost reporting and NOI calculation. cost_center_code is a denormalized string; this FK enables validat',
    `employee_id` BIGINT COMMENT 'Reference to the employee whose payroll was calculated in this run. Links to the workforce employee master record.',
    `payroll_id` BIGINT COMMENT 'Reference to the payroll run batch under which this result was calculated. Identifies the specific payroll processing cycle.',
    `adp_payroll_result_number` STRING COMMENT 'Externally-known unique identifier assigned by ADP Workforce Now to this individual payroll result record. Used for reconciliation with the source system.',
    `allowance_amount` DECIMAL(18,2) COMMENT 'Total allowances paid in this pay period, including vehicle allowances, mobile phone allowances, and housing allowances for property managers or field staff.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when an authorized payroll administrator approved this result for payment disbursement. Null if not yet approved.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Gross base salary or regular hourly wage earnings for the pay period before any additions or deductions. Core compensation component for salaried and hourly employees.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Discretionary or performance-based bonus paid in this pay period. Includes signing bonuses, annual performance bonuses, and deal-closing incentives for real estate professionals.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission earnings paid in this pay period, typically applicable to brokers, leasing agents, and sales staff based on closed transactions or lease executions.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this payroll result. Typically USD for US-based real estate operations; supports multi-currency for international portfolios.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Code identifying the organizational department to which the employees compensation is charged. Used for cost allocation across property management, development, brokerage, and corporate functions.',
    `employee_type` STRING COMMENT 'Classification of the employees compensation arrangement at the time of this payroll result. Determines applicable overtime rules and tax treatment.. Valid values are `salaried_exempt|salaried_nonexempt|hourly|contractor|part_time`',
    `federal_income_tax_withheld` DECIMAL(18,2) COMMENT 'Federal income tax withheld from the employees gross earnings for this pay period based on W-4 filing status and allowances. Reported on IRS Form W-2 Box 2.',
    `gross_earnings_amount` DECIMAL(18,2) COMMENT 'Total gross earnings for the pay period, representing the sum of base salary, overtime, commission, bonus, and allowances before any deductions or tax withholdings.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total regular hours worked by the employee during the pay period as recorded in ADP time and attendance. Used for overtime calculation and labor cost allocation to properties.',
    `is_void` BOOLEAN COMMENT 'Indicates whether this payroll result has been voided. True when the result was cancelled before or after payment, requiring a reversal entry in the General Ledger.',
    `local_income_tax_withheld` DECIMAL(18,2) COMMENT 'Local or municipal income tax withheld from the employees earnings. Applicable in jurisdictions with city or county income taxes. Reported on IRS Form W-2 Box 19.',
    `medicare_tax_withheld` DECIMAL(18,2) COMMENT 'Employee share of Medicare (HI) tax withheld, including the Additional Medicare Tax for high earners. Reported on IRS Form W-2 Box 6.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Final take-home pay disbursed to the employee after all pre-tax deductions, tax withholdings, and post-tax deductions are subtracted from gross earnings. Represents the actual amount deposited or paid by check.',
    `overtime_amount` DECIMAL(18,2) COMMENT 'Total overtime pay earned during the pay period, calculated at 1.5x or 2x the regular rate for hours exceeding FLSA thresholds. Applicable to non-exempt employees.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours worked by the employee during the pay period exceeding the FLSA threshold. Drives overtime_amount calculation and labor compliance reporting.',
    `pay_frequency` STRING COMMENT 'Frequency at which the employee is paid. Determines the number of pay periods per year and the proration of annual salary components.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_period_end_date` DATE COMMENT 'Last calendar date of the pay period covered by this payroll result. Together with pay_period_start_date defines the earnings window.',
    `pay_period_start_date` DATE COMMENT 'First calendar date of the pay period covered by this payroll result. Defines the earnings window for time and attendance calculations.',
    `pay_type` STRING COMMENT 'Classification of the payroll run type for this result. regular = standard scheduled payroll; supplemental = bonus or commission run; off_cycle = manual correction; final = termination pay; void_replacement = reissued after void.. Valid values are `regular|supplemental|off_cycle|final|void_replacement`',
    `payment_date` DATE COMMENT 'Scheduled or actual date on which net pay is disbursed to the employee via direct deposit or check. Used for cash flow planning and W-2 tax year assignment.',
    `payment_method` STRING COMMENT 'Method by which net pay is disbursed to the employee. direct_deposit = ACH transfer to bank account; check = paper check; wire_transfer = same-day wire; pay_card = prepaid debit card.. Valid values are `direct_deposit|check|wire_transfer|pay_card`',
    `posttax_deductions_amount` DECIMAL(18,2) COMMENT 'Total post-tax deductions from the employees pay, including Roth 401(k) contributions, garnishments, union dues, and voluntary after-tax benefit elections.',
    `pretax_401k_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax contribution to the 401(k) retirement savings plan deducted from gross earnings. Reduces federal taxable wages. Subject to IRS annual contribution limits.',
    `pretax_dental_vision_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax payroll deduction for employer-sponsored dental and vision insurance premiums under a Section 125 cafeteria plan.',
    `pretax_fsa_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax contribution to a Flexible Spending Account (FSA) for healthcare or dependent care expenses deducted from gross earnings.',
    `pretax_hsa_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax contribution to a Health Savings Account (HSA) deducted from gross earnings. Applicable only to employees enrolled in a High Deductible Health Plan (HDHP).',
    `pretax_medical_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax payroll deduction for employer-sponsored medical insurance premiums under a Section 125 cafeteria plan.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll result was calculated and finalized by the payroll processing engine in ADP Workforce Now.',
    `result_status` STRING COMMENT 'Current lifecycle state of this payroll result. calculated = computed but not yet approved; approved = authorized for payment; paid = disbursed to employee; voided = cancelled before payment; reversed = payment recalled after disbursement.. Valid values are `calculated|approved|paid|voided|reversed`',
    `social_security_tax_withheld` DECIMAL(18,2) COMMENT 'Employee share of Social Security (OASDI) tax withheld at the applicable rate on wages up to the annual wage base. Reported on IRS Form W-2 Box 4.',
    `state_income_tax_withheld` DECIMAL(18,2) COMMENT 'State income tax withheld from the employees earnings for the primary work state. Reported on IRS Form W-2 Box 17. Varies by state tax jurisdiction.',
    `work_state_code` STRING COMMENT 'Two-letter US state code for the state in which the employee performed work during this pay period. Determines state income tax withholding jurisdiction.. Valid values are `^[A-Z]{2}$`',
    `ytd_federal_tax_withheld` DECIMAL(18,2) COMMENT 'Cumulative federal income tax withheld from the start of the calendar year through this pay period. Reported on IRS Form W-2 Box 2 at year-end.',
    `ytd_gross_earnings` DECIMAL(18,2) COMMENT 'Cumulative gross earnings from the start of the calendar year through and including this pay period. Used for W-2 preparation, Social Security wage base tracking, and compensation analytics.',
    `ytd_net_pay` DECIMAL(18,2) COMMENT 'Cumulative net pay disbursed to the employee from the start of the calendar year through this pay period. Supports payroll audit reconciliation and compensation reporting.',
    CONSTRAINT pk_payroll_result PRIMARY KEY(`payroll_result_id`)
) COMMENT 'Individual employee-level payroll calculation results for each payroll run. Captures employee reference, payroll run reference, pay period dates, gross earnings by component (base salary, overtime, commission, bonus, allowances), pre-tax deductions (401k, HSA, FSA, medical/dental/vision premiums), federal/state/local tax withholdings, post-tax deductions, net pay, payment method (direct deposit, check), bank account reference, and YTD accumulators. Sourced from ADP Workforce Now. Supports W-2 preparation, payroll audits, and compensation analytics for real estate workforce.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the compensation plan record. Primary key for this entity.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Real estate compensation plans are market-specific — broker pay bands and commission rates differ by MSA. Replaces denormalized geographic_market text field; enables market-benchmarked compensation an',
    `grade_band_id` BIGINT COMMENT 'Reference to the pay grade band associated with this compensation plan, used to define salary ranges and pay equity tiers across the real estate enterprise.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile (role definition) to which this compensation plan applies, such as Property Manager, Leasing Agent, or Asset Manager.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Compensation plans in real estate enterprises are often scoped to specific organizational units — property management divisions, brokerage groups, development teams, or corporate functions. Adding org',
    `superseded_by_plan_compensation_plan_id` BIGINT COMMENT 'Reference to the newer compensation plan record that replaced this plan when it was superseded. Enables plan lineage tracking and historical compensation analysis. Null if this is the current active version.',
    `approval_date` DATE COMMENT 'The date on which this compensation plan received final approval from the authorized HR or finance approver. Required for SOX audit trail and compensation governance.',
    `approval_status` STRING COMMENT 'Current lifecycle state of the compensation plan record. Draft plans are under construction; pending_approval awaits HR/finance sign-off; approved plans are active; rejected plans were declined; expired plans have passed their end date; superseded plans have been replaced by a newer version.. Valid values are `draft|pending_approval|approved|rejected|expired|superseded`',
    `approved_by` STRING COMMENT 'Name or employee identifier of the HR or finance authority who approved this compensation plan. Required for SOX compensation controls and audit trail.',
    `base_pay_rate` DECIMAL(18,2) COMMENT 'The base compensation rate assigned under this plan. For salaried employees this is the annual salary amount; for hourly employees this is the hourly rate. Expressed in the plan currency. Sensitive compensation data.',
    `bonus_frequency` STRING COMMENT 'The frequency at which performance bonuses are evaluated and paid under this plan. Common in property management roles where NOI performance is assessed quarterly or annually.. Valid values are `monthly|quarterly|semiannual|annual`',
    `bonus_max_pct` DECIMAL(18,2) COMMENT 'The maximum achievable bonus as a percentage of base pay under this plan, representing the cap on performance-based bonus payouts. Used for compensation budgeting and NOI impact analysis.',
    `bonus_target_pct` DECIMAL(18,2) COMMENT 'The target annual bonus expressed as a percentage of base pay for plans that include a performance bonus component (e.g., Property Manager base plus bonus). Null for commission-only or pure salary plans without bonus.',
    `car_allowance_amount` DECIMAL(18,2) COMMENT 'Monthly vehicle allowance included in this compensation plan, commonly provided to property managers, asset managers, and brokers who travel between properties. Expressed in plan currency per month.',
    `commission_basis` STRING COMMENT 'The transaction value base upon which the commission rate is applied. Gross Sale Price (PSF or total), Net Sale Price, Lease Value (total lease term value), Annual Rent (GRI), or Gross Commission Income (GCI) for split arrangements. Null for non-commission plans.. Valid values are `gross_sale_price|net_sale_price|lease_value|annual_rent|gross_commission_income`',
    `commission_rate_pct` DECIMAL(18,2) COMMENT 'The commission percentage applied to qualifying transaction values (e.g., sale price, lease value) for brokers and leasing agents. Expressed as a percentage (e.g., 3.0000 = 3%). Null for non-commission plan types.',
    `commission_schedule_ref` STRING COMMENT 'Reference code or identifier pointing to the detailed commission rate schedule document or table that governs tiered or variable commission structures for this plan. Links to the commission schedule master in ADP or Salesforce CRM.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compensation plan record was first created in the system. Used for audit trail, data lineage, and SOX compliance reporting.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this compensation plan (e.g., USD). Supports multi-currency operations for international real estate portfolios.. Valid values are `^[A-Z]{3}$`',
    `draw_amount` DECIMAL(18,2) COMMENT 'For draw-against-commission plans, the periodic advance amount paid to the broker or leasing agent against future earned commissions. Expressed in plan currency per pay period. Null for non-draw plan types.',
    `draw_recovery_method` STRING COMMENT 'Specifies whether the draw advance is recoverable (must be repaid from future commissions if earned commissions are insufficient) or non-recoverable (forgiven if commissions do not cover the draw). Critical for broker compensation accounting.. Valid values are `recoverable|non_recoverable`',
    `effective_date` DATE COMMENT 'The date on which this compensation plan becomes binding and active for the assigned job profile and grade band. Aligns with payroll cycle start dates in ADP Workforce Now.',
    `employment_type` STRING COMMENT 'The employment classification for which this plan is applicable. Independent contractor is common for brokers; full_time for property managers and corporate staff. Affects tax treatment and benefit eligibility.. Valid values are `full_time|part_time|contract|independent_contractor`',
    `equity_eligible` BOOLEAN COMMENT 'Indicates whether employees under this compensation plan are eligible for equity-based compensation (e.g., REIT stock grants, restricted stock units, or partnership interests). Relevant for senior AM and executive roles.',
    `equity_grant_target_pct` DECIMAL(18,2) COMMENT 'Target equity grant expressed as a percentage of base pay for eligible employees under this plan. Used for long-term incentive planning in REIT and investment management roles. Null if equity_eligible is False.',
    `expiration_date` DATE COMMENT 'The date on which this compensation plan ceases to be effective. Null indicates an open-ended plan with no defined end date. Used for plan versioning and renewal workflows.',
    `flsa_exemption_status` STRING COMMENT 'Fair Labor Standards Act (FLSA) classification for employees under this plan. Exempt employees are not entitled to overtime; non-exempt employees are entitled to overtime pay; highly_compensated applies to employees meeting the HCE threshold.. Valid values are `exempt|non_exempt|highly_compensated`',
    `housing_allowance_amount` DECIMAL(18,2) COMMENT 'Monthly housing allowance included in this compensation plan, applicable to on-site property managers or resident managers who may receive housing as part of their compensation package.',
    `license_stipend_amount` DECIMAL(18,2) COMMENT 'Annual stipend provided to employees for maintaining required professional licenses and certifications (e.g., real estate broker license, appraiser credentials, LEED certification). Expressed in plan currency per year.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether employees under this compensation plan are eligible for overtime pay under FLSA regulations. True for non-exempt hourly workers; False for exempt salaried employees.',
    `pay_frequency` STRING COMMENT 'The frequency at which employees under this plan are paid (e.g., biweekly, semimonthly). Drives payroll cycle configuration in ADP Workforce Now.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_grade` STRING COMMENT 'The pay grade designation within the compensation structure (e.g., G5, M3, E2). Defines the salary band range and career level for the role. Aligns with SAP S/4HANA HCM grade definitions.',
    `pay_rate_type` STRING COMMENT 'Indicates the unit basis for the base_pay_rate field: annual salary, hourly rate, monthly rate, or weekly rate. Determines how payroll calculations are performed in ADP Workforce Now.. Valid values are `annual|hourly|monthly|weekly`',
    `plan_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this compensation plan within ADP Workforce Now and downstream HR/payroll systems. Used for cross-system reconciliation.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `plan_description` STRING COMMENT 'Free-text narrative describing the compensation plans purpose, eligibility criteria, special provisions, and any unique terms applicable to specific roles such as broker draw arrangements or resident manager housing benefits.',
    `plan_name` STRING COMMENT 'Human-readable name of the compensation plan (e.g., Broker Commission-Only Plan, Property Manager Base + Bonus, Leasing Agent Draw-Against-Commission).',
    `plan_type` STRING COMMENT 'Classification of the compensation structure. Salary for salaried employees, hourly for hourly workers, commission_only for brokers/leasing agents on pure commission, draw_against_commission for brokers receiving advances against future commissions, base_plus_commission for hybrid roles, base_plus_bonus for property managers with performance bonuses, hybrid for multi-component plans. [ENUM-REF-CANDIDATE: salary|hourly|commission_only|draw_against_commission|base_plus_commission|base_plus_bonus|hybrid — promote to reference product]',
    `salary_range_max` DECIMAL(18,2) COMMENT 'The maximum base pay rate defined for this compensation plans grade band. Caps the base pay for the associated job profile and grade, used for budget control and compensation governance.',
    `salary_range_midpoint` DECIMAL(18,2) COMMENT 'The midpoint of the salary range for this compensation plans grade band. Used as the market reference point for compa-ratio calculations and compensation equity analysis.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'The minimum base pay rate defined for this compensation plans grade band. Used for pay equity analysis, offer management, and compensation benchmarking against market data.',
    `source_system_code` STRING COMMENT 'Identifies the originating system of record for this compensation plan record. ADP for ADP Workforce Now, SAP for SAP S/4HANA HCM, MANUAL for records entered directly into the lakehouse.. Valid values are `ADP|SAP|MANUAL`',
    `source_system_plan_code` STRING COMMENT 'The native identifier of this compensation plan in the originating source system (e.g., ADP Workforce Now plan ID). Used for cross-system reconciliation and data lineage tracing.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this compensation plan record was last modified. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver layer.',
    `version_number` STRING COMMENT 'Sequential version number of this compensation plan record. Incremented each time the plan is revised and re-approved. Supports plan history tracking and audit compliance.',
    `workforce_segment` STRING COMMENT 'The business segment or functional area for which this compensation plan is designed. Drives plan applicability rules and reporting segmentation across the real estate enterprise. [ENUM-REF-CANDIDATE: brokerage|property_management|asset_management|development|corporate|leasing|facility_operations — promote to reference product]',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Compensation structures and pay plans assigned to employees across the real estate enterprise. Captures compensation plan type (salary, hourly, commission-based, draw-against-commission for brokers/leasing agents, hybrid), base pay rate, pay frequency, commission rate schedule reference, bonus target percentage, effective date, expiration date, approval status, and the job profile and grade band it applies to. Brokers and leasing agents may have commission-only or draw-against-commission plans. Property managers may have base plus performance bonus. Sourced from ADP Workforce Now Compensation module.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`benefit` (
    `benefit_id` BIGINT COMMENT 'Primary key for benefit',
    `employee_id` BIGINT COMMENT 'Reference to the employee enrolled in or associated with this benefit plan record. Links to the workforce employee master.',
    `aca_offer_of_coverage_code` STRING COMMENT 'IRS-defined code (1A–1I) reported on Form 1095-C Line 14 indicating the type of health coverage offered to the employee and their dependents for each month of the plan year. Required for ACA employer shared responsibility reporting.. Valid values are `^1[A-Z]$`',
    `aca_safe_harbor_code` STRING COMMENT 'IRS-defined code (2A–2I) reported on Form 1095-C Line 16 indicating the applicable safe harbor or relief provision used by the employer for ACA employer shared responsibility penalty avoidance.. Valid values are `^2[A-I]$`',
    `annual_deductible_amount` DECIMAL(18,2) COMMENT 'Annual out-of-pocket deductible amount the employee must satisfy before the plan begins paying covered expenses. Applicable to medical, dental, and vision plans. Used in employee benefits communications and plan comparison analytics.',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier, financial institution, or third-party administrator (TPA) providing the benefit plan (e.g., Aetna, Delta Dental, Fidelity Investments, WageWorks). Used for carrier billing reconciliation and employee communications.',
    `carrier_plan_code` STRING COMMENT 'Carrier-assigned plan identifier used for EDI 834 benefit enrollment transactions and carrier billing reconciliation. Distinct from the internal plan_code.',
    `cobra_election_deadline` DATE COMMENT 'Deadline by which the employee or qualified beneficiary must elect COBRA continuation coverage (60 days from the later of coverage loss date or COBRA notice date). Used for COBRA administration compliance tracking.',
    `cobra_eligible_indicator` BOOLEAN COMMENT 'Indicates whether the employee or dependent is eligible for COBRA continuation coverage following a qualifying event (e.g., termination, reduction in hours). Drives COBRA notice generation and administration.',
    `coverage_tier` STRING COMMENT 'Coverage tier elected by the employee, defining who is covered under the plan. Drives premium contribution amounts and dependent eligibility. Standard tiers: employee only, employee + spouse, employee + child(ren), employee + family.. Valid values are `employee_only|employee_spouse|employee_child|employee_family`',
    `dependent_count` STRING COMMENT 'Number of dependents enrolled under the employees benefit plan election. Used for coverage tier validation, carrier eligibility feeds, and ACA 1095-C Part III reporting.',
    `dependent_coverage_indicator` BOOLEAN COMMENT 'Indicates whether the employee has elected dependent coverage under this benefit plan. True when one or more dependents are enrolled. Drives ACA 1095-C Part III dependent reporting requirements.',
    `disability_benefit_pct` DECIMAL(18,2) COMMENT 'Percentage of the employees base salary replaced by the disability benefit plan (short-term or long-term disability). Applicable when plan_type = disability. Used in total compensation reporting and workforce planning.',
    `effective_end_date` DATE COMMENT 'Date on which the employees coverage under this benefit plan ends. Null for currently active enrollments. Triggers COBRA notification requirements upon termination of coverage.',
    `effective_start_date` DATE COMMENT 'Date on which the employees coverage under this benefit plan becomes effective. Used for payroll deduction start, carrier eligibility feeds, and ACA minimum essential coverage determination.',
    `eligibility_criteria` STRING COMMENT 'Textual description of the eligibility rules for this benefit plan, including minimum hours worked, employment classification (full-time, part-time), waiting period, and applicable employee groups (e.g., property managers, brokers, corporate staff).',
    `employee_hsa_contribution` DECIMAL(18,2) COMMENT 'Annual employee contribution amount elected for a Health Savings Account (HSA). Applicable only when plan_type = HSA. Subject to IRS annual contribution limits. Used for payroll deduction and W-2 Box 12 reporting.',
    `employee_premium_amount` DECIMAL(18,2) COMMENT 'Per-pay-period premium amount deducted from the employees paycheck for this benefit plan. Used for payroll deduction configuration and benefits cost allocation reporting.',
    `employer_hsa_contribution` DECIMAL(18,2) COMMENT 'Annual employer seed contribution to the employees Health Savings Account (HSA). Applicable only when plan_type = HSA. Reported on W-2 Box 12 Code W.',
    `employer_match_formula` STRING COMMENT 'Textual description of the employers 401(k) matching contribution formula (e.g., 100% match on first 3% of compensation, 50% match on next 2%). Applicable when plan_type = 401k. Used in employee communications and total compensation reporting.',
    `employer_match_max_pct` DECIMAL(18,2) COMMENT 'Maximum percentage of eligible compensation the employer will match under the 401(k) plan. Used for benefits cost modeling, OPEX budgeting, and total compensation analytics.',
    `employer_premium_amount` DECIMAL(18,2) COMMENT 'Per-pay-period premium amount contributed by the employer for this benefit plan. Used for benefits cost allocation to property management, development, and corporate cost centers (OPEX tracking).',
    `enrollment_event_type` STRING COMMENT 'The triggering event that initiated this benefit enrollment or change. Determines the enrollment window and permissible elections under IRS and ERISA rules.. Valid values are `new_hire|open_enrollment|qualifying_life_event|COBRA|rehire`',
    `enrollment_status` STRING COMMENT 'Current status of the employees enrollment in this benefit plan. Enrolled indicates active coverage; waived indicates the employee declined coverage; COBRA_elected indicates post-termination continuation coverage.. Valid values are `enrolled|waived|pending|terminated|COBRA_elected`',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit enrollment record was first created in ADP Workforce Now. Serves as the audit trail anchor for the enrollment lifecycle and supports SOX financial controls over payroll deductions.',
    `fsa_contribution_amount` DECIMAL(18,2) COMMENT 'Annual employee contribution amount elected for a Flexible Spending Account (FSA). Applicable when plan_type = FSA. Subject to IRS annual contribution limits and use-it-or-lose-it rules.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the benefit enrollment record in ADP Workforce Now. Used for change data capture (CDC) in the Databricks Silver layer ingestion pipeline and audit trail maintenance.',
    `life_coverage_amount` DECIMAL(18,2) COMMENT 'Face value of life insurance coverage elected by the employee. Applicable when plan_type = life. Amounts exceeding $50,000 of employer-paid coverage are subject to imputed income under IRS Section 79.',
    `out_of_pocket_max_amount` DECIMAL(18,2) COMMENT 'Maximum annual out-of-pocket cost the employee is responsible for under the plan, after which the plan covers 100% of covered expenses. ACA-mandated limit for qualified health plans.',
    `plan_code` STRING COMMENT 'Externally-known alphanumeric code assigned to the benefit plan by the carrier or the enterprise HR system (ADP Workforce Now). Used as the business identifier for plan lookup and cross-system reconciliation.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `plan_name` STRING COMMENT 'Human-readable name of the benefit plan as presented to employees (e.g., Aetna PPO Gold, Delta Dental Premier, Fidelity 401(k) Plan). Used in employee-facing communications and ACA reporting.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the benefit plan offering. Active plans are available for enrollment; terminated plans are closed to new elections; suspended plans are temporarily unavailable.. Valid values are `active|inactive|pending|terminated|suspended`',
    `plan_type` STRING COMMENT 'Category of benefit plan. Drives eligibility rules, tax treatment, and ACA compliance logic. [ENUM-REF-CANDIDATE: medical|dental|vision|life|disability|401k|HSA|FSA|commuter|EAP — promote to reference product]',
    `plan_year` STRING COMMENT 'Calendar or fiscal year for which this benefit plan is offered (e.g., 2024). Used to segment plan configurations, premium rates, and enrollment windows by year for ACA 1095-C reporting and cost allocation.',
    `plan_year_end_date` DATE COMMENT 'Last day of the benefit plan year. Defines when current coverage terms, premium rates, and contribution limits expire. Used for COBRA administration and ACA reporting period boundaries.',
    `plan_year_start_date` DATE COMMENT 'First day of the benefit plan year. Defines the effective start of coverage terms, premium rates, deductibles, and contribution limits for the plan year.',
    `premium_frequency` STRING COMMENT 'Frequency at which premium contributions are deducted from payroll or billed to the employer. Must align with the payroll cycle configured in ADP Workforce Now.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `retirement_employee_contribution_pct` DECIMAL(18,2) COMMENT 'Employees elected contribution rate as a percentage of eligible compensation for the 401(k) or retirement plan. Applicable when plan_type = 401k. Used for payroll deduction calculation and IRS annual limit compliance.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Total per-pay-period premium for this benefit plan (employee + employer contributions combined). Used for carrier billing reconciliation and total benefits cost reporting.',
    `vesting_cliff_months` STRING COMMENT 'Number of months of service required before employer contributions begin to vest under a cliff or graded vesting schedule. Applicable when vesting_schedule_type is cliff or graded.',
    `vesting_full_months` STRING COMMENT 'Total months of service required for the employee to become 100% vested in employer contributions. Used for workforce retention analytics and ERISA compliance reporting.',
    `vesting_schedule_type` STRING COMMENT 'Type of vesting schedule applied to employer contributions in the retirement plan. Immediate vesting grants full ownership at once; cliff vesting grants full ownership after a defined period; graded vesting grants incremental ownership over time.. Valid values are `immediate|cliff|graded|none`',
    `waiting_period_days` STRING COMMENT 'Number of days from the employees hire date or qualifying event before coverage under this benefit plan becomes effective. ACA limits waiting periods to 90 days for employer-sponsored health plans.',
    `waiver_indicator` BOOLEAN COMMENT 'Indicates whether the employee has affirmatively waived coverage under this benefit plan. True when the employee declined enrollment. Required for ACA 1095-C Line 16 reporting to document offer and waiver.',
    CONSTRAINT pk_benefit PRIMARY KEY(`benefit_id`)
) COMMENT 'Catalog of employee benefit plans offered by the real estate enterprise and employee enrollment/election records for each plan year. Plan data captures plan name, type (medical, dental, vision, life, disability, 401k, HSA, FSA, commuter, EAP), carrier, plan year, coverage tiers, premium contributions, deductibles, 401k match formula, vesting schedule, and eligibility criteria. Enrollment data captures employee reference, enrollment event type (new hire, open enrollment, qualifying life event), coverage tier elected, contribution amounts, dependent coverage, effective dates, waiver indicator, and enrollment status. Sourced from ADP Workforce Now Benefits Administration module. Supports ACA compliance reporting (1095-C), benefits cost allocation, and COBRA administration for terminated employees.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique surrogate identifier for each benefit enrollment record in the Silver Layer lakehouse. Primary key for the benefit_enrollment data product.',
    `benefit_id` BIGINT COMMENT 'Reference to the benefit plan in which the employee is enrolling or waiving. Links to the benefit plan master record (e.g., medical, dental, vision, 401k, FSA, HSA, life insurance).',
    `cost_center_id` BIGINT COMMENT 'Reference to the finance cost center to which the employers benefit contribution cost for this enrollment is allocated. Enables benefits OPEX allocation across real estate business units such as property management, development, brokerage, and corporate functions. Links to the finance cost center master.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who elected or waived this benefit plan. Links to the workforce employee master record sourced from ADP Workforce Now.',
    `aca_offer_type_code` STRING COMMENT 'The IRS-defined code indicating the type of health coverage offered to the employee for ACA Form 1095-C Line 14 reporting (e.g., 1A through 1I). Identifies whether minimum essential coverage was offered to the employee only, employee and dependents, or not offered. Required for ACA employer shared responsibility compliance for real estate employers with 50+ full-time equivalent employees.',
    `aca_safe_harbor_code` STRING COMMENT 'The IRS-defined code for ACA Form 1095-C Line 16 indicating the applicable safe harbor or relief provision (e.g., 2A through 2I). Used to indicate months the employee was not employed, was in a waiting period, or the employer qualifies for an affordability safe harbor. Required for ACA employer shared responsibility reporting.',
    `annual_employee_cost` DECIMAL(18,2) COMMENT 'The annualized employee premium cost for this benefit enrollment, calculated as the per-period employee contribution multiplied by the number of pay periods in the plan year. Used for ACA affordability testing (employee cost must not exceed a percentage of household income) and total compensation reporting.',
    `annual_employer_cost` DECIMAL(18,2) COMMENT 'The annualized employer contribution toward this benefit enrollment for the plan year. Used for OPEX budgeting, benefits cost allocation across real estate business units, and FASB ASC 715 disclosure.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the benefit enrollment was approved by HR or the benefits administrator. Null if the enrollment is pending approval or was auto-approved. Supports audit trail requirements and enrollment processing SLA tracking.',
    `carrier_member_number` STRING COMMENT 'The unique member identification number assigned by the insurance carrier or benefit plan provider to the enrolled employee. Used for claims processing, eligibility verification, and carrier EDI 834 enrollment file reconciliation. Distinct from the internal ADP employee ID.',
    `cobra_election_deadline` DATE COMMENT 'The deadline by which the qualified beneficiary must elect COBRA continuation coverage following a qualifying event. Typically 60 days from the later of the qualifying event date or the date the COBRA election notice was provided. Null if cobra_eligible is False or no qualifying event has occurred.',
    `cobra_eligible` BOOLEAN COMMENT 'Indicates whether this enrollment is eligible for COBRA continuation coverage upon a qualifying event (e.g., employment termination, reduction in hours). True for group health plans subject to COBRA; False for plans exempt from COBRA (e.g., dental-only, vision-only under certain thresholds, or employers with fewer than 20 employees).',
    `contribution_frequency` STRING COMMENT 'The pay period frequency at which employee and employer contributions are applied for this enrollment. Determines how per-period amounts are annualized for ACA affordability testing and benefits cost reporting.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `coverage_tier` STRING COMMENT 'The coverage tier elected by the employee, defining who is covered under the benefit plan. Employee Only covers the employee alone; Employee + Spouse adds a spouse or domestic partner; Employee + Children adds dependent children; Employee + Family covers all eligible dependents. Drives premium contribution calculations and ACA affordability testing.. Valid values are `employee_only|employee_spouse|employee_children|employee_family`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this benefit enrollment record was first created in the system. Serves as the record audit creation timestamp for data lineage, Silver Layer ingestion tracking, and SOX audit trail requirements.',
    `dependent_count` STRING COMMENT 'The number of dependents (spouse, domestic partner, children) covered under this enrollment. Used to validate coverage tier elections, calculate per-dependent costs, and support ACA dependent coverage reporting for children up to age 26.',
    `effective_date` DATE COMMENT 'The date on which the benefit coverage becomes active for the employee under this enrollment. Determines when premium deductions begin and when claims can be submitted. Critical for ACA minimum essential coverage (MEC) determination and 1095-C line 14/15/16 reporting.',
    `election_timestamp` TIMESTAMP COMMENT 'The date and time when the employee submitted their benefit election or waiver. Serves as the principal business event timestamp for this enrollment transaction. Used for audit trails, late enrollment identification, and compliance with enrollment window deadlines.',
    `eligibility_start_date` DATE COMMENT 'The date on which the employee first became eligible to enroll in this benefit plan, typically based on hire date plus any applicable waiting period (e.g., 30, 60, or 90 days). Used to validate enrollment timeliness and ACA waiting period compliance (maximum 90-day waiting period rule).',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'The per-pay-period pre-tax or post-tax dollar amount deducted from the employees paycheck for this benefit plan enrollment. Used for payroll deduction processing, benefits cost allocation across real estate cost centers (property management, development, corporate), and W-2 Box 12 reporting.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The per-pay-period dollar amount contributed by the employer toward this benefit plan enrollment. Used for benefits cost allocation to property management, development, and corporate OPEX budgets, and for FASB ASC 715 post-employment benefit accounting.',
    `employment_type` STRING COMMENT 'The employment classification of the employee at the time of enrollment. Determines benefit eligibility rules; full-time employees (30+ hours per week) are subject to ACA employer mandate; part-time employees may have limited benefit eligibility. Relevant for real estate roles including property managers, leasing agents, brokers, and construction staff.. Valid values are `full_time|part_time|temporary|contractor`',
    `enrollment_event_type` STRING COMMENT 'The triggering event that initiated this benefit enrollment or change. New hire enrollments occur within the initial eligibility window; open enrollment occurs during the annual election period; qualifying life events (QLE) include marriage, birth, divorce, or loss of other coverage; rehire triggers a new enrollment window; COBRA enrollments apply to terminated employees electing continuation coverage.. Valid values are `new_hire|open_enrollment|qualifying_life_event|rehire|cobra`',
    `enrollment_number` STRING COMMENT 'Externally-known unique enrollment reference number assigned by ADP Workforce Now Benefits Administration. Used for cross-system reconciliation, ACA 1095-C reporting, and COBRA administration correspondence.',
    `enrollment_source` STRING COMMENT 'The channel or method through which the benefit enrollment was submitted. Self-service indicates the employee enrolled via the ADP employee self-service portal; hr_admin indicates HR staff entered the election on behalf of the employee; paper_form indicates a physical enrollment form was submitted; api_integration indicates enrollment was received via system integration; auto_enrolled indicates the employee was automatically enrolled per plan rules.. Valid values are `self_service|hr_admin|paper_form|api_integration|auto_enrolled`',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the benefit enrollment record. Active indicates coverage is in force; pending indicates awaiting approval or effective date; terminated indicates coverage has ended; waived indicates employee declined coverage; suspended indicates temporary hold; cancelled indicates enrollment was voided before taking effect.. Valid values are `active|pending|terminated|waived|suspended|cancelled`',
    `fsa_election_amount` DECIMAL(18,2) COMMENT 'The annual dollar amount the employee elected to contribute to a Flexible Spending Account (FSA) for the plan year. Subject to IRS annual FSA contribution limits. Null for non-FSA plan types. Used for payroll deduction scheduling and IRS Section 125 cafeteria plan compliance.',
    `group_number` STRING COMMENT 'The insurance carriers group policy number associated with the employers benefit plan. Used for carrier billing reconciliation, claims adjudication, and EDI 834 enrollment file submissions. Typically the same for all employees enrolled in the same plan.',
    `has_dependent_coverage` BOOLEAN COMMENT 'Indicates whether one or more dependents are covered under this benefit enrollment. True when dependent_count is greater than zero. Used for ACA minimum essential coverage (MEC) reporting and dependent eligibility audits.',
    `hsa_contribution_amount` DECIMAL(18,2) COMMENT 'The per-period employer contribution to the employees Health Savings Account (HSA), applicable when the employee is enrolled in a High Deductible Health Plan (HDHP). Null for non-HSA-eligible plans. Subject to IRS annual HSA contribution limits. Used for payroll processing and W-2 Box 12 Code W reporting.',
    `life_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The face value of group term life insurance coverage elected by the employee. Applicable only for life insurance plan types. Amounts exceeding IRS imputed income threshold (currently $50,000) require W-2 Box 12 Code C reporting for the taxable portion of employer-provided group term life insurance.',
    `notes` STRING COMMENT 'Free-text notes entered by HR administrators regarding this benefit enrollment. May include documentation of special circumstances, late enrollment justifications, carrier exception approvals, or COBRA administration notes. Not used for structured reporting.',
    `open_enrollment_period` STRING COMMENT 'The identifier or label for the open enrollment period during which this election was made (e.g., OE-2024, OE-2025). Null for new hire and qualifying life event enrollments. Used to group elections by enrollment campaign and track open enrollment completion rates across the real estate workforce.',
    `plan_year` STRING COMMENT 'The calendar or fiscal plan year (e.g., 2024) for which this enrollment is effective. Used to segment enrollments by annual benefit cycle and support ACA compliance reporting (1095-C) by tax year.',
    `qualifying_event_date` DATE COMMENT 'The date on which the qualifying life event (QLE) occurred that triggered a mid-year enrollment change outside of open enrollment. Examples include marriage, birth of a child, adoption, divorce, or loss of other coverage. Null for new hire and open enrollment event types. Required for HIPAA special enrollment and IRS Section 125 cafeteria plan compliance.',
    `qualifying_event_type` STRING COMMENT 'The type of qualifying life event that triggered a mid-year enrollment change. Marriage includes domestic partnership; birth_adoption covers new dependents; divorce includes legal separation; loss_of_coverage covers involuntary loss of other group coverage; death_of_dependent removes a covered dependent. Null for new hire and open enrollment event types.. Valid values are `marriage|birth_adoption|divorce|loss_of_coverage|death_of_dependent|other`',
    `termination_date` DATE COMMENT 'The date on which the benefit coverage ends for this enrollment. Populated upon employment termination, voluntary cancellation, or plan year end. Null indicates coverage is currently active. Used to determine COBRA qualifying event dates and continuation coverage election windows.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this benefit enrollment record was last modified. Tracks changes to enrollment elections, contribution amounts, coverage tiers, or status updates. Used for incremental data pipeline processing and SOX audit trail compliance.',
    `waiting_period_days` STRING COMMENT 'The number of days from the employees hire date (or rehire date) before they become eligible to enroll in this benefit plan. Must not exceed 90 days for group health plans under ACA. Used to calculate eligibility_start_date and validate ACA waiting period compliance.',
    `waiver_indicator` BOOLEAN COMMENT 'Indicates whether the employee affirmatively declined (waived) coverage under this benefit plan for the plan year. True means the employee opted out; False means the employee enrolled. Required for ACA 1095-C Line 14 reporting to distinguish employees who were offered but declined minimum essential coverage.',
    `waiver_reason` STRING COMMENT 'The stated reason the employee declined coverage under this benefit plan. Other coverage indicates the employee has coverage through another source (e.g., spouses employer plan); cost indicates the premium was unaffordable; ineligible indicates the employee does not meet plan eligibility criteria. Null when waiver_indicator is False.. Valid values are `other_coverage|spouse_coverage|cost|ineligible|voluntary_decline|other`',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Employee elections and enrollments in benefit plans for each plan year. Captures employee reference, benefit plan reference, enrollment event type (new hire, open enrollment, qualifying life event), coverage tier elected, employee contribution amount, employer contribution amount, dependent coverage details, enrollment effective date, termination date, waiver indicator (employee declined coverage), and enrollment status. Sourced from ADP Workforce Now Benefits Administration. Supports ACA compliance reporting (1095-C), benefits cost allocation, and COBRA administration for terminated real estate employees.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique system-generated identifier for each individual time and attendance record submitted by a real estate employee. Primary key for the time_entry data product.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Property management labor hours must be allocated to specific assets for CAM reconciliation, operating expense reporting, and job costing. Linking time_entry to asset is required for accurate property',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Labor cost allocation in real estate property management and maintenance requires mapping time entries to validated GL accounts for job costing, CAM recovery calculations, and NOI reporting. gl_accoun',
    `cost_center_id` BIGINT COMMENT 'Reference to the finance cost center to which this time entrys labor cost is allocated. Supports CAPEX/OPEX segregation and departmental cost reporting.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: GAAP requires capitalization of internal labor costs to development projects. Time entries must be linked to dev_project for CAPEX vs OPEX labor classification, construction budget actual cost trackin',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Labor cost allocation by geographic market is a real estate operational need for property-level P&L and market-level labor cost reporting. Enables geographic labor cost analysis beyond property_code, ',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: Property management and asset management staff log time against specific assets for labor cost allocation to NOI calculations and CAPEX budgets. Linking time_entry to portfolio_asset enables asset-lev',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Time entries capture the job_title as a STRING field, which is a denormalized reference to the position being worked. Adding position_id to time_entry normalizes this reference to the authoritative po',
    `employee_id` BIGINT COMMENT 'Reference to the employee who submitted this time entry. Links to the workforce employee master record sourced from ADP Workforce Now.',
    `work_assignment_id` BIGINT COMMENT 'Foreign key linking to workforce.work_assignment. Business justification: Time entries are submitted by employees working on specific property assignments, development projects, or asset management roles. Adding work_assignment_id to time_entry links each time record to the',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Technician time entries linked to work orders enable actual labor cost calculation, SLA compliance verification, and payroll cost allocation to maintenance activities — a core real estate facilities m',
    `adp_time_entry_number` STRING COMMENT 'Externally-known unique identifier assigned by ADP Workforce Now to this time entry record. Used for cross-system reconciliation between the lakehouse and the source payroll system.',
    `amendment_reason` STRING COMMENT 'Free-text description of the reason for amending or correcting this time entry after initial submission. Required when is_amended is True to maintain a complete audit trail for payroll and SOX compliance.',
    `approval_status` STRING COMMENT 'Current workflow state of the time entry in the approval lifecycle. Drives payroll processing eligibility; only APPROVED entries are included in payroll runs.. Valid values are `SUBMITTED|APPROVED|REJECTED|PENDING|RECALLED`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time at which the approving manager approved or rejected this time entry. Provides a complete audit trail for payroll authorization and SOX compliance.',
    `break_duration_minutes` STRING COMMENT 'Total duration of unpaid break time in minutes deducted from the employees clocked hours during this work period. Required for accurate net hours calculation and compliance with labor regulations.',
    `clock_in_time` TIMESTAMP COMMENT 'The date and timestamp at which the employee clocked in or started their work period. Used to calculate total hours worked and validate shift compliance.',
    `clock_out_time` TIMESTAMP COMMENT 'The date and timestamp at which the employee clocked out or ended their work period. Combined with clock-in time to derive total hours worked.',
    `cost_allocation_type` STRING COMMENT 'Indicates whether the labor hours in this time entry are allocated as Capital Expenditure (CAPEX) for development/construction projects or Operating Expenditure (OPEX) for ongoing property management and maintenance. Critical for financial reporting and asset capitalization under FASB ASC 840/842.. Valid values are `CAPEX|OPEX`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this time entry record was first created in the system. Supports data lineage, audit trail, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the labor cost amount recorded in this time entry (e.g., USD). Supports multi-currency portfolio reporting for international real estate operations.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Code identifying the organizational department to which the employee belongs at the time of the entry (e.g., Property Management, Development, Brokerage, Corporate Finance). Supports departmental labor cost reporting.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of hours worked at double-time pay rate, applicable for work performed on holidays or beyond extended overtime thresholds per applicable labor agreements. Distinct from standard overtime hours.',
    `entry_method` STRING COMMENT 'The method by which this time entry was recorded in ADP Workforce Now (e.g., manual entry by employee, physical clock-in/out terminal, mobile app, timesheet batch, or imported from a third-party system such as Procore).. Valid values are `MANUAL|CLOCK_IN_OUT|MOBILE|TIMESHEET|IMPORTED`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'The employees hourly pay rate applicable at the time of this entry, used to calculate the labor cost value of the time entry for CAPEX/OPEX allocation and project cost reporting. Classified as confidential business-sensitive compensation data.',
    `is_amended` BOOLEAN COMMENT 'Indicates whether this time entry has been amended or corrected after initial submission. True if the entry was modified post-submission; False for original unmodified entries. Supports audit trail and payroll correction tracking.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'The gross labor cost in USD for this time entry, calculated as total hours multiplied by the applicable pay rate including any overtime premium. Used for project cost tracking, CAPEX/OPEX allocation, and NOI (Net Operating Income) analysis.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the employee or manager providing additional context for this time entry, such as special work conditions, task descriptions, or explanations for unusual hours.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked beyond the standard threshold (typically 8 hours/day or 40 hours/week) during this time entry period. Triggers premium pay rates per FLSA regulations.',
    `pay_code` STRING COMMENT 'Classification code indicating the type of pay associated with this time entry. Drives payroll calculation rules, benefit accrual, and labor cost categorization. [ENUM-REF-CANDIDATE: REGULAR|OVERTIME|PTO|SICK|HOLIDAY|BEREAVEMENT|JURY_DUTY|TRAINING|UNPAID_LEAVE — promote to reference product]. Valid values are `REGULAR|OVERTIME|PTO|SICK|HOLIDAY|BEREAVEMENT`',
    `pay_period_end_date` DATE COMMENT 'The last date of the payroll period to which this time entry belongs. Defines the boundary for payroll batch inclusion and period-close accruals.',
    `pay_period_start_date` DATE COMMENT 'The first date of the payroll period to which this time entry belongs. Used to group time entries for payroll batch processing and period-end financial reporting.',
    `payroll_batch_code` STRING COMMENT 'Identifier of the payroll processing batch in ADP Workforce Now into which this approved time entry was included. Enables traceability from individual time entries to payroll run outputs and GL postings.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Total number of regular (non-overtime) hours worked by the employee during this time entry period. Used for standard payroll calculation and labor cost allocation.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approving manager when rejecting a time entry. Populated only when approval_status is REJECTED. Supports employee feedback and payroll dispute resolution.',
    `shift_type` STRING COMMENT 'Classification of the work shift associated with this time entry. Relevant for maintenance technicians, security staff, and construction workers who may work non-standard shifts at real estate properties.. Valid values are `DAY|EVENING|NIGHT|WEEKEND|ON_CALL`',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time at which the employee submitted this time entry for approval. Used to assess timeliness of submission relative to payroll deadlines and to support audit trails.',
    `total_hours` DECIMAL(18,2) COMMENT 'Total hours recorded for this time entry, inclusive of regular, overtime, and any leave hours. Represents the gross time claimed for payroll and cost allocation purposes.',
    `union_code` STRING COMMENT 'Code identifying the labor union or collective bargaining agreement applicable to the employee for this time entry. Relevant for construction workers and building trades staff; drives union-specific pay rules and reporting obligations.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this time entry record was most recently modified. Tracks amendments, corrections, and re-submissions for audit and change management purposes.',
    `work_date` DATE COMMENT 'The calendar date on which the employee performed the work recorded in this time entry. Principal business event date for payroll period alignment and project cost allocation.',
    `work_location_code` STRING COMMENT 'Code identifying the physical work location where the employee performed the work (e.g., a specific property address, construction site, or corporate office). Supports geographic labor cost allocation and site-level reporting.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Individual time and attendance records submitted by real estate employees for each work period. Captures employee reference, work date, clock-in time, clock-out time, total hours worked, overtime hours, pay code (regular, overtime, PTO, sick, holiday, jury duty, bereavement), project or property cost allocation code, approval status (submitted, approved, rejected), approving manager, and submission timestamp. Applicable to hourly field staff, maintenance technicians, construction workers, and any salaried employees tracking project time for CAPEX/OPEX allocation. Sourced from ADP Workforce Now Time and Attendance module.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique system-generated identifier for each employee leave of absence request record in the workforce management system.',
    `asset_id` BIGINT COMMENT 'Reference to the property or portfolio asset to which the employee is primarily assigned at the time of the leave request. Enables property-level workforce availability analysis and operational impact assessment for property management and leasing operations.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which the employees leave-related costs (pay continuation, benefits, temporary replacement) are charged. Supports leave liability accrual and financial reporting in SAP S/4HANA and Yardi Voyager GL.',
    `position_id` BIGINT COMMENT 'Reference to the employees job position at the time of the leave request. Used to identify the role requiring coverage (e.g., property manager, leasing agent, construction superintendent) and to plan temporary staffing or workload redistribution.',
    `employee_id` BIGINT COMMENT 'Reference to the employee submitting the leave request. Links to the employee master record in ADP Workforce Now.',
    `accommodation_notes` STRING COMMENT 'Free-text notes documenting any workplace accommodations arranged in connection with the leave, such as modified duties upon return, reduced schedule, or assistive equipment. Relevant for ADA interactive process documentation. Classified as confidential due to health-related content.',
    `actual_return_date` DATE COMMENT 'The date the employee actually returned to active employment following the leave. May differ from approved_end_date due to early return, medical clearance delays, or leave extensions. Critical for FMLA compliance and payroll reinstatement.',
    `adp_leave_case_number` STRING COMMENT 'The source system case number assigned by ADP Workforce Now to this leave request. Used for data lineage, reconciliation between the Silver Layer and ADP, and audit trail purposes.',
    `approved_days` STRING COMMENT 'Total number of calendar days approved by HR for the leave of absence, calculated from approved_start_date to approved_end_date inclusive. Used for FMLA entitlement balance tracking (maximum 84 days / 12 weeks per rolling year) and leave liability accrual.',
    `approved_end_date` DATE COMMENT 'The HR-approved last calendar date of the leave of absence. Used alongside approved_start_date to calculate approved leave duration for payroll, benefits continuation, and FMLA entitlement tracking.',
    `approved_start_date` DATE COMMENT 'The HR-approved first calendar date of the leave of absence, which may differ from the requested start date. Used for payroll processing, leave liability accrual, and workforce scheduling.',
    `benefits_continuation` BOOLEAN COMMENT 'Indicates whether the employees group health benefits are being maintained by the employer during the leave period. Under FMLA, employers must maintain group health coverage on the same terms as if the employee had continued working.',
    `coverage_arrangement` STRING COMMENT 'Describes how the employees responsibilities will be covered during the leave period: temp_hire = temporary employee engaged; internal_reassignment = duties redistributed to existing staff; overtime = existing staff work additional hours; no_coverage = role left vacant; deferred = work deferred until return. Supports workforce planning for property management and brokerage operations.. Valid values are `temp_hire|internal_reassignment|overtime|no_coverage|deferred`',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when the leave request record was first created in the data platform (Silver Layer). Distinct from submitted_timestamp which reflects the business event time.',
    `decision_date` DATE COMMENT 'The date on which HR formally approved or denied the leave request. Used to measure HR response time and ensure FMLA designation notice is provided within the required 5-business-day window (29 CFR §825.300).',
    `denial_reason` STRING COMMENT 'Narrative explanation provided by HR for denying the leave request. Populated only when leave_status = denied. Required for documentation of adverse employment actions and potential legal review under FMLA or ADA.',
    `employee_premium_owed` DECIMAL(18,2) COMMENT 'Dollar amount of employee-share health insurance premiums that the employee owes during the unpaid leave period. Tracked for potential recovery if the employee fails to return from FMLA leave (29 CFR §825.213). Expressed in USD.',
    `fmla_designated` BOOLEAN COMMENT 'Indicates whether HR has formally designated this leave as FMLA-qualifying following review of the leave reason and medical certification. Distinct from fmla_eligible — an employee may be eligible but the leave may not qualify for FMLA designation.',
    `fmla_eligible` BOOLEAN COMMENT 'Indicates whether the employee meets FMLA eligibility criteria at the time of the request: employed for at least 12 months, worked 1,250 hours in the prior 12 months, and works at a location with 50+ employees within 75 miles. Drives FMLA designation and compliance tracking.',
    `fmla_hours_used` DECIMAL(18,2) COMMENT 'Cumulative FMLA-protected hours consumed by this leave request against the employees 480-hour (12-week) annual FMLA entitlement. Tracked in hours to support intermittent leave scenarios where partial days are taken.',
    `hr_notes` STRING COMMENT 'Internal HR narrative notes documenting case management activities, communications with the employee, escalations, or special circumstances related to the leave request. Classified as confidential due to potential inclusion of sensitive employment information.',
    `intermittent_frequency` STRING COMMENT 'Expected frequency of intermittent leave episodes as certified by the healthcare provider. Applicable only when intermittent_leave is True. Used for workforce scheduling and absence pattern monitoring.. Valid values are `daily|weekly|monthly|as_needed`',
    `intermittent_leave` BOOLEAN COMMENT 'Indicates whether the leave is taken intermittently (in separate blocks of time or by reducing the normal weekly or daily work schedule) rather than as a single continuous period. Intermittent FMLA leave requires separate scheduling and tracking in ADP Workforce Now.',
    `leave_reason` STRING COMMENT 'Narrative description of the reason for the leave request as provided by the employee. May include medical condition references, family circumstances, or personal reasons. Classified as confidential due to sensitivity of health and personal information.',
    `leave_reason_code` STRING COMMENT 'Standardized categorical code classifying the reason for leave per FMLA and HR policy definitions. Used for compliance reporting and workforce analytics. [ENUM-REF-CANDIDATE: serious_health_condition|birth_adoption|family_care|military_service|personal|sabbatical|other — promote to reference product]',
    `leave_status` STRING COMMENT 'Current workflow state of the leave request throughout its lifecycle: requested = submitted pending review; approved = HR/manager approved; denied = request rejected; in_progress = employee currently on leave; returned = employee has returned to work; cancelled = request withdrawn by employee or voided by HR.. Valid values are `requested|approved|denied|in_progress|returned|cancelled`',
    `leave_type` STRING COMMENT 'Classification of the leave of absence by regulatory or policy category. FMLA = Family and Medical Leave Act protected leave; parental = birth/adoption/foster care bonding; medical = non-FMLA health-related; military = USERRA-protected military service; personal = discretionary personal leave; sabbatical = extended professional development leave. Drives eligibility rules, pay continuation, and compliance reporting.. Valid values are `FMLA|parental|medical|military|personal|sabbatical`',
    `leave_year_type` STRING COMMENT 'The method used to calculate the 12-month period for FMLA entitlement tracking: calendar_year = January–December; rolling_12_month = 12 months measured backward from the date leave is used; fixed_leave_year = any fixed 12-month period (e.g., fiscal year); rolling_forward = 12-month period starting on the first date FMLA leave is taken.. Valid values are `calendar_year|rolling_12_month|fixed_leave_year|rolling_forward`',
    `medical_certification_date` DATE COMMENT 'Date on which the completed medical certification form was received by HR. Used to verify compliance with the 15-calendar-day submission deadline and to trigger FMLA designation notice.',
    `medical_certification_received` BOOLEAN COMMENT 'Indicates whether the required medical certification has been received from the employees healthcare provider. Employees have 15 calendar days to provide certification (29 CFR §825.305). Tracks compliance with certification deadlines.',
    `medical_certification_required` BOOLEAN COMMENT 'Indicates whether HR has determined that a medical certification (WH-380-E or WH-380-F form) is required to support this leave request. Required for FMLA-qualifying serious health conditions.',
    `paid_leave` BOOLEAN COMMENT 'Indicates whether the approved leave period is fully or partially paid under company policy, state law, or short-term disability benefits. Drives payroll processing and leave liability accrual calculations.',
    `pay_continuation_type` STRING COMMENT 'Specifies the compensation arrangement during the leave period: full_pay = 100% salary continuation; partial_pay = reduced pay per policy; unpaid = no compensation; std_benefit = short-term disability benefit payments; pto_substitution = employee elects to use accrued PTO/sick time to receive pay during FMLA leave.. Valid values are `full_pay|partial_pay|unpaid|std_benefit|pto_substitution`',
    `request_number` STRING COMMENT 'Externally visible, human-readable business identifier for the leave request, used in correspondence with employees, HR, and payroll teams (e.g., LR-2024-000123). Sourced from ADP Workforce Now.. Valid values are `^LR-[0-9]{4}-[0-9]{6}$`',
    `requested_days` STRING COMMENT 'Total number of calendar days requested by the employee for the leave of absence, calculated from requested_start_date to requested_end_date inclusive. Used for initial workforce planning and FMLA entitlement assessment.',
    `requested_end_date` DATE COMMENT 'The employee-requested last calendar date of the leave of absence. Combined with requested_start_date to determine the requested leave duration for planning purposes.',
    `requested_start_date` DATE COMMENT 'The employee-requested first calendar date of the leave of absence. Used for workforce availability planning and scheduling coverage for property management, leasing, and construction roles.',
    `return_to_work_clearance` BOOLEAN COMMENT 'Indicates whether the employee has provided a fitness-for-duty certification or medical clearance from their healthcare provider prior to returning from leave. Required for certain FMLA leave types per company policy and 29 CFR §825.312.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the employee formally submitted the leave request in ADP Workforce Now. Serves as the principal business event timestamp for the transaction and is used to measure HR response time and FMLA notice compliance (29 CFR §825.302).',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when the leave request record was most recently modified in the data platform, capturing status changes, date amendments, or accommodation note updates.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Employee leave of absence requests and approved leave records. Captures employee reference, leave type (FMLA, personal leave, military leave, parental leave, medical leave, sabbatical), requested start date, requested end date, approved start date, approved end date, leave reason, FMLA eligibility indicator, intermittent leave indicator, leave status (requested, approved, denied, in-progress, returned, cancelled), HR approver, return-to-work date, and accommodation notes. Sourced from ADP Workforce Now. Supports FMLA compliance tracking, workforce availability planning, and leave liability accrual for real estate operations.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`license_certification` (
    `license_certification_id` BIGINT COMMENT 'Unique surrogate identifier for each professional license or certification record held by a real estate workforce member. Primary key for the license_certification data product in the workforce domain.',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the licensed broker under whose sponsorship a salesperson or associate broker license is held, as required by most state real estate commissions. A salesperson license is only active when affiliated with a sponsoring broker. Null for independent broker licenses, appraiser credentials, and non-brokerage certifications.',
    `employee_id` BIGINT COMMENT 'Reference to the workforce member (property manager, broker, appraiser, leasing agent, construction staff, or corporate employee) who holds this license or certification. Links to the employee master record sourced from ADP Workforce Now.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Real estate licenses are jurisdiction-specific. Linking to geographic_hierarchy enables geographic license coverage reporting — critical for ensuring licensed staff coverage across all operating marke',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Real estate broker and appraiser licenses are governed by specific regulatory frameworks (state RE commission rules, USPAP). Linking enables compliance tracking against specific mandates, automated re',
    `adp_credential_record_code` STRING COMMENT 'The unique identifier assigned to this license or certification record within ADP Workforce Nows talent management module. Used for system-of-record traceability, data lineage, and reconciliation between the lakehouse silver layer and the ADP source system.',
    `alert_days_before_expiry` STRING COMMENT 'Number of calendar days before the expiration_date at which automated renewal alert notifications should be triggered for this credential. Configurable per credential type and jurisdiction (e.g., 90 days for broker licenses, 60 days for appraiser credentials). Drives the proactive license expiry alert workflow.',
    `ce_cycle_start_date` DATE COMMENT 'The start date of the current CE reporting cycle for this credential. CE hours completed are counted from this date through the renewal deadline. Enables accurate tracking of CE progress within the applicable compliance window.',
    `ce_hours_completed` DECIMAL(18,2) COMMENT 'Number of Continuing Education (CE) hours the employee has completed in the current renewal cycle to date. Compared against ce_hours_required to determine compliance progress and identify employees at risk of credential lapse. Sourced from ADP Workforce Now training records and issuing authority portals.',
    `ce_hours_required` DECIMAL(18,2) COMMENT 'Total number of Continuing Education (CE) hours mandated by the issuing authority for the current renewal cycle. Varies by credential type and jurisdiction (e.g., 45 CE hours per 2-year cycle for California real estate broker, 28 hours for Certified General Appraiser per USPAP cycle). Supports compliance gap analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this license or certification record was first created in the system. Provides the audit trail creation marker for data governance, lineage tracking, and SOX compliance. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credential_name` STRING COMMENT 'Human-readable full name of the license or certification (e.g., Certified General Appraiser License, LEED Accredited Professional — Building Design and Construction, Certified Property Manager (CPM), CCIM Designation). Provides the identity label for the credential record.',
    `credential_number` STRING COMMENT 'The official license or certification number assigned by the issuing authority (e.g., state real estate commission license number, appraiser credential number, LEED AP certificate number). This is the externally-known business identifier used for regulatory verification and compliance audits.',
    `credential_status` STRING COMMENT 'Current lifecycle status of the license or certification. active indicates the credential is valid and in good standing; pending indicates initial application or renewal in progress; expired indicates the credential has passed its expiration date without renewal; suspended indicates temporary regulatory action; lapsed indicates the credential was not renewed within the grace period; revoked indicates permanent cancellation by the issuing authority. Drives proactive expiry alerts and compliance dashboards.. Valid values are `active|pending|expired|suspended|lapsed|revoked`',
    `credential_type` STRING COMMENT 'Classification of the professional license or certification held. Indicates the category of credential such as real estate broker license, salesperson license, appraiser license, or professional designation. [ENUM-REF-CANDIDATE: real_estate_broker_license|salesperson_license|appraiser_certified_residential|appraiser_certified_general|appraiser_licensed_residential|MAI_designation|LEED_AP|BREEAM_assessor|CPM|CCIM|RPA|FMA|PMP|OSHA_30|contractor_license — promote to reference product]',
    `document_reference` STRING COMMENT 'Reference identifier or URL pointing to the scanned copy or digital document of the license or certification certificate stored in the document management system (e.g., DocuSign CLM or SharePoint). Enables auditors and compliance officers to retrieve the original credential document for verification.',
    `expiration_date` DATE COMMENT 'The date on which the license or certification expires and is no longer valid without renewal. This is the primary date used for proactive expiry alert generation, renewal deadline scheduling, and multi-state compliance audit reporting. Aligns with MASTER_AGREEMENT EFFECTIVE_UNTIL category.',
    `is_company_sponsored` BOOLEAN COMMENT 'Indicates whether the company is sponsoring this credential (True) — covering renewal fees, CE costs, and administrative support — or whether the employee maintains it independently (False). Drives reimbursement eligibility, OPEX cost allocation, and workforce benefit reporting.',
    `is_primary_credential` BOOLEAN COMMENT 'Indicates whether this is the employees primary professional credential required for their current role (True) or a supplementary/secondary credential (False). Used to prioritize renewal alerts and compliance monitoring — lapse of a primary credential may prevent the employee from legally performing their core job function.',
    `issue_date` DATE COMMENT 'The date on which the license or certification was originally issued by the issuing authority. Represents the effective start date of the credentials validity period. Used to calculate credential tenure and verify compliance with minimum holding period requirements.',
    `issuing_authority` STRING COMMENT 'Name of the regulatory body, professional association, or government agency that issued the license or certification (e.g., California Department of Real Estate, Appraisal Institute, U.S. Green Building Council, IREM, CCIM Institute, Project Management Institute). Required for multi-state compliance audits and regulatory verification.',
    `jurisdiction_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country in which the license or certification is valid. Supports international portfolio operations and cross-border compliance tracking (e.g., BREEAM assessors operating in GBR, LEED AP credentials valid globally).. Valid values are `^[A-Z]{3}$`',
    `jurisdiction_state` STRING COMMENT 'Two-letter US state code (ISO 3166-2:US) or equivalent sub-national jurisdiction code where the license or certification is valid and enforceable. Critical for multi-state compliance tracking — brokers and appraisers must hold active credentials in each state where they practice.. Valid values are `^[A-Z]{2}$`',
    `last_verified_date` DATE COMMENT 'The most recent date on which the credential was independently verified against the issuing authoritys public registry or license lookup system (e.g., state real estate commission license search, Appraisal Subcommittee National Registry). Supports ongoing compliance assurance and audit trail requirements.',
    `notes` STRING COMMENT 'Free-text field for compliance officers or HR administrators to record additional context about the credential, such as disciplinary actions, conditions attached to the license, reciprocity arrangements between states, or special endorsements. Supports nuanced compliance case management.',
    `primary_practice_area` STRING COMMENT 'The primary real estate practice area for which this credential is used (e.g., commercial brokerage, residential sales, appraisal, property management, development). Supports workforce planning, role-to-credential alignment analysis, and ensures brokers and appraisers are credentialed for their assigned practice areas. [ENUM-REF-CANDIDATE: commercial|residential|industrial|mixed_use|land|appraisal|property_management|development|investment — 9 candidates stripped; promote to reference product]',
    `regulatory_body_confirmation` STRING COMMENT 'Confirmation reference number, transaction ID, or acknowledgment code provided by the regulatory body or issuing authority upon receipt or approval of the renewal application. Serves as audit evidence for compliance reporting and SOX controls.',
    `renewal_application_date` DATE COMMENT 'The date on which the renewal application was submitted to the issuing authority. Used to confirm timely filing, calculate processing time, and provide audit evidence of compliance with renewal deadlines.',
    `renewal_cycle_months` STRING COMMENT 'The standard renewal cycle duration in months as defined by the issuing authority for this credential type (e.g., 24 months for most state real estate broker licenses, 36 months for Certified General Appraiser). Used to project future renewal dates and plan CE hour completion schedules.',
    `renewal_deadline` DATE COMMENT 'The last date by which a renewal application must be submitted to the issuing authority to avoid lapse or suspension of the credential. May differ from expiration_date where a grace period or advance filing window applies. Used to trigger automated renewal workflow alerts.',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'The monetary fee paid to the issuing authority for the credential renewal, in the applicable currency. Used for workforce cost tracking, OPEX budgeting, and reimbursement processing through Accounts Payable. Supports analysis of total credential maintenance costs across the workforce.',
    `renewal_fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the renewal fee amount (e.g., USD, GBP, CAD). Required for international portfolio operations where credentials are maintained in multiple currencies.. Valid values are `^[A-Z]{3}$`',
    `renewal_status` STRING COMMENT 'Current status of the active renewal process for this credential. pending indicates renewal is due but not yet initiated; submitted indicates the renewal application has been filed with the issuing authority; approved indicates the renewal has been granted; lapsed indicates the renewal was not completed before the deadline; suspended indicates the issuing authority has placed a hold on the renewal. Distinct from credential_status which reflects the overall credential lifecycle.. Valid values are `pending|submitted|approved|lapsed|suspended`',
    `renewed_credential_number` STRING COMMENT 'The new license or certification number assigned by the issuing authority upon successful renewal, if the number changes from the prior cycle. Some jurisdictions issue a new credential number with each renewal cycle. Null if the credential number remains unchanged upon renewal.',
    `renewed_expiration_date` DATE COMMENT 'The new expiration date assigned to the credential following a successful renewal. Populated once the issuing authority approves the renewal and issues the updated credential. Used to update the active expiration_date for the next compliance cycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this license or certification record was most recently modified. Tracks the last update event for data currency monitoring, change detection in ETL pipelines, and audit trail completeness. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `verified_by` STRING COMMENT 'Name or identifier of the compliance officer, HR administrator, or automated system that performed the most recent credential verification. Provides accountability and audit trail for the verification process.',
    CONSTRAINT pk_license_certification PRIMARY KEY(`license_certification_id`)
) COMMENT 'Professional licenses and certifications held by real estate workforce members, including renewal lifecycle tracking. Credential data captures employee reference, credential type (real estate broker license, salesperson license, appraiser license — Certified Residential, Certified General, Licensed Residential, MAI, LEED AP, BREEAM assessor, CPM, CCIM, RPA, FMA, PMP, OSHA 30, contractor license), issuing authority, license number, issue date, expiration date, jurisdiction (state/country), and CE hours required vs completed. Renewal data captures renewal cycle dates, renewal deadline, CE hours progress, application submission date, renewal fee, renewed license number, new expiration date, renewal status (pending, submitted, approved, lapsed, suspended), and regulatory body confirmation. Supports proactive license expiry alerts, multi-state compliance audits, and ensures brokers, appraisers, and property managers maintain active credentials required by state commissions, NAR, and the Appraisal Institute.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`license_renewal` (
    `license_renewal_id` BIGINT COMMENT 'Unique surrogate identifier for each license renewal transaction record in the workforce license renewal tracking system. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Real estate broker license renewal costs must be allocated to cost centers for property management expense tracking and CAM recovery analysis. cost_center_code is a denormalized string; this FK enable',
    `employee_id` BIGINT COMMENT 'Reference to the workforce employee whose professional license or certification is being renewed. Links to the employee master record in ADP Workforce Now.',
    `license_certification_id` BIGINT COMMENT 'Reference to the professional license or certification record being renewed, as tracked in the workforce license master (e.g., broker license, appraiser credential, property manager license).',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: License renewals are driven by specific regulatory frameworks (state RE commission renewal cycles, CE hour mandates). Replaces denormalized regulatory_body text; enables automated compliance deadline ',
    `adp_renewal_reference` STRING COMMENT 'Externally-known renewal transaction identifier assigned by ADP Workforce Now for this renewal cycle. Used for cross-system reconciliation and audit trail with the system of record.',
    `alert_acknowledged` BOOLEAN COMMENT 'Indicates whether the employee has acknowledged receipt of the renewal expiry alert notification. Used to track employee awareness and escalate unacknowledged alerts.',
    `alert_sent_date` DATE COMMENT 'The date on which the proactive license expiry alert notification was sent to the employee and their manager. Supports compliance monitoring workflows and ensures timely renewal action.',
    `application_submission_date` DATE COMMENT 'The date on which the renewal application was formally submitted to the regulatory body. Used to confirm timely filing and calculate days-to-deadline metrics for compliance reporting.',
    `background_check_cleared` BOOLEAN COMMENT 'Indicates whether the required background check was completed and cleared for this renewal cycle. Null if background_check_required is False. Blocking condition for renewal approval.',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether the regulatory body requires a background check as part of this renewal cycle. Some jurisdictions mandate periodic background checks for broker and appraiser license renewals.',
    `ce_ethics_hours_completed` DECIMAL(18,2) COMMENT 'Number of CE ethics hours completed by the employee within the current renewal cycle. Tracked separately to ensure compliance with mandatory ethics training requirements.',
    `ce_ethics_hours_required` DECIMAL(18,2) COMMENT 'Number of CE hours specifically required in ethics coursework as mandated by the regulatory body (e.g., NAR Code of Ethics training). Subset of total CE hours required.',
    `ce_hours_completed` DECIMAL(18,2) COMMENT 'Total number of Continuing Education (CE) credit hours accumulated by the employee to date within the current renewal cycle. Compared against ce_hours_required to assess compliance readiness.',
    `ce_hours_required` DECIMAL(18,2) COMMENT 'Total number of Continuing Education (CE) credit hours mandated by the regulatory body for this renewal cycle. Varies by license type, jurisdiction, and renewal period length.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this license renewal record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for record origination.',
    `current_license_number` STRING COMMENT 'The active license or certification number issued by the regulatory body for the current (pre-renewal) license period. Used to reference the existing credential during the renewal process.',
    `docusign_envelope_code` STRING COMMENT 'Reference identifier for the DocuSign CLM envelope associated with the renewal application or employer sponsorship authorization documents. Enables traceability to the contract lifecycle management system.',
    `employer_sponsored` BOOLEAN COMMENT 'Indicates whether the renewal fee and associated CE costs are sponsored (paid) by the employer organization. True if the company covers the renewal cost; False if the employee bears the cost personally.',
    `issuing_state_code` STRING COMMENT 'Two-letter US state code of the jurisdiction that issued and governs the license being renewed (e.g., CA, NY, TX). Determines applicable state commission rules and CE requirements.. Valid values are `^[A-Z]{2}$`',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Additional penalty fee charged by the regulatory body when the renewal application is submitted after the standard deadline but within the late-filing grace period. Zero if filed on time.',
    `license_type` STRING COMMENT 'Classification of the professional license or certification being renewed. Determines applicable regulatory body, CE (Continuing Education) requirements, and renewal cycle rules. [ENUM-REF-CANDIDATE: broker|salesperson|appraiser|property_manager|mortgage_originator|contractor|notary|inspector — promote to reference product]. Valid values are `broker|salesperson|appraiser|property_manager|mortgage_originator|contractor`',
    `new_expiration_date` DATE COMMENT 'The expiration date of the license as renewed and confirmed by the regulatory body. Populated upon approval of the renewal application. Drives the next renewal cycle start date.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, exceptions, regulatory correspondence details, or special circumstances related to this license renewal cycle (e.g., waiver granted, name change on license, address update).',
    `prior_expiration_date` DATE COMMENT 'The expiration date of the license in the immediately preceding renewal cycle. Used to validate continuity of licensure and detect any gaps in active credential status.',
    `regulatory_confirmation_date` DATE COMMENT 'The date on which the regulatory body confirmed approval of the renewal and issued the renewed license. Marks the official completion of the renewal lifecycle.',
    `regulatory_confirmation_reference` STRING COMMENT 'The confirmation number, transaction reference, or case number provided by the regulatory body upon approval of the renewal application. Used for audit trail and compliance verification.',
    `reinstatement_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the regulatory body for reinstating a lapsed or suspended license. Applicable only when reinstatement_required is True. Tracked separately from the standard renewal fee.',
    `reinstatement_required` BOOLEAN COMMENT 'Indicates whether the license lapsed and requires a formal reinstatement process rather than a standard renewal. True when the renewal deadline was missed and the license entered lapsed or suspended status.',
    `renewal_cycle_start_date` DATE COMMENT 'The date on which the current renewal cycle officially begins, typically aligned with the expiration of the prior license period. Marks the opening of the CE (Continuing Education) accumulation window.',
    `renewal_deadline` DATE COMMENT 'The regulatory deadline by which the renewal application must be submitted and approved to avoid license lapse or suspension. Critical for proactive expiry alerts and compliance monitoring.',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'The total monetary amount paid to the regulatory body for the license renewal application. Expressed in USD. Used for OPEX (Operating Expenditure) tracking and workforce compliance cost reporting.',
    `renewal_fee_paid_date` DATE COMMENT 'The date on which the renewal fee was remitted to the regulatory body. Used for accounts payable reconciliation and compliance audit documentation.',
    `renewal_fee_payment_method` STRING COMMENT 'The method used to remit the renewal fee to the regulatory body (e.g., check, ACH transfer, credit card via online portal). Supports AP (Accounts Payable) reconciliation.. Valid values are `check|ach|credit_card|online_portal|money_order`',
    `renewal_method` STRING COMMENT 'The channel or method through which the renewal application was submitted to the regulatory body (e.g., online portal, paper form, in-person at commission office, via third-party agent).. Valid values are `online|paper|in_person|third_party_agent`',
    `renewal_status` STRING COMMENT 'Current lifecycle state of the license renewal process. Pending: renewal cycle initiated but application not yet submitted. Submitted: application filed with regulatory body. Approved: renewed license confirmed active. Lapsed: renewal deadline passed without approval. Suspended: license suspended by regulatory authority during renewal.. Valid values are `pending|submitted|approved|lapsed|suspended`',
    `renewed_license_number` STRING COMMENT 'The new license or certification number issued by the regulatory body upon successful renewal. May differ from the current license number depending on the issuing jurisdictions practices. Populated once renewal is approved.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this license renewal record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking and data lineage in the Databricks Silver Layer.',
    CONSTRAINT pk_license_renewal PRIMARY KEY(`license_renewal_id`)
) COMMENT 'Transactional records tracking the renewal lifecycle of professional licenses and certifications for real estate workforce members. Captures license/certification reference, renewal cycle start date, renewal deadline, CE hours required for renewal, CE hours completed to date, renewal application submission date, renewal fee paid amount, renewed license number, new expiration date, renewal status (pending, submitted, approved, lapsed, suspended), and regulatory body confirmation reference. Supports proactive license expiry alerts, compliance audits, and ensures brokers, appraisers, and property managers maintain active credentials required by NAR, state commissions, and the Appraisal Institute.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`workforce_training` (
    `workforce_training_id` BIGINT COMMENT 'Primary key for training',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Real estate CE training is mandated by specific regulatory frameworks (state RE commission rules, USPAP). Replaces denormalized regulatory_framework text; enables compliance training catalog managemen',
    `accrediting_body` STRING COMMENT 'Name of the professional organization or regulatory body that accredits or approves the CE credit hours for this course (e.g., National Association of Realtors, Appraisal Institute, IVSC, OSHA, HUD). Null for non-accredited internal courses.',
    `applicable_role_group` STRING COMMENT 'Comma-separated list or descriptive text identifying the employee role groups for which this course is applicable or required (e.g., Brokers, Leasing Agents, All Employees, Property Managers, Asset Managers, Construction Staff). Supports targeted assignment and compliance tracking.',
    `ce_credit_hours` DECIMAL(18,2) COMMENT 'Number of Continuing Education (CE) credit hours awarded upon successful completion of the course. Applicable to courses that count toward broker, appraiser, or property manager license renewal requirements. Null if the course does not carry CE credit.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a completion certificate is issued to employees upon successful completion of this course (True). Certificates are required for license renewal submissions to state boards and professional associations.',
    `cost_per_seat` DECIMAL(18,2) COMMENT 'Direct cost charged per employee enrollment in this course, expressed in the companys operating currency (USD). Used for training budget planning, OPEX allocation, and cost-per-employee reporting. Sourced from vendor contracts or ADP LMS catalog pricing.',
    `course_category` STRING COMMENT 'High-level classification of the course purpose. Drives compliance tracking and reporting: compliance_mandatory (Fair Housing, SOX, anti-harassment), ce_license_renewal (Continuing Education for broker/appraiser/PM license renewal), leadership_development, technical_skills, safety_osha, dei (Diversity Equity Inclusion), onboarding. [ENUM-REF-CANDIDATE: compliance_mandatory|ce_license_renewal|leadership_development|technical_skills|safety_osha|dei|onboarding — 7 candidates stripped; promote to reference product]',
    `course_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the course within the LMS catalog (e.g., FH-101, OSHA-GEN-01, CE-BROKER-RE). Used for cross-system reference and reporting. Sourced from ADP Workforce Now LMS.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `course_subcategory` STRING COMMENT 'Secondary classification providing finer-grained grouping within a category (e.g., Fair Housing, Anti-Harassment, Fire Safety, Lease Accounting ASC 842, Broker Ethics, Appraiser USPAP). Supports detailed compliance reporting and curriculum management.',
    `course_title` STRING COMMENT 'Full descriptive title of the training course as displayed to employees in the LMS catalog (e.g., Fair Housing Act Compliance, OSHA 10-Hour General Industry Safety, Broker Continuing Education: Ethics and Standards).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the course record was first created in the workforce training catalog (Silver Layer). Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports data lineage and audit trail requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost_per_seat amount (e.g., USD). Supports multi-currency operations for international real estate portfolios.. Valid values are `^[A-Z]{3}$`',
    `delivery_format` STRING COMMENT 'Method by which the course is delivered to employees. Determines scheduling, resource requirements, and LMS tracking approach. Values: online_self_paced, instructor_led_virtual, instructor_led_in_person, blended, webinar, on_the_job.. Valid values are `online_self_paced|instructor_led_virtual|instructor_led_in_person|blended|webinar|on_the_job`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total instructional time for the course expressed in decimal hours (e.g., 1.5, 8.0, 40.0). Used for workforce planning, scheduling, and CE credit hour validation. Sourced from ADP Workforce Now LMS course catalog.',
    `effective_date` DATE COMMENT 'Date from which this course version became available for enrollment in the LMS catalog. Used to determine which version of a compliance course was active at the time of an employees enrollment.',
    `esg_relevant_flag` BOOLEAN COMMENT 'Indicates whether this course contributes to the companys Environmental, Social, and Governance (ESG) reporting objectives (True), such as DEI training, LEED/BREEAM sustainability education, or ESG compliance courses. Supports ESG workforce development metrics.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the course is currently active and available for enrollment in the LMS catalog (True) or has been retired/deactivated (False). Retired courses remain in the catalog for historical completion record reference.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this course is mandatory for one or more employee populations (True) or elective/optional (False). Mandatory courses include Fair Housing Act, OSHA safety, SOX controls, and anti-harassment training. Drives compliance completion rate reporting.',
    `language_code` STRING COMMENT 'IETF BCP 47 language code indicating the primary language in which the course is delivered (e.g., en, es, en-US, es-MX). Supports multilingual workforce compliance tracking across diverse real estate operations.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the course record in the catalog. Used for incremental data pipeline processing and audit trail compliance. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `license_type_applicability` STRING COMMENT 'Type of professional license for which CE credit hours from this course are applicable (e.g., Real Estate Broker, Real Estate Salesperson, Certified Appraiser, Property Manager License). Null if the course does not carry CE credit toward a license. Supports license renewal tracking.',
    `lms_course_code` STRING COMMENT 'Native course identifier assigned by ADP Workforce Now LMS / Talent Management module. Used for system-of-record reconciliation and data lineage tracing back to the source system.',
    `max_attempts_allowed` STRING COMMENT 'Maximum number of times an employee may attempt the course assessment before being marked as failed and requiring re-enrollment. Null indicates unlimited attempts. Sourced from ADP Workforce Now LMS course configuration.',
    `max_enrollment_capacity` STRING COMMENT 'Maximum number of employees that can be enrolled in a single session or offering of this course. Applicable primarily to instructor-led formats. Null for self-paced online courses with no capacity constraint.',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum assessment score (as a percentage, 0–100) required to achieve a passing status and earn CE credit hours or a completion certificate. Null for courses with no formal assessment (e.g., attendance-based completions).',
    `prerequisite_course_codes` STRING COMMENT 'Comma-separated list of course_code values that must be completed before an employee can enroll in this course (e.g., OSHA-GEN-01, FH-101). Null if no prerequisites are required. Supports curriculum sequencing and enrollment validation.',
    `provider_name` STRING COMMENT 'Name of the organization or vendor delivering the course content (e.g., ADP Learning, NAR Education, McKissock Learning, Kaplan Real Estate Education, internal training department). Supports vendor management and cost tracking.',
    `provider_type` STRING COMMENT 'Classification of the training provider: internal (delivered by company staff), external_vendor (third-party training company), accredited_institution (university or professional school), regulatory_body (government or licensing authority).. Valid values are `internal|external_vendor|accredited_institution|regulatory_body`',
    `renewal_period_months` STRING COMMENT 'Number of months after completion before the course must be retaken to maintain compliance or license standing (e.g., 12 for annual OSHA refresher, 24 for Fair Housing). Null for one-time courses with no renewal requirement.',
    `retirement_date` DATE COMMENT 'Date on which the course was or is scheduled to be retired from the active LMS catalog. Null if the course has no planned retirement. Supports catalog lifecycle management and ensures employees are not enrolled in outdated compliance content.',
    `version_number` STRING COMMENT 'Version identifier for the course content (e.g., 1.0, 2.1, 3.0). Tracks content revisions to ensure employees complete the most current version, particularly important for regulatory compliance courses updated due to law changes.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_workforce_training PRIMARY KEY(`workforce_training_id`)
) COMMENT 'Catalog of training and professional development courses available to real estate workforce members, along with employee enrollment and completion records. Course data captures course code, title, category (compliance/mandatory, CE for license renewal, leadership development, technical skills, safety/OSHA, DEI, onboarding), delivery format, duration hours, CE credit hours, accrediting body, provider, cost per seat, and active status. Enrollment data captures employee reference, enrollment date, completion date, completion status (enrolled, in-progress, completed, failed, withdrawn, no-show), assessment score, CE hours earned, and certificate reference. Includes mandatory compliance training (Fair Housing Act, OSHA, SOX, anti-harassment) and elective professional development. Sourced from ADP Workforce Now Talent Management / LMS module. Supports compliance training completion rate reporting and CE hour tracking toward license renewals for brokers, appraisers, and property managers.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`training_enrollment` (
    `training_enrollment_id` BIGINT COMMENT 'Unique surrogate identifier for each training enrollment record in the workforce training management system. Primary key for the training_enrollment data product.',
    `employee_id` BIGINT COMMENT 'Reference to the employee enrolled in the training course. Links to the employee master record in the workforce domain.',
    `license_certification_id` BIGINT COMMENT 'Foreign key linking to workforce.license_certification. Business justification: Training enrollments in the real estate industry are frequently undertaken to fulfill continuing education (CE) requirements for broker licenses, appraiser credentials, and other professional certific',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: CE training enrollment is tracked against specific regulatory frameworks for license renewal compliance. Enables direct regulatory compliance reporting on training completion — e.g., which enrollments',
    `training_session_id` BIGINT COMMENT 'Reference to the specific scheduled session or class instance of the course that the employee is enrolled in.',
    `workforce_training_id` BIGINT COMMENT 'Reference to the training course catalog record defining the course content, type, and CE credit hours.',
    `accreditation_body` STRING COMMENT 'The professional or regulatory body that accredits the training course for CE credit purposes (e.g., National Association of Realtors, Appraisal Institute, USGBC for LEED, OSHA). Determines CE credit applicability for license renewals.',
    `adp_enrollment_number` STRING COMMENT 'Source system enrollment identifier from ADP Workforce Now Talent Management module. Used for reconciliation and audit traceability back to the system of record.',
    `approval_date` DATE COMMENT 'The date on which the training enrollment was formally approved by the manager or HR. Used for workflow tracking and cost authorization audit trails.',
    `approved_by` STRING COMMENT 'The name or identifier of the manager or HR representative who approved the training enrollment, particularly for cost-bearing or external training programs. Supports approval workflow audit trails.',
    `assessment_score` DECIMAL(18,2) COMMENT 'The numeric score achieved by the employee on the course assessment or examination, expressed as a percentage (0.00–100.00). Used to determine pass/fail status and competency validation.',
    `attempts_count` STRING COMMENT 'The number of times the employee has attempted the course assessment. Used to enforce maximum attempt policies and identify employees requiring additional support.',
    `ce_hours_available` DECIMAL(18,2) COMMENT 'The maximum number of Continuing Education (CE) credit hours available for this course upon successful completion. Used for pre-enrollment planning and license renewal gap analysis.',
    `ce_hours_earned` DECIMAL(18,2) COMMENT 'The number of Continuing Education (CE) credit hours earned by the employee upon successful completion of the training course. Applied toward license renewal requirements for brokers, appraisers, and property managers. Null if course not yet completed or failed.',
    `certificate_reference` STRING COMMENT 'The identifier or document reference number for the certificate of completion issued upon successful course completion. Used for license renewal submissions to state real estate commissions and professional bodies.',
    `completion_date` DATE COMMENT 'The date on which the employee successfully completed the training course. Null if the course has not yet been completed. Used for CE hour credit posting and license renewal tracking.',
    `compliance_category` STRING COMMENT 'The regulatory or compliance category to which this training enrollment belongs. Used to track mandatory compliance training completion rates. [ENUM-REF-CANDIDATE: fair-housing|osha-safety|anti-harassment|sox-compliance|license-renewal|professional-development|onboarding|data-privacy|esg|other — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the training enrollment record was first created in the system. Provides the audit trail creation marker per SOX and GDPR data governance requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the training cost amount (e.g., USD). Supports multi-currency reporting for international real estate operations.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'The modality through which the training course is delivered. Determines scheduling logistics, attendance tracking approach, and CE credit eligibility. [ENUM-REF-CANDIDATE: in-person|virtual-live|e-learning|blended|on-the-job|webinar|self-study|conference — promote to reference product if additional values are needed]. Valid values are `in-person|virtual-live|e-learning|blended|on-the-job|webinar`',
    `department_cost_charged` STRING COMMENT 'The cost center or department code to which the training cost is charged for internal financial allocation. Aligns with the General Ledger (GL) cost center structure for OPEX reporting.',
    `due_date` DATE COMMENT 'The mandatory deadline by which the employee must complete the training course. Critical for compliance training (Fair Housing, OSHA, anti-harassment, SOX) where overdue status triggers escalation.',
    `enrollment_date` DATE COMMENT 'The date on which the employee was formally enrolled or registered for the training course. Represents the business event timestamp of enrollment initiation.',
    `enrollment_source` STRING COMMENT 'Indicates how the enrollment was initiated: manager-assigned (by direct supervisor), self-enrolled (employee-initiated), hr-assigned (by HR department), system-auto (automatically triggered by role or compliance rule), or compliance-required (mandated by regulatory obligation).. Valid values are `manager-assigned|self-enrolled|hr-assigned|system-auto|compliance-required`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the training enrollment. Tracks progression from initial enrollment through completion or exit. Values: enrolled (registered, not yet started), in-progress (actively attending), completed (successfully finished), failed (did not meet passing criteria), withdrawn (voluntarily removed before completion), no-show (did not attend without prior withdrawal).. Valid values are `enrolled|in-progress|completed|failed|withdrawn|no-show`',
    `enrollment_type` STRING COMMENT 'Classification of whether the training enrollment is mandatory (required by policy or regulation), elective (employee-initiated), recommended (manager-suggested), or regulatory (required by an external governing body such as OSHA, HUD, or SEC).. Valid values are `mandatory|elective|recommended|regulatory`',
    `instructor_name` STRING COMMENT 'The name of the instructor or facilitator delivering the training session. Used for quality tracking, feedback attribution, and scheduling coordination.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this training enrollment is mandatory for the employee based on their role, license requirements, or regulatory obligations. True = mandatory; False = optional or elective. Drives compliance reporting and escalation workflows.',
    `is_overdue` BOOLEAN COMMENT 'Indicates whether the training enrollment has passed its due date without completion. True = overdue; False = on track or completed. Drives compliance escalation workflows and manager notifications for mandatory training.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the training enrollment record was most recently modified. Supports change tracking, data lineage, and audit compliance in the Databricks Silver Layer.',
    `license_type_applicable` STRING COMMENT 'The professional license type for which CE hours from this training are applicable (e.g., Real Estate Broker, Real Estate Salesperson, Certified Appraiser, Property Manager License). Enables targeted CE tracking per license category.',
    `max_attempts_allowed` STRING COMMENT 'The maximum number of assessment attempts permitted for this course enrollment before the enrollment is marked as failed. Enforces course policy and compliance standards.',
    `notes` STRING COMMENT 'Free-text field for additional context, special accommodations, or remarks related to the training enrollment (e.g., accommodation requests, rescheduling notes, compliance exception documentation).',
    `passing_score` DECIMAL(18,2) COMMENT 'The minimum assessment score required to pass the course and receive credit, expressed as a percentage. Enables automated pass/fail determination and CE credit eligibility validation.',
    `scheduled_session_date` DATE COMMENT 'The planned calendar date on which the training session is scheduled to take place. Used for workforce scheduling, attendance planning, and compliance deadline tracking.',
    `time_spent_hours` DECIMAL(18,2) COMMENT 'The actual number of hours the employee spent engaged with the training course content, as tracked by the learning management system. Used for CE credit verification and workforce productivity analysis.',
    `training_cost_amount` DECIMAL(18,2) COMMENT 'The total cost charged to the department for this training enrollment, including registration fees, materials, and any associated expenses. Used for OPEX (Operating Expenditure) tracking and training budget management.',
    `training_provider` STRING COMMENT 'The name of the external or internal organization providing the training course (e.g., NAR, Appraisal Institute, USGBC, internal L&D team). Used for vendor management and CE credit accreditation tracking.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the employee has been granted a waiver or exemption from completing this training enrollment. True = waiver granted; False = no waiver. Waivers must be documented for compliance audit purposes.',
    `waiver_reason` STRING COMMENT 'The documented reason for granting a training waiver or exemption (e.g., prior equivalent certification, medical accommodation, role change). Required for compliance audit trail when waiver_flag is True.',
    `withdrawal_date` DATE COMMENT 'The date on which the employee was withdrawn from the training enrollment. Populated only when enrollment_status is withdrawn or no-show. Used for compliance gap analysis.',
    CONSTRAINT pk_training_enrollment PRIMARY KEY(`training_enrollment_id`)
) COMMENT 'Employee enrollments and completion records for training courses. Captures employee reference, training course reference, enrollment date, scheduled session date, completion date, completion status (enrolled, in-progress, completed, failed, withdrawn, no-show), assessment score, CE hours earned, certificate of completion reference, and cost charged to department. Tracks mandatory compliance training completion rates (Fair Housing, OSHA, anti-harassment, SOX) and CE hours earned toward license renewals for brokers, appraisers, and property managers. Sourced from ADP Workforce Now Talent Management module.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique system-generated identifier for each formal employee performance evaluation record. Primary key for the performance_review data product.',
    `compensation_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.compensation_plan. Business justification: Performance reviews drive compensation decisions including merit increases and bonus recommendations. Linking performance_review to compensation_plan via compensation_plan_id establishes the formal co',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Performance reviews evaluate employees against competency frameworks defined in job profiles. Adding job_profile_id to performance_review links the evaluation to the standardized job definition and co',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, or property-level team) to which the employee belonged at the time of the review. Supports workforce analytics by business function.',
    `position_id` BIGINT COMMENT 'Reference to the position or job role held by the employee at the time of the review. Captures the role context (e.g., Property Manager, Asset Manager, Broker, Leasing Agent) for benchmarking and succession planning.',
    `employee_id` BIGINT COMMENT 'Reference to the employee being evaluated in this performance review. Links to the employee master record in the workforce domain.',
    `tertiary_performance_hr_business_partner_employee_id` BIGINT COMMENT 'Reference to the HR Business Partner who approved and finalized this performance review. Required for compliance with talent governance and compensation decision workflows.',
    `adp_review_code` STRING COMMENT 'The native performance review identifier assigned by ADP Workforce Now Talent Management. Used for system-of-record traceability and reconciliation with the source HR platform.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when the HR Business Partner formally approved and finalized this performance review record. Marks the transition to completed status and triggers downstream compensation and succession planning workflows.',
    `bonus_recommended` BOOLEAN COMMENT 'Indicates whether the reviewing manager has recommended a discretionary or performance-based bonus for the employee as an outcome of this review. Feeds into the annual compensation and incentive planning cycle.',
    `bonus_recommended_amount` DECIMAL(18,2) COMMENT 'The specific bonus dollar amount recommended by the manager for this employee, expressed in the companys operating currency. Populated when bonus_recommended is True. Supports compensation budget planning and incentive analytics.',
    `calibration_status` STRING COMMENT 'Indicates the current state of the HR calibration process for this review. Calibration ensures rating consistency and distribution fairness across managers and business units. Overridden status applies when a calibration committee adjusts the managers original rating.. Valid values are `not_required|pending|in_calibration|calibrated|overridden`',
    `competency_rating` STRING COMMENT 'Aggregate rating reflecting the employees demonstration of required behavioral and technical competencies for their role (e.g., client relationship management, market knowledge, financial acumen, regulatory compliance awareness). Distinct from goal achievement rating.. Valid values are `exceeds_expectations|meets_expectations|partially_meets|needs_improvement|unsatisfactory`',
    `competency_rating_score` DECIMAL(18,2) COMMENT 'Numeric score for competency assessment on a standardized scale (e.g., 1.00–5.00). Enables quantitative talent benchmarking and identification of skill gaps across the real estate workforce.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this performance review record was first created in the system. Serves as the audit trail creation marker per data governance and SOX compliance requirements.',
    `development_plan_summary` STRING COMMENT 'Free-text summary of the employees agreed individual development plan (IDP) for the upcoming review period. Captures targeted training, licensing goals (e.g., broker license renewal, appraiser credential), mentoring, and stretch assignments.',
    `employee_acknowledgement_date` DATE COMMENT 'The date on which the employee formally acknowledged receipt and review of their performance evaluation. Required for HR compliance and dispute resolution documentation.',
    `employee_comments` STRING COMMENT 'Free-text narrative comments provided by the employee in response to the managers evaluation. Captures the employees perspective, acknowledgment, or disagreement with the review findings. Classified as confidential.',
    `goal_rating` STRING COMMENT 'Aggregate rating reflecting the employees performance against individually assigned goals for the review period (e.g., leasing targets, NOI improvement goals, project delivery milestones, client satisfaction scores). Distinct from competency rating.. Valid values are `exceeds_expectations|meets_expectations|partially_meets|needs_improvement|unsatisfactory`',
    `goal_rating_score` DECIMAL(18,2) COMMENT 'Numeric score for goal achievement on a standardized scale (e.g., 1.00–5.00). Supports quantitative decomposition of overall rating into goal vs. competency components for compensation and development analytics.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this performance review record was most recently modified. Supports change tracking, audit compliance, and incremental data pipeline processing in the Databricks Silver Layer.',
    `license_compliance_noted` BOOLEAN COMMENT 'Indicates whether the review explicitly addressed the employees compliance with required professional licenses and certifications (e.g., real estate broker license, appraiser credential, LEED certification). Critical for regulated real estate roles.',
    `manager_comments` STRING COMMENT 'Free-text narrative comments provided by the reviewing manager summarizing the employees performance, strengths, development areas, and behavioral observations during the review period. Classified as confidential due to sensitive personnel evaluation content.',
    `merit_increase_pct` DECIMAL(18,2) COMMENT 'Recommended merit salary increase expressed as a percentage of the employees current base compensation. Populated when merit_increase_recommended is True. Drives compensation planning and budget forecasting for the real estate workforce.',
    `merit_increase_recommended` BOOLEAN COMMENT 'Indicates whether the reviewing manager has recommended a merit-based base salary increase for this employee as an outcome of this performance review. Feeds into the compensation planning cycle.',
    `overall_rating` STRING COMMENT 'The final holistic performance rating assigned to the employee for the review period. Drives merit increase eligibility, promotion consideration, and succession planning decisions across property management, brokerage, development, and corporate functions.. Valid values are `exceeds_expectations|meets_expectations|partially_meets|needs_improvement|unsatisfactory`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric representation of the overall performance rating on a standardized scale (e.g., 1.00–5.00). Enables quantitative ranking, calibration distribution analysis, and statistical workforce analytics for compensation modeling.',
    `pip_end_date` DATE COMMENT 'The date on which the Performance Improvement Plan (PIP) is scheduled to conclude, if pip_indicator is True. Defines the end of the monitored improvement period for follow-up evaluation.',
    `pip_indicator` BOOLEAN COMMENT 'Indicates whether this performance review has resulted in the initiation of a Performance Improvement Plan (PIP) for the employee. A True value triggers a formal PIP workflow and associated documentation requirements.',
    `pip_start_date` DATE COMMENT 'The date on which the Performance Improvement Plan (PIP) formally begins, if pip_indicator is True. Defines the start of the monitored improvement period.',
    `pre_calibration_rating` STRING COMMENT 'The overall performance rating assigned by the manager before the HR calibration session. Preserved for audit and analytics purposes to measure calibration adjustment frequency and magnitude.. Valid values are `exceeds_expectations|meets_expectations|partially_meets|needs_improvement|unsatisfactory`',
    `promotion_recommended` BOOLEAN COMMENT 'Indicates whether the reviewing manager has recommended the employee for a promotion to a higher job grade or title as an outcome of this review. Feeds into succession planning and talent pipeline management.',
    `recommended_next_role` STRING COMMENT 'The job title or role recommended for the employees next career step if a promotion is recommended (e.g., Senior Property Manager, Director of Asset Management, Principal Broker). Supports succession planning and talent pipeline reporting.',
    `retention_risk` STRING COMMENT 'Managers assessment of the employees flight risk or likelihood of voluntary departure. Informs proactive retention strategies and workforce planning for licensed and specialized real estate professionals.. Valid values are `low|medium|high|critical`',
    `review_completion_date` DATE COMMENT 'The date on which the performance review was formally completed and signed off by both the manager and the HR Business Partner. Represents the business event date for the review lifecycle.',
    `review_cycle_name` STRING COMMENT 'The named review cycle to which this evaluation belongs (e.g., FY2024 Annual Review, H1 2024 Mid-Year Review, Q1 2024 Probationary Review). Enables cohort-level reporting and calibration across the real estate workforce.',
    `review_due_date` DATE COMMENT 'The scheduled deadline by which the performance review must be completed per the HR review cycle calendar. Used to track on-time completion rates and manager compliance with talent management processes.',
    `review_period_end_date` DATE COMMENT 'The last date of the performance evaluation period covered by this review. Defines the end boundary of the assessment window (e.g., 2024-12-31 for an annual review).',
    `review_period_start_date` DATE COMMENT 'The first date of the performance evaluation period covered by this review. Defines the start boundary of the assessment window (e.g., 2024-01-01 for an annual review).',
    `review_source_system` STRING COMMENT 'Identifies the originating system from which this performance review record was sourced. Primarily ADP Workforce Now Talent Management; manual or imported values indicate off-cycle or legacy data loads.. Valid values are `adp_workforce_now|manual|imported`',
    `review_status` STRING COMMENT 'Current lifecycle state of the performance review record. Tracks progression from initial draft through manager completion, HR calibration, and final approval. Cancelled status applies to reviews voided due to employee departure or restructuring.. Valid values are `draft|in_progress|pending_approval|calibrated|completed|cancelled`',
    `review_type` STRING COMMENT 'Classification of the review by its business purpose and cadence. Annual reviews drive merit and promotion decisions; mid-year reviews provide interim feedback; probationary reviews assess new hires; project-based reviews evaluate performance on specific development or brokerage engagements; PIP checkpoints monitor employees on a Performance Improvement Plan (PIP).. Valid values are `annual|mid_year|probationary|project_based|pip_checkpoint|ad_hoc`',
    `self_assessment_reference` STRING COMMENT 'Reference identifier or document link to the employees self-assessment submission associated with this review cycle. Supports 360-degree feedback processes and manager-employee alignment analysis.',
    `succession_readiness` STRING COMMENT 'Assessment of the employees readiness to assume a higher-level or critical role within the organization. Used in succession planning for key positions such as Property Manager, Asset Manager, and senior brokerage roles.. Valid values are `ready_now|ready_1_2_years|ready_3_5_years|not_identified`',
    `workforce_segment` STRING COMMENT 'The functional workforce segment to which the employee belongs at the time of the review. Enables segment-level performance benchmarking and talent analytics across the real estate enterprise (e.g., comparing broker performance vs. property management performance). [ENUM-REF-CANDIDATE: property_management|brokerage|asset_management|development|corporate|facility_operations — promote to reference product if additional segments are added]. Valid values are `property_management|brokerage|asset_management|development|corporate|facility_operations`',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Formal employee performance evaluation records conducted on a scheduled or ad-hoc basis. Captures employee reference, review period (annual, mid-year, probationary, project-based), review type, overall performance rating (e.g., exceeds expectations, meets expectations, needs improvement), individual goal ratings, competency ratings, manager comments, employee self-assessment reference, calibration status, merit increase recommendation, promotion recommendation, PIP (Performance Improvement Plan) indicator, review completion date, and approving HR business partner. Sourced from ADP Workforce Now Talent Management. Drives compensation decisions, succession planning, and talent development for real estate workforce.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'Unique surrogate identifier for each headcount plan record in the workforce planning system.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Real estate firms budget headcount at the property level — staffing models for property managers, leasing agents, and maintenance are planned per asset. This link enables property-level labor cost bud',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Real estate annual planning requires reconciling headcount plans with financial budgets — labor cost budgets must align with approved FTE counts. This FK enables variance analysis between planned head',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Fund-level headcount planning is a real business process in real estate investment management: staffing budgets are allocated per fund for LP reporting on management fees and fund expenses. headcount_',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Real estate headcount planning is fundamentally organized by geographic market — firms plan broker and property manager headcount by MSA and submarket. Enables market-level workforce planning dashboar',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile or role classification (e.g., Property Manager, Asset Manager, Leasing Agent, Broker) for which headcount is being planned.',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Real estate headcount planning is organized by investment strategy segment (core, value-add, opportunistic). Enables investment-strategy-aligned workforce planning reports — e.g., how many acquisition',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, business unit, or property team) for which this headcount plan is defined.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Real estate headcount planning is organized by property type — firms plan how many property managers, leasing agents, and engineers are needed per asset class (multifamily vs office vs retail). Enable',
    `superseded_by_plan_headcount_plan_id` BIGINT COMMENT 'Reference to the newer headcount plan record that supersedes this version, enabling plan version lineage tracking. Null if this is the current active version.',
    `actual_filled_fte` DECIMAL(18,2) COMMENT 'The actual number of filled FTE positions as of the reporting snapshot date for this plan period. Sourced from ADP Workforce Now active employee records.',
    `actual_labor_cost` DECIMAL(18,2) COMMENT 'Actual labor cost incurred for this org unit and job profile during the planning period, sourced from payroll actuals in ADP Workforce Now and reconciled via SAP S/4HANA General Ledger.',
    `adp_plan_reference` STRING COMMENT 'Source system reference identifier from ADP Workforce Now for this headcount plan record, enabling traceability and reconciliation with the system of record.',
    `budgeted_headcount_fte` DECIMAL(18,2) COMMENT 'The approved budgeted number of full-time equivalent (FTE) positions for this org unit, job profile, and planning period. Fractional values represent part-time allocations.',
    `budgeted_labor_cost` DECIMAL(18,2) COMMENT 'Total approved budgeted labor cost for this headcount plan, inclusive of base salary and benefits (employer-side). Used for OPEX/CAPEX labor budgeting and SAP S/4HANA financial consolidation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this headcount plan record was first created in the data platform (Silver Layer). Supports audit trail and data lineage requirements.',
    `critical_role_flag` BOOLEAN COMMENT 'Indicates whether the job profile in this headcount plan is designated as a critical role requiring succession planning (e.g., senior asset managers, portfolio directors, licensed brokers in key markets).',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this headcount plan record (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `development_gaps_summary` STRING COMMENT 'Free-text summary of identified skill or competency development gaps for the workforce population in this plan segment, particularly for licensed roles (broker licenses, appraiser credentials) and leadership pipeline.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the planning year (Q1–Q4). Null for annual plans that span the full fiscal year.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this headcount plan applies (e.g., 2025). Used for annual workforce planning cycles and financial consolidation in SAP S/4HANA.',
    `gl_cost_center_code` STRING COMMENT 'SAP S/4HANA General Ledger cost center code to which the budgeted and actual labor costs for this headcount plan are posted, enabling financial consolidation and OPEX/CAPEX tracking.',
    `labor_cost_variance` DECIMAL(18,2) COMMENT 'Difference between budgeted labor cost and actual labor cost (budgeted minus actual). Negative values indicate cost overrun; positive values indicate underspend. Used for financial reporting and variance analysis.',
    `licensed_staff_count` STRING COMMENT 'Number of positions in this headcount plan that require active professional licenses or certifications (e.g., real estate broker licenses, appraiser credentials, LEED certifications). Used for compliance tracking.',
    `net_headcount_change` STRING COMMENT 'Net change in headcount for the planning period, calculated as planned new hires minus planned attrition. Positive values indicate growth; negative values indicate workforce reduction.',
    `open_requisition_count` STRING COMMENT 'Number of approved but unfilled job requisitions currently open for this org unit and job profile within the planning period.',
    `opex_capex_classification` STRING COMMENT 'Indicates whether the labor costs in this plan are classified as Operating Expenditure (OPEX), Capital Expenditure (CAPEX) for development projects, or a mixed allocation. Critical for real estate development project budgeting and financial consolidation.. Valid values are `OPEX|CAPEX|mixed`',
    `plan_approved_by` STRING COMMENT 'Name or employee identifier of the executive or manager who approved this headcount plan (e.g., Chief People Officer, Regional VP). Supports SOX financial controls audit trail.',
    `plan_approved_date` DATE COMMENT 'Date on which this headcount plan was formally approved by the authorized approver. Null if plan is still in draft or submitted status.',
    `plan_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this headcount plan record, used for cross-system reference with SAP S/4HANA and ADP Workforce Now.. Valid values are `^HC-[A-Z0-9]{4,20}$`',
    `plan_name` STRING COMMENT 'Descriptive name of the headcount plan (e.g., FY2025 Q1 Property Management Staffing Plan — Southeast Portfolio).',
    `plan_notes` STRING COMMENT 'Free-text field for additional context, assumptions, or commentary associated with this headcount plan (e.g., market conditions, portfolio growth drivers, regulatory staffing requirements).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the headcount plan record: draft (in preparation), submitted (pending approval), approved (authorized for execution), rejected (returned for revision), or superseded (replaced by a newer version).. Valid values are `draft|submitted|approved|rejected|superseded`',
    `plan_submitted_date` DATE COMMENT 'Date on which this headcount plan was submitted for approval. Supports workflow tracking and planning cycle governance.',
    `plan_type` STRING COMMENT 'Classification of the headcount plan by planning horizon or purpose: annual workforce plan, quarterly reforecast, project-based (CAPEX/OPEX development), succession planning, or contingency staffing.. Valid values are `annual|quarterly|project|succession|contingency`',
    `plan_version` STRING COMMENT 'Sequential version number of this headcount plan record, incremented each time the plan is revised and resubmitted. Version 1 is the initial submission.',
    `planned_attrition` STRING COMMENT 'Anticipated number of employee departures (voluntary and involuntary) projected for this org unit and job profile during the planning period, based on historical attrition rates and known departures.',
    `planned_new_hires` STRING COMMENT 'Number of net-new headcount additions planned for this org unit and job profile during the planning period, excluding backfills.',
    `planning_period_end_date` DATE COMMENT 'The last date of the workforce planning period covered by this headcount plan record.',
    `planning_period_start_date` DATE COMMENT 'The first date of the workforce planning period covered by this headcount plan record.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver when a headcount plan is rejected, documenting the basis for revision. Null for non-rejected plans.',
    `retention_risk_level` STRING COMMENT 'Assessed retention risk level for the workforce population in this headcount plan segment: low, medium, high, or critical. Informs proactive retention investment and succession urgency.. Valid values are `low|medium|high|critical`',
    `sap_wbs_element` STRING COMMENT 'SAP S/4HANA Work Breakdown Structure element code for CAPEX-classified headcount plans associated with real estate development or construction projects, enabling project cost tracking in Procore and SAP.',
    `succession_readiness_level` STRING COMMENT 'Aggregate readiness assessment for succession coverage of the critical role: ready_now (successor can step in immediately), ready_1_2_years, ready_3_5_years, or no_successor (gap requiring external hiring or development investment).. Valid values are `ready_now|ready_1_2_years|ready_3_5_years|no_successor`',
    `successor_candidate_count` STRING COMMENT 'Number of identified internal successor candidates for the critical role in this headcount plan. Supports leadership continuity planning and succession readiness reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this headcount plan record was most recently modified in the data platform. Used for incremental load processing and change tracking in the Databricks Lakehouse Silver Layer.',
    `workforce_segment` STRING COMMENT 'Business segment or functional area to which this headcount plan belongs, reflecting the real estate operational structure: property management, asset management, brokerage, development/construction, corporate, or facility operations. [ENUM-REF-CANDIDATE: property_management|asset_management|brokerage|development|corporate|facility_operations — promote to reference product]. Valid values are `property_management|asset_management|brokerage|development|corporate|facility_operations`',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'Workforce planning and headcount budgeting records by department, property, or business unit for a planning period. Captures planning period (fiscal year, quarter), org unit reference, job profile reference, budgeted headcount (FTE), actual filled headcount, open requisition count, planned new hires, planned attrition, net headcount change, budgeted labor cost (salary + benefits), actual labor cost, variance, and plan approval status. Now also captures succession planning data for critical roles: successor candidates, readiness levels, development gaps, and retention risk. Supports annual workforce planning cycles, CAPEX/OPEX labor budgeting for development projects, property-level staffing models, and leadership continuity planning. Integrates with SAP S/4HANA for financial consolidation.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`recruiting` (
    `recruiting_id` BIGINT COMMENT 'Primary key for recruiting',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Job requisitions in real estate are opened for specific properties (e.g., hiring a property manager for a newly acquired asset). Linking requisitions to assets enables property-level hiring pipeline r',
    `compensation_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.compensation_plan. Business justification: Job requisitions in real estate are opened with a specific compensation plan in mind — defining the pay structure, commission eligibility, and bonus targets for the role being filled. Adding compensat',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Development projects frequently drive specific headcount requisitions — hiring a project manager or site superintendent for a named project. Linking job requisitions to dev_project enables project-spe',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Real estate recruiting is market-specific — broker license requirements, compensation benchmarks, and talent pools vary by submarket and MSA. Enables market-level recruiting pipeline dashboards and li',
    `headcount_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.headcount_plan. Business justification: Job requisitions are authorized by and traceable to approved headcount plans. Adding headcount_plan_id to recruiting links each requisition to its budget authorization, enabling headcount plan vs. act',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Job requisitions are opened to fill roles defined by standardized job profiles. Adding job_profile_id to recruiting links the requisition to the job profile that defines required competencies, license',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, or property team) that owns this requisition.',
    `position_id` BIGINT COMMENT 'Reference to the approved headcount position this requisition is filling, linking to the workforce position master.',
    `employee_id` BIGINT COMMENT 'Reference to the employee record of the hiring manager who initiated and owns this requisition.',
    `recruiting_recruiter_employee_id` BIGINT COMMENT 'Reference to the internal recruiter or talent acquisition specialist assigned to manage this requisition.',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Real estate recruiting for licensed roles must comply with specific state regulatory frameworks. Enables compliance-driven recruiting pipeline management — tracking which open requisitions require lic',
    `adp_requisition_code` STRING COMMENT 'Native requisition identifier from the ADP Workforce Now Talent Acquisition source system. Used for lineage tracing and reconciliation between the lakehouse silver layer and the operational system of record.',
    `applicant_count` STRING COMMENT 'Total number of candidates who have applied to this requisition. Used for sourcing effectiveness analysis and EEOC applicant flow reporting.',
    `appraiser_credential_required` BOOLEAN COMMENT 'Indicates whether a state-certified or licensed appraiser credential (e.g., Certified General Appraiser) is required for this role. Relevant for valuation and appraisal positions per Appraisal Institute and IVSC standards.',
    `approval_status` STRING COMMENT 'Current state of the headcount approval workflow. Requisitions must be approved by finance and HR leadership before sourcing begins, per SOX financial controls for publicly traded REITs.. Valid values are `pending|approved|rejected|cancelled`',
    `approved_by` STRING COMMENT 'Name or employee identifier of the individual who granted final approval for this requisition. Supports SOX audit trail and governance requirements.',
    `approved_date` DATE COMMENT 'Date the requisition received final headcount and budget approval. Used in time-to-fill calculations and SOX audit trails.',
    `approved_headcount` STRING COMMENT 'Number of approved openings under this requisition. Typically 1 but may be greater for bulk hiring events such as leasing agent campaigns or construction crew onboarding.',
    `budget_salary_max` DECIMAL(18,2) COMMENT 'Maximum approved salary budget for this requisition in local currency. Ensures offers remain within approved compensation bands.',
    `budget_salary_min` DECIMAL(18,2) COMMENT 'Minimum approved salary budget for this requisition in local currency. Supports compensation benchmarking and offer approval workflows.',
    `cancellation_reason` STRING COMMENT 'Reason the requisition was cancelled or put on hold (e.g., budget freeze, reorganization, role eliminated). Null if requisition is active or filled.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was first created in the ADP Workforce Now system. Serves as the audit trail anchor for the requisition lifecycle.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budgeted salary amounts (e.g., USD). Supports multi-market real estate enterprises operating across jurisdictions.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Cost center or department code to which the new hires compensation will be charged. Aligns with SAP S/4HANA GL cost center structure.',
    `eeo_job_category` STRING COMMENT 'Equal Employment Opportunity Commission job category code assigned to this requisition (e.g., Officials and Managers, Professionals, Sales Workers). Required for EEOC EEO-1 Component 1 applicant flow reporting. [ENUM-REF-CANDIDATE: officials_managers|professionals|technicians|sales_workers|office_clerical|craft_workers|operatives|laborers|service_workers — promote to reference product]',
    `employment_type` STRING COMMENT 'Nature of the employment arrangement being recruited for. Determines benefits eligibility, payroll classification, and EEOC reporting scope.. Valid values are `full_time|part_time|contract|temporary|intern`',
    `filled_date` DATE COMMENT 'Actual date the requisition was closed as filled (offer accepted). Used to compute time-to-fill KPI.',
    `flsa_classification` STRING COMMENT 'Fair Labor Standards Act classification for the role being recruited. Determines overtime eligibility and payroll processing rules. Must be established at requisition stage to ensure correct offer structuring.. Valid values are `exempt|non_exempt`',
    `internal_posting_flag` BOOLEAN COMMENT 'Indicates whether this requisition was posted internally to allow current employees to apply before or alongside external sourcing. Supports internal mobility programs.',
    `job_family` STRING COMMENT 'Broad occupational grouping for the role (e.g., Property Management, Brokerage, Development, Finance, Corporate). Supports workforce segmentation and compensation benchmarking.',
    `job_posting_url` STRING COMMENT 'External URL of the published job posting on the primary job board or company careers page. Supports sourcing channel tracking and candidate attribution.',
    `job_title` STRING COMMENT 'Official job title for the open position as it will appear on job postings and offer letters. Examples include Property Manager, Leasing Agent, Asset Manager, Construction Project Manager.',
    `min_education_level` STRING COMMENT 'Minimum educational qualification required for the role. Used in candidate screening and EEOC-compliant job posting.. Valid values are `high_school|associate|bachelor|master|doctorate|professional_certification`',
    `min_years_experience` STRING COMMENT 'Minimum number of years of relevant industry experience required for the role. Used in candidate screening and EEOC-compliant job posting standards.',
    `open_date` DATE COMMENT 'Date the requisition was formally approved and opened for sourcing. Used as the start point for time-to-fill calculations.',
    `primary_sourcing_channel` STRING COMMENT 'Main channel through which candidates are being sourced for this requisition. MLS job boards are industry-specific channels for real estate roles. Supports sourcing ROI analytics. [ENUM-REF-CANDIDATE: linkedin|internal_referral|staffing_agency|job_board|mls_job_board|direct_apply|campus|social_media|headhunter — promote to reference product]',
    `priority_level` STRING COMMENT 'Business priority assigned to this requisition by the hiring manager or HR business partner. Critical requisitions (e.g., licensed brokers for active deal pipelines) receive expedited sourcing resources.. Valid values are `critical|high|medium|low`',
    `re_license_required` BOOLEAN COMMENT 'Indicates whether a valid real estate broker or salesperson license is a mandatory requirement for this role. Critical for brokerage, leasing agent, and property management requisitions per NAR and state licensing regulations.',
    `re_license_state` STRING COMMENT 'Two-letter US state code indicating the jurisdiction in which a valid real estate license is required for this role. Null if re_license_required is false.. Valid values are `^[A-Z]{2}$`',
    `requisition_number` STRING COMMENT 'Externally visible, human-readable requisition identifier assigned by ADP Workforce Now Talent Acquisition module. Used in all communications, approvals, and EEOC applicant flow reporting.. Valid values are `^REQ-[0-9]{6,10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the job requisition. Drives time-to-fill analytics and workforce planning dashboards.. Valid values are `draft|open|on_hold|filled|cancelled|closed`',
    `requisition_type` STRING COMMENT 'Classification of the requisition indicating whether it replaces a departing employee (backfill), adds net new headcount, or fills a temporary or contract role. Critical for workforce planning and budget approval workflows.. Valid values are `backfill|new_headcount|temporary|contract|conversion`',
    `target_fill_date` DATE COMMENT 'Business-requested date by which the position should be filled. Used to measure recruiter performance and flag at-risk requisitions in workforce planning.',
    `target_start_date` DATE COMMENT 'Desired start date for the new hire as specified by the hiring manager. Relevant for property management roles tied to lease commencement or construction project timelines.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the requisition record. Used for incremental data loading in the Databricks lakehouse silver layer and audit compliance.',
    `work_location_code` STRING COMMENT 'Code identifying the primary office, property, or work site where the hired employee will be based. Aligns with Yardi Voyager property codes and ADP location master.',
    `work_location_type` STRING COMMENT 'Indicates whether the role requires on-site presence at a property or office, a hybrid arrangement, or is fully remote. Relevant for leasing agents and property managers who typically require on-site presence.. Valid values are `on_site|hybrid|remote`',
    `workforce_segment` STRING COMMENT 'Business segment classification for the role being recruited. Aligns with the real estate enterprises workforce planning taxonomy across property management, brokerage, development, investment, and corporate functions.. Valid values are `property_management|brokerage|development|investment|corporate|facility_operations`',
    CONSTRAINT pk_recruiting PRIMARY KEY(`recruiting_id`)
) COMMENT 'Job requisitions and candidate pipeline records for talent acquisition across the real estate enterprise. Requisition data captures requisition number, position reference, job profile reference, hiring manager, recruiter, requisition type (backfill, new headcount, temporary, contract), department, work location, target dates, budget, status, sourcing channels (MLS job boards, LinkedIn, internal referral, staffing agency), and applicant count. Candidate data captures applicant name, contact information, application date, source channel, resume reference, years of experience, real estate license status (critical for brokerage/leasing roles), education level, application status (applied, screening, phone interview, in-person interview, offer extended, offer accepted, offer declined, rejected, withdrawn), and disposition reason. Sourced from ADP Workforce Now Talent Acquisition module. Supports EEOC applicant flow reporting and time-to-fill analytics.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`applicant` (
    `applicant_id` BIGINT COMMENT 'Unique system-generated identifier for each applicant record in the talent acquisition pipeline. Primary key for the workforce.applicant data product sourced from ADP Workforce Now Talent Acquisition.',
    `employee_id` BIGINT COMMENT 'Employee ID of the hiring manager responsible for the open position. Used to route interview feedback, approval workflows, and offer authorization in the talent acquisition process.',
    `applicant_recruiter_employee_id` BIGINT COMMENT 'Employee ID of the internal recruiter assigned to this applicant record. Links to workforce.employee for recruiter performance analytics and workload reporting.',
    `applicant_referral_employee_id` BIGINT COMMENT 'Employee ID of the internal employee who referred this applicant. Populated only when source_channel is employee_referral. Used for employee referral program tracking and bonus eligibility.',
    `org_unit_id` BIGINT COMMENT 'Reference to the workforce.org_unit record representing the department or business unit for which this position is being filled. Supports headcount planning and EEOC reporting by organizational unit.',
    `position_id` BIGINT COMMENT 'Reference to the workforce.position record representing the open job requisition this applicant applied for. Links the applicant to the specific role being filled.',
    `recruiting_id` BIGINT COMMENT 'Foreign key linking to workforce.recruiting. Business justification: Applicants apply to specific job requisitions. The recruiting product holds the job requisition record. Adding job_requisition_id to applicant creates the direct parent-child link between a candidate ',
    `adp_applicant_number` STRING COMMENT 'External applicant tracking number assigned by ADP Workforce Now Talent Acquisition module. Used for cross-system reconciliation and EEOC applicant flow reporting.',
    `agency_name` STRING COMMENT 'Name of the external staffing or executive search agency that submitted the applicant. Populated only when source_channel is agency. Used for agency performance tracking and fee management.',
    `application_date` DATE COMMENT 'Calendar date on which the applicant submitted their application for the open position. Used for time-to-fill calculations and EEOC applicant flow log reporting.',
    `application_status` STRING COMMENT 'Current stage of the applicant in the recruitment workflow. Tracks progression from initial application through final disposition. [ENUM-REF-CANDIDATE: applied|screening|phone_interview|in_person_interview|offer_extended|offer_accepted|offer_declined|rejected|withdrawn — promote to reference product]',
    `appraiser_credential` STRING COMMENT 'Appraisal Institute or state-issued appraiser credential level held by the applicant. Required for valuation and appraisal roles. Aligns with Appraisal Institute and IVSC credentialing standards.. Valid values are `trainee|licensed|certified_residential|certified_general|none`',
    `background_check_status` STRING COMMENT 'Current status of the pre-employment background screening process for the applicant. Critical for roles requiring broker license verification, financial background checks, and OSHA safety-sensitive positions.. Valid values are `not_initiated|in_progress|passed|failed|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the applicant record was first created in ADP Workforce Now Talent Acquisition. Used for audit trail, data lineage, and EEOC applicant flow log period assignment.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the offer_amount field (e.g., USD). Supports multi-market compensation reporting for real estate enterprises operating across multiple geographies.. Valid values are `^[A-Z]{3}$`',
    `current_employer` STRING COMMENT 'Name of the applicants current or most recent employer as declared on the application. Used for background screening, competitive intelligence, and candidate qualification assessment.',
    `current_job_title` STRING COMMENT 'Job title held by the applicant at their current or most recent employer. Provides context for experience level assessment and role alignment in real estate functions such as property management, brokerage, or asset management.',
    `disability_status` STRING COMMENT 'Self-identified disability status of the applicant as voluntarily provided for Section 503 of the Rehabilitation Act and OFCCP compliance reporting. Collected on a voluntary basis and not used in selection decisions.. Valid values are `yes|no|prefer_not_to_disclose`',
    `disposition_date` DATE COMMENT 'Date on which the final disposition decision was recorded for the applicant (offer accepted, rejected, withdrawn, etc.). Used for time-to-decision metrics and EEOC reporting period alignment.',
    `disposition_reason` STRING COMMENT 'Narrative or coded reason explaining the final outcome of the application (e.g., Does not meet minimum license requirement, Salary expectations exceed band, Position filled by internal candidate, Candidate withdrew). Required for EEOC applicant flow log documentation.',
    `education_field_of_study` STRING COMMENT 'Academic discipline or major associated with the applicants highest education credential (e.g., Real Estate, Finance, Business Administration, Architecture, Construction Management). Supports qualification matching for specialized roles.',
    `eeoc_gender` STRING COMMENT 'Self-identified gender of the applicant as voluntarily provided for EEOC applicant flow log reporting. Collected on a voluntary basis and stored separately from selection criteria per EEOC regulations.. Valid values are `male|female|non_binary|prefer_not_to_disclose`',
    `eeoc_race_ethnicity` STRING COMMENT 'Self-identified race or ethnicity category of the applicant as voluntarily provided for EEOC applicant flow log reporting. Collected on a voluntary basis per EEOC EEO-1 category definitions. [ENUM-REF-CANDIDATE: hispanic_latino|white|black_african_american|native_hawaiian_pacific_islander|asian|american_indian_alaska_native|two_or_more_races|prefer_not_to_disclose — promote to reference product]',
    `email` STRING COMMENT 'Primary email address of the applicant used for all recruitment communications, interview scheduling, and offer delivery. Sourced from ADP Workforce Now application form.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expected_start_date` DATE COMMENT 'Anticipated first day of employment for the applicant if the offer is accepted. Used for onboarding planning, position fill date tracking, and workforce planning alignment.',
    `first_name` STRING COMMENT 'Legal first (given) name of the applicant as provided on the application. Used for candidate identification, correspondence, and EEOC applicant flow reporting.',
    `highest_education_level` STRING COMMENT 'Highest academic credential attained by the applicant as declared on the application. Used for minimum education requirement screening per position profile. [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctorate|professional_certification|other — 7 candidates stripped; promote to reference product]',
    `interview_stage` STRING COMMENT 'Current interview stage reached by the applicant in the selection process. Provides granular tracking within the broader application_status field for pipeline reporting and time-in-stage analytics.. Valid values are `not_started|phone_screen|first_round|second_round|final_round|completed`',
    `last_name` STRING COMMENT 'Legal last (family) name of the applicant as provided on the application. Used for candidate identification, correspondence, and EEOC applicant flow reporting.',
    `offer_amount` DECIMAL(18,2) COMMENT 'Base compensation amount included in the formal offer extended to the applicant. Expressed in the currency defined by currency_code. Used for offer acceptance rate analytics and compensation band compliance review.',
    `offer_date` DATE COMMENT 'Date on which a formal employment offer was extended to the applicant. Used for time-to-offer metrics and offer acceptance rate reporting.',
    `offer_expiry_date` DATE COMMENT 'Date by which the applicant must accept or decline the employment offer. Supports offer management workflows and ensures timely backfill decisions if the offer lapses.',
    `phone` STRING COMMENT 'Primary contact phone number for the applicant. Used by recruiters and hiring managers for screening calls and interview coordination.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `professional_designations` STRING COMMENT 'Comma-separated list of industry professional designations held by the applicant (e.g., CCIM, CPM, MAI, SIOR, CFA, PMP, LEED AP). Supports advanced qualification matching for specialized real estate roles.',
    `re_license_number` STRING COMMENT 'State-issued real estate broker or salesperson license number declared by the applicant. Verified during background screening for roles requiring active licensure. Corresponds to broker_license_number in workforce.employee upon hire.',
    `re_license_state` STRING COMMENT 'Two-letter US state code of the jurisdiction in which the applicant holds their real estate license. Relevant for roles requiring licensure in specific markets or states.. Valid values are `^[A-Z]{2}$`',
    `re_license_status` STRING COMMENT 'Indicates whether the applicant holds an active real estate broker or salesperson license. Critical screening criterion for brokerage, leasing agent, and property management roles requiring licensure under state real estate commission regulations.. Valid values are `active|inactive|pending|none`',
    `re_license_type` STRING COMMENT 'Classification of the real estate license held by the applicant — broker, salesperson, or broker associate. Determines eligibility for roles requiring a specific license tier under state real estate commission rules.. Valid values are `broker|salesperson|broker_associate|none`',
    `resume_reference` STRING COMMENT 'File path, document management system URI, or DocuSign CLM reference pointing to the applicants submitted resume or curriculum vitae. Enables recruiters to retrieve the source document for review.',
    `source_channel` STRING COMMENT 'Recruitment channel through which the applicant was sourced. Used for sourcing effectiveness analytics and cost-per-hire reporting. Values include employee referral, job board (e.g., LinkedIn, Indeed), staffing agency, direct application, company career site, and social media.. Valid values are `employee_referral|job_board|agency|direct_application|career_site|social_media`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the applicant record in ADP Workforce Now. Supports incremental data loading in the Databricks Silver Layer and audit trail requirements.',
    `veteran_status` STRING COMMENT 'Self-identified veteran status of the applicant as voluntarily provided for VEVRAA (Vietnam Era Veterans Readjustment Assistance Act) compliance reporting. Collected on a voluntary basis.. Valid values are `protected_veteran|not_protected_veteran|prefer_not_to_disclose`',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of relevant professional experience declared by the applicant in the real estate industry or related field. Used for minimum qualification screening against position requirements.',
    CONSTRAINT pk_applicant PRIMARY KEY(`applicant_id`)
) COMMENT 'Candidate records for open job requisitions across the real estate enterprise. Captures applicant name, contact information, application date, job requisition reference, source channel (employee referral, job board, agency, direct application), resume reference, current employer, years of relevant experience, real estate license status (holds active broker/salesperson license — critical for brokerage and leasing roles), highest education level, application status (applied, screening, phone interview, in-person interview, offer extended, offer accepted, offer declined, rejected, withdrawn), and disposition reason. Sourced from ADP Workforce Now Talent Acquisition. Supports EEOC applicant flow reporting.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`work_assignment` (
    `work_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each work assignment record linking an employee to a property, project, development site, or asset management portfolio.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Property management staffing requires formal assignment of employees (property managers, leasing agents, engineers) to specific assets. Enables property-level headcount reporting, managed-GLA-per-staf',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: In multi-building campus assets, building engineers and facility staff are assigned to specific buildings. Building-level assignment tracking is required for maintenance scheduling, compliance staffin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Property-level work assignments in real estate require cost center allocation for labor cost tracking, NOI reporting, and CAM expense recovery. cost_center_code is a denormalized string; this FK enabl',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Employee-to-project assignment is a core real estate development staffing process — project managers, site supervisors, and development analysts are formally assigned to specific projects for CAPEX la',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Work assignments in real estate are explicitly tied to geographic submarkets for portfolio staffing ratios and market coverage reporting. Replaces denormalized submarket_code text field; enables marke',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Real estate work assignments are tied to investment strategy segments (core, value-add, opportunistic). Enables investment-strategy-aligned staffing reports — e.g., FTE allocation by market segment fo',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, or business unit) under which this assignment is administered for cost allocation and reporting.',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: Work assignments in real estate track which employees (property managers, asset managers) are assigned to specific portfolio assets. This drives staffing reports, labor cost allocation to assets for N',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Portfolio-level work assignments track which employees manage entire investment portfolios (portfolio managers, analysts). This is essential for portfolio staffing reports, AUM-per-employee metrics, a',
    `position_id` BIGINT COMMENT 'Reference to the position/role definition that governs the employees responsibilities within this assignment (e.g., Property Manager, Leasing Agent, Construction Superintendent).',
    `employee_id` BIGINT COMMENT 'Reference to the employee record for the individual assigned. Enables cross-domain joins to the workforce employee master.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Real estate work assignments are categorized by property type (office, retail, multifamily) for staffing allocation, commission structure determination, and licensing compliance. Replaces denormalized',
    `tertiary_work_approved_by_employee_id` BIGINT COMMENT 'Employee ID of the individual who authorized this work assignment. Required for SOX (Sarbanes-Oxley Act) internal controls and audit trail compliance.',
    `adp_assignment_number` STRING COMMENT 'Source system assignment identifier from ADP Workforce Now used for reconciliation and audit traceability back to the system of record.',
    `approval_date` DATE COMMENT 'The date on which the work assignment was formally approved by the authorized manager or HR business partner.',
    `assignment_basis` STRING COMMENT 'The employment basis under which the assignment is executed. Distinguishes permanent full-time assignments from interim, contract, or secondment arrangements common in real estate project staffing.. Valid values are `full_time|part_time|contract|interim|secondment`',
    `assignment_notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or context relevant to this assignment. May include transition notes, coverage arrangements, or scope clarifications.',
    `assignment_role` STRING COMMENT 'The functional role the employee performs within this specific assignment, which may differ from their formal job title. Distinguishes PM (Property Manager) from AM (Asset Manager) responsibilities at the assignment level. [ENUM-REF-CANDIDATE: property_manager|asset_manager|leasing_agent|construction_superintendent|facility_manager|portfolio_manager|brokerage_agent|maintenance_supervisor — promote to reference product]',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the work assignment. Drives operational reporting on active workforce coverage across properties and projects.. Valid values are `active|pending|on_hold|completed|cancelled|transferred`',
    `assignment_type` STRING COMMENT 'Categorical classification of the nature of the work assignment. Determines which operational domain the employee is serving. [ENUM-REF-CANDIDATE: property_management|leasing_territory|construction_site|asset_management_portfolio|facility_operations|development_project — promote to reference product]. Valid values are `property_management|leasing_territory|construction_site|asset_management_portfolio|facility_operations|development_project`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the jurisdiction in which the assignment is located. Supports multi-national portfolio workforce compliance and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work assignment record was first created in the data platform. Supports audit trail and data lineage requirements per SOX internal controls.',
    `effective_end_date` DATE COMMENT 'The date on which the employees assignment concludes. Null for open-ended assignments. Used for WALT (Weighted Average Lease Term) workforce coverage calculations and succession planning.',
    `effective_start_date` DATE COMMENT 'The date on which the employees assignment to the property, project, or portfolio becomes operationally effective. Used for workforce coverage gap analysis and cost allocation period determination.',
    `fte_allocation_pct` DECIMAL(18,2) COMMENT 'Percentage of the employees full-time equivalent capacity dedicated to this assignment. Supports partial allocations across multiple properties or projects. Values range from 0.01 to 100.00.',
    `geographic_market` STRING COMMENT 'The geographic market or metropolitan area associated with this assignment (e.g., New York Metro, Los Angeles, Chicago). Supports market-level workforce density and coverage analytics aligned with CoStar market definitions.',
    `gl_account_code` STRING COMMENT 'The GL account code used for posting labor costs associated with this assignment. Supports financial consolidation and NOI reporting by property.',
    `is_leed_required` BOOLEAN COMMENT 'Indicates whether LEED (Leadership in Energy and Environmental Design) certification is required for the employee in this assignment. Relevant for ESG (Environmental, Social, and Governance) compliance and green building management roles.',
    `is_primary_assignment` BOOLEAN COMMENT 'Indicates whether this is the employees primary work assignment when multiple concurrent assignments exist. True = primary; False = secondary. Ensures unambiguous identification of the principal property or project responsibility.',
    `license_required` BOOLEAN COMMENT 'Indicates whether a professional license (e.g., broker license, appraiser credential) is required to fulfill this assignment. Triggers compliance validation against the employees license records.',
    `license_type_required` STRING COMMENT 'The specific professional license or credential required for this assignment. Used for compliance monitoring and workforce planning to ensure licensed staff coverage across regulated roles.. Valid values are `broker_license|appraiser_credential|property_manager_license|contractor_license|none`',
    `managed_gla_sqf` DECIMAL(18,2) COMMENT 'Total GLA (Gross Leasable Area) in square feet (SQF) under the employees management responsibility within this assignment. Used for PSF (Per Square Foot) labor cost benchmarking and workload capacity analysis.',
    `opex_capex_classification` STRING COMMENT 'Indicates whether the labor cost of this assignment is classified as OPEX (Operating Expenditure) for property management/leasing or CAPEX (Capital Expenditure) for development and construction activities. Critical for financial reporting and NOI calculations.. Valid values are `opex|capex|mixed`',
    `planned_end_date` DATE COMMENT 'Originally planned end date for the assignment at the time of creation, before any extensions or modifications. Enables variance analysis between planned and actual assignment duration for workforce planning.',
    `procore_assignment_ref` STRING COMMENT 'Cross-reference to the Procore project team member record for construction and development assignments. Populated for assignment_type = construction_site or development_project.',
    `salesforce_user_assignment_ref` STRING COMMENT 'Cross-reference to the Salesforce CRM territory or account assignment record for leasing agents and brokers. Enables reconciliation between HR assignment data and CRM deal pipeline ownership.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this assignment record originated. Supports data lineage tracking and reconciliation across integrated platforms.. Valid values are `adp_workforce_now|yardi_voyager|procore|salesforce_crm|manual`',
    `state_code` STRING COMMENT 'Two-letter US state or territory code for the jurisdiction of the assignment. Drives state-specific licensing compliance validation and payroll tax jurisdiction determination.. Valid values are `^[A-Z]{2}$`',
    `termination_reason` STRING COMMENT 'Reason code explaining why the assignment ended. Supports workforce analytics on assignment turnover patterns and property-level staffing continuity. [ENUM-REF-CANDIDATE: completed|reassigned|property_sold|project_closed|employee_terminated|restructure|voluntary_exit — promote to reference product]',
    `unit_count` STRING COMMENT 'Number of leasable units or suites under the employees management responsibility within this assignment. Relevant for residential property managers and leasing agents for workload benchmarking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this work assignment record. Used for incremental data pipeline processing and change data capture in the Databricks Silver Layer.',
    `yardi_assignment_ref` STRING COMMENT 'Cross-reference identifier from Yardi Voyager linking this assignment to the property management user-property access configuration. Enables reconciliation between HR assignment records and property system access rights.',
    CONSTRAINT pk_work_assignment PRIMARY KEY(`work_assignment_id`)
) COMMENT 'Operational assignments linking employees to specific properties, projects, development sites, or asset management portfolios for a defined period. Captures assignment type (property management, leasing territory, construction site, asset management portfolio, facility operations), assigned property or project reference, start and end dates, FTE allocation percentage, primary vs. secondary indicator, and assignment status. Enables property-level workforce tracking — which PM manages which building, which leasing agent covers which submarket, which construction superintendent is on which development project. Critical for cross-domain joins to property and development domains for operational reporting and cost allocation.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`commission_record` (
    `commission_record_id` BIGINT COMMENT 'Unique surrogate identifier for each employee-facing commission earnings record. Primary key for the commission_record data product in the workforce domain.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Brokerage commissions are earned on specific property transactions. Linking commission_record to asset enables commission reporting by property, portfolio-level GCI analytics, and asset disposition co',
    `brokerage_deal_id` BIGINT COMMENT 'Reference to the brokerage deal (lease execution, property sale, or acquisition) that triggered this commission event. Sourced from Salesforce CRM deal closure events.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Commission expense GL posting in real estate brokerage requires validated chart of accounts mapping for accurate leasing commission capitalization vs. expensing under ASC 842. gl_account_code is a den',
    `compensation_plan_id` BIGINT COMMENT 'Reference to the compensation plan governing the commission structure, split percentages, and draw-against-commission terms applicable to this record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Commission expense allocation to cost centers in real estate brokerage is required for property-level leasing cost tracking and NOI reporting. cost_center_code is a denormalized string; this FK enable',
    `lead_attribution_id` BIGINT COMMENT 'Foreign key linking to marketing.lead_attribution. Business justification: Marketing ROI measurement and commission calculation in real estate require linking each commission payment to the marketing attribution record that generated the deal. This enables campaign-level ROI',
    `lease_agreement_id` BIGINT COMMENT 'Foreign key linking to lease.agreement. Business justification: Leasing commissions are triggered by lease execution milestones (signing, rent commencement). Linking commission_record directly to the lease agreement enables commission payment scheduling, clawback ',
    `payroll_id` BIGINT COMMENT 'Reference to the ADP payroll run in which this commission was processed and disbursed to the employee. Null if commission is pending payroll processing.',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: Broker commissions in real estate are earned on specific property transactions. Linking commission_record to portfolio_asset enables asset-level commission cost tracking, disposition cost reporting, a',
    `employee_id` BIGINT COMMENT 'Reference to the employee (broker, leasing agent, or sales staff) who earned this commission. Links to the workforce employee master record.',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: Commission payments are triggered by property sale closings. Linking commission_record directly to property_sale enables commission-by-transaction reporting, closing-date-triggered payment processing,',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Real estate commissions vary by transaction type (sale, lease, 1031 exchange). Replaces denormalized deal_type text; enables commission reporting by transaction category, GL classification, tax treatm',
    `accrual_period` STRING COMMENT 'The accounting period (YYYY-MM format) in which this commission expense is accrued for financial reporting purposes. Used for period-close reconciliation and commission expense accrual journal entries.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `adp_commission_reference` STRING COMMENT 'External reference number assigned by ADP Workforce Now to this commission earnings record, used for reconciliation between the lakehouse and the payroll system of record.',
    `approval_date` DATE COMMENT 'The date on which the commission record was reviewed and approved by the authorized approver (e.g., brokerage manager or finance controller) for payroll processing.',
    `clawback_date` DATE COMMENT 'The date on which a previously paid commission was clawed back due to deal cancellation, lease default, or policy violation. Null if payment_status is not clawed_back.',
    `clawback_reason` STRING COMMENT 'The reason code for a commission clawback event. Populated only when payment_status is clawed_back. Used for audit trail, dispute resolution, and financial restatement.. Valid values are `deal_cancellation|lease_default|policy_violation|calculation_error|overpayment`',
    `co_broker_firm_name` STRING COMMENT 'Name of the external brokerage firm participating in the co-broker split arrangement. Populated only when co_broker_flag is True. Used for co-broker payment reconciliation and MLS reporting.',
    `co_broker_flag` BOOLEAN COMMENT 'Indicates whether this commission record involves a co-broker split arrangement where commission is shared with an external brokerage firm. True = co-broker split applies.',
    `commission_event_type` STRING COMMENT 'Classification of the commission-triggering event. Determines the calculation basis and GL posting treatment. [ENUM-REF-CANDIDATE: lease_commission|sale_commission|referral_fee|co_broker_split|override_commission|acquisition_commission — promote to reference product if additional types emerge]. Valid values are `lease_commission|sale_commission|referral_fee|co_broker_split|override_commission|acquisition_commission`',
    `commission_period_end_date` DATE COMMENT 'The end date of the commission earning period to which this record applies. Paired with commission_period_start_date to define the accrual window.',
    `commission_period_start_date` DATE COMMENT 'The start date of the commission earning period to which this record applies. Used for accrual accounting, period-over-period reporting, and alignment with payroll pay periods.',
    `commission_rate_pct` DECIMAL(18,2) COMMENT 'The commission rate applied to the deal transaction value to derive the gross commission amount. Expressed as a decimal (e.g., 0.0300 = 3%). Sourced from the applicable compensation plan or deal-specific commission agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this commission record was first created in the system, typically upon deal closure event ingestion from Salesforce CRM. Audit trail field per SOX controls.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this commission record (e.g., USD). Supports multi-currency operations for international real estate portfolios.. Valid values are `^[A-Z]{3}$`',
    `deal_close_date` DATE COMMENT 'The date the underlying real estate deal (lease execution, property sale, or acquisition) was officially closed and commission was earned. This is the principal business event date that triggers the commission record.',
    `deal_transaction_value` DECIMAL(18,2) COMMENT 'The total value of the underlying real estate transaction (e.g., sale price, total lease value over term) that forms the basis for commission calculation. Used for commission rate validation and analytics.',
    `draw_balance_offset` DECIMAL(18,2) COMMENT 'Amount deducted from the net commission to recover outstanding draw advances previously paid to the employee under a draw-against-commission plan. Zero if the employee is not on a draw plan or has no outstanding draw balance.',
    `draw_plan_flag` BOOLEAN COMMENT 'Indicates whether the employee is on a draw-against-commission compensation plan. True = draw advances are being issued and recovered against earned commissions.',
    `gl_posted_flag` BOOLEAN COMMENT 'Indicates whether this commission expense has been successfully posted to the General Ledger. True = posted; False = pending GL posting. Used for period-close reconciliation.',
    `gl_posting_reference` STRING COMMENT 'The document or journal entry reference number from the GL system (SAP S/4HANA or Yardi Voyager) confirming that this commission expense has been posted. Null if GL posting is pending.',
    `gross_commission_amount` DECIMAL(18,2) COMMENT 'Total commission amount generated by the deal before any splits, co-broker deductions, or draw offsets are applied. Represents the full commission pool attributable to this event.',
    `is_1099_reportable` BOOLEAN COMMENT 'Indicates whether this commission payment must be reported on IRS Form 1099-NEC. True for independent contractor brokers; False for W-2 employees whose commissions are included in W-2 wages.',
    `net_commission_amount` DECIMAL(18,2) COMMENT 'The employees net commission earnings after applying the split percentage and any co-broker deductions. Calculated as gross_commission_amount × split_pct minus co-broker deductions. This is the pre-draw-offset amount payable to the employee.',
    `notes` STRING COMMENT 'Free-text field for additional context, exceptions, or explanations related to this commission record. Used by payroll administrators and brokerage managers to document non-standard commission arrangements or dispute resolutions.',
    `outstanding_draw_balance` DECIMAL(18,2) COMMENT 'The remaining unrecovered draw advance balance owed by the employee after applying the draw_balance_offset from this commission record. Carried forward to subsequent commission records for ongoing recovery.',
    `payable_amount` DECIMAL(18,2) COMMENT 'Final amount to be disbursed to the employee after applying the split percentage and subtracting the draw balance offset. This is the amount processed through ADP payroll or issued as a 1099 payment.',
    `payment_date` DATE COMMENT 'The date the commission was actually disbursed to the employee via payroll or direct 1099 payment. Null if payment_status is not paid.',
    `payment_status` STRING COMMENT 'Current lifecycle state of the commission payment. Drives payroll processing eligibility, accrual reversal, and 1099 reporting inclusion. Pending = awaiting approval; Approved = cleared for payroll; Paid = disbursed; Clawed_back = recovered due to deal cancellation or policy violation; Voided = cancelled before payment.. Valid values are `pending|approved|paid|clawed_back|voided`',
    `salesforce_deal_number` STRING COMMENT 'The externally-known deal or opportunity number from Salesforce CRM that originated this commission event. Used for cross-system traceability between brokerage and payroll domains.',
    `split_pct` DECIMAL(18,2) COMMENT 'The percentage of the gross commission allocated to this employee under the applicable commission split agreement. Expressed as a decimal (e.g., 0.6000 = 60%). Owned by the brokerage domain commission_split product; replicated here for payroll calculation audit trail.',
    `tax_year` STRING COMMENT 'The calendar tax year (e.g., 2024) to which this commission record belongs for IRS 1099-NEC or W-2 reporting purposes. Used for year-end tax reporting and accrual cutoff.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this commission record, including status changes, amount adjustments, or approval actions. Audit trail field per SOX controls.',
    `worker_classification` STRING COMMENT 'Tax classification of the commission recipient. Determines whether commission is processed through W-2 payroll (ADP) or issued as a 1099-NEC for independent contractor brokers. Critical for IRS compliance and 1099 reporting.. Valid values are `w2_employee|independent_contractor|1099_broker`',
    CONSTRAINT pk_commission_record PRIMARY KEY(`commission_record_id`)
) COMMENT 'Employee-facing transactional records of commission earnings for brokers, leasing agents, and sales staff. Captures employee reference, deal reference (lease execution, property sale, acquisition), commission event type (lease commission, sale commission, referral fee, co-broker split, override commission), gross commission amount, split percentage, net commission to employee, draw balance offset for draw-against-commission plans, commission period, payment status (pending, approved, paid, clawed-back), and GL posting reference. Sourced from Salesforce CRM deal closure events and processed through ADP Workforce Now payroll. SSOT boundary: deal-level commission structures and split calculations are owned by the brokerage domain; this product owns the employee-facing earnings record for payroll processing, 1099 reporting for independent contractor brokers, and commission expense accrual.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` (
    `role_training_requirement_id` BIGINT COMMENT 'Unique surrogate identifier for each role training requirement record',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to the job profile definition',
    `workforce_training_id` BIGINT COMMENT 'Foreign key linking to the training course in the workforce training catalog',
    `ce_credit_hours_applicable` DECIMAL(18,2) COMMENT 'Number of CE credit hours from this course that count toward license renewal requirements for this job profile. May differ from the courses total CE hours if only a subset applies to this roles license type.',
    `completion_deadline_days` STRING COMMENT 'Number of days from hire date (for onboarding) or from effective date (for ongoing requirements) by which employees in this job profile must complete the training',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training requirement record was first created in the system',
    `effective_date` DATE COMMENT 'Date from which this training requirement becomes active for the job profile. Used to manage phased rollouts of new compliance requirements.',
    `expiration_date` DATE COMMENT 'Date on which this training requirement ceases to apply to the job profile. Null indicates an ongoing requirement.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this training course is mandatory for employees in this job profile. Drives compliance tracking and enforcement workflows.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this training requirement record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training requirement record was last modified',
    `recurrence_period_months` STRING COMMENT 'Number of months between required completions for recurring training requirements (e.g., annual compliance training). Null for one-time requirements.',
    `requirement_status` STRING COMMENT 'Current lifecycle state of this training requirement. Active requirements are enforced in compliance reporting.',
    `requirement_type` STRING COMMENT 'Classification of why this training is required for this role (e.g., Regulatory for state-mandated CE, Compliance for internal policy, Onboarding for new hires, License Renewal for maintaining credentials)',
    `waiver_allowed` BOOLEAN COMMENT 'Indicates whether employees in this job profile can request a waiver or exemption from this training requirement based on prior experience or equivalent credentials',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this training requirement record',
    CONSTRAINT pk_role_training_requirement PRIMARY KEY(`role_training_requirement_id`)
) COMMENT 'This association product represents the formal assignment of mandatory or recommended training courses to job profiles within the real estate enterprise. It captures regulatory CE requirements, compliance mandates, and professional development standards that apply to specific roles. Each record links one training course to one job profile with attributes that define the requirements nature, timing, and applicability. Sourced from ADP Workforce Now LMS and HCM modules, this association supports compliance tracking, license renewal planning, and onboarding curriculum design.. Existence Justification: In real estate workforce management, training requirements are formally assigned to job profiles based on regulatory mandates (state real estate commission CE requirements for brokers, appraisal board requirements for appraisers), compliance policies (Fair Housing, OSHA), and role-specific competencies. A single training course (e.g., Fair Housing Act compliance) is required for multiple job profiles (broker, property manager, leasing agent), and a single job profile requires multiple training courses to maintain licensure and operational competency. This is an actively managed business process in ADP Workforce Now LMS, where HR and compliance teams create, update, and retire training requirements as regulations and business needs evolve.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`grade_band` (
    `grade_band_id` BIGINT COMMENT 'Primary key for grade_band',
    `parent_grade_band_id` BIGINT COMMENT 'Self-referencing FK on grade_band (parent_grade_band_id)',
    `approval_required` BOOLEAN COMMENT 'Indicates whether executive or board approval is required for compensation decisions within this grade band (typically true for executive-level bands).',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether positions in this grade band are eligible for performance-based bonus compensation.',
    `career_track` STRING COMMENT 'Career progression track for this grade band (individual contributor, management, executive).',
    `grade_band_category` STRING COMMENT 'High-level classification of the grade band grouping similar organizational levels together.',
    `grade_band_code` STRING COMMENT 'Short alphanumeric code representing the grade band (e.g., GB01, EXEC, MGR1). Used as a business identifier for payroll and HR systems.',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether positions in this grade band are eligible for commission-based compensation (typically for brokers and leasing agents).',
    `compa_ratio_target` DECIMAL(18,2) COMMENT 'Target compa-ratio (comparison ratio) for employees in this grade band, expressed as a percentage. A compa-ratio of 100.00 means the employee is paid at the midpoint of the salary range.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this grade band record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for salary amounts (e.g., USD, CAD, GBP).',
    `grade_band_description` STRING COMMENT 'Detailed description of the grade band, including typical roles, responsibilities, and organizational level.',
    `education_requirement` STRING COMMENT 'Typical education requirement for positions in this grade band (e.g., High School Diploma, Bachelors Degree, Masters Degree, Professional Certification).',
    `effective_end_date` DATE COMMENT 'Date when this grade band is no longer effective. Null for currently active grade bands.',
    `effective_start_date` DATE COMMENT 'Date when this grade band becomes effective and available for use in compensation planning and employee assignments.',
    `equity_eligible` BOOLEAN COMMENT 'Indicates whether positions in this grade band are eligible for equity compensation (stock options, restricted stock units).',
    `flsa_status` STRING COMMENT 'FLSA classification indicating whether positions in this grade band are exempt or non-exempt from overtime pay requirements.',
    `job_family` STRING COMMENT 'Broad job family or functional area associated with this grade band (e.g., Property Management, Asset Management, Brokerage, Construction, Corporate).',
    `last_market_review_date` DATE COMMENT 'Date when the salary ranges for this grade band were last reviewed and updated based on market data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this grade band record was last updated.',
    `grade_band_level` STRING COMMENT 'Numeric level representing the hierarchical position of the grade band within the organization (e.g., 1=entry level, 10=executive). Used for career progression and reporting structure.',
    `license_required` BOOLEAN COMMENT 'Indicates whether positions in this grade band require professional licenses (e.g., real estate broker license, appraiser certification, property management license).',
    `market_pricing_source` STRING COMMENT 'External compensation survey or market data source used to benchmark salary ranges for this grade band (e.g., Mercer, Willis Towers Watson, Radford).',
    `maximum_salary` DECIMAL(18,2) COMMENT 'Maximum annual salary amount for positions within this grade band. Represents the ceiling for compensation within this band.',
    `midpoint_salary` DECIMAL(18,2) COMMENT 'Target midpoint annual salary for positions within this grade band. Represents the competitive market rate for fully competent performance.',
    `minimum_salary` DECIMAL(18,2) COMMENT 'Minimum annual salary amount for positions within this grade band. Used for compensation planning and pay equity analysis.',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of relevant work experience typically required for positions in this grade band.',
    `grade_band_name` STRING COMMENT 'Human-readable name of the grade band (e.g., Executive Leadership, Senior Management, Professional Staff, Administrative Support).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next market review and potential adjustment of salary ranges for this grade band.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this grade band.',
    `pay_transparency_disclosure` BOOLEAN COMMENT 'Indicates whether salary ranges for this grade band must be disclosed in job postings to comply with pay transparency laws (e.g., California, New York, Colorado).',
    `salary_frequency` STRING COMMENT 'Frequency at which salary amounts are expressed (annual, monthly, biweekly, weekly, hourly).',
    `grade_band_status` STRING COMMENT 'Current lifecycle status of the grade band. Active bands are available for employee assignment; inactive bands are no longer used.',
    `target_bonus_percentage` DECIMAL(18,2) COMMENT 'Target bonus as a percentage of base salary for positions in this grade band (e.g., 15.00 represents 15% target bonus).',
    CONSTRAINT pk_grade_band PRIMARY KEY(`grade_band_id`)
) COMMENT 'Master reference table for grade_band. Referenced by grade_band_id.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`training_session` (
    `training_session_id` BIGINT COMMENT 'Primary key for training_session',
    `address_id` BIGINT COMMENT 'Reference to the physical location, facility, or property where the training session is held (for in-person sessions).',
    `employee_id` BIGINT COMMENT 'Reference to the employee or external trainer who is facilitating this training session.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or business unit sponsoring or organizing this training session.',
    `training_program_id` BIGINT COMMENT 'Reference to the parent training program or curriculum that this session belongs to.',
    `workforce_training_id` BIGINT COMMENT 'Reference to the specific course or training module delivered in this session.',
    `prior_training_session_id` BIGINT COMMENT 'Self-referencing FK on training_session (prior_training_session_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the training session concluded, may differ from scheduled time.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the training session commenced, may differ from scheduled time.',
    `assessment_required` BOOLEAN COMMENT 'Indicates whether participants must complete a test, quiz, or assessment to pass this training session (True/False).',
    `attended_count` STRING COMMENT 'Actual number of participants who attended or completed the training session.',
    `average_score_percent` DECIMAL(18,2) COMMENT 'Mean assessment score achieved by all participants who completed the training session.',
    `cancellation_reason` STRING COMMENT 'Explanation or business reason for cancelling or postponing the training session, if applicable.',
    `certification_type` STRING COMMENT 'Type or name of the professional certification, license, or credential awarded upon completion (e.g., broker license, appraiser credential, property manager certification).',
    `completion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of enrolled participants who successfully completed the training session.',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'Number of continuing education credits or professional development hours awarded for completing this training session.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Cost or fee charged per participant for attending this training session, in the organizations base currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this training session record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this session record (e.g., USD, CAD, GBP).',
    `duration_hours` DECIMAL(18,2) COMMENT 'Planned or actual duration of the training session measured in hours.',
    `enrolled_count` STRING COMMENT 'Current number of employees or participants registered for this training session.',
    `feedback_comments` STRING COMMENT 'Aggregated or representative participant feedback comments and suggestions for improving the training session.',
    `feedback_rating` DECIMAL(18,2) COMMENT 'Average participant satisfaction rating for this training session, typically on a scale of 1.00 to 5.00.',
    `is_certification_eligible` BOOLEAN COMMENT 'Indicates whether successful completion of this session qualifies participants for a professional certification or credential (True/False).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether attendance at this training session is required for specific employee roles or compliance purposes (True/False).',
    `materials_provided` STRING COMMENT 'Description of training materials, handouts, or resources provided to participants (e.g., workbooks, digital files, reference guides).',
    `max_capacity` STRING COMMENT 'Maximum number of participants or seats available for this training session.',
    `meeting_url` STRING COMMENT 'Web link or URL for accessing the virtual training session, if applicable.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this training session record was last updated or modified.',
    `passing_score_percent` DECIMAL(18,2) COMMENT 'Minimum percentage score required on the assessment to successfully complete the training session.',
    `prerequisites` STRING COMMENT 'Required prior training, certifications, or experience that participants must have before enrolling in this session.',
    `room_number` STRING COMMENT 'Specific room, conference space, or training area identifier within the location facility.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned date and time when the training session is scheduled to conclude.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when the training session is scheduled to begin.',
    `session_category` STRING COMMENT 'Business classification of the training content area (compliance, technical, leadership, sales, safety, onboarding, professional development).',
    `session_code` STRING COMMENT 'Externally-known unique business identifier for the training session, used for scheduling and registration purposes.',
    `session_title` STRING COMMENT 'Human-readable name or title of the training session (e.g., Broker License Renewal Course, Property Management Best Practices).',
    `session_type` STRING COMMENT 'Categorical classification of the training delivery method (classroom, virtual, hybrid, on-the-job, self-paced, webinar).',
    `training_session_status` STRING COMMENT 'Current lifecycle state of the training session (scheduled, in_progress, completed, cancelled, postponed, draft).',
    `target_audience` STRING COMMENT 'Description of the intended participant group or employee roles for this training session (e.g., New Brokers, Property Managers, All Corporate Staff).',
    `total_session_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for delivering this training session, including instructor fees, materials, and facility costs.',
    `virtual_platform` STRING COMMENT 'Name of the virtual meeting or webinar platform used for remote training delivery (Zoom, Teams, Webex, Google Meet, other).',
    CONSTRAINT pk_training_session PRIMARY KEY(`training_session_id`)
) COMMENT 'Master reference table for training_session. Referenced by session_id.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`workforce`.`training_program` (
    `training_program_id` BIGINT COMMENT 'Primary key for training_program',
    `prerequisite_training_program_id` BIGINT COMMENT 'Self-referencing FK on training_program (prerequisite_training_program_id)',
    `accreditation_body` STRING COMMENT 'Name of the professional or regulatory body that accredits or recognizes this training program.',
    `accreditation_number` STRING COMMENT 'Unique accreditation or approval number assigned by the accrediting body.',
    `assessment_required` BOOLEAN COMMENT 'Indicates whether participants must complete an assessment or examination to pass the training program.',
    `certification_awarded` STRING COMMENT 'Name of the certification or credential awarded upon successful completion of the training program.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Cost in USD per participant for delivering the training program, including materials and instructor fees.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training program record was first created in the system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of continuing education credit hours awarded upon successful completion, applicable for professional certifications.',
    `delivery_method` STRING COMMENT 'Method by which the training program is delivered to participants.',
    `department_code` STRING COMMENT 'Code of the department responsible for administering and maintaining the training program.',
    `training_program_description` STRING COMMENT 'Detailed description of the training program content, objectives, and learning outcomes.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training program measured in hours.',
    `effective_end_date` DATE COMMENT 'Date when the training program is no longer available for new enrollments, nullable for ongoing programs.',
    `effective_start_date` DATE COMMENT 'Date when the training program becomes available for enrollment and delivery.',
    `is_compliance_required` BOOLEAN COMMENT 'Indicates whether the training program is required to meet regulatory or industry compliance obligations.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the training program is mandatory for specific roles or all employees.',
    `language` STRING COMMENT 'Primary language in which the training program is delivered, using ISO 639-2 three-letter language codes.',
    `last_review_date` DATE COMMENT 'Date when the training program content was last reviewed for accuracy and relevance.',
    `learning_objectives` STRING COMMENT 'Specific learning objectives and competencies that participants will achieve upon completion.',
    `materials_url` STRING COMMENT 'URL or file path to the training materials, handouts, and resources for the program.',
    `maximum_capacity` STRING COMMENT 'Maximum number of participants that can be enrolled in a single session of the training program.',
    `minimum_enrollment` STRING COMMENT 'Minimum number of participants required to proceed with a scheduled training session.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified the training program record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the training program record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and update of the training program content.',
    `owner_employee_id` BIGINT COMMENT 'Employee identifier of the program owner responsible for content, delivery, and maintenance of the training program.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required to successfully pass the training program assessment.',
    `prerequisites` STRING COMMENT 'Required prior training, certifications, or experience needed before enrolling in this program.',
    `program_code` STRING COMMENT 'Externally-known unique code for the training program used in catalogs and scheduling systems.',
    `program_name` STRING COMMENT 'Full name of the training program as displayed to employees and managers.',
    `program_status` STRING COMMENT 'Current lifecycle status of the training program indicating availability for enrollment.',
    `program_type` STRING COMMENT 'Classification of the training program by its primary purpose and audience.',
    `recertification_interval_months` STRING COMMENT 'Number of months between required recertification or renewal training sessions.',
    `recertification_required` BOOLEAN COMMENT 'Indicates whether periodic recertification or renewal training is required after initial completion.',
    `target_audience` STRING COMMENT 'Description of the intended audience for the training program, including roles, departments, or employee levels.',
    `vendor_name` STRING COMMENT 'Name of the external vendor or training provider delivering the program, if applicable.',
    `version_number` STRING COMMENT 'Version number of the training program content, incremented when curriculum or materials are updated.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the training program record.',
    CONSTRAINT pk_training_program PRIMARY KEY(`training_program_id`)
) COMMENT 'Master reference table for training_program. Referenced by training_program_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `real_estate_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `real_estate_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_replaced_position_id` FOREIGN KEY (`replaced_position_id`) REFERENCES `real_estate_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_unit_org_unit_id` FOREIGN KEY (`parent_unit_org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `real_estate_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_position_id` FOREIGN KEY (`position_id`) REFERENCES `real_estate_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_tertiary_employment_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_employment_hr_business_partner_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `real_estate_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `real_estate_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_payroll_id` FOREIGN KEY (`payroll_id`) REFERENCES `real_estate_ecm`.`workforce`.`payroll`(`payroll_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_grade_band_id` FOREIGN KEY (`grade_band_id`) REFERENCES `real_estate_ecm`.`workforce`.`grade_band`(`grade_band_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `real_estate_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_superseded_by_plan_compensation_plan_id` FOREIGN KEY (`superseded_by_plan_compensation_plan_id`) REFERENCES `real_estate_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ADD CONSTRAINT `fk_workforce_benefit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `real_estate_ecm`.`workforce`.`benefit`(`benefit_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_position_id` FOREIGN KEY (`position_id`) REFERENCES `real_estate_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_work_assignment_id` FOREIGN KEY (`work_assignment_id`) REFERENCES `real_estate_ecm`.`workforce`.`work_assignment`(`work_assignment_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_position_id` FOREIGN KEY (`position_id`) REFERENCES `real_estate_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ADD CONSTRAINT `fk_workforce_license_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ADD CONSTRAINT `fk_workforce_license_renewal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ADD CONSTRAINT `fk_workforce_license_renewal_license_certification_id` FOREIGN KEY (`license_certification_id`) REFERENCES `real_estate_ecm`.`workforce`.`license_certification`(`license_certification_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_license_certification_id` FOREIGN KEY (`license_certification_id`) REFERENCES `real_estate_ecm`.`workforce`.`license_certification`(`license_certification_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_training_session_id` FOREIGN KEY (`training_session_id`) REFERENCES `real_estate_ecm`.`workforce`.`training_session`(`training_session_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ADD CONSTRAINT `fk_workforce_training_enrollment_workforce_training_id` FOREIGN KEY (`workforce_training_id`) REFERENCES `real_estate_ecm`.`workforce`.`workforce_training`(`workforce_training_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `real_estate_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `real_estate_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `real_estate_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_tertiary_performance_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_performance_hr_business_partner_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `real_estate_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_superseded_by_plan_headcount_plan_id` FOREIGN KEY (`superseded_by_plan_headcount_plan_id`) REFERENCES `real_estate_ecm`.`workforce`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ADD CONSTRAINT `fk_workforce_recruiting_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `real_estate_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ADD CONSTRAINT `fk_workforce_recruiting_headcount_plan_id` FOREIGN KEY (`headcount_plan_id`) REFERENCES `real_estate_ecm`.`workforce`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ADD CONSTRAINT `fk_workforce_recruiting_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `real_estate_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ADD CONSTRAINT `fk_workforce_recruiting_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ADD CONSTRAINT `fk_workforce_recruiting_position_id` FOREIGN KEY (`position_id`) REFERENCES `real_estate_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ADD CONSTRAINT `fk_workforce_recruiting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ADD CONSTRAINT `fk_workforce_recruiting_recruiting_recruiter_employee_id` FOREIGN KEY (`recruiting_recruiter_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_applicant_recruiter_employee_id` FOREIGN KEY (`applicant_recruiter_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_applicant_referral_employee_id` FOREIGN KEY (`applicant_referral_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_position_id` FOREIGN KEY (`position_id`) REFERENCES `real_estate_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_recruiting_id` FOREIGN KEY (`recruiting_id`) REFERENCES `real_estate_ecm`.`workforce`.`recruiting`(`recruiting_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `real_estate_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_tertiary_work_approved_by_employee_id` FOREIGN KEY (`tertiary_work_approved_by_employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ADD CONSTRAINT `fk_workforce_commission_record_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `real_estate_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ADD CONSTRAINT `fk_workforce_commission_record_payroll_id` FOREIGN KEY (`payroll_id`) REFERENCES `real_estate_ecm`.`workforce`.`payroll`(`payroll_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ADD CONSTRAINT `fk_workforce_commission_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ADD CONSTRAINT `fk_workforce_role_training_requirement_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `real_estate_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ADD CONSTRAINT `fk_workforce_role_training_requirement_workforce_training_id` FOREIGN KEY (`workforce_training_id`) REFERENCES `real_estate_ecm`.`workforce`.`workforce_training`(`workforce_training_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`grade_band` ADD CONSTRAINT `fk_workforce_grade_band_parent_grade_band_id` FOREIGN KEY (`parent_grade_band_id`) REFERENCES `real_estate_ecm`.`workforce`.`grade_band`(`grade_band_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `real_estate_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `real_estate_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `real_estate_ecm`.`workforce`.`training_program`(`training_program_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_workforce_training_id` FOREIGN KEY (`workforce_training_id`) REFERENCES `real_estate_ecm`.`workforce`.`workforce_training`(`workforce_training_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` ADD CONSTRAINT `fk_workforce_training_session_prior_training_session_id` FOREIGN KEY (`prior_training_session_id`) REFERENCES `real_estate_ecm`.`workforce`.`training_session`(`training_session_id`);
ALTER TABLE `real_estate_ecm`.`workforce`.`training_program` ADD CONSTRAINT `fk_workforce_training_program_prerequisite_training_program_id` FOREIGN KEY (`prerequisite_training_program_id`) REFERENCES `real_estate_ecm`.`workforce`.`training_program`(`training_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `real_estate_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `real_estate_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `adp_employee_number` SET TAGS ('dbx_business_glossary_term' = 'ADP Employee Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `adp_employee_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `adp_employee_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `appraiser_credential` SET TAGS ('dbx_business_glossary_term' = 'Appraiser Credential Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `appraiser_credential` SET TAGS ('dbx_value_regex' = 'trainee|licensed|certified_residential|certified_general|none');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'passed|pending|failed|not_required');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `base_salary` SET TAGS ('dbx_business_glossary_term' = 'Base Salary');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `benefits_eligible` SET TAGS ('dbx_business_glossary_term' = 'Benefits Eligibility Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `benefits_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Benefits Enrollment Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `broker_license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Broker License Expiry Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `broker_license_number` SET TAGS ('dbx_business_glossary_term' = 'Broker License Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `broker_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `broker_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `broker_license_state` SET TAGS ('dbx_business_glossary_term' = 'Broker License State');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `broker_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'adp_workforce_now|sap_s4hana|manual');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `eeo_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Category');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `eeo_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|terminated|on_leave|suspended|pending');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|intern|temporary');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `i9_verification_status` SET TAGS ('dbx_business_glossary_term' = 'I-9 Employment Eligibility Verification Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `i9_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|expired|not_required');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `i9_verification_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'fmla|personal|medical|parental|military|none');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|semi_monthly|monthly');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `professional_designation` SET TAGS ('dbx_business_glossary_term' = 'Professional Designation');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `pto_balance_days` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Balance Days');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM User ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `work_location_name` SET TAGS ('dbx_business_glossary_term' = 'Work Location Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'property_site|regional_office|corporate_hq|remote|field');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `workforce_segment` SET TAGS ('dbx_business_glossary_term' = 'Workforce Segment');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `yardi_user_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager User ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `yardi_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employee` ALTER COLUMN `yardi_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `replaced_position_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `adp_position_code` SET TAGS ('dbx_business_glossary_term' = 'ADP Workforce Now Position ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `adp_position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Position Approved Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `budgeted_fte` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Full-Time Equivalent (FTE)');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `comp_band_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Band Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `comp_band_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,15}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `comp_band_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `comp_band_max` SET TAGS ('dbx_business_glossary_term' = 'Compensation Band Maximum');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `comp_band_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `comp_band_min` SET TAGS ('dbx_business_glossary_term' = 'Compensation Band Minimum');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `comp_band_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `competency_framework_code` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `competency_framework_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,15}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `division_name` SET TAGS ('dbx_business_glossary_term' = 'Division Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Position Effective End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Position Effective Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|intern');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `fill_status` SET TAGS ('dbx_business_glossary_term' = 'Position Fill Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `fill_status` SET TAGS ('dbx_value_regex' = 'filled|vacant|partially_filled');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt|independent_contractor');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `headcount_budget_year` SET TAGS ('dbx_business_glossary_term' = 'Headcount Budget Year');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Revenue Generating Position Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `is_safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Safety Sensitive Position Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `job_function` SET TAGS ('dbx_business_glossary_term' = 'Job Function');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `job_grade` SET TAGS ('dbx_business_glossary_term' = 'Job Grade');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `job_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,10}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `key_responsibilities` SET TAGS ('dbx_business_glossary_term' = 'Key Responsibilities');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|vacant|frozen|eliminated|pending_approval');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `primary_work_location` SET TAGS ('dbx_business_glossary_term' = 'Primary Work Location');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `required_education` SET TAGS ('dbx_business_glossary_term' = 'Required Education Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `required_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Required Experience Years');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `requires_appraiser_credential` SET TAGS ('dbx_business_glossary_term' = 'Requires Appraiser Credential Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `requires_broker_license` SET TAGS ('dbx_business_glossary_term' = 'Requires Broker License Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `requires_leed_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires Leadership in Energy and Environmental Design (LEED) Certification Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `sap_position_code` SET TAGS ('dbx_business_glossary_term' = 'SAP S/4HANA Position ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `sap_position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `target_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Target Fill Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`position` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid|field');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `benefits_eligible` SET TAGS ('dbx_business_glossary_term' = 'Benefits Eligible Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Frequency');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_value_regex' = 'Annual|Hourly|Monthly|Bi-Weekly');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `drug_test_required` SET TAGS ('dbx_business_glossary_term' = 'Drug Test Required Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `eeo_job_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Job Category');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'Full-Time|Part-Time|Contract|Temporary|Intern');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'Exempt|Non-Exempt|Highly Compensated|Independent Contractor');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_exemption_basis` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exemption Basis');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family_group` SET TAGS ('dbx_business_glossary_term' = 'Job Family Group');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_grade` SET TAGS ('dbx_business_glossary_term' = 'Job Grade');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_grade` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,3}[0-9]{1,3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_summary` SET TAGS ('dbx_business_glossary_term' = 'Job Summary');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `key_responsibilities` SET TAGS ('dbx_business_glossary_term' = 'Key Responsibilities');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `license_required` SET TAGS ('dbx_business_glossary_term' = 'License Required Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `max_compensation_usd` SET TAGS ('dbx_business_glossary_term' = 'Maximum Compensation (USD)');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `max_compensation_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `mid_compensation_usd` SET TAGS ('dbx_business_glossary_term' = 'Midpoint Compensation (USD)');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `mid_compensation_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `min_compensation_usd` SET TAGS ('dbx_business_glossary_term' = 'Minimum Compensation (USD)');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `min_compensation_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `min_education_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Requirement');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `min_education_requirement` SET TAGS ('dbx_value_regex' = 'High School Diploma|Associate Degree|Bachelor Degree|Master Degree|Doctorate|Professional Certification');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `min_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience (Years)');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `preferred_certifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Certifications');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `preferred_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Preferred Experience (Years)');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Draft|Pending Approval|Archived');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `reporting_structure` SET TAGS ('dbx_business_glossary_term' = 'Reporting Structure');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `required_license_types` SET TAGS ('dbx_business_glossary_term' = 'Required License Types');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `soc_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Occupational Classification (SOC) Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `soc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{4}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'ADP|SAP|MANUAL');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement` SET TAGS ('dbx_value_regex' = 'None|Minimal|Moderate|Frequent|Extensive');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Union Eligible Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'On-Site|Remote|Hybrid|Field-Based');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `worker_category` SET TAGS ('dbx_business_glossary_term' = 'Worker Category');
ALTER TABLE `real_estate_ecm`.`workforce`.`job_profile` ALTER COLUMN `worker_category` SET TAGS ('dbx_value_regex' = 'Employee|Contractor|Contingent Worker|Intern');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'ADP Workforce Now Organizational Unit ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_unit_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `actual_headcount_fte` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount Full-Time Equivalent (FTE)');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `actual_headcount_fte` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `budgeted_headcount_fte` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount Full-Time Equivalent (FTE)');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `budgeted_headcount_fte` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `budgeted_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Cost');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `budgeted_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `critical_role_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Role Count');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `development_gaps_summary` SET TAGS ('dbx_business_glossary_term' = 'Development Gaps Summary');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Path');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_property_level_unit` SET TAGS ('dbx_business_glossary_term' = 'Property-Level Unit Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `labor_cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Variance');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `labor_cost_variance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `licensed_staff_count` SET TAGS ('dbx_business_glossary_term' = 'Licensed Staff Count');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Notes');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `open_requisition_count` SET TAGS ('dbx_business_glossary_term' = 'Open Requisition Count');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `opex_capex_classification` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) / Capital Expenditure (CAPEX) Classification');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `opex_capex_classification` SET TAGS ('dbx_value_regex' = 'opex|capex|mixed');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|dissolved|restructuring');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `physical_location_code` SET TAGS ('dbx_business_glossary_term' = 'Physical Location Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `physical_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `physical_location_name` SET TAGS ('dbx_business_glossary_term' = 'Physical Location Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `plan_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Workforce Plan Approval Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `plan_approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|revised');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `plan_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Workforce Plan Approved By');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `plan_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Workforce Plan Approved Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `planned_attrition` SET TAGS ('dbx_business_glossary_term' = 'Planned Attrition');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `planned_hires` SET TAGS ('dbx_business_glossary_term' = 'Planned Hires');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `planning_period` SET TAGS ('dbx_business_glossary_term' = 'Workforce Planning Period');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `planning_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|H[12]|FY|M(0[1-9]|1[0-2]))$');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `primary_business_function` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Function');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `retention_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Risk Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `retention_risk_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `succession_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Succession Readiness Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `succession_readiness_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|critical_gap');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'division|department|team|cost_center|business_unit|region');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `employment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Identifier');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `tertiary_employment_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `tertiary_employment_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `tertiary_employment_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `adp_action_reference` SET TAGS ('dbx_business_glossary_term' = 'ADP Action Reference Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Appeal Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|upheld|overturned|withdrawn');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Approved Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `approving_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'annual_salary|hourly|commission|contract');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Category');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_category` SET TAGS ('dbx_value_regex' = 'career_progression|compensation|disciplinary|leave|separation|onboarding');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|completed|under_review');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `hr_business_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Initiated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `investigation_findings` SET TAGS ('dbx_business_glossary_term' = 'Investigation Findings Summary');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `leave_expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date from Leave');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave of Absence Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'fmla|medical|personal|military|parental|unpaid');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `legal_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `legal_review_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `new_compensation_rate` SET TAGS ('dbx_business_glossary_term' = 'New Compensation Rate');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `new_compensation_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `new_department` SET TAGS ('dbx_business_glossary_term' = 'New Department');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `new_employment_type` SET TAGS ('dbx_business_glossary_term' = 'New Employment Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `new_employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `new_flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'New Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `new_flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `new_job_title` SET TAGS ('dbx_business_glossary_term' = 'New Job Title');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `new_location` SET TAGS ('dbx_business_glossary_term' = 'New Work Location');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `policy_violation_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Violation Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `policy_violation_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Violation Description');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `prior_compensation_rate` SET TAGS ('dbx_business_glossary_term' = 'Prior Compensation Rate');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `prior_compensation_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `prior_department` SET TAGS ('dbx_business_glossary_term' = 'Prior Department');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `prior_employment_type` SET TAGS ('dbx_business_glossary_term' = 'Prior Employment Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `prior_employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `prior_flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Prior Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `prior_flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `prior_job_title` SET TAGS ('dbx_business_glossary_term' = 'Prior Job Title');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `prior_location` SET TAGS ('dbx_business_glossary_term' = 'Prior Work Location');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Reason Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Reason Description');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `severance_offered` SET TAGS ('dbx_business_glossary_term' = 'Severance Package Offered Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ADP_Workforce_Now|SAP_S4HANA|Manual');
ALTER TABLE `real_estate_ecm`.`workforce`.`employment_event` ALTER COLUMN `suspension_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Suspension Duration (Days)');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` SET TAGS ('dbx_subdomain' = 'compensation_administration');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `payroll_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Identifier');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `adp_run_code` SET TAGS ('dbx_business_glossary_term' = 'ADP Payroll Run ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `allowance_earnings` SET TAGS ('dbx_business_glossary_term' = 'Allowance Earnings');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `allowance_earnings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `base_salary_earnings` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Earnings');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `base_salary_earnings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `bonus_earnings` SET TAGS ('dbx_business_glossary_term' = 'Bonus Earnings');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `bonus_earnings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `commission_earnings` SET TAGS ('dbx_business_glossary_term' = 'Commission Earnings');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `commission_earnings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `employer_tax_liability` SET TAGS ('dbx_business_glossary_term' = 'Employer Tax Liability');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `employer_tax_liability` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Federal Income Tax Withheld');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `flsa_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exempt Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `gl_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posted Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `gl_posting_reference` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `gross_earnings` SET TAGS ('dbx_business_glossary_term' = 'Gross Earnings');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `gross_earnings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `hsa_deduction` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Deduction');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `hsa_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Local Income Tax Withheld');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `medical_premium_deduction` SET TAGS ('dbx_business_glossary_term' = 'Medical Insurance Premium Deduction');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `medical_premium_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax Withheld');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `net_pay` SET TAGS ('dbx_business_glossary_term' = 'Net Pay');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `net_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `overtime_earnings` SET TAGS ('dbx_business_glossary_term' = 'Overtime Earnings');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `overtime_earnings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|wire_transfer|pay_card');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `posttax_deductions_total` SET TAGS ('dbx_business_glossary_term' = 'Post-Tax Deductions Total');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `posttax_deductions_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `pretax_deductions_total` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Deductions Total');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `pretax_deductions_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `retirement_401k_deduction` SET TAGS ('dbx_business_glossary_term' = '401(k) Retirement Deduction');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `retirement_401k_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|approved|posted|voided|reversed');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regular|off_cycle|bonus|commission|correction|final');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax Withheld (OASDI)');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'State Income Tax Withheld');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `work_state_code` SET TAGS ('dbx_business_glossary_term' = 'Work State Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `work_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `ytd_federal_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Federal Tax Withheld');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `ytd_federal_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `ytd_gross_earnings` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Earnings');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `ytd_gross_earnings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `ytd_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Net Pay');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll` ALTER COLUMN `ytd_net_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` SET TAGS ('dbx_subdomain' = 'compensation_administration');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payroll_result_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Result ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payroll_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `adp_payroll_result_number` SET TAGS ('dbx_business_glossary_term' = 'ADP Payroll Result Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowance Earnings Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Approved Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Earnings Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Earnings Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `employee_type` SET TAGS ('dbx_business_glossary_term' = 'Employee Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `employee_type` SET TAGS ('dbx_value_regex' = 'salaried_exempt|salaried_nonexempt|hourly|contractor|part_time');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Federal Income Tax Withheld Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `gross_earnings_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Earnings Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `gross_earnings_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `is_void` SET TAGS ('dbx_business_glossary_term' = 'Is Void Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Local Income Tax Withheld Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax Withheld Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `overtime_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Earnings Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `overtime_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pay_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pay_type` SET TAGS ('dbx_value_regex' = 'regular|supplemental|off_cycle|final|void_replacement');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|wire_transfer|pay_card');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `posttax_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Post-Tax Deductions Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `posttax_deductions_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pretax_401k_deduction` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax 401(k) Deduction Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pretax_401k_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pretax_dental_vision_deduction` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Dental and Vision Premium Deduction Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pretax_dental_vision_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pretax_fsa_deduction` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Flexible Spending Account (FSA) Deduction Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pretax_fsa_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pretax_hsa_deduction` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Health Savings Account (HSA) Deduction Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pretax_hsa_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pretax_medical_deduction` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Medical Premium Deduction Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pretax_medical_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Result Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'calculated|approved|paid|voided|reversed');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax Withheld Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `social_security_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'State Income Tax Withheld Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `work_state_code` SET TAGS ('dbx_business_glossary_term' = 'Work State Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `work_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `ytd_federal_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Federal Income Tax Withheld');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `ytd_federal_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `ytd_gross_earnings` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Earnings');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `ytd_gross_earnings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `ytd_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Net Pay');
ALTER TABLE `real_estate_ecm`.`workforce`.`payroll_result` ALTER COLUMN `ytd_net_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'compensation_administration');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `grade_band_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Band ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_by_plan_compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Compensation Plan ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_by_plan_compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_by_plan_compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Approval Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Approval Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|expired|superseded');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Rate');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_frequency` SET TAGS ('dbx_business_glossary_term' = 'Bonus Payment Frequency');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semiannual|annual');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_max_pct` SET TAGS ('dbx_business_glossary_term' = 'Bonus Maximum Percentage');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_max_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Percentage');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `car_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Car Allowance Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `car_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `commission_basis` SET TAGS ('dbx_business_glossary_term' = 'Commission Basis');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `commission_basis` SET TAGS ('dbx_value_regex' = 'gross_sale_price|net_sale_price|lease_value|annual_rent|gross_commission_income');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `commission_schedule_ref` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Schedule Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `draw_amount` SET TAGS ('dbx_business_glossary_term' = 'Draw Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `draw_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `draw_recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Draw Recovery Method');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `draw_recovery_method` SET TAGS ('dbx_value_regex' = 'recoverable|non_recoverable');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Effective Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|independent_contractor');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `equity_eligible` SET TAGS ('dbx_business_glossary_term' = 'Equity Eligible Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `equity_grant_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Target Percentage');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `equity_grant_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Expiration Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `flsa_exemption_status` SET TAGS ('dbx_business_glossary_term' = 'FLSA Exemption Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `flsa_exemption_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt|highly_compensated');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Housing Allowance Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `license_stipend_amount` SET TAGS ('dbx_business_glossary_term' = 'License Stipend Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `license_stipend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_value_regex' = 'annual|hourly|monthly|weekly');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Description');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `salary_range_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Midpoint');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `salary_range_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'ADP|SAP|MANUAL');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `source_system_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Plan ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Version Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `workforce_segment` SET TAGS ('dbx_business_glossary_term' = 'Workforce Segment');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` SET TAGS ('dbx_subdomain' = 'compensation_administration');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Identifier');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `aca_offer_of_coverage_code` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Offer of Coverage Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `aca_offer_of_coverage_code` SET TAGS ('dbx_value_regex' = '^1[A-Z]$');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `aca_safe_harbor_code` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Safe Harbor Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `aca_safe_harbor_code` SET TAGS ('dbx_value_regex' = '^2[A-I]$');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `annual_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Deductible Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `annual_deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Carrier Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `carrier_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Plan ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `cobra_election_deadline` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Deadline Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `cobra_eligible_indicator` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_child|employee_family');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Dependent Count');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `dependent_coverage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dependent Coverage Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `disability_benefit_pct` SET TAGS ('dbx_business_glossary_term' = 'Disability Benefit Percentage');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `disability_benefit_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Benefit Eligibility Criteria');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employee_hsa_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employee Health Savings Account (HSA) Contribution Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employee_hsa_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employee_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Premium Contribution Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employee_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employer_hsa_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Health Savings Account (HSA) Contribution Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employer_hsa_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employer_match_formula` SET TAGS ('dbx_business_glossary_term' = 'Employer 401(k) Match Formula');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employer_match_max_pct` SET TAGS ('dbx_business_glossary_term' = 'Employer Maximum Match Percentage');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employer_match_max_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employer_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Premium Contribution Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `employer_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_value_regex' = 'new_hire|open_enrollment|qualifying_life_event|COBRA|rehire');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|waived|pending|terminated|COBRA_elected');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `fsa_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Flexible Spending Account (FSA) Contribution Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `fsa_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `life_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Life Insurance Coverage Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `life_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `out_of_pocket_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `out_of_pocket_max_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `plan_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `plan_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Contribution Frequency');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `retirement_employee_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Retirement Plan Employee Contribution Percentage');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `retirement_employee_contribution_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `vesting_cliff_months` SET TAGS ('dbx_business_glossary_term' = 'Vesting Cliff Period (Months)');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `vesting_full_months` SET TAGS ('dbx_business_glossary_term' = 'Full Vesting Period (Months)');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `vesting_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Vesting Schedule Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `vesting_schedule_type` SET TAGS ('dbx_value_regex' = 'immediate|cliff|graded|none');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Benefit Waiting Period (Days)');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit` ALTER COLUMN `waiver_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coverage Waiver Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'compensation_administration');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `aca_offer_type_code` SET TAGS ('dbx_business_glossary_term' = 'ACA Offer of Coverage Type Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `aca_safe_harbor_code` SET TAGS ('dbx_business_glossary_term' = 'ACA Safe Harbor Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_employee_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Employee Cost');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_employee_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_employee_cost` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_employer_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Employer Cost');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_employer_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_employer_cost` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Approved Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Member ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_election_deadline` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Deadline');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligible Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `election_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Election Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `eligibility_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Eligibility Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|temporary|contractor');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_value_regex' = 'new_hire|open_enrollment|qualifying_life_event|rehire|cobra');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'self_service|hr_admin|paper_form|api_integration|auto_enrolled');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|waived|suspended|cancelled');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `fsa_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Flexible Spending Account (FSA) Annual Election Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `fsa_election_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `fsa_election_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Benefit Group Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `has_dependent_coverage` SET TAGS ('dbx_business_glossary_term' = 'Has Dependent Coverage');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `hsa_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Contribution Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `hsa_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `hsa_contribution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Life Insurance Coverage Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `open_enrollment_period` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_value_regex' = 'marriage|birth_adoption|divorce|loss_of_coverage|death_of_dependent|other');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Benefit Waiting Period Days');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_indicator` SET TAGS ('dbx_business_glossary_term' = 'Waiver Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `real_estate_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_value_regex' = 'other_coverage|spouse_coverage|cost|ineligible|voluntary_decline|other');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'compensation_administration');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Work Assignment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `adp_time_entry_number` SET TAGS ('dbx_business_glossary_term' = 'ADP Time Entry Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'SUBMITTED|APPROVED|REJECTED|PENDING|RECALLED');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Minutes)');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `clock_in_time` SET TAGS ('dbx_business_glossary_term' = 'Clock-In Time');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `clock_out_time` SET TAGS ('dbx_business_glossary_term' = 'Clock-Out Time');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `cost_allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Type (CAPEX/OPEX)');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `cost_allocation_type` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_method` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Method');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_method` SET TAGS ('dbx_value_regex' = 'MANUAL|CLOCK_IN_OUT|MOBILE|TIMESHEET|IMPORTED');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Pay Rate');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `is_amended` SET TAGS ('dbx_business_glossary_term' = 'Is Amended Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Notes');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `pay_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `pay_code` SET TAGS ('dbx_value_regex' = 'REGULAR|OVERTIME|PTO|SICK|HOLIDAY|BEREAVEMENT');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Batch ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'DAY|EVENING|NIGHT|WEEKEND|ON_CALL');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Hours');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'compensation_administration');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Job Position ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `accommodation_notes` SET TAGS ('dbx_business_glossary_term' = 'Workplace Accommodation Notes');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `accommodation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return-to-Work Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `adp_leave_case_number` SET TAGS ('dbx_business_glossary_term' = 'ADP Leave Case Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `approved_days` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Duration (Days)');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `approved_end_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `benefits_continuation` SET TAGS ('dbx_business_glossary_term' = 'Benefits Continuation Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `coverage_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Leave Coverage Arrangement');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `coverage_arrangement` SET TAGS ('dbx_value_regex' = 'temp_hire|internal_reassignment|overtime|no_coverage|deferred');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Decision Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Denial Reason');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_premium_owed` SET TAGS ('dbx_business_glossary_term' = 'Employee Benefits Premium Owed');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_premium_owed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_designated` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Designated Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_eligible` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Eligibility Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_hours_used` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Hours Used');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `hr_notes` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Notes');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `hr_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `intermittent_frequency` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Frequency');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `intermittent_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|as_needed');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `intermittent_leave` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_status` SET TAGS ('dbx_value_regex' = 'requested|approved|denied|in_progress|returned|cancelled');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'FMLA|parental|medical|military|personal|sabbatical');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_year_type` SET TAGS ('dbx_business_glossary_term' = 'FMLA Leave Year Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_year_type` SET TAGS ('dbx_value_regex' = 'calendar_year|rolling_12_month|fixed_leave_year|rolling_forward');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `paid_leave` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `pay_continuation_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Continuation Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `pay_continuation_type` SET TAGS ('dbx_value_regex' = 'full_pay|partial_pay|unpaid|std_benefit|pto_substitution');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `requested_days` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Duration (Days)');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_clearance` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Work Medical Clearance Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submitted Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`leave_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` SET TAGS ('dbx_subdomain' = 'professional_development');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `license_certification_id` SET TAGS ('dbx_business_glossary_term' = 'License Certification ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Broker ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `adp_credential_record_code` SET TAGS ('dbx_business_glossary_term' = 'ADP Credential Record ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `alert_days_before_expiry` SET TAGS ('dbx_business_glossary_term' = 'Alert Days Before Expiry');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `ce_cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Cycle Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `ce_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Completed');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `ce_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Required');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `credential_name` SET TAGS ('dbx_business_glossary_term' = 'Credential Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `credential_number` SET TAGS ('dbx_business_glossary_term' = 'Credential Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `credential_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `credential_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `credential_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|lapsed|revoked');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `is_company_sponsored` SET TAGS ('dbx_business_glossary_term' = 'Is Company Sponsored Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `is_primary_credential` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Credential Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `jurisdiction_country` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `jurisdiction_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Credential Notes');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `primary_practice_area` SET TAGS ('dbx_business_glossary_term' = 'Primary Practice Area');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `regulatory_body_confirmation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Confirmation Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `renewal_application_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `renewal_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle Months');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `renewal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Renewal Deadline');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `renewal_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Currency');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `renewal_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|approved|lapsed|suspended');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `renewed_credential_number` SET TAGS ('dbx_business_glossary_term' = 'Renewed Credential Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `renewed_credential_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `renewed_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Renewed Expiration Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` SET TAGS ('dbx_subdomain' = 'professional_development');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `license_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'License Renewal ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `license_certification_id` SET TAGS ('dbx_business_glossary_term' = 'License ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `adp_renewal_reference` SET TAGS ('dbx_business_glossary_term' = 'ADP Renewal Reference Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `alert_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Renewal Alert Acknowledged Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `alert_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Alert Sent Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `application_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Submission Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `background_check_cleared` SET TAGS ('dbx_business_glossary_term' = 'Background Check Cleared Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `ce_ethics_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Ethics Hours Completed');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `ce_ethics_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Ethics Hours Required');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `ce_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Completed');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `ce_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Required');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `current_license_number` SET TAGS ('dbx_business_glossary_term' = 'Current License Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `current_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `employer_sponsored` SET TAGS ('dbx_business_glossary_term' = 'Employer Sponsored Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `issuing_state_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing State Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `issuing_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Renewal Fee Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'broker|salesperson|appraiser|property_manager|mortgage_originator|contractor');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `new_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'New Expiration Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `prior_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Expiration Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `regulatory_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Confirmation Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `regulatory_confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Confirmation Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `reinstatement_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Fee Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `reinstatement_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `reinstatement_required` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Required Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewal_cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Renewal Deadline Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewal_fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Paid Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewal_fee_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Payment Method');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewal_fee_payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|credit_card|online_portal|money_order');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewal_method` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Method');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewal_method` SET TAGS ('dbx_value_regex' = 'online|paper|in_person|third_party_agent');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|approved|lapsed|suspended');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewed_license_number` SET TAGS ('dbx_business_glossary_term' = 'Renewed License Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `renewed_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`license_renewal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` SET TAGS ('dbx_subdomain' = 'professional_development');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `workforce_training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Identifier');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Course Accrediting Body');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `applicable_role_group` SET TAGS ('dbx_business_glossary_term' = 'Applicable Employee Role Group');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `ce_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Credit Hours');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `cost_per_seat` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Per Seat');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `cost_per_seat` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Training Course Category');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Training Course Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `course_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Training Course Subcategory');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Training Course Title');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Format');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `delivery_format` SET TAGS ('dbx_value_regex' = 'online_self_paced|instructor_led_virtual|instructor_led_in_person|blended|webinar|on_the_job');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Course Duration Hours');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Course Effective Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `esg_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Relevant Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Course Active Status Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Course Language Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `license_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'License Type Applicability');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `lms_course_code` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Course ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `max_attempts_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Assessment Attempts Allowed');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `max_enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment Capacity');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Course Passing Score');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `prerequisite_course_codes` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Course Codes');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = 'internal|external_vendor|accredited_institution|regulatory_body');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `renewal_period_months` SET TAGS ('dbx_business_glossary_term' = 'Training Renewal Period Months');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Course Retirement Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Course Version Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`workforce_training` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` SET TAGS ('dbx_subdomain' = 'professional_development');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `license_certification_id` SET TAGS ('dbx_business_glossary_term' = 'License Certification Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_session_id` SET TAGS ('dbx_business_glossary_term' = 'Training Session ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `workforce_training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `adp_enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'ADP Enrollment Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Approval Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Approved By');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `attempts_count` SET TAGS ('dbx_business_glossary_term' = 'Assessment Attempt Count');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `ce_hours_available` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Available');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `ce_hours_earned` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Earned');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Completion Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Category');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'in-person|virtual-live|e-learning|blended|on-the-job|webinar');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `department_cost_charged` SET TAGS ('dbx_business_glossary_term' = 'Department Cost Center Charged');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Training Due Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'manager-assigned|self-enrolled|hr-assigned|system-auto|compliance-required');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|in-progress|completed|failed|withdrawn|no-show');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'mandatory|elective|recommended|regulatory');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `is_overdue` SET TAGS ('dbx_business_glossary_term' = 'Overdue Training Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `license_type_applicable` SET TAGS ('dbx_business_glossary_term' = 'Applicable License Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `max_attempts_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Assessment Attempts Allowed');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `scheduled_session_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Session Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `time_spent_hours` SET TAGS ('dbx_business_glossary_term' = 'Time Spent in Training (Hours)');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Reason');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'compensation_administration');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `adp_review_code` SET TAGS ('dbx_business_glossary_term' = 'ADP Workforce Now Review ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'HR Approval Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `bonus_recommended` SET TAGS ('dbx_business_glossary_term' = 'Bonus Recommendation Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `bonus_recommended_amount` SET TAGS ('dbx_business_glossary_term' = 'Recommended Bonus Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `bonus_recommended_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_calibration|calibrated|overridden');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|partially_meets|needs_improvement|unsatisfactory');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating Score');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_plan_summary` SET TAGS ('dbx_business_glossary_term' = 'Individual Development Plan Summary');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_plan_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Response Comments');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `goal_rating` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Rating');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `goal_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|partially_meets|needs_improvement|unsatisfactory');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `goal_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Rating Score');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `license_compliance_noted` SET TAGS ('dbx_business_glossary_term' = 'License and Credential Compliance Noted Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Performance Comments');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_pct` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_recommended` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Recommended Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|partially_meets|needs_improvement|unsatisfactory');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating Score');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_indicator` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `pre_calibration_rating` SET TAGS ('dbx_business_glossary_term' = 'Pre-Calibration Overall Rating');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `pre_calibration_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|partially_meets|needs_improvement|unsatisfactory');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommendation Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `recommended_next_role` SET TAGS ('dbx_business_glossary_term' = 'Recommended Next Role');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `retention_risk` SET TAGS ('dbx_business_glossary_term' = 'Retention Risk Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `retention_risk` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Cycle Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_source_system` SET TAGS ('dbx_business_glossary_term' = 'Review Source System');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_source_system` SET TAGS ('dbx_value_regex' = 'adp_workforce_now|manual|imported');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|pending_approval|calibrated|completed|cancelled');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|project_based|pip_checkpoint|ad_hoc');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `self_assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `succession_readiness` SET TAGS ('dbx_business_glossary_term' = 'Succession Readiness Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `succession_readiness` SET TAGS ('dbx_value_regex' = 'ready_now|ready_1_2_years|ready_3_5_years|not_identified');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `workforce_segment` SET TAGS ('dbx_business_glossary_term' = 'Workforce Segment');
ALTER TABLE `real_estate_ecm`.`workforce`.`performance_review` ALTER COLUMN `workforce_segment` SET TAGS ('dbx_value_regex' = 'property_management|brokerage|asset_management|development|corporate|facility_operations');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `superseded_by_plan_headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Headcount Plan ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `actual_filled_fte` SET TAGS ('dbx_business_glossary_term' = 'Actual Filled Full-Time Equivalent (FTE) Headcount');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `adp_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'ADP Workforce Now Plan Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budgeted_headcount_fte` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount Full-Time Equivalent (FTE)');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budgeted_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Cost');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budgeted_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `critical_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Role Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `development_gaps_summary` SET TAGS ('dbx_business_glossary_term' = 'Development Gaps Summary');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `gl_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Cost Center Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `labor_cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Variance');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `labor_cost_variance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `licensed_staff_count` SET TAGS ('dbx_business_glossary_term' = 'Licensed Staff Count');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `net_headcount_change` SET TAGS ('dbx_business_glossary_term' = 'Net Headcount Change');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `open_requisition_count` SET TAGS ('dbx_business_glossary_term' = 'Open Requisition Count');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `opex_capex_classification` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure / Capital Expenditure (OPEX/CAPEX) Classification');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `opex_capex_classification` SET TAGS ('dbx_value_regex' = 'OPEX|CAPEX|mixed');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Plan Approved By');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approved Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^HC-[A-Z0-9]{4,20}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Notes');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Approval Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|superseded');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Submitted Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|project|succession|contingency');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Version Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planned_attrition` SET TAGS ('dbx_business_glossary_term' = 'Planned Attrition');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planned_new_hires` SET TAGS ('dbx_business_glossary_term' = 'Planned New Hires');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Plan Rejection Reason');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `retention_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Retention Risk Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `retention_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `succession_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Succession Readiness Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `succession_readiness_level` SET TAGS ('dbx_value_regex' = 'ready_now|ready_1_2_years|ready_3_5_years|no_successor');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `successor_candidate_count` SET TAGS ('dbx_business_glossary_term' = 'Successor Candidate Count');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `workforce_segment` SET TAGS ('dbx_business_glossary_term' = 'Workforce Segment');
ALTER TABLE `real_estate_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `workforce_segment` SET TAGS ('dbx_value_regex' = 'property_management|asset_management|brokerage|development|corporate|facility_operations');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` SET TAGS ('dbx_subdomain' = 'compensation_administration');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `recruiting_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Identifier');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `recruiting_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `recruiting_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `recruiting_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `adp_requisition_code` SET TAGS ('dbx_business_glossary_term' = 'ADP Workforce Now Requisition ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `applicant_count` SET TAGS ('dbx_business_glossary_term' = 'Applicant Count');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `appraiser_credential_required` SET TAGS ('dbx_business_glossary_term' = 'Appraiser Credential Required Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Approval Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Approved Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `approved_headcount` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `budget_salary_max` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Salary Range Maximum');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `budget_salary_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `budget_salary_min` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Salary Range Minimum');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `budget_salary_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `eeo_job_category` SET TAGS ('dbx_business_glossary_term' = 'EEO Job Category');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|intern');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `filled_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Filled Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'FLSA Exemption Classification');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `internal_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Posting Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `job_posting_url` SET TAGS ('dbx_business_glossary_term' = 'Job Posting URL');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `min_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level Required');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `min_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional_certification');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `min_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience Required');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `primary_sourcing_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Sourcing Channel');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Requisition Priority Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `re_license_required` SET TAGS ('dbx_business_glossary_term' = 'Real Estate License Required Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `re_license_state` SET TAGS ('dbx_business_glossary_term' = 'Required Real Estate License State');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `re_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'draft|open|on_hold|filled|cancelled|closed');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'backfill|new_headcount|temporary|contract|conversion');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `target_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Target Fill Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_site|hybrid|remote');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `workforce_segment` SET TAGS ('dbx_business_glossary_term' = 'Workforce Segment');
ALTER TABLE `real_estate_ecm`.`workforce`.`recruiting` ALTER COLUMN `workforce_segment` SET TAGS ('dbx_value_regex' = 'property_management|brokerage|development|investment|corporate|facility_operations');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` SET TAGS ('dbx_subdomain' = 'compensation_administration');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `applicant_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `applicant_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `applicant_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `applicant_referral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `applicant_referral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `applicant_referral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `recruiting_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `adp_applicant_number` SET TAGS ('dbx_business_glossary_term' = 'ADP Applicant Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Staffing Agency Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `appraiser_credential` SET TAGS ('dbx_business_glossary_term' = 'Appraiser Credential Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `appraiser_credential` SET TAGS ('dbx_value_regex' = 'trainee|licensed|certified_residential|certified_general|none');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|in_progress|passed|failed|pending_review');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `current_employer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `current_job_title` SET TAGS ('dbx_business_glossary_term' = 'Current Job Title');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `current_job_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'yes|no|prefer_not_to_disclose');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `education_field_of_study` SET TAGS ('dbx_business_glossary_term' = 'Field of Study');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `eeoc_gender` SET TAGS ('dbx_business_glossary_term' = 'EEOC Gender');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `eeoc_gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_disclose');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `eeoc_gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `eeoc_gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `eeoc_race_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'EEOC Race/Ethnicity');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `eeoc_race_ethnicity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `eeoc_race_ethnicity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Email Address');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant First Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `interview_stage` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `interview_stage` SET TAGS ('dbx_value_regex' = 'not_started|phone_screen|first_round|second_round|final_round|completed');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Last Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Offer Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `offer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `offer_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Expiry Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Phone Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `professional_designations` SET TAGS ('dbx_business_glossary_term' = 'Professional Designations');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `re_license_number` SET TAGS ('dbx_business_glossary_term' = 'Real Estate License Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `re_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `re_license_state` SET TAGS ('dbx_business_glossary_term' = 'Real Estate License State');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `re_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `re_license_status` SET TAGS ('dbx_business_glossary_term' = 'Real Estate License Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `re_license_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|none');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `re_license_type` SET TAGS ('dbx_business_glossary_term' = 'Real Estate License Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `re_license_type` SET TAGS ('dbx_value_regex' = 'broker|salesperson|broker_associate|none');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `resume_reference` SET TAGS ('dbx_business_glossary_term' = 'Resume Document Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `resume_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Applicant Source Channel');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'employee_referral|job_board|agency|direct_application|career_site|social_media');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_value_regex' = 'protected_veteran|not_protected_veteran|prefer_not_to_disclose');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`applicant` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Relevant Experience');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `work_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Work Assignment ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `tertiary_work_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `tertiary_work_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `tertiary_work_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `adp_assignment_number` SET TAGS ('dbx_business_glossary_term' = 'ADP Assignment Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approval Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `assignment_basis` SET TAGS ('dbx_business_glossary_term' = 'Assignment Basis');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `assignment_basis` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|interim|secondment');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|pending|on_hold|completed|cancelled|transferred');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'property_management|leasing_territory|construction_site|asset_management_portfolio|facility_operations|development_project');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `fte_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation Percentage');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `is_leed_required` SET TAGS ('dbx_business_glossary_term' = 'LEED Certification Required Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `is_primary_assignment` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `license_required` SET TAGS ('dbx_business_glossary_term' = 'License Required Indicator');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `license_type_required` SET TAGS ('dbx_business_glossary_term' = 'Required License Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `license_type_required` SET TAGS ('dbx_value_regex' = 'broker_license|appraiser_credential|property_manager_license|contractor_license|none');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `managed_gla_sqf` SET TAGS ('dbx_business_glossary_term' = 'Managed Gross Leasable Area (GLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `opex_capex_classification` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure / Capital Expenditure (OPEX/CAPEX) Classification');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `opex_capex_classification` SET TAGS ('dbx_value_regex' = 'opex|capex|mixed');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Assignment End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `procore_assignment_ref` SET TAGS ('dbx_business_glossary_term' = 'Procore Project Assignment Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `salesforce_user_assignment_ref` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM User Assignment Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'adp_workforce_now|yardi_voyager|procore|salesforce_crm|manual');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Termination Reason');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `unit_count` SET TAGS ('dbx_business_glossary_term' = 'Managed Unit Count');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`work_assignment` ALTER COLUMN `yardi_assignment_ref` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Assignment Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` SET TAGS ('dbx_subdomain' = 'compensation_administration');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `commission_record_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Record ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `lead_attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Attribution Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `payroll_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `accrual_period` SET TAGS ('dbx_business_glossary_term' = 'Commission Accrual Period (YYYY-MM)');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `accrual_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `adp_commission_reference` SET TAGS ('dbx_business_glossary_term' = 'ADP Commission Reference Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Approval Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `clawback_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Clawback Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `clawback_reason` SET TAGS ('dbx_business_glossary_term' = 'Commission Clawback Reason');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `clawback_reason` SET TAGS ('dbx_value_regex' = 'deal_cancellation|lease_default|policy_violation|calculation_error|overpayment');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `co_broker_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Firm Name');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `co_broker_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Broker Commission Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `commission_event_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Event Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `commission_event_type` SET TAGS ('dbx_value_regex' = 'lease_commission|sale_commission|referral_fee|co_broker_split|override_commission|acquisition_commission');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `commission_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Period End Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `commission_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Period Start Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `deal_close_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Close Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `deal_transaction_value` SET TAGS ('dbx_business_glossary_term' = 'Deal Transaction Value');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `draw_balance_offset` SET TAGS ('dbx_business_glossary_term' = 'Draw Balance Offset Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `draw_balance_offset` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `draw_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Draw Against Commission Plan Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `gl_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posted Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `gl_posting_reference` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Reference');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `gross_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Commission Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `gross_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `is_1099_reportable` SET TAGS ('dbx_business_glossary_term' = '1099 Reportable Flag');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `net_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Commission Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `net_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Commission Record Notes');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `outstanding_draw_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Draw Balance Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `outstanding_draw_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Payable Commission Amount');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `payable_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Payment Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Commission Payment Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|clawed_back|voided');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `salesforce_deal_number` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Deal Number');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `split_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Percentage (PSF Split %)');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `real_estate_ecm`.`workforce`.`commission_record` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'w2_employee|independent_contractor|1099_broker');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` SET TAGS ('dbx_subdomain' = 'professional_development');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` SET TAGS ('dbx_association_edges' = 'workforce.workforce_training,workforce.job_profile');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `role_training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Role Training Requirement ID');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Role Training Requirement - Job Profile Id');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `workforce_training_id` SET TAGS ('dbx_business_glossary_term' = 'Role Training Requirement - Workforce Training Course Id');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `ce_credit_hours_applicable` SET TAGS ('dbx_business_glossary_term' = 'CE Credit Hours Applicable');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `completion_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Completion Deadline Days');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `recurrence_period_months` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Period Months');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `waiver_allowed` SET TAGS ('dbx_business_glossary_term' = 'Waiver Allowed');
ALTER TABLE `real_estate_ecm`.`workforce`.`role_training_requirement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `real_estate_ecm`.`workforce`.`grade_band` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`grade_band` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `real_estate_ecm`.`workforce`.`grade_band` ALTER COLUMN `grade_band_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Band Identifier');
ALTER TABLE `real_estate_ecm`.`workforce`.`grade_band` ALTER COLUMN `parent_grade_band_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`grade_band` ALTER COLUMN `maximum_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`grade_band` ALTER COLUMN `midpoint_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`grade_band` ALTER COLUMN `minimum_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`grade_band` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` SET TAGS ('dbx_subdomain' = 'professional_development');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` ALTER COLUMN `training_session_id` SET TAGS ('dbx_business_glossary_term' = 'Training Session Identifier');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` ALTER COLUMN `prior_training_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` ALTER COLUMN `meeting_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_session` ALTER COLUMN `total_session_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_program` SET TAGS ('dbx_subdomain' = 'professional_development');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_program` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program Identifier');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_program` ALTER COLUMN `prerequisite_training_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`workforce`.`training_program` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_confidential' = 'true');
