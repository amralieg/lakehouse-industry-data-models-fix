-- Schema for Domain: workforce | Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`workforce` COMMENT 'Human capital management for scientists, engineers, manufacturing staff, field application specialists, and corporate employees. Manages employee records, compensation, benefits, performance management, GxP training qualification records, talent acquisition, organizational hierarchies, FTE planning, and workforce analytics. Integrates Oracle Cloud HCM as the system of record.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key sourced from Oracle Cloud HCM. System of record identifier for workforce identity across all domains.',
    `manager_employee_id` BIGINT COMMENT 'Employee ID of the direct manager. Establishes hierarchical reporting relationship. Used for approval workflows, performance management, and organizational charts.',
    `clia_qualification_status` STRING COMMENT 'Current qualification status for CLIA personnel. Qualified indicates documented education, training, and competency assessment per 42 CFR 493. Pending indicates qualification in progress. Expired requires requalification. Not applicable for non-CLIA roles.. Valid values are `qualified|pending|expired|not_applicable`',
    `compensation_grade` STRING COMMENT 'Salary grade or band assigned to the employee. Determines compensation range, bonus eligibility, and equity participation. Used for pay equity analysis and market benchmarking.. Valid values are `^[A-Z0-9]{2,6}$`',
    `cost_center_code` STRING COMMENT 'Financial cost center to which employee compensation and expenses are charged. Links to SAP S/4HANA Controlling (CO) module for budgeting and variance analysis.. Valid values are `^[0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in Oracle Cloud HCM. Used for audit trail and data lineage.',
    `department_name` STRING COMMENT 'Name of the organizational department to which the employee is assigned. Reflects functional reporting structure. Examples: Sequencing Operations, Reagent Manufacturing, Clinical Genomics, Bioinformatics.',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of employee emergency. Required for workplace safety and incident response.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact. Required for workplace safety and incident response.',
    `employee_number` STRING COMMENT 'Human-readable employee number assigned by HR. Externally visible identifier used on badges, timesheets, and HR documents. Distinct from system ID.. Valid values are `^[A-Z0-9]{6,12}$`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employment relationship. Active employees have system access and payroll processing. Leave and suspended statuses retain benefits. Terminated employees are historical records.. Valid values are `active|leave_of_absence|suspended|terminated`',
    `employment_type` STRING COMMENT 'Classification of employment relationship. Determines benefits eligibility, compensation structure, and regulatory obligations. Full-Time Equivalent (FTE) planning uses this field.. Valid values are `full_time|part_time|contractor|intern|temporary`',
    `fte_percentage` DECIMAL(18,2) COMMENT 'Percentage of full-time work commitment. 100.00 for full-time, 50.00 for half-time, etc. Used for workforce capacity planning, headcount reporting, and cost allocation.',
    `hire_date` DATE COMMENT 'Date the employee commenced employment with Genomics Biotech. Used for tenure calculations, benefits vesting, and anniversary recognition. Original hire date for rehires.',
    `is_clia_personnel` BOOLEAN COMMENT 'Indicates whether the employee performs testing or supervision in a CLIA-regulated laboratory. True for laboratory directors, technical supervisors, and testing personnel in clinical genomics. Requires documented qualifications per CLIA personnel standards.',
    `is_field_application_specialist` BOOLEAN COMMENT 'Indicates whether the employee is a Field Application Specialist providing on-site customer technical support, training, and application guidance for sequencing instruments and assays.',
    `is_gxp_role` BOOLEAN COMMENT 'Indicates whether the employees role is subject to Good Practice regulations (GMP, GLP, GCP). True for manufacturing, quality, clinical, and regulatory roles requiring documented training and qualification.',
    `job_code` STRING COMMENT 'Standardized code representing the job classification. Links to compensation bands, career ladders, and job descriptions. Used for workforce planning and benchmarking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles. Examples: Research and Development (R&D), Manufacturing, Quality Assurance (QA), Bioinformatics, Field Application Specialist (FAS), Corporate Functions. Used for talent management and succession planning.',
    `job_title` STRING COMMENT 'Official job title assigned to the employee. Reflects role, seniority, and functional area. Used in organizational charts, business cards, and external communications.',
    `last_modified_by` STRING COMMENT 'Username or system identifier of the person or process that last modified the employee record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employee record. Used for change tracking, audit trail, and data synchronization.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent completed performance review. Used to track review cycles and ensure timely performance management.',
    `last_training_update_date` DATE COMMENT 'Date of the most recent training record update. Used to monitor training currency and trigger requalification workflows.',
    `legal_first_name` STRING COMMENT 'Employees legal first name as recorded in government-issued identification. Required for payroll, benefits, and regulatory compliance.',
    `legal_last_name` STRING COMMENT 'Employees legal last name as recorded in government-issued identification. Required for payroll, benefits, and regulatory compliance.',
    `performance_rating` STRING COMMENT 'Most recent annual performance review rating. Used for merit increase decisions, promotion eligibility, and talent management. Not rated for employees hired mid-cycle or on leave.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated`',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in workplace communications. May differ from legal name. Used in email signatures, badges, and internal systems.',
    `security_clearance_level` STRING COMMENT 'Level of security clearance granted to the employee for access to sensitive data, facilities, or projects. Determines access to Protected Health Information (PHI), intellectual property (IP), and restricted areas.. Valid values are `none|basic|confidential|secret`',
    `termination_date` DATE COMMENT 'Date the employment relationship ended. Null for active employees. Triggers final payroll, benefits termination, and system access revocation.',
    `termination_reason` STRING COMMENT 'Classification of the reason for employment termination. Used for turnover analysis, exit interview tracking, and regulatory reporting. Null for active employees.. Valid values are `voluntary_resignation|involuntary_termination|retirement|end_of_contract|layoff|death`',
    `training_compliance_status` STRING COMMENT 'Aggregate status of required training completion. Compliant indicates all mandatory training (GxP, safety, compliance, role-specific) is current. Overdue indicates expired or incomplete training. Critical for GxP audit readiness and regulatory compliance.. Valid values are `compliant|overdue|pending|not_required`',
    `union_membership_flag` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union. Determines applicability of collective bargaining agreements, grievance procedures, and labor relations policies.',
    `visa_expiration_date` DATE COMMENT 'Expiration date of the employees work authorization or visa. Null for citizens and permanent residents. Used to trigger renewal processes and ensure continuous work authorization.',
    `visa_status` STRING COMMENT 'Immigration and work authorization status. Determines eligibility for employment, travel restrictions, and visa sponsorship requirements. Critical for compliance with immigration laws. [ENUM-REF-CANDIDATE: citizen|permanent_resident|h1b|l1|opt|ead|other — 7 candidates stripped; promote to reference product]',
    `work_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the employees primary work location. Determines applicable labor laws, tax jurisdiction, and regulatory compliance requirements (GDPR, HIPAA, local labor codes).. Valid values are `^[A-Z]{3}$`',
    `work_email_address` STRING COMMENT 'Corporate email address assigned to the employee. Primary channel for business communication and system authentication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_location_code` STRING COMMENT 'Code identifying the primary physical work location. Examples: headquarters, manufacturing site, regional office, laboratory facility. Used for space planning, emergency response, and compliance reporting.. Valid values are `^[A-Z]{3}[0-9]{3}$`',
    `work_location_name` STRING COMMENT 'Human-readable name of the primary work location. Examples: San Diego Headquarters, Singapore Manufacturing, Cambridge R&D Lab.',
    `work_phone_number` STRING COMMENT 'Primary business phone number for the employee. May be desk phone, mobile, or extension depending on role.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Authoritative master record for all Genomics Biotech employees — scientists, bioinformaticians, engineers, manufacturing staff, field application specialists (FAS), and corporate personnel. Sourced from Oracle Cloud HCM. Captures legal name, employee number, hire date, employment type (FTE/contractor/intern), job classification, GxP-relevant role flags, CLIA personnel qualification status, work location, cost center assignment, manager hierarchy, employment status, and termination details. SSOT for workforce identity across all domains.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the position record. Primary key. Represents the atomic unit of headcount planning distinct from the person filling the role.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that bears the financial burden of this position for budgeting and P&L reporting.',
    `location_id` BIGINT COMMENT 'Reference to the primary work location (site, facility, or office) where this position is based.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department to which this position is assigned within the organizational hierarchy.',
    `reports_to_position_id` BIGINT COMMENT 'Reference to the supervisory position to which this position reports, enabling organizational hierarchy traversal.',
    `actual_filled_count` DECIMAL(18,2) COMMENT 'Current actual FTE count for this position reflecting whether it is filled, partially filled, or vacant.',
    `approved_headcount` DECIMAL(18,2) COMMENT 'Approved FTE headcount for this position by finance and executive leadership, serving as the budget baseline.',
    `budget_allocation_amount` DECIMAL(18,2) COMMENT 'Annual budget allocation for this position including salary, benefits, and overhead costs. Used for FTE spend vs. budget analysis.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget allocation amount.. Valid values are `^[A-Z]{3}$`',
    `clia_director_flag` BOOLEAN COMMENT 'Indicates whether the position is designated as a CLIA laboratory director responsible for overall operation and administration of the laboratory.',
    `clia_supervisor_flag` BOOLEAN COMMENT 'Indicates whether the position is designated as a CLIA technical supervisor or clinical consultant responsible for day-to-day supervision of testing personnel.',
    `contractor_fte_equivalent` DECIMAL(18,2) COMMENT 'FTE equivalent of contractors or temporary workers filling this position role, used for total workforce capacity planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was first created in the system for audit and compliance tracking.',
    `effective_end_date` DATE COMMENT 'Date when this position was eliminated or became inactive. Null for currently active positions.',
    `effective_start_date` DATE COMMENT 'Date when this position became active and available for assignment within the organizational structure.',
    `employment_type` STRING COMMENT 'Classification of the position by employment arrangement affecting FTE calculation and benefits eligibility.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `exempt_status` STRING COMMENT 'Classification of the position as exempt or non-exempt from overtime pay requirements under labor law.. Valid values are `exempt|non_exempt`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent value for the position used in headcount planning and budget allocation. 1.00 represents a full-time position.',
    `gxp_designated_flag` BOOLEAN COMMENT 'Indicates whether the position requires GxP training and qualification due to involvement in regulated activities (GMP, GLP, GCP). Critical for compliance tracking.',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles together for workforce planning and talent management. Examples include R&D, Manufacturing, QA, Regulatory, Clinical, Bioinformatics, Field Application Science. [ENUM-REF-CANDIDATE: research_and_development|manufacturing|quality_assurance|regulatory_affairs|clinical_operations|bioinformatics|field_application_science|sales|marketing|customer_support — 10 candidates stripped; promote to reference product]',
    `job_level` STRING COMMENT 'Hierarchical level of the position within the organization defining seniority and scope of responsibility. [ENUM-REF-CANDIDATE: individual_contributor|senior_individual_contributor|manager|senior_manager|director|senior_director|vice_president|senior_vice_president|executive — 9 candidates stripped; promote to reference product]',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this position record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was last modified for audit trail and change tracking.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for the position, critical for talent acquisition and CLIA personnel qualification requirements.. Valid values are `high_school|associate|bachelor|master|doctorate|postdoctoral`',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for the position.',
    `open_requisition_count` STRING COMMENT 'Number of active recruitment requisitions open for this position indicating hiring activity in progress.',
    `planned_headcount` DECIMAL(18,2) COMMENT 'Planned FTE headcount for this position in the current fiscal period as approved in the annual workforce planning cycle.',
    `position_code` STRING COMMENT 'Business identifier for the position used in workforce planning and reporting. Externally-known unique code for the position.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_description` STRING COMMENT 'Detailed description of the position responsibilities, qualifications, and key accountabilities used for recruitment and performance management.',
    `position_status` STRING COMMENT 'Current lifecycle state of the position indicating whether it is filled, vacant, frozen for budget reasons, or eliminated.. Valid values are `active|filled|vacant|frozen|eliminated|pending_approval`',
    `rd_capitalization_eligible_flag` BOOLEAN COMMENT 'Indicates whether costs for this position are eligible for R&D capitalization under accounting standards, critical for CFO financial reporting.',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Indicates whether the position is eligible for remote or hybrid work arrangements based on role requirements.',
    `safety_sensitive_flag` BOOLEAN COMMENT 'Indicates whether the position is designated as safety-sensitive requiring additional screening and compliance measures for GMP manufacturing or laboratory operations.',
    `title` STRING COMMENT 'Official job title for the position as defined in the organizational structure.',
    `variance_to_plan` DECIMAL(18,2) COMMENT 'Calculated variance between actual filled count and planned headcount, enabling headcount gap analysis and CFO/CHRO reporting.',
    `created_by` STRING COMMENT 'User identifier of the person who created this position record in the system.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Defines approved headcount positions within the organizational structure and serves as the atomic unit of FTE planning — distinct from the person filling the role. Position attributes: title, job family, job level, GxP-designated flag, CLIA director/supervisor designation, department, cost center, position status (filled/vacant/frozen), and effective dates. Headcount planning attributes: planned headcount by fiscal period, approved headcount, actual filled count, open requisition count, contractor FTE equivalents, variance to plan, and budget allocation. Enables headcount gap analysis, annual workforce planning cycles, R&D headcount capitalization decisions, GMP staffing compliance, and CFO/CHRO reporting on FTE spend vs. budget. Sourced from Oracle Cloud HCM Position Management and Workforce Planning.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Reference to the General Ledger (GL) cost center associated with this organizational unit for financial tracking and reporting.',
    `location_id` BIGINT COMMENT 'Reference to the physical site or facility where this organizational unit is primarily located.',
    `mdm_policy_id` BIGINT COMMENT 'Foreign key linking to data.mdm_policy. Business justification: Organizational units in genomics biotech must comply with master data management policies governing genomic data handling, retention, and quality standards. GxP-regulated units require explicit policy',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy, enabling traversal of the organizational tree structure. Null for top-level units.',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to data.retention_policy. Business justification: Org units generating genomic sequencing data, clinical test results, or research datasets must adhere to specific retention policies driven by CLIA (2 years for test records), CAP accreditation, IRB r',
    `employee_id` BIGINT COMMENT 'Reference to the employee who leads this organizational unit (department head, director, VP, etc.).',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual operating budget allocated to this organizational unit for the current fiscal year, in USD.',
    `business_unit_code` STRING COMMENT 'High-level business unit code for enterprise-wide segmentation and consolidated reporting (e.g., SEQOPS, CLINDIAG, REAGENT).. Valid values are `^[A-Z]{2,6}$`',
    `cap_accredited_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit holds College of American Pathologists (CAP) laboratory accreditation.',
    `clia_certified_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit holds Clinical Laboratory Improvement Amendments (CLIA) certification for performing clinical diagnostic testing.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where this organizational unit is primarily registered or operates (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit ceased operations or was closed. Null for currently active units.',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit became active and operational within the enterprise structure.',
    `functional_area` STRING COMMENT 'Primary business function or domain that this organizational unit supports, enabling cross-functional analytics and workforce planning. [ENUM-REF-CANDIDATE: research_development|manufacturing|quality_compliance|clinical_genomics|bioinformatics|sales_marketing|customer_support|regulatory_affairs|supply_chain|finance|human_resources|information_technology|legal|facilities — 14 candidates stripped; promote to reference product]',
    `gl_cost_center_code` STRING COMMENT 'General Ledger (GL) cost center code used for financial accounting and Profit and Loss (P&L) reporting in SAP S/4HANA.. Valid values are `^[0-9]{4,10}$`',
    `gxp_regulated_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit operates under Good Practice (GxP) regulations (GMP, GLP, GCP), requiring enhanced training, qualification, and compliance tracking.',
    `headcount_actual` STRING COMMENT 'Current actual Full-Time Equivalent (FTE) headcount assigned to this organizational unit.',
    `headcount_planned` STRING COMMENT 'Planned Full-Time Equivalent (FTE) headcount for this organizational unit, used for workforce planning and capacity analysis.',
    `internal_order_number` STRING COMMENT 'SAP internal order number used for project-based cost tracking and capital expenditure (CAPEX) management for this organizational unit.. Valid values are `^[A-Z0-9]{6,12}$`',
    `iso_13485_certified_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit operates under ISO 13485 Medical Devices Quality Management System certification.',
    `legal_entity_code` STRING COMMENT 'Legal entity identifier to which this organizational unit belongs, used for statutory reporting and compliance.. Valid values are `^[A-Z0-9]{2,8}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified in the system.',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units mission, scope, and responsibilities within Genomics Biotech.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the organizational unit office or department.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for this organizational units primary location (e.g., America/Los_Angeles, Europe/London), used for scheduling and shift management.',
    `unit_code` STRING COMMENT 'Short alphanumeric business identifier for the organizational unit, used in reporting and system integrations (e.g., NGS-OPS, BIO-ENG, GMP-MFG).. Valid values are `^[A-Z0-9]{2,12}$`',
    `unit_name` STRING COMMENT 'Full business name of the organizational unit (e.g., NGS Operations, Bioinformatics Engineering, GMP Manufacturing, Clinical Assay Development, Regulatory Affairs, Field Applications).',
    `unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit indicating whether it is operational, planned for future activation, or closed.. Valid values are `active|inactive|planned|closed`',
    `unit_type` STRING COMMENT 'Classification of the organizational unit by its hierarchical level and purpose within the enterprise structure. [ENUM-REF-CANDIDATE: department|division|lab|cost_center|business_unit|function|team — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Hierarchical organizational unit master representing departments, divisions, labs, and cost centers within Genomics Biotech — e.g., NGS Operations, Bioinformatics Engineering, GMP Manufacturing, Clinical Assay Development, Regulatory Affairs, Field Applications. Captures unit name, unit type, parent unit, unit head employee reference, GL cost center code, physical site, and effective dates. Enables org hierarchy traversal and workforce analytics by business unit.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile. Primary key for the job profile catalog.',
    `genomic_access_control_id` BIGINT COMMENT 'Foreign key linking to data.genomic_access_control. Business justification: Job profiles define baseline access rights to genomic datasets based on role requirements (e.g., bioinformatician accesses variant databases, lab technician accesses QC data only). Standard RBAC patte',
    `clia_personnel_category` STRING COMMENT 'CLIA-defined personnel category for laboratory roles performing or supervising clinical testing activities. Required for clinical genomics and diagnostic laboratory positions. [ENUM-REF-CANDIDATE: testing_personnel|technical_consultant|technical_supervisor|clinical_consultant|general_supervisor|laboratory_director|not_applicable — 7 candidates stripped; promote to reference product]',
    `compensation_grade` STRING COMMENT 'Compensation grade or band assigned to this job profile within the organizations salary structure.. Valid values are `^[A-Z0-9]{2,10}$`',
    `core_competencies` STRING COMMENT 'Comma-separated list of essential technical and behavioral competencies required for success in this job profile (e.g., NGS data analysis, CRISPR design, PCR optimization, regulatory submission, quality systems, leadership, communication).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this job profile record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this job profile version was superseded or retired. Null for currently active profiles.',
    `effective_start_date` DATE COMMENT 'Date when this job profile version became active and available for position creation and talent management activities.',
    `flsa_classification` STRING COMMENT 'Classification under the U.S. Fair Labor Standards Act determining overtime eligibility and wage-hour requirements.. Valid values are `exempt|non_exempt`',
    `fte_planning_category` STRING COMMENT 'FTE planning and budgeting category for workforce analytics and financial reporting. Aligns with cost accounting and P&L allocation.. Valid values are `direct_labor|indirect_labor|research_and_development|sales_and_marketing|general_and_administrative`',
    `gxp_role_flag` BOOLEAN COMMENT 'Indicates whether this job profile performs GxP-regulated activities requiring documented training, qualification, and ongoing competency assessment under GMP, GLP, or GCP regulations.',
    `gxp_training_requirements` STRING COMMENT 'Comma-separated list of mandatory GxP training courses and qualification activities required for personnel in this job profile (e.g., GMP fundamentals, aseptic technique, data integrity, 21 CFR Part 11, deviation management).',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles across the organization. Aligns with genomics-biotechnology functional areas including R&D, bioinformatics, clinical, manufacturing, quality, regulatory, field application, and corporate functions. [ENUM-REF-CANDIDATE: research_and_development|bioinformatics|clinical_genomics|manufacturing|quality_assurance|regulatory_affairs|field_application_science|sales|marketing|customer_support|supply_chain|finance|human_resources|information_technology|legal|executive_leadership — 16 candidates stripped; promote to reference product]',
    `job_level` STRING COMMENT 'Hierarchical level of the job profile within the organizations career ladder and compensation bands. [ENUM-REF-CANDIDATE: entry|intermediate|senior|lead|principal|manager|senior_manager|director|senior_director|vice_president|senior_vice_president|executive_vice_president|chief_officer — 13 candidates stripped; promote to reference product]',
    `last_modified_by` STRING COMMENT 'Username or identifier of the HR professional who last updated this job profile record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this job profile record was last updated in the system.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for this job profile as defined by organizational standards and regulatory requirements. [ENUM-REF-CANDIDATE: high_school|associate_degree|bachelor_degree|master_degree|doctoral_degree|postdoctoral|medical_degree|not_specified — 8 candidates stripped; promote to reference product]',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for this job profile.',
    `performance_management_template` STRING COMMENT 'Reference to the performance management template and goal-setting framework used for employees in this job profile.',
    `physical_requirements` STRING COMMENT 'Description of physical demands and working conditions for this job profile (e.g., laboratory work, cleanroom environment, extended computer use, lifting requirements, standing duration).',
    `preferred_certifications` STRING COMMENT 'Comma-separated list of professional certifications, licenses, or credentials that are preferred but not mandatory for this job profile.',
    `preferred_education_field` STRING COMMENT 'Preferred academic discipline or field of study for candidates in this job profile (e.g., molecular biology, bioinformatics, biochemistry, genetics, computer science, engineering).',
    `profile_code` STRING COMMENT 'Unique business identifier code for the job profile used across HR systems and organizational documentation.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `profile_description` STRING COMMENT 'Comprehensive description of the job profile including purpose, scope, key responsibilities, and organizational impact.',
    `profile_name` STRING COMMENT 'Official name of the job profile as recognized in the organizations job architecture and compensation structure.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the job profile indicating whether it is available for position creation and talent management activities.. Valid values are `active|inactive|draft|under_review|deprecated`',
    `regulatory_qualification_criteria` STRING COMMENT 'Specific qualification requirements mandated by regulatory bodies such as FDA, CAP, ISO 15189, or EMA for personnel performing regulated activities in this job profile.',
    `remote_work_eligibility` STRING COMMENT 'Indicates whether this job profile is eligible for remote or hybrid work arrangements based on role requirements and organizational policy.. Valid values are `fully_remote|hybrid|onsite_only`',
    `required_certifications` STRING COMMENT 'Comma-separated list of professional certifications, licenses, or credentials required for this job profile (e.g., ASCP certification, state laboratory director license, CQA, CQE, PMP, clinical genetics board certification).',
    `safety_training_requirements` STRING COMMENT 'Comma-separated list of mandatory safety training courses required for this job profile (e.g., biosafety level 2, chemical hygiene, bloodborne pathogens, laser safety, ergonomics).',
    `succession_planning_tier` STRING COMMENT 'Priority tier for succession planning and talent pipeline development based on business criticality and talent scarcity.. Valid values are `critical|high|medium|low|not_applicable`',
    `supervisory_role_flag` BOOLEAN COMMENT 'Indicates whether this job profile has direct supervisory or people management responsibilities.',
    `technical_skills` STRING COMMENT 'Comma-separated list of specific technical skills, tools, platforms, or methodologies required for this job profile (e.g., Illumina BaseSpace, Benchling, Python, R, FASTQ analysis, variant calling pipelines, SAP, LIMS).',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of work time requiring business travel. Particularly relevant for field application scientists, sales, and customer support roles.',
    `created_by` STRING COMMENT 'Username or identifier of the HR professional who created this job profile record.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Catalog of standardized job profiles defining role competencies, required qualifications, GxP training requirements, CLIA personnel category (testing personnel, technical supervisor, general supervisor, laboratory director), regulatory body qualification criteria (FDA, CAP, ISO 15189), and required certifications for each job family and level. Serves as the reference template for position creation, performance management, and training qualification planning. Sourced from Oracle Cloud HCM Job.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` (
    `workforce_assignment_id` BIGINT COMMENT 'Unique identifier for the employee assignment record. Primary key.',
    `bargaining_unit_id` BIGINT COMMENT 'Reference to the collective bargaining unit or labor union to which this assignment belongs, if applicable. Relevant for unionized manufacturing and laboratory staff.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that bears the financial responsibility for this assignment. Used for budgeting and financial reporting.',
    `grade_id` BIGINT COMMENT 'Reference to the salary grade or job grade assigned to this position. Used for compensation benchmarking and career progression planning.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile or job classification for this assignment. Defines the nature of work, responsibilities, and competencies required.',
    `location_id` BIGINT COMMENT 'Reference to the physical or virtual work location where the employee performs their duties under this assignment.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, or business unit) to which the employee is assigned.',
    `position_id` BIGINT COMMENT 'Reference to the position to which the employee is assigned. Represents the specific role within the organizational structure.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who holds this assignment. Links to the employee master record.',
    `work_schedule_id` BIGINT COMMENT 'Reference to the work schedule pattern assigned to this employee, defining standard working hours, shift patterns, and work calendar.',
    `actual_termination_date` DATE COMMENT 'The actual date on which the assignment was terminated, if different from the planned end date. Captures the real-world termination event.',
    `assignment_category` STRING COMMENT 'Employment category for this assignment indicating full-time, part-time, temporary, contract, or intern status.. Valid values are `full_time|part_time|temporary|contract|intern`',
    `assignment_name` STRING COMMENT 'A descriptive name for the assignment, typically combining the job title and organizational unit for easy identification in reports and dashboards.',
    `assignment_number` STRING COMMENT 'Human-readable business identifier for the assignment. Unique within the HCM system and used for operational reference.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment indicating whether it is active, inactive, suspended, terminated, or pending activation.. Valid values are `active|inactive|suspended|terminated|pending`',
    `assignment_type` STRING COMMENT 'Classification of the assignment indicating whether it is the employees primary role, a secondary assignment, a concurrent assignment, a contingent worker assignment, or a project-based assignment.. Valid values are `primary|secondary|concurrent|contingent|project`',
    `clia_qualified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the employee in this assignment holds CLIA qualification for performing clinical laboratory testing. Required for clinical genomics and IVD operations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `employment_type` STRING COMMENT 'The type of employment relationship for this assignment, distinguishing between employees, contractors, consultants, temporary workers, and interns.. Valid values are `employee|contractor|consultant|temporary|intern`',
    `end_date` DATE COMMENT 'The date on which the assignment ends or is scheduled to end. Null for open-ended assignments. Used for tracking assignment duration and planning succession.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The percentage of full-time equivalent effort allocated to this assignment. 100.00 represents full-time; values below 100 indicate part-time or fractional assignments. Used for workforce planning and capacity analysis.',
    `gxp_critical_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment is in a GxP-critical role requiring enhanced training, qualification, and compliance tracking per FDA, EMA, and ISO 13485 regulations.',
    `last_qualification_date` DATE COMMENT 'The date on which the employee last completed qualification training for this assignment. Used for tracking compliance with GxP and regulatory training requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this assignment record was last modified. Used for change tracking and audit compliance.',
    `next_qualification_due_date` DATE COMMENT 'The date by which the employee must complete requalification training for this assignment to maintain compliance with regulatory and quality standards.',
    `notice_period_days` STRING COMMENT 'The number of days of notice required for termination of this assignment, as defined by employment contract or policy.',
    `pay_basis` STRING COMMENT 'The basis on which the employee is compensated for this assignment: salary, hourly wage, commission, or piece rate.. Valid values are `salary|hourly|commission|piece_rate`',
    `pay_frequency` STRING COMMENT 'The frequency with which the employee is paid for this assignment: weekly, biweekly, semimonthly, or monthly.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `primary_assignment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this is the employees primary assignment. An employee may have multiple assignments, but only one can be primary.',
    `probation_end_date` DATE COMMENT 'The date on which the probationary period for this assignment ends. Used for tracking new hire performance evaluation milestones.',
    `reason` STRING COMMENT 'The business reason for creating or modifying this assignment: new hire, promotion, transfer, demotion, reorganization, project assignment, or return from leave. [ENUM-REF-CANDIDATE: new_hire|promotion|transfer|demotion|reorganization|project|return_from_leave — 7 candidates stripped; promote to reference product]',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment is eligible for remote or hybrid work arrangements. Relevant for bioinformatics, corporate, and field application specialist roles.',
    `shift_pattern` STRING COMMENT 'The shift pattern for this assignment indicating day shift, evening shift, night shift, rotating shifts, flexible schedule, or on-call status. Critical for manufacturing and laboratory operations.. Valid values are `day|evening|night|rotating|flexible|on_call`',
    `source_system_code` STRING COMMENT 'The identifier of the assignment record in the source system (Oracle Cloud HCM). Used for data lineage and reconciliation between operational and analytical systems.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'The standard number of hours per week the employee is expected to work under this assignment. Used for time tracking, payroll, and capacity planning.',
    `start_date` DATE COMMENT 'The date on which the employee began this assignment. Marks the effective start of the assignment relationship.',
    `training_qualification_status` STRING COMMENT 'Current status of the employees training and qualification for this assignment. Tracks whether the employee is fully qualified, undergoing training, has expired qualifications, or does not require qualification.. Valid values are `qualified|in_training|expired|not_required`',
    `travel_required_percentage` DECIMAL(18,2) COMMENT 'The percentage of time this assignment requires business travel. Critical for field application specialists, sales, and customer support roles.',
    CONSTRAINT pk_workforce_assignment PRIMARY KEY(`workforce_assignment_id`)
) COMMENT 'Tracks the active and historical assignment of an employee to a specific position, org unit, job profile, work schedule, and cost center at any point in time. Captures assignment start/end dates, assignment type (primary/secondary), FTE percentage, work location, shift pattern, and assignment status. Supports workforce planning, org change tracking, and cross-functional project staffing. Sourced from Oracle Cloud HCM Employment Assignment.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`compensation` (
    `compensation_id` BIGINT COMMENT 'Unique identifier for the compensation record. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee ID of the manager or HR representative who approved this compensation change. Null if not yet approved. Supports audit and compliance requirements.',
    `compensation_employee_id` BIGINT COMMENT 'Reference to the employee receiving this compensation. Links to the employee master record in Oracle Cloud HCM.',
    `compensation_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.compensation_plan. Business justification: Compensation records belong to a defined compensation plan. Adding compensation_plan_id creates the necessary inbound link for the compensation_plan reference table, eliminates duplicate plan_code and',
    `approval_date` DATE COMMENT 'Date when the compensation change was approved. Null if not yet approved. Supports audit trails and compliance reporting.',
    `approval_status` STRING COMMENT 'Current approval status of the compensation record (draft, pending_approval, approved, rejected, cancelled). Tracks the compensation approval workflow.. Valid values are `draft|pending_approval|approved|rejected|cancelled`',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Annual base salary amount for salaried employees or hourly rate for hourly employees. Restricted due to salary sensitivity and personal financial information.',
    `change_reason_code` STRING COMMENT 'Reason code for the compensation change (promotion, merit increase, market adjustment, equity refresh, new_hire, transfer, demotion, cost_of_living adjustment, retention, correction). Supports compensation analytics and audit trails. [ENUM-REF-CANDIDATE: promotion|merit|market_adjustment|equity_refresh|new_hire|transfer|demotion|cost_of_living|retention|correction — 10 candidates stripped; promote to reference product]',
    `change_reason_description` STRING COMMENT 'Detailed description or notes explaining the compensation change. Provides additional context beyond the change reason code.',
    `compa_ratio` DECIMAL(18,2) COMMENT 'Comparative ratio expressing the employees compensation as a percentage of the midpoint of the pay grade range (e.g., 95.00 means 95% of midpoint). Used for compensation equity analysis. Confidential business metric.',
    `compensation_type` STRING COMMENT 'Type of compensation component (base_salary for salaried employees, hourly_wage for manufacturing staff, variable_pay for performance-based pay, equity_grant for RSUs/options, shift_differential for GMP manufacturing staff, field_allowance for field application specialists, bonus, commission). [ENUM-REF-CANDIDATE: base_salary|hourly_wage|variable_pay|equity_grant|shift_differential|field_allowance|bonus|commission — 8 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'Cost center code for financial accounting and budgeting purposes. Links compensation expense to the general ledger and financial reporting. Integrates with SAP S/4HANA FI/CO.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compensation record was first created in the source system. Supports audit trails and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, EUR, GBP, JPY, CNY). Supports global workforce across multiple geographies.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Code identifying the department or organizational unit for this compensation record (e.g., RD_SEQUENCING, MFG_REAGENT, SALES_CLINICAL). Supports departmental compensation analytics and budgeting.. Valid values are `^[A-Z0-9_]{3,15}$`',
    `effective_end_date` DATE COMMENT 'Date when this compensation record ceases to be effective. Null for current active compensation records. Supports historical tracking.',
    `effective_start_date` DATE COMMENT 'Date when this compensation record becomes effective. Supports historical tracking of compensation changes over time.',
    `employment_type` STRING COMMENT 'Type of employment relationship (full_time, part_time, contractor, temporary, intern). Determines eligibility for benefits and compensation components.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `equity_grant_quantity` STRING COMMENT 'Number of equity units granted (shares for RSUs, options for stock options). Null if no equity grant. Restricted due to personal financial information.',
    `equity_grant_type` STRING COMMENT 'Type of equity compensation granted (RSU for Restricted Stock Units, stock_option for stock options, ESPP for Employee Stock Purchase Plan, none if no equity). Confidential compensation data.. Valid values are `rsu|stock_option|espp|none`',
    `equity_grant_value` DECIMAL(18,2) COMMENT 'Fair market value of the equity grant at the time of grant. Calculated as quantity multiplied by grant price. Restricted due to salary sensitivity.',
    `field_allowance_amount` DECIMAL(18,2) COMMENT 'Monthly or annual allowance for field application specialists covering travel, mobile devices, and customer site expenses. Null if not applicable. Confidential compensation data.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'Full-Time Equivalent percentage for this compensation record (100.00 for full-time, 50.00 for half-time, etc.). Used for workforce planning and FTE analytics.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active compensation record for the employee (True) or a historical record (False). Simplifies queries for current compensation.',
    `job_code` STRING COMMENT 'Code identifying the job role associated with this compensation record (e.g., SCI_GENOMICS, ENG_BIOINFO, MFG_TECH, FSE_CLINICAL). Links compensation to job classification and organizational structure.. Valid values are `^[A-Z0-9_]{3,15}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compensation record was last modified in the source system. Supports change tracking and audit requirements.',
    `pay_frequency` STRING COMMENT 'Frequency at which the employee is paid (weekly, biweekly, semimonthly, monthly, annual). Determines payroll cycle and disbursement schedule.. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `pay_grade` STRING COMMENT 'Pay grade or salary band assigned to this compensation record (e.g., E1, E2, M3, S5, T7). Determines the salary range and eligibility for benefits. Confidential business classification data.. Valid values are `^[A-Z0-9]{1,10}$`',
    `review_cycle` STRING COMMENT 'Identifier for the compensation review cycle or merit cycle during which this compensation was set or adjusted (e.g., 2024_ANNUAL_MERIT, 2024_Q2_PROMO). Supports compensation planning and analytics.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional hourly rate paid for non-standard shifts (night shift, weekend shift) for GMP (Good Manufacturing Practice) manufacturing staff. Null if not applicable. Confidential compensation data.',
    `source_system_code` STRING COMMENT 'Unique identifier from the source system (Oracle Cloud HCM Compensation Management). Used for data lineage, reconciliation, and integration traceability.. Valid values are `^[A-Z0-9_]{1,50}$`',
    `variable_pay_amount` DECIMAL(18,2) COMMENT 'Target variable pay amount (annual bonus, commission, or performance-based incentive). Null if not applicable to this compensation record. Restricted due to salary sensitivity.',
    `variable_pay_percentage` DECIMAL(18,2) COMMENT 'Variable pay as a percentage of base salary (e.g., 15.00 for 15% target bonus). Used for executive and sales roles. Confidential business data.',
    CONSTRAINT pk_compensation PRIMARY KEY(`compensation_id`)
) COMMENT 'Stores current and historical compensation records for each employee — base salary, variable pay, equity grants (RSUs/options), shift differentials for GMP manufacturing staff, and field application specialist allowances. Captures compensation plan, pay grade, pay frequency, currency, effective date, and change reason (promotion, merit, market adjustment, equity refresh). Sourced from Oracle Cloud HCM Compensation Management. Restricted classification due to salary sensitivity.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment record. Primary key for the benefit enrollment entity.',
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan in which the employee is enrolled. Links to the benefit plan catalog.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee enrolling in the benefit plan. Links to the employee master record.',
    `approval_date` DATE COMMENT 'Date on which the enrollment was approved. Nullable if approval is not required or still pending.',
    `approval_status` STRING COMMENT 'Status of managerial or HR approval for the enrollment. Approved indicates enrollment is authorized; pending approval indicates awaiting review; rejected indicates enrollment was denied; not required indicates no approval workflow applies.. Valid values are `approved|pending_approval|rejected|not_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the HR administrator or manager who approved the enrollment. Nullable if approval is not required or still pending.',
    `beneficiary_name` STRING COMMENT 'Full legal name of the primary beneficiary designated by the employee to receive benefits in the event of the employees death. Applicable to life insurance and retirement plans. Nullable if no beneficiary is designated.',
    `beneficiary_percentage` DECIMAL(18,2) COMMENT 'Percentage of benefit proceeds allocated to the primary beneficiary. Must sum to 100 across all beneficiaries for a given enrollment. Nullable if no beneficiary is designated.',
    `beneficiary_relationship` STRING COMMENT 'Relationship of the beneficiary to the employee, such as spouse, child, parent, sibling, or other. Nullable if no beneficiary is designated.',
    `benefit_provider_name` STRING COMMENT 'Name of the insurance carrier or third-party administrator providing the benefit coverage, such as Aetna, Blue Cross Blue Shield, Fidelity, or Principal Financial.',
    `benefit_provider_policy_number` STRING COMMENT 'Policy or group number assigned by the benefit provider to identify the employer group plan. Used for claims processing and provider coordination.',
    `cobra_election_deadline` DATE COMMENT 'Date by which the employee must elect COBRA continuation coverage. Typically 60 days from the qualifying event or notice date. Nullable if COBRA is not applicable.',
    `cobra_eligible_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the employee is eligible for COBRA continuation coverage upon termination of employment or loss of eligibility. True if eligible; false otherwise. Applicable to health, dental, and vision plans.',
    `confirmation_sent_date` DATE COMMENT 'Date on which the enrollment confirmation was sent to the employee via email or mail. Used to track communication and compliance with notification requirements.',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are deducted and remitted. Aligns with payroll cycle.. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Total dollar value of coverage provided by the benefit plan, such as life insurance face value, disability benefit maximum, or annual FSA/HSA contribution limit. Nullable for plans without a defined coverage amount.',
    `coverage_tier` STRING COMMENT 'Level of coverage elected by the employee. Employee only covers the employee; employee+spouse covers employee and spouse/domestic partner; employee+children covers employee and dependent children; family covers employee, spouse, and children.. Valid values are `employee_only|employee_spouse|employee_children|family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit enrollment record was first created in the system. Used for audit trail and data lineage.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the employee must pay out-of-pocket before insurance coverage begins. Applicable to health, dental, and vision plans. Nullable for plans without deductibles.',
    `dependent_count` STRING COMMENT 'Number of dependents covered under this enrollment. Applicable to family coverage tiers. Zero for employee-only coverage.',
    `effective_end_date` DATE COMMENT 'Date on which the benefit coverage ends. Nullable for active enrollments with no predetermined end date. Populated when employee terminates, changes plans, or reaches plan expiration.',
    `effective_start_date` DATE COMMENT 'Date on which the benefit coverage becomes active and the employee is eligible to use the benefit. May differ from enrollment date due to waiting periods or plan year start dates.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employee contributes per pay period toward the benefit premium or plan cost. Deducted from employee paycheck.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employer contributes per pay period toward the benefit premium or plan cost. Represents employer-funded portion of benefit.',
    `enrollment_date` DATE COMMENT 'Date on which the employee submitted the benefit enrollment election. This is the transaction date when the enrollment was recorded in the system.',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment confirmation number provided to the employee upon successful enrollment.',
    `enrollment_reason` STRING COMMENT 'Business reason or trigger for the enrollment. Open enrollment is the annual election period; new hire is initial enrollment upon employment; qualifying life event includes marriage, birth, adoption, divorce; annual renewal is automatic continuation; plan change is mid-year modification; rehire is re-enrollment after termination and return.. Valid values are `open_enrollment|new_hire|qualifying_life_event|annual_renewal|plan_change|rehire`',
    `enrollment_source` STRING COMMENT 'Channel or method through which the enrollment was submitted. Employee self-service indicates online portal; HR administrator indicates manual entry by HR staff; benefits broker indicates third-party enrollment; call center indicates phone enrollment; paper form indicates scanned document; automated import indicates system integration.. Valid values are `employee_self_service|hr_administrator|benefits_broker|call_center|paper_form|automated_import`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the benefit enrollment. Active indicates the enrollment is in effect; pending indicates awaiting approval or effective date; waived indicates employee declined coverage; terminated indicates coverage has ended; suspended indicates temporary hold; cancelled indicates enrollment was voided.. Valid values are `active|pending|waived|terminated|suspended|cancelled`',
    `hipaa_certification_date` DATE COMMENT 'Date on which the employee completed HIPAA privacy and security training as required for enrollment in health-related benefits. Ensures compliance with Protected Health Information (PHI) regulations.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified the enrollment record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit enrollment record was last updated. Used for audit trail and change tracking.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum annual amount the employee will pay out-of-pocket for covered services before the plan pays 100 percent. Applicable to health insurance plans. Nullable for plans without out-of-pocket maximums.',
    `plan_type` STRING COMMENT 'Category of benefit plan. Health includes medical insurance; dental includes dental insurance; vision includes vision insurance; life includes life insurance; disability includes short-term and long-term disability; retirement includes 401(k) and pension plans; FSA is Flexible Spending Account; HSA is Health Savings Account. [ENUM-REF-CANDIDATE: health|dental|vision|life|disability|retirement|fsa|hsa — 8 candidates stripped; promote to reference product]',
    `provider_enrollment_date` DATE COMMENT 'Date on which the enrollment was transmitted to and confirmed by the benefit provider. May differ from internal enrollment date due to processing lag.',
    `qualifying_event_date` DATE COMMENT 'Date on which the qualifying life event occurred. Used to validate enrollment timing and eligibility. Nullable if enrollment is not due to a qualifying event.',
    `qualifying_event_type` STRING COMMENT 'Specific type of qualifying life event that triggered mid-year enrollment or change, such as marriage, divorce, birth, adoption, loss of other coverage, or change in employment status. Nullable if enrollment is not due to a qualifying event.',
    `termination_reason` STRING COMMENT 'Reason for termination of the benefit enrollment, such as employee termination, plan change, loss of eligibility, non-payment, or voluntary cancellation. Nullable for active enrollments.',
    `waiver_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the employee explicitly waived (declined) this benefit. True if waived; false if enrolled. Used to track opt-out decisions for compliance and reporting.',
    `waiver_reason` STRING COMMENT 'Explanation provided by the employee for waiving the benefit, such as coverage through spouse, other employer coverage, cost, or personal preference. Nullable if benefit is not waived.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Records employee enrollment in benefit plans — health insurance, dental, vision, life insurance, 401(k)/pension, FSA/HSA, and supplemental benefits. Captures plan type, coverage tier (employee only, employee+spouse, family), enrollment date, effective date, waiver status, and benefit provider. Tracks open enrollment elections and qualifying life event changes. Sourced from Oracle Cloud HCM Benefits Administration.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` (
    `gxp_training_record_id` BIGINT COMMENT 'Unique identifier for the GxP training record. Primary key for the training record entity.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who last modified this training record. Part of the audit trail for regulatory compliance.',
    `controlled_document_id` BIGINT COMMENT 'Identifier of the document-controlled Standard Operating Procedure (SOP) or work instruction that is the subject of this training. Links to the document management system (MasterControl) for version control and audit trail.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: GxP training for bioinformatics personnel must document which reference genome build (GRCh37, GRCh38, T2T-CHM13) they are qualified to analyze. CLIA/CAP regulations require version-specific competency',
    `primary_gxp_employee_id` BIGINT COMMENT 'Identifier of the employee who completed or is assigned this training. Links to the employee master record in Oracle Cloud HCM.',
    `quality_rule_id` BIGINT COMMENT 'Foreign key linking to data.quality_rule. Business justification: GxP training records document personnel qualification for executing quality-controlled genomic assay processes (e.g., NGS library prep, variant calling). Quality rules validate that only qualified per',
    `quaternary_gxp_waiver_approved_by_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the training waiver. Links to the employee master record. Required for audit trail when training is waived.',
    `quinary_gxp_created_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who created this training record. Part of the audit trail for regulatory compliance.',
    `tertiary_gxp_assessor_employee_id` BIGINT COMMENT 'Identifier of the employee who assessed or evaluated the training completion. Links to the employee master record. May be different from the trainer for independent assessment.',
    `training_item_id` BIGINT COMMENT 'Identifier of the specific training item or course completed. Links to the training item master that defines the training content, version, and requirements.',
    `workforce_training_curriculum_id` BIGINT COMMENT 'Identifier of the training curriculum to which this training record belongs. Links to the curriculum definition that specifies required training items, sequencing, and regulatory basis.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved on the training assessment or examination. Typically expressed as a percentage (0.00 to 100.00). Used to determine pass/fail status against minimum passing score requirements.',
    `assessor_name` STRING COMMENT 'Full name of the assessor who evaluated the training completion. Captured for audit trail and compliance documentation.',
    `assignment_date` DATE COMMENT 'Date when the training was assigned to the employee. Used to track compliance with assignment rules and turnaround time (TAT) for training completion.',
    `cap_accreditation_flag` BOOLEAN COMMENT 'Indicates whether this training is required for CAP accreditation. True for training that supports CAP laboratory accreditation standards.',
    `clia_required_flag` BOOLEAN COMMENT 'Indicates whether this training is required for CLIA compliance. True for training that qualifies personnel to perform clinical laboratory testing under CLIA regulations (42 CFR 493).',
    `completion_date` DATE COMMENT 'Date when the employee successfully completed the training item. This is the principal business event timestamp for the training record lifecycle.',
    `completion_status` STRING COMMENT 'Current lifecycle status of the training record. Values: assigned (training assigned but not started), in_progress (training started but not completed), completed (training finished, awaiting assessment), passed (training completed and assessment passed), failed (training completed but assessment failed), expired (qualification expired and requalification required), waived (training requirement waived by authorized personnel), cancelled (training assignment cancelled). [ENUM-REF-CANDIDATE: assigned|in_progress|completed|passed|failed|expired|waived|cancelled — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was first created in the system. Part of the audit trail for regulatory compliance.',
    `delivery_method` STRING COMMENT 'Method by which the training was delivered. Values: classroom (in-person instructor-led), online (e-learning or web-based), on_the_job (hands-on training at workstation), blended (combination of methods), self_paced (independent study), webinar (live virtual instructor-led), simulation (virtual or physical simulation), practical_demonstration (hands-on demonstration and evaluation). [ENUM-REF-CANDIDATE: classroom|online|on_the_job|blended|self_paced|webinar|simulation|practical_demonstration — 8 candidates stripped; promote to reference product]',
    `due_date` DATE COMMENT 'Date by which the training must be completed. Used to monitor compliance with training schedules and regulatory requirements.',
    `gxp_critical_flag` BOOLEAN COMMENT 'Indicates whether this training is GxP-critical and subject to heightened regulatory scrutiny and documentation requirements. True for training that qualifies personnel to perform activities that directly impact product quality, patient safety, or data integrity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was last modified. Part of the audit trail for regulatory compliance and change tracking.',
    `pass_fail_status` STRING COMMENT 'Indicates whether the employee passed or failed the training assessment. Values: pass (assessment passed), fail (assessment failed), not_assessed (training completed but no assessment required), pending (assessment not yet completed).. Valid values are `pass|fail|not_assessed|pending`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training assessment. Typically expressed as a percentage (0.00 to 100.00). Used to determine qualification status.',
    `qualification_effective_date` DATE COMMENT 'Date when the qualification becomes effective. Typically the completion date for initial qualifications, or the requalification date for renewals. Used to determine when personnel are authorized to perform GxP-critical activities.',
    `qualification_expiry_date` DATE COMMENT 'Date when the qualification expires and requalification is required. Calculated based on the qualification effective date and the requalification frequency defined in the curriculum. Critical for maintaining GxP compliance and personnel authorization.',
    `regulatory_basis` STRING COMMENT 'Primary regulatory framework or standard that mandates this training. Values: gmp (Good Manufacturing Practice), glp (Good Laboratory Practice), gcp (Good Clinical Practice), clia (Clinical Laboratory Improvement Amendments), cap (College of American Pathologists), iso_13485 (ISO 13485 Medical Devices Quality Management), iso_15189 (ISO 15189 Medical Laboratories Quality and Competence), fda_21_cfr_part_11 (FDA 21 CFR Part 11 Electronic Records), fda_21_cfr_part_211 (FDA 21 CFR Part 211 Current Good Manufacturing Practice), gdpr (General Data Protection Regulation), hipaa (Health Insurance Portability and Accountability Act), other (other regulatory basis). [ENUM-REF-CANDIDATE: gmp|glp|gcp|clia|cap|iso_13485|iso_15189|fda_21_cfr_part_11|fda_21_cfr_part_211|gdpr|hipaa|other — 12 candidates stripped; promote to reference product]',
    `requalification_due_date` DATE COMMENT 'Date by which requalification training must be completed to maintain continuous qualification status. Typically set before the qualification expiry date to allow time for completion.',
    `requalification_frequency_months` STRING COMMENT 'Number of months between required requalification training cycles. Defined by the curriculum and regulatory requirements. Common values include 12 (annual), 24 (biennial), or 36 (triennial) months.',
    `sop_document_number` STRING COMMENT 'Document control number of the Standard Operating Procedure (SOP) or work instruction that is the subject of this training. Used for traceability and audit purposes.',
    `trainer_name` STRING COMMENT 'Full name of the trainer who delivered the training. Captured for audit trail and compliance documentation.',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training in hours. Used for tracking training investment, Full-Time Equivalent (FTE) planning, and compliance with minimum training hour requirements.',
    `training_item_code` STRING COMMENT 'Business code or catalog number for the training item. Examples include NGS-OPS-101 for Next-Generation Sequencing Operator Qualification, GMP-MFG-201 for Good Manufacturing Practice Manufacturing Technician Curriculum, CLIA-LAB-301 for Clinical Laboratory Improvement Amendments Testing Personnel Qualification.',
    `training_item_title` STRING COMMENT 'Full title or name of the training item or course. Examples include NGS Operator Qualification, GMP Manufacturing Technician Curriculum, CLIA Testing Personnel Qualification, CRISPR Lab Safety Program.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was delivered. Examples include facility name, room number, or online platform name.',
    `training_notes` STRING COMMENT 'Free-text notes or comments about the training completion. May include observations from the trainer or assessor, special circumstances, or additional context for the training record.',
    `training_version` STRING COMMENT 'Version number or revision identifier of the training item completed. Critical for GxP compliance to ensure personnel are trained on the current version of Standard Operating Procedures (SOPs) and work instructions.',
    `waiver_approval_date` DATE COMMENT 'Date when the training waiver was approved. Required for audit trail when training is waived.',
    `waiver_reason` STRING COMMENT 'Explanation for why the training requirement was waived. Populated only when completion_status is waived. Requires documented justification and approval for GxP compliance.',
    CONSTRAINT pk_gxp_training_record PRIMARY KEY(`gxp_training_record_id`)
) COMMENT 'GxP-critical training qualification lifecycle management — encompassing curriculum definitions, assignment rules, and individual completion records. Curriculum layer: defines structured training curricula required for specific job profiles, GxP roles, and regulatory qualifications (e.g., NGS Operator Qualification, GMP Manufacturing Technician Curriculum, CLIA Testing Personnel Qualification, CRISPR Lab Safety Program) with required training items, sequencing rules, requalification frequency, regulatory basis (GMP/GLP/GCP/CLIA/CAP), and curriculum owner. Record layer: captures individual training item completion (version, completion date, assessment score, pass/fail status, qualification expiry, requalification due date, trainer/assessor identity, delivery method). Supports FDA 21 CFR Part 211.25 personnel qualification, ISO 13485 competency requirements, CLIA personnel standards (42 CFR 493), and CAP accreditation. Integrates with MasterControl for document-controlled SOPs and Oracle Cloud HCM Learning.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` (
    `workforce_training_curriculum_id` BIGINT COMMENT 'Unique identifier for the training curriculum record. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Organizational unit responsible for this curriculum (e.g., Quality Assurance, Training Department, Manufacturing Operations).',
    `genomic_access_control_id` BIGINT COMMENT 'Foreign key linking to data.genomic_access_control. Business justification: Training curricula (GxP, CLIA, HIPAA, data privacy) establish qualification prerequisites for accessing sensitive genomic datasets. Access control policies reference required training completion (e.g.',
    `document_id` BIGINT COMMENT 'Reference identifier to the source curriculum document in MasterControl document management system.',
    `employee_id` BIGINT COMMENT 'Employee responsible for maintaining and updating this curriculum.',
    `applicable_job_profiles` STRING COMMENT 'Comma-separated list or structured description of job profiles, roles, or position codes for which this curriculum is required (e.g., NGS Operator, Manufacturing Technician II, Clinical Lab Director).',
    `approval_date` DATE COMMENT 'Date when this curriculum was formally approved for use.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether formal assessment or testing is required to complete this curriculum.',
    `cap_required_flag` BOOLEAN COMMENT 'Indicates whether this curriculum is mandatory for CAP-accredited laboratory personnel.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether a formal certification or qualification certificate is issued upon successful completion.',
    `certification_name` STRING COMMENT 'Name of the certification or qualification awarded upon curriculum completion. Null if no certification is issued.',
    `clia_required_flag` BOOLEAN COMMENT 'Indicates whether this curriculum is mandatory for CLIA-certified laboratory personnel.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this curriculum record was first created in the system.',
    `curriculum_code` STRING COMMENT 'Unique business identifier code for the training curriculum, used for external reference and system integration.. Valid values are `^[A-Z0-9]{6,20}$`',
    `curriculum_name` STRING COMMENT 'Full descriptive name of the training curriculum (e.g., NGS Operator Qualification, GMP Manufacturing Technician Curriculum, CLIA Testing Personnel Qualification).',
    `curriculum_status` STRING COMMENT 'Current lifecycle status of the training curriculum.. Valid values are `draft|under_review|approved|active|retired|obsolete`',
    `curriculum_type` STRING COMMENT 'Classification of the curriculum by its primary purpose and structure.. Valid values are `initial_qualification|requalification|continuing_education|role_based|regulatory_compliance|technical_skills`',
    `effective_end_date` DATE COMMENT 'Date when this curriculum version is no longer effective. Null for currently active curricula.',
    `effective_start_date` DATE COMMENT 'Date when this curriculum version becomes effective and available for assignment.',
    `estimated_completion_hours` DECIMAL(18,2) COMMENT 'Estimated total time in hours required to complete all training items in this curriculum.',
    `gcp_required_flag` BOOLEAN COMMENT 'Indicates whether this curriculum is mandatory for Good Clinical Practice compliance.',
    `glp_required_flag` BOOLEAN COMMENT 'Indicates whether this curriculum is mandatory for Good Laboratory Practice compliance.',
    `gmp_required_flag` BOOLEAN COMMENT 'Indicates whether this curriculum is mandatory for Good Manufacturing Practice compliance.',
    `gxp_regulated_flag` BOOLEAN COMMENT 'Indicates whether this curriculum is required for GxP-regulated roles (GMP, GLP, GCP compliance).',
    `iso_13485_required_flag` BOOLEAN COMMENT 'Indicates whether this curriculum is mandatory for ISO 13485 medical device quality management system compliance.',
    `last_modified_by` STRING COMMENT 'User or system account that last modified this curriculum record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this curriculum record was last modified.',
    `last_review_date` DATE COMMENT 'Date when this curriculum was last reviewed for accuracy and regulatory compliance.',
    `mandatory_items_count` STRING COMMENT 'Number of training items within this curriculum that are mandatory for completion.',
    `minimum_passing_score_percent` DECIMAL(18,2) COMMENT 'Minimum percentage score required to pass curriculum assessments. Null if no assessment is required.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this curriculum.',
    `practical_demonstration_required_flag` BOOLEAN COMMENT 'Indicates whether hands-on practical demonstration of skills is required as part of this curriculum.',
    `prerequisites` STRING COMMENT 'Description of any prerequisite qualifications, experience, or prior training required before enrolling in this curriculum.',
    `regulatory_basis` STRING COMMENT 'Detailed description of the regulatory framework(s) and specific requirements that mandate this curriculum (e.g., FDA 21 CFR Part 820, CLIA 42 CFR 493.1489, ISO 13485:2016 Clause 6.2).',
    `requalification_frequency_months` STRING COMMENT 'Number of months between required requalification cycles. Null if requalification is not required.',
    `requalification_required_flag` BOOLEAN COMMENT 'Indicates whether periodic requalification is required after initial curriculum completion.',
    `review_frequency_months` STRING COMMENT 'Number of months between required curriculum reviews to ensure continued relevance and compliance.',
    `sequencing_rules` STRING COMMENT 'Structured description of the order and dependencies in which training items must be completed (e.g., prerequisite requirements, parallel vs sequential completion).',
    `target_audience_description` STRING COMMENT 'Detailed description of the intended audience for this curriculum, including role characteristics, experience level, and functional area.',
    `total_training_items_count` STRING COMMENT 'Total number of individual training items (courses, modules, assessments) included in this curriculum.',
    `version_number` STRING COMMENT 'Version number of this curriculum (e.g., 1.0, 2.1) to track curriculum revisions and updates.. Valid values are `^[0-9]+.[0-9]+$`',
    `workforce_training_curriculum_description` STRING COMMENT 'Comprehensive description of the curriculum purpose, scope, learning objectives, and business context.',
    `created_by` STRING COMMENT 'User or system account that created this curriculum record.',
    CONSTRAINT pk_workforce_training_curriculum PRIMARY KEY(`workforce_training_curriculum_id`)
) COMMENT 'Defines structured training curricula required for specific job profiles, GxP roles, and regulatory qualifications — e.g., NGS Operator Qualification, GMP Manufacturing Technician Curriculum, CLIA Testing Personnel Qualification, CRISPR Lab Safety Program. Captures curriculum name, applicable job profiles, required training items, sequencing rules, requalification frequency, regulatory basis (GMP/GLP/GCP/CLIA/CAP), and curriculum owner. Sourced from MasterControl.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key for the performance review entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed. Links to the employee master record in Oracle Cloud HCM.',
    `review_cycle_id` BIGINT COMMENT 'Identifier of the performance review cycle (e.g., FY2024 Annual Review, Q2 2024 Mid-Year Review). Links to the review cycle configuration.',
    `bonus_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for performance bonus based on review results. True if performance meets bonus criteria, False otherwise. Used for incentive compensation planning.',
    `calibration_date` DATE COMMENT 'Date when the performance rating was calibrated in the calibration session. Used to track calibration timeline and ensure consistency across the organization.',
    `calibration_status` STRING COMMENT 'Status indicating whether the performance rating has been through calibration session. Values: not_calibrated (review not yet calibrated), calibration_scheduled (calibration session scheduled), calibrated (rating confirmed through calibration), calibration_adjusted (rating adjusted during calibration).. Valid values are `not_calibrated|calibration_scheduled|calibrated|calibration_adjusted`',
    `collaboration_competency_rating` STRING COMMENT 'Rating for collaboration and teamwork competencies including cross-functional collaboration, communication effectiveness, and stakeholder engagement.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was first created in the system. Used for audit trail and data lineage.',
    `development_areas_summary` STRING COMMENT 'Summary of areas where the employee needs development or improvement. Informs individual development plans and training recommendations.',
    `employee_acknowledgment_date` DATE COMMENT 'Date when the employee acknowledged receipt and review of their performance evaluation. Required for review cycle closure and compliance.',
    `employee_self_assessment` STRING COMMENT 'Employees self-assessment narrative describing their accomplishments, challenges, goal achievement, and development needs during the review period.',
    `flight_risk_indicator` STRING COMMENT 'Assessment of the employees risk of voluntary turnover based on performance review discussions, engagement signals, and manager assessment. Values: low (low risk of departure), medium (moderate risk), high (high risk), critical (imminent risk of departure). Used for retention planning.. Valid values are `low|medium|high|critical`',
    `goal_achievement_percentage` DECIMAL(18,2) COMMENT 'Percentage of goals achieved by the employee during the review period. Calculated as (goals_achieved_count / goals_total_count) * 100. Key metric for performance evaluation.',
    `goals_achieved_count` STRING COMMENT 'Number of goals fully achieved by the employee during the review period. Used to calculate goal achievement rate and inform overall performance rating.',
    `goals_total_count` STRING COMMENT 'Total number of goals assigned to the employee for the review period. Used to calculate goal achievement rate.',
    `high_potential_flag` BOOLEAN COMMENT 'Indicates whether the employee is identified as high potential talent based on performance, competencies, and leadership potential. True if designated as HiPo, False otherwise. Used for talent development and retention strategies.',
    `hr_approval_date` DATE COMMENT 'Date when the performance review was approved by HR. Final step in the review workflow before archival.',
    `innovation_competency_rating` STRING COMMENT 'Rating for innovation and continuous improvement competencies including process optimization, creative problem-solving, and contribution to R&D initiatives.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was last modified. Used for audit trail and change tracking.',
    `leadership_competency_rating` STRING COMMENT 'Rating for leadership competencies including people management, strategic thinking, decision-making, and team development. Applicable to managers and individual contributors demonstrating leadership.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `manager_narrative` STRING COMMENT 'Detailed narrative feedback provided by the manager summarizing the employees performance, accomplishments, areas for improvement, and development recommendations. Supports the overall rating and competency assessments.',
    `merit_increase_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for merit-based salary increase based on performance rating. True if performance meets merit increase criteria, False otherwise. Used for compensation planning.',
    `merit_increase_percentage` DECIMAL(18,2) COMMENT 'Recommended merit increase percentage based on performance rating and calibration. Used by compensation team for salary adjustment decisions. Confidential business data.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the employees next performance review. Typically 6 or 12 months from the current review completion date.',
    `overall_rating` STRING COMMENT 'Overall performance rating assigned to the employee for the review period. Values: exceeds_expectations (consistently exceeds performance expectations), meets_expectations (meets all performance expectations), needs_improvement (performance below expectations, improvement required), unsatisfactory (performance significantly below expectations), outstanding (exceptional performance, far exceeds expectations).. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score corresponding to the overall performance rating. Typically on a scale of 1.0 to 5.0, where higher scores indicate better performance. Used for merit increase calculations and talent analytics.',
    `pip_recommended_flag` BOOLEAN COMMENT 'Indicates whether a Performance Improvement Plan is recommended for the employee due to unsatisfactory performance. True if PIP is recommended, False otherwise. Triggers HR intervention and formal improvement process.',
    `pre_calibration_rating` STRING COMMENT 'Original overall performance rating assigned by the manager before calibration session. Retained for audit trail and calibration analysis.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `promotion_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for promotion based on performance review results. True if performance meets or exceeds promotion criteria, False otherwise. Used for talent review and succession planning.',
    `review_completion_date` DATE COMMENT 'Date when the performance review was completed and finalized by the manager. Marks the end of the review workflow.',
    `review_period_end_date` DATE COMMENT 'End date of the performance period being evaluated. Typically the end of the fiscal year or review cycle.',
    `review_period_start_date` DATE COMMENT 'Start date of the performance period being evaluated. Typically the beginning of the fiscal year or review cycle.',
    `review_status` STRING COMMENT 'Current workflow status of the performance review. Values: draft (review initiated but not started), self_assessment_pending (awaiting employee self-assessment), manager_review_pending (awaiting manager evaluation), calibration_pending (awaiting calibration session), completed (review finalized), approved (review approved by HR), archived (review archived after cycle closure). [ENUM-REF-CANDIDATE: draft|self_assessment_pending|manager_review_pending|calibration_pending|completed|approved|archived — 7 candidates stripped; promote to reference product]',
    `review_type` STRING COMMENT 'Type of performance review conducted. Values: annual (annual performance review), mid_year (mid-year checkpoint review), probationary (probationary period review), project_based (project completion review), promotion (promotion evaluation), pip (Performance Improvement Plan review).. Valid values are `annual|mid_year|probationary|project_based|promotion|pip`',
    `strengths_summary` STRING COMMENT 'Summary of the employees key strengths and areas of excellence identified during the review. Used for talent development and succession planning.',
    `succession_readiness_level` STRING COMMENT 'Assessment of the employees readiness for succession to higher-level roles. Values: ready_now (ready for immediate promotion), ready_1_year (ready within 1 year with development), ready_2_3_years (ready within 2-3 years with development), not_ready (not ready for advancement), not_applicable (role not in succession planning scope). Used for talent pipeline and succession planning.. Valid values are `ready_now|ready_1_year|ready_2_3_years|not_ready|not_applicable`',
    `technical_competency_rating` STRING COMMENT 'Rating for technical competencies specific to the employees role (e.g., NGS sequencing expertise, bioinformatics pipeline development, GMP manufacturing knowledge, regulatory submission proficiency). Evaluates domain-specific technical skills.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `weighted_goal_score` DECIMAL(18,2) COMMENT 'Weighted average score of all goals based on goal weights and achievement levels. Calculated by summing (goal_weight * goal_achievement_score) for all goals. Used in overall performance rating calculation.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Performance management lifecycle records encompassing review cycles, goal management, and evaluation. Captures annual/mid-year reviews (overall rating, competency ratings, calibration status, manager narrative), individual and team goals (goal title, goal type, weight, target metric, measurement unit, target value, actual value, goal status, alignment to corporate OKR, review cycle), and goal achievement scoring. Goals include genomics-specific targets such as NGS throughput, reagent yield improvement, regulatory submission milestones, and FAS NPS improvement. Supports merit increase decisions, promotion eligibility, talent development planning, and strategic alignment tracking. Sourced from Oracle Cloud HCM Performance and Goal Management.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`goal` (
    `goal_id` BIGINT COMMENT 'Unique identifier for the performance goal record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically a manager or executive) who approved this goal for inclusion in the performance plan.',
    `goal_employee_id` BIGINT COMMENT 'Reference to the employee who owns this goal. For individual goals, this is the goal owner. For team goals, this may reference the team lead or be null.',
    `goal_manager_employee_id` BIGINT COMMENT 'Reference to the manager who approved or is responsible for overseeing this goal.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit to which this goal is aligned. Used for team and departmental goals.',
    `achievement_percentage` DECIMAL(18,2) COMMENT 'Percentage of goal achievement calculated as (actual_value / target_value) * 100. Values over 100% indicate over-achievement; values under 100% indicate partial achievement.',
    `actual_completion_date` DATE COMMENT 'Actual date on which the goal was completed or achieved. Null if the goal is still in progress or was not completed.',
    `actual_value` DECIMAL(18,2) COMMENT 'Actual achieved value of the metric at the time of measurement or goal completion. Compared against target_value to determine goal attainment percentage.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the goal was formally approved and activated.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Starting or baseline value of the metric at the beginning of the goal period. Used to calculate improvement or delta against the target.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the goal record was first created in the system.',
    `employee_self_assessment` STRING COMMENT 'Self-assessment comments provided by the employee regarding their own progress, challenges, and achievements toward the goal.',
    `goal_category` STRING COMMENT 'Functional category of the goal. Operational goals relate to day-to-day performance; strategic goals align to long-term business objectives; development goals focus on skill-building; compliance goals ensure regulatory adherence; innovation goals drive R&D and new capabilities; quality goals target process improvement and defect reduction.. Valid values are `operational|strategic|development|compliance|innovation|quality`',
    `goal_code` STRING COMMENT 'Business identifier or code for the goal, often used for tracking and reporting purposes. May follow organizational naming conventions such as FY24-NGS-001.',
    `goal_description` STRING COMMENT 'Detailed description of the goal, including context, rationale, and any specific deliverables or milestones.',
    `goal_status` STRING COMMENT 'Current lifecycle status of the goal. Draft goals are being defined; active goals are approved and in effect; in_progress goals have begun execution; completed goals have been achieved and closed; cancelled goals were terminated before completion; deferred goals are postponed to a future period.. Valid values are `draft|active|in_progress|completed|cancelled|deferred`',
    `goal_type` STRING COMMENT 'Classification of the goal by scope and ownership. Individual goals are owned by a single employee; team goals are shared across a team; departmental goals align to an organizational unit; corporate goals cascade from executive strategy; stretch goals are aspirational targets beyond standard expectations.. Valid values are `individual|team|departmental|corporate|stretch`',
    `gxp_related_flag` BOOLEAN COMMENT 'Indicates whether this goal is related to Good Practice (GxP) compliance activities such as Good Manufacturing Practice (GMP), Good Laboratory Practice (GLP), or Good Clinical Practice (GCP). True if the goal involves GxP-regulated processes or deliverables.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the goal record was last updated or modified.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the goal was last reviewed or assessed by the manager or employee during a check-in or formal review.',
    `manager_comments` STRING COMMENT 'Qualitative feedback and comments provided by the manager regarding goal progress, achievement, or challenges. Used during performance reviews and mid-cycle check-ins.',
    `measurement_type` STRING COMMENT 'Method by which goal achievement is measured. Quantitative goals have numeric targets; qualitative goals are assessed subjectively; milestone goals are measured by completion of specific deliverables; binary goals are either achieved or not achieved.. Valid values are `quantitative|qualitative|milestone|binary`',
    `measurement_unit` STRING COMMENT 'Unit of measure for the target metric. Examples: gigabases per day (Gb/day), percentage (%), count, score (0-100), days, USD, FTE (Full-Time Equivalent).',
    `okr_alignment` STRING COMMENT 'Reference to the corporate or departmental Objective and Key Result (OKR) to which this goal is aligned. Ensures cascading alignment from strategic objectives to individual performance.',
    `performance_rating` STRING COMMENT 'Final performance rating assigned to this goal upon completion or review. Exceeds expectations indicates over-achievement; meets expectations indicates target achievement; partially meets indicates partial achievement; does not meet indicates failure to achieve threshold; not rated indicates the goal has not yet been evaluated.. Valid values are `exceeds_expectations|meets_expectations|partially_meets|does_not_meet|not_rated`',
    `priority` STRING COMMENT 'Business priority level of the goal. Critical goals are mission-critical and must be achieved; high priority goals are important but not blocking; medium and low priority goals are secondary objectives.. Valid values are `critical|high|medium|low`',
    `rd_capitalization_eligible_flag` BOOLEAN COMMENT 'Indicates whether work performed toward this goal is eligible for Research and Development (R&D) capitalization under accounting standards. True if the goal involves development of capitalizable intellectual property or product enhancements.',
    `regulatory_milestone_flag` BOOLEAN COMMENT 'Indicates whether this goal represents a regulatory submission or approval milestone, such as FDA (Food and Drug Administration) submission, EMA (European Medicines Agency) approval, CE-IVD (Conformité Européenne In Vitro Diagnostic) certification, or CLIA (Clinical Laboratory Improvement Amendments) accreditation.',
    `review_cycle` STRING COMMENT 'Performance review cycle or period to which this goal belongs. Examples: FY2024 Annual Review, Q2 2024 Quarterly Review, H1 2024 Mid-Year Review.',
    `review_period_end_date` DATE COMMENT 'End date of the performance review period. Goals are typically evaluated and closed at or before this date.',
    `review_period_start_date` DATE COMMENT 'Start date of the performance review period during which this goal is active and measured.',
    `strategic_pillar` STRING COMMENT 'High-level strategic pillar or theme to which this goal contributes. Examples: Innovation Leadership, Operational Excellence, Customer Success, Regulatory Compliance, Talent Development.',
    `stretch_target_value` DECIMAL(18,2) COMMENT 'Optional aspirational target value beyond the standard target, used for stretch goals or exceptional performance recognition.',
    `target_completion_date` DATE COMMENT 'Planned or target date by which the goal should be achieved. May differ from review_period_end_date for milestone-based goals.',
    `target_metric` STRING COMMENT 'The specific metric or Key Performance Indicator (KPI) being measured. Examples: NGS Throughput (Gb/day), Reagent Yield (%), Regulatory Submission Count, Net Promoter Score (NPS), Time to Market (days), Cost of Goods Sold (COGS) per unit.',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target value to be achieved for quantitative goals. For example, 15.0 for a 15% improvement target, 85.0 for an NPS score target, 500.0 for a throughput target in Gb/day.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Minimum acceptable value for goal achievement. Performance below this threshold may be considered unsatisfactory.',
    `title` STRING COMMENT 'Short, descriptive title of the performance goal. Examples: Increase NGS Throughput by 15%, Complete CRISPR Assay Validation, Achieve NPS Score of 85+.',
    `visibility_level` STRING COMMENT 'Defines who can view this goal. Private goals are visible only to the employee and manager; manager-visible goals are shared with the reporting chain; team-visible goals are shared with team members; department-visible goals are shared across the organizational unit; public goals are visible company-wide.. Valid values are `private|manager|team|department|public`',
    `weight_percentage` DECIMAL(18,2) COMMENT 'Relative weight or importance of this goal in the employees overall performance evaluation, expressed as a percentage. Typically sums to 100% across all goals for an individual in a review cycle.',
    CONSTRAINT pk_goal PRIMARY KEY(`goal_id`)
) COMMENT 'Individual and team performance goals aligned to Genomics Biotech strategic objectives — e.g., NGS throughput targets, reagent yield improvement, regulatory submission milestones, NPS improvement for field application specialists. Captures goal title, goal type (individual/team/corporate), weight, target metric, measurement unit, target value, actual value, goal status, alignment to corporate OKR, and review cycle. Sourced from Oracle Cloud HCM Goal Management.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` (
    `talent_profile_id` BIGINT COMMENT 'Unique identifier for the talent profile record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee whose talent profile this record represents. Links to the employee master record in Oracle Cloud HCM.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Bioinformatics talent profiles track primary proficiency with specific genome builds (hg19, GRCh38, T2T-CHM13). Essential for project staffing decisions, capability gap analysis, and succession planni',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database. Business justification: Clinical genomics personnel profiles track expertise with specific variant databases (ClinVar, gnomAD, COSMIC). Critical for assigning variant interpretation work, ensuring analysts use databases they',
    `abmgg_certified_flag` BOOLEAN COMMENT 'Indicates whether the employee holds ABMGG certification in clinical genetics or genomics, required for genetic counselors and clinical geneticists.',
    `additional_languages` STRING COMMENT 'Comma-separated list of additional languages the employee is proficient in, supporting international operations and field application support.',
    `ascp_certified_flag` BOOLEAN COMMENT 'Indicates whether the employee holds ASCP certification (e.g., MLS, MT, MB), a recognized credential for clinical laboratory professionals.',
    `bioinformatics_pipeline_proficiency` STRING COMMENT 'Employees skill level in developing and maintaining bioinformatics pipelines for genomic data processing, variant calling, and annotation.. Valid values are `none|basic|intermediate|advanced|expert`',
    `career_aspiration` STRING COMMENT 'Free-text description of the employees stated career goals and aspirations, used for development planning and succession management.',
    `clia_personnel_category` STRING COMMENT 'The CLIA personnel qualification category the employee meets, required for clinical laboratory roles under CLIA regulations.. Valid values are `director|technical_supervisor|clinical_consultant|general_supervisor|testing_personnel|not_applicable`',
    `clinical_assay_validation_proficiency` STRING COMMENT 'Employees skill level in clinical assay validation processes, essential for IVD and LDT development under CLIA and FDA regulations.. Valid values are `none|basic|intermediate|advanced|expert`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this talent profile record was first created in the system, supporting audit trail and data lineage.',
    `crispr_editing_proficiency` STRING COMMENT 'Employees skill level in CRISPR gene editing techniques, critical for gene editing tool development and research applications.. Valid values are `none|basic|intermediate|advanced|expert`',
    `critical_talent_flag` BOOLEAN COMMENT 'Indicates whether the employee possesses rare or mission-critical skills that are difficult to replace, requiring retention focus.',
    `development_plan_status` STRING COMMENT 'Current status of the employees individual development plan, tracking progress toward skill and competency goals.. Valid values are `not_started|in_progress|completed|on_hold`',
    `education_field` STRING COMMENT 'Primary field or discipline of the employees highest degree (e.g., Molecular Biology, Bioinformatics, Biochemistry, Mechanical Engineering, Computer Science). Essential for matching talent to genomics-specific roles.',
    `flight_risk_indicator` STRING COMMENT 'Assessment of the employees likelihood to leave the organization, based on engagement surveys, tenure, and market factors.. Valid values are `low|medium|high`',
    `geographic_mobility_preference` STRING COMMENT 'Employees stated willingness to relocate for career opportunities, critical for succession planning and internal mobility programs.. Valid values are `not_mobile|local|regional|national|international`',
    `gmp_experience_flag` BOOLEAN COMMENT 'Indicates whether the employee has hands-on experience working in GMP-regulated manufacturing environments, required for reagent and consumable production roles.',
    `graduation_year` STRING COMMENT 'Year the employee completed their highest degree, used for experience calculation and career progression analysis.',
    `gxp_training_current_flag` BOOLEAN COMMENT 'Indicates whether the employees GxP training qualifications (GMP, GLP, GCP) are current and up-to-date, mandatory for regulated roles.',
    `high_potential_flag` BOOLEAN COMMENT 'Indicates whether the employee has been identified as a high-potential talent for accelerated development and leadership roles.',
    `highest_education_level` STRING COMMENT 'The highest level of formal education attained by the employee, critical for role qualification and succession planning in scientific and technical positions.. Valid values are `high_school|associate|bachelor|master|doctorate|postdoctoral`',
    `institution_name` STRING COMMENT 'Name of the university or institution where the highest degree was obtained, relevant for academic pedigree assessment in research-intensive roles.',
    `language_proficiency_level` STRING COMMENT 'Overall language proficiency level for additional languages, used to assess readiness for international assignments and customer interactions.. Valid values are `basic|conversational|professional|native`',
    `last_competency_assessment_date` DATE COMMENT 'Date of the most recent formal competency assessment, ensuring skills and qualifications are current for GxP and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this talent profile record was last modified, supporting audit trail and change tracking for compliance.',
    `lims_proficiency` STRING COMMENT 'Employees skill level in using LIMS platforms (e.g., LabVantage) for sample tracking, workflow management, and laboratory operations.. Valid values are `none|basic|intermediate|advanced|expert`',
    `next_competency_assessment_due_date` DATE COMMENT 'Scheduled date for the next competency assessment, ensuring ongoing qualification for regulated roles and continuous skill validation.',
    `ngs_library_prep_proficiency` STRING COMMENT 'Employees skill level in NGS library preparation techniques, a core competency for laboratory scientists in genomics sequencing operations.. Valid values are `none|basic|intermediate|advanced|expert`',
    `patents_count` STRING COMMENT 'Number of patents filed or granted with the employee as inventor, indicating innovation contribution and intellectual property generation.',
    `pmp_certified_flag` BOOLEAN COMMENT 'Indicates whether the employee holds PMP certification, valuable for project managers overseeing product development and commercialization initiatives.',
    `preferred_career_path` STRING COMMENT 'The employees preferred career trajectory (technical vs. managerial), informing development and succession planning decisions.. Valid values are `individual_contributor|people_management|technical_leadership|executive_leadership|cross_functional`',
    `primary_language` STRING COMMENT 'The employees primary working language, important for global collaboration and customer-facing roles.',
    `professional_certifications` STRING COMMENT 'Comma-separated list of additional professional certifications held by the employee (e.g., Six Sigma, Lean, AWS Certified Solutions Architect, Certified Quality Engineer).',
    `profile_last_updated_date` DATE COMMENT 'Date when the talent profile was last updated by the employee or HR, ensuring data currency for talent decisions.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the talent profile record indicating whether it is actively maintained, under review, or archived.. Valid values are `active|inactive|pending_review|archived`',
    `publications_count` STRING COMMENT 'Number of peer-reviewed scientific publications authored or co-authored by the employee, relevant for research scientists and thought leadership roles.',
    `qpcr_proficiency` STRING COMMENT 'Employees skill level in qPCR techniques, a foundational molecular biology competency for genomics research and quality control.. Valid values are `none|basic|intermediate|advanced|expert`',
    `relocation_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is currently eligible for company-sponsored relocation based on tenure, performance, and business need.',
    `skills_gap_analysis_date` DATE COMMENT 'Date of the most recent skills gap analysis conducted for this employee, used to track development needs and training effectiveness.',
    `succession_planning_readiness` STRING COMMENT 'Assessment of the employees readiness to assume higher-level or critical roles, used for talent pipeline and succession planning.. Valid values are `not_ready|ready_1_2_years|ready_now|emergency_ready`',
    `variant_calling_proficiency` STRING COMMENT 'Employees skill level in variant calling and interpretation from sequencing data, critical for clinical genomics and research applications.. Valid values are `none|basic|intermediate|advanced|expert`',
    CONSTRAINT pk_talent_profile PRIMARY KEY(`talent_profile_id`)
) COMMENT 'Captures the skills, competencies, certifications, educational background, and career aspirations of each employee — including genomics-specific competencies (NGS library prep, bioinformatics pipeline development, CRISPR editing, clinical assay validation), professional certifications (ASCP, ABMGG, PMP), advanced degrees, language proficiency, and mobility preferences. Supports succession planning, internal mobility, and skills gap analysis. Sourced from Oracle Cloud HCM Talent Profile.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Unique identifier for the talent acquisition requisition record. Primary key for the requisition entity.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile defining role requirements, competencies, compensation grade, and GxP training requirements for this requisition.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, or functional area) where the position resides.',
    `position_id` BIGINT COMMENT 'Reference to the approved position record this requisition is filling. Links to organizational structure and headcount planning.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the user who created this requisition record. Typically the hiring manager or recruiter initiating the hiring request.',
    `requisition_hiring_manager_employee_id` BIGINT COMMENT 'Employee identifier of the hiring manager responsible for candidate selection and final hiring decision.',
    `requisition_last_modified_by_employee_id` BIGINT COMMENT 'Employee identifier of the user who last updated this requisition record. Supports change tracking and audit compliance.',
    `requisition_recruiter_employee_id` BIGINT COMMENT 'Employee identifier of the talent acquisition specialist or recruiter assigned to manage the candidate pipeline for this requisition.',
    `approval_date` DATE COMMENT 'Date the requisition received final headcount and budget approval from authorized approvers (hiring manager, finance, HR). Marks transition from draft to approved status.',
    `approved_headcount` STRING COMMENT 'Number of positions approved for hire under this requisition. Typically 1, but may be greater for bulk hiring initiatives (e.g., manufacturing scale-up, field application specialist expansion).',
    `clia_personnel_category` STRING COMMENT 'CLIA personnel classification for clinical laboratory roles: director (laboratory director), technical supervisor, clinical consultant, testing personnel, or not applicable (non-CLIA role). Determines regulatory qualification and oversight requirements.. Valid values are `director|technical_supervisor|clinical_consultant|testing_personnel|not_applicable`',
    `close_date` DATE COMMENT 'Date the requisition was closed (filled, cancelled, or withdrawn). End point for time-to-fill KPI calculation.',
    `compensation_grade` STRING COMMENT 'Internal compensation grade or band assigned to this requisition. Determines salary range, bonus eligibility, and equity participation. Confidential business data not disclosed to candidates during initial screening.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this requisition record was first created in Oracle Cloud HCM Recruiting. Used for audit trail and requisition aging analysis.',
    `eeo_job_category` STRING COMMENT 'EEO-1 job category classification for regulatory reporting to the U.S. Equal Employment Opportunity Commission. Required for diversity and inclusion compliance reporting. [ENUM-REF-CANDIDATE: executive|manager|professional|technician|sales|administrative|craft|operative|laborer|service — 10 candidates stripped; promote to reference product]',
    `employment_type` STRING COMMENT 'Classification of employment relationship: full-time employee (FTE), part-time employee, contractor, temporary worker, or intern.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation for this requisition. 1.00 represents full-time; 0.50 represents half-time. Used for workforce planning and budget calculations.',
    `gxp_designated_flag` BOOLEAN COMMENT 'Indicates whether this position is designated as a GxP role requiring compliance with Good Manufacturing Practice (GMP), Good Laboratory Practice (GLP), or Good Clinical Practice (GCP) regulations. Triggers mandatory GxP training and qualification requirements.',
    `internal_posting_flag` BOOLEAN COMMENT 'Indicates whether this requisition is posted internally for current employee applications before external posting. Supports internal mobility and career development programs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this requisition record. Used for audit trail, data freshness assessment, and change tracking.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for the role: high school diploma, associate degree, bachelor degree, master degree, PhD, or postdoctoral training. Critical for scientific and engineering roles in genomics.. Valid values are `high_school|associate|bachelor|master|phd|postdoc`',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for the role. Used for candidate screening and qualification assessment.',
    `open_date` DATE COMMENT 'Date the requisition was opened and made available for candidate applications. Start point for time-to-fill KPI calculation.',
    `posting_description` STRING COMMENT 'Detailed job description published to external candidates, including responsibilities, qualifications, required skills, and company overview. Optimized for candidate attraction and employer branding.',
    `posting_location_description` STRING COMMENT 'Geographic location description displayed in job postings. May include city, state, country, or remote designation. Used for candidate filtering and location-based search.',
    `posting_title` STRING COMMENT 'External-facing job title displayed on career sites, job boards, and recruiting channels. May differ from internal position title for market competitiveness.',
    `primary_sourcing_channel` STRING COMMENT 'Primary recruitment channel or platform used to source candidates for this requisition: LinkedIn, Indeed, Glassdoor, employee referral, campus recruiting, staffing agency, company career site, or professional network (e.g., scientific societies). [ENUM-REF-CANDIDATE: linkedin|indeed|glassdoor|referral|campus|agency|career_site|professional_network — 8 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Business priority classification for filling this requisition: critical (business-critical role, immediate need), high (important for operations), medium (standard priority), or low (opportunistic hire). Drives recruiter resource allocation.. Valid values are `critical|high|medium|low`',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Indicates whether the position is eligible for remote or hybrid work arrangements. Impacts candidate sourcing geography and workplace flexibility offerings.',
    `requisition_number` STRING COMMENT 'Business-facing unique requisition identifier displayed to hiring managers, recruiters, and candidates. Externally visible requisition code.. Valid values are `^REQ-[0-9]{6,10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the requisition: draft (being prepared), pending approval (awaiting headcount authorization), approved (authorized but not yet posted), open (actively recruiting), on hold (temporarily paused), filled (candidate hired), cancelled (no longer needed), or closed (completed process). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|open|on_hold|filled|cancelled|closed — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the requisition purpose: new headcount creation, replacement for departed employee, backfill for leave, contractor-to-FTE conversion, intern program, or temporary assignment.. Valid values are `new_position|replacement|backfill|contractor_conversion|intern|temporary`',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for salary range (e.g., USD, EUR, GBP). Supports global recruiting operations across multiple countries.. Valid values are `^[A-Z]{3}$`',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'Maximum annual base salary for the position in the specified currency. Represents top of compensation band for highly experienced candidates.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'Minimum annual base salary for the position in the specified currency. Used for budget planning and candidate offer preparation. May be disclosed in jurisdictions with pay transparency laws.',
    `target_start_date` DATE COMMENT 'Desired start date for the new hire. Used for workforce planning, onboarding preparation, and time-to-fill metrics.',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from requisition open date to requisition close date (hire completion). Key recruiting efficiency KPI and talent acquisition performance metric.',
    `total_applicants` STRING COMMENT 'Total number of candidates who applied to this requisition. Used for recruiting funnel analytics and sourcing effectiveness measurement.',
    `total_hires` STRING COMMENT 'Number of candidates who accepted offers and were successfully hired under this requisition. Final funnel conversion metric.',
    `total_interviewed` STRING COMMENT 'Number of candidates who participated in formal interviews (phone screen, video, or onsite). Key recruiting funnel stage metric.',
    `total_offers_extended` STRING COMMENT 'Number of formal employment offers extended to candidates for this requisition. Used to calculate offer acceptance rate and hiring efficiency.',
    `total_screened` STRING COMMENT 'Number of candidates who passed initial resume screening and were advanced to recruiter or hiring manager review. Funnel conversion metric.',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of work time requiring business travel. Particularly relevant for field application scientists, sales roles, and clinical support specialists who visit customer sites.',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Talent acquisition lifecycle record encompassing the approved headcount request and full candidate pipeline management. Requisition layer: captures requisition number, position reference, job profile, hiring manager, recruiter, requisition type, target start date, approved headcount, sourcing channels, status, and time-to-fill metrics. Candidate layer: manages applicant/candidate master records including candidate name, source channel (LinkedIn, referral, job board, campus), application date, applied position, candidate status through pipeline stages (applied/screened/interviewed/offered/hired/rejected/withdrawn), interview progression, offer details, background check status, and EEO data. Candidate records are distinct from employee records created upon hire. Sourced from Oracle Cloud HCM Recruiting.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`candidate` (
    `candidate_id` BIGINT COMMENT 'Unique identifier for the candidate record in the talent acquisition pipeline. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee record created upon hire. Links the candidate record to the employee master record.',
    `candidate_hiring_manager_employee_id` BIGINT COMMENT 'Identifier of the hiring manager responsible for the position to which the candidate applied.',
    `candidate_recruiter_employee_id` BIGINT COMMENT 'Identifier of the recruiter or talent acquisition specialist managing this candidate.',
    `candidate_referral_employee_id` BIGINT COMMENT 'Identifier of the employee who referred this candidate, if the source channel was employee referral.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Candidates apply for specific job profiles. Currently applied_position_title is a free-text STRING, which creates data quality issues and prevents proper matching/reporting. Adding job_profile_id FK n',
    `requisition_id` BIGINT COMMENT 'Identifier of the job requisition to which the candidate applied.',
    `application_date` DATE COMMENT 'Date when the candidate submitted their application for the position.',
    `background_check_completion_date` DATE COMMENT 'Date when the background check was completed.',
    `background_check_status` STRING COMMENT 'Status of the background check process for the candidate (not initiated, in progress, completed, cleared, flagged).. Valid values are `not_initiated|in_progress|completed|cleared|flagged`',
    `candidate_number` STRING COMMENT 'Human-readable business identifier assigned to the candidate for tracking and reference purposes across recruiting workflows.',
    `candidate_status` STRING COMMENT 'Current status of the candidate in the recruiting pipeline (applied, screened, interviewed, offered, hired, rejected, withdrawn). [ENUM-REF-CANDIDATE: applied|screened|interviewed|offered|hired|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `cover_letter_file_path` STRING COMMENT 'File path or storage location reference for the candidates cover letter document, if provided.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was first created in the system.',
    `current_employer` STRING COMMENT 'Name of the candidates current or most recent employer.',
    `current_job_title` STRING COMMENT 'Job title or role the candidate currently holds or most recently held.',
    `eeo_disability_status` STRING COMMENT 'Self-reported disability status for Equal Employment Opportunity (EEO) reporting purposes. Collected voluntarily and stored separately for compliance.',
    `eeo_ethnicity` STRING COMMENT 'Self-reported ethnicity for Equal Employment Opportunity (EEO) reporting purposes. Collected voluntarily and stored separately for compliance.',
    `eeo_gender` STRING COMMENT 'Self-reported gender for Equal Employment Opportunity (EEO) reporting purposes. Collected voluntarily and stored separately for compliance.',
    `eeo_veteran_status` STRING COMMENT 'Self-reported veteran status for Equal Employment Opportunity (EEO) reporting purposes. Collected voluntarily and stored separately for compliance.',
    `email_address` STRING COMMENT 'Primary email address used for candidate communication throughout the recruiting process.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expected_start_date` DATE COMMENT 'Expected or agreed-upon start date for the candidate if hired.',
    `first_name` STRING COMMENT 'Legal first name of the candidate as provided in the application.',
    `highest_education_level` STRING COMMENT 'Highest level of education attained by the candidate (e.g., high school, bachelors degree, masters degree, PhD).',
    `hire_date` DATE COMMENT 'Actual date when the candidate was hired and transitioned to employee status.',
    `interview_stage` STRING COMMENT 'Current interview stage or phase the candidate is in (e.g., phone screen, technical interview, panel interview, final interview).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was last updated or modified.',
    `last_name` STRING COMMENT 'Legal last name of the candidate as provided in the application.',
    `location_preference` STRING COMMENT 'Geographic location or site preference indicated by the candidate for the position.',
    `middle_name` STRING COMMENT 'Middle name or initial of the candidate, if provided.',
    `offer_acceptance_date` DATE COMMENT 'Date when the candidate accepted the job offer.',
    `offer_amount` DECIMAL(18,2) COMMENT 'Total compensation amount offered to the candidate (base salary or total package value).',
    `offer_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the offer amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `offer_date` DATE COMMENT 'Date when a formal job offer was extended to the candidate.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the candidate.',
    `rejection_date` DATE COMMENT 'Date when the candidate was formally rejected or removed from consideration.',
    `rejection_reason` STRING COMMENT 'Reason or category for candidate rejection if applicable (e.g., qualifications not met, position filled, candidate withdrew).',
    `resume_file_path` STRING COMMENT 'File path or storage location reference for the candidates resume or curriculum vitae document.',
    `source_channel` STRING COMMENT 'Channel through which the candidate was sourced or applied (e.g., LinkedIn, employee referral, job board, campus recruiting, career site, recruiting agency).. Valid values are `linkedin|referral|job_board|campus|career_site|agency`',
    `withdrawal_date` DATE COMMENT 'Date when the candidate withdrew their application from the recruiting process.',
    `work_authorization_status` STRING COMMENT 'Candidates work authorization status in the hiring country (e.g., citizen, permanent resident, requires sponsorship).',
    `years_of_experience` STRING COMMENT 'Total years of relevant professional experience reported by the candidate.',
    CONSTRAINT pk_candidate PRIMARY KEY(`candidate_id`)
) COMMENT 'Applicant/candidate master record in the talent acquisition pipeline — capturing candidate name, source channel (LinkedIn, referral, job board, campus), application date, applied position, candidate status (applied/screened/interviewed/offered/hired/rejected/withdrawn), interview stage, offer details, background check status, and EEO data. Sourced from Oracle Cloud HCM Recruiting. Distinct from the employee record created upon hire.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` (
    `absence_record_id` BIGINT COMMENT 'Unique identifier for the absence record. Primary key.',
    `absence_plan_id` BIGINT COMMENT 'Reference to the absence plan or policy under which this absence is recorded (e.g., annual Paid Time Off (PTO) plan, sick leave plan, Family and Medical Leave Act (FMLA) plan). Links to absence plan configuration.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically manager or Human Resources (HR) representative) who approved or rejected the absence request.',
    `primary_absence_employee_id` BIGINT COMMENT 'Reference to the employee who is absent. Links to the employee master record.',
    `workforce_assignment_id` BIGINT COMMENT 'Reference to the employee assignment or position providing coverage during this absence. Used for workforce planning and continuity management.',
    `absence_reason` STRING COMMENT 'Detailed reason or description for the absence event. May include medical condition category, family care reason, or other contextual information.',
    `absence_status` STRING COMMENT 'Current lifecycle status of the absence request. Tracks workflow from submission through approval and completion.. Valid values are `DRAFT|SUBMITTED|APPROVED|REJECTED|CANCELLED|COMPLETED`',
    `absence_type_code` STRING COMMENT 'Classification of the absence event. Includes planned leave (Paid Time Off (PTO), vacation, parental leave, sabbatical) and unplanned absences (sick leave, Family and Medical Leave Act (FMLA), disability leave, bereavement). [ENUM-REF-CANDIDATE: PTO|VACATION|SICK|FMLA|PARENTAL|BEREAVEMENT|DISABILITY — 7 candidates stripped; promote to reference product]',
    `accrual_balance_after` DECIMAL(18,2) COMMENT 'Employees absence accrual balance (in hours or days) after this absence was deducted. Used for audit trail and balance reconciliation.',
    `accrual_balance_before` DECIMAL(18,2) COMMENT 'Employees absence accrual balance (in hours or days) before this absence was taken. Used for audit trail and balance reconciliation.',
    `approval_comments` STRING COMMENT 'Comments or notes provided by the approver during the approval or rejection process.',
    `approval_date` DATE COMMENT 'Date when the absence request was approved or rejected by the approver.',
    `approval_status` STRING COMMENT 'Approval workflow status for the absence request. Tracks manager or Human Resources (HR) approval decision.. Valid values are `PENDING|APPROVED|REJECTED|WITHDRAWN`',
    `cancellation_date` DATE COMMENT 'Date when the absence request was cancelled by the employee or system administrator.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the absence request was cancelled.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this absence record was first created in the system. Used for audit trail and data lineage.',
    `disability_leave_flag` BOOLEAN COMMENT 'Indicates whether this absence is classified as short-term or long-term disability leave.',
    `duration_days` DECIMAL(18,2) COMMENT 'Total duration of the absence measured in calendar days. Supports fractional days for partial-day absences.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the absence measured in hours. Used for hourly tracking and partial-day leave calculations.',
    `end_date` DATE COMMENT 'The last scheduled date of the absence period. Represents the planned return date minus one day.',
    `external_reference_code` STRING COMMENT 'External system identifier for this absence record (e.g., Oracle Cloud Human Capital Management (HCM) absence ID, third-party leave management system case number). Used for cross-system reconciliation.',
    `fmla_designated_flag` BOOLEAN COMMENT 'Indicates whether this absence qualifies for and is designated as Family and Medical Leave Act (FMLA) protected leave under U.S. federal law.',
    `fmla_hours_used` DECIMAL(18,2) COMMENT 'Number of Family and Medical Leave Act (FMLA) hours consumed by this absence event. Tracked against the employees 12-week (480-hour) annual Family and Medical Leave Act (FMLA) entitlement.',
    `gxp_qualification_impact_notes` STRING COMMENT 'Free-text notes documenting the impact of the absence on the employees Good Practice Regulations (GxP) qualification status, including specific training or requalification activities required before resuming Good Manufacturing Practice (GMP) or Clinical Laboratory Improvement Amendments (CLIA) duties.',
    `gxp_requalification_required_flag` BOOLEAN COMMENT 'Indicates whether the employee requires Good Practice Regulations (GxP) requalification or retraining upon return to work due to extended absence from Good Manufacturing Practice (GMP) or Clinical Laboratory Improvement Amendments (CLIA) regulated environment. Triggered when absence exceeds regulatory qualification maintenance thresholds.',
    `intermittent_leave_flag` BOOLEAN COMMENT 'Indicates whether this absence is part of an intermittent leave pattern (e.g., recurring medical appointments, reduced work schedule under Family and Medical Leave Act (FMLA)).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this absence record was last updated. Used for audit trail and change tracking.',
    `medical_certification_date` DATE COMMENT 'Date when medical certification or documentation was received by Human Resources (HR).',
    `medical_certification_received_flag` BOOLEAN COMMENT 'Indicates whether required medical certification or documentation has been received and validated by Human Resources (HR).',
    `medical_certification_required_flag` BOOLEAN COMMENT 'Indicates whether medical certification or documentation is required for this absence (e.g., doctors note for extended sick leave, Family and Medical Leave Act (FMLA) certification).',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the absence event. May include special circumstances, accommodation details, or Human Resources (HR) case management notes.',
    `paid_flag` BOOLEAN COMMENT 'Indicates whether the absence is paid or unpaid. True for paid leave (Paid Time Off (PTO), vacation, paid sick leave), false for unpaid leave (unpaid Family and Medical Leave Act (FMLA), leave without pay).',
    `payroll_impact_flag` BOOLEAN COMMENT 'Indicates whether this absence has an impact on payroll processing (e.g., unpaid leave deduction, paid time off usage).',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether the payroll impact of this absence has been processed in the payroll system.',
    `return_to_work_date` DATE COMMENT 'The actual date the employee returned to work following the absence. May differ from planned end date if absence is extended or shortened.',
    `source_system_code` STRING COMMENT 'Identifies the system or channel through which the absence record was created (Oracle Cloud Human Capital Management (HCM), manual Human Resources (HR) entry, timekeeping integration, employee self-service portal).. Valid values are `ORACLE_HCM|MANUAL_ENTRY|TIMEKEEPING|SELF_SERVICE`',
    `start_date` DATE COMMENT 'The first date of the absence period. Represents when the employee begins their leave.',
    `submission_date` DATE COMMENT 'Date when the employee or their representative submitted the absence request.',
    `workers_compensation_flag` BOOLEAN COMMENT 'Indicates whether this absence is related to a workers compensation claim due to work-related injury or illness.',
    CONSTRAINT pk_absence_record PRIMARY KEY(`absence_record_id`)
) COMMENT 'Tracks employee absence events — planned leave (PTO, vacation, parental leave, sabbatical) and unplanned absences (sick leave, FMLA, disability leave). Captures absence type, start date, end date, duration in hours/days, approval status, FMLA designation, return-to-work date, and impact on GxP qualification status (e.g., requalification required after extended absence from GMP environment). Sourced from Oracle Cloud HCM Absence Management.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'Unique identifier for the headcount plan record. Primary key for the headcount planning entity.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that will bear the financial burden of this headcount plan. Links to the finance cost_center master data for General Ledger (GL) integration.',
    `location_id` BIGINT COMMENT 'Reference to the primary work location (site, office, or facility) for this headcount plan entry. Supports geographic workforce distribution analysis.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit for which this headcount plan applies. Links to the org_unit master data.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this headcount plan record. Supports audit trail and governance requirements.',
    `tertiary_headcount_last_modified_by_user_employee_id` BIGINT COMMENT 'The user identifier of the person who last modified this headcount plan record. Supports audit trail and data governance.',
    `actual_filled_headcount` DECIMAL(18,2) COMMENT 'The actual number of Full-Time Equivalent (FTE) positions filled as of the reporting date. Sourced from Oracle Cloud HCM active assignments.',
    `approved_headcount` DECIMAL(18,2) COMMENT 'The approved number of Full-Time Equivalent (FTE) positions after budget review and executive approval. May differ from planned_headcount due to budget constraints or strategic adjustments.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this headcount plan record was approved. Supports audit trail and Sarbanes-Oxley Act (SOX) compliance.',
    `budget_allocation_amount` DECIMAL(18,2) COMMENT 'The total budget amount allocated for this headcount plan entry, including salary, benefits, and overhead. Used for Full-Time Equivalent (FTE) spend vs. budget variance reporting.',
    `budget_currency_code` STRING COMMENT 'The three-letter International Organization for Standardization (ISO) 4217 currency code for the budget allocation amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `business_unit_code` STRING COMMENT 'The business unit code for this headcount plan entry. Aligns with corporate organizational structure and Profit and Loss (P&L) reporting.',
    `clia_certified_flag` BOOLEAN COMMENT 'Indicates whether the headcount in this plan entry requires Clinical Laboratory Improvement Amendments (CLIA) certification or qualification. Relevant for clinical genomics and In Vitro Diagnostic (IVD) laboratory personnel.',
    `contractor_fte_equivalent` DECIMAL(18,2) COMMENT 'The Full-Time Equivalent (FTE) count of contractors and contingent workers supporting this org unit and job family. Enables total workforce capacity analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this headcount plan record was first created in the system. Supports audit trail and data lineage.',
    `employment_type` STRING COMMENT 'The employment type classification for this headcount plan entry. Distinguishes between permanent employees, contractors, and temporary staff.. Valid values are `full_time|part_time|contractor|intern|temporary`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year (1-12). Provides monthly granularity for headcount planning and Full-Time Equivalent (FTE) tracking.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the fiscal year for this headcount plan (Q1, Q2, Q3, Q4). Enables quarterly workforce planning and variance analysis.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this headcount plan applies (e.g., 2024, 2025). Supports annual workforce planning cycles.',
    `functional_area` STRING COMMENT 'The functional area classification for this headcount plan entry (e.g., Research and Development (R&D), Manufacturing, Quality, Sales, General and Administrative (G&A)). Used for functional cost allocation and Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) reporting.',
    `gxp_regulated_flag` BOOLEAN COMMENT 'Indicates whether the headcount in this plan entry is subject to Good Practice Regulations (GxP) (Good Manufacturing Practice (GMP), Good Laboratory Practice (GLP), Good Clinical Practice (GCP)) compliance requirements. Drives training and qualification planning.',
    `job_family` STRING COMMENT 'The job family classification for this headcount plan entry (e.g., Research and Development (R&D), Manufacturing, Quality Assurance (QA), Field Application Scientist, Bioinformatics, Clinical Operations, Sales, Marketing, Finance, Human Resources (HR)). Aligns with workforce planning categories.',
    `job_level` STRING COMMENT 'The job level or grade for this headcount plan entry (e.g., Individual Contributor, Senior, Lead, Manager, Director, Vice President (VP), Executive). Used for workforce stratification and compensation planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this headcount plan record was last modified. Supports audit trail and change tracking.',
    `open_requisition_count` STRING COMMENT 'The number of open job requisitions for this org unit, job family, and fiscal period. Indicates active recruiting efforts to close the headcount gap.',
    `plan_effective_end_date` DATE COMMENT 'The date when this headcount plan record ceases to be effective. Null indicates an open-ended plan. Supports temporal workforce planning and historical analysis.',
    `plan_effective_start_date` DATE COMMENT 'The date when this headcount plan record becomes effective. Supports temporal workforce planning and historical analysis.',
    `plan_notes` STRING COMMENT 'Free-text notes or comments regarding this headcount plan entry. Captures business context, assumptions, or special considerations.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the headcount plan record. Tracks the approval workflow and activation state of the plan.. Valid values are `draft|submitted|approved|active|closed|superseded`',
    `plan_version` STRING COMMENT 'The version identifier for this headcount plan (e.g., Original Budget, Revised Q2, Board Approved). Supports multiple planning scenarios and revisions throughout the fiscal year.',
    `planned_headcount` DECIMAL(18,2) COMMENT 'The planned number of Full-Time Equivalent (FTE) positions for this org unit, job family, and fiscal period. Represents the initial workforce plan target.',
    `rd_capitalization_eligible_flag` BOOLEAN COMMENT 'Indicates whether the headcount in this plan entry is eligible for Research and Development (R&D) capitalization under Generally Accepted Accounting Principles (GAAP) or International Financial Reporting Standards (IFRS). Supports financial reporting and Sarbanes-Oxley Act (SOX) compliance.',
    `source_system_code` STRING COMMENT 'Identifier of the source system from which this headcount plan record originated (e.g., Oracle Cloud HCM, SAP S/4HANA, Workday, custom workforce planning tool). Supports data lineage and integration traceability.',
    `variance_to_plan` DECIMAL(18,2) COMMENT 'The variance between approved_headcount and actual_filled_headcount (calculated as actual_filled_headcount minus approved_headcount). Negative values indicate understaffing; positive values indicate overstaffing.',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'FTE planning and headcount budget records by org unit, job family, and fiscal period — capturing planned headcount, approved headcount, actual filled headcount, open requisition count, contractor FTE equivalents, and variance to plan. Supports annual workforce planning cycles, R&D headcount capitalization decisions, and GMP staffing compliance. Enables CFO/CHRO reporting on FTE spend vs. budget.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` (
    `lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the HR lifecycle event record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who provided final approval for this lifecycle event.',
    `location_id` BIGINT COMMENT 'Reference to the work location after this lifecycle event. Null for termination events.',
    `primary_lifecycle_employee_id` BIGINT COMMENT 'Reference to the employee who is the subject of this lifecycle event.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile assigned to the employee before this event. Null for new hire events.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit the employee belonged to before this event. Null for new hire events.',
    `position_id` BIGINT COMMENT 'Reference to the employees position before this lifecycle event. Null for new hire events.',
    `prior_location_id` BIGINT COMMENT 'Reference to the work location before this lifecycle event. Null for new hire events.',
    `quaternary_lifecycle_initiating_manager_employee_id` BIGINT COMMENT 'Reference to the manager who initiated this lifecycle event. Critical for SOX compliance audit trail.',
    `quinary_lifecycle_hr_business_partner_employee_id` BIGINT COMMENT 'Reference to the HR business partner responsible for processing this lifecycle event.',
    `tertiary_lifecycle_new_manager_employee_id` BIGINT COMMENT 'Reference to the employees direct manager after this lifecycle event. Null for termination events.',
    `approval_chain` STRING COMMENT 'Comma-separated list of employee IDs representing the approval workflow sequence for this event. Provides complete audit trail for SOX compliance.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when final approval was granted for this lifecycle event. Critical for SOX audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this lifecycle event record was first created in the system. Distinct from event_effective_date which represents the business event date.',
    `event_comments` STRING COMMENT 'Free-text field for additional notes, context, or special instructions related to this lifecycle event.',
    `event_effective_date` DATE COMMENT 'The date when this lifecycle event becomes effective for the employee. This is the business event date, distinct from system processing timestamps. Critical for SOX compliance and GxP personnel qualification continuity per 21 CFR Part 211.25.',
    `event_number` STRING COMMENT 'Human-readable business identifier for the lifecycle event, typically system-generated sequence number from Oracle Cloud HCM.',
    `event_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the lifecycle event. Maps to Oracle Cloud HCM action reason lookup values.',
    `event_reason_description` STRING COMMENT 'Detailed textual explanation of the reason for the lifecycle event. Provides context beyond the standardized reason code.',
    `event_status` STRING COMMENT 'Current workflow status of the lifecycle event. Tracks progression through approval and execution stages. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_progress|completed|cancelled|rejected — 7 candidates stripped; promote to reference product]',
    `event_type` STRING COMMENT 'Classification of the HR lifecycle event. Defines the nature of the personnel action being recorded. [ENUM-REF-CANDIDATE: new_hire|internal_transfer|promotion|demotion|role_change|location_change|leave_of_absence_start|return_from_leave|termination|offboarding — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this lifecycle event record was last updated in the system.',
    `new_clia_qualified_flag` BOOLEAN COMMENT 'Indicates whether the employee requires CLIA personnel qualification in their new role. Null for termination events.',
    `new_employment_type` STRING COMMENT 'Employment classification after this lifecycle event. Null for termination events.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `new_fte_percentage` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation percentage after this event. 100.00 represents full-time. Null for termination events.',
    `new_gxp_critical_flag` BOOLEAN COMMENT 'Indicates whether the employees new role is designated as GxP-critical requiring regulatory qualification per 21 CFR Part 211.25. Null for termination events.',
    `prior_clia_qualified_flag` BOOLEAN COMMENT 'Indicates whether the employee held CLIA personnel qualification in their prior role. Null for new hire events.',
    `prior_employment_type` STRING COMMENT 'Employment classification before this lifecycle event. Null for new hire events.. Valid values are `full_time|part_time|contractor|temporary|intern`',
    `prior_fte_percentage` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation percentage before this event. 100.00 represents full-time. Null for new hire events.',
    `prior_gxp_critical_flag` BOOLEAN COMMENT 'Indicates whether the employees prior role was designated as GxP-critical requiring regulatory qualification per 21 CFR Part 211.25. Null for new hire events.',
    `requalification_due_date` DATE COMMENT 'Target date by which training requalification must be completed following this lifecycle event. Null if requalification is not required.',
    `source_system_code` STRING COMMENT 'Identifier of the source system from which this lifecycle event record originated, typically Oracle Cloud HCM instance identifier.',
    `source_system_event_code` STRING COMMENT 'Native event identifier from the source system (Oracle Cloud HCM action ID) for traceability and reconciliation.',
    `sox_control_event_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event is subject to SOX personnel change control requirements due to financial system access or authority changes.',
    `system_access_change_required_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event requires changes to system access permissions and roles. Critical for SOX IT general controls.',
    `training_requalification_required_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event triggers mandatory GxP training requalification per 21 CFR Part 211.25.',
    CONSTRAINT pk_lifecycle_event PRIMARY KEY(`lifecycle_event_id`)
) COMMENT 'Captures discrete HR lifecycle events providing a complete audit trail for each employee — new hire onboarding, internal transfer, promotion, demotion, role change, location change, leave of absence initiation, return from leave, and termination/offboarding. Each event captures event type, effective date, prior state, new state, initiating manager, HR business partner, approval chain, and event reason code. Critical for SOX compliance (personnel change controls), GxP personnel qualification continuity (21 CFR Part 211.25), and CLIA personnel change documentation. Sourced from Oracle Cloud HCM.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` (
    `lab_qualification_id` BIGINT COMMENT 'Unique identifier for the laboratory qualification record. Primary key for the lab_qualification product.',
    `controlled_document_id` BIGINT COMMENT 'Reference to the qualification documentation stored in the document management system (e.g., Veeva Vault, MasterControl). Links to assessment forms, certificates, and training records.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Lab qualifications for variant calling, NGS pipeline operation, and clinical bioinformatics must specify the genome build the employee is qualified to use. CLIA personnel qualification records require',
    `genomic_access_control_id` BIGINT COMMENT 'Foreign key linking to data.genomic_access_control. Business justification: Lab qualifications determine technical access rights to specific genomic analysis platforms (e.g., Illumina BaseSpace, bioinformatics pipelines) and associated datasets. Operational necessity: only qu',
    `employee_id` BIGINT COMMENT 'Reference to the employee who holds this laboratory qualification. Links to the employee master record in the workforce domain.',
    `quality_rule_id` BIGINT COMMENT 'Foreign key linking to data.quality_rule. Business justification: Lab qualifications (instrument-specific, assay-specific) authorize personnel to perform quality-controlled genomic workflows. Quality rules enforce that only qualified personnel execute critical data ',
    `assay_type` STRING COMMENT 'Specific assay or test method for which the qualification applies. Examples: WGS (Whole Genome Sequencing), WES (Whole Exome Sequencing), SNP Array, CNV Detection, CRISPR Editing Protocol. Null for non-assay-specific qualifications.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved during the qualification assessment, expressed as a percentage (0.00 to 100.00). Null if the assessment was pass/fail without numerical scoring.',
    `assessor_name` STRING COMMENT 'Full name of the individual who conducted the qualification assessment. Denormalized for audit trail and reporting purposes.',
    `assessor_title` STRING COMMENT 'Job title or role of the assessor at the time of qualification. Examples: Senior Scientist, Lab Manager, Technical Director, Quality Assurance Manager.',
    `biosafety_level` STRING COMMENT 'Biosafety containment level for which the individual is authorized. BSL-1 for minimal hazard, BSL-2 for moderate risk, BSL-3 for serious or potentially lethal agents. Not applicable for non-biosafety qualifications.. Valid values are `BSL-1|BSL-2|BSL-3|not_applicable`',
    `cap_accreditation_required_flag` BOOLEAN COMMENT 'Indicates whether this qualification is required for CAP laboratory accreditation. True for qualifications mandated by CAP inspection checklists; false otherwise.',
    `cleanroom_class` STRING COMMENT 'ISO cleanroom classification for which the individual is qualified. ISO 5 (Class 100) through ISO 8 (Class 100,000) per ISO 14644-1. Not applicable for non-cleanroom qualifications.. Valid values are `ISO_5|ISO_6|ISO_7|ISO_8|not_applicable`',
    `clia_required_flag` BOOLEAN COMMENT 'Indicates whether this qualification is required for CLIA-regulated clinical laboratory operations. True for qualifications mandated by CLIA personnel standards; false otherwise.',
    `competency_assessment_method` STRING COMMENT 'Method used to assess competency for this qualification. Practical demonstration for hands-on skills; written exam for knowledge; observation for supervised performance; simulation for controlled scenarios; combination for multi-method assessment.. Valid values are `practical_demonstration|written_exam|observation|simulation|combination`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system. Audit trail field for data governance and compliance.',
    `expiry_date` DATE COMMENT 'Date on which the qualification expires and requalification is required. Null for qualifications with no expiration (permanent authorization).',
    `gxp_critical_flag` BOOLEAN COMMENT 'Indicates whether this qualification is critical for GxP compliance (Good Manufacturing Practice, Good Laboratory Practice, Good Clinical Practice). True for qualifications required for regulated activities; false otherwise.',
    `independent_runs_required` STRING COMMENT 'Number of successful independent runs required to demonstrate competency. Null for non-operational qualifications.',
    `instrument_model` STRING COMMENT 'Specific instrument model or platform for which the qualification applies. Examples: Illumina NovaSeq 6000, Illumina NextSeq 2000, Applied Biosystems QuantStudio 7, CRISPR Cas9 System. Null for non-instrument qualifications.',
    `iso_13485_required_flag` BOOLEAN COMMENT 'Indicates whether this qualification is required for ISO 13485 medical device quality management system compliance. True for qualifications mandated by ISO 13485 personnel competency requirements; false otherwise.',
    `lab_scope` STRING COMMENT 'Laboratory area, facility, or functional scope to which this qualification applies. Examples: NGS Production Lab, qPCR Lab, Gene Editing Suite, BSL-2 Containment Area, Cleanroom Zone A.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last updated. Audit trail field for data governance and compliance.',
    `last_requalification_date` DATE COMMENT 'Date of the most recent requalification assessment. Null if the individual has not yet been requalified since initial qualification.',
    `next_requalification_due_date` DATE COMMENT 'Calculated date by which the next requalification must be completed. Derived from last qualification date plus requalification frequency. Null for qualifications not requiring requalification.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special conditions, limitations, or observations related to the qualification. Examples: Qualified with restrictions, requires co-signer for first 10 runs, authorized for research use only.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the qualification assessment, expressed as a percentage. Typically 80.00 or higher for GxP-regulated qualifications.',
    `qualification_certificate_number` STRING COMMENT 'Unique certificate or credential number issued upon successful qualification. Used for audit trail and verification purposes.',
    `qualification_code` STRING COMMENT 'Standardized code identifying the specific qualification. Examples: NGS-NOVASEQ-OPR, QPCR-OPR, CRISPR-EDIT-L2, BSL2-AUTH, CR-GOWN-A.',
    `qualification_date` DATE COMMENT 'Date on which the individual successfully completed the qualification and was authorized. Represents the effective start of competency.',
    `qualification_name` STRING COMMENT 'Human-readable name of the laboratory qualification. Examples: NovaSeq 6000 Instrument Operator, qPCR Operator Qualification, CRISPR Gene Editing Lab Level 2, Biosafety Level 2 Authorization, Cleanroom Gowning Class A.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification. Active indicates the individual is currently authorized; expired indicates the qualification has lapsed; suspended indicates temporary hold; pending_requalification indicates renewal in process; revoked indicates permanent removal; in_progress indicates initial qualification underway.. Valid values are `active|expired|suspended|pending_requalification|revoked|in_progress`',
    `qualification_type` STRING COMMENT 'Category of laboratory qualification. Distinguishes between instrument operation, lab technique competency, biosafety clearance, cleanroom access, assay-specific authorization, and equipment maintenance qualification.. Valid values are `instrument_operator|lab_technique|biosafety_authorization|cleanroom_qualification|assay_specific|equipment_maintenance`',
    `requalification_frequency_months` STRING COMMENT 'Number of months between required requalification assessments. Common values: 12, 24, 36. Null for qualifications that do not require periodic requalification.',
    `requalification_status` STRING COMMENT 'Current status of requalification requirement. Not required for permanent qualifications; upcoming when approaching expiry; overdue when past expiry; in progress during reassessment; completed when renewed.. Valid values are `not_required|upcoming|overdue|in_progress|completed`',
    `revocation_date` DATE COMMENT 'Date on which the qualification was revoked due to performance issues, safety violations, or other disqualifying events. Null for qualifications that have not been revoked.',
    `revocation_reason` STRING COMMENT 'Explanation for why the qualification was revoked. Examples: Failed requalification assessment, safety violation, quality incident, extended absence, role change. Null for qualifications that have not been revoked.',
    `sop_version` STRING COMMENT 'Version of the Standard Operating Procedure under which the qualification was conducted. Ensures traceability to the specific procedure version used for assessment.',
    `supervised_runs_completed` STRING COMMENT 'Number of supervised instrument runs, assays, or procedures completed during the qualification process. Null for non-operational qualifications.',
    `suspension_end_date` DATE COMMENT 'Date on which the qualification suspension was lifted and authorization was reinstated. Null for qualifications that are currently suspended or have not been suspended.',
    `suspension_reason` STRING COMMENT 'Explanation for why the qualification was temporarily suspended. Examples: Pending investigation, refresher training required, equipment change, procedure update. Null for qualifications that have not been suspended.',
    `suspension_start_date` DATE COMMENT 'Date on which the qualification was temporarily suspended. Null for qualifications that have not been suspended.',
    `training_hours_completed` DECIMAL(18,2) COMMENT 'Total number of training hours completed as part of the qualification process. Includes classroom instruction, hands-on practice, and supervised operation.',
    CONSTRAINT pk_lab_qualification PRIMARY KEY(`lab_qualification_id`)
) COMMENT 'Tracks individual laboratory and instrument-specific qualifications for scientists, engineers, and technicians — e.g., NGS instrument operator qualification (Illumina NovaSeq, NextSeq), qPCR operator qualification, CRISPR editing lab qualification, biosafety level (BSL-1/BSL-2) authorization, and cleanroom gowning qualification. Captures qualification type, instrument/lab scope, qualification date, qualified-by assessor, expiry date, and requalification status. Distinct from GxP training records — this is competency-based lab authorization.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` (
    `payroll_result_id` BIGINT COMMENT 'Unique identifier for the payroll result record. Primary key for this entity representing a single employees processed payroll for a specific pay period.',
    `cost_center_id` BIGINT COMMENT 'Cost center to which this payroll expense is allocated. Critical for labor cost allocation and R&D capitalization analysis per SOX requirements.',
    `employee_id` BIGINT COMMENT 'Reference to the employee for whom this payroll result was processed. Links to the employee master record in Oracle Cloud HCM.',
    `payroll_run_id` BIGINT COMMENT 'Reference to the payroll run batch that generated this result. Links to the payroll run header record.',
    `workforce_assignment_id` BIGINT COMMENT 'Reference to the employee assignment record active during this pay period. Captures the position, organization, and cost center context for this payroll result.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Discretionary or performance-based bonus payments included in this pay period. May include annual bonuses, spot awards, or incentive compensation.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Sales commission earnings for field application specialists and commercial staff. Calculated based on revenue attainment and commission plans.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll result record was first created in the system. Part of standard audit trail.',
    `dental_insurance_deduction_amount` DECIMAL(18,2) COMMENT 'Employee portion of dental insurance premiums deducted from pay. Typically pre-tax under cafeteria plan.',
    `federal_tax_withheld_amount` DECIMAL(18,2) COMMENT 'Federal income tax withheld from gross pay per IRS regulations and employee W-4 elections. Required for SOX financial controls and tax reporting.',
    `fsa_contribution_amount` DECIMAL(18,2) COMMENT 'Employee pre-tax contributions to healthcare or dependent care FSA. Subject to IRS annual limits and use-it-or-lose-it rules.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting this payroll expense. Maps to chart of accounts for financial reporting and SOX controls.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total earnings before any deductions or withholdings. Includes regular pay, overtime, shift differentials, bonuses, and other earnings components.',
    `health_insurance_deduction_amount` DECIMAL(18,2) COMMENT 'Employee portion of health insurance premiums deducted from pay. May be pre-tax under Section 125 cafeteria plan.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total hours worked during the pay period including regular and overtime hours. Used for labor productivity analysis and FTE calculations.',
    `hsa_contribution_amount` DECIMAL(18,2) COMMENT 'Employee pre-tax contributions to HSA for high-deductible health plan participants. Subject to IRS annual limits.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll result record was last updated. Tracks changes for audit and compliance purposes.',
    `local_tax_withheld_amount` DECIMAL(18,2) COMMENT 'Local or municipal income tax withheld where applicable. Includes city, county, or district taxes based on work or residence location.',
    `medicare_tax_amount` DECIMAL(18,2) COMMENT 'Employee portion of FICA Medicare tax withheld. Includes additional Medicare tax for high earners per ACA regulations.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Take-home pay after all deductions and withholdings. The amount disbursed to the employee via direct deposit or check.',
    `other_deductions_amount` DECIMAL(18,2) COMMENT 'Sum of miscellaneous deductions not captured in standard categories. May include garnishments, union dues, charitable contributions, or loan repayments.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Hours worked beyond standard schedule at premium pay rates. Subject to FLSA regulations and company overtime policy.',
    `overtime_pay_amount` DECIMAL(18,2) COMMENT 'Additional earnings for hours worked beyond standard schedule. Calculated at premium rates per labor regulations and company policy.',
    `pay_period_end_date` DATE COMMENT 'The last day of the pay period covered by this payroll result. Defines the earnings and deductions calculation window.',
    `pay_period_start_date` DATE COMMENT 'The first day of the pay period covered by this payroll result. Used for period-based reporting and labor cost allocation.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payroll result. Typically USD for US operations.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the net pay was disbursed to the employee. Used for cash flow forecasting and SOX financial controls.',
    `payment_method` STRING COMMENT 'Method by which net pay was disbursed to the employee. Direct deposit is standard for most employees.. Valid values are `direct_deposit|check|wire_transfer`',
    `payroll_frequency` STRING COMMENT 'Pay cycle frequency for this employee. Determines pay period duration and payment schedule.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `payroll_run_status` STRING COMMENT 'Current lifecycle status of this payroll result. Tracks progression from calculation through payment and supports audit trail for SOX compliance.. Valid values are `draft|calculated|validated|paid|reversed|voided`',
    `processed_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll result was calculated and finalized. Critical for audit trail and SOX compliance.',
    `pto_hours_used` DECIMAL(18,2) COMMENT 'Paid time off hours taken during this pay period. Reduces available PTO balance and is included in gross pay calculation.',
    `rd_capitalization_amount` DECIMAL(18,2) COMMENT 'Portion of labor cost eligible for R&D capitalization per accounting standards. Used for financial statement preparation and tax credits.',
    `rd_capitalization_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross pay allocated to R&D capitalization. Determined by employee role, project assignment, and accounting policy.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Standard hours worked at base pay rate. Excludes overtime and premium hours.',
    `regular_pay_amount` DECIMAL(18,2) COMMENT 'Base earnings for standard hours worked during the pay period. Excludes overtime, bonuses, and other supplemental pay.',
    `retirement_contribution_amount` DECIMAL(18,2) COMMENT 'Employee pre-tax or Roth contributions to 401(k) retirement plan. Voluntary deduction subject to IRS annual limits.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this payroll result has been reversed or voided. True if reversed, false if active. Used for audit trail and correction tracking.',
    `reversal_reason` STRING COMMENT 'Business justification for reversing this payroll result. Required for SOX audit trail when corrections are made.',
    `shift_differential_amount` DECIMAL(18,2) COMMENT 'Premium pay for GMP manufacturing staff working non-standard shifts (evening, night, weekend). Critical for labor cost analysis in regulated manufacturing operations.',
    `social_security_tax_amount` DECIMAL(18,2) COMMENT 'Employee portion of FICA Social Security tax withheld. Calculated at statutory rate up to annual wage base limit.',
    `state_tax_withheld_amount` DECIMAL(18,2) COMMENT 'State income tax withheld based on employee work location and state tax regulations. Varies by jurisdiction.',
    `total_deductions_amount` DECIMAL(18,2) COMMENT 'Sum of all tax withholdings and voluntary deductions subtracted from gross pay. Used to calculate net pay.',
    `vision_insurance_deduction_amount` DECIMAL(18,2) COMMENT 'Employee portion of vision insurance premiums deducted from pay. Typically pre-tax under cafeteria plan.',
    CONSTRAINT pk_payroll_result PRIMARY KEY(`payroll_result_id`)
) COMMENT 'Stores processed payroll run results per employee per pay period — capturing gross pay, net pay, tax withholdings (federal, state, local), benefit deductions, voluntary deductions (401k, FSA), overtime pay, shift differential pay for GMP manufacturing staff, and payroll run status. Sourced from Oracle Cloud HCM Payroll. Restricted classification. Supports SOX financial controls and labor cost allocation to cost centers and R&D capitalization.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique identifier for the time entry record. Primary key for the time entry data product.',
    `account_id` BIGINT COMMENT 'Reference to the customer account for billable time entries. Used for field application specialist time tracking and customer invoicing.',
    `employee_id` BIGINT COMMENT 'Reference to the manager or supervisor who approved this time entry. Provides audit trail for SOX compliance.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center against which this time is charged. Enables labor cost allocation across organizational units.',
    `location_id` BIGINT COMMENT 'Reference to the physical location where the work was performed. Supports multi-site labor cost allocation and remote work tracking.',
    `payroll_run_id` BIGINT COMMENT 'Reference to the payroll run that processed this time entry. Links time to compensation and enables payroll audit trail.',
    `primary_time_employee_id` BIGINT COMMENT 'Reference to the employee who recorded this time entry. Links to the employee master data.',
    `rd_capitalization_id` BIGINT COMMENT 'Foreign key linking to finance.rd_capitalization. Business justification: R&D labor capitalization under ASC 985-20/IAS 38 requires linking time entries to capitalization decisions to allocate labor costs to fixed assets (capitalized software/technology). Essential for dete',
    `service_agreement_id` BIGINT COMMENT 'Reference to the service agreement or contract under which billable time is provided. Links time to contractual commitments and SLA tracking.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_order. Business justification: Enables direct labor cost rollup from time entries to work orders and production batches for manufacturing cost accounting and variance analysis. Critical for GMP cost tracking and production costing.',
    `workforce_assignment_id` BIGINT COMMENT 'Reference to the specific employee assignment under which this time was worked. Supports employees with multiple concurrent assignments.',
    `adjusted_time_entry_id` BIGINT COMMENT 'Self-referencing FK on time_entry (adjusted_time_entry_id)',
    `activity_code` STRING COMMENT 'Specific activity or task performed during this time period. Supports detailed labor cost analysis and R&D capitalization eligibility determination.',
    `approval_status` STRING COMMENT 'Current approval status of the time entry. Controls payroll processing and financial posting. Critical for SOX internal controls over labor cost.. Valid values are `draft|submitted|approved|rejected|pending_review`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry was approved. Critical for payroll cutoff and SOX audit trail.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this time is billable to a customer or external party. Critical for field application specialist revenue recognition.',
    `capitalization_percentage` DECIMAL(18,2) COMMENT 'Percentage of labor cost from this time entry that should be capitalized as R&D asset. Supports partial capitalization scenarios.',
    `clia_qualified_activity_flag` BOOLEAN COMMENT 'Indicates whether this time was spent on CLIA-regulated clinical laboratory activities requiring personnel qualification. Critical for CAP accreditation and CLIA compliance.',
    `comments` STRING COMMENT 'Free-text comments or notes about the time entry. Provides context for unusual entries or approval decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this time entry record was first created in the system. Provides audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for labor cost amount. Supports multi-currency operations and global workforce management.. Valid values are `^[A-Z]{3}$`',
    `entry_date` DATE COMMENT 'The calendar date on which the work was performed. Critical for labor cost allocation and payroll processing.',
    `external_reference_code` STRING COMMENT 'External system reference identifier for this time entry. Enables cross-system reconciliation and audit trail.',
    `gl_posted_flag` BOOLEAN COMMENT 'Indicates whether labor cost from this time entry has been posted to the general ledger. Critical for financial close and SOX compliance.',
    `gl_posting_date` DATE COMMENT 'Date when labor cost was posted to the general ledger. Used for period-end close and financial reporting.',
    `gmp_production_flag` BOOLEAN COMMENT 'Indicates whether this time was spent on GMP-regulated manufacturing activities. Used for regulatory compliance reporting and labor cost allocation to production batches.',
    `gxp_critical_flag` BOOLEAN COMMENT 'Indicates whether this time was spent on GxP-regulated activities requiring documented qualification and training compliance. Critical for FDA and EMA audit trails.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours worked for this time entry. Supports fractional hours for precise labor cost allocation.',
    `internal_order_number` STRING COMMENT 'SAP internal order number for cost collection and allocation. Used for project-based and overhead cost tracking.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost for this time entry including base pay, overtime premium, and shift differential. Used for cost accounting and R&D capitalization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this time entry record was last updated. Critical for change tracking and SOX audit trail.',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether this time entry has been processed in payroll. Prevents duplicate payment and supports payroll reconciliation.',
    `rd_capitalization_eligible_flag` BOOLEAN COMMENT 'Indicates whether this time entry is eligible for R&D capitalization under ASC 730 or IAS 38. Critical for financial reporting and SOX compliance.',
    `shift_code` STRING COMMENT 'Shift identifier for manufacturing and laboratory operations. Used for shift differential calculation and 24/7 operations management.',
    `source_system_code` STRING COMMENT 'Identifier of the source system that created this time entry record. Supports data lineage and multi-system integration.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the employee submitted the time entry for approval. Tracks timesheet submission timeliness.',
    `time_type_code` STRING COMMENT 'Classification of the time worked. Determines pay rate multiplier and labor cost treatment. Critical for GMP manufacturing staff overtime tracking and SOX-compliant labor reporting.. Valid values are `regular|overtime|double_time|on_call|standby|shift_differential`',
    `wbs_element` STRING COMMENT 'Work breakdown structure element for project-based time tracking. Enables hierarchical project cost rollup and R&D capitalization reporting.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Captures employee time worked against cost centers, projects, and R&D activities — supporting labor cost allocation, R&D capitalization under ASC 730/IAS 38, overtime tracking for GMP manufacturing staff, and billable hours for field application specialists. Records employee reference, date, hours, time type (regular/overtime/on-call), project/activity code, cost center, approval status, and capitalization eligibility flag. Sourced from Oracle Cloud HCM Time and Labor. Critical for biotech R&D capitalization decisions and SOX-compliant labor cost reporting.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` (
    `genomic_access_grant_id` BIGINT COMMENT 'Unique identifier for this access grant record. Primary key.',
    `approver_employee_id` BIGINT COMMENT 'Employee ID of the Data Access Committee member or authorized approver who granted this access.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who has been granted access to the genomic dataset',
    `genomic_access_control_id` BIGINT COMMENT 'Foreign key linking to the genomic access control policy governing the dataset being accessed',
    `access_tier` STRING COMMENT 'Level of access granted to the employee for this specific dataset, which may differ from the policys default tier based on employee role and approval. Explicitly identified in detection phase.',
    `approval_date` DATE COMMENT 'Date on which the Data Access Committee or authorized approver granted this access request. Explicitly identified in detection phase.',
    `audit_log_reference` STRING COMMENT 'Reference identifier linking this access grant to the audit logging system tracking all data access events by this employee for this dataset. Explicitly identified in detection phase.',
    `data_use_agreement_signed_date` DATE COMMENT 'Date on which the employee signed the Data Use Agreement acknowledging their responsibilities and limitations for accessing this genomic dataset.',
    `data_use_limitation_codes` STRING COMMENT 'GA4GH Data Use Ontology (DUO) codes specifying the permitted uses for this specific access grant, which may be more restrictive than the policy-level limitations. Explicitly identified in detection phase.',
    `grant_expiry_date` DATE COMMENT 'Date on which the employees access to the genomic dataset expires and must be renewed or revoked. Explicitly identified in detection phase as access_grant_expiry_date.',
    `grant_start_date` DATE COMMENT 'Date on which the employees access to the genomic dataset becomes effective. Explicitly identified in detection phase as access_grant_start_date.',
    `grant_status` STRING COMMENT 'Current lifecycle status of this access grant indicating whether the employee currently has active access.',
    `revocation_date` DATE COMMENT 'Date on which this access grant was revoked before its natural expiry, if applicable. Null for grants that expired naturally or are still active.',
    `revocation_reason` STRING COMMENT 'Reason for early revocation of access, such as employment termination, role change, IRB protocol violation, or data breach investigation.',
    `training_completion_date` DATE COMMENT 'Date on which the employee completed required training on genomic data handling, privacy protection, and ethical use before being granted access.',
    CONSTRAINT pk_genomic_access_grant PRIMARY KEY(`genomic_access_grant_id`)
) COMMENT 'This association product represents the authorization event granting an employee access to a specific genomic dataset governed by an access control policy. It captures time-bound access permissions, approval workflows, data use limitations, and audit requirements. Each record links one employee to one genomic access control policy with attributes that exist only in the context of this specific access grant, including grant dates, expiration, approval references, and compliance tracking.. Existence Justification: In genomics research and clinical operations, employees require access to multiple genomic datasets (dbGaP studies, internal cohorts, clinical variant databases), and each dataset has multiple authorized users across different roles (researchers, bioinformaticians, clinicians, data stewards). Access grants are actively managed as time-bound authorizations with approval workflows, expiration tracking, audit logging, and compliance requirements tied to IRB protocols and data use agreements. This is an operational M:N relationship where the business manages individual access grants as distinct entities.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` (
    `genome_qualification_id` BIGINT COMMENT 'Primary key for the genome_qualification association',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who holds this genome assembly qualification',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to the genome assembly for which the employee is qualified',
    `certification_expiry_date` DATE COMMENT 'Date on which this qualification certification expires and requires renewal. Null for qualifications without expiry. Critical for CLIA compliance tracking.',
    `certifying_authority` STRING COMMENT 'Name or identifier of the person or body that certified this qualification (e.g., training manager, CLIA director). Required for audit trail.',
    `last_used_date` DATE COMMENT 'Most recent date the employee worked with this genome assembly in a production pipeline or assay. Used to track active vs dormant qualifications and identify retraining needs.',
    `notes` STRING COMMENT 'Free-text notes about this qualification, including special conditions, limitations, or requalification requirements.',
    `proficiency_level` STRING COMMENT 'Assessed proficiency level of the employee working with this specific genome assembly. Used for project staffing decisions and training needs assessment.',
    `qualification_date` DATE COMMENT 'Date on which the employee achieved qualification to work with this genome assembly. Required for CLIA personnel records and audit trails.',
    `qualification_status` STRING COMMENT 'Current status of the qualification. Active indicates the employee is currently authorized to work with this assembly. Expired/Suspended/Revoked indicate loss of authorization requiring requalification.',
    `training_completion_date` DATE COMMENT 'Date the employee completed required training for this genome assembly. May differ from qualification_date if assessment occurred later.',
    CONSTRAINT pk_genome_qualification PRIMARY KEY(`genome_qualification_id`)
) COMMENT 'This association product represents the qualification relationship between employees and genome assemblies. It captures CLIA-compliant personnel qualification records for bioinformatics staff authorized to work with specific reference genome builds. Each record links one employee to one genome assembly with qualification status, proficiency level, certification dates, and last usage tracking required for regulatory compliance and project staffing decisions.. Existence Justification: In genomics biotechnology operations, bioinformatics employees must be qualified to work with specific genome assemblies for CLIA compliance and quality assurance. A single employee (bioinformatician, scientist) can be qualified on multiple genome builds (GRCh37, GRCh38, T2T-CHM13, GRCm39), and each genome assembly requires multiple qualified personnel for operational continuity, cross-coverage, and 24/7 pipeline support. The qualification relationship itself carries regulatory-critical data including qualification dates, proficiency levels, certification expiry, and last usage tracking.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Primary key for compensation_plan',
    `superseded_compensation_plan_id` BIGINT COMMENT 'Self-referencing FK on compensation_plan (superseded_compensation_plan_id)',
    `actual_percentage` DECIMAL(18,2) COMMENT 'Achieved percentage used for final payout calculation.',
    `approval_date` DATE COMMENT 'Date when the compensation plan received formal approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the compensation plan.',
    `bonus_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the base amount for bonus calculations.',
    `budget_currency_code` STRING COMMENT 'Currency of the plan budget amount.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Base monetary amount associated with the plan (e.g., salary base, bonus pool).',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the plan complies with GxP and other regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compensation plan record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values in the plan.',
    `effective_end_date` DATE COMMENT 'Date when the compensation plan expires or is superseded; null for open‑ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the compensation plan becomes effective.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which employees qualify for the plan.',
    `eligibility_end_date` DATE COMMENT 'Date when eligibility for the plan ends.',
    `eligibility_start_date` DATE COMMENT 'Date when an employee becomes eligible for the plan.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this plan is the default for its category.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the compensation plan.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the compensation plan.',
    `payout_frequency` STRING COMMENT 'How often compensation is paid under the plan.',
    `plan_budget` DECIMAL(18,2) COMMENT 'Total budget allocated for the compensation plan.',
    `plan_code` STRING COMMENT 'External business identifier for the compensation plan used in HR and payroll systems.',
    `plan_name` STRING COMMENT 'Human‑readable name of the compensation plan.',
    `plan_owner` STRING COMMENT 'Department or individual responsible for the plans administration.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the plan.',
    `plan_type` STRING COMMENT 'Category of the plan indicating the compensation mechanism.',
    `plan_version_description` STRING COMMENT 'Narrative description of changes introduced in this version.',
    `regulatory_approval_date` DATE COMMENT 'Date when the plan received regulatory clearance.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority that approved the plan.',
    `review_cycle` STRING COMMENT 'Frequency at which the plan is reviewed for updates.',
    `target_percentage` DECIMAL(18,2) COMMENT 'Target percentage of base salary or quota used to calculate variable pay.',
    `tax_code` STRING COMMENT 'Code representing the tax treatment applicable to the plan.',
    `taxability_flag` BOOLEAN COMMENT 'Indicates whether the compensation is subject to tax withholding.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compensation plan record.',
    `version_number` STRING COMMENT 'Sequential version number of the compensation plan.',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Master reference table for compensation_plan. Referenced by compensation_plan_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`absence_plan` (
    `absence_plan_id` BIGINT COMMENT 'Primary key for absence_plan',
    `superseded_absence_plan_id` BIGINT COMMENT 'Self-referencing FK on absence_plan (superseded_absence_plan_id)',
    `accrual_frequency` STRING COMMENT 'How often accruals are applied.',
    `accrual_rate` DECIMAL(18,2) COMMENT 'Number of leave units accrued per accrual period.',
    `accrual_unit` STRING COMMENT 'Unit of measurement for the accrual rate.',
    `applicable_job_levels` STRING COMMENT 'Job levels eligible for this plan.',
    `approval_workflow` STRING COMMENT 'Defined workflow for approving leave.',
    `carryover_allowed` BOOLEAN COMMENT 'Indicates if unused leave can be carried over to the next period.',
    `carryover_limit` DECIMAL(18,2) COMMENT 'Maximum amount of leave that can be carried over.',
    `classification` STRING COMMENT 'Classification of the plan for eligibility and policy purposes.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the plan applies.',
    `absence_plan_description` STRING COMMENT 'Detailed description of the plan policies.',
    `effective_from` DATE COMMENT 'Date when the plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the plan expires or is terminated; null if open-ended.',
    `eligibility_criteria` STRING COMMENT 'Eligibility rules for employees to be enrolled in the plan.',
    `is_flexible` BOOLEAN COMMENT 'Indicates if the plan allows flexible scheduling of leave.',
    `is_paid_leave` BOOLEAN COMMENT 'Indicates if the leave under this plan is paid.',
    `lifecycle_status` STRING COMMENT 'Current status of the plan in its lifecycle.',
    `max_accrual` DECIMAL(18,2) COMMENT 'Maximum allowable balance for the plan.',
    `plan_code` STRING COMMENT 'External code used to reference the absence plan in HR systems.',
    `plan_name` STRING COMMENT 'Descriptive name of the absence plan.',
    `plan_type` STRING COMMENT 'Category of leave covered by the plan.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the plan record was created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plan record.',
    `region` STRING COMMENT 'Geographic region or state where the plan is applicable.',
    `requires_approval` BOOLEAN COMMENT 'Whether leave requests under this plan require managerial approval.',
    `reset_date` DATE COMMENT 'Date when the plan balance resets according to policy.',
    `reset_frequency` STRING COMMENT 'Frequency of balance reset.',
    `usage_balance` DECIMAL(18,2) COMMENT 'Current available leave balance for the plan.',
    CONSTRAINT pk_absence_plan PRIMARY KEY(`absence_plan_id`)
) COMMENT 'Master reference table for absence_plan. Referenced by absence_plan_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`location` (
    `location_id` BIGINT COMMENT 'Primary key for location',
    `parent_location_id` BIGINT COMMENT 'Self-referencing FK on location (parent_location_id)',
    `access_control` STRING COMMENT 'Defines the level of physical or logical access required for the location.',
    `address_line1` STRING COMMENT 'First line of the street address for the location.',
    `address_line2` STRING COMMENT 'Second line of the street address for the location (optional).',
    `capacity` DECIMAL(18,2) COMMENT 'Primary capacity metric (e.g., number of samples processed per day).',
    `capacity_unit` STRING COMMENT 'Unit of measure for the capacity field.',
    `city` STRING COMMENT 'City where the location is situated.',
    `closing_date` DATE COMMENT 'Date the location ceased operations (null if still active).',
    `location_code` STRING COMMENT 'External code used to reference the location in enterprise systems (e.g., plant code, site ID).',
    `compliance_status` STRING COMMENT 'Indicates whether the location meets GxP regulatory requirements.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the location resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the system.',
    `location_description` STRING COMMENT 'Free‑form text describing the location’s purpose, special features, or notes.',
    `hazard_level` STRING COMMENT 'Risk classification for safety or bio‑hazard considerations at the location.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the location in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the location in decimal degrees.',
    `location_name` STRING COMMENT 'Human‑readable name of the facility or site.',
    `opening_date` DATE COMMENT 'Date the location became operational.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the location.',
    `primary_contact_email` STRING COMMENT 'Main email address for the location’s point of contact.',
    `primary_contact_phone` STRING COMMENT 'Main telephone number for the location’s point of contact.',
    `region` STRING COMMENT 'Broad geographic region for reporting and analytics.',
    `security_clearance_required` BOOLEAN COMMENT 'True if personnel must have a security clearance to enter the location.',
    `square_feet` DECIMAL(18,2) COMMENT 'Total usable floor area of the location.',
    `state_province` STRING COMMENT 'State or province of the location.',
    `location_status` STRING COMMENT 'Current operational status of the location.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the location (e.g., America/New_York).',
    `location_type` STRING COMMENT 'Category describing the primary function of the location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the location record.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master reference table for location. Referenced by location_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`work_schedule` (
    `work_schedule_id` BIGINT COMMENT 'Primary key for work_schedule',
    `employee_id` BIGINT COMMENT 'Unique identifier of the schedule owner in the employee master.',
    `superseded_work_schedule_id` BIGINT COMMENT 'Self-referencing FK on work_schedule (superseded_work_schedule_id)',
    `applicable_employee_category` STRING COMMENT 'Employee categories to which the schedule may be assigned.',
    `compliance_status` STRING COMMENT 'Current compliance verification status of the schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the source system.',
    `work_schedule_description` STRING COMMENT 'Free‑form description of the schedule purpose and rules.',
    `effective_end_date` DATE COMMENT 'Date on which the schedule ceases to be effective (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the schedule becomes effective for assignment.',
    `gxp_training_required` BOOLEAN COMMENT 'Indicates if GxP (Good Practice) training is mandatory for employees on this schedule.',
    `is_flexible` BOOLEAN COMMENT 'Indicates whether employees may vary start/end times within the schedule.',
    `last_review_date` DATE COMMENT 'Date when the schedule was last reviewed for compliance or operational relevance.',
    `max_consecutive_work_days` STRING COMMENT 'Maximum number of days an employee can work consecutively under this schedule.',
    `min_rest_hours_between_shifts` DECIMAL(18,2) COMMENT 'Minimum required rest period between the end of one shift and the start of the next.',
    `next_review_date` DATE COMMENT 'Planned date for the next compliance or operational review.',
    `qualification_required` STRING COMMENT 'Specific qualification or certification required to work under this schedule (e.g., GxP training).',
    `schedule_code` STRING COMMENT 'Unique alphanumeric code used to reference the schedule across systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name of the schedule (e.g., "Day Shift", "On‑Call Rotation").',
    `schedule_owner` STRING COMMENT 'Full name of the manager or owner responsible for the schedule.',
    `schedule_type` STRING COMMENT 'Classification of the schedule pattern.',
    `shift_end_time` STRING COMMENT 'Planned end time of a standard shift (HH:MM, 24‑hour).',
    `shift_start_time` STRING COMMENT 'Planned start time of a standard shift (HH:MM, 24‑hour).',
    `work_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the schedule (e.g., "America/New_York").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the schedule record.',
    `version_number` STRING COMMENT 'Incremental version identifier for change management.',
    `work_hours_per_week` DECIMAL(18,2) COMMENT 'Total number of work hours allocated per week under this schedule.',
    CONSTRAINT pk_work_schedule PRIMARY KEY(`work_schedule_id`)
) COMMENT 'Master reference table for work_schedule. Referenced by work_schedule_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`grade` (
    `grade_id` BIGINT COMMENT 'Primary key for grade',
    `parent_grade_id` BIGINT COMMENT 'Self-referencing FK on grade (parent_grade_id)',
    `compensation_band` STRING COMMENT 'Internal compensation band classification for budgeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grade record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the salary amounts.',
    `effective_date` DATE COMMENT 'Date when the grade becomes active for new hires.',
    `expiration_date` DATE COMMENT 'Date when the grade is retired or no longer assignable (nullable).',
    `external_reference_code` STRING COMMENT 'Identifier used in external HR or payroll systems.',
    `grade_category` STRING COMMENT 'Broad category grouping of grades.',
    `grade_code` STRING COMMENT 'Short alphanumeric code used to identify the grade in HR systems.',
    `grade_description` STRING COMMENT 'Detailed description of responsibilities and expectations for the grade.',
    `grade_group` STRING COMMENT 'Higher‑level grouping of related grades (e.g., scientific, engineering).',
    `grade_level` STRING COMMENT 'Numeric level indicating hierarchy position of the grade.',
    `grade_name` STRING COMMENT 'Descriptive name of the grade (e.g., Senior Scientist).',
    `is_fte_eligible` BOOLEAN COMMENT 'Indicates if the grade can be assigned to full‑time equivalent positions.',
    `is_managerial` BOOLEAN COMMENT 'Flag indicating whether the grade is considered managerial.',
    `max_salary` DECIMAL(18,2) COMMENT 'Upper bound of the salary range for the grade.',
    `min_salary` DECIMAL(18,2) COMMENT 'Lower bound of the salary range for the grade.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the grade.',
    `grade_status` STRING COMMENT 'Current lifecycle status of the grade.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the grade record.',
    CONSTRAINT pk_grade PRIMARY KEY(`grade_id`)
) COMMENT 'Master reference table for grade. Referenced by grade_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`bargaining_unit` (
    `bargaining_unit_id` BIGINT COMMENT 'Primary key for bargaining_unit',
    `collective_bargaining_agreement_id` BIGINT COMMENT 'Reference to the collective bargaining agreement governing this unit.',
    `union_id` BIGINT COMMENT 'Identifier of the labor union representing the bargaining unit.',
    `parent_bargaining_unit_id` BIGINT COMMENT 'Self-referencing FK on bargaining_unit (parent_bargaining_unit_id)',
    `contract_expiration_date` DATE COMMENT 'Date the collective bargaining agreement expires.',
    `contract_signed_date` DATE COMMENT 'Date the collective bargaining agreement was signed.',
    `contract_version` STRING COMMENT 'Version identifier of the governing collective bargaining agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bargaining unit record was first created in the system.',
    `bargaining_unit_description` STRING COMMENT 'Free‑form description of the bargaining unit purpose and scope.',
    `effective_end_date` DATE COMMENT 'Date when the bargaining unit ends or is superseded; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the bargaining unit became effective.',
    `employee_count` STRING COMMENT 'Total number of employees assigned to the bargaining unit.',
    `external_reference_number` STRING COMMENT 'External system reference or legacy identifier for the bargaining unit.',
    `fte_count` DECIMAL(18,2) COMMENT 'Sum of full‑time equivalent positions within the bargaining unit.',
    `is_gxp_compliant` BOOLEAN COMMENT 'Indicates whether the bargaining unit complies with GxP regulations (True/False).',
    `jurisdiction` STRING COMMENT 'Three‑letter country code indicating the primary legal jurisdiction of the bargaining unit.',
    `last_review_date` DATE COMMENT 'Most recent date the bargaining unit details were reviewed.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bargaining unit record.',
    `location` STRING COMMENT 'Geographic region or site where the bargaining unit operates (e.g., campus, plant).',
    `next_review_date` DATE COMMENT 'Planned date for the next review of the bargaining unit.',
    `notes` STRING COMMENT 'Additional free‑form remarks or comments about the bargaining unit.',
    `bargaining_unit_status` STRING COMMENT 'Current lifecycle state of the bargaining unit.',
    `union_name` STRING COMMENT 'Name of the labor union associated with the bargaining unit.',
    `unit_code` STRING COMMENT 'External code or number used to identify the bargaining unit in HR and union systems.',
    `unit_name` STRING COMMENT 'Human‑readable name of the bargaining unit.',
    `unit_type` STRING COMMENT 'Category of the bargaining unit (e.g., union, management, technical, support).',
    CONSTRAINT pk_bargaining_unit PRIMARY KEY(`bargaining_unit_id`)
) COMMENT 'Master reference table for bargaining_unit. Referenced by bargaining_unit_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Primary key for benefit_plan',
    `superseded_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (superseded_benefit_plan_id)',
    `coinsurance_percent` DECIMAL(18,2) COMMENT 'Percentage of costs shared between employee and insurer after deductible.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed amount the employee pays per service encounter.',
    `coverage_level` STRING COMMENT 'Scope of coverage (e.g., employee only, employee + spouse, family).',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual amount the employee must pay before benefits apply.',
    `effective_from` DATE COMMENT 'Date when the benefit plan becomes binding.',
    `effective_until` DATE COMMENT 'Date when the benefit plan ends; null if open‑ended.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which employees qualify for the plan.',
    `employee_contribution_percent` DECIMAL(18,2) COMMENT 'Percentage of premium paid by the employee.',
    `employer_contribution_percent` DECIMAL(18,2) COMMENT 'Percentage of premium paid by the employer.',
    `enrollment_end_date` DATE COMMENT 'Last date employees may enroll in the plan.',
    `enrollment_start_date` DATE COMMENT 'First date employees may enroll in the plan.',
    `is_gxp_compliant` BOOLEAN COMMENT 'Indicates whether the plan complies with GxP regulations.',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'Maximum annual amount employee pays after which plan covers 100%.',
    `plan_category` STRING COMMENT 'Classification of the plan based on eligible participant groups.',
    `plan_code` STRING COMMENT 'Short alphanumeric code used to reference the benefit plan in HR systems.',
    `plan_description` STRING COMMENT 'Detailed narrative describing plan benefits and rules.',
    `plan_document_url` STRING COMMENT 'Link to the official plan document.',
    `plan_name` STRING COMMENT 'Human‑readable name of the benefit plan.',
    `plan_type` STRING COMMENT 'Category of benefits provided by the plan.',
    `plan_version` STRING COMMENT 'Version number of the plan for change management.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Periodic amount the employee pays for the plan.',
    `premium_currency` STRING COMMENT 'Currency of the premium amount.',
    `provider_code` BIGINT COMMENT 'Identifier of the benefit provider.',
    `provider_name` STRING COMMENT 'Name of the external vendor delivering the benefits.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the benefit plan record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the benefit plan record.',
    `regulatory_approval_date` DATE COMMENT 'Date the plan received required regulatory approval.',
    `regulatory_body` STRING COMMENT 'Authority that approved the benefit plan.',
    `benefit_plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by benefit_plan_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`training_item` (
    `training_item_id` BIGINT COMMENT 'Primary key for training_item',
    `prerequisite_training_item_id` BIGINT COMMENT 'Self-referencing FK on training_item (prerequisite_training_item_id)',
    `assessment_type` STRING COMMENT 'Method used to evaluate learner performance.',
    `author` STRING COMMENT 'Name of the individual or team that created the training content.',
    `certification_name` STRING COMMENT 'Name of the certification granted upon successful completion.',
    `certification_required` BOOLEAN COMMENT 'True if successful completion awards a formal certification.',
    `training_item_code` STRING COMMENT 'Business‑assigned unique code used to reference the training item in catalogs and LMS systems.',
    `compliance_required` BOOLEAN COMMENT 'True if the training is required to meet external regulatory compliance.',
    `cost` DECIMAL(18,2) COMMENT 'Monetary cost to enroll in the training item.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training item record was first created in the system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Accredited credit value associated with the training item.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the training cost.',
    `delivery_method` STRING COMMENT 'How the training is delivered to participants.',
    `training_item_description` STRING COMMENT 'Detailed narrative describing the content, objectives, and scope of the training item.',
    `duration_minutes` STRING COMMENT 'Total length of the training item expressed in minutes.',
    `effective_from` DATE COMMENT 'Date when the training item becomes available for enrollment.',
    `effective_until` DATE COMMENT 'Date after which the training item is no longer offered (null if open‑ended).',
    `external_reference_code` STRING COMMENT 'Identifier used by external Learning Management Systems to reference this training item.',
    `format` STRING COMMENT 'Technical format of the training material.',
    `gxp_training` BOOLEAN COMMENT 'True if the training satisfies Good Laboratory Practice (GLP), Good Manufacturing Practice (GMP), or related regulatory requirements.',
    `language` STRING COMMENT 'Natural language in which the training content is presented.',
    `language_code` STRING COMMENT 'ISO 639‑2 three‑letter code representing the training language.',
    `last_review_date` DATE COMMENT 'Date the training content was last reviewed for relevance and accuracy.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the training item is mandatory for the assigned audience.',
    `max_attempts` STRING COMMENT 'Maximum number of times a learner may attempt the assessment.',
    `training_item_name` STRING COMMENT 'Human‑readable title of the training item.',
    `owner` STRING COMMENT 'Department or business unit responsible for the training item.',
    `pass_score` DECIMAL(18,2) COMMENT 'Minimum percentage required to pass the assessment.',
    `prerequisite_flag` BOOLEAN COMMENT 'Indicates whether completion of other training items is required before this one.',
    `retention_period_days` STRING COMMENT 'Number of days the training record must be retained for compliance.',
    `review_cycle_months` STRING COMMENT 'Planned interval in months between mandatory content reviews.',
    `training_item_status` STRING COMMENT 'Current lifecycle state of the training item.',
    `target_audience` STRING COMMENT 'Primary employee group(s) for which the training is intended.',
    `training_item_type` STRING COMMENT 'Category that classifies the training item by its primary focus area.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training item record.',
    `version` STRING COMMENT 'Version identifier for the training content (e.g., v1.2).',
    CONSTRAINT pk_training_item PRIMARY KEY(`training_item_id`)
) COMMENT 'Master reference table for training_item. Referenced by training_item_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Primary key for payroll_run',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who initiated or approved the payroll run.',
    `payroll_cycle_id` BIGINT COMMENT 'Identifier of the recurring payroll cycle to which this run belongs.',
    `reversal_payroll_run_id` BIGINT COMMENT 'Self-referencing FK on payroll_run (reversal_payroll_run_id)',
    `adjustment_reason` STRING COMMENT 'Reason code or description for any manual adjustments applied to the payroll run.',
    `audit_trail` STRING COMMENT 'JSON string capturing key audit events for the payroll run (e.g., approvals, rejections).',
    `company_code` BIGINT COMMENT 'Identifier of the legal entity (company) for which the payroll run is processed.',
    `compliance_status` STRING COMMENT 'Result of compliance validation for the payroll run.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the payroll amounts.',
    `payroll_run_description` STRING COMMENT 'Free‑form description or notes about the payroll run.',
    `employee_count` STRING COMMENT 'Number of distinct employee records included in the payroll run.',
    `is_gxp_compliant` BOOLEAN COMMENT 'Indicates whether the payroll run complies with GxP regulatory requirements.',
    `is_manual_override` BOOLEAN COMMENT 'True if the payroll run was manually adjusted after automatic processing.',
    `pay_date` DATE COMMENT 'Scheduled date on which employees receive payment for this payroll run.',
    `payroll_provider_code` BIGINT COMMENT 'Identifier of the external payroll service provider (if outsourced).',
    `payroll_run_number` STRING COMMENT 'Human‑readable identifier or number assigned to the payroll run by the finance system.',
    `payroll_type` STRING COMMENT 'Category of payroll processing (e.g., regular salary, bonus, overtime).',
    `period_end_date` DATE COMMENT 'Last day of the payroll period covered by this run.',
    `period_start_date` DATE COMMENT 'First day of the payroll period covered by this run.',
    `run_timestamp` TIMESTAMP COMMENT 'Date and time when the payroll run was executed.',
    `source_system` STRING COMMENT 'Originating HR/Payroll system that generated the payroll run data.',
    `payroll_run_status` STRING COMMENT 'Current lifecycle status of the payroll run.',
    `total_benefit_amount` DECIMAL(18,2) COMMENT 'Aggregate employer‑paid benefit contributions included in the payroll run.',
    `total_deduction_amount` DECIMAL(18,2) COMMENT 'Sum of all deductions (taxes, benefits, garnishments) applied to the payroll run.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of gross earnings for all employees in this payroll run before deductions.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount paid to employees after all deductions for this payroll run.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Aggregate tax withholdings deducted from the gross amount in this payroll run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll run record.',
    `version_number` STRING COMMENT 'Version number of the payroll run record for audit purposes.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master reference table for payroll_run. Referenced by payroll_run_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`review_cycle` (
    `review_cycle_id` BIGINT COMMENT 'Primary key for review_cycle',
    `previous_review_cycle_id` BIGINT COMMENT 'Self-referencing FK on review_cycle (previous_review_cycle_id)',
    `review_cycle_code` STRING COMMENT 'Short code used to identify the review cycle in systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the review cycle record was initially created.',
    `cycle_type` STRING COMMENT 'Category of the review cycle indicating its recurrence pattern.',
    `review_cycle_description` STRING COMMENT 'Detailed description of the purpose and scope of the review cycle.',
    `effective_from` DATE COMMENT 'Date when this review cycle definition becomes effective.',
    `effective_until` DATE COMMENT 'Date when this review cycle definition expires; null if indefinite.',
    `eligibility_criteria` STRING COMMENT 'Textual criteria defining which employees are eligible for this review cycle.',
    `end_month` STRING COMMENT 'Calendar month (1-12) when the review cycle period ends.',
    `frequency_months` STRING COMMENT 'Number of months between successive occurrences of this review cycle.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the review cycle is mandatory for all applicable employees.',
    `review_cycle_name` STRING COMMENT 'Descriptive name of the review cycle (e.g., Annual Performance Review).',
    `notes` STRING COMMENT 'Additional free-form notes regarding the review cycle.',
    `owner_department` STRING COMMENT 'Organizational department responsible for managing the review cycle.',
    `review_window_days` STRING COMMENT 'Number of days allocated for employees to complete the review within the cycle.',
    `start_month` STRING COMMENT 'Calendar month (1-12) when the review cycle period begins.',
    `review_cycle_status` STRING COMMENT 'Current lifecycle status of the review cycle definition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the review cycle record.',
    `version_number` STRING COMMENT 'Version number of the review cycle definition, incremented on changes.',
    CONSTRAINT pk_review_cycle PRIMARY KEY(`review_cycle_id`)
) COMMENT 'Master reference table for review_cycle. Referenced by review_cycle_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`union` (
    `union_id` BIGINT COMMENT 'Primary key for union',
    `parent_union_id` BIGINT COMMENT 'Self-referencing FK on union (parent_union_id)',
    `abbreviation` STRING COMMENT 'Common short form or acronym for the union (e.g., "UAW").',
    `address_line1` STRING COMMENT 'Primary street address of the unions headquarters.',
    `address_line2` STRING COMMENT 'Additional address information (suite, floor, etc.).',
    `cba_number` STRING COMMENT 'Identifier of the primary collective bargaining agreement associated with the union.',
    `city` STRING COMMENT 'City where the unions main office is located.',
    `classification` STRING COMMENT 'Legal classification of the union entity.',
    `contact_email` STRING COMMENT 'Primary email address for union communications and notifications.',
    `contact_phone` STRING COMMENT 'Main telephone number for the union office.',
    `country_code` STRING COMMENT 'Three‑letter country code where the union is registered.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the union record was first inserted into the system.',
    `union_description` STRING COMMENT 'Narrative description providing context about the unions purpose and coverage.',
    `effective_date` DATE COMMENT 'Date on which the unions agreement or registration became effective.',
    `union_name` STRING COMMENT 'Official full name of the labor union as used in contracts and communications.',
    `number_of_members` BIGINT COMMENT 'Total count of individual members covered under the union agreement.',
    `postal_code` STRING COMMENT 'Postal code for the unions mailing address.',
    `state_province` STRING COMMENT 'State or province component of the unions address.',
    `union_status` STRING COMMENT 'Current lifecycle status of the union record.',
    `tax_id` STRING COMMENT 'Federal tax identification number for the union, used for reporting and compliance.',
    `termination_date` DATE COMMENT 'Date the union ceased to be active or was dissolved.',
    `union_type` STRING COMMENT 'Scope of the unions representation (e.g., national, regional).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the union record.',
    `website_url` STRING COMMENT 'Public website address where union information is published.',
    CONSTRAINT pk_union PRIMARY KEY(`union_id`)
) COMMENT 'Master reference table for union. Referenced by union_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` (
    `collective_bargaining_agreement_id` BIGINT COMMENT 'Primary key for collective_bargaining_agreement',
    `superseded_collective_bargaining_agreement_id` BIGINT COMMENT 'Self-referencing FK on collective_bargaining_agreement (superseded_collective_bargaining_agreement_id)',
    `agreement_number` STRING COMMENT 'Official reference number assigned to the collective bargaining agreement.',
    `agreement_title` STRING COMMENT 'Descriptive title of the agreement.',
    `agreement_type` STRING COMMENT 'Category of the agreement based on its scope.',
    `amendment_indicator` STRING COMMENT 'Indicates if the agreement has been amended.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment, if applicable.',
    `arbitration_clause` STRING COMMENT 'Details of arbitration provisions for dispute resolution.',
    `benefits_summary` STRING COMMENT 'Overview of benefits (health, retirement, etc.) provided under the agreement.',
    `classification` STRING COMMENT 'Indicates whether the agreement is collective or individual.',
    `collective_bargaining_unit` STRING COMMENT 'Name of the specific employee group covered.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the agreement document.',
    `coverage_geography` STRING COMMENT 'Geographic scope of the agreement.',
    `document_url` STRING COMMENT 'Link to the stored digital copy of the agreement.',
    `document_version` STRING COMMENT 'Version identifier of the agreement document.',
    `effective_from` DATE COMMENT 'Date when the agreement becomes effective.',
    `effective_until` DATE COMMENT 'Date when the agreement expires or is terminated; null if open-ended.',
    `employer_id` BIGINT COMMENT 'Unique identifier for the employer entity.',
    `employer_name` STRING COMMENT 'Name of the employer party (Genomics Biotech).',
    `expiration_notice_sent` BOOLEAN COMMENT 'Indicates whether a notice of upcoming expiration has been sent.',
    `grievance_procedure` STRING COMMENT 'Description of the process for handling grievances under the agreement.',
    `labor_law_jurisdiction` STRING COMMENT 'Legal jurisdiction governing the agreement.',
    `negotiation_end_date` DATE COMMENT 'Date when negotiations concluded.',
    `negotiation_start_date` DATE COMMENT 'Date when negotiations for the agreement commenced.',
    `number_of_employees_covered` STRING COMMENT 'Count of employees covered by the agreement.',
    `parent_agreement_id` BIGINT COMMENT 'Reference to a parent agreement if this is an amendment or subsidiary.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `renewal_option` STRING COMMENT 'Specifies the renewal mechanism for the agreement.',
    `signatory_employer_rep_email` STRING COMMENT 'Email address of the employer signatory.',
    `signatory_employer_rep_name` STRING COMMENT 'Full name of the employer representative who signed the agreement.',
    `signatory_union_rep_email` STRING COMMENT 'Email address of the union signatory.',
    `signatory_union_rep_name` STRING COMMENT 'Full name of the union representative who signed the agreement.',
    `signed_date` DATE COMMENT 'Date when the agreement was formally signed by parties.',
    `collective_bargaining_agreement_status` STRING COMMENT 'Current lifecycle status of the agreement.',
    `union_id` BIGINT COMMENT 'Unique identifier for the union entity.',
    `union_name` STRING COMMENT 'Name of the labor union party to the agreement.',
    `wage_scale_description` STRING COMMENT 'Summary of wage scales and pay grades defined in the agreement.',
    CONSTRAINT pk_collective_bargaining_agreement PRIMARY KEY(`collective_bargaining_agreement_id`)
) COMMENT 'Master reference table for collective_bargaining_agreement. Referenced by cba_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`workforce`.`payroll_cycle` (
    `payroll_cycle_id` BIGINT COMMENT 'Primary key for payroll_cycle',
    `previous_payroll_cycle_id` BIGINT COMMENT 'Self-referencing FK on payroll_cycle (previous_payroll_cycle_id)',
    `payroll_cycle_code` STRING COMMENT 'Short alphanumeric code used to identify the payroll cycle in systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll cycle record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for payroll payments (e.g., USD).',
    `payroll_cycle_description` STRING COMMENT 'Detailed description of the payroll cycle purpose and rules.',
    `effective_from` DATE COMMENT 'Date when this payroll cycle definition becomes effective.',
    `effective_until` DATE COMMENT 'Date when this payroll cycle definition is retired (null if still active).',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1-4) associated with the payroll cycle.',
    `fiscal_year` STRING COMMENT 'Fiscal year associated with the payroll cycle (e.g., 2024).',
    `frequency` STRING COMMENT 'How often payroll is processed for this cycle.',
    `gxp_compliant` BOOLEAN COMMENT 'Indicates whether the payroll cycle complies with GxP regulations.',
    `is_default` BOOLEAN COMMENT 'Indicates if this payroll cycle is the default for new employees.',
    `payroll_cycle_name` STRING COMMENT 'Descriptive name of the payroll cycle.',
    `notes` STRING COMMENT 'Free-text field for any additional information or remarks.',
    `pay_date_offset` STRING COMMENT 'Number of days after period end when payment is issued.',
    `payroll_cycle_type` STRING COMMENT 'Classification of the payroll cycle purpose.',
    `payroll_period_end_day` STRING COMMENT 'Day of month when the payroll period ends (1-31).',
    `payroll_period_start_day` STRING COMMENT 'Day of month when the payroll period starts (1-31).',
    `payroll_cycle_status` STRING COMMENT 'Current lifecycle status of the payroll cycle definition.',
    `tax_withholding_code` STRING COMMENT 'Code representing tax withholding rules applied to this payroll cycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll cycle record.',
    CONSTRAINT pk_payroll_cycle PRIMARY KEY(`payroll_cycle_id`)
) COMMENT 'Master reference table for payroll_cycle. Referenced by payroll_cycle_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_location_id` FOREIGN KEY (`location_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_location_id` FOREIGN KEY (`location_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ADD CONSTRAINT `fk_workforce_workforce_assignment_bargaining_unit_id` FOREIGN KEY (`bargaining_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`bargaining_unit`(`bargaining_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ADD CONSTRAINT `fk_workforce_workforce_assignment_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`grade`(`grade_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ADD CONSTRAINT `fk_workforce_workforce_assignment_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ADD CONSTRAINT `fk_workforce_workforce_assignment_location_id` FOREIGN KEY (`location_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ADD CONSTRAINT `fk_workforce_workforce_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ADD CONSTRAINT `fk_workforce_workforce_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ADD CONSTRAINT `fk_workforce_workforce_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ADD CONSTRAINT `fk_workforce_workforce_assignment_work_schedule_id` FOREIGN KEY (`work_schedule_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`work_schedule`(`work_schedule_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_compensation_employee_id` FOREIGN KEY (`compensation_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_primary_gxp_employee_id` FOREIGN KEY (`primary_gxp_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_quaternary_gxp_waiver_approved_by_employee_id` FOREIGN KEY (`quaternary_gxp_waiver_approved_by_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_quinary_gxp_created_by_user_employee_id` FOREIGN KEY (`quinary_gxp_created_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_tertiary_gxp_assessor_employee_id` FOREIGN KEY (`tertiary_gxp_assessor_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_training_item_id` FOREIGN KEY (`training_item_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`training_item`(`training_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_workforce_training_curriculum_id` FOREIGN KEY (`workforce_training_curriculum_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum`(`workforce_training_curriculum_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ADD CONSTRAINT `fk_workforce_workforce_training_curriculum_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ADD CONSTRAINT `fk_workforce_workforce_training_curriculum_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_review_cycle_id` FOREIGN KEY (`review_cycle_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`review_cycle`(`review_cycle_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_goal_employee_id` FOREIGN KEY (`goal_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_goal_manager_employee_id` FOREIGN KEY (`goal_manager_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ADD CONSTRAINT `fk_workforce_talent_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_requisition_hiring_manager_employee_id` FOREIGN KEY (`requisition_hiring_manager_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_requisition_last_modified_by_employee_id` FOREIGN KEY (`requisition_last_modified_by_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_requisition_recruiter_employee_id` FOREIGN KEY (`requisition_recruiter_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_candidate_hiring_manager_employee_id` FOREIGN KEY (`candidate_hiring_manager_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_candidate_recruiter_employee_id` FOREIGN KEY (`candidate_recruiter_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_candidate_referral_employee_id` FOREIGN KEY (`candidate_referral_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`requisition`(`requisition_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_absence_plan_id` FOREIGN KEY (`absence_plan_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`absence_plan`(`absence_plan_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_primary_absence_employee_id` FOREIGN KEY (`primary_absence_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_workforce_assignment_id` FOREIGN KEY (`workforce_assignment_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`workforce_assignment`(`workforce_assignment_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_location_id` FOREIGN KEY (`location_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_tertiary_headcount_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_headcount_last_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ADD CONSTRAINT `fk_workforce_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ADD CONSTRAINT `fk_workforce_lifecycle_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ADD CONSTRAINT `fk_workforce_lifecycle_event_primary_lifecycle_employee_id` FOREIGN KEY (`primary_lifecycle_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ADD CONSTRAINT `fk_workforce_lifecycle_event_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ADD CONSTRAINT `fk_workforce_lifecycle_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ADD CONSTRAINT `fk_workforce_lifecycle_event_position_id` FOREIGN KEY (`position_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ADD CONSTRAINT `fk_workforce_lifecycle_event_prior_location_id` FOREIGN KEY (`prior_location_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ADD CONSTRAINT `fk_workforce_lifecycle_event_quaternary_lifecycle_initiating_manager_employee_id` FOREIGN KEY (`quaternary_lifecycle_initiating_manager_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ADD CONSTRAINT `fk_workforce_lifecycle_event_quinary_lifecycle_hr_business_partner_employee_id` FOREIGN KEY (`quinary_lifecycle_hr_business_partner_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ADD CONSTRAINT `fk_workforce_lifecycle_event_tertiary_lifecycle_new_manager_employee_id` FOREIGN KEY (`tertiary_lifecycle_new_manager_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ADD CONSTRAINT `fk_workforce_lab_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_workforce_assignment_id` FOREIGN KEY (`workforce_assignment_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`workforce_assignment`(`workforce_assignment_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_location_id` FOREIGN KEY (`location_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_primary_time_employee_id` FOREIGN KEY (`primary_time_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_workforce_assignment_id` FOREIGN KEY (`workforce_assignment_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`workforce_assignment`(`workforce_assignment_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_adjusted_time_entry_id` FOREIGN KEY (`adjusted_time_entry_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`time_entry`(`time_entry_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ADD CONSTRAINT `fk_workforce_genomic_access_grant_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ADD CONSTRAINT `fk_workforce_genomic_access_grant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ADD CONSTRAINT `fk_workforce_genome_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_superseded_compensation_plan_id` FOREIGN KEY (`superseded_compensation_plan_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_plan` ADD CONSTRAINT `fk_workforce_absence_plan_superseded_absence_plan_id` FOREIGN KEY (`superseded_absence_plan_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`absence_plan`(`absence_plan_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ADD CONSTRAINT `fk_workforce_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`work_schedule` ADD CONSTRAINT `fk_workforce_work_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`work_schedule` ADD CONSTRAINT `fk_workforce_work_schedule_superseded_work_schedule_id` FOREIGN KEY (`superseded_work_schedule_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`work_schedule`(`work_schedule_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`grade` ADD CONSTRAINT `fk_workforce_grade_parent_grade_id` FOREIGN KEY (`parent_grade_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`grade`(`grade_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`bargaining_unit` ADD CONSTRAINT `fk_workforce_bargaining_unit_collective_bargaining_agreement_id` FOREIGN KEY (`collective_bargaining_agreement_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement`(`collective_bargaining_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`bargaining_unit` ADD CONSTRAINT `fk_workforce_bargaining_unit_union_id` FOREIGN KEY (`union_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`union`(`union_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`bargaining_unit` ADD CONSTRAINT `fk_workforce_bargaining_unit_parent_bargaining_unit_id` FOREIGN KEY (`parent_bargaining_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`bargaining_unit`(`bargaining_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`training_item` ADD CONSTRAINT `fk_workforce_training_item_prerequisite_training_item_id` FOREIGN KEY (`prerequisite_training_item_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`training_item`(`training_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_payroll_cycle_id` FOREIGN KEY (`payroll_cycle_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`payroll_cycle`(`payroll_cycle_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_reversal_payroll_run_id` FOREIGN KEY (`reversal_payroll_run_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_previous_review_cycle_id` FOREIGN KEY (`previous_review_cycle_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`review_cycle`(`review_cycle_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ADD CONSTRAINT `fk_workforce_union_parent_union_id` FOREIGN KEY (`parent_union_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`union`(`union_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` ADD CONSTRAINT `fk_workforce_collective_bargaining_agreement_superseded_collective_bargaining_agreement_id` FOREIGN KEY (`superseded_collective_bargaining_agreement_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement`(`collective_bargaining_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_cycle` ADD CONSTRAINT `fk_workforce_payroll_cycle_previous_payroll_cycle_id` FOREIGN KEY (`previous_payroll_cycle_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`payroll_cycle`(`payroll_cycle_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `genomics_biotech_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `clia_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `clia_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|expired|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|leave_of_absence|suspended|terminated');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|intern|temporary');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `is_clia_personnel` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Personnel Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `is_field_application_specialist` SET TAGS ('dbx_business_glossary_term' = 'Field Application Specialist (FAS) Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `is_gxp_role` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Role Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `last_training_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Update Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|confidential|secret');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary_resignation|involuntary_termination|retirement|end_of_contract|layoff|death');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `training_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Training Compliance Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `training_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|overdue|pending|not_required');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `visa_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Visa Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `visa_expiration_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `visa_expiration_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `visa_status` SET TAGS ('dbx_business_glossary_term' = 'Visa Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `visa_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `visa_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `work_country_code` SET TAGS ('dbx_business_glossary_term' = 'Work Country Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `work_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `work_email_address` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `work_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `work_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `work_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `work_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `work_location_name` SET TAGS ('dbx_business_glossary_term' = 'Work Location Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `actual_filled_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Filled Count');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `approved_headcount` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `budget_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `budget_allocation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `clia_director_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Director Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `clia_supervisor_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Supervisor Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `contractor_fte_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Contractor Full-Time Equivalent (FTE) Equivalent');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Position Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Position Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `exempt_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exempt Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `exempt_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `gxp_designated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Designated Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|postdoctoral');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `open_requisition_count` SET TAGS ('dbx_business_glossary_term' = 'Open Requisition Count');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `planned_headcount` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|filled|vacant|frozen|eliminated|pending_approval');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `rd_capitalization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Capitalization Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `remote_work_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `safety_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Sensitive Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `variance_to_plan` SET TAGS ('dbx_business_glossary_term' = 'Variance to Plan');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Site ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `mdm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Mdm Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Head Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `cap_accredited_flag` SET TAGS ('dbx_business_glossary_term' = 'College of American Pathologists (CAP) Accredited Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `clia_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Certified Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `gl_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `gl_cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `gxp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Regulated Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_actual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_planned` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_planned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `iso_13485_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 13485 Certified Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,12}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `clia_personnel_category` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Personnel Category');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `core_competencies` SET TAGS ('dbx_business_glossary_term' = 'Core Competencies');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `fte_planning_category` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Planning Category');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `fte_planning_category` SET TAGS ('dbx_value_regex' = 'direct_labor|indirect_labor|research_and_development|sales_and_marketing|general_and_administrative');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `gxp_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Role Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `gxp_training_requirements` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Training Requirements');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `performance_management_template` SET TAGS ('dbx_business_glossary_term' = 'Performance Management Template');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `physical_requirements` SET TAGS ('dbx_business_glossary_term' = 'Physical Requirements');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `preferred_certifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Certifications');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `preferred_education_field` SET TAGS ('dbx_business_glossary_term' = 'Preferred Education Field');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Description');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|deprecated');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `regulatory_qualification_criteria` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Qualification Criteria');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `remote_work_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligibility');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `remote_work_eligibility` SET TAGS ('dbx_value_regex' = 'fully_remote|hybrid|onsite_only');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `safety_training_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Requirements');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `succession_planning_tier` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Tier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `succession_planning_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `supervisory_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Role Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `technical_skills` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `workforce_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `bargaining_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `work_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `actual_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Termination Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Assignment Category');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `assignment_category` SET TAGS ('dbx_value_regex' = 'full_time|part_time|temporary|contract|intern');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `assignment_name` SET TAGS ('dbx_business_glossary_term' = 'Assignment Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|concurrent|contingent|project');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `clia_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Qualified Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'employee|contractor|consultant|temporary|intern');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `gxp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Critical Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `last_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Qualification Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `next_qualification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Qualification Due Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `pay_basis` SET TAGS ('dbx_business_glossary_term' = 'Pay Basis');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `pay_basis` SET TAGS ('dbx_value_regex' = 'salary|hourly|commission|piece_rate');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `primary_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `remote_work_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|flexible|on_call');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `training_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Training Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `training_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|in_training|expired|not_required');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ALTER COLUMN `travel_required_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Required Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` SET TAGS ('dbx_subdomain' = 'compensation_management');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `compa_ratio` SET TAGS ('dbx_business_glossary_term' = 'Comparative Ratio (Compa-Ratio)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `compa_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,15}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_quantity` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Quantity');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_quantity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_quantity` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_type` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_type` SET TAGS ('dbx_value_regex' = 'rsu|stock_option|espp|none');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_value` SET TAGS ('dbx_business_glossary_term' = 'Equity Grant Value');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `equity_grant_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `field_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Field Allowance Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `field_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,15}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Compensation Review Cycle');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,50}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `variable_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Variable Pay Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `variable_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `variable_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `variable_pay_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variable Pay Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation` ALTER COLUMN `variable_pay_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|not_required');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_percentage` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Relationship');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Provider Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_provider_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Benefit Provider Policy Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_provider_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_election_deadline` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Election Deadline');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_eligible_indicator` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Indicator');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `confirmation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Sent Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|family');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_reason` SET TAGS ('dbx_value_regex' = 'open_enrollment|new_hire|qualifying_life_event|annual_renewal|plan_change|rehire');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'employee_self_service|hr_administrator|benefits_broker|call_center|paper_form|automated_import');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|waived|terminated|suspended|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `hipaa_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Certification Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `provider_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Enrollment Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_indicator` SET TAGS ('dbx_business_glossary_term' = 'Waiver Indicator');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` SET TAGS ('dbx_subdomain' = 'training_compliance');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `gxp_training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Training Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `primary_gxp_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `primary_gxp_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `primary_gxp_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quality_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Rule Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quaternary_gxp_waiver_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quaternary_gxp_waiver_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quaternary_gxp_waiver_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quinary_gxp_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quinary_gxp_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quinary_gxp_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `tertiary_gxp_assessor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `tertiary_gxp_assessor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `tertiary_gxp_assessor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_item_id` SET TAGS ('dbx_business_glossary_term' = 'Training Item Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `workforce_training_curriculum_id` SET TAGS ('dbx_business_glossary_term' = 'Training Curriculum Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `cap_accreditation_flag` SET TAGS ('dbx_business_glossary_term' = 'College of American Pathologists (CAP) Accreditation Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `clia_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Training Due Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `gxp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Critical Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_assessed|pending');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `qualification_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Requalification Due Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `requalification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Requalification Frequency in Months');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `sop_document_number` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Document Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `trainer_name` SET TAGS ('dbx_business_glossary_term' = 'Trainer Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Hours');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_item_code` SET TAGS ('dbx_business_glossary_term' = 'Training Item Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_item_title` SET TAGS ('dbx_business_glossary_term' = 'Training Item Title');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_notes` SET TAGS ('dbx_business_glossary_term' = 'Training Notes');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_version` SET TAGS ('dbx_business_glossary_term' = 'Training Version');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` SET TAGS ('dbx_subdomain' = 'training_compliance');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `workforce_training_curriculum_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Training Curriculum Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Owner Organizational Unit Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'MasterControl Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Owner Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `applicable_job_profiles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Job Profiles');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `cap_required_flag` SET TAGS ('dbx_business_glossary_term' = 'College of American Pathologists (CAP) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `clia_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `curriculum_code` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `curriculum_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `curriculum_name` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `curriculum_status` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `curriculum_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|retired|obsolete');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `curriculum_type` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `curriculum_type` SET TAGS ('dbx_value_regex' = 'initial_qualification|requalification|continuing_education|role_based|regulatory_compliance|technical_skills');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `estimated_completion_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Hours');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `gcp_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Clinical Practice (GCP) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `glp_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Laboratory Practice (GLP) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `gmp_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `gxp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Regulated Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `iso_13485_required_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 13485 Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `mandatory_items_count` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Items Count');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `minimum_passing_score_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Passing Score Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `practical_demonstration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Practical Demonstration Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `prerequisites` SET TAGS ('dbx_business_glossary_term' = 'Prerequisites');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `requalification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Requalification Frequency in Months');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `requalification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Requalification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `sequencing_rules` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Rules');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `target_audience_description` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `total_training_items_count` SET TAGS ('dbx_business_glossary_term' = 'Total Training Items Count');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `workforce_training_curriculum_description` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Description');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `bonus_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_calibrated|calibration_scheduled|calibrated|calibration_adjusted');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `collaboration_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Competency Rating');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `collaboration_competency_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_areas_summary` SET TAGS ('dbx_business_glossary_term' = 'Development Areas Summary');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `flight_risk_indicator` SET TAGS ('dbx_business_glossary_term' = 'Flight Risk Indicator');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `flight_risk_indicator` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `goals_achieved_count` SET TAGS ('dbx_business_glossary_term' = 'Goals Achieved Count');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `goals_total_count` SET TAGS ('dbx_business_glossary_term' = 'Total Goals Count');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `high_potential_flag` SET TAGS ('dbx_business_glossary_term' = 'High Potential (HiPo) Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `hr_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `innovation_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Innovation Competency Rating');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `innovation_competency_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Competency Rating');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_competency_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `manager_narrative` SET TAGS ('dbx_business_glossary_term' = 'Manager Narrative');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Recommended Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `pre_calibration_rating` SET TAGS ('dbx_business_glossary_term' = 'Pre-Calibration Rating');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `pre_calibration_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|project_based|promotion|pip');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Strengths Summary');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `succession_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Succession Readiness Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `succession_readiness_level` SET TAGS ('dbx_value_regex' = 'ready_now|ready_1_year|ready_2_3_years|not_ready|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `technical_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Competency Rating');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `technical_competency_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`performance_review` ALTER COLUMN `weighted_goal_score` SET TAGS ('dbx_business_glossary_term' = 'Weighted Goal Score');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_id` SET TAGS ('dbx_business_glossary_term' = 'Goal Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `achievement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Achievement Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_business_glossary_term' = 'Goal Category');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_category` SET TAGS ('dbx_value_regex' = 'operational|strategic|development|compliance|innovation|quality');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_code` SET TAGS ('dbx_business_glossary_term' = 'Goal Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_description` SET TAGS ('dbx_business_glossary_term' = 'Goal Description');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_status` SET TAGS ('dbx_business_glossary_term' = 'Goal Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_status` SET TAGS ('dbx_value_regex' = 'draft|active|in_progress|completed|cancelled|deferred');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_type` SET TAGS ('dbx_business_glossary_term' = 'Goal Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `goal_type` SET TAGS ('dbx_value_regex' = 'individual|team|departmental|corporate|stretch');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `gxp_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Related Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Comments');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'quantitative|qualitative|milestone|binary');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `okr_alignment` SET TAGS ('dbx_business_glossary_term' = 'Objectives and Key Results (OKR) Alignment');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|partially_meets|does_not_meet|not_rated');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Goal Priority');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `rd_capitalization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Capitalization Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `regulatory_milestone_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Milestone Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `strategic_pillar` SET TAGS ('dbx_business_glossary_term' = 'Strategic Pillar');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `stretch_target_value` SET TAGS ('dbx_business_glossary_term' = 'Stretch Target Value');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `target_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Metric');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Goal Title');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `visibility_level` SET TAGS ('dbx_business_glossary_term' = 'Visibility Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `visibility_level` SET TAGS ('dbx_value_regex' = 'private|manager|team|department|public');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`goal` ALTER COLUMN `weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Goal Weight Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `abmgg_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'American Board of Medical Genetics and Genomics (ABMGG) Certified Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `additional_languages` SET TAGS ('dbx_business_glossary_term' = 'Additional Languages');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `ascp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'American Society for Clinical Pathology (ASCP) Certified Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `bioinformatics_pipeline_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Bioinformatics Pipeline Development Proficiency');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `bioinformatics_pipeline_proficiency` SET TAGS ('dbx_value_regex' = 'none|basic|intermediate|advanced|expert');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `career_aspiration` SET TAGS ('dbx_business_glossary_term' = 'Career Aspiration');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `clia_personnel_category` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Personnel Category');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `clia_personnel_category` SET TAGS ('dbx_value_regex' = 'director|technical_supervisor|clinical_consultant|general_supervisor|testing_personnel|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `clinical_assay_validation_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Clinical Assay Validation Proficiency');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `clinical_assay_validation_proficiency` SET TAGS ('dbx_value_regex' = 'none|basic|intermediate|advanced|expert');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `crispr_editing_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Clustered Regularly Interspaced Short Palindromic Repeats (CRISPR) Editing Proficiency');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `crispr_editing_proficiency` SET TAGS ('dbx_value_regex' = 'none|basic|intermediate|advanced|expert');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `critical_talent_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Talent Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `development_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `development_plan_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|on_hold');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `education_field` SET TAGS ('dbx_business_glossary_term' = 'Education Field of Study');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `flight_risk_indicator` SET TAGS ('dbx_business_glossary_term' = 'Flight Risk Indicator');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `flight_risk_indicator` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `geographic_mobility_preference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Mobility Preference');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `geographic_mobility_preference` SET TAGS ('dbx_value_regex' = 'not_mobile|local|regional|national|international');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `gmp_experience_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Experience Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `graduation_year` SET TAGS ('dbx_business_glossary_term' = 'Graduation Year');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `gxp_training_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Training Current Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `high_potential_flag` SET TAGS ('dbx_business_glossary_term' = 'High Potential (HiPo) Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|postdoctoral');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `institution_name` SET TAGS ('dbx_business_glossary_term' = 'Educational Institution Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `language_proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Language Proficiency Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `language_proficiency_level` SET TAGS ('dbx_value_regex' = 'basic|conversational|professional|native');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `last_competency_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Competency Assessment Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `lims_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Proficiency');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `lims_proficiency` SET TAGS ('dbx_value_regex' = 'none|basic|intermediate|advanced|expert');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `next_competency_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Competency Assessment Due Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `ngs_library_prep_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Next-Generation Sequencing (NGS) Library Preparation Proficiency');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `ngs_library_prep_proficiency` SET TAGS ('dbx_value_regex' = 'none|basic|intermediate|advanced|expert');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `patents_count` SET TAGS ('dbx_business_glossary_term' = 'Patents Count');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `pmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Project Management Professional (PMP) Certified Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `preferred_career_path` SET TAGS ('dbx_business_glossary_term' = 'Preferred Career Path');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `preferred_career_path` SET TAGS ('dbx_value_regex' = 'individual_contributor|people_management|technical_leadership|executive_leadership|cross_functional');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `professional_certifications` SET TAGS ('dbx_business_glossary_term' = 'Professional Certifications List');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `profile_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Profile Last Updated Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_review|archived');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `publications_count` SET TAGS ('dbx_business_glossary_term' = 'Publications Count');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `qpcr_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Quantitative Polymerase Chain Reaction (qPCR) Proficiency');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `qpcr_proficiency` SET TAGS ('dbx_value_regex' = 'none|basic|intermediate|advanced|expert');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `relocation_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Relocation Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `skills_gap_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Skills Gap Analysis Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `succession_planning_readiness` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Readiness');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `succession_planning_readiness` SET TAGS ('dbx_value_regex' = 'not_ready|ready_1_2_years|ready_now|emergency_ready');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `variant_calling_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Variant Calling Proficiency');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ALTER COLUMN `variant_calling_proficiency` SET TAGS ('dbx_value_regex' = 'none|basic|intermediate|advanced|expert');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_hiring_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_hiring_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_hiring_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `approved_headcount` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `clia_personnel_category` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Personnel Category');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `clia_personnel_category` SET TAGS ('dbx_value_regex' = 'director|technical_supervisor|clinical_consultant|testing_personnel|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `eeo_job_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Job Category');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `gxp_designated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Designated Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `internal_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Posting Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|phd|postdoc');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `posting_description` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Description');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `posting_location_description` SET TAGS ('dbx_business_glossary_term' = 'Posting Location Description');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `posting_title` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Title');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `primary_sourcing_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Sourcing Channel');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `remote_work_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'new_position|replacement|backfill|contractor_conversion|intern|temporary');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `total_applicants` SET TAGS ('dbx_business_glossary_term' = 'Total Applicants');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `total_hires` SET TAGS ('dbx_business_glossary_term' = 'Total Hires');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `total_interviewed` SET TAGS ('dbx_business_glossary_term' = 'Total Interviewed Candidates');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `total_offers_extended` SET TAGS ('dbx_business_glossary_term' = 'Total Offers Extended');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `total_screened` SET TAGS ('dbx_business_glossary_term' = 'Total Screened Candidates');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`requisition` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_hiring_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_hiring_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_hiring_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_referral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Employee Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_referral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_referral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|in_progress|completed|cleared|flagged');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_number` SET TAGS ('dbx_business_glossary_term' = 'Candidate Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_status` SET TAGS ('dbx_business_glossary_term' = 'Candidate Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `cover_letter_file_path` SET TAGS ('dbx_business_glossary_term' = 'Cover Letter File Path');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `current_job_title` SET TAGS ('dbx_business_glossary_term' = 'Current Job Title');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `eeo_disability_status` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Disability Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `eeo_disability_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `eeo_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Ethnicity');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `eeo_ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `eeo_gender` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Gender');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `eeo_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `eeo_veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Veteran Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `eeo_veteran_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Candidate Email Address');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate First Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `interview_stage` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Last Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `location_preference` SET TAGS ('dbx_business_glossary_term' = 'Location Preference');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Middle Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Acceptance Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Offer Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Candidate Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `resume_file_path` SET TAGS ('dbx_business_glossary_term' = 'Resume File Path');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Candidate Source Channel');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'linkedin|referral|job_board|campus|career_site|agency');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`candidate` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Plan Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `primary_absence_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `primary_absence_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `primary_absence_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `workforce_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_reason` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_status` SET TAGS ('dbx_business_glossary_term' = 'Absence Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_status` SET TAGS ('dbx_value_regex' = 'DRAFT|SUBMITTED|APPROVED|REJECTED|CANCELLED|COMPLETED');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_type_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Type Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `accrual_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Accrual Balance After Absence');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `accrual_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Accrual Balance Before Absence');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'PENDING|APPROVED|REJECTED|WITHDRAWN');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `disability_leave_flag` SET TAGS ('dbx_business_glossary_term' = 'Disability Leave Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `disability_leave_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `disability_leave_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Absence Duration in Days');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Absence Duration in Hours');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Absence End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `fmla_designated_flag` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Designated Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `fmla_hours_used` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Hours Used');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `gxp_qualification_impact_notes` SET TAGS ('dbx_business_glossary_term' = 'Good Practice Regulations (GxP) Qualification Impact Notes');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `gxp_requalification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice Regulations (GxP) Requalification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `intermittent_leave_flag` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_received_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_received_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certification_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Absence Notes');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Paid Absence Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `payroll_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'ORACLE_HCM|MANUAL_ENTRY|TIMEKEEPING|SELF_SERVICE');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `workers_compensation_flag` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `workers_compensation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_record` ALTER COLUMN `workers_compensation_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `tertiary_headcount_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `tertiary_headcount_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `tertiary_headcount_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `actual_filled_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Filled Headcount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_headcount` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budget_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budget_allocation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `clia_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Certified Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `contractor_fte_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Contractor Full-Time Equivalent (FTE) Equivalent');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|intern|temporary');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `gxp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice Regulations (GxP) Regulated Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `open_requisition_count` SET TAGS ('dbx_business_glossary_term' = 'Open Requisition Count');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|closed|superseded');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planned_headcount` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `rd_capitalization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Capitalization Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `variance_to_plan` SET TAGS ('dbx_business_glossary_term' = 'Variance to Plan');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Final Approver Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'New Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `primary_lifecycle_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `primary_lifecycle_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `primary_lifecycle_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Job Profile Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Organization Unit Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Position Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `prior_location_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `quaternary_lifecycle_initiating_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Manager Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `quaternary_lifecycle_initiating_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `quaternary_lifecycle_initiating_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `quinary_lifecycle_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `quinary_lifecycle_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `quinary_lifecycle_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `tertiary_lifecycle_new_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'New Manager Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `tertiary_lifecycle_new_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `tertiary_lifecycle_new_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `approval_chain` SET TAGS ('dbx_business_glossary_term' = 'Approval Chain');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `event_comments` SET TAGS ('dbx_business_glossary_term' = 'Event Comments');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `event_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Event Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `event_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `event_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Description');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `new_clia_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'New Clinical Laboratory Improvement Amendments (CLIA) Qualified Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `new_employment_type` SET TAGS ('dbx_business_glossary_term' = 'New Employment Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `new_employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `new_fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'New Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `new_gxp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'New Good Practice (GxP) Critical Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `prior_clia_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Clinical Laboratory Improvement Amendments (CLIA) Qualified Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `prior_employment_type` SET TAGS ('dbx_business_glossary_term' = 'Prior Employment Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `prior_employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|intern');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `prior_fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Prior Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `prior_gxp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Good Practice (GxP) Critical Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Requalification Due Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Event Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `sox_control_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Event Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `system_access_change_required_flag` SET TAGS ('dbx_business_glossary_term' = 'System Access Change Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lifecycle_event` ALTER COLUMN `training_requalification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Requalification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` SET TAGS ('dbx_subdomain' = 'training_compliance');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `lab_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Qualification Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `quality_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Rule Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `assay_type` SET TAGS ('dbx_business_glossary_term' = 'Assay Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `assessor_title` SET TAGS ('dbx_business_glossary_term' = 'Assessor Job Title');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `biosafety_level` SET TAGS ('dbx_business_glossary_term' = 'Biosafety Level (BSL)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `biosafety_level` SET TAGS ('dbx_value_regex' = 'BSL-1|BSL-2|BSL-3|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `cap_accreditation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'College of American Pathologists (CAP) Accreditation Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `cleanroom_class` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Classification Class');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `cleanroom_class` SET TAGS ('dbx_value_regex' = 'ISO_5|ISO_6|ISO_7|ISO_8|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `clia_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `competency_assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Competency Assessment Method');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `competency_assessment_method` SET TAGS ('dbx_value_regex' = 'practical_demonstration|written_exam|observation|simulation|combination');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `gxp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Critical Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `independent_runs_required` SET TAGS ('dbx_business_glossary_term' = 'Independent Runs Required Count');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `instrument_model` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `iso_13485_required_flag` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 13485 Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `lab_scope` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Scope');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `last_requalification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Requalification Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `next_requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Requalification Due Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `qualification_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Certificate Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `qualification_code` SET TAGS ('dbx_business_glossary_term' = 'Qualification Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Name');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_requalification|revoked|in_progress');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'instrument_operator|lab_technique|biosafety_authorization|cleanroom_qualification|assay_specific|equipment_maintenance');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `requalification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Requalification Frequency in Months');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `requalification_status` SET TAGS ('dbx_business_glossary_term' = 'Requalification Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `requalification_status` SET TAGS ('dbx_value_regex' = 'not_required|upcoming|overdue|in_progress|completed');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Revocation Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Qualification Revocation Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `sop_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Version');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `supervised_runs_completed` SET TAGS ('dbx_business_glossary_term' = 'Supervised Runs Completed Count');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Suspension End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Qualification Suspension Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Suspension Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ALTER COLUMN `training_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Completed');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` SET TAGS ('dbx_subdomain' = 'compensation_management');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payroll_result_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Result Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `workforce_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `dental_insurance_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Dental Insurance Deduction Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `federal_tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Withheld Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `fsa_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Flexible Spending Account (FSA) Contribution Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `health_insurance_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Deduction Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `health_insurance_deduction_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `health_insurance_deduction_amount` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `hsa_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Contribution Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `local_tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Tax Withheld Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `medicare_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `other_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|wire_transfer');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payroll_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payroll Frequency');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payroll_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|validated|paid|reversed|voided');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `pto_hours_used` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Hours Used');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `rd_capitalization_amount` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Capitalization Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `rd_capitalization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Capitalization Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `regular_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Regular Pay Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Retirement Contribution Amount (401k)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `state_tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'State Tax Withheld Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ALTER COLUMN `vision_insurance_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Vision Insurance Deduction Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `workforce_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `adjusted_time_entry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|pending_review');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `capitalization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Percentage');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `clia_qualified_activity_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Qualified Activity Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Comments');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `gl_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posted Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `gmp_production_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Production Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `gxp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Critical Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `rd_capitalization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Capitalization Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_type_code` SET TAGS ('dbx_business_glossary_term' = 'Time Type Code');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_type_code` SET TAGS ('dbx_value_regex' = 'regular|overtime|double_time|on_call|standby|shift_differential');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` SET TAGS ('dbx_subdomain' = 'training_compliance');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` SET TAGS ('dbx_association_edges' = 'workforce.employee,data.genomic_access_control');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `genomic_access_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Grant ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Grant - Employee Id');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Grant - Genomic Access Control Id');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `access_tier` SET TAGS ('dbx_business_glossary_term' = 'Access Tier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Access Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `data_use_agreement_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement Signed Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `data_use_limitation_codes` SET TAGS ('dbx_business_glossary_term' = 'Data Use Limitation Codes');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `grant_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Access Grant Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `grant_start_date` SET TAGS ('dbx_business_glossary_term' = 'Access Grant Start Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` SET TAGS ('dbx_subdomain' = 'training_compliance');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` SET TAGS ('dbx_association_edges' = 'workforce.employee,reference.genome_assembly');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `genome_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Qualification - Genome Qualification Id');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Qualification - Employee Id');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Qualification - Genome Assembly Id');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `certifying_authority` SET TAGS ('dbx_business_glossary_term' = 'Certifying Authority');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'compensation_management');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_plan` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_plan` ALTER COLUMN `absence_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Plan Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`absence_plan` ALTER COLUMN `superseded_absence_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `parent_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`work_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`work_schedule` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `work_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `superseded_work_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`work_schedule` ALTER COLUMN `schedule_owner` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`grade` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`grade` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`grade` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`grade` ALTER COLUMN `parent_grade_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`grade` ALTER COLUMN `max_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`grade` ALTER COLUMN `min_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`bargaining_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`bargaining_unit` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`bargaining_unit` ALTER COLUMN `bargaining_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`bargaining_unit` ALTER COLUMN `parent_bargaining_unit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'compensation_management');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `coinsurance_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `copay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `employee_contribution_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `out_of_pocket_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`training_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`training_item` SET TAGS ('dbx_subdomain' = 'training_compliance');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`training_item` ALTER COLUMN `training_item_id` SET TAGS ('dbx_business_glossary_term' = 'Training Item Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`training_item` ALTER COLUMN `prerequisite_training_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'compensation_management');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_run` ALTER COLUMN `reversal_payroll_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`review_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`review_cycle` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`review_cycle` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`review_cycle` ALTER COLUMN `previous_review_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `union_id` SET TAGS ('dbx_business_glossary_term' = 'Union Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `parent_union_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `union_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `union_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`union` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` ALTER COLUMN `collective_bargaining_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` ALTER COLUMN `superseded_collective_bargaining_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` ALTER COLUMN `signatory_employer_rep_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` ALTER COLUMN `signatory_employer_rep_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` ALTER COLUMN `signatory_employer_rep_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` ALTER COLUMN `signatory_employer_rep_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` ALTER COLUMN `signatory_union_rep_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` ALTER COLUMN `signatory_union_rep_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` ALTER COLUMN `signatory_union_rep_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`collective_bargaining_agreement` ALTER COLUMN `signatory_union_rep_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_cycle` SET TAGS ('dbx_subdomain' = 'compensation_management');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_cycle` ALTER COLUMN `payroll_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Cycle Identifier');
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_cycle` ALTER COLUMN `previous_payroll_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
